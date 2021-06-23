Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB0EC48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8270A610A0
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFWP0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhFWP0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 11:26:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519ECC061766
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d11so3161678wrm.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wkS9XD+Bfyy6mgoJrEFk+IPYjLyu1Pucet3Q7umxtlA=;
        b=eaGYNHM1I0KuyoAdwLbTA3mzlgDvcO8RIptkXwEOfxfqDarnQvAdgawktffn/tYTuZ
         XMj/mGaRHoRL9DziYNgL+wtecgcJTRcAG99lUR9Rg72lgr6fI2Jlc5DzYCPY5c4tf5qA
         tFkJmHXCwnBycFINYQBDJL88UO52ESYeoJ5ffI8oH1uKIjZRnx6RexAgdbtzweQ+aI2K
         iwKXj77D8qH6GlPNVNgFw0QD4+5qp2mN9i8h0sR09mCpzZZagvV1eOxuvHkurj8fQiG1
         UUNlqGT3uGPfx39FZcZZBwgCqGGIiTKDjNOXtME6VnTzH0SQ7aBh1CusKwSmkOO89fbn
         kBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wkS9XD+Bfyy6mgoJrEFk+IPYjLyu1Pucet3Q7umxtlA=;
        b=Ml3UdSuDWaAg2EhgfELI191iH/tN5jZK54EBbVxF/KVQ5MCb3tiFPLZOsiGxoEeKR+
         NabUnInPOwoAUELurctdkGMGOhS2hg8US6gfBa1MCFpUxfQ/oCNYLHGC6j/jLbh1XYXg
         r7/Nhw8ADRRdOA1VMt+ZVA6ZMS6ORe3HuFRXQKQBI6XjGr9Fq5hKnQLdJagG7StGInu0
         J5WzHu5kO612TGijKbqZrFsifJvw5EpD8dElXsDVRd1HYaLTW4jPfwAGzb99LCdGwIV2
         OAZiCauxy3QEWUMXaaRTAbUiraXuTsUFqprQD8a5pPUOHR3nKQfqY+SF22p4OKipRCpQ
         +S5Q==
X-Gm-Message-State: AOAM530VLnMZsYGKukW6gQ5j1iOSMKVA2wFRRa/AKVU9jim5ghFUIlMQ
        HboU9qUd5w12adUJG7lWNMunxalLrIA=
X-Google-Smtp-Source: ABdhPJycjFw+63i/0a7TCE5EpgM09a3Poiexh1O9nr3hY/1l5xiqEJp4ZQhcGV73ki1BK3I8pD2eBg==
X-Received: by 2002:adf:f284:: with SMTP id k4mr634086wro.177.1624461861989;
        Wed, 23 Jun 2021 08:24:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f22sm239779wmb.46.2021.06.23.08.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:24:21 -0700 (PDT)
Message-Id: <e772d8f1d9b9e044833d715cef89bc43876b31d8.1624461857.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.1624461857.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Jun 2021 15:24:16 +0000
Subject: [PATCH 6/6] ci: accelerate the checkout
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
index 3b40c677ab..405204c78a 100644
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
