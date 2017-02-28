Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E8011F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 01:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbdB1B0x (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 20:26:53 -0500
Received: from avasout04.plus.net ([212.159.14.19]:48482 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdB1B0u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 20:26:50 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id q1S71u00222aPyA011S8QP; Tue, 28 Feb 2017 01:26:08 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=acTKgRHFm2Qr1q2xEK4A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] wrapper.c: remove unused gitmkstemps() function
Message-ID: <361c3567-1449-9cc4-f311-ee2c747e934a@ramsayjones.plus.com>
Date:   Tue, 28 Feb 2017 01:26:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The last call to the mkstemps() function was removed in commit 659488326
("wrapper.c: delete dead function git_mkstemps()", 22-04-2016). In order
to support platforms without mkstemps(), this functionality was provided,
along with a Makefile build variable (NO_MKSTEMPS), by the gitmkstemps()
function. Remove the dead code, along with the defunct build machinery.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile          |  5 -----
 config.mak.uname  | 17 -----------------
 configure.ac      |  6 ------
 git-compat-util.h |  5 -----
 wrapper.c         |  7 -------
 5 files changed, 40 deletions(-)

diff --git a/Makefile b/Makefile
index 8e4081e06..ca9f16d19 100644
--- a/Makefile
+++ b/Makefile
@@ -102,8 +102,6 @@ all::
 #
 # Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
 #
-# Define NO_MKSTEMPS if you don't have mkstemps in the C library.
-#
 # Define NO_GECOS_IN_PWENT if you don't have pw_gecos in struct passwd
 # in the C library.
 #
@@ -1280,9 +1278,6 @@ ifdef MKDIR_WO_TRAILING_SLASH
 	COMPAT_CFLAGS += -DMKDIR_WO_TRAILING_SLASH
 	COMPAT_OBJS += compat/mkdir.o
 endif
-ifdef NO_MKSTEMPS
-	COMPAT_CFLAGS += -DNO_MKSTEMPS
-endif
 ifdef NO_UNSETENV
 	COMPAT_CFLAGS += -DNO_UNSETENV
 	COMPAT_OBJS += compat/unsetenv.o
diff --git a/config.mak.uname b/config.mak.uname
index 447f36ac2..7bdf86d2a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -27,7 +27,6 @@ endif
 ifeq ($(uname_S),Linux)
 	HAVE_ALLOCA_H = YesPlease
 	NO_STRLCPY = YesPlease
-	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 	HAVE_DEV_TTY = YesPlease
@@ -41,7 +40,6 @@ endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
 	NO_STRLCPY = YesPlease
-	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
@@ -55,7 +53,6 @@ ifeq ($(uname_S),UnixWare)
 	SHELL_PATH = /usr/local/bin/bash
 	NO_IPV6 = YesPlease
 	NO_HSTRERROR = YesPlease
-	NO_MKSTEMPS = YesPlease
 	BASIC_CFLAGS += -Kthread
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
@@ -79,7 +76,6 @@ ifeq ($(uname_S),SCO_SV)
 	SHELL_PATH = /usr/bin/bash
 	NO_IPV6 = YesPlease
 	NO_HSTRERROR = YesPlease
-	NO_MKSTEMPS = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	NO_STRCASESTR = YesPlease
@@ -122,7 +118,6 @@ ifeq ($(uname_S),SunOS)
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
-	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
 	NO_MSGFMT_EXTENDED_OPTIONS = YesPlease
 	HAVE_DEV_TTY = YesPlease
@@ -168,7 +163,6 @@ ifeq ($(uname_O),Cygwin)
 		NO_D_TYPE_IN_DIRENT = YesPlease
 		NO_STRCASESTR = YesPlease
 		NO_MEMMEM = YesPlease
-		NO_MKSTEMPS = YesPlease
 		NO_SYMLINK_HEAD = YesPlease
 		NO_IPV6 = YesPlease
 		OLD_ICONV = UnfortunatelyYes
@@ -233,7 +227,6 @@ ifeq ($(uname_S),NetBSD)
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
 	USE_ST_TIMESPEC = YesPlease
-	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
 endif
@@ -242,7 +235,6 @@ ifeq ($(uname_S),AIX)
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
-	NO_MKSTEMPS = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_NSEC = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
@@ -263,7 +255,6 @@ ifeq ($(uname_S),GNU)
 	# GNU/Hurd
 	HAVE_ALLOCA_H = YesPlease
 	NO_STRLCPY = YesPlease
-	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 endif
@@ -272,7 +263,6 @@ ifeq ($(uname_S),IRIX)
 	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_MKSTEMPS = YesPlease
 	NO_MKDTEMP = YesPlease
 	# When compiled with the MIPSpro 7.4.4m compiler, and without pthreads
 	# (i.e. NO_PTHREADS is set), and _with_ MMAP (i.e. NO_MMAP is not set),
@@ -291,7 +281,6 @@ ifeq ($(uname_S),IRIX64)
 	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_MKSTEMPS = YesPlease
 	NO_MKDTEMP = YesPlease
 	# When compiled with the MIPSpro 7.4.4m compiler, and without pthreads
 	# (i.e. NO_PTHREADS is set), and _with_ MMAP (i.e. NO_MMAP is not set),
@@ -311,7 +300,6 @@ ifeq ($(uname_S),HP-UX)
 	NO_SETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_MKSTEMPS = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_UNSETENV = YesPlease
@@ -352,7 +340,6 @@ ifeq ($(uname_S),Windows)
 	NO_ICONV = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
-	NO_MKSTEMPS = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
@@ -402,7 +389,6 @@ ifeq ($(uname_S),Interix)
 	NO_MKDTEMP = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_NSEC = YesPlease
-	NO_MKSTEMPS = YesPlease
 	ifeq ($(uname_R),3.5)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
@@ -461,7 +447,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_SETENV = YesPlease
 	NO_UNSETENV = YesPlease
 	NO_MKDTEMP = YesPlease
-	NO_MKSTEMPS = YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV = UnfortunatelyYes
 	NO_REGEX = YesPlease
@@ -503,7 +488,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NEEDS_LIBICONV = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
-	NO_MKSTEMPS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
@@ -584,7 +568,6 @@ ifeq ($(uname_S),QNX)
 	NO_ICONV = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
-	NO_MKSTEMPS = YesPlease
 	NO_NSEC = YesPlease
 	NO_PTHREADS = YesPlease
 	NO_R_TO_GCC_LINKER = YesPlease
diff --git a/configure.ac b/configure.ac
index 0b15f04b1..128165529 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1050,12 +1050,6 @@ GIT_CHECK_FUNC(mkdtemp,
 [NO_MKDTEMP=YesPlease])
 GIT_CONF_SUBST([NO_MKDTEMP])
 #
-# Define NO_MKSTEMPS if you don't have mkstemps in the C library.
-GIT_CHECK_FUNC(mkstemps,
-[NO_MKSTEMPS=],
-[NO_MKSTEMPS=YesPlease])
-GIT_CONF_SUBST([NO_MKSTEMPS])
-#
 # Define NO_INITGROUPS if you don't have initgroups in the C library.
 GIT_CHECK_FUNC(initgroups,
 [NO_INITGROUPS=],
diff --git a/git-compat-util.h b/git-compat-util.h
index ef6d560e1..e626851fe 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -639,11 +639,6 @@ extern int gitsetenv(const char *, const char *, int);
 extern char *gitmkdtemp(char *);
 #endif
 
-#ifdef NO_MKSTEMPS
-#define mkstemps gitmkstemps
-extern int gitmkstemps(char *, int);
-#endif
-
 #ifdef NO_UNSETENV
 #define unsetenv gitunsetenv
 extern void gitunsetenv(const char *);
diff --git a/wrapper.c b/wrapper.c
index 1a140639f..0542fc758 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -514,13 +514,6 @@ int git_mkstemp_mode(char *pattern, int mode)
 	return git_mkstemps_mode(pattern, 0, mode);
 }
 
-#ifdef NO_MKSTEMPS
-int gitmkstemps(char *pattern, int suffix_len)
-{
-	return git_mkstemps_mode(pattern, suffix_len, 0600);
-}
-#endif
-
 int xmkstemp_mode(char *template, int mode)
 {
 	int fd;
-- 
2.12.0
