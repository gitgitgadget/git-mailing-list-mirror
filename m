Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75141C433E3
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A056206BE
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NndPUzFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgFZQLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgFZQLr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 12:11:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4B5C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so1967758wrs.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dScyMjQFZqcxhEOGVIcscYScukm7u7/MxH57avyFXDg=;
        b=NndPUzFy8IH+vdD+LeLSC9nGQ4s154jh1fT3c6woah7UI6zJafy1wuVyiRfivCTtQK
         HAy0+ODxaLM4JpTq+wfqOS+s9qHvdRJIfzbCtKS1FHazvViR5dVnBcJzpFBiOcVeK740
         SjRpcOPd6z9HOMrU2w31XDNAAeyvkWTitl2kueq4GGGoTcUn1cottFvhIFa0TBWgzgc0
         k9Bg+oVXu0yRlgg3z6pds+J0NfT4fN8l9kBsOKxeb49BCmEvBfg/q4Urp2BSr+Laz6ll
         Xcy+lSax1xJChGqAvmUEoIn4vD/p5+uee5AV+ktAdrdqEQrweBz9tB+UZj9ARIdyIjyS
         jApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dScyMjQFZqcxhEOGVIcscYScukm7u7/MxH57avyFXDg=;
        b=omfAiQlx4o/J0s4xhhzbAtH42irT7nvKr4LfsNyLd2jCoZywZIsKuzgG8amiYJ0MqV
         j1r6bUHX1rS+eBBRGiZnAeA+uMcEDL/h9guu2wo+86GrUTsYZAnWcrg07hhMtdq31hrF
         XzaRDtCs/aSk+mUBRikcLLfCmtghXKqhhxTQ+RqZakv4BsKJWwxPwONcYK7rCquhsUiv
         Ze1ojV7kwc1qB5vIIhCv+C/umO4zmhSQ/ewpLyqowozNUtcuekbMPN+dQaIz2TXTGgec
         75QMnP2dPHU0bp55qgplsF5iZObT17r0v2Cmq0ZEsO1/KRnIrVZ2ie7wM4HdWd3bwctJ
         ZQVQ==
X-Gm-Message-State: AOAM530y1uchKorvy/Av0mUNEZMoHz2lrFZGBCh/Q9ewrKCXdiiJa+QQ
        qqRWthrLRjDE0eOzmg1UuXrMZd2m
X-Google-Smtp-Source: ABdhPJzKpeFmQiOrBn7EXtp+OP7W8hiJnbLQVnBqF1mxBrfjGRVelh/B8+rLK/k9Q+3OocIPzaXSYw==
X-Received: by 2002:adf:f8d1:: with SMTP id f17mr4558833wrq.59.1593187905818;
        Fri, 26 Jun 2020 09:11:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z25sm17194265wmk.28.2020.06.26.09.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 09:11:45 -0700 (PDT)
Message-Id: <10acdbf5e4d4c49f69889ab1129d3d6b5a7fd754.1593187898.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
References: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
        <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 16:11:36 +0000
Subject: [PATCH v5 6/8] cmake: support for building git on windows with mingw
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

This patch facilitates building git on Windows with CMake using MinGW

NOTE: The funtions unsetenv and hstrerror are not checked in Windows
builds.
Reasons
NO_UNSETENV is not compatible with Windows builds.
lines 262-264 compat/mingw.h

compat/mingw.h(line 25) provides a definition of hstrerror which
conflicts with the definition provided in
git-compat-util.h(lines 733-736).

To use CMake on Windows with MinGW do this:
cmake `relative-path-to-srcdir` -G "MinGW Makefiles"

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 117 ++++++++++++++++++++++------
 1 file changed, 94 insertions(+), 23 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2768ee5b71..2d7c0ed88e 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -42,6 +42,10 @@ cmake_minimum_required(VERSION 3.14)
 set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
 
 find_program(SH_EXE sh)
+if(NOT SH_EXE)
+	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
+			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
+endif()
 
 #Create GIT-VERSION-FILE using GIT-VERSION-GEN
 if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
@@ -65,7 +69,9 @@ project(git
 	VERSION ${git_version}
 	LANGUAGES C)
 
+
 #TODO gitk git-gui gitweb
+#TODO Enable NLS on windows natively
 #TODO Add pcre support
 
 #macros for parsing the Makefile for sources and scripts
@@ -104,6 +110,7 @@ find_package(EXPAT)
 find_package(Iconv)
 find_package(Intl)
 
+
 if(NOT Intl_FOUND)
 	add_compile_definitions(NO_GETTEXT)
 	if(NOT Iconv_FOUND)
@@ -125,6 +132,14 @@ if(Intl_FOUND)
 	include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
 endif()
 
+
+if(WIN32)
+	find_program(WINDRES_EXE windres)
+	if(NOT WINDRES_EXE)
+		message(FATAL_ERROR "Install windres on Windows for resource files")
+	endif()
+endif()
+
 find_program(MSGFMT_EXE msgfmt)
 if(NOT MSGFMT_EXE)
 	message(WARNING "Text Translations won't be build")
@@ -156,11 +171,35 @@ add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
 			BINDIR="bin"
 			GIT_BUILT_FROM_COMMIT="")
 
-set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
-add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
+if(WIN32)
+	set(FALLBACK_RUNTIME_PREFIX /mingw64)
+	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
+else()
+	set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
+	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
+endif()
+
+
+#Platform Specific
+if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+	include_directories(${CMAKE_SOURCE_DIR}/compat/win32)
+	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
+				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
+				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
+				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
+				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
+	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
+		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
+		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
+		compat/nedmalloc/nedmalloc.c compat/strdup.c)
+	set(NO_UNIX_SOCKETS 1)
+
+elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
+	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
+	list(APPEND compat_SOURCES unix-socket.c)
+endif()
 
-add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
-list(APPEND compat_SOURCES unix-socket.c)
+set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
 
 #header checks
 check_include_file(libgen.h HAVE_LIBGEN_H)
@@ -223,7 +262,12 @@ endif()
 #function checks
 set(function_checks
 	strcasestr memmem strlcpy strtoimax strtoumax strtoull
-	setenv mkdtemp poll pread memmem unsetenv hstrerror)
+	setenv mkdtemp poll pread memmem)
+
+#unsetenv,hstrerror are incompatible with windows build
+if(NOT WIN32)
+	list(APPEND function_checks unsetenv hstrerror)
+endif()
 
 foreach(f ${function_checks})
 	string(TOUPPER ${f} uf)
@@ -444,7 +488,13 @@ unset(CMAKE_REQUIRED_INCLUDES)
 #programs
 set(PROGRAMS_BUILT
 	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
-	git-shell git-remote-testsvn git-credential-cache git-credential-cache--daemon)
+	git-shell git-remote-testsvn)
+
+if(NO_UNIX_SOCKETS)
+	list(APPEND excluded_progs git-credential-cache git-credential-cache--daemon)
+else()
+	list(APPEND PROGRAMS_BUILT git-credential-cache git-credential-cache--daemon)
+endif()
 
 if(NOT CURL_FOUND)
 	list(APPEND excluded_progs git-http-fetch git-http-push)
@@ -516,15 +566,34 @@ parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
 list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
 
+#add git.rc for gcc
+if(WIN32)
+	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
+			COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
+				-DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
+				-i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
+			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+			VERBATIM)
+	add_custom_target(git-rc DEPENDS ${CMAKE_BINARY_DIR}/git.res)
+endif()
+
 #link all required libraries to common-main
 add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
-target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES} pthread rt)
+
+target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
 if(Intl_FOUND)
 	target_link_libraries(common-main ${Intl_LIBRARIES})
 endif()
 if(Iconv_FOUND)
 	target_link_libraries(common-main ${Iconv_LIBRARIES})
 endif()
+if(WIN32)
+	target_link_libraries(common-main ws2_32 ntdll ${CMAKE_BINARY_DIR}/git.res)
+	add_dependencies(common-main git-rc)
+	target_link_options(common-main PUBLIC -municode -Wl,--nxcompat -Wl,--dynamicbase -Wl,--pic-executable,-e,mainCRTStartup)
+elseif(UNIX)
+	target_link_libraries(common-main pthread rt)
+endif()
 
 #git
 parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
@@ -575,11 +644,13 @@ endif()
 add_executable(git-remote-testsvn ${CMAKE_SOURCE_DIR}/remote-testsvn.c)
 target_link_libraries(git-remote-testsvn common-main vcs-svn)
 
-add_executable(git-credential-cache ${CMAKE_SOURCE_DIR}/credential-cache.c)
-target_link_libraries(git-credential-cache common-main)
+if(NOT NO_UNIX_SOCKETS)
+	add_executable(git-credential-cache ${CMAKE_SOURCE_DIR}/credential-cache.c)
+	target_link_libraries(git-credential-cache common-main)
 
-add_executable(git-credential-cache--daemon ${CMAKE_SOURCE_DIR}/credential-cache--daemon.c)
-target_link_libraries(git-credential-cache--daemon common-main)
+	add_executable(git-credential-cache--daemon ${CMAKE_SOURCE_DIR}/credential-cache--daemon.c)
+	target_link_libraries(git-credential-cache--daemon common-main)
+endif()
 
 
 set(git_builtin_extra
@@ -591,16 +662,16 @@ set(git_builtin_extra
 foreach(s ${git_SOURCES} ${git_builtin_extra})
 	string(REPLACE "${CMAKE_SOURCE_DIR}/builtin/" "" s ${s})
 	string(REPLACE ".c" "" s ${s})
-	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git git-${s})\n")
-	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s})
+	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git${EXE_EXTENSION} git-${s}${EXE_EXTENSION})\n")
+	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s}${EXE_EXTENSION})
 endforeach()
 
 if(CURL_FOUND)
 	set(remote_exes
 		git-remote-https git-remote-ftp git-remote-ftps)
 	foreach(s ${remote_exes})
-		file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git-remote-http ${s})\n")
-		list(APPEND git_http_links ${CMAKE_BINARY_DIR}/${s})
+		file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git-remote-http${EXE_EXTENSION} ${s}${EXE_EXTENSION})\n")
+		list(APPEND git_http_links ${CMAKE_BINARY_DIR}/${s}${EXE_EXTENSION})
 	endforeach()
 endif()
 
@@ -722,20 +793,20 @@ set(bin_links
 	git-receive-pack git-upload-archive git-upload-pack)
 
 foreach(b ${bin_links})
-install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/bin/${b})")
+install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/bin/${b}${EXE_EXTENSION})")
 endforeach()
 
-install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git)")
-install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-shell)")
+install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git${EXE_EXTENSION})")
+install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-shell${EXE_EXTENSION})")
 
 foreach(b ${git_links})
 	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
-	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
+	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b}${EXE_EXTENSION})")
 endforeach()
 
 foreach(b ${git_http_links})
 	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
-	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
+	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b}${EXE_EXTENSION})")
 endforeach()
 
 install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
@@ -784,14 +855,14 @@ set(wrapper_test_scripts
 foreach(script ${wrapper_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
-	string(REPLACE "@@PROG@@" "${script}" content "${content}")
+	string(REPLACE "@@PROG@@" "${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
 foreach(script ${wrapper_test_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
-	string(REPLACE "@@PROG@@" "t/helper/${script}" content "${content}")
+	string(REPLACE "@@PROG@@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
@@ -857,7 +928,7 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PAGER_ENV='${PAGER_ENV}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DC_SHA1='${DC_SHA1}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X=''\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
-- 
gitgitgadget

