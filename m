Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52679CA90AF
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F9820720
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS653kLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgELQvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgELQvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:51:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7D5C061A0F
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w19so9489760wmc.1
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4iKZYsq4YTDcYvnqHIsAb+eqjsQE3UwvEBogppE4+18=;
        b=DS653kLanQ+UlinJxPNJXLNU8q4KNAQwGh2x99kBA4M/SSpK1GldTfmuqxBqkHaQCE
         wEOXYo2bqHx1SQEu7gjK0AyyzYs28DK7XXoG69Gd9qPZu88UZ9d+DQ9ZPkyD4/jxhwUX
         XNmJroY8+YwW7fsSEn5NkeBYqXLbqB0OymRYFM2PVL7waP6hAQeKsC2GtbJV+4TFluos
         T9MnbBohH07vKRqEoWshKq0k4+R4pJma+U78jWf9XgePfYcYZ68HV5TeFHnKw+wH7eLH
         b1F4SWPUAX/034kJaUzfOkbo7OTFqt9V3jYnFBcC6eoDdDBKVnZ/OGXFlAIGxJo0+7F8
         KbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4iKZYsq4YTDcYvnqHIsAb+eqjsQE3UwvEBogppE4+18=;
        b=HiVYzI/bwoaTW+yUHIYLsBiUA8ghSpNkCCAzXescOYD4csTmbBUebeIEHk/1jAHhze
         QZFuwYK6TlSOMCu6eSakmGCpVNztq3Hlf7c7EU2mTc7C+0W7GyZYd8b3+dc1k840gFu8
         mvqLJrX5ggYwWSJ3IzGpilKAEBxF9K22uJPf68OksYmJCpG2SjDkv1xupwq1eRIBv9ZP
         I6mD+HYJ3j0JDyhOWz3BXJigeTzPZ+su3rw3aECqjB6Q8/XiYYM1PsUfwmU2Gm6VB+i5
         M4FKDK8/Rc6+g7/tEi4FAGBOaQtgX+T9JVSaZtulHHXOJh9WuPj+Tvd/qptNBtT3Lwod
         UJKg==
X-Gm-Message-State: AGi0PuYv3RPcb4/lxpD2AH74IU4a8+TwTah8HRteio2un3o2xpBZbMUb
        uY9EtrIRViMOcTpZsn2tzVzvXdcb
X-Google-Smtp-Source: APiQypLyaZCn/50BHlsYcXpmmJcN8BBBq8Qk0gveSy5E2pHHnvDt6u9dFx3xIs3gnPI0Ll23xQL1kQ==
X-Received: by 2002:a1c:3bc5:: with SMTP id i188mr27575990wma.90.1589302262416;
        Tue, 12 May 2020 09:51:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7sm20869180wrq.39.2020.05.12.09.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:51:01 -0700 (PDT)
Message-Id: <af6c606881d73cac2cf10f165327462e75efb9d8.1589302254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:50:50 +0000
Subject: [PATCH v2 07/11] cmake: support for building git on windows with msvc
 and clang.
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

This patch adds support for Visual Studio and Clang builds

The minimum required version of CMake is upgraded to 3.15 because
this version offers proper support for Clang builds on Windows.

Libintl is not searched for when building with Visual Studio or Clang
because there is no binary compatible version available yet.

NOTE: In the link options invalidcontinue.obj has to be included.
The reason for this is because by default, Windows calls abort()'s
instead of setting errno=EINVAL when invalid arguments are passed to
standard functions.
This commit explains it in detail:
4b623d80f73528a632576990ca51e34c333d5dd6

On Windows the default generator is Visual Studio,so for Visual Studio
builds do this:

cmake `relative-path-to-srcdir`

NOTE: Visual Studio generator is a multi config generator, which means
that Debug and Release builds can be done on the same build directory.

For Clang builds do this:

On bash
CC=Clang cmake `relative-path-to-srcdir` -G Ninja
		-DCMAKE_BUILD_TYPE=[Debug or Release]

On cmd
set CC=Clang
cmake `relative-path-to-srcdir` -G Ninja
		-DCMAKE_BUILD_TYPE=[Debug or Release]

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 CMakeLists.txt | 57 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9625e41886f..4353080b708 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -2,7 +2,7 @@
 #	Copyright (c) 2020 Sibi Siddharthan
 #
 
-cmake_minimum_required(VERSION 3.14)
+cmake_minimum_required(VERSION 3.15)
 
 #Parse GIT-VERSION-GEN to get the version
 file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN git_version REGEX "DEF_VER=v(.*)")
@@ -32,8 +32,11 @@ find_package(ZLIB REQUIRED)
 find_package(CURL)
 find_package(EXPAT)
 find_package(Iconv)
-find_package(Intl)
 
+#Don't use libintl on Windows Visual Studio and Clang builds
+if(NOT (WIN32 AND (CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")))
+	find_package(Intl)
+endif()
 
 if(NOT Intl_FOUND)
 	add_compile_definitions(NO_GETTEXT)
@@ -62,7 +65,7 @@ if(NOT SH_EXE)
 			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
 endif()
 
-if(WIN32)
+if(WIN32 AND NOT MSVC)#not required for visual studio builds
 	find_program(WINDRES_EXE windres)
 	if(NOT WINDRES_EXE)
 		message(FATAL_ERROR "Install windres on Windows for resource files")
@@ -74,6 +77,13 @@ if(NOT MSGFMT_EXE)
 	message(WARNING "Text Translations won't be build")
 endif()
 
+#Force all visual studio outputs to CMAKE_BINARY_DIR
+if(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
+	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})
+	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
+	add_compile_options(/MP)
+endif()
+
 #default behaviour
 include_directories(${CMAKE_SOURCE_DIR})
 add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
@@ -111,6 +121,10 @@ endif()
 
 #Platform Specific
 if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
+	if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
+		include_directories(compat/vcbuild/include)
+		add_compile_definitions(_CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_DEPRECATE)
+	endif()
 	include_directories(compat/win32)
 	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
@@ -464,14 +478,22 @@ set(libvcs-svn_SOURCES
 	vcs-svn/svndiff.c vcs-svn/svndump.c)
 add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
 
-#add git.rc for gcc
 if(WIN32)
-	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
-			COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
-				-DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
-				-i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
-			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
-			VERBATIM)
+	if(NOT MSVC)#use windres when compiling with gcc and clang
+		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
+				COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
+					-DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
+					-i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
+				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+				VERBATIM)
+	else()#MSVC use rc
+		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
+				COMMAND ${CMAKE_RC_COMPILER} /d MAJOR=${PROJECT_VERSION_MAJOR} /d MINOR=${PROJECT_VERSION_MINOR}
+					/d MICRO=${PROJECT_VERSION_PATCH} /d PATCHLEVEL=0 /d GIT_VERSION="${PROJECT_VERSION}.GIT"
+					/fo ${CMAKE_BINARY_DIR}/git.res ${CMAKE_SOURCE_DIR}/git.rc
+				WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+				VERBATIM)
+	endif()
 	add_custom_target(git-rc DEPENDS ${CMAKE_BINARY_DIR}/git.res)
 endif()
 
@@ -488,7 +510,13 @@ endif()
 if(WIN32)
 	target_link_libraries(common-main ws2_32 ntdll ${CMAKE_BINARY_DIR}/git.res)
 	add_dependencies(common-main git-rc)
-	target_link_options(common-main PUBLIC -municode -Wl,--nxcompat -Wl,--dynamicbase -Wl,--pic-executable,-e,mainCRTStartup)
+	if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
+		target_link_options(common-main PUBLIC -municode -Wl,--nxcompat -Wl,--dynamicbase -Wl,--pic-executable,-e,mainCRTStartup)
+	elseif(CMAKE_C_COMPILER_ID STREQUAL "Clang")
+		target_link_options(common-main PUBLIC -municode -Wl,-nxcompat -Wl,-dynamicbase -Wl,-entry:wmainCRTStartup -Wl,invalidcontinue.obj)
+	elseif(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
+		target_link_options(common-main PUBLIC /IGNORE:4217 /IGNORE:4049 /NOLOGO /ENTRY:wmainCRTStartup /SUBSYSTEM:CONSOLE invalidcontinue.obj)
+	endif()
 elseif(UNIX)
 	target_link_libraries(common-main pthread rt)
 endif()
@@ -798,6 +826,13 @@ target_link_libraries(test-tool common-main)
 set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
 			PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/helper)
 
+if(MSVC)
+	set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
+				PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
+	set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
+				PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
+endif()
+
 #wrapper scripts
 set(wrapper_scripts
 	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext)
-- 
gitgitgadget

