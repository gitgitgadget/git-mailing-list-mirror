Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448AEC4727F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE452100A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpftEE7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgI1VJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgI1VJb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E435DC0613D0
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so2877137wrv.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=59x1AmiheC+liIcCpQBp+o2x9UMjcoDT6jZnO4S/gkM=;
        b=OpftEE7id4G7NinoheatBxRXOPw5YB6tHpEf80IQuZPFxh5pRJUADiE2f8oS1zi4vr
         7QnG1RmOR7udDhNPDmnWVDH2h0xguQZKT1lfP+uEqneKX9krtcITcSvMf3SVQ3P9cmWr
         YHr4DXi+BPw+brYFCBQeyDylQCiPG0Bup47n4FzNA/NOiogV2PAYooi/NsTtyVCCNEUM
         jzxG8oW79vH2hlCOShGxTP6+slYudmqoSUxXpGYr6Lo3qZbPJpOcCWYK8BzyBn4v0mZW
         SJYRNnHANR9dUfm8zYA1PjaGihONvXmWUhrPcNOQLWHnwS/T0LUqgnSjfeY2IpVu+KTX
         FTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=59x1AmiheC+liIcCpQBp+o2x9UMjcoDT6jZnO4S/gkM=;
        b=VyfZZTcVp/VwmrX8F1rqhCIAbVKz9E88PfOvThxs7PkYgf58qMe2uguxWXak6ATCMA
         MbGO8yn1EYrl9SzQDXWDxj/tedVlQ/rvHGwGEBK/WhgfajWRrTFXzs3S6G3tcg/a7qVM
         Rx5iQ+1dEpAOra0K9YLlGTq5m8yjBsPANsarJtVXG4y942a49qW8MqA6xcTosvum2tF6
         ixGmvvBLgoNEuNAAGNTWjWF3RJEWh7F8dHerRx8o9JhOYWDjIoSy5epNoSjLChIUcMWB
         fgGUhe8ppy+K+CQRe5mQhHUNbbBM2vonySJAF8QMs6q9MFGAfpK31OCjrM5atdNVpDry
         p9Iw==
X-Gm-Message-State: AOAM5336YapIbT+nlNUOItA/8h4+RF4/vHAtabjWoYApXvkQPvQTBYet
        1XzRaMIIDKLapdvl+YYV3T0LMdllw2s=
X-Google-Smtp-Source: ABdhPJznrDiXq1yZgnKYQqxa9OSqroz1PI0IkbsqH7yBtMHDEd1p5EiSzncN5CxNVEMIwCRAgPIchg==
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr333684wrg.335.1601327369481;
        Mon, 28 Sep 2020 14:09:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16sm2917506wrq.62.2020.09.28.14.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:28 -0700 (PDT)
Message-Id: <ec182738f0f8344f6fbea869990200aeb8e94e58.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:14 +0000
Subject: [PATCH v3 09/11] cmake (Windows): recommend using Visual Studio's
 built-in CMake support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is a lot more convenient to use than having to specify the
configuration in CMake manually (does not matter whether using the
command-line or CMake's GUI).

While at it, recommend using `contrib/buildsystems/out/` as build
directory also in the part that talks about running CMake manually.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 6a92ec9763..4b16744847 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -4,17 +4,25 @@
 
 #[[
 
-Instructions to run CMake:
+Instructions how to use this in Visual Studio:
 
-cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
-Eg.
-From the root of git source tree
-	`cmake contrib/buildsystems/ `
-This will build the git binaries at the root
+Open the worktree as a folder. Visual Studio 2019 and later will detect
+the CMake configuration automatically and set everything up for you,
+ready to build. You can then run the tests in `t/` via a regular Git Bash.
 
-For out of source builds, say build in 'git/git-build/'
-	`mkdir git-build;cd git-build; cmake ../contrib/buildsystems/`
-This will build the git binaries in git-build directory
+Note: Visual Studio also has the option of opening `CMakeLists.txt`
+directly; Using this option, Visual Studio will not find the source code,
+though, therefore the `File>Open>Folder...` option is preferred.
+
+Instructions to run CMake manually:
+
+    mkdir -p contrib/buildsystems/out
+    cd contrib/buildsystems/out
+    cmake ../ -DCMAKE_BUILD_TYPE=Release
+
+This will build the git binaries in contrib/buildsystems/out
+directory (our top-level .gitignore file knows to ignore contents of
+this directory).
 
 Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
 compiler flags
-- 
gitgitgadget

