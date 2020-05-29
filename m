Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2723C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9041A206E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar4ewIe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgE2Nka (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 09:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2Nk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 09:40:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856DC03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e1so3673600wrt.5
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f6tcl88/37S+uvYo8K1ZFKlT1Z8RrAoOH55NlHJWOpw=;
        b=ar4ewIe8AjMEPlaqOTfy3DbKaRUHyIqF6pzXKTMpl8Pvt/Hsy5/nGFJMTfWHMPtQNz
         wfiDovVM8pk68riGPwQNxBPd7iwo2c0tAEk+Dns1yKdb//gSjaqdVd1nvDdNt+HMx0j7
         RfR5BbqjRNZLezXUG+T5Xs4VuhyRfPS+v7EBKu2fPb/8PqqJrwwNi165OECeleDR0QTh
         l1kMzWrLKmOU91egQyP+YUbSdnQpO0fptuaOqN+vfmfsgPDeGNjkCmOvNs7UUh9TonsG
         lvS/tzljEhixp4MGAWcSqDcexO9L3+hGc2oPGw1PcOBqCvNleKIv7pSwUDSzbSbJdxbZ
         cNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f6tcl88/37S+uvYo8K1ZFKlT1Z8RrAoOH55NlHJWOpw=;
        b=pvSm36QEkIt9cSFsoVxNBxYfvvE1Bof5Yn/jxOc0Qu5DvMDm/LFs51PM5JfYfEzbWB
         e0eUELmVwuoaHnbP7tApFV8ET7CXPp797e0Mq6Auqd8j/T/EqOFYWeJQJal6tTu1yybr
         BDtzxspwmOjgODLk50z6ywyv7mqEPdAkqUf6aqt8WZft0Rz5IS8N2g+wnSXjrIvhB9HJ
         el+h8YZDzWR5jthzmiJsrkTxO0Fj8PP2mhNSQVvSDPuqGtf9r1HYNdk9z+d9JQ2/xYJk
         ggaITK2q6kOrbfZfM3L2GObgOdt3PWaBmQ0lBpp05iPZ2zxbStqNYnvcs7KVFlGUFVn6
         D5eQ==
X-Gm-Message-State: AOAM531ui7bNu49bwZ936X8ZTWxoGHKuItwmljRZ1nsN7yFYuZqZAsTq
        TPG0bL3godVjjf1LFSqCfUg3IYbc
X-Google-Smtp-Source: ABdhPJwq3/9T2+DVel0VDOy93euE2A6wgavwNlvL7rfOIoiW00f+2th5O6/OYf9bkDzfyFv7SINqCg==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr9453944wrw.179.1590759626418;
        Fri, 29 May 2020 06:40:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m129sm10699203wmf.2.2020.05.29.06.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:40:25 -0700 (PDT)
Message-Id: <09c972de52b35b14a4c6f44b10c3dfc1732b2c7a.1590759624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 May 2020 13:40:17 +0000
Subject: [PATCH v3 1/8] Introduce CMake support for configuring Git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>

At the moment, the recommended way to configure Git's builds is to
simply run `make`. If that does not work, the recommended strategy is to
look at the top of the `Makefile` to see whether any "Makefile knob" has
to be turned on/off, e.g. `make NO_OPENSSL=YesPlease`.

Alternatively, Git also has an `autoconf` setup which allows configuring
builds via `./configure [<option>...]`.

Both of these options are fine if the developer works on Unix or Linux.
But on Windows, we have to jump through hoops to configure a build
(read: we force the user to install a full Git for Windows SDK, which
occupies around two gigabytes (!) on disk and downloads about three
quarters of a gigabyte worth of Git objects).

The build infrastructure for Git is written around being able to run
make, which is not supported natively on Windows.
To help Windows developers a CMake build script is introduced here.

With a working support CMake, developers on Windows need only install
CMake, configure their build, load the generated Visual Studio solution
and immediately start modifying the code and build their own version of
Git. Likewise, developers on other platforms can use the convenient GUI
tools provided by CMake to configure their build.

So let's start building CMake support for Git.

This is only the first step, and to make it easier to review, it only
allows for configuring builds on the platform that is easiest to
configure for: Linux.

The CMake script checks whether the headers are present(eg. libgen.h),
whether the functions are present(eg. memmem), whether the funtions work
properly (eg. snprintf) and generate the required compile definitions
for the platform. The script also searches for the required libraries,
if it fails to find the required libraries the respective executables
won't be built.(eg. If libcurl is not found then git-remote-http won't
be built). This will help building Git easier.

With a CMake script an out of source build of git is possible resulting
in a clean source tree.

Note: this patch asks for the minimum version v3.14 of CMake (which is
not all that old as of time of writing) because that is the first
version to offer a platform-independent way to generate hardlinks as
part of the build. This is needed to generate all those hardlinks for
the built-in commands of Git.

Changes
The CMake script parses the Makefile for:
LIB_OBJS
BUILTIN_OBJS
XDIFF_OBJS
VCSSVN_OBJS
TEST_BUILTINS_OBJS

By doing this we avoid duplication of text between the Makefile and
the CMake script.

The CMake script has been relocated to contrib/buildsystems.

The CMake script uses GIT-VERSION-GEN to determine the version of Git
being built.

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 575 ++++++++++++++++++++++++++++
 1 file changed, 575 insertions(+)
 create mode 100644 contrib/buildsystems/CMakeLists.txt

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
new file mode 100644
index 00000000000..8e2b27f44a6
--- /dev/null
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -0,0 +1,575 @@
+#
+#	Copyright (c) 2020 Sibi Siddharthan
+#
+
+#[[
+
+Instructions to run CMake:
+
+cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
+
+Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
+compiler flags
+Debug : -g
+Release: -O3
+RelWithDebInfo : -O2 -g
+MinSizeRel : -Os
+empty(default) :
+
+NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual Studio
+this option is ignored
+
+This process generates a Makefile(Linux) , Visual Studio solution(Windows) by default.
+Run `make` to build Git on Linux.
+Open git.sln on Windows and build Git.
+
+NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
+to use another tool say `ninja` add this to the command line when configuring.
+`-G Ninja`
+
+]]
+cmake_minimum_required(VERSION 3.14)
+
+#set the source directory to root of git
+set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
+
+find_program(SH_EXE sh)
+
+#Create GIT-VERSION-FILE using GIT-VERSION-GEN
+if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
+	message("Generating GIT-VERSION-FILE")
+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
+		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
+endif()
+
+#Parse GIT-VERSION-FILE to get the version
+file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE git_version REGEX "GIT_VERSION = (.*)")
+string(REPLACE "GIT_VERSION = " "" git_version ${git_version})
+string(FIND ${git_version} "GIT" location)
+if(location EQUAL -1)
+	string(REGEX MATCH "[0-9]*\\.[0-9]*\\.[0-9]*" git_version ${git_version})
+else()
+	string(REGEX MATCH "[0-9]*\\.[0-9]*" git_version ${git_version})
+	string(APPEND git_version ".0") #for building from a snapshot
+endif()
+
+project(git
+	VERSION ${git_version}
+	LANGUAGES C)
+
+
+#macros for parsing the Makefile for sources
+macro(parse_makefile_for_sources list_var regex)
+	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
+	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
+	string(REPLACE "$(COMPAT_OBJS)" "" ${list_var} ${${list_var}}) #remove "$(COMPAT_OBJS)" This is only for libgit.
+	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
+	string(REPLACE ".o" ".c;" ${list_var} ${${list_var}}) #change .o to .c, ; is for converting the string into a list
+	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespaces for each element in list
+	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
+endmacro()
+
+include(CheckTypeSize)
+include(CheckCSourceRuns)
+include(CheckCSourceCompiles)
+include(CheckIncludeFile)
+include(CheckFunctionExists)
+include(CheckSymbolExists)
+include(CheckStructHasMember)
+
+find_package(ZLIB REQUIRED)
+find_package(CURL)
+find_package(EXPAT)
+find_package(Iconv)
+find_package(Intl)
+
+if(NOT Intl_FOUND)
+	add_compile_definitions(NO_GETTEXT)
+	if(NOT Iconv_FOUND)
+		add_compile_definitions(NO_ICONV)
+	endif()
+endif()
+
+include_directories(SYSTEM ${ZLIB_INCLUDE_DIRS})
+if(CURL_FOUND)
+	include_directories(SYSTEM ${CURL_INCLUDE_DIRS})
+endif()
+if(EXPAT_FOUND)
+	include_directories(SYSTEM ${EXPAT_INCLUDE_DIRS})
+endif()
+if(Iconv_FOUND)
+	include_directories(SYSTEM ${Iconv_INCLUDE_DIRS})
+endif()
+if(Intl_FOUND)
+	include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
+endif()
+
+#default behaviour
+include_directories(${CMAKE_SOURCE_DIR})
+add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
+add_compile_definitions(SHA256_BLK INTERNAL_QSORT RUNTIME_PREFIX)
+add_compile_definitions(NO_OPENSSL SHA1_DC SHA1DC_NO_STANDARD_INCLUDES
+			SHA1DC_INIT_SAFE_HASH_DEFAULT=0
+			SHA1DC_CUSTOM_INCLUDE_SHA1_C="cache.h"
+			SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h" )
+list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
+
+
+add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
+			ETC_GITATTRIBUTES="etc/gitattributes"
+			ETC_GITCONFIG="etc/gitconfig"
+			GIT_EXEC_PATH="libexec/git-core"
+			GIT_LOCALE_PATH="share/locale"
+			GIT_MAN_PATH="share/man"
+			GIT_INFO_PATH="share/info"
+			GIT_HTML_PATH="share/doc/git-doc"
+			DEFAULT_HELP_FORMAT="html"
+			DEFAULT_GIT_TEMPLATE_DIR="share/git-core/templates"
+			GIT_VERSION="${PROJECT_VERSION}.GIT"
+			GIT_USER_AGENT="git/${PROJECT_VERSION}.GIT"
+			BINDIR="bin"
+			GIT_BUILT_FROM_COMMIT="")
+
+set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
+add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
+
+add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
+list(APPEND compat_SOURCES unix-socket.c)
+
+#header checks
+check_include_file(libgen.h HAVE_LIBGEN_H)
+if(NOT HAVE_LIBGEN_H)
+	add_compile_definitions(NO_LIBGEN_H)
+	list(APPEND compat_SOURCES compat/basename.c)
+endif()
+
+check_include_file(sys/sysinfo.h HAVE_SYSINFO)
+if(HAVE_SYSINFO)
+	add_compile_definitions(HAVE_SYSINFO)
+endif()
+
+check_c_source_compiles("
+#include <alloca.h>
+int
+main ()
+{
+char *p = (char *) alloca (2 * sizeof (int));
+	if (p) return 0;
+	return 0;
+}"
+HAVE_ALLOCA_H)
+if(HAVE_ALLOCA_H)
+	add_compile_definitions(HAVE_ALLOCA_H)
+endif()
+
+check_include_file(strings.h HAVE_STRINGS_H)
+if(HAVE_STRINGS_H)
+	add_compile_definitions(HAVE_STRINGS_H)
+endif()
+
+check_include_file(sys/select.h HAVE_SYS_SELECT_H)
+if(NOT HAVE_SYS_SELECT_H)
+	add_compile_definitions(NO_SYS_SELECT_H)
+endif()
+
+check_include_file(sys/poll.h HAVE_SYS_POLL_H)
+if(NOT HAVE_SYS_POLL_H)
+	add_compile_definitions(NO_SYS_POLL_H)
+endif()
+
+check_include_file(poll.h HAVE_POLL_H)
+if(NOT HAVE_POLL_H)
+	add_compile_definitions(NO_POLL_H)
+endif()
+
+check_include_file(inttypes.h HAVE_INTTYPES_H)
+if(NOT HAVE_INTTYPES_H)
+	add_compile_definitions(NO_INTTYPES_H)
+endif()
+
+check_include_file(paths.h HAVE_PATHS_H)
+if(HAVE_PATHS_H)
+	add_compile_definitions(HAVE_PATHS_H)
+endif()
+
+#function checks
+set(function_checks
+	strcasestr memmem strlcpy strtoimax strtoumax strtoull
+	setenv mkdtemp poll pread memmem unsetenv hstrerror)
+
+foreach(f ${function_checks})
+	string(TOUPPER ${f} uf)
+	check_function_exists(${f} HAVE_${uf})
+	if(NOT HAVE_${uf})
+		add_compile_definitions(NO_${uf})
+	endif()
+endforeach()
+
+if(NOT HAVE_POLL_H OR NOT HAVE_SYS_POLL_H OR NOT HAVE_POLL)
+	include_directories(${CMAKE_SOURCE_DIR}/compat/poll)
+	add_compile_definitions(NO_POLL)
+	list(APPEND compat_SOURCES compat/poll/poll.c)
+endif()
+
+if(NOT HAVE_STRCASESTR)
+	list(APPEND compat_SOURCES compat/strcasestr.c)
+endif()
+
+if(NOT HAVE_STRLCPY)
+	list(APPEND compat_SOURCES compat/strlcpy.c)
+endif()
+
+if(NOT HAVE_STRTOUMAX)
+	list(APPEND compat_SOURCES compat/strtoumax.c compat/strtoimax.c)
+endif()
+
+if(NOT HAVE_SETENV)
+	list(APPEND compat_SOURCES compat/setenv.c)
+endif()
+
+if(NOT HAVE_MKDTEMP)
+	list(APPEND compat_SOURCES compat/mkdtemp.c)
+endif()
+
+if(NOT HAVE_PREAD)
+	list(APPEND compat_SOURCES compat/pread.c)
+endif()
+
+if(NOT HAVE_MEMMEM)
+	list(APPEND compat_SOURCES compat/memmem.c)
+endif()
+
+if(NOT WIN32)
+	if(NOT HAVE_UNSETENV)
+		list(APPEND compat_SOURCES compat/unsetenv.c)
+	endif()
+
+	if(NOT HAVE_HSTRERROR)
+		list(APPEND compat_SOURCES compat/hstrerror.c)
+	endif()
+endif()
+
+check_function_exists(getdelim HAVE_GETDELIM)
+if(HAVE_GETDELIM)
+	add_compile_definitions(HAVE_GETDELIM)
+endif()
+
+check_function_exists(clock_gettime HAVE_CLOCK_GETTIME)
+check_symbol_exists(CLOCK_MONOTONIC "time.h" HAVE_CLOCK_MONOTONIC)
+if(HAVE_CLOCK_GETTIME)
+	add_compile_definitions(HAVE_CLOCK_GETTIME)
+endif()
+if(HAVE_CLOCK_MONOTONIC)
+	add_compile_definitions(HAVE_CLOCK_MONOTONIC)
+endif()
+
+#check for st_blocks in struct stat
+check_struct_has_member("struct stat" st_blocks "sys/stat.h" STRUCT_STAT_HAS_ST_BLOCKS)
+if(NOT STRUCT_STAT_HAS_ST_BLOCKS)
+	add_compile_definitions(NO_ST_BLOCKS_IN_STRUCT_STAT)
+endif()
+
+#compile checks
+check_c_source_runs("
+#include<stdio.h>
+#include<stdarg.h>
+#include<string.h>
+#include<stdlib.h>
+int test_vsnprintf(char *str, size_t maxsize, const char *format, ...)
+{
+	int ret;
+	va_list ap;
+
+	va_start(ap, format);
+	ret = vsnprintf(str, maxsize, format, ap);
+	va_end(ap);
+	return ret;
+}
+
+int
+main ()
+{
+	char buf[6];
+	if (test_vsnprintf(buf, 3, \"%s\", \"12345\") != 5
+		|| strcmp(buf, \"12\")) return 1;
+	if (snprintf(buf, 3, \"%s\", \"12345\") != 5
+		|| strcmp(buf, \"12\")) return 1;
+
+	return 0;
+}"
+SNPRINTF_OK)
+if(NOT SNPRINTF_OK)
+	add_compile_definitions(SNPRINTF_RETURNS_BOGUS)
+	list(APPEND compat_SOURCES compat/snprintf.c)
+endif()
+
+check_c_source_runs("
+#include<stdio.h>
+int
+main ()
+{
+	FILE *f = fopen(\".\", \"r\");
+	return f != NULL;
+
+	return 0;
+}"
+FREAD_READS_DIRECTORIES_NO)
+if(NOT FREAD_READS_DIRECTORIES_NO)
+	add_compile_definitions(FREAD_READS_DIRECTORIES)
+	list(APPEND compat_SOURCES compat/fopen.c)
+endif()
+
+check_c_source_compiles("
+#include <regex.h>
+#ifndef REG_STARTEND
+#error oops we dont have it
+#endif
+int main(){return 0;}"
+HAVE_REGEX)
+if(NOT HAVE_REGEX)
+	include_directories(${CMAKE_SOURCE_DIR}/compat/regex)
+	list(APPEND compat_SOURCES compat/regex/regex.c )
+	add_compile_definitions(NO_REGEX NO_MBSUPPORT GAWK)
+endif()
+
+
+check_c_source_compiles("
+#include <stddef.h>
+#include <sys/types.h>
+#include <sys/sysctl.h>
+
+int
+main ()
+{
+	int val, mib[2];
+	size_t len;
+
+	mib[0] = CTL_HW;
+	mib[1] = 1;
+	len = sizeof(val);
+	return sysctl(mib, 2, &val, &len, NULL, 0) ? 1 : 0;
+
+	return 0;
+}"
+HAVE_BSD_SYSCTL)
+if(HAVE_BSD_SYSCTL)
+	add_compile_definitions(HAVE_BSD_SYSCTL)
+endif()
+
+set(CMAKE_REQUIRED_LIBRARIES ${Iconv_LIBRARIES})
+set(CMAKE_REQUIRED_INCLUDES ${Iconv_INCLUDE_DIRS})
+
+check_c_source_compiles("
+#include <iconv.h>
+
+extern size_t iconv(iconv_t cd,
+		char **inbuf, size_t *inbytesleft,
+		char **outbuf, size_t *outbytesleft);
+
+int main(){return 0;}"
+HAVE_NEW_ICONV)
+if(HAVE_NEW_ICONV)
+	set(HAVE_OLD_ICONV 0)
+else()
+	set(HAVE_OLD_ICONV 1)
+endif()
+
+check_c_source_runs("
+#include <iconv.h>
+#if ${HAVE_OLD_ICONV}
+typedef const char *iconv_ibp;
+#else
+typedef char *iconv_ibp;
+#endif
+
+int main()
+{
+	int v;
+	iconv_t conv;
+	char in[] = \"a\"; iconv_ibp pin = in;
+	char out[20] = \"\"; char *pout = out;
+	size_t isz = sizeof in;
+	size_t osz = sizeof out;
+
+	conv = iconv_open(\"UTF-16\", \"UTF-8\");
+	iconv(conv, &pin, &isz, &pout, &osz);
+	iconv_close(conv);
+	v = (unsigned char)(out[0]) + (unsigned char)(out[1]);
+	return v != 0xfe + 0xff;
+}"
+ICONV_DOESNOT_OMIT_BOM)
+if(NOT ICONV_DOESNOT_OMIT_BOM)
+	add_compile_definitions(ICONV_OMITS_BOM)
+endif()
+
+unset(CMAKE_REQUIRED_LIBRARIES)
+unset(CMAKE_REQUIRED_INCLUDES)
+
+
+#programs
+set(PROGRAMS_BUILT
+	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
+	git-shell git-remote-testsvn git-credential-cache git-credential-cache--daemon)
+
+if(NOT CURL_FOUND)
+	list(APPEND excluded_progs git-http-fetch git-http-push)
+	add_compile_definitions(NO_CURL)
+	message(WARNING "git-http-push and git-http-fetch will not be built")
+else()
+	list(APPEND PROGRAMS_BUILT git-http-fetch git-http-push git-imap-send git-remote-http)
+	if(CURL_VERSION_STRING VERSION_GREATER_EQUAL 7.34.0)
+		add_compile_definitions(USE_CURL_FOR_IMAP_SEND)
+	endif()
+endif()
+
+if(NOT EXPAT_FOUND)
+	list(APPEND excluded_progs git-http-push)
+	add_compile_definitions(NO_EXPAT)
+else()
+	list(APPEND PROGRAMS_BUILT git-http-push)
+	if(EXPAT_VERSION_STRING VERSION_LESS_EQUAL 1.2)
+		add_compile_definitions(EXPAT_NEEDS_XMLPARSE_H)
+	endif()
+endif()
+
+list(REMOVE_DUPLICATES excluded_progs)
+list(REMOVE_DUPLICATES PROGRAMS_BUILT)
+
+
+foreach(p ${excluded_progs})
+	list(APPEND EXCLUSION_PROGS --exclude-program ${p} )
+endforeach()
+
+#for comparing null values
+list(APPEND EXCLUSION_PROGS empty)
+set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS} CACHE STRING "Programs not built" FORCE)
+
+if(NOT EXISTS ${CMAKE_BINARY_DIR}/command-list.h OR NOT EXCLUSION_PROGS_CACHE STREQUAL EXCLUSION_PROGS)
+	list(REMOVE_ITEM EXCLUSION_PROGS empty)
+	message("Generating command-list.h")
+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-cmdlist.sh ${EXCLUSION_PROGS} command-list.txt
+			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+			OUTPUT_FILE ${CMAKE_BINARY_DIR}/command-list.h)
+endif()
+
+if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
+	message("Generating config-list.h")
+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh
+			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+			OUTPUT_FILE ${CMAKE_BINARY_DIR}/config-list.h)
+endif()
+
+include_directories(${CMAKE_BINARY_DIR})
+
+#build
+#libgit
+parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
+
+list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
+
+#libxdiff
+parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
+
+list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+add_library(xdiff STATIC ${libxdiff_SOURCES})
+
+#libvcs-svn
+parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
+
+list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
+
+#link all required libraries to common-main
+add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
+target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES} pthread rt)
+if(Intl_FOUND)
+	target_link_libraries(common-main ${Intl_LIBRARIES})
+endif()
+if(Iconv_FOUND)
+	target_link_libraries(common-main ${Iconv_LIBRARIES})
+endif()
+
+#git
+parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
+
+list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
+target_link_libraries(git common-main)
+
+add_executable(git-bugreport ${CMAKE_SOURCE_DIR}/bugreport.c)
+target_link_libraries(git-bugreport common-main)
+
+add_executable(git-credential-store ${CMAKE_SOURCE_DIR}/credential-store.c)
+target_link_libraries(git-credential-store common-main)
+
+add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
+target_link_libraries(git-daemon common-main)
+
+add_executable(git-fast-import ${CMAKE_SOURCE_DIR}/fast-import.c)
+target_link_libraries(git-fast-import common-main)
+
+add_executable(git-http-backend ${CMAKE_SOURCE_DIR}/http-backend.c)
+target_link_libraries(git-http-backend common-main)
+
+add_executable(git-sh-i18n--envsubst ${CMAKE_SOURCE_DIR}/sh-i18n--envsubst.c)
+target_link_libraries(git-sh-i18n--envsubst common-main)
+
+add_executable(git-shell ${CMAKE_SOURCE_DIR}/shell.c)
+target_link_libraries(git-shell common-main)
+
+if(CURL_FOUND)
+	add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/http.c)
+
+	add_executable(git-imap-send ${CMAKE_SOURCE_DIR}/imap-send.c)
+	target_link_libraries(git-imap-send http_obj common-main ${CURL_LIBRARIES})
+
+	add_executable(git-http-fetch ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/http-fetch.c)
+	target_link_libraries(git-http-fetch http_obj common-main ${CURL_LIBRARIES})
+
+	add_executable(git-remote-http ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/remote-curl.c)
+	target_link_libraries(git-remote-http http_obj common-main ${CURL_LIBRARIES} )
+
+	if(EXPAT_FOUND)
+		add_executable(git-http-push ${CMAKE_SOURCE_DIR}/http-push.c)
+		target_link_libraries(git-http-push http_obj common-main ${CURL_LIBRARIES} ${EXPAT_LIBRARIES})
+	endif()
+endif()
+
+add_executable(git-remote-testsvn ${CMAKE_SOURCE_DIR}/remote-testsvn.c)
+target_link_libraries(git-remote-testsvn common-main vcs-svn)
+
+add_executable(git-credential-cache ${CMAKE_SOURCE_DIR}/credential-cache.c)
+target_link_libraries(git-credential-cache common-main)
+
+add_executable(git-credential-cache--daemon ${CMAKE_SOURCE_DIR}/credential-cache--daemon.c)
+target_link_libraries(git-credential-cache--daemon common-main)
+
+
+set(git_builtin_extra
+	cherry cherry-pick format-patch fsck-objects
+	init merge-subtree restore show
+	stage status switch whatchanged)
+
+#Creating hardlinks
+foreach(s ${git_SOURCES} ${git_builtin_extra})
+	string(REPLACE "${CMAKE_SOURCE_DIR}/builtin/" "" s ${s})
+	string(REPLACE ".c" "" s ${s})
+	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git git-${s})\n")
+	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s})
+endforeach()
+
+if(CURL_FOUND)
+	set(remote_exes
+		git-remote-https git-remote-ftp git-remote-ftps)
+	foreach(s ${remote_exes})
+		file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git-remote-http ${s})\n")
+		list(APPEND git_http_links ${CMAKE_BINARY_DIR}/${s})
+	endforeach()
+endif()
+
+add_custom_command(OUTPUT ${git_links} ${git_http_links}
+		COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/CreateLinks.cmake
+		DEPENDS git git-remote-http)
+add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
-- 
gitgitgadget

