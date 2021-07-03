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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC8CC07E9D
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9061438
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhGCV3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhGCV3N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 17:29:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40BDC061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 14:26:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j34so8791491wms.5
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OWdmvoLFvRKaZ00xRXQUel4GoLKe8gPH+g71h/kYGls=;
        b=YdJVgSFX2gM29l6O2ujSzhaShqp6YUXjBQFWBVtcT+mzT15uION72JR++tiZR5sK2A
         1lk1jGsWRTjRatVJuY7bVWbMs0v2NMkBmWfSFDcsqhBafDCi7yu+5IV+DCZfMFCq1qEy
         Byp+zrIuT9i50TjSUGA2PtTSxLcymIJElcBq0lDQ/8lLgDCg6jlyOJAWGbd+uvshy43x
         2WcHliWpJ+iEnlA6qxqRlUJy5Blp1ICbvCSSd9FAF/S/C2vQ3nyLnQgP15EPkH6jS1Mr
         7DxeeM7hw7DP2tWzPmCQ7/t+4buXh/8Ie4F5nPzIpzstEddHjKeu9Ev0MWUEJrNXY5An
         eUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OWdmvoLFvRKaZ00xRXQUel4GoLKe8gPH+g71h/kYGls=;
        b=oEcpTfW23+0u17+bOXDjs89KL4jnA8v35PMe+OmEF9R8/zBbBCJ2IzDZbX5d5GJ3/8
         sepGUIya7uJcfAcbT1bS73VmZoXxd5HhedndEqFY3Szc3r3UxNikvCaIIkiAYj4JH8wC
         wbuqRhWNcJJryDW8/VVOnYJWwrmtu+XAaY/Pc16cWLCCc3lQFGY5p6nZzLeln6gboUOu
         oO8Pon0/R8vObys3q9f64DLYJz+zOanYDlOCLtakZZEMcFyNBXeLTV3TMbbK3TbdY0lz
         DrpD0etkkwWCMFNdtEP2FlSBuRg0oKERUJVoeAXp8LaJfoYw8elL7VXcsBkbcEyKIXqC
         +65w==
X-Gm-Message-State: AOAM530lT9qi3TM2L8KR1VOu29LNkIIMJLSa7u/sKjsgMu08kqFRwbLp
        KQ1C7DM5fHwVBXSn/MHeAcQumfSnWlU=
X-Google-Smtp-Source: ABdhPJyCMSZSOpZSWY1UqipMriWugwld2qs+z+GTXreFZtRKdZCygCikRbxR4KX+PuH2uOexykwpgw==
X-Received: by 2002:a05:600c:b59:: with SMTP id k25mr6766306wmr.117.1625347596442;
        Sat, 03 Jul 2021 14:26:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16sm9181685wrx.63.2021.07.03.14.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 14:26:36 -0700 (PDT)
Message-Id: <59dc44428fbc168a5edbb6e6679c9b8aff8d74c1.1625347592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
        <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Jul 2021 21:26:29 +0000
Subject: [PATCH v2 4/7] ci(windows): transfer also the Git-tracked files to
 the test jobs
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

