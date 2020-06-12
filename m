Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B86BC433E2
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45544207ED
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlLCGCWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFLS3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgFLS3h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 14:29:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9FC08C5C1
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:29:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r15so9152247wmh.5
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0XPPft8r4Xra+F4c0Y5/B3YzjOeaiPpJXgsH7VeZvsQ=;
        b=nlLCGCWNR8/juix/RMzMoJIPCAFz0PBLIjTWfz8AXsXGQuJvdnTzwhWKO0i2404NwV
         rCDKoQmIJY6Ge4jY+9ivEftZwMRPuqY0sDZnWagGzA5Pn/HaY7urv72txaRrgxTQLoOe
         gsMmmRpyO0b9CeLtwMM9x3SayNMY7AV1ZxPZYLuCfn0VMxfylosgoEod+cpNIyt8GAWW
         RM5/mOLUx8g2QpW3CQLj4tmQQOnTIiqxgke+4LBzShjxMskXQj19XDTC9ayHWZgpxbF2
         f3y3CA5RhXQhZcMOK2fUDAqEeM9KBmpPROeic92Ms6Na4Pfp0oCPmMeUOBjq4bgmSJG6
         woXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0XPPft8r4Xra+F4c0Y5/B3YzjOeaiPpJXgsH7VeZvsQ=;
        b=odTN/7cLjazsz3wTsiADLkIjWHGu+g+4q9A6bJaG1mGOhzy+CZ+LN0bV9dIw6GpcJm
         EnPD025idPoYoIchxPsMkVX20Iczt3q9soOmuwFn73l1wcHuJXjgihtVMU+/l5O6+W2r
         MXP5SavfkxlEu0Zq+UNDAYXmNU0YY9IUnlUy0qqDQJoB73jhTeMxu+npMECkmjOCdTye
         TBy8eWw9AqRtXTLhpFTShzdLhsn7QHkNY0BFIKUGNXmlGCGGznsdPf0YMZzMbhSFcq0k
         7F879P9C2mzxuotOrtOzQvLlUw4+QNp8P3Q/gD36KY0tBPhjtVGYh8JC4/CTFq76EI/g
         YG6Q==
X-Gm-Message-State: AOAM531g5zcqJFFx+zjto+GV0Ne/q7qSX82IfmVwhJz2EpWkP8QiM/tn
        kFbkTAqi78E7+daC8etn8vhtM86x
X-Google-Smtp-Source: ABdhPJz835s3o3zLgLhKm9k+jqf/dzyx5mlu+u1q9M2A7eXdy0qV4CvrVxLBtIHWL0zc0OgDuDUZwg==
X-Received: by 2002:a1c:4487:: with SMTP id r129mr256405wma.14.1591986575564;
        Fri, 12 Jun 2020 11:29:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 104sm11974245wrl.25.2020.06.12.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:29:34 -0700 (PDT)
Message-Id: <f85ea0ac0ca5160a23a0a4ea26b7090638bcaf11.1591986566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
References: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
        <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Jun 2020 18:29:25 +0000
Subject: [PATCH v4 7/8] cmake: support for building git on windows with msvc
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
index 9aff2b9f4f9..8367b73e947 100644
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
@@ -570,14 +584,22 @@ parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
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
 
@@ -594,7 +616,13 @@ endif()
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
@@ -847,6 +875,13 @@ target_link_libraries(test-tool common-main)
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

