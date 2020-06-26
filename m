Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85B8C433E2
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08A820791
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLOqluSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgFZQLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgFZQLs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 12:11:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03874C03E97A
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so9187375wmm.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VzwJd7/3jVM4lKFgqpyfetM4aIT2T8ER/Nj9Kr3MMrI=;
        b=oLOqluSx25o+tAIcCViL5nSICrWKmoR5faGID6hT6XVPDcbteTrEw1RVaLqQHI0aId
         bUTK8OQZR8YcHBR+EuSm60qUfu4VGmQxpZnHtpb0JCoHL/rV1ee59PDv34fYrinTs7cG
         S74Ik5M/ya5Tc0SNpqFWX+7H/bzjegnghVUh45dZIZY199aTInuwLEn86cokoGIrGMfJ
         hyYZSdXVFmd5D1vfX87KOJ5X32HAEEga6i67OgeRrk+73I9yvURWPkpeWg6cUlEAIk+V
         xVcRo1FR2zJGfvlIoV61ltYD95uNPBE/U8lA50hLDI4r7Oao9PEA9coKnAkTTxJMQcDB
         BL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VzwJd7/3jVM4lKFgqpyfetM4aIT2T8ER/Nj9Kr3MMrI=;
        b=Fs6oce2c5lH4Ni7zjHylJPxGzdrcw2cBlbi3prfrXRwNwgg4HoQZiGJs6AjmEd1fdq
         K9/n4rmU/s7hi4MOGJl/P/QbJgPr3oh4lE8Z1I0OBZyeiSECe1HBfdaSfgFDRSJIhs6b
         izbyRCQOEeXwo30wfgdeHNC2xsjjbMq+QPZuJ69iAYOLJLpmIMADZy5sgNK/cqZqpjL4
         Ngwu0WpWprwMMolJksMjehc+/QClWp7Kal1e5MsAAiYxKNmcjCq9Er2u/iUwRege3I3T
         ITJZpq/ZpN8wtHkcwB513dBvGEFb3JoJ6ySWSey5eNddL1XYEZkGBIxmkaiEJw2KfqYh
         gs/Q==
X-Gm-Message-State: AOAM530P9So70RxbLymYPhVEjtld5Xxu2mD2rAUzBRo96+CpddvBcBev
        vqe63ghO7Cg3YqkOrewO5KUsUS/G
X-Google-Smtp-Source: ABdhPJzV69BKvibZcw9l6j05XEXvrOFQ7bjs5e5ajggvAJDRsoYibushVLetjZ9NWHNVNtf1N7Ui2w==
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr2077227wma.13.1593187906502;
        Fri, 26 Jun 2020 09:11:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x7sm38671368wrr.72.2020.06.26.09.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 09:11:46 -0700 (PDT)
Message-Id: <0b921545d2523db7b44d5ee74efc3940e3b8e58b.1593187898.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
References: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
        <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 16:11:37 +0000
Subject: [PATCH v5 7/8] cmake: support for building git on windows with msvc
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
CC=clang cmake `relative-path-to-srcdir` -G Ninja
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
index 2d7c0ed88e..47215df25b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -108,8 +108,11 @@ find_package(ZLIB REQUIRED)
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
@@ -133,7 +136,7 @@ if(Intl_FOUND)
 endif()
 
 
-if(WIN32)
+if(WIN32 AND NOT MSVC)#not required for visual studio builds
 	find_program(WINDRES_EXE windres)
 	if(NOT WINDRES_EXE)
 		message(FATAL_ERROR "Install windres on Windows for resource files")
@@ -145,6 +148,13 @@ if(NOT MSGFMT_EXE)
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
@@ -182,6 +192,10 @@ endif()
 
 #Platform Specific
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+	if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
+		include_directories(${CMAKE_SOURCE_DIR}/compat/vcbuild/include)
+		add_compile_definitions(_CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_DEPRECATE)
+	endif()
 	include_directories(${CMAKE_SOURCE_DIR}/compat/win32)
 	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
@@ -566,14 +580,22 @@ parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
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
 
@@ -590,7 +612,13 @@ endif()
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
@@ -844,6 +872,13 @@ target_link_libraries(test-tool common-main)
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

