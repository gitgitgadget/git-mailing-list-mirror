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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A8AC4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 17:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2205D613FA
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 17:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFDRp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhFDRpY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 13:45:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B36C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 10:43:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q5so10129401wrm.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9IWbLO8RcVIBHxdVxnqQ4B4bOqXfzwkTu3W2+74X4Xs=;
        b=GrxyY0+qP6gIlkYa4ZXGRbfojG5l/kdWvDD+aJmxu7oIdyzx5pZyDUM3FIWjxLEXd1
         gWHf5XAcD5Qp/c3zqelt5K95N3j2WzhCkv4YL7zP9ENlex6EXC0gGLuRfaXFd8Nb+0nO
         AIt6q3w2NZoXtsig3pJxs2GZTkPh02WDGEg/3c/bPvrqY6q5+sVT7F5ln/B0idikGWjt
         29EyXFdD1usl242fBnhTx4021v5ZciJn2UScMmjkNxd1+hjL4DpCC4tSHMrDB1VjLgmN
         Atx4kPLFsESqx/m/nY2nqcPxGsPe8uJFmZZurz9MuR7bbyck8iUX/Z65PXNffKkl9Rfr
         4fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9IWbLO8RcVIBHxdVxnqQ4B4bOqXfzwkTu3W2+74X4Xs=;
        b=C/80NkjPZGN1R2twdy99Fm19/chd9jCOWMfmRpwLRE6mljqpA7H1g0uMzIbMDL5npg
         vPAwa3+MB6SdllBhpGPQfq8Q4bVjx36PNyGWyayLENzfmHeyz+mn4SpIabBjxV+fNi60
         fVqGT35RnJYzyYG/mpMF3LwmHCGVFonge9SrObCYG+VAtn8+Xc29Lr+v5z0p8dCNGf4w
         SR6pcx8ADYxhNBTX92RhuuE/NBmDTN3BS2zw+5dwTlyid//lWpEAqwJxdVz2+HowAcWt
         7SZ3vX/FZKO6j81bMe012pmv1ysyVibyYh+TX+sXbaXhKhdWXcymai7hVqbH4Ion0uzM
         W+IA==
X-Gm-Message-State: AOAM53352/uQXLUBzHLjTXigLBz/5Ov+MhCsA8Uy3cC7NcbZnu2/T23U
        tj/mCegR3TAs3O41cMWnDPTOGqtOa1k=
X-Google-Smtp-Source: ABdhPJybPCs2h2tOqXBstiKyRHyOZtAKXQFS8MaQeTQHqhwbAvxGI/gxIPh6sKw12jBfPASTgGvYoQ==
X-Received: by 2002:a5d:58c1:: with SMTP id o1mr5002432wrf.420.1622828607622;
        Fri, 04 Jun 2021 10:43:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm7412570wrv.39.2021.06.04.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:43:27 -0700 (PDT)
Message-Id: <3170f78daa5fa89f04f61e24c9c64c93ea5b394f.1622828605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.970.git.1622828605.gitgitgadget@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 17:43:23 +0000
Subject: [PATCH 1/3] cmake: add knob to disable vcpkg
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>,
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
    VS 2019 by default, making it impossible for Visual Studio to
    configure the project in the likely event that it couldn't find the
    dependencies.

  - Inexperienced users of CMake are very likely to get tripped up by
    the errors caused by a lack of vcpkg, making the above bullet point
    both annoying and hard to debug.

As such, lets make using vcpkg the default on windows.  Users who want
to avoid using vcpkg can disable it by passing -DNO_VCPKG=TRUE.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a87841340e6a..41320150bf66 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -43,14 +43,24 @@ NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studi
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
+if (WIN32 AND NOT NO_VCPKG)
+	set(USING_VCPKG TRUE)
+else()
+	set(USING_VCPKG FALSE)
+endif()
+
+if(USING_VCPKG)
 	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
-	if(MSVC AND NOT EXISTS ${VCPKG_DIR})
+	if(NOT EXISTS ${VCPKG_DIR})
 		message("Initializing vcpkg and building the Git's dependencies (this will take a while...)")
 		execute_process(COMMAND ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg_install.bat)
 	endif()
@@ -178,7 +188,9 @@ endif()
 
 find_program(MSGFMT_EXE msgfmt)
 if(NOT MSGFMT_EXE)
-	set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
+	if (USING_VCPKG)
+		set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
+	endif()
 	if(NOT EXISTS ${MSGFMT_EXE})
 		message(WARNING "Text Translations won't be built")
 		unset(MSGFMT_EXE)
@@ -982,7 +994,7 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SUPPORTS_SIMPLE_IPC='${SUPPORTS_SIMPLE_IPC}'\n")
-if(WIN32)
+if(USING_VCPKG)
 	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
 
-- 
gitgitgadget

