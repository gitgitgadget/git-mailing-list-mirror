From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 2/2] build: don't duplicate substitution of make variables
Date: Tue, 11 Sep 2012 17:45:30 +0200
Message-ID: <1c54b744c0ec6987f7987a41853ab0ae00513d03.1347378210.git.stefano.lattarini@gmail.com>
References: <1be62f9a7bbe728e6422e668d982ddf313d016eb.1347378209.git.stefano.lattarini@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 17:46:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBSf4-0005Tn-Ai
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 17:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759157Ab2IKPpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 11:45:50 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59191 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821Ab2IKPpt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 11:45:49 -0400
Received: by mail-ee0-f46.google.com with SMTP id c1so541562eek.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=trGyej/6HvZoHlqlfI2yhdas1q5PNgYY/orGbABXvmA=;
        b=y0WX8Nl3/xweWSQAlAhbGu5vjZHvJrtvKmiZaJZbfkOHPW072B7n2cJ72HWQjqFOv+
         F8NwTBiqE7xL3cnj71iN9tY/QXnMLbZX3u4sfjrwjWZTapjzKSGbmYCVBgX9mO969z0r
         VlCi1iRHuKaBvoSbEJZEAVuI7lUpPEfXFCaLyvKmkYDrEYBZc9AhA+849t7RJXHFfgqJ
         mMpyeReS/UUM4aURuIaT6WTgnGf5JDGp//+E6rOeZvuTMCbljy4a5wFQWixj8IZ3kq5P
         geEHozf9mQm8kOuaHArrZnpc40kB80jI60s9iMKXDZD4SXnQrgnpH2qCvooSPp+0uI2M
         eH4A==
Received: by 10.204.130.156 with SMTP id t28mr5095084bks.33.1347378347934;
        Tue, 11 Sep 2012 08:45:47 -0700 (PDT)
Received: from localhost.localdomain (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id hg13sm10046535bkc.7.2012.09.11.08.45.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Sep 2012 08:45:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.317.g1c54b74
In-Reply-To: <1be62f9a7bbe728e6422e668d982ddf313d016eb.1347378209.git.stefano.lattarini@gmail.com>
In-Reply-To: <1be62f9a7bbe728e6422e668d982ddf313d016eb.1347378209.git.stefano.lattarini@gmail.com>
References: <1be62f9a7bbe728e6422e668d982ddf313d016eb.1347378209.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205241>

Thanks to our 'GIT_CONF_SUBST' layer in configure.ac, a make variable 'VAR'
can be defined to a value 'VAL' at ./configure runtime in our build system
simply by using "GIT_CONF_SUBST([VAR], [VAL])" in configure.ac, rather than
having both to call "AC_SUBST([VAR], [VAL])" in configure.ac and adding the
'VAR = @VAR@' definition in config.mak.in.  Less duplication, less margin
for error, less possibility of confusion.

While at it, fix some formatting issues in configure.ac that unnecessarily
obscured the code flow.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 config.mak.in |  49 --------------------
 configure.ac  | 144 +++++++++++++++++++++++++++++++---------------------------
 2 files changed, 76 insertions(+), 117 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 802d342..69d4838 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -5,12 +5,10 @@ CC = @CC@
 CFLAGS = @CFLAGS@
 CPPFLAGS = @CPPFLAGS@
 LDFLAGS = @LDFLAGS@
-CC_LD_DYNPATH = @CC_LD_DYNPATH@
 AR = @AR@
 TAR = @TAR@
 DIFF = @DIFF@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
-TCLTK_PATH = @TCLTK_PATH@
 
 prefix = @prefix@
 exec_prefix = @exec_prefix@
@@ -27,50 +25,3 @@ VPATH = @srcdir@
 
 export exec_prefix mandir
 export srcdir VPATH
-
-NEEDS_SSL_WITH_CRYPTO=@NEEDS_SSL_WITH_CRYPTO@
-NO_OPENSSL=@NO_OPENSSL@
-NO_CURL=@NO_CURL@
-NO_EXPAT=@NO_EXPAT@
-NO_LIBGEN_H=@NO_LIBGEN_H@
-HAVE_PATHS_H=@HAVE_PATHS_H@
-HAVE_LIBCHARSET_H=@HAVE_LIBCHARSET_H@
-NO_GETTEXT=@NO_GETTEXT@
-LIBC_CONTAINS_LIBINTL=@LIBC_CONTAINS_LIBINTL@
-NEEDS_LIBICONV=@NEEDS_LIBICONV@
-NEEDS_SOCKET=@NEEDS_SOCKET@
-NEEDS_RESOLV=@NEEDS_RESOLV@
-NEEDS_LIBGEN=@NEEDS_LIBGEN@
-NO_SYS_SELECT_H=@NO_SYS_SELECT_H@
-NO_D_INO_IN_DIRENT=@NO_D_INO_IN_DIRENT@
-NO_D_TYPE_IN_DIRENT=@NO_D_TYPE_IN_DIRENT@
-NO_SOCKADDR_STORAGE=@NO_SOCKADDR_STORAGE@
-NO_IPV6=@NO_IPV6@
-NO_HSTRERROR=@NO_HSTRERROR@
-NO_STRCASESTR=@NO_STRCASESTR@
-NO_STRTOK_R=@NO_STRTOK_R@
-NO_FNMATCH=@NO_FNMATCH@
-NO_FNMATCH_CASEFOLD=@NO_FNMATCH_CASEFOLD@
-NO_MEMMEM=@NO_MEMMEM@
-NO_STRLCPY=@NO_STRLCPY@
-NO_UINTMAX_T=@NO_UINTMAX_T@
-NO_STRTOUMAX=@NO_STRTOUMAX@
-NO_SETENV=@NO_SETENV@
-NO_UNSETENV=@NO_UNSETENV@
-NO_MKDTEMP=@NO_MKDTEMP@
-NO_MKSTEMPS=@NO_MKSTEMPS@
-NO_INET_NTOP=@NO_INET_NTOP@
-NO_INET_PTON=@NO_INET_PTON@
-NO_ICONV=@NO_ICONV@
-OLD_ICONV=@OLD_ICONV@
-NO_REGEX=@NO_REGEX@
-USE_LIBPCRE=@USE_LIBPCRE@
-NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
-INLINE=@INLINE@
-SOCKLEN_T=@SOCKLEN_T@
-FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
-SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
-NO_PTHREADS=@NO_PTHREADS@
-PTHREAD_CFLAGS=@PTHREAD_CFLAGS@
-PTHREAD_LIBS=@PTHREAD_LIBS@
-CHARSET_LIB=@CHARSET_LIB@
diff --git a/configure.ac b/configure.ac
index 450bbe7..da1f41f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -267,6 +267,8 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
 	USE_LIBPCRE=YesPlease
 	LIBPCREDIR=$withval
 	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
+        dnl USE_LIBPCRE can still be modified below, so don't substitute
+        dnl it yet.
 	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
 #
@@ -387,9 +389,10 @@ AC_MSG_NOTICE([CHECKS for programs])
 AC_PROG_CC([cc gcc])
 AC_C_INLINE
 case $ac_cv_c_inline in
-  inline | yes | no)	;;
-  *)			AC_SUBST([INLINE], [$ac_cv_c_inline]) ;;
+  inline | yes | no) INLINE='';;
+  *)                 INLINE=$ac_cv_c_inline ;;
 esac
+GIT_CONF_SUBST([INLINE])
 
 # which switch to pass runtime path to dynamic libraries to the linker
 AC_CACHE_CHECK([if linker supports -R], git_cv_ld_dashr, [
@@ -399,7 +402,7 @@ AC_CACHE_CHECK([if linker supports -R], git_cv_ld_dashr, [
    LDFLAGS="${SAVE_LDFLAGS}"
 ])
 if test "$git_cv_ld_dashr" = "yes"; then
-   AC_SUBST(CC_LD_DYNPATH, [-R])
+   CC_LD_DYNPATH=-R
 else
    AC_CACHE_CHECK([if linker supports -Wl,-rpath,], git_cv_ld_wl_rpath, [
       SAVE_LDFLAGS="${LDFLAGS}"
@@ -408,7 +411,7 @@ else
       LDFLAGS="${SAVE_LDFLAGS}"
    ])
    if test "$git_cv_ld_wl_rpath" = "yes"; then
-      AC_SUBST(CC_LD_DYNPATH, [-Wl,-rpath,])
+      CC_LD_DYNPATH=-Wl,-rpath
    else
       AC_CACHE_CHECK([if linker supports -rpath], git_cv_ld_rpath, [
          SAVE_LDFLAGS="${LDFLAGS}"
@@ -417,32 +420,35 @@ else
          LDFLAGS="${SAVE_LDFLAGS}"
       ])
       if test "$git_cv_ld_rpath" = "yes"; then
-         AC_SUBST(CC_LD_DYNPATH, [-rpath])
+         CC_LD_DYNPATH=-rpath
       else
+         CC_LD_DYNPATH=
          AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
       fi
    fi
 fi
+GIT_CONF_SUBST([CC_LD_DYNPATH])
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOLS(AR, [gar ar], :)
 AC_CHECK_PROGS(TAR, [gtar tar])
 AC_CHECK_PROGS(DIFF, [gnudiff gdiff diff])
 # TCLTK_PATH will be set to some value if we want Tcl/Tk
 # or will be empty otherwise.
-if test -z "$NO_TCLTK"; then
+if test -n "$NO_TCLTK"; then
+  TCLTK_PATH=
+else
   if test "$with_tcltk" = ""; then
   # No Tcl/Tk switches given. Do not check for Tcl/Tk, use bare 'wish'.
     TCLTK_PATH=wish
-    AC_SUBST(TCLTK_PATH)
   elif test "$with_tcltk" = "yes"; then
   # Tcl/Tk check requested.
     AC_CHECK_PROGS(TCLTK_PATH, [wish], )
   else
     AC_MSG_RESULT([Using Tcl/Tk interpreter $with_tcltk])
     TCLTK_PATH="$with_tcltk"
-    AC_SUBST(TCLTK_PATH)
   fi
 fi
+GIT_CONF_SUBST([TCLTK_PATH])
 AC_CHECK_PROGS(ASCIIDOC, [asciidoc])
 if test -n "$ASCIIDOC"; then
 	AC_MSG_CHECKING([for asciidoc version])
@@ -469,13 +475,13 @@ GIT_STASH_FLAGS($OPENSSLDIR)
 AC_CHECK_LIB([crypto], [SHA1_Init],
 [NEEDS_SSL_WITH_CRYPTO=],
 [AC_CHECK_LIB([ssl], [SHA1_Init],
- [NEEDS_SSL_WITH_CRYPTO=YesPlease],
- [NEEDS_SSL_WITH_CRYPTO= NO_OPENSSL=YesPlease])])
+ [NEEDS_SSL_WITH_CRYPTO=YesPlease NO_OPENSSL=],
+ [NEEDS_SSL_WITH_CRYPTO=          NO_OPENSSL=YesPlease])])
 
 GIT_UNSTASH_FLAGS($OPENSSLDIR)
 
-AC_SUBST(NEEDS_SSL_WITH_CRYPTO)
-AC_SUBST(NO_OPENSSL)
+GIT_CONF_SUBST([NEEDS_SSL_WITH_CRYPTO])
+GIT_CONF_SUBST([NO_OPENSSL])
 
 #
 # Define USE_LIBPCRE if you have and want to use libpcre. git-grep will be
@@ -492,7 +498,7 @@ AC_CHECK_LIB([pcre], [pcre_version],
 
 GIT_UNSTASH_FLAGS($LIBPCREDIR)
 
-AC_SUBST(USE_LIBPCRE)
+GIT_CONF_SUBST([USE_LIBPCRE])
 
 fi
 
@@ -509,7 +515,7 @@ AC_CHECK_LIB([curl], [curl_global_init],
 
 GIT_UNSTASH_FLAGS($CURLDIR)
 
-AC_SUBST(NO_CURL)
+GIT_CONF_SUBST([NO_CURL])
 
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
@@ -523,7 +529,7 @@ AC_CHECK_LIB([expat], [XML_ParserCreate],
 
 GIT_UNSTASH_FLAGS($EXPATDIR)
 
-AC_SUBST(NO_EXPAT)
+GIT_CONF_SUBST([NO_EXPAT])
 
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin and
@@ -569,8 +575,8 @@ LIBS="$old_LIBS"
 
 GIT_UNSTASH_FLAGS($ICONVDIR)
 
-AC_SUBST(NEEDS_LIBICONV)
-AC_SUBST(NO_ICONV)
+GIT_CONF_SUBST([NEEDS_LIBICONV])
+GIT_CONF_SUBST([NO_ICONV])
 
 if test -n "$NO_ICONV"; then
     NEEDS_LIBICONV=
@@ -597,7 +603,7 @@ LIBS="$old_LIBS"
 
 GIT_UNSTASH_FLAGS($ZLIB_PATH)
 
-AC_SUBST(NO_DEFLATE_BOUND)
+GIT_CONF_SUBST([NO_DEFLATE_BOUND])
 
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
@@ -605,7 +611,7 @@ AC_SUBST(NO_DEFLATE_BOUND)
 AC_CHECK_LIB([c], [socket],
 [NEEDS_SOCKET=],
 [NEEDS_SOCKET=YesPlease])
-AC_SUBST(NEEDS_SOCKET)
+GIT_CONF_SUBST([NEEDS_SOCKET])
 test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
 
 #
@@ -613,40 +619,43 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
 # libresolv provides some of the functions we would normally get
 # from libc.
 NEEDS_RESOLV=
-AC_SUBST(NEEDS_RESOLV)
 #
 # Define NO_INET_NTOP if linking with -lresolv is not enough.
 # Solaris 2.7 in particular hos inet_ntop in -lresolv.
 NO_INET_NTOP=
-AC_SUBST(NO_INET_NTOP)
 AC_CHECK_FUNC([inet_ntop],
-	[],
+    [],
     [AC_CHECK_LIB([resolv], [inet_ntop],
-	    [NEEDS_RESOLV=YesPlease],
+	[NEEDS_RESOLV=YesPlease],
 	[NO_INET_NTOP=YesPlease])
 ])
+GIT_CONF_SUBST([NO_INET_NTOP])
 #
 # Define NO_INET_PTON if linking with -lresolv is not enough.
 # Solaris 2.7 in particular hos inet_pton in -lresolv.
 NO_INET_PTON=
-AC_SUBST(NO_INET_PTON)
 AC_CHECK_FUNC([inet_pton],
-	[],
+    [],
     [AC_CHECK_LIB([resolv], [inet_pton],
-	    [NEEDS_RESOLV=YesPlease],
+	[NEEDS_RESOLV=YesPlease],
 	[NO_INET_PTON=YesPlease])
 ])
+GIT_CONF_SUBST([NO_INET_PTON])
 #
 # Define NO_HSTRERROR if linking with -lresolv is not enough.
 # Solaris 2.6 in particular has no hstrerror, even in -lresolv.
 NO_HSTRERROR=
 AC_CHECK_FUNC([hstrerror],
-	[],
+    [],
     [AC_CHECK_LIB([resolv], [hstrerror],
-	    [NEEDS_RESOLV=YesPlease],
+	[NEEDS_RESOLV=YesPlease],
 	[NO_HSTRERROR=YesPlease])
 ])
-AC_SUBST(NO_HSTRERROR)
+GIT_CONF_SUBST([NO_HSTRERROR])
+
+dnl This must go after all the possible places for its initialization,
+dnl in the AC_CHECK_FUNC invocations above.
+GIT_CONF_SUBST([NEEDS_RESOLV])
 #
 # If any of the above tests determined that -lresolv is needed at
 # build-time, also set it here for remaining configure-time checks.
@@ -655,13 +664,13 @@ test -n "$NEEDS_RESOLV" && LIBS="$LIBS -lresolv"
 AC_CHECK_LIB([c], [basename],
 [NEEDS_LIBGEN=],
 [NEEDS_LIBGEN=YesPlease])
-AC_SUBST(NEEDS_LIBGEN)
+GIT_CONF_SUBST([NEEDS_LIBGEN])
 test -n "$NEEDS_LIBGEN" && LIBS="$LIBS -lgen"
 
 AC_CHECK_LIB([c], [gettext],
 [LIBC_CONTAINS_LIBINTL=YesPlease],
 [LIBC_CONTAINS_LIBINTL=])
-AC_SUBST(LIBC_CONTAINS_LIBINTL)
+GIT_CONF_SUBST([LIBC_CONTAINS_LIBINTL])
 
 #
 # Define NO_GETTEXT if you don't want Git output to be translated.
@@ -669,7 +678,7 @@ AC_SUBST(LIBC_CONTAINS_LIBINTL)
 AC_CHECK_HEADER([libintl.h],
 [NO_GETTEXT=],
 [NO_GETTEXT=YesPlease])
-AC_SUBST(NO_GETTEXT)
+GIT_CONF_SUBST([NO_GETTEXT])
 
 if test -z "$NO_GETTEXT"; then
     test -n "$LIBC_CONTAINS_LIBINTL" || LIBS="$LIBS -lintl"
@@ -682,19 +691,19 @@ AC_MSG_NOTICE([CHECKS for header files])
 AC_CHECK_HEADER([sys/select.h],
 [NO_SYS_SELECT_H=],
 [NO_SYS_SELECT_H=UnfortunatelyYes])
-AC_SUBST(NO_SYS_SELECT_H)
+GIT_CONF_SUBST([NO_SYS_SELECT_H])
 #
 # Define NO_SYS_POLL_H if you don't have sys/poll.h
 AC_CHECK_HEADER([sys/poll.h],
 [NO_SYS_POLL_H=],
 [NO_SYS_POLL_H=UnfortunatelyYes])
-AC_SUBST(NO_SYS_POLL_H)
+GIT_CONF_SUBST([NO_SYS_POLL_H])
 #
 # Define NO_INTTYPES_H if you don't have inttypes.h
 AC_CHECK_HEADER([inttypes.h],
 [NO_INTTYPES_H=],
 [NO_INTTYPES_H=UnfortunatelyYes])
-AC_SUBST(NO_INTTYPES_H)
+GIT_CONF_SUBST([NO_INTTYPES_H])
 #
 # Define OLD_ICONV if your library has an old iconv(), where the second
 # (input buffer pointer) parameter is declared with type (const char **).
@@ -717,23 +726,24 @@ AC_COMPILE_IFELSE([OLDICONVTEST_SRC],
 
 GIT_UNSTASH_FLAGS($ICONVDIR)
 
-AC_SUBST(OLD_ICONV)
+GIT_CONF_SUBST([OLD_ICONV])
 
 ## Checks for typedefs, structures, and compiler characteristics.
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
 #
 TYPE_SOCKLEN_T
 case $ac_cv_type_socklen_t in
-  yes)	;;
-  *)  	AC_SUBST([SOCKLEN_T], [$git_cv_socklen_t_equiv]) ;;
+  yes)	SOCKLEN_T='';;
+  *)  	SOCKLEN_T=$git_cv_socklen_t_equiv;;
 esac
+GIT_CONF_SUBST([SOCKLEN_T])
 
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,
 [NO_D_INO_IN_DIRENT=],
 [NO_D_INO_IN_DIRENT=YesPlease],
 [#include <dirent.h>])
-AC_SUBST(NO_D_INO_IN_DIRENT)
+GIT_CONF_SUBST([NO_D_INO_IN_DIRENT])
 #
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (latest Cygwin -- will be fixed soonish).
@@ -741,7 +751,7 @@ AC_CHECK_MEMBER(struct dirent.d_type,
 [NO_D_TYPE_IN_DIRENT=],
 [NO_D_TYPE_IN_DIRENT=YesPlease],
 [#include <dirent.h>])
-AC_SUBST(NO_D_TYPE_IN_DIRENT)
+GIT_CONF_SUBST([NO_D_TYPE_IN_DIRENT])
 #
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
 # sockaddr_storage.
@@ -751,7 +761,7 @@ AC_CHECK_TYPE(struct sockaddr_storage,
 #include <sys/types.h>
 #include <sys/socket.h>
 ])
-AC_SUBST(NO_SOCKADDR_STORAGE)
+GIT_CONF_SUBST([NO_SOCKADDR_STORAGE])
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
 AC_CHECK_TYPE([struct addrinfo],[
@@ -763,7 +773,7 @@ AC_CHECK_TYPE([struct addrinfo],[
 #include <sys/socket.h>
 #include <netdb.h>
 ])
-AC_SUBST(NO_IPV6)
+GIT_CONF_SUBST([NO_IPV6])
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
 AC_CACHE_CHECK([whether the platform regex can handle null bytes],
@@ -784,7 +794,7 @@ if test $ac_cv_c_excellent_regex = yes; then
 else
 	NO_REGEX=YesPlease
 fi
-AC_SUBST(NO_REGEX)
+GIT_CONF_SUBST([NO_REGEX])
 #
 # Define FREAD_READS_DIRECTORIES if your are on a system which succeeds
 # when attempting to read from an fopen'ed directory.
@@ -804,7 +814,7 @@ if test $ac_cv_fread_reads_directories = yes; then
 else
 	FREAD_READS_DIRECTORIES=
 fi
-AC_SUBST(FREAD_READS_DIRECTORIES)
+GIT_CONF_SUBST([FREAD_READS_DIRECTORIES])
 #
 # Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
 # or vsnprintf() return -1 instead of number of characters which would
@@ -838,7 +848,7 @@ if test $ac_cv_snprintf_returns_bogus = yes; then
 else
 	SNPRINTF_RETURNS_BOGUS=
 fi
-AC_SUBST(SNPRINTF_RETURNS_BOGUS)
+GIT_CONF_SUBST([SNPRINTF_RETURNS_BOGUS])
 
 
 ## Checks for library functions.
@@ -849,47 +859,45 @@ AC_MSG_NOTICE([CHECKS for library functions])
 AC_CHECK_HEADER([libgen.h],
 [NO_LIBGEN_H=],
 [NO_LIBGEN_H=YesPlease])
-AC_SUBST(NO_LIBGEN_H)
+GIT_CONF_SUBST([NO_LIBGEN_H])
 #
 # Define HAVE_PATHS_H if you have paths.h.
 AC_CHECK_HEADER([paths.h],
 [HAVE_PATHS_H=YesPlease],
 [HAVE_PATHS_H=])
-AC_SUBST(HAVE_PATHS_H)
+GIT_CONF_SUBST([HAVE_PATHS_H])
 #
 # Define HAVE_LIBCHARSET_H if have libcharset.h
 AC_CHECK_HEADER([libcharset.h],
 [HAVE_LIBCHARSET_H=YesPlease],
 [HAVE_LIBCHARSET_H=])
-AC_SUBST(HAVE_LIBCHARSET_H)
+GIT_CONF_SUBST([HAVE_LIBCHARSET_H])
 # Define CHARSET_LIB if libiconv does not export the locale_charset symbol
 # and libcharset does
 CHARSET_LIB=
 AC_CHECK_LIB([iconv], [locale_charset],
        [],
        [AC_CHECK_LIB([charset], [locale_charset],
-                     [CHARSET_LIB=-lcharset])
-       ]
-)
-AC_SUBST(CHARSET_LIB)
+                     [CHARSET_LIB=-lcharset])])
+GIT_CONF_SUBST([CHARSET_LIB])
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=],
 [NO_STRCASESTR=YesPlease])
-AC_SUBST(NO_STRCASESTR)
+GIT_CONF_SUBST([NO_STRCASESTR])
 #
 # Define NO_STRTOK_R if you don't have strtok_r
 GIT_CHECK_FUNC(strtok_r,
 [NO_STRTOK_R=],
 [NO_STRTOK_R=YesPlease])
-AC_SUBST(NO_STRTOK_R)
+GIT_CONF_SUBST([NO_STRTOK_R])
 #
 # Define NO_FNMATCH if you don't have fnmatch
 GIT_CHECK_FUNC(fnmatch,
 [NO_FNMATCH=],
 [NO_FNMATCH=YesPlease])
-AC_SUBST(NO_FNMATCH)
+GIT_CONF_SUBST([NO_FNMATCH])
 #
 # Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
 # FNM_CASEFOLD GNU extension.
@@ -911,19 +919,19 @@ if test $ac_cv_c_excellent_fnmatch = yes; then
 else
 	NO_FNMATCH_CASEFOLD=YesPlease
 fi
-AC_SUBST(NO_FNMATCH_CASEFOLD)
+GIT_CONF_SUBST([NO_FNMATCH_CASEFOLD])
 #
 # Define NO_MEMMEM if you don't have memmem.
 GIT_CHECK_FUNC(memmem,
 [NO_MEMMEM=],
 [NO_MEMMEM=YesPlease])
-AC_SUBST(NO_MEMMEM)
+GIT_CONF_SUBST([NO_MEMMEM])
 #
 # Define NO_STRLCPY if you don't have strlcpy.
 GIT_CHECK_FUNC(strlcpy,
 [NO_STRLCPY=],
 [NO_STRLCPY=YesPlease])
-AC_SUBST(NO_STRLCPY)
+GIT_CONF_SUBST([NO_STRLCPY])
 #
 # Define NO_UINTMAX_T if your platform does not have uintmax_t
 AC_CHECK_TYPE(uintmax_t,
@@ -931,43 +939,43 @@ AC_CHECK_TYPE(uintmax_t,
 [NO_UINTMAX_T=YesPlease],[
 #include <inttypes.h>
 ])
-AC_SUBST(NO_UINTMAX_T)
+GIT_CONF_SUBST([NO_UINTMAX_T])
 #
 # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
 GIT_CHECK_FUNC(strtoumax,
 [NO_STRTOUMAX=],
 [NO_STRTOUMAX=YesPlease])
-AC_SUBST(NO_STRTOUMAX)
+GIT_CONF_SUBST([NO_STRTOUMAX])
 #
 # Define NO_SETENV if you don't have setenv in the C library.
 GIT_CHECK_FUNC(setenv,
 [NO_SETENV=],
 [NO_SETENV=YesPlease])
-AC_SUBST(NO_SETENV)
+GIT_CONF_SUBST([NO_SETENV])
 #
 # Define NO_UNSETENV if you don't have unsetenv in the C library.
 GIT_CHECK_FUNC(unsetenv,
 [NO_UNSETENV=],
 [NO_UNSETENV=YesPlease])
-AC_SUBST(NO_UNSETENV)
+GIT_CONF_SUBST([NO_UNSETENV])
 #
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 GIT_CHECK_FUNC(mkdtemp,
 [NO_MKDTEMP=],
 [NO_MKDTEMP=YesPlease])
-AC_SUBST(NO_MKDTEMP)
+GIT_CONF_SUBST([NO_MKDTEMP])
 #
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 GIT_CHECK_FUNC(mkstemps,
 [NO_MKSTEMPS=],
 [NO_MKSTEMPS=YesPlease])
-AC_SUBST(NO_MKSTEMPS)
+GIT_CONF_SUBST([NO_MKSTEMPS])
 #
 # Define NO_INITGROUPS if you don't have initgroups in the C library.
 GIT_CHECK_FUNC(initgroups,
 [NO_INITGROUPS=],
 [NO_INITGROUPS=YesPlease])
-AC_SUBST(NO_INITGROUPS)
+GIT_CONF_SUBST([NO_INITGROUPS])
 #
 #
 # Define NO_MMAP if you want to avoid mmap.
@@ -1049,9 +1057,9 @@ fi
 
 CFLAGS="$old_CFLAGS"
 
-AC_SUBST(PTHREAD_CFLAGS)
-AC_SUBST(PTHREAD_LIBS)
-AC_SUBST(NO_PTHREADS)
+GIT_CONF_SUBST([PTHREAD_CFLAGS])
+GIT_CONF_SUBST([PTHREAD_LIBS])
+GIT_CONF_SUBST([NO_PTHREADS])
 
 ## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}"])
-- 
1.7.12.317.g1c54b74
