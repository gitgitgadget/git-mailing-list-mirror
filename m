Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8FBC43217
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKAWv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiKAWvx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:51:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB8F1EAE5
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:51:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a5so23859512edb.11
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUU2s5J99nCD8UDvMI0GEYtE+eWp0bVgvz1Tk9lagbg=;
        b=hs2sZnWHIyKj8ryN+8SKXkIAkw/EQDrLJ1RNbtyLu1GEdyu28tz5yJsZuHabbxPsTV
         DAG50CaGolMuEAfj9kgODGNTo4JzgQ246pygov1oqOC2dTPhJXHeaMPjKx3nyGMAmZZx
         4UBR0JOW9+1BxRi7biRH0IAOiyW1wqwYiGof0T5B1K+Xe8oBLcPb8vvhvlaRCH4t78j2
         Ld7An+l5s6tQeezYnsfSOYsAo0E1sYh0aFDvgX8RFgJ8LRJ5+Zkncqk4WbGDmvGNIhSi
         Sl9Ecwg9ReiyoCjCFe9sgEmBM3I02mLECJ0G40G57IkNyavWNCAB2XVDJcD4e8Zfp5rw
         a7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUU2s5J99nCD8UDvMI0GEYtE+eWp0bVgvz1Tk9lagbg=;
        b=Lax1ph9ZlPnCiBQocf77Fh3lqRkKSAUuQV/qQf1GJ+z5tsk/hg3tX5+LifT2maGnBa
         5wu701oPSVrfuH5CTxv7TFSZBTeahPZ7nS3vmPsUw4ulYXl0nna7K31P2vGuuFnikurq
         j7KiuOiBTtfdc8kk9DrYXBvpS5tvWPDacSGNVvoeu1po/YydOCFS3mxXwDo4222EwkiS
         GH6tc35vD2uPP28RONF/vW2v50cHoqahF9Zbw2PG05zXj6gOFmh6zephQdko+Adg/lpD
         7YxpgfCmvQj+s5+LY2NORwMgwmltSFJVqc4c02OfTALoB1Tsk+vfPE6DLlaN4AWaWai4
         lOJg==
X-Gm-Message-State: ACrzQf0NqFK/xfbOV33FxNjxuFf27o/L6o/cTNwvi79maAZ2WzkvmHeH
        qyvpDDPmB9kCrjIjn2zsC92otD9dHSZJVQ==
X-Google-Smtp-Source: AMsMyM765nBGkHjap5VywaZFbKwTAgHiV0rnAlVmelO7Hcifi+ctjSn9yVhuKapD6ciOqd2jpvbdOA==
X-Received: by 2002:a05:6402:1348:b0:461:c056:bf65 with SMTP id y8-20020a056402134800b00461c056bf65mr21858486edw.414.1667343110429;
        Tue, 01 Nov 2022 15:51:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:49 -0700 (PDT)
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
Subject: [PATCH v3 02/12] cmake: update instructions for portable CMakeLists.txt
Date:   Tue,  1 Nov 2022 23:51:26 +0100
Message-Id: <patch-v3-02.12-7a21f4aa24c-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
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
 contrib/buildsystems/CMakeLists.txt | 66 +++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 494da807c53..7bc123da315 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -4,7 +4,48 @@
 
 #[[
 
-Instructions how to use this in Visual Studio:
+== Overview ==
+
+The top-level Makefile is Git's primary build environment, and a lot
+of things are missing (and probably always will be) from this CMake
+alternative.
+
+The primary use-case for maintaining this CMake build recipe is to
+have nicer IDE integration on Windows. To get Visual Studio-specific
+instructions see "== Visual Studio & Windows ==" below.
+
+== Creating a build recipe ==
+
+To create the build recipe run:
+
+    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
+
+For alternative "-DCMAKE_BUILD_TYPE=<type>" flags see instructions
+under the "== -DCMAKE_BUILD_TYPE=<type> ==" heading below.
+
+== Building ==
+
+The "cmake" command creates a build file from this recipe. For Windows
+Open contrib/buildsystems/git.sln and build Git. Or use the
+"msbuild" command-line tool (see our own ".github/workflows/main.yml"
+for a real example):
+
+	msbuild git.sln
+
+On all other platforms running "cmake" will generate a Makefile; to
+build with it run:
+
+	make -C contrib/buildsystems/out
+
+It's also possible to use other generators, e.g. Ninja has arguably
+slightly better output. Add "-G Ninja" to the cmake command above,
+then e.g.:
+
+	ninja -C contrib/buildsystems/out
+
+== Visual Studio & Windows ==
+
+To use this in Visual Studio:
 
 Open the worktree as a folder. Visual Studio 2019 and later will detect
 the CMake configuration automatically and set everything up for you,
@@ -14,14 +55,15 @@ Note: Visual Studio also has the option of opening `CMakeLists.txt`
 directly; Using this option, Visual Studio will not find the source code,
 though, therefore the `File>Open>Folder...` option is preferred.
 
-Instructions to run CMake manually:
-
-    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
-
-This will build the git binaries in contrib/buildsystems/out
+Following the instructions above will build the git binaries in the contrib/buildsystems/out
 directory (our top-level .gitignore file knows to ignore contents of
 this directory).
 
+By default CMake will install vcpkg locally to your source tree on configuration,
+to avoid this, add `-DNO_VCPKG=TRUE` to the command line when configuring.
+
+== -DCMAKE_BUILD_TYPE=<type> ==
+
 Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
 compiler flags
 Debug : -g
@@ -32,18 +74,6 @@ empty(default) :
 
 NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual Studio
 this option is ignored
-
-This process generates a Makefile(Linux/*BSD/MacOS) , Visual Studio solution(Windows) by default.
-Run `make -C contrib/buildsystems` to build Git on Linux/*BSD/MacOS.
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
2.38.0.1280.g8136eb6fab2

