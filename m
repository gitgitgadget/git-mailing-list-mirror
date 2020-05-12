Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D50C2D0F7
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E4120720
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4CXXhb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgELQvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgELQvG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:51:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECAAC05BD0A
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so10449816wru.0
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZN/3phHujoltkVy6Vug9RWuCYu+ocbOn2U7qyoOzjsM=;
        b=A4CXXhb5XT6l5M+zV77M5Ynq19fPESAXl0j6MPkbPz1ndWoV0wMc3iy0S5aheAuy2b
         ir2F8GBqtuIa9ztXNs2I3zCQa1J0GyyJYgVnyY4h3z4Wnql74XT6WqBfOYsfAHtE9tuD
         U4whGFpSJ3NwSXOohfd460xD/j0pGC71IpjKBH0OoEhnP2BuoVj1LTXXqcNkoX5+Xoqk
         kXinJfBY3KWgZmRfu5qE0W754vuRaidan/2EKeIdZpC7+uz7cLd62yS+naCOiVyubLcE
         T40xe/G/ayETwc7c2bDS/tzwTNDYYRqjk8+8EdmHRJSWMLP5IQdnbWsHdHRtKmkyq1Xw
         jlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZN/3phHujoltkVy6Vug9RWuCYu+ocbOn2U7qyoOzjsM=;
        b=FM3KO1ZnY/0K6y5zXfOvCf+3kyH/o83K3aji8ZHAJ+i6aBwsk/8Qp8FFFs28t0KeD3
         IPzzrUbGcwaggzBaOnU9Q0KeNY5lOMrBDmAYHAE6ZvCjTuODEcHCVed2Uyk8o/c3FtnT
         hqyuPrhzzd3bmCRcGPM+MV7iZk47Kym+4IhYPmZq3BknPT0nCLgUdfGe/NTu5wi0Fnvh
         wn1rv+k/IUjCWsulQY/4nX7u/Fz5FCoKfXZjeT2lDHzVaE9iCqsI7NxXjBfugmeenlVN
         QZwxQBsB1PlogtzOxqRwywmwlYwHQlmWtha7LYIijJN/CSTxl9caqB68GyTRslu21ovT
         3VzA==
X-Gm-Message-State: AGi0PuY5IDEdhVmoX6L1zFm2YYV2041wl6e1I4E/qDW+O8I7mJ19iBGa
        fCFgvuuQMViLMkXMv0oIf5OzRGqG
X-Google-Smtp-Source: APiQypIu9aAAdBkDCjKYn/Z1MEYUpNU5LC4dL1ZUnVoRnOqfboG4Eds7/Q5iwTXdlmJYkUfr5mYFXw==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr24657717wrq.136.1589302263961;
        Tue, 12 May 2020 09:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x5sm24827356wro.12.2020.05.12.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:51:03 -0700 (PDT)
Message-Id: <9c674372fb58aa42e339c0a96c432283c4b0a894.1589302255.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:50:52 +0000
Subject: [PATCH v2 09/11] cmake: relocated script file contrib/buildsystems
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

The CMake script has been relocated to contrib/buildsystems.
The changes made to the script involves pointing to correct location
of the source files.

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 .../buildsystems/CMakeLists.txt               | 76 +++++++++++--------
 1 file changed, 45 insertions(+), 31 deletions(-)
 rename CMakeLists.txt => contrib/buildsystems/CMakeLists.txt (92%)

diff --git a/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
similarity index 92%
rename from CMakeLists.txt
rename to contrib/buildsystems/CMakeLists.txt
index 975791c8b89..e0ce069dc2a 100644
--- a/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -4,6 +4,9 @@
 
 cmake_minimum_required(VERSION 3.15)
 
+#set the source directory to root of git
+set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
+
 #Parse GIT-VERSION-GEN to get the version
 file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN git_version REGEX "DEF_VER=v(.*)")
 string(REPLACE "DEF_VER=v" "" git_version ${git_version})
@@ -123,10 +126,10 @@ endif()
 #Platform Specific
 if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
 	if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
-		include_directories(compat/vcbuild/include)
+		include_directories(${CMAKE_SOURCE_DIR}/compat/vcbuild/include)
 		add_compile_definitions(_CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_DEPRECATE)
 	endif()
-	include_directories(compat/win32)
+	include_directories(${CMAKE_SOURCE_DIR}/compat/win32)
 	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
@@ -224,7 +227,7 @@ foreach(f ${function_checks})
 endforeach()
 
 if(NOT HAVE_POLL_H OR NOT HAVE_SYS_POLL_H OR NOT HAVE_POLL)
-	include_directories(compat/poll)
+	include_directories(${CMAKE_SOURCE_DIR}/compat/poll)
 	add_compile_definitions(NO_POLL)
 	list(APPEND compat_SOURCES compat/poll/poll.c)
 endif()
@@ -345,7 +348,7 @@ check_c_source_compiles("
 int main(){return 0;}"
 HAVE_REGEX)
 if(NOT HAVE_REGEX)
-	include_directories(compat/regex )
+	include_directories(${CMAKE_SOURCE_DIR}/compat/regex)
 	list(APPEND compat_SOURCES compat/regex/regex.c )
 	add_compile_definitions(NO_REGEX NO_MBSUPPORT GAWK)
 endif()
@@ -467,21 +470,23 @@ endforeach()
 list(APPEND EXCLUSION_PROGS empty)
 set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS} CACHE STRING "Programs not built" FORCE)
 
-if(NOT EXISTS ${CMAKE_SOURCE_DIR}/command-list.h OR NOT EXCLUSION_PROGS_CACHE STREQUAL EXCLUSION_PROGS)
+if(NOT EXISTS ${CMAKE_BINARY_DIR}/command-list.h OR NOT EXCLUSION_PROGS_CACHE STREQUAL EXCLUSION_PROGS)
 	list(REMOVE_ITEM EXCLUSION_PROGS empty)
 	message("Generating command-list.h")
 	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-cmdlist.sh ${EXCLUSION_PROGS} command-list.txt
 			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
-			OUTPUT_FILE ${CMAKE_SOURCE_DIR}/command-list.h)
+			OUTPUT_FILE ${CMAKE_BINARY_DIR}/command-list.h)
 endif()
 
-if(NOT EXISTS ${CMAKE_SOURCE_DIR}/config-list.h)
+if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
 	message("Generating config-list.h")
 	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh
 			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
-			OUTPUT_FILE ${CMAKE_SOURCE_DIR}/config-list.h)
+			OUTPUT_FILE ${CMAKE_BINARY_DIR}/config-list.h)
 endif()
 
+include_directories(${CMAKE_BINARY_DIR})
+
 
 #build
 set(libgit_SOURCES
@@ -521,16 +526,22 @@ set(libgit_SOURCES
 	worktree.c wrapper.c write-or-die.c ws.c wt-status.c xdiff-interface.c
 	zlib.c)
 
+list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
 
 set(libxdiff_SOURCES
 	xdiff/xdiffi.c xdiff/xprepare.c xdiff/xutils.c xdiff/xemit.c
 	xdiff/xmerge.c xdiff/xpatience.c xdiff/xhistogram.c)
+
+list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(xdiff STATIC ${libxdiff_SOURCES})
 
 set(libvcs-svn_SOURCES
 	vcs-svn/line_buffer.c vcs-svn/sliding_window.c vcs-svn/fast_export.c
 	vcs-svn/svndiff.c vcs-svn/svndump.c)
+
+list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
 
 if(WIN32)
@@ -553,7 +564,7 @@ if(WIN32)
 endif()
 
 #link all required libraries to common-main
-add_library(common-main OBJECT common-main.c)
+add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
 
 target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
 if(Intl_FOUND)
@@ -612,56 +623,57 @@ set(git_SOURCES
 	builtin/upload-pack.c builtin/var.c builtin/verify-commit.c builtin/verify-pack.c
 	builtin/verify-tag.c builtin/worktree.c builtin/write-tree.c)
 
-add_executable(git git.c ${git_SOURCES})
+list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
 target_link_libraries(git common-main )
 
-add_executable(git-bugreport bugreport.c)
+add_executable(git-bugreport ${CMAKE_SOURCE_DIR}/bugreport.c)
 target_link_libraries(git-bugreport common-main)
 
-add_executable(git-credential-store credential-store.c)
+add_executable(git-credential-store ${CMAKE_SOURCE_DIR}/credential-store.c)
 target_link_libraries(git-credential-store common-main)
 
-add_executable(git-daemon daemon.c)
+add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
 target_link_libraries(git-daemon common-main)
 
-add_executable(git-fast-import fast-import.c)
+add_executable(git-fast-import ${CMAKE_SOURCE_DIR}/fast-import.c)
 target_link_libraries(git-fast-import common-main)
 
-add_executable(git-http-backend http-backend.c)
+add_executable(git-http-backend ${CMAKE_SOURCE_DIR}/http-backend.c)
 target_link_libraries(git-http-backend common-main)
 
-add_executable(git-sh-i18n--envsubst sh-i18n--envsubst.c)
+add_executable(git-sh-i18n--envsubst ${CMAKE_SOURCE_DIR}/sh-i18n--envsubst.c)
 target_link_libraries(git-sh-i18n--envsubst common-main)
 
-add_executable(git-shell shell.c)
+add_executable(git-shell ${CMAKE_SOURCE_DIR}/shell.c)
 target_link_libraries(git-shell common-main)
 
 if(CURL_FOUND)
-	add_library(http_obj OBJECT http.c)
+	add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/http.c)
 
-	add_executable(git-imap-send imap-send.c)
+	add_executable(git-imap-send ${CMAKE_SOURCE_DIR}/imap-send.c)
 	target_link_libraries(git-imap-send http_obj common-main ${CURL_LIBRARIES})
 
-	add_executable(git-http-fetch http-walker.c http-fetch.c)
+	add_executable(git-http-fetch ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/http-fetch.c)
 	target_link_libraries(git-http-fetch http_obj common-main ${CURL_LIBRARIES})
 
-	add_executable(git-remote-http http-walker.c remote-curl.c)
+	add_executable(git-remote-http ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/remote-curl.c)
 	target_link_libraries(git-remote-http http_obj common-main ${CURL_LIBRARIES} )
 
 	if(EXPAT_FOUND)
-		add_executable(git-http-push http-push.c)
+		add_executable(git-http-push ${CMAKE_SOURCE_DIR}/http-push.c)
 		target_link_libraries(git-http-push http_obj common-main ${CURL_LIBRARIES} ${EXPAT_LIBRARIES})
 	endif()
 endif()
 
-add_executable(git-remote-testsvn remote-testsvn.c)
+add_executable(git-remote-testsvn ${CMAKE_SOURCE_DIR}/remote-testsvn.c)
 target_link_libraries(git-remote-testsvn common-main vcs-svn)
 
 if(NOT NO_UNIX_SOCKETS)
-	add_executable(git-credential-cache credential-cache.c)
+	add_executable(git-credential-cache ${CMAKE_SOURCE_DIR}/credential-cache.c)
 	target_link_libraries(git-credential-cache common-main)
 
-	add_executable(git-credential-cache--daemon credential-cache--daemon.c)
+	add_executable(git-credential-cache--daemon ${CMAKE_SOURCE_DIR}/credential-cache--daemon.c)
 	target_link_libraries(git-credential-cache--daemon common-main)
 endif()
 
@@ -673,7 +685,7 @@ set(git_builtin_extra
 
 #Creating hardlinks
 foreach(s ${git_SOURCES} ${git_builtin_extra})
-	string(REPLACE "builtin/" "" s ${s})
+	string(REPLACE "${CMAKE_SOURCE_DIR}/builtin/" "" s ${s})
 	string(REPLACE ".c" "" s ${s})
 	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git${EXE_EXTENSION} git-${s}${EXE_EXTENSION})\n")
 	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s}${EXE_EXTENSION})
@@ -831,7 +843,7 @@ endforeach()
 install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
 	DESTINATION libexec/git-core)
 
-install(DIRECTORY mergetools DESTINATION libexec/git-core)
+install(DIRECTORY ${CMAKE_SOURCE_DIR}/mergetools DESTINATION libexec/git-core)
 install(DIRECTORY ${CMAKE_BINARY_DIR}/perl/build/lib/ DESTINATION share/perl5
 	FILES_MATCHING PATTERN "*.pm")
 install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/templates)
@@ -844,13 +856,13 @@ endif()
 if(BUILD_TESTING)
 
 #tests-helpers
-add_executable(test-fake-ssh t/helper/test-fake-ssh.c)
+add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
 target_link_libraries(test-fake-ssh common-main)
 
-add_executable(test-line-buffer t/helper/test-line-buffer.c)
+add_executable(test-line-buffer ${CMAKE_SOURCE_DIR}/t/helper/test-line-buffer.c)
 target_link_libraries(test-line-buffer common-main vcs-svn)
 
-add_executable(test-svn-fe t/helper/test-svn-fe.c)
+add_executable(test-svn-fe ${CMAKE_SOURCE_DIR}/t/helper/test-svn-fe.c)
 target_link_libraries(test-svn-fe common-main vcs-svn)
 
 set(test-tool_SOURCES
@@ -875,6 +887,7 @@ set(test-tool_SOURCES
 	t/helper/test-trace2.c t/helper/test-urlmatch-normalization.c t/helper/test-xml-encode.c
 	t/helper/test-wildmatch.c t/helper/test-windows-named-pipe.c t/helper/test-write-cache.c)
 
+list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_executable(test-tool ${test-tool_SOURCES})
 target_link_libraries(test-tool common-main)
 
@@ -978,7 +991,8 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PRE
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
 
 #Make the tests work when building out of the source tree
-if(NOT ${CMAKE_BINARY_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
+get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
+if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
 	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
 	#Setting the build directory in test-lib.sh before running tests
-- 
gitgitgadget

