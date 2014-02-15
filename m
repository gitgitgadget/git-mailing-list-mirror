From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] Stop using fnmatch (either native or compat)
Date: Sat, 15 Feb 2014 09:01:48 +0700
Message-ID: <1392429709-9237-4-git-send-email-pclouds@gmail.com>
References: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 03:02:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEUaC-0004bC-Su
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 03:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbaBOCCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Feb 2014 21:02:09 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:47430 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbaBOCCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 21:02:00 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so13019216pab.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 18:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZIPZQxxa1nufHRQdGmONNmikop0kJJaUdd6FvHNA1SA=;
        b=JO2btNmJFKAOpV57wm/z+jF7okgCdAHJiQfAdlANtIvO5M5tFHZ6txSo5aUd4AhlSE
         CeYjYYE/PJVZmO+232VA/x9zbB70G5AfSH16++RB5wIFq3VR76/z5m6H2i3dS6XsHX8A
         tuC6Yf4HSEtxXsUKSiaV9SiWeDLQCDwVox6KC07IxWgj8OybSOGKxQHOuAvOz7ehv6t1
         jHpftybyYRT311NXa5pcBlVCVTNVVOvb4m2spey+/Ckq/fma1ahkV6qCr0JKcmY+yBg9
         aNA9O+TnvFlAFxChnqjq8QHm1QLYEk5K9vk4TXhm86QWoVMJyPPP36N5X49ESJ+lRlg8
         ji3Q==
X-Received: by 10.66.241.73 with SMTP id wg9mr12842105pac.69.1392429719590;
        Fri, 14 Feb 2014 18:01:59 -0800 (PST)
Received: from lanh ([115.73.215.60])
        by mx.google.com with ESMTPSA id tu3sm21812368pbc.40.2014.02.14.18.01.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Feb 2014 18:01:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Feb 2014 09:02:09 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242175>

Since v1.8.4 (about six months ago) wildmatch is used as default
replacement for fnmatch. We have seen only one fix since so wildmatch
probably has done a good job as fnmatch replacement. This concludes
the fnmatch->wildmatch transition by no longer relying on fnmatch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile             | 22 ----------------------
 config.mak.uname     | 10 ----------
 configure.ac         | 28 ----------------------------
 git-compat-util.h    | 12 ------------
 t/t3070-wildmatch.sh | 13 -------------
 test-wildmatch.c     |  6 ------
 6 files changed, 91 deletions(-)

diff --git a/Makefile b/Makefile
index dddaf4f..ca38f99 100644
--- a/Makefile
+++ b/Makefile
@@ -101,14 +101,6 @@ all::
 #
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 #
-# Define NO_FNMATCH if you don't have fnmatch in the C library.
-#
-# Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
-# FNM_CASEFOLD GNU extension.
-#
-# Define NO_WILDMATCH if you do not want to use Git's wildmatch
-# implementation as fnmatch
-#
 # Define NO_GECOS_IN_PWENT if you don't have pw_gecos in struct passwd
 # in the C library.
 #
@@ -1271,20 +1263,6 @@ endif
 ifdef NO_STRTOULL
 	COMPAT_CFLAGS +=3D -DNO_STRTOULL
 endif
-ifdef NO_FNMATCH
-	COMPAT_CFLAGS +=3D -Icompat/fnmatch
-	COMPAT_CFLAGS +=3D -DNO_FNMATCH
-	COMPAT_OBJS +=3D compat/fnmatch/fnmatch.o
-else
-ifdef NO_FNMATCH_CASEFOLD
-	COMPAT_CFLAGS +=3D -Icompat/fnmatch
-	COMPAT_CFLAGS +=3D -DNO_FNMATCH_CASEFOLD
-	COMPAT_OBJS +=3D compat/fnmatch/fnmatch.o
-endif
-endif
-ifndef NO_WILDMATCH
-	COMPAT_CFLAGS +=3D -DUSE_WILDMATCH
-endif
 ifdef NO_SETENV
 	COMPAT_CFLAGS +=3D -DNO_SETENV
 	COMPAT_OBJS +=3D compat/setenv.o
diff --git a/config.mak.uname b/config.mak.uname
index 7d31fad..6069a44 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -108,7 +108,6 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 	NO_REGEX =3D YesPlease
-	NO_FNMATCH_CASEFOLD =3D YesPlease
 	NO_MSGFMT_EXTENDED_OPTIONS =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
 	ifeq ($(uname_R),5.6)
@@ -259,7 +258,6 @@ ifeq ($(uname_S),IRIX)
 	# issue, comment out the NO_MMAP statement.
 	NO_MMAP =3D YesPlease
 	NO_REGEX =3D YesPlease
-	NO_FNMATCH_CASEFOLD =3D YesPlease
 	SNPRINTF_RETURNS_BOGUS =3D YesPlease
 	SHELL_PATH =3D /usr/gnu/bin/bash
 	NEEDS_LIBGEN =3D YesPlease
@@ -279,7 +277,6 @@ ifeq ($(uname_S),IRIX64)
 	# issue, comment out the NO_MMAP statement.
 	NO_MMAP =3D YesPlease
 	NO_REGEX =3D YesPlease
-	NO_FNMATCH_CASEFOLD =3D YesPlease
 	SNPRINTF_RETURNS_BOGUS =3D YesPlease
 	SHELL_PATH =3D /usr/gnu/bin/bash
 	NEEDS_LIBGEN =3D YesPlease
@@ -296,7 +293,6 @@ ifeq ($(uname_S),HP-UX)
 	NO_UNSETENV =3D YesPlease
 	NO_HSTRERROR =3D YesPlease
 	NO_SYS_SELECT_H =3D YesPlease
-	NO_FNMATCH_CASEFOLD =3D YesPlease
 	SNPRINTF_RETURNS_BOGUS =3D YesPlease
 	NO_NSEC =3D YesPlease
 	ifeq ($(uname_R),B.11.00)
@@ -327,7 +323,6 @@ ifeq ($(uname_S),Windows)
 	NO_UNSETENV =3D YesPlease
 	NO_STRCASESTR =3D YesPlease
 	NO_STRLCPY =3D YesPlease
-	NO_FNMATCH =3D YesPlease
 	NO_MEMMEM =3D YesPlease
 	# NEEDS_LIBICONV =3D YesPlease
 	NO_ICONV =3D YesPlease
@@ -389,13 +384,11 @@ ifeq ($(uname_S),Interix)
 		NO_INET_NTOP =3D YesPlease
 		NO_INET_PTON =3D YesPlease
 		NO_SOCKADDR_STORAGE =3D YesPlease
-		NO_FNMATCH_CASEFOLD =3D YesPlease
 	endif
 	ifeq ($(uname_R),5.2)
 		NO_INET_NTOP =3D YesPlease
 		NO_INET_PTON =3D YesPlease
 		NO_SOCKADDR_STORAGE =3D YesPlease
-		NO_FNMATCH_CASEFOLD =3D YesPlease
 	endif
 endif
 ifeq ($(uname_S),Minix)
@@ -440,7 +433,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_D_TYPE_IN_DIRENT =3D YesPlease
 	NO_HSTRERROR =3D YesPlease
 	NO_STRCASESTR =3D YesPlease
-	NO_FNMATCH_CASEFOLD =3D YesPlease
 	NO_MEMMEM =3D YesPlease
 	NO_STRLCPY =3D YesPlease
 	NO_SETENV =3D YesPlease
@@ -484,7 +476,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_UNSETENV =3D YesPlease
 	NO_STRCASESTR =3D YesPlease
 	NO_STRLCPY =3D YesPlease
-	NO_FNMATCH =3D YesPlease
 	NO_MEMMEM =3D YesPlease
 	NEEDS_LIBICONV =3D YesPlease
 	NO_STRTOUMAX =3D YesPlease
@@ -538,7 +529,6 @@ ifeq ($(uname_S),QNX)
 	EXPAT_NEEDS_XMLPARSE_H =3D YesPlease
 	HAVE_STRINGS_H =3D YesPlease
 	NEEDS_SOCKET =3D YesPlease
-	NO_FNMATCH_CASEFOLD =3D YesPlease
 	NO_GETPAGESIZE =3D YesPlease
 	NO_ICONV =3D YesPlease
 	NO_MEMMEM =3D YesPlease
diff --git a/configure.ac b/configure.ac
index 2f43393..24ab738 100644
--- a/configure.ac
+++ b/configure.ac
@@ -901,34 +901,6 @@ GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=3DYesPlease])
 GIT_CONF_SUBST([NO_STRCASESTR])
 #
-# Define NO_FNMATCH if you don't have fnmatch
-GIT_CHECK_FUNC(fnmatch,
-[NO_FNMATCH=3D],
-[NO_FNMATCH=3DYesPlease])
-GIT_CONF_SUBST([NO_FNMATCH])
-#
-# Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
-# FNM_CASEFOLD GNU extension.
-AC_CACHE_CHECK([whether the fnmatch function supports the FNMATCH_CASE=
=46OLD GNU extension],
- [ac_cv_c_excellent_fnmatch], [
-AC_EGREP_CPP(yippeeyeswehaveit,
-	AC_LANG_PROGRAM([
-#include <fnmatch.h>
-],
-[#ifdef FNM_CASEFOLD
-yippeeyeswehaveit
-#endif
-]),
-	[ac_cv_c_excellent_fnmatch=3Dyes],
-	[ac_cv_c_excellent_fnmatch=3Dno])
-])
-if test $ac_cv_c_excellent_fnmatch =3D yes; then
-	NO_FNMATCH_CASEFOLD=3D
-else
-	NO_FNMATCH_CASEFOLD=3DYesPlease
-fi
-GIT_CONF_SUBST([NO_FNMATCH_CASEFOLD])
-#
 # Define NO_MEMMEM if you don't have memmem.
 GIT_CHECK_FUNC(memmem,
 [NO_MEMMEM=3D],
diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..eaee438 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -116,9 +116,6 @@
 #include <sys/time.h>
 #include <time.h>
 #include <signal.h>
-#ifndef USE_WILDMATCH
-#include <fnmatch.h>
-#endif
 #include <assert.h>
 #include <regex.h>
 #include <utime.h>
@@ -304,16 +301,7 @@ extern char *gitbasename(char *);
=20
 #include "compat/bswap.h"
=20
-#ifdef USE_WILDMATCH
 #include "wildmatch.h"
-#define FNM_PATHNAME WM_PATHNAME
-#define FNM_CASEFOLD WM_CASEFOLD
-#define FNM_NOMATCH  WM_NOMATCH
-static inline int fnmatch(const char *pattern, const char *string, int=
 flags)
-{
-	return wildmatch(pattern, string, flags, NULL);
-}
-#endif
=20
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list para=
ms);
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 38446a0..ef509df 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -14,19 +14,6 @@ match() {
 	    ! test-wildmatch wildmatch '$3' '$4'
 	"
     fi
-    if [ $2 =3D 1 ]; then
-	test_expect_success "fnmatch:       match '$3' '$4'" "
-	    test-wildmatch fnmatch '$3' '$4'
-	"
-    elif [ $2 =3D 0 ]; then
-	test_expect_success "fnmatch:    no match '$3' '$4'" "
-	    ! test-wildmatch fnmatch '$3' '$4'
-	"
-#    else
-#	test_expect_success BROKEN_FNMATCH "fnmatch:       '$3' '$4'" "
-#	    ! test-wildmatch fnmatch '$3' '$4'
-#	"
-    fi
 }
=20
 imatch() {
diff --git a/test-wildmatch.c b/test-wildmatch.c
index 1564bd5..578b164 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -1,8 +1,4 @@
-#ifdef USE_WILDMATCH
-#undef USE_WILDMATCH  /* We need real fnmatch implementation here */
-#endif
 #include "cache.h"
-#include "wildmatch.h"
=20
 int main(int argc, char **argv)
 {
@@ -20,8 +16,6 @@ int main(int argc, char **argv)
 		return !!wildmatch(argv[3], argv[2], WM_PATHNAME | WM_CASEFOLD, NULL=
);
 	else if (!strcmp(argv[1], "pathmatch"))
 		return !!wildmatch(argv[3], argv[2], 0, NULL);
-	else if (!strcmp(argv[1], "fnmatch"))
-		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
 		return 1;
 }
--=20
1.8.5.2.240.g8478abd
