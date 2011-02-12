From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH resend] configure: use AC_LANG_PROGRAM consistently
Date: Sat, 12 Feb 2011 17:35:58 -0600
Message-ID: <20110212233558.GA13660@elie>
References: <20110102060044.GJ19818@gmx.de>
 <20110102075953.GB8937@burratino>
 <20110102094730.GA10365@gmx.de>
 <20110102100012.GA12284@burratino>
 <20110102102455.GD10365@gmx.de>
 <20110201193927.GA1634@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 00:36:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoP0e-0007MO-Mf
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 00:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab1BLXgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 18:36:08 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35897 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab1BLXgG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 18:36:06 -0500
Received: by yxt3 with SMTP id 3so1587484yxt.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 15:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=D8utc4GuGI/dWXnl0wAvnuDPifiWHMK33nDmNxfAC4g=;
        b=hK5ZFl0ACUVCIGS+BqsGBNwNSHuAFtqvYkOVCIe0kO4WaULx5LhBu4xTaa8nW9vycm
         x852WCBBMvVBngUHOQA3ki6kOGULBTRvpGRUxGB7IzYOlwQTIyTq7AARxDz5FBPwC2xh
         HOOGTWQkPmwQ7X1XuzwPgtAqB2cjl/XIMuwOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NPqXSdogLdRE4bRBivJUd178toXAfqy3NszeGJL5DjvsLQegTvcsNbJvmEb6LJ8gy2
         HajTsl8mikswUBzcgrA2IIVUTxr4BE1rksUpyIV/dv/k4FLG+MSssG0Ds8l+bQGiPMMi
         //rxsysXo5G01kR7ep9Pc6uCP9XoiDzQzMHVE=
Received: by 10.150.189.13 with SMTP id m13mr2572766ybf.95.1297553764615;
        Sat, 12 Feb 2011 15:36:04 -0800 (PST)
Received: from elie (adsl-69-209-71-45.dsl.chcgil.ameritech.net [69.209.71.45])
        by mx.google.com with ESMTPS id v4sm700505ybe.17.2011.02.12.15.36.02
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 15:36:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110201193927.GA1634@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166632>

From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Date: Sun, 2 Jan 2011 11:24:55 +0100

Avoid warnings from Autoconf 2.68 about missing use of AC_LANG_PROGRAM
and friends.

Quoting autoconf-2.68/NEWS:

  ** The macros AC_PREPROC_IFELSE, AC_COMPILE_IFELSE, AC_LINK_IFELSE, and
     AC_RUN_IFELSE now warn if the first argument failed to use
     AC_LANG_SOURCE or AC_LANG_PROGRAM to generate the conftest file
     contents.  A new macro AC_LANG_DEFINES_PROVIDED exists if you have
     a compelling reason why you cannot use AC_LANG_SOURCE but must
     avoid the warning.

The underlying reason for that change is that AC_LANG_{SOURCE,PROGRAM}
take care to supply the previously computed set of #defines (and
include standard headers if so desired) for preprocessed languages
like C and C++.

In some cases, AC_LANG_PROGRAM is already used but not sufficiently
m4-quoted, so we just need to add another set of [quotes] to prevent
the autoconf warning from being triggered bogusly.  Quoting all
arguments (except when calling special macros that need to be expanded
before recursion) is better style, anyway.  These and more rules are
described in detail in 'info Autoconf "Programming in M4"'.

No change in the resulting config.mak.autogen after running
./configure intended.

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Ralf Wildenhues wrote:
> * Ralf Wildenhues wrote on Sun, Jan 02, 2011 at 11:24:55AM CET:

>> This avoids warnings from Autoconf 2.68 about missing use of
>> AC_LANG_PROGRAM and friends.
>
> I'd like to ping this patch:
> http://thread.gmane.org/gmane.comp.version-control.git/164409/focus=164416
>
> which IIUC addresses all previous comments in the thread and was
> otherwise noncontroversial.  If there is anything else left to do,
> I'd be happy to hear about it.

The point of using AC_LANG_PROGRAM is that some magic (like #define
_GNU_SOURCE) could be added before the code used to perform a feature
test.  And that is good --- we have similar magic in
git-compat-util.h, for similar reasons.

The worrisome aspect is that autoconf's magic and git's magic are
unlikely to work the same way, making the detection inaccurate.

That said, at least this patch doesn't make it worse.  Consistency
is nice.  And sometimes squashing a warning is worthwhile just for
the sake of squashing a warning, so other warnings don't get lost
in the noise.

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
1.7.4.1
