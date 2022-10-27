Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ECAC38A2D
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 03:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiJ0D1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiJ0D1D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 23:27:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807EAF88D4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a14so77833wru.5
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojycgPXUwdE8I42vBJDKHZf9ozYioO388esYPJ+UEZQ=;
        b=WyyGciQ2s/pHoOJ84wVmNn20hyeZlpyr0h6V8vXfGjPFZLDXPsFEq9ngtMpkk9VzRz
         7y2cBpMv+0Y8CG7jPIPpjUy6yyvGSWdbIIhXcrmHb/F3stRvgN8uGM30Dh3eTRkFtueh
         mcyDqCrTsema7kaMxR2H7Y+Mo5PhFvvH7gJs6nqTlgdV3fx49yB7y3qk3W4XEnv3hVfU
         m3LCgasLP+LKRgHNJhLHm2S+2rncZErE/V20y6pkW5ICS9wSH0Ue8VfZvlOPlMbUj9hE
         jbgxTwqPET6Z4kVU5HJO/o12fuhD4mtjd8Hc0GyXMcrKIPLX9jRKHH2uYa4HIoHimxGw
         roYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojycgPXUwdE8I42vBJDKHZf9ozYioO388esYPJ+UEZQ=;
        b=KuDAW8FrcnN+EltFxXany6qfu0sMve657rZt3uo8jHjyDZzKbsTb56T4coNAcl56B/
         Vpn3Ju2wZPHEPpL7H2bf/dg5J9DjFx8pZMQKyokwT64usLhDtk0mvO5YMfeSnWTomEN7
         eAykIobvO/mgEMUst4+fdXdukUq3YPJYG4D2ANyDZdt/rO2ILLBNhMN/coolv6L9iTe6
         jW/0ZI36hr4JnLvauLHOoeZ28tQGSz2Er9yS7gQt4zahym8cZUdiGTlhl6/wiSR7sfvv
         5/Aa8X5EuqeWuf7MfatVute0YFGUTcUsSu1ST7hgkziFJuNYIeYRSit/74DPSe0AnbSh
         VqjA==
X-Gm-Message-State: ACrzQf3u8cDut6Adcw0itx8WGcVtJgba/329oAD4ReQq4fHHoH5Mqf/P
        niKgGW24fXlLjtIN5j4+mjLiY0m5gjGTqA==
X-Google-Smtp-Source: AMsMyM6NYBDk0w2iFonGco/0j5H9si3jfzpfJ4pVU9AVoA+gU7dvHYFU1RQYGWoAlp13oykU4Pryyg==
X-Received: by 2002:a5d:42c4:0:b0:236:637c:6c71 with SMTP id t4-20020a5d42c4000000b00236637c6c71mr16217800wrr.499.1666841219760;
        Wed, 26 Oct 2022 20:26:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hn2-20020a05600ca38200b003c6d0f8c377sm236828wmb.7.2022.10.26.20.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:26:58 -0700 (PDT)
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
Subject: [PATCH v2 02/11] cmake: update instructions for portable CMakeLists.txt
Date:   Thu, 27 Oct 2022 05:26:43 +0200
Message-Id: <patch-v2-02.11-9e2470dcb95-20221027T032622Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1250.ge066ede4da3
In-Reply-To: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
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
index 494da807c53..a76a3c46767 100644
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
+One the recipe is created a build recipe will be created. For Windows
+Open contrib/buildsystems/git.sln on Windows and build Git. Or use the
+"msbuild" command-line tool (see our own ".github/workflows/main.yml"
+for a real example):
+
+	msbuild git.sln
+
+On all other platforms running "cmake" will generate a Makefile, to
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
2.38.0.1250.ge066ede4da3

