Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3BEC49EA5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE1E6112D
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFWP0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhFWP0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 11:26:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD233C06175F
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m3so1902132wms.4
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L3klJRPQBsUOGiYLOmapQxnaCe2Vx29JCOhSY9CvEtE=;
        b=gyojfb7ABghch1/cAFlh69Q003A1rvJAPP3MHwdpj0IJtR3wEFDcXVlivnj+AHsHWf
         SL3faDvJ7ZEPxfFo8Of780X05TkDyD2NJbEEo9y0twYqXOsku9EwjXzvXyd8acUDeNgV
         As9t2siZJ69WoYAGZUU5Xb5MJnAu5/C092cRDs9b1I4KQRNope639Dk0jr0R2AFMSUZy
         fCSGTMEODZKfkU/BQYDkdzkp0NneJQt3wwk7GvexvBkqCuIqRKJPoeQngAyywkf3kEn7
         UzJsBQ9bEPuVdhAXDdJ9RwslZq1wW7g2KgJjRnxRTdSS9740+6/SFgr8P8Hio0hje69x
         zmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L3klJRPQBsUOGiYLOmapQxnaCe2Vx29JCOhSY9CvEtE=;
        b=pocNNzZwFeNJphnqA0SlDhj2XIfLHw+NBeL8dFou2TLKKleBn/dDoMU93aYLtXqV3K
         8X83eI+zOGS5CLKGdfj/mDZsmnsUzFJhAWtgiAGhEzMiPrcOJZIJhssQMh9Gjh8UWver
         DVstxnI+nQKShI9bc7N16p/ex/8m5ZFv+3hETNIesh/SpehWVrCuXXyiotrrA8eTMqJ+
         JRS7Z3dnCCwy0T8cihwXWV9YTr+UB0dRW47Xot22XyZ/BKh0ZqgWa+eFRTpunFel4BH1
         hK7G1jUFmPwuG1D75z7jSfIt4sKI1VWpbCVOah0xT55+X7CCgpThJ9NIV6ZvkJRirWlF
         5veQ==
X-Gm-Message-State: AOAM530Xp3NgjUKlQAGKFxslsu6ebGGb2DmvcJsfScp9FvB2KCS2cn+x
        EyIR5gBF6QiM/DtyGYnCqj+NWuQkrG8=
X-Google-Smtp-Source: ABdhPJx7ICNWPVJ1B4y8vQnPLYpO0nZM6qgNCZvvl/aDg29vX59gK+cFmNUUMg6lHO2XKf8fqDCnWA==
X-Received: by 2002:a05:600c:321a:: with SMTP id r26mr11350449wmp.90.1624461860401;
        Wed, 23 Jun 2021 08:24:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p187sm268267wmp.28.2021.06.23.08.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:24:20 -0700 (PDT)
Message-Id: <7930465e80971eeef79aff012008cd43199cfb50.1624461857.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.1624461857.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Jun 2021 15:24:13 +0000
Subject: [PATCH 3/6] ci: upgrade to using actions/{up,down}load-artifacts v2
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
index d430c4e0d2..a399114c0f 100644
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

