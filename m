Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BFC07E9A
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BDF613D3
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhGCV3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhGCV3N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 17:29:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2D2C0613DB
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 14:26:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l1so8788380wme.4
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OZTzR01ECxBymzSoayWdhb0eSWSZDeJvZ5Se3aZe5BQ=;
        b=h373bSosPK+aMWv0Oxo//o4FZoHBehlDvu8ZIFXN3LMSDXvQivbwWHhGuVbS+AfGhn
         4bCKRlFmTh1ZC3DqSLQREfxKhLSWf5+V5H6Z0z5MsxoPA/V2jSZBPm2AKvVhKZX6mgUq
         1bPUZWPQs0KrmV/stg8DhzoZM3uhKUTgASsqzFL0uR7/7imm7g1pwOV9lz3vn87DRplh
         M4HIBmKxEnaIBgEAk1v8m1X5sf8lASTQqpSJ08inBMwD/u+jORb5ZYGQ7kvOhI8kv4QS
         k1fL2BNk4sMI9OT3RpJHSGGm9h94qptg6D5yoL9niW2T0/fG80Nm9bWab9OiuIf8iFQ6
         ZUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OZTzR01ECxBymzSoayWdhb0eSWSZDeJvZ5Se3aZe5BQ=;
        b=f3TimZVshOWLxSp4K0QDvmCkywKr2IN7dyO4ebCy4LapUp/PRpelOtwgnlJndiki18
         qDOOx/Os5KHq9LFQb4F8mOFso7zayJP5+ttTNg7HvbPFc2a5eL8Cf6dTAgN+Bp5r96mh
         trHwmWwf0B5Y4vZ4is89yFDlrZdu4SsrBdO8B6Z6xs2pObDWjGnlQVeORPFpTKS6PRLa
         nmbF4W6uy94LX1CE5kIBahok6JmJoyCNuRiR3CSSfzfbpC4vgLZTB0WIXSEVh9rpmmns
         OoNCP6HmKgh9J+zw3ar6hnFF90v4yZ2lp6lTyoT7gGvvxyCDomfx1NB1QRL0E8rAcwX0
         +Uag==
X-Gm-Message-State: AOAM532duXOqHVbMO/u6LlUTJRrK/1d59ebew5sBPQPTRhQGBps68Yhq
        YUrewMa/pewqjvNdt6DaQ/PwtOBaq30=
X-Google-Smtp-Source: ABdhPJyLmdd7B7uvixSjcdaBuUH+5P2V2p+ep4gzm2bQoDbCW59lhPmv3TpwyuK1OW7HzVimLQT6pg==
X-Received: by 2002:a1c:f016:: with SMTP id a22mr6590631wmb.65.1625347597931;
        Sat, 03 Jul 2021 14:26:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm7117315wmn.44.2021.07.03.14.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 14:26:37 -0700 (PDT)
Message-Id: <88a44863cd013fc9c152ff91cf109fd7b1073257.1625347592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
        <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Jul 2021 21:26:32 +0000
Subject: [PATCH v2 7/7] ci: accelerate the checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By upgrading from v1 to v2 of `actions/checkout`, we avoid fetching all
the tags and the complete history: v2 only fetches one revision by
default. This should make things a lot faster.

Note that `actions/checkout@v2` seems to be incompatible with running in
containers: https://github.com/actions/checkout/issues/151. Therefore,
we stick with v1 there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 3b40c677ab5..405204c78a7 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -81,7 +81,7 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: build
       shell: bash
@@ -134,7 +134,7 @@ jobs:
       GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
     runs-on: windows-latest
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: initialize vcpkg
       uses: actions/checkout@v2
@@ -237,7 +237,7 @@ jobs:
       jobname: ${{matrix.vector.jobname}}
     runs-on: ${{matrix.vector.pool}}
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - run: ci/print-test-failures.sh
@@ -282,7 +282,7 @@ jobs:
       jobname: StaticAnalysis
     runs-on: ubuntu-18.04
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
   documentation:
@@ -292,6 +292,6 @@ jobs:
       jobname: Documentation
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/test-documentation.sh
-- 
gitgitgadget
