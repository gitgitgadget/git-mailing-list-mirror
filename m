Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2FFC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40DD613D3
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhGCV3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 17:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhGCV3L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 17:29:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBBAC061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 14:26:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l8so16966299wry.13
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1u8MGfSxgCE03cekx/+oC9KGRE09BcEKKiz0MnCYhaQ=;
        b=mHOz/5MV5OsOeRgGqOw9jlqKGRBUeth+mIYSE5GfPJtXTDkhhDwa/qj78Ul/3LfiL/
         dYkTCuxLeEZ3Y4LNqBcfTvg9YnuJwNrmD7rkgmywy9JamLjwOGT+CDtrWrw+Oyyz/cai
         MgGSYLyaseQKzqcLwK4i+CQ+Cg7ME60ngZIFKxhlPofLzjoufIneijXBYOwf7mO+pUwF
         4kE4kEJVCXwMbzer1whnvvq9TXNIucE533WkBKaPgUOaKsLKfwBPgBZlHfamSh03EXqH
         ax3hW165xCvrQ66eHO6pD1dmK4PGIgRADEqPeU+jNYne/5Bc1cJrIN+hYXj6xPqnxFW2
         WcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1u8MGfSxgCE03cekx/+oC9KGRE09BcEKKiz0MnCYhaQ=;
        b=QwbmJCEbLPZTpqe+RNC6Wl3tiL21SyDXFJSIpLUK9A5tf/OuhXCNoP+wuaduRcto5O
         CWBc9iEGRgRrwlkCDuXtGkOM5RgSGjO5fn3gOUDzCCLJ1qdLKMM+h2uhh/D/o5Qk4jAN
         reuBsEWzAI8KtY8RR3LxzAzmEzRZSG30hnW7vnBCS7uZ+pU/lPZmEBy8xIrJqTVz8bZR
         DRFzbB+atPJFKex/Hnyh7yGL7RJKP0F+9zMr9P7jKFC2yP7ushzmZq2Kw283Z1P0Mxq2
         WZQvFmQW5mWa2gmGgv3JsAkYxROl7suoU35sMcQlKVvY/jlsPisImhiZsdvF0HuM/A3T
         BMFA==
X-Gm-Message-State: AOAM532ed8XgwGuqipvWL0zYlSMGv1sw9HuMPMh1k3DlVwfgH7q20ooj
        1PEXDimYjfv2m4r1uSlWUaohBgkPd5o=
X-Google-Smtp-Source: ABdhPJz0Yc+p3iM3jNdVQFPYAY2cr5eCP5FPt7+7ZFS8K08PZfhJh20apnxmxmx0mnq7Dc30QGKlfQ==
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr6865854wrx.191.1625347595940;
        Sat, 03 Jul 2021 14:26:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm7215501wmq.45.2021.07.03.14.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 14:26:35 -0700 (PDT)
Message-Id: <c256bbf4b1ce5f8fc13ca3aae47618b87985a906.1625347592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
        <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Jul 2021 21:26:28 +0000
Subject: [PATCH v2 3/7] ci: upgrade to using actions/{up,down}load-artifacts
 v2
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

The GitHub Actions to upload/download workflow artifacts saw a major
upgrade since Git's GitHub workflow was established. Let's use it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index d430c4e0d20..a399114c0f8 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -90,7 +90,7 @@ jobs:
         NO_PERL: 1
       run: ci/make-test-artifacts.sh artifacts
     - name: upload build artifacts
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: windows-artifacts
         path: artifacts
@@ -104,7 +104,7 @@ jobs:
     steps:
     - uses: actions/checkout@v1
     - name: download build artifacts
-      uses: actions/download-artifact@v1
+      uses: actions/download-artifact@v2
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
@@ -121,7 +121,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -170,7 +170,7 @@ jobs:
         mkdir -p artifacts &&
         eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)"
     - name: upload build artifacts
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: vs-artifacts
         path: artifacts
@@ -185,7 +185,7 @@ jobs:
     - uses: actions/checkout@v1
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download build artifacts
-      uses: actions/download-artifact@v1
+      uses: actions/download-artifact@v2
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
@@ -204,7 +204,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -242,7 +242,7 @@ jobs:
       if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -269,7 +269,7 @@ jobs:
       if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-- 
gitgitgadget

