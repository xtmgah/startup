options(startup.dryrun = TRUE)

message("*** api() ...")

message("*** api()")
api <- startup:::api()
stopifnot(is.list(api), length(api) > 0)

message("*** renviron_d()")
res <- startup::renviron_d()
stopifnot(all.equal(res, api))

message("*** rprofile_d()")
res <- startup::rprofile_d()
stopifnot(all.equal(res, api))

res <- startup::rprofile_d(all = TRUE)

message("*** startup(unload = FALSE)")
res <- startup::startup(unload = FALSE)
stopifnot(all.equal(res, api))

message("*** startup(debug = TRUE)")
## Fake some settings / calls to cover more code
options(startup.debug.commandArgs = commandArgs()[1])
save.image(file = ".RData")
res <- startup::startup(debug = TRUE)
str(res)
stopifnot(all.equal(res, api))
file.remove(".RData")
options(startup.debug.commandArgs = NULL)

options(startup.dryrun = FALSE)

message("*** api() ... DONE")

rm(list = c("api", "res"))
