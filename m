Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C1CC43219
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiKCQms (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiKCQkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E618B1D
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kt23so6786527ejc.7
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC04IBAnHudicfCWlrtI14YpWjoD/JHSNx+SNl/1PUk=;
        b=WgO3Lf3Ac6dhlqalkOcOCvnLKt8ugd7LDPg36Nxnl56bBY8Wn+Ah6PawtyxI4eYFJX
         XM/DB90LklSDafILGooGBqSAEnL6BZsqBFNvCmjpDJDKqGnuUFkasuiist9UFsv2PabX
         hku1SmGRv7jHy3+WdS8QdU3q+bB2AZBlWR7febc+OWnDdSJ22JzjO2l8WFl6jjbJ4H66
         dg79lZnJI9I4CeXrV0lXz15kWhpJJBbklEYn4e8+7xiMqBdj6iPPRjIDaFyu0DKuhBeQ
         ns5hqYQMqZ+ATrILpSvSuEYsR2spizo+HbCecOLrq4IhH3YKLf6QN1f3H5qsp5jna2q9
         hT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC04IBAnHudicfCWlrtI14YpWjoD/JHSNx+SNl/1PUk=;
        b=73qxeU6uht6tBhCihS/M8wf9Y0c+TFU8C8g8JsGaMicQJeYJisdae1Lw4N4Pywhdyp
         5OnLuVAxnEoDCNbi+28sVS1nzcRfHmLzuuxIBZM7UIYtf3/q7FNoW4UL9wJYE263RStw
         AWkoh/mqCPmFLQmlWiCTli3tcgGSYkGg5BTmNpOYJjntQ5S1+GxBgkDAN5imL7ZU/H8/
         9yke38+sRt5e/PPK7+213Y2GQADZapPu/H8PdBZMU7axy/e89V/CbruC7tX4lJYEVVcU
         1wgcEDxv++mdtPDi9xd4Cs9oIP9X/H1sKNF0z6YpfYj7KeXqRsWGvNpLUW+WkBtf0PnS
         6U8Q==
X-Gm-Message-State: ACrzQf1f8QSaZ+UpbpcQgtnj66R07PsBZ/2yVy7Lhx/io55gQGcxFrvW
        Ub8zdLVN4axeALRZ7nPUm9o+xGUgIuUzBQ==
X-Google-Smtp-Source: AMsMyM4AuIhGHsH96HnhCkI6z5jg7v6pugNJVfel0WrryDu4CG5FUvjpKOBf2BKTi0b2daS+6l+yIA==
X-Received: by 2002:a17:906:2353:b0:7ad:daae:6edd with SMTP id m19-20020a170906235300b007addaae6eddmr19991048eja.40.1667493489509;
        Thu, 03 Nov 2022 09:38:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:08 -0700 (PDT)
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
Subject: [PATCH v4 03/14] cmake: update instructions for portable CMakeLists.txt
Date:   Thu,  3 Nov 2022 17:37:53 +0100
Message-Id: <patch-v4-03.14-6f0eae7a02a-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
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
index 463f55e5516..484b1988a7e 100644
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
2.38.0.1451.g86b35f4140a

