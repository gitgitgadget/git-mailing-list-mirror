Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF4C433FE
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 03:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiJ0D1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiJ0D1C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 23:27:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF60F70AF
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j15so88576wrq.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwoTPCJ8FVYjbbQ2mQca8EGfR+fXP1CH3i1PkwD7NmY=;
        b=hzjlc6conDawDgqCqXh6L2cWpjy4b6Dy9Y5zr6aKBcSi2yQDIZfawpZO9d9NLpJBaA
         UAoqXi4OOUTztkGTD0TzsRYOmN/+AoH2ELWEGS1KbQJd/QBPv908cZYjZZsKOVXYKNUn
         ysMknstReJsVZj+kFBUU4yG4d8LihL2Xwf7mBEnpt6jIfv+Xejq/b9oImLaRNkN/nkGR
         48qYE5hs7JeOiYozMR65sPHoT1+jVh2d+aIldOaZL865bzTTiyo8NSpyy2Mw2JB+I/HT
         At9I2gWPT8ku1a4WhwyW7TRB2LeC7nY9ffTTvdOG7zqjy5k+tQZJI1TES3rd1wuDrlzK
         o+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwoTPCJ8FVYjbbQ2mQca8EGfR+fXP1CH3i1PkwD7NmY=;
        b=C1VhmcCHDkw8A8LeLKwN3TgRwfNVNQ+qpSQ+uRQWVJy1JDgXrAZFtWnl88F3zb7LIK
         Dy8ubxmTGB54sbqs3GU4gEA60dl2VqPPpOLrVCYcfnkydFsGrAiW9Slk5zvyD+Npvx/b
         hzlwR/8iQKZrc07w0Rti5oWM7dCTn55OsVfaxHIKDBkVOtZBoYk+12bICc9c61X9T+Fu
         1yiyo0wpr3eREMzgFLWbWy85Yv2TckqET4uZ4ReMhi9a2nvatjpa9fKC5uaHNbaaaNGI
         axOllIGXV8Yyno3xK90TciywVoqdaslPICp3C3nldCWA/JGv8EolCXLhkTVfpvouGNWO
         EajQ==
X-Gm-Message-State: ACrzQf3lHe/WGYs3mbgY6rWJQ6hP7NrkYSC3wCms0UOyzUBmfDQ/Ax8a
        33usJA392q54/RnZ8/AqcIEGLtOXOEmFww==
X-Google-Smtp-Source: AMsMyM5/KwfWmoz7ZeTWswh/V29Hv8piXD5IOI6u7ne5DlHBGzpy3qXb7ImW0fQ2fDAIBrh6q49zkQ==
X-Received: by 2002:a05:6000:1887:b0:236:7b1a:b14c with SMTP id a7-20020a056000188700b002367b1ab14cmr9289420wri.173.1666841218442;
        Wed, 26 Oct 2022 20:26:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hn2-20020a05600ca38200b003c6d0f8c377sm236828wmb.7.2022.10.26.20.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:26:57 -0700 (PDT)
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
Subject: [PATCH v2 01/11] cmake: don't "mkdir -p" and "cd" in build instructions
Date:   Thu, 27 Oct 2022 05:26:42 +0200
Message-Id: <patch-v2-01.11-667a2bd5271-20221027T032622Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1250.ge066ede4da3
In-Reply-To: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "-S" and -B" flags instead of "mkdir -p" and "cd". The "-p"
flag to "mkdir" wasn't needed as "contrib/buildsystems" is tracked,
and the rest of this is now easier to copy/paste into a shell without
having one's directory changed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3957e4cf8cd..494da807c53 100644
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
+Run `make -C contrib/buildsystems` to build Git on Linux/*BSD/MacOS.
+Open contrib/buildsystems/git.sln on Windows and build Git.
 
 NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
 to use another tool say `ninja` add this to the command line when configuring.
-- 
2.38.0.1250.ge066ede4da3

