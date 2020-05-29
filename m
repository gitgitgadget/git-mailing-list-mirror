Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6AAC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A94206E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3hmS5p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgE2Nki (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 09:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgE2Nke (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 09:40:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B943C08C5C9
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so3709253wrp.2
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fIr98H2ooWMe5BwCNQ3Z5eX/C8HIYDp0M8dOeXncG9A=;
        b=V3hmS5p8kCD3sNyxPygvlKTdzZsQsBhmHRx75XVb2YTcIlP45Il3PcivAAkcUKT+fB
         4f6F0KN3JFWG9c1NOjXb3A/Xjhcw1EZYmRz/ZL1tGkxxx+54GgYTv3oqffZd0y/0FPFe
         cJm7Gg1YmzNATRmyA7MdWTplBmA6yaeszHe1B0Wnead6IbGZ1weiiQ6wLYx3qfw6skH8
         KnV3Y/xOfle5DUg/roiS0HpNPF0wt5BZMnXsAIxco1YjMDy3gMk7KiFUEStJ0wlPapfz
         palqHc2+wcEzTVIEmSxBSIYyQ5fpuydkExpGBEr1necAvUkObalx/6K3D48RkRgOUAEV
         iY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fIr98H2ooWMe5BwCNQ3Z5eX/C8HIYDp0M8dOeXncG9A=;
        b=OA3sifRXUOC6MOrzkPNNSvNXNs3UnuWYcGcC01We7bcwqk5VSnZQJaKeFW1YLdYttS
         YfoyREwKoZ0Tg8tsatUuHGyn1ZjzD+bf73X9sKA8FfKNrmN/RB6EHUXJGQQ76lkZExbF
         m4gRbohC8jYBQtescNJVS+abqNYquYJZlLKpw7hC9tFXoUiewDvEz0qLn7Jc+a69+bYj
         b9k0lUb62dDQ2GVZy97kGdRi/b1/Y9opOBsmw14k/cu2Q/Ge+mMoKTQupey++wMRnQ6Y
         JaJHvneeJROpYQMv1A/umJc6Yzb6CbCFsF2TfXLzcqYlGxo0U9KRLwYRzmBILWnKS2Bt
         +Zww==
X-Gm-Message-State: AOAM531GSWksd8T5V7QZUUfTMLUWyLMdY1xVh9TVB+dt+XAA2tuVh5+x
        PYmfWRww+d95E19IeIEUP5luLr7W
X-Google-Smtp-Source: ABdhPJxo6yellzmvFsOTWytHHAjGRBmZxFgK7e4GCV2qI35X7e64o4UkxxrKmTShWy2XrCOxwJvGeA==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr8394369wrs.234.1590759632602;
        Fri, 29 May 2020 06:40:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 138sm4245533wma.23.2020.05.29.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:40:32 -0700 (PDT)
Message-Id: <8f36e30cd2218fa56fb0c2b89f6f51726b0eb285.1590759624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 May 2020 13:40:23 +0000
Subject: [PATCH v3 7/8] cmake: support for building git on windows with msvc
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
 contrib/buildsystems/CMakeLists.txt | 55 +++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 46197d0b806..0a3f711db88 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -98,8 +98,11 @@ find_package(ZLIB REQUIRED)
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
@@ -123,7 +126,7 @@ if(Intl_FOUND)
 endif()
 
 
-if(WIN32)
+if(WIN32 AND NOT MSVC)#not required for visual studio builds
 	find_program(WINDRES_EXE windres)
 	if(NOT WINDRES_EXE)
 		message(FATAL_ERROR "Install windres on Windows for resource files")
@@ -135,6 +138,13 @@ if(NOT MSGFMT_EXE)
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
@@ -172,6 +182,10 @@ endif()
 
 #Platform Specific
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+	if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
+		include_directories(${CMAKE_SOURCE_DIR}/compat/vcbuild/include)
+		add_compile_definitions(_CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_DEPRECATE)
+	endif()
 	include_directories(${CMAKE_SOURCE_DIR}/compat/win32)
 	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
@@ -551,14 +565,22 @@ parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
 list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
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
 
@@ -575,7 +597,13 @@ endif()
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
@@ -831,6 +859,13 @@ target_link_libraries(test-tool common-main)
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

