Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D7FC47088
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiLBL2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiLBL2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:28:46 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8688C460B
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:44 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bj12so10822020ejb.13
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqtn+7vSlnXoq6OOtiHulDwRYTaqRmC5mma9ZOEBYiM=;
        b=b+jWsRKBLKgnAbTw+vkmLeYKnIk/rs9lS3qksU0e0KvYS0tO/gtKZC+SqSXNQ2HxTw
         2IGQHIXK278svRVREqjGBRMFgKX1KGcu5zPlwanNnePm2HiJJQwVuC9T5J+2TnQVgC+4
         qDnfzYRf4ED/pfd54y7e1r3WN9zZK2DEsJJ4JnOjT3RqPq7OUmBXbK6SkM6VIVQ0cgcj
         dHQMh0hjUGVwfmKY/6ZFo5RW63GKQfiht3rXBgIuFJu5XLsstK9V66FqWrRlWRcRR3Wo
         42Xp3tWFCPaadllk9xmFRVqUmVerYD3zS8sKkIx/ILU0GzdIS5DK3Cet6bbbyH7gji0g
         Shfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqtn+7vSlnXoq6OOtiHulDwRYTaqRmC5mma9ZOEBYiM=;
        b=pNfEUPvebQw7m8NSjvmH4AEf/DVRInZjUGijuzc66H5g+PcmvybDZtz/QTdMKXp5VR
         IbLu/qeBCB7pWcX/D1a/sshEB1Bngmr3m0fPi/zfrKM/QWMxOzRSsEK7vQseY3bi2JR5
         usFyVgMz7AOHC9SShnFpStVVuZqP6RW4vzVNyIYXRhQNOgoN2U7997U9djST8D66swcI
         juUl0UPIbbbsfMDbnRBa2mEssMaLqVnzD36GwMOUoaWjKY6tn89I6oLn0uIJdXgAk0Jw
         94PpGJsG7aV1psIh9i8K87ATCwRapvkRa7v3KaVNz2HYqWDPDqvGZg5sjWqz7bwmnG01
         pVCw==
X-Gm-Message-State: ANoB5pkfxIAwqR40wIEwAR556vSwKu0asxz5WaHKyzCIS8ecUEReHJRn
        8SSXMoxRQT0hgIm2PCLr3lHZLdhA9OQxjA==
X-Google-Smtp-Source: AA0mqf566BVLvQ7IacSs6OQeVsf4mgUbFPDP3tfWr3iKx34VH0ShQUP/37hoz3EdWIMoNqiN8T/Y9Q==
X-Received: by 2002:a17:906:4f0b:b0:78d:aaf9:7b8c with SMTP id t11-20020a1709064f0b00b0078daaf97b8cmr61117960eju.229.1669980523043;
        Fri, 02 Dec 2022 03:28:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:42 -0800 (PST)
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
Subject: [PATCH v5 03/15] cmake: update instructions for portable CMakeLists.txt
Date:   Fri,  2 Dec 2022 12:28:24 +0100
Message-Id: <patch-v5-03.15-5c4ba2425b6-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
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
2.39.0.rc1.981.gf846af54b4b

