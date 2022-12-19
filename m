Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C53C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiLSKdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiLSKc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:32:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0202B6348
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:32:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s5so12150894edc.12
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYvgCmr5emtAAGZAHJBmIKlnSEitCV9nCUr2NxODjEU=;
        b=MZ12R/ZoaP/tlzWfjZnDnTR2Dtwtnnlr7YvGR6paVXB6nWJRbgkZSG8Kl5+4tiuRRn
         B8Val3H3CaKseXQG3fdtrltQGsHA2f5T0XJzAl/LqkLTgwujbJwNcaJo/d91wt6jVIN5
         4Wq4kPVJ0BiEttDqgWKwcQGFZXpJAwlPU2tOjTNMJSA9hMEnQuoujeEbmGPth8sLvu93
         wX2j39TEkBzOevblJWiUuiKyuygkDmWNM2KVBorC0t30SXGo+w6HSSX/xPfzfhzQl9SD
         N6QvHGoTl5skPIZwgfubRzvIkpm/1RfjkNTnkbZ8FmDxQrOxReL1wyXIjSPtumhlM73c
         BOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYvgCmr5emtAAGZAHJBmIKlnSEitCV9nCUr2NxODjEU=;
        b=qLE/mi2WIhq1qtXxzITsfVAy6ZhnCbJrKW+h73fVmqItwl8U84m03hGiQj19CyTpUH
         cJDjtfd4Ki8ia+jW5xjFc+Pg6l3+4xgAACg5D6lTYWC/cOC5hgKu17VJXFJuTWTz5bDl
         8OKIAAWp3VTaBy6Oj2/CDc1Q9XBcRi8zdjTKFnwUKDrNr+cEXcIGWssn8teXHrHqi+2J
         7PzSGxeHClLVg7EQcYqM8+7HF2Df3DUUNqITXuwi0ETrB9k8hqNsBdDh77QnakjvLEWt
         3z4mROLS7L98mz+Yj1/V60+Wax9qdR77XegjwRc3gUTbsI+vzdLVzjjVP9fivBL1kfxl
         NY+Q==
X-Gm-Message-State: ANoB5pkTp7HaMDbfAEOtWw9k2uTN3fWRd8OBDH7JSj9Y45Llc+8En+74
        lxcrAR9Vu4b0sxeTQDi4hI5udGlMhBEe6A==
X-Google-Smtp-Source: AA0mqf4NDwhxKMC3pztgDonf2smEW+coU2pnlZVxGMS1+GMHkVa9e0X4Yls+eEbukd21ZMg0ulXnhQ==
X-Received: by 2002:a05:6402:6c1:b0:46f:d396:a7bc with SMTP id n1-20020a05640206c100b0046fd396a7bcmr27066301edy.28.1671445974228;
        Mon, 19 Dec 2022 02:32:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p26-20020a056402045a00b004610899742asm4177918edw.13.2022.12.19.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:32:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] cmake: update instructions for portable CMakeLists.txt
Date:   Mon, 19 Dec 2022 11:32:46 +0100
Message-Id: <patch-2.2-d6058ed0f22-20221219T102813Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-0.2-00000000000-20221219T102813Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20221219T102813Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The instructions for running CMake went back & forth between *nix,
Windows and Visual Studio instructions Let's create headings and split
the existing instructions up into those new sections.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 68 +++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5b22a9b217f..80290edd72a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -4,7 +4,31 @@
 
 #[[
 
-Instructions how to use this in Visual Studio:
+== Overview ==
+
+The top-level Makefile is Git's primary build environment, and a lot
+of things are missing (and probably always will be) from this CMake
+alternative.
+
+The primary use-case for maintaining this CMake build recipe is to
+have nicer IDE integration on Windows.
+
+== Creating a build recipe ==
+
+The "cmake" command creates a build file from this recipe:
+
+    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
+
+Running this will create files in the contrib/buildsystems/out
+directory (our top-level .gitignore file knows to ignore contents of
+this directory).
+
+See "cmake options" below for a discussion of
+"-DCMAKE_BUILD_TYPE=Release" and other options to "cmake".
+
+== Building with Visual Visual Studio ==
+
+To use this in Visual Studio:
 
 Open the worktree as a folder. Visual Studio 2019 and later will detect
 the CMake configuration automatically and set everything up for you,
@@ -14,13 +38,33 @@ Note: Visual Studio also has the option of opening `CMakeLists.txt`
 directly; Using this option, Visual Studio will not find the source code,
 though, therefore the `File>Open>Folder...` option is preferred.
 
-Instructions to run CMake manually:
+By default CMake will install vcpkg locally to your source tree on configuration,
+to avoid this, add `-DNO_VCPKG=TRUE` to the command line when configuring.
 
-    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
+== Building on Windows without Visual Studio ==
 
-This will build the git binaries in contrib/buildsystems/out
-directory (our top-level .gitignore file knows to ignore contents of
-this directory).
+Open contrib/buildsystems/git.sln and build Git. Or use the "msbuild"
+command-line tool (see our own ".github/workflows/main.yml" for a real
+example):
+
+	msbuild git.sln
+
+== Building on *nix ==
+
+On all other platforms running "cmake" will generate a Makefile; to
+build with it run:
+
+	make -C contrib/buildsystems/out
+
+It's also possible to use other generators, e.g. Ninja has arguably
+slightly better output. Add "-G Ninja" to the cmake command above,
+then:
+
+	ninja -C contrib/buildsystems/out
+
+== cmake options ==
+
+=== -DCMAKE_BUILD_TYPE=<type> ===
 
 Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
 compiler flags
@@ -32,18 +76,6 @@ empty(default) :
 
 NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual Studio
 this option is ignored
-
-This process generates a Makefile(Linux/*BSD/MacOS) , Visual Studio solution(Windows) by default.
-Run `make -C contrib/buildsystems/out` to build Git on Linux/*BSD/MacOS.
-Open contrib/buildsystems/git.sln on Windows and build Git.
-
-NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
-to use another tool say `ninja` add this to the command line when configuring.
-`-G Ninja`
-
-NOTE: By default CMake will install vcpkg locally to your source tree on configuration,
-to avoid this, add `-DNO_VCPKG=TRUE` to the command line when configuring.
-
 ]]
 cmake_minimum_required(VERSION 3.14)
 
-- 
2.39.0.1071.g97ce8966538

