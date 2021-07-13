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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55556C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 11:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389F661008
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 11:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhGMLyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 07:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbhGMLyT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 07:54:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88856C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 04:51:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f17so30098563wrt.6
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lGuF0HpN2bwTdT++Ycdzu865KJTc/5O/a45lLjBPClE=;
        b=O8T4Bllrj/qsqyf+dlg7wcJGbJl3cDIlqwz+rymRsqadteybbgZodEUKy0ngVADavJ
         LXsna8gQ4p2CcD7PZHTdzcVQ9Prc1XlKApUSeiJ1EbH70KlptEm61wdI0zNcnReRGNVL
         2EtnuNNqdH2vutJOk6aVIQ0qDChIJHVSkKiHtGQbsUbePTcT3VizsYIAaIKfojWfEnb3
         9+xON32AX3dY53fEsy+3ht4xv9ULDECLPSu7e0UkpU58NeO56vBu2oyHQQJRLi0bCA4g
         x8kMQDToutgRvf6tdUXAoQGAf5FrVl2WMrH6w7wfyqskE2xEppRRsC/IUv1umJuPt3xK
         9n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lGuF0HpN2bwTdT++Ycdzu865KJTc/5O/a45lLjBPClE=;
        b=l4E5JTr77ss5ng/kCfPrIbQ3FQ+0EoJCn8tHfOKtMWg0mtM+J5YnqCmON9Ev3rxeJC
         m519EvEnY4AFsTOAJiBM2pnMwHS/5hwUcaDUxrsBRQ9ZHdAFASs8PdzeypZ/2fi/E2Bq
         gEy80mx8aoKK1a2mcVY9Nc0Xfbi/HhQlbyBTu8PTLPx8dRpxXl2NjIVn0fsDhAcsyB4x
         b0gvN2avON13WUAYq5CkPDtAGZQ+YD7nW4LdjV73D9eytNK/brG6B6t91/PrEfkDBuBi
         dmBwei1eR+DBea4JgCFoy3affUt6O2kvsGe6x82SdhoErReTQ2WgovTUflt0ym6E8ad8
         ZpwQ==
X-Gm-Message-State: AOAM5302WoCQDTz7m7oz8wfTB46Q1DLCTv7qv4e2WZ1kvwNRwv6g19JF
        +gbYbbiFdUUuw70D4vymglZ0HGsDvPg=
X-Google-Smtp-Source: ABdhPJxlqFQ5fdmwIW1wjIe6UmxEmw2u688frGnkGxnlX7m9o9Hb8z8Wt+xATx9HDUFqGj/vuTvDOQ==
X-Received: by 2002:a5d:4449:: with SMTP id x9mr5159781wrr.52.1626177088152;
        Tue, 13 Jul 2021 04:51:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm3085851wma.48.2021.07.13.04.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 04:51:27 -0700 (PDT)
Message-Id: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Jul 2021 11:51:26 +0000
Subject: [PATCH] ci: run `make sparse` as a GitHub workflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Occasionally we receive reviews after patches were integrated, where
`sparse` identified problems such as file-local variables or functions
being declared as global.

By running `sparse` as part of our Continuous Integration, we can catch
such things much earlier. Even better: developers who activated GitHub
Actions on their forks can catch such issues before even sending their
patches to the Git mailing list.

This addresses https://github.com/gitgitgadget/git/issues/345

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: run make sparse as a GitHub workflow
    
    One of the earliest open source static analyzers is called "sparse", and
    occasionally Ramsay Jones sends out mails on the Git mailing list that
    some function or other should be declared static because sparse found
    out that it is only used within the same file.
    
    Let's add a GitHub workflow running "make sparse".
    
    Example run: https://github.com/gitgitgadget/git/actions/runs/1026303823

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-994%2Fdscho%2Fci-enable-sparse-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-994/dscho/ci-enable-sparse-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/994

 .github/workflows/run-sparse.yml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 .github/workflows/run-sparse.yml

diff --git a/.github/workflows/run-sparse.yml b/.github/workflows/run-sparse.yml
new file mode 100644
index 00000000000..25f6a6efb40
--- /dev/null
+++ b/.github/workflows/run-sparse.yml
@@ -0,0 +1,22 @@
+name: Run `sparse`
+
+on: [push, pull_request]
+
+jobs:
+  sparse:
+    runs-on: ubuntu-20.04
+    steps:
+    - name: Download the `sparse` package
+      uses: git-for-windows/get-azure-pipelines-artifact@v0
+      with:
+        repository: git/git
+        definitionId: 10
+        artifact: sparse-20.04
+    - name: Install the `sparse` package
+      run: sudo dpkg -i sparse-20.04/sparse_*.deb
+    - name: Install a couple of dependencies
+      run: |
+        sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev
+    - uses: actions/checkout@v2
+    - name: make sparse
+      run: make sparse
\ No newline at end of file

base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
-- 
gitgitgadget
