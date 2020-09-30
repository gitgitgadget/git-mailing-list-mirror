Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A01C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA4920759
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxmcagBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgI3P0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbgI3P0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:26:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8ACC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so2269325wrn.13
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aA+G/vxeATnqubeQXxe1fG2bCSFpx19fAU1b++4OAwM=;
        b=HxmcagBpJTmnY27rDaa1ZEfAN6E7WulNdy2xjt0HKF5GB0jo2HUK+nNoI/nkivi4h/
         Luo2aRNnl5SacxIdbm8H8daHDEsO371J66pNsgcbVgAwh0Ljbmw3zyYwT7hx3BYZ3UVN
         qPpGExwJFhqB+ljtGcBwSEkAKILkda+2eNooCc5tgQ0nSToFejg9hxMjFL3Lua7a9Faz
         CXHP/ZfmEV3IGY3WX1G3XUlSs1DFGPTUEhF3qSnMWfhDIfMjx5TleMTJ/duiZOGdDON/
         SH1Px73U6VItFOu2oprZDyZc+W/pTsXHyo5WFTUpfPFQba9KXfnPyKnvryjn1RsQE5+i
         4fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aA+G/vxeATnqubeQXxe1fG2bCSFpx19fAU1b++4OAwM=;
        b=P3AexIqSmtGRh5HNQ0is/+uM3C5DTOMDS2u5G3nwxKiBs+gr51rMxQFZONCazlgcpC
         DP8nqC+SwapebXhyu0yiva6UjwNepMJnslWxVZ8Xwj3wewme/7REKFeAJ9DKuoK02HW3
         NOdGlme7vG/GKzwBvY0DwIByDuZNj7xvjILCUbFiZPfU5oKWc/tsJ3zV9mRSELGzXneV
         L+gQMANflPaC6PrtyPql9f80BJqqlIrdsaoYaASc0S8t6KCUZqO4jBa46PRIwVrZBGdg
         6A2M/c7uyWEOUJpC71sM0V4NwsiJHKvxu+VjzR3Dow0wUUjirtgxZgGtRhYZmm8FQld0
         kZqA==
X-Gm-Message-State: AOAM533HQB3YvlMJpPWRGzhDjduYe9IqKNNh07++eb6nKlVFU+6MhvRb
        PRAKqUOiR/t8OkipnmXFUshxOKsbA24=
X-Google-Smtp-Source: ABdhPJypl0VS+oxGuqwOLWLqayvOIYUI6L/Im2cg905LBXUAR+Qhi1boGKhf2OnlBoolCUcxZNiSxg==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr3740742wrr.402.1601479593232;
        Wed, 30 Sep 2020 08:26:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm3739230wrq.67.2020.09.30.08.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:26:32 -0700 (PDT)
Message-Id: <b239162eb2be6309b6aef7ab08cf100f4b63e3bf.1601479585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:26:23 +0000
Subject: [PATCH v4 09/10] cmake (Windows): recommend using Visual Studio's
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
index ebadae2271..df539a44fa 100644
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

