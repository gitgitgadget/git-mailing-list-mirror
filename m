Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9EDC4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiLFCJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiLFCJd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:09:33 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4848C2408E
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:32 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id b2so2811942eja.7
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8O3VBldRJck7bjge4k+rX0d31r1Px6xgEfOzGUYTsA=;
        b=hZcRNtagtjN43djS/haAenZpjqUdNowFvizyvobg1KqspSE3ZEB5wKx7/bXwRHFLNZ
         l//fDFMm39aiyZ7KgmppT2qR0syb6BBQR32xk0c+sJDoGmnG5CGmVloh/ChNpxgT8IET
         QKTtkToBulotNQOg130YAEWKGu25FVU4TD/oyjztfBavkLlmXB0VEtZRdNhzDo3yHaHt
         vyUdEhwFdU1RK8S5V23u7x4w+J/WjZASPkhdrcxfpZjgkDm4AMDe3PpAoT7ZIDCNZ7f2
         BudXwjX/UQ0+GPpWqAsEAAs+k/8YvwT5AekqSvfxf9oLYYD6CMupxGbdBzEj1US/F9Ph
         23qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8O3VBldRJck7bjge4k+rX0d31r1Px6xgEfOzGUYTsA=;
        b=Gwjf53oSGgBylQR3lD5UNpstbnADevL1AikoMOlVFD1IrJxPd11I5aHeIGspxk43l1
         Wtk0tCZ6oxinF/aUWOfpBQZTBs0SO7UBFHBtdoRUKAkQUUhv+yY6b2xyrJnd0j3svLoG
         IIEVo6gy70sdQEgcYr/1EUieEqeuRPQrFeGMhLtjZjq5W1s0m0lw1G7hlce6h0Y3G7KM
         Ter41t/hYo4iZm6gHBDUCwgg5F7zU3rVgLGYP1XBynTfHqGV49df9G/r29P6B266Nigx
         K5QYHTa5l2Pvno1spo2Nh7XWmWqWSxNSwiRKC5HnbsSZva1tqM2rdTFKg/UFgLg5nj72
         3hPg==
X-Gm-Message-State: ANoB5pnTeDKP6aUlIHMfdMga20pAhgs5RrrNPCCQFt+NtFrCfx4UwpRb
        rkvJSYE6/vQSdlOAjTfVvWlmrzi9yjF5qg==
X-Google-Smtp-Source: AA0mqf4PgOu0zjAH4wL1b3oY9OLj+Daz5fY/+V5argRv1B19Z/Yq9aB+FoKyOx79aArJpFMo7T8cRg==
X-Received: by 2002:a17:906:4804:b0:7a8:3ecb:bd62 with SMTP id w4-20020a170906480400b007a83ecbbd62mr72315381ejq.721.1670292570543;
        Mon, 05 Dec 2022 18:09:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:29 -0800 (PST)
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
Subject: [PATCH v6 03/15] cmake: update instructions for portable CMakeLists.txt
Date:   Tue,  6 Dec 2022 03:09:01 +0100
Message-Id: <patch-v6-03.15-b9ddb5db1d3-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
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
2.39.0.rc1.1006.gb4c675778ba

