Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F0C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiLSKdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLSKc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:32:56 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336F4625D
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:32:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id e13so12196242edj.7
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUDGzNK/xkLpzpOUb+4aJATdRFMr68eMkSoiXc4mVmU=;
        b=Cjuha+yImrVDqv2Dn6Ei6LP12wGttaCfQT+xx/W3bnD9PJD1DGXoW0HtlOZFtnJOco
         EiKDHHze0a8ISfZbW3G/a+ImQ8ZLg55/lA1lDZf4Ky8dhpyTIKMx5l+Tl8wwpApt6nYE
         Zjyia0hLvQbJ3QHSvLhwOdF2zkspWwdS9GNsfmQaVx007WxPdCipnvDvNql2RyZ6NcIP
         s6Kcg48n4Ccd76peh+fNFywlFjxFRVDR2KpEbLUkhiKsFmM43OAXwtMDwp0oWE1ZVQ4r
         rDn6qJnhU6deoN7P+QxGCqISTNsNeQtP0U7eWPorG3GK6Hizl9QYv+wUVO9cf424pGMJ
         iELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUDGzNK/xkLpzpOUb+4aJATdRFMr68eMkSoiXc4mVmU=;
        b=3YZmm1fHlxV7BAH1xnDq3zqXWxdcp2ghVIUNIvu3jRhKpEZtHHgy9M1HLUd5GguJwr
         rumPLvVuuc9lER/f0HLPZ9e4QfWTcArfekjpLA+Nqiistuwy83C8/vLHVBsu+cMnLvXQ
         ko7/J0dY6LY9bI6Nl3zAg5+WhsABmaIHs/sHbgcS1ZZ4/OtDX6ylo+DobFYDIHi+m/V+
         3yzqiQe0BMJZ8dd2V5BvDJlUOHxkj8HoQyLpHd1r8YMEQYDrW3xrHIj6AkM/9LSfVuyZ
         my5FAYaxzreHmuqROmzjWvj4IFU2qmOwZOjDWRAgD43zxUf1u+5wviYykHp5xNCkpiNI
         UyvA==
X-Gm-Message-State: ANoB5pl1w4R8j5+lDaVMiG3/w/ryr2hm1aVeLMfNMXA/Gz0KNC1216IE
        8RK/3Gx2lyKLWBvhC55g8GZ1yHxqqIPYMg==
X-Google-Smtp-Source: AA0mqf6wskJlx/2W+C/hRR2vdZSzYIi5xx5ABDrQRXq3SIH1jdBAELPS9wQOL9cUkwQGwZZnSI00JQ==
X-Received: by 2002:a05:6402:320c:b0:46f:d71c:e732 with SMTP id g12-20020a056402320c00b0046fd71ce732mr39434028eda.31.1671445973311;
        Mon, 19 Dec 2022 02:32:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p26-20020a056402045a00b004610899742asm4177918edw.13.2022.12.19.02.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:32:52 -0800 (PST)
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
Subject: [PATCH 1/2] cmake: use "-S" and "-B" to specify source and build directories
Date:   Mon, 19 Dec 2022 11:32:45 +0100
Message-Id: <patch-1.2-2411acc9d4c-20221219T102813Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-0.2-00000000000-20221219T102813Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20221219T102813Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than the multi-line "mkdir/cd/cmake" recipe provide an
equivalent one-liner using the "-S" and "-B" options, and then suggest
building with "make -C <build-dir>".

The rest of these instructions discuss e.g. running tests from our
top-level "t/" directory, so it's more helpful to avoid changing the
user's current directory.

The "-S" and "-B" options were added in cmake v3.13.0, which is older
than the version we have a hard dependency on[1].

As an aside, the "-p" flag to "mkdir" in the pre-image wasn't needed,
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
2.39.0.1071.g97ce8966538

