From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Consistent use of AC_LANG_PROGRAM in configure.ac and
 aclocal.m4.
Date: Sun, 2 Jan 2011 07:00:44 +0100
Organization: Institute for Numerical Simulation, University of Bonn
Message-ID: <20110102060044.GJ19818@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 02 07:07:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZH62-00061P-Gq
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 07:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781Ab1ABGAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 01:00:48 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:39488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750695Ab1ABGAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 01:00:46 -0500
Received: (qmail invoked by alias); 02 Jan 2011 06:00:44 -0000
Received: from xdsl-78-35-55-111.netcologne.de (EHLO localhost.localdomain) [78.35.55.111]
  by mail.gmx.net (mp025) with SMTP; 02 Jan 2011 07:00:44 +0100
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX18l4jtT234lxhAjwxuYrg4jS3bJxU6s72XNfllRQq
	00QSZx21nMJd6u
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1PZGzk-0002Hq-Ik
	for git@vger.kernel.org; Sun, 02 Jan 2011 07:00:44 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2010-08-04)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164409>

This avoids warnings from Autoconf 2.68 about missing use of
AC_LANG_PROGRAM and friends.

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

The patch should not cause any semantic changes in the generated
configure script.

Thanks,
Ralf

 aclocal.m4   |    4 ++--
 configure.ac |   56 +++++++++++++++++++-------------------------------------
 2 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/aclocal.m4 b/aclocal.m4
index d399de2..f11bc7e 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -13,7 +13,7 @@ AC_DEFUN([TYPE_SOCKLEN_T],
          git_cv_socklen_t_equiv=
          for arg2 in "struct sockaddr" void; do
             for t in int size_t unsigned long "unsigned long"; do
-               AC_TRY_COMPILE([
+               AC_COMPILE_IFELSE([AC_LANG_PROGRAM([
                   #include <sys/types.h>
                   #include <sys/socket.h>
 
@@ -21,7 +21,7 @@ AC_DEFUN([TYPE_SOCKLEN_T],
                ],[
                   $t len;
                   getpeername(0,0,&len);
-               ],[
+               ])],[
                   git_cv_socklen_t_equiv="$t"
                   break 2
                ])
diff --git a/configure.ac b/configure.ac
index 5792425..20039c5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -345,7 +345,7 @@ esac
 AC_CACHE_CHECK([if linker supports -R], git_cv_ld_dashr, [
    SAVE_LDFLAGS="${LDFLAGS}"
    LDFLAGS="${SAVE_LDFLAGS} -R /"
-   AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_dashr=yes], [git_cv_ld_dashr=no])
+   AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_dashr=yes], [git_cv_ld_dashr=no])
    LDFLAGS="${SAVE_LDFLAGS}"
 ])
 if test "$git_cv_ld_dashr" = "yes"; then
@@ -354,7 +354,7 @@ else
    AC_CACHE_CHECK([if linker supports -Wl,-rpath,], git_cv_ld_wl_rpath, [
       SAVE_LDFLAGS="${LDFLAGS}"
       LDFLAGS="${SAVE_LDFLAGS} -Wl,-rpath,/"
-      AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_wl_rpath=yes], [git_cv_ld_wl_rpath=no])
+      AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_wl_rpath=yes], [git_cv_ld_wl_rpath=no])
       LDFLAGS="${SAVE_LDFLAGS}"
    ])
    if test "$git_cv_ld_wl_rpath" = "yes"; then
@@ -363,7 +363,7 @@ else
       AC_CACHE_CHECK([if linker supports -rpath], git_cv_ld_rpath, [
          SAVE_LDFLAGS="${LDFLAGS}"
          LDFLAGS="${SAVE_LDFLAGS} -rpath /"
-         AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_rpath=yes], [git_cv_ld_rpath=no])
+         AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_rpath=yes], [git_cv_ld_rpath=no])
          LDFLAGS="${SAVE_LDFLAGS}"
       ])
       if test "$git_cv_ld_rpath" = "yes"; then
@@ -472,15 +472,9 @@ if test -z "$NO_ICONV"; then
 
 GIT_STASH_FLAGS($ICONVDIR)
 
-AC_DEFUN([ICONVTEST_SRC], [
-#include <iconv.h>
-
-int main(void)
-{
-	iconv_open("", "");
-	return 0;
-}
-])
+AC_DEFUN([ICONVTEST_SRC],
+[AC_LANG_PROGRAM([#include <iconv.h>],
+ [iconv_open("", "");])])
 
 if test -n "$ICONVDIR"; then
    lib_order="-liconv -lc"
@@ -500,7 +494,7 @@ for l in $lib_order; do
     old_LIBS="$LIBS"
     LIBS="$LIBS $l"
     AC_MSG_CHECKING([for iconv in $l])
-    AC_LINK_IFELSE(ICONVTEST_SRC,
+    AC_LINK_IFELSE([ICONVTEST_SRC],
 	[AC_MSG_RESULT([yes])
 	NO_ICONV=
 	break],
@@ -528,18 +522,12 @@ fi
 GIT_STASH_FLAGS($ZLIB_PATH)
 
 AC_DEFUN([ZLIBTEST_SRC], [
-#include <zlib.h>
-
-int main(void)
-{
-	deflateBound(0, 0);
-	return 0;
-}
-])
+AC_LANG_PROGRAM([#include <zlib.h>],
+ [deflateBound(0, 0);])])
 AC_MSG_CHECKING([for deflateBound in -lz])
 old_LIBS="$LIBS"
 LIBS="$LIBS -lz"
-AC_LINK_IFELSE(ZLIBTEST_SRC,
+AC_LINK_IFELSE([ZLIBTEST_SRC],
 	[AC_MSG_RESULT([yes])],
 	[AC_MSG_RESULT([no])
 	NO_DEFLATE_BOUND=yes])
@@ -631,23 +619,19 @@ AC_SUBST(NO_INTTYPES_H)
 #
 # Define OLD_ICONV if your library has an old iconv(), where the second
 # (input buffer pointer) parameter is declared with type (const char **).
-AC_DEFUN([OLDICONVTEST_SRC], [[
+AC_DEFUN([OLDICONVTEST_SRC], [
+AC_LANG_PROGRAM([[
 #include <iconv.h>
 
 extern size_t iconv(iconv_t cd,
 		    char **inbuf, size_t *inbytesleft,
 		    char **outbuf, size_t *outbytesleft);
-
-int main(void)
-{
-	return 0;
-}
-]])
+]], [])])
 
 GIT_STASH_FLAGS($ICONVDIR)
 
 AC_MSG_CHECKING([for old iconv()])
-AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
+AC_COMPILE_IFELSE([OLDICONVTEST_SRC],
 	[AC_MSG_RESULT([no])],
 	[AC_MSG_RESULT([yes])
 	OLD_ICONV=UnfortunatelyYes])
@@ -931,18 +915,16 @@ AC_SUBST(NO_INITGROUPS)
 #
 # Define PTHREAD_LIBS to the linker flag used for Pthread support.
 AC_DEFUN([PTHREADTEST_SRC], [
+AC_LANG_PROGRAM([[
 #include <pthread.h>
-
-int main(void)
-{
+]], [[
 	pthread_mutex_t test_mutex;
 	int retcode = 0;
 	retcode |= pthread_mutex_init(&test_mutex,(void *)0);
 	retcode |= pthread_mutex_lock(&test_mutex);
 	retcode |= pthread_mutex_unlock(&test_mutex);
 	return retcode;
-}
-])
+]])])
 
 dnl AC_LANG_CONFTEST([AC_LANG_PROGRAM(
 dnl   [[#include <pthread.h>]],
@@ -962,7 +944,7 @@ elif test -z "$PTHREAD_CFLAGS"; then
      old_CFLAGS="$CFLAGS"
      CFLAGS="$opt $CFLAGS"
      AC_MSG_CHECKING([Checking for POSIX Threads with '$opt'])
-     AC_LINK_IFELSE(PTHREADTEST_SRC,
+     AC_LINK_IFELSE([PTHREADTEST_SRC],
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
 		PTHREAD_LIBS="$opt"
@@ -982,7 +964,7 @@ else
   old_CFLAGS="$CFLAGS"
   CFLAGS="$PTHREAD_CFLAGS $CFLAGS"
   AC_MSG_CHECKING([Checking for POSIX Threads with '$PTHREAD_CFLAGS'])
-  AC_LINK_IFELSE(PTHREADTEST_SRC,
+  AC_LINK_IFELSE([PTHREADTEST_SRC],
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
 		PTHREAD_LIBS="$PTHREAD_CFLAGS"
-- 
1.7.4.rc0
