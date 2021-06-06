Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A81C47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2F061159
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFFMEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 08:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhFFMEs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 08:04:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF044C061767
        for <git@vger.kernel.org>; Sun,  6 Jun 2021 05:02:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h8so14154688wrz.8
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2ne3rB5ZdeRb8L0oPxjH/HNDLTUAEiWOIUVXHEOYdy8=;
        b=qGaYwV22oyxMLPVLa22pLsg7m0bax7lbXHfNZsUkBEWyWypARkW6utBzsxQv+C0JkR
         AWhMQDl3r/AKhwbqp9oBOsk49UD7oTGRURkDTKPV0kZw82ibfroQKwNMKIZF7jbQtJt6
         OEr9vTlNLr9G5pSwe4wYxrtI4I8c4/GQauvam0Zkc4979QBqaXrfRk0ZNt0vByftvMdL
         52XOSIZWdZjPDtQ+JDYdlNMTIn4G54xx4D5/U4b31/La1Wn0n9hO0TyWhck5McLorgNR
         nXasPjcNvQ9oi6f+MlhkL9RBcQs30YgBoE97ufRb7Hg3nX3lsiLB4zbN13ffAcAi0x2n
         pszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2ne3rB5ZdeRb8L0oPxjH/HNDLTUAEiWOIUVXHEOYdy8=;
        b=tN3GT8HpsK3R2rBxLUABJhcbQ+UoLnPRogejk4xjo/I69VYO9fOl/e1uQDeXPTB/7l
         1Dm5t/zX9pZNVsN5H1FAu/qY2SftkAu9ZZjU3EfflVWNAkObgEDjcEqpPImITTtkC2NQ
         1tli206LDDFSCGnKyhcEK1zRg/QOMy9asTXAm7EfQxWkjX5KLJ+XWhrVwb04Mrte3vIj
         O/MM8kMaXojWBKTnWQJ0YNic5pq88ff7gT8KT9zpUfzizk18RKI2tID4SEdq2kxDKBk5
         ofwXeWX9YvKoLGOhrt8ccOmtVAu2u6AJT38u35YL471lnHkD3+CQk5i6Su+aA2wzfmAC
         MGDw==
X-Gm-Message-State: AOAM530FHmUqvgGX7U0Kwu5tLv5sTM1qfjS//CWyzEcL6nzk9VT4alFq
        XGHKFLumRJFUMfb0KN3kpHLdOOn0FUI=
X-Google-Smtp-Source: ABdhPJygSfVGrcqjfYa3ahtwkPe9+s8Xs1YVTbMUv9TlDYFyhm4QwCvLJqZe+IWeG01hTutZT5CDZg==
X-Received: by 2002:a5d:618f:: with SMTP id j15mr7446528wru.348.1622980976670;
        Sun, 06 Jun 2021 05:02:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g23sm11651983wmk.3.2021.06.06.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 05:02:56 -0700 (PDT)
Message-Id: <485254b49de8923f2f47e595f6882d9935e38ee1.1622980974.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
        <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Jun 2021 12:02:52 +0000
Subject: [PATCH v2 1/3] cmake: add knob to disable vcpkg
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

When building on windows users have the option to use vcpkg to provide
the dependencies needed to compile.  Previously, this was used only when
using the Visual Studio generator which was not ideal because:

  - Not all users who want to use vcpkg use the Visual Studio
    generators.

  - Some versions of Visual Studio 2019 moved away from using the
    VS 2019  generator by default, making it impossible for Visual
    Studio to configure the project in the likely event that it couldn't
    find the dependencies.

  - Inexperienced users of CMake are very likely to get tripped up by
    the errors caused by a lack of vcpkg, making the above bullet point
    both annoying and hard to debug.

As such, let's make using vcpkg the default on windows.  Users who want
to avoid using vcpkg can disable it by passing -DNO_VCPKG=TRUE.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a87841340e6a..be6d9659c387 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -43,14 +43,23 @@ NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studi
 to use another tool say `ninja` add this to the command line when configuring.
 `-G Ninja`
 
+NOTE: By default CMake will install vcpkg locally to your source tree on configuration,
+to avoid this, add `-DNO_VCPKG=TRUE` to the command line when configuring.
+
 ]]
 cmake_minimum_required(VERSION 3.14)
 
 #set the source directory to root of git
 set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
-if(WIN32)
+
+option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.  Only applicable to Windows platforms" ON)
+if(NOT WIN32)
+	set(USE_VCPKG OFF CACHE BOOL FORCE)
+endif()
+
+if(USE_VCPKG)
 	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
-	if(MSVC AND NOT EXISTS ${VCPKG_DIR})
+	if(NOT EXISTS ${VCPKG_DIR})
 		message("Initializing vcpkg and building the Git's dependencies (this will take a while...)")
 		execute_process(COMMAND ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg_install.bat)
 	endif()
@@ -178,7 +187,9 @@ endif()
 
 find_program(MSGFMT_EXE msgfmt)
 if(NOT MSGFMT_EXE)
-	set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
+	if (USE_VCPKG)
+		set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
+	endif()
 	if(NOT EXISTS ${MSGFMT_EXE})
 		message(WARNING "Text Translations won't be built")
 		unset(MSGFMT_EXE)
@@ -982,7 +993,7 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SUPPORTS_SIMPLE_IPC='${SUPPORTS_SIMPLE_IPC}'\n")
-if(WIN32)
+if(USE_VCPKG)
 	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
 
-- 
gitgitgadget

