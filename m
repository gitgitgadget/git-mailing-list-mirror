Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7411EC4741F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A48920BED
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGxAS+kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgIYO2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgIYO2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB1DC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so3260282wmi.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=StAC+JuC7BCx37VzRLDpn7Fy15q3b+oQk3Au3tZXbAE=;
        b=GGxAS+kSV2ZFgr+zhmlz/15PC06OTg0Hg31nWHZ+el2+Cuae+C1CT9YRyk2xaASUmV
         8CBVweP7HY2+IF+MYrlba+1tdnbnG1KZBQkdF5P7c0GBd+hb84v5s8bdEhpC94ao+U1p
         8yVeSEf3Df7UlsZClt/JnzleKCoTavchxY9G4/KBQvi8Oh0XIQbp1Vi12dDwKUn3QmUc
         NhPJORpuJhhBjigs9Buk62lSfy45mmnA3Mio1jxLw0YV8TYO4pkpLVglxMqnORElOOyQ
         WJVPLLYNYXoNaUWPofXA6DYkUBfRxNDPEPovGgHzGmKmkVepXEfPJuAo9c4BJoGCwpgo
         t2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=StAC+JuC7BCx37VzRLDpn7Fy15q3b+oQk3Au3tZXbAE=;
        b=UVS8CfGx2F291HVQT5+/Sp7Nr9Av53aDwHaAREgKQW5BB0VxCFJvhPo1+BIUMezzm2
         qbxtRk+GXpJldZ8LIHyd7drgRUzeATIOwTR37FTie0ZgnIh+p1yR6zjQUX+rhQNcc/UY
         t2oTDFaly9udVO2Eocuz3T103jncvcx7z+x3VRigjTC4V8HOh/QY5VCO6THwcHWnjoq2
         ivyD7qsM75FC64lUFXSQf+LgxjI2w52hQMaqldg6+Nt9DvEN/YvPiDYtmXViOQ06FmoL
         NevkbAHrlsqu6FUfgOfeH0p0i88tZs4nS1qe3J3OfNTj1Op6ByFOyhc83EIPjfPL+F0f
         bldA==
X-Gm-Message-State: AOAM533oMjy6XLwVIQfVeI2e74RXd88wk2e3I6j/Jp2IFo1Cv4LY8EyW
        KuQMYaG9QVkijPkVKwDSSkviLxeluKY=
X-Google-Smtp-Source: ABdhPJwCJ23v+HA8salCOLD07ca2KZhisUILrXzgkOYM1EwgPhbFpegXdVunUZdfEQRd3jV1rQVdMw==
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr3507935wmb.138.1601044127488;
        Fri, 25 Sep 2020 07:28:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm3154502wmh.27.2020.09.25.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:28:47 -0700 (PDT)
Message-Id: <f07e4216669bcda728668d8c5cc99081bfca9f49.1601044119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.git.1601044118.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 14:28:37 +0000
Subject: [PATCH 09/10] cmake (Windows): recommend using Visual Studio's
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is a lot more convenient to use than having to specify the
configuration in CMake manually (does not matter whether using the
command-line or CMake's GUI).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 1eaeb8b8e0..442b4e69ad 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -4,7 +4,17 @@
 
 #[[
 
-Instructions to run CMake:
+Instructions how to use this in Visual Studio:
+
+Open the worktree as a folder. Visual Studio 2019 and later will detect
+the CMake configuration automatically and set everything up for you,
+ready to build. You can then run the tests in `t/` via a regular Git Bash.
+
+Note: Visual Studio also has the option of opening the CMake configuration
+directly; Using this option, Visual Studio will not find the source code,
+though, therefore the `File>Open>Folder...` option is preferred.
+
+Instructions to run CMake manually:
 
 cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
 Eg.
-- 
gitgitgadget

