Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C7DC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiLBL2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiLBL2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:28:46 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF1DB0A21
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id d14so1138692edj.11
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la+mvrhNwgN0PwoiVVvWQ+1nEVZe4BTpmKXb9GL0EQs=;
        b=RUm7D/u5f+JfGDaRkbdsFnwFmmu9PC6jBDr6mVt7yDyVLebshLC8R+yRaUOo80Rp/Y
         2mVGF/yXSak0Y08Yff7+qFcWLb0b/R5bEx4xRGJXEVCil08lblGF96mOaXG8An2/4QYl
         04QqOOd8JqYwmxKjA5qu8BFxfCYRg6qA110NhweNSgpu+bjvO+JOX2j/ULRU1+HJzwvW
         zfP4qXFIsGqpyMR2hMnwwsaPqhYkstr/rKJiebsH7j3UahkscWOMumFsCWuew+g2K9iN
         7T7VG5jQ8xLDKLD/ySYZWwOBji0Enx5E5wPuAVU+QzHU1ROTEDRziEwSN5iTkbnXZhL+
         K5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=la+mvrhNwgN0PwoiVVvWQ+1nEVZe4BTpmKXb9GL0EQs=;
        b=ehDrbOqP4255dgddoXTGGajqNLg/78XA8O39c0SUCr+TzCx/u+cRBZoa4LmWoJ5Hua
         B/zNmZ/m+b0A8H98BQBu7MPF8UEV7VRr55vI27vQgQFdXkKcpQmunMDN3F8HIi+b0+wO
         GMOVtVVuZ/8mWlkoOk2n0TIW0ReczwuMYilb9cFGyZLBEBsdTha0SRYb0cqnKyytYyCt
         xnqFhGTphxyvaWnir0/+FAZW7F4CqztR0RU6msSNjDZuiipCXJzZIXBSFjT5/6gUBN2t
         R6Ah280YyaNQH6XMknBYGLNJjbamR6CuntUsnRPY1XCl4MGcFbCdNxkxLyDlZ+fW3Y/2
         IguQ==
X-Gm-Message-State: ANoB5pmRfj0VlT1uBAcHuyqjJRFHw0Hlt/xyCdtIdGN2t7Zne9bXotKb
        eDBlpqdd/z0b5kBpbPVZvjcLSG2wtrh5DQ==
X-Google-Smtp-Source: AA0mqf42oCZsBc4HnOLMTUFccXk+NQ+h2+wWcaMuom7WUGKInEQ2Ie5b3GrgWKZ1YUbHejGleZ+K6Q==
X-Received: by 2002:a05:6402:4147:b0:461:b2b1:9702 with SMTP id x7-20020a056402414700b00461b2b19702mr4125141eda.274.1669980521839;
        Fri, 02 Dec 2022 03:28:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:41 -0800 (PST)
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
Subject: [PATCH v5 02/15] cmake: use "-S" and "-B" to specify source and build directories
Date:   Fri,  2 Dec 2022 12:28:23 +0100
Message-Id: <patch-v5-02.15-314c5e40cff-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than the multi-line "mkdir/cd/cmake" recipe provide an
equivalent one-liner using the "-S" and "-B" options, and then suggest building with "make -C <build-dir>".

The rest of these instructions discuss e.g. running tests from our
top-level "t/" directory, so it's more helpful to avoid changing the
user's current directory.

The "-S" and "-B" options were added in cmake v3.13.0, which is older
than the version we have a hard dependency on[1].

As an aside The "-p" flag to "mkdir" in the pre-image wasn't needed,
as "contrib/buildsystems" is tracked

1. 061c2240b1b (Introduce CMake support for configuring Git, 2020-06-12)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 8f8b6f375f7..5b22a9b217f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -16,9 +16,7 @@ though, therefore the `File>Open>Folder...` option is preferred.
 
 Instructions to run CMake manually:
 
-    mkdir -p contrib/buildsystems/out
-    cd contrib/buildsystems/out
-    cmake ../ -DCMAKE_BUILD_TYPE=Release
+    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
 
 This will build the git binaries in contrib/buildsystems/out
 directory (our top-level .gitignore file knows to ignore contents of
@@ -36,8 +34,8 @@ NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual St
 this option is ignored
 
 This process generates a Makefile(Linux/*BSD/MacOS) , Visual Studio solution(Windows) by default.
-Run `make` to build Git on Linux/*BSD/MacOS.
-Open git.sln on Windows and build Git.
+Run `make -C contrib/buildsystems/out` to build Git on Linux/*BSD/MacOS.
+Open contrib/buildsystems/git.sln on Windows and build Git.
 
 NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
 to use another tool say `ninja` add this to the command line when configuring.
-- 
2.39.0.rc1.981.gf846af54b4b

