Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB6BC07E9A
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2DAE613F9
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhGDW54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 18:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhGDW5z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 18:57:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C79BC061762
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 15:55:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a8so8041745wrp.5
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OWdmvoLFvRKaZ00xRXQUel4GoLKe8gPH+g71h/kYGls=;
        b=Gxm9As2Xt2y+NDVANJlw9HhYSBcmdG8nBlmL87wDcYFYho+sNMcagJB61XmsYA3eds
         DWSGUuCMfAsc73ZbLxRMdTw/H41phytJXysJLawLEiZd9O2Ktk5iw/uypuFzasO78cKs
         gnKstph39T+MM104dv/INAU54kEigFV+MmfQu8l44572HGxg9hvYP3gtS1be2t4qH5di
         8CsEtojY7yJAebBp19pPxgiJXmb8CnrVMVLb4HgauK2PEd4ihDcw64/7o6vYUaqM49fQ
         a/70MhMciXoMqwREBiDXCqW/D2nOUkfwZ3rT+QWLLIFSJQ5nBMBXlakK8ivI1KOkAkL1
         hRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OWdmvoLFvRKaZ00xRXQUel4GoLKe8gPH+g71h/kYGls=;
        b=SdSyGSNzAXveUqRnJr8YoMLoDj+2kHk79+cyz8IF17YQ7qACtzeRpN5UxrUFQeJMZN
         94nkXmaucw5tRLpdFQcG7zcqWyXZdsm8EC5/phIzNTJAcPkq0nxx6YO8501aAoW56+DN
         v7QZfu1KJEjXXu7VF8lpgRy3V9c5qnONMKDIcccl2J5qQ5CC2Zy8Mp1VWw6NZ7duf3+q
         ue7SDEk7MpkC27r5Myn0Hc9ICUUvWoibfkFw5/Jc8nXjcXw1PpO+Lfw8ESHGa+YhERuX
         zLNeiZod+6/39zUDNuLsVYcpdIHl0CX2nEY9cgTAQxSxpscs0bTRHvbCoVpl8AWrbXyf
         q70w==
X-Gm-Message-State: AOAM533/LE6bCARuiXWmq2UumwPM3cD0nTkH1d1A08G78wyaZoiWXEy4
        anx9TKPv0s1bz1qqx5L7KGKQe6eQfDY=
X-Google-Smtp-Source: ABdhPJyuI5NAMHgIl2S+jNqEGle+I+OB0R6QwNn+VLk9ldMfepePNtUIUR8KtSQwbUVO+imuENnLSg==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr12729517wrq.105.1625439318276;
        Sun, 04 Jul 2021 15:55:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3sm8223086wrz.89.2021.07.04.15.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:55:17 -0700 (PDT)
Message-Id: <59dc44428fbc168a5edbb6e6679c9b8aff8d74c1.1625439315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
        <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 04 Jul 2021 22:55:11 +0000
Subject: [PATCH v3 4/7] ci(windows): transfer also the Git-tracked files to
 the test jobs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git's test suite is excruciatingly slow on Windows, mainly due to the
fact that it executes a lot of shell script code, and that's simply not
native to Windows.

To help with that, we established the pattern where the artifacts are
first built in one job, and then multiple test jobs run in parallel
using the artifacts built in the first job.

We take pains in transferring only the build outputs, and letting
`actions/checkout` fill in the rest of the files.

One major downside of that strategy is that the test jobs might fail to
check out the intended revision (e.g. because the branch has been
updated while the build was running, as is frequently the case with the
`seen` branch).

Let's transfer also the files tracked by Git, and skip the checkout step
in the test jobs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index a399114c0f8..0f7516c9ef3 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -89,7 +89,9 @@ jobs:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
       run: ci/make-test-artifacts.sh artifacts
-    - name: upload build artifacts
+    - name: zip up tracked files
+      run: git archive -o artifacts/tracked.tar.gz HEAD
+    - name: upload tracked files and build artifacts
       uses: actions/upload-artifact@v2
       with:
         name: windows-artifacts
@@ -102,15 +104,14 @@ jobs:
       matrix:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
-    - uses: actions/checkout@v1
-    - name: download build artifacts
+    - name: download tracked files and build artifacts
       uses: actions/download-artifact@v2
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
-    - name: extract build artifacts
+    - name: extract tracked files and build artifacts
       shell: bash
-      run: tar xf artifacts.tar.gz
+      run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: test
       shell: bash
@@ -169,7 +170,9 @@ jobs:
       run: |
         mkdir -p artifacts &&
         eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)"
-    - name: upload build artifacts
+    - name: zip up tracked files
+      run: git archive -o artifacts/tracked.tar.gz HEAD
+    - name: upload tracked files and build artifacts
       uses: actions/upload-artifact@v2
       with:
         name: vs-artifacts
@@ -182,16 +185,15 @@ jobs:
       matrix:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
-    - uses: actions/checkout@v1
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
-    - name: download build artifacts
+    - name: download tracked files and build artifacts
       uses: actions/download-artifact@v2
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
-    - name: extract build artifacts
+    - name: extract tracked files and build artifacts
       shell: bash
-      run: tar xf artifacts.tar.gz
+      run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
     - name: test
       shell: bash
       env:
-- 
gitgitgadget

