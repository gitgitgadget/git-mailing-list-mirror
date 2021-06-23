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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5DDC48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BBB610A0
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFWP0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhFWP0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 11:26:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46970C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f15so3094406wro.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MZlWXg3zGS+JvN+bAAm49SeIPF4y/Zt1F1SorzzxIPI=;
        b=T2GnS/6qgbAOEtH7tylDVHgWlqY+70WSCo81xlqP+hef3BEPU/HgIM60rN7wkBq7rj
         oDnrtlBFwE3aMf1lhgKRHeAxu+o1GS4muBSESx/CKe6KJUZ48WY14hzvMoQ05ajcO8et
         OxXNTU7hUjcLY7d4a3rcXQXmKq4w3F/3WV+x/CWztYlaQtEpFuuKq0Gy50GfM7P9Y8qX
         Ljpk9WTTqtoRyxYVFpY3ei72yz7dE6+bitBgBp1GkiWHS6iVyklBPaSvqKrX1CLmfssW
         4nIVybtSOhojnXp3SbKiyGyK2RMzAqXyQaIt5WSn/0wbObkos9OSva0mE3C2Vn34oEIw
         PWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MZlWXg3zGS+JvN+bAAm49SeIPF4y/Zt1F1SorzzxIPI=;
        b=B/S76HK+BXMO20ipDlScOo4qWZfmKt422gDQG/C/U8xALlWr1KWhiFvrvOGkqtovON
         HRbYGzWSZYjPaWvZ893YJtfnDJBYDw4pq6C2WE5n+AToG3nc7vEdxDQ/CtvZdxyBRhP3
         cZyQmLqGMZqvk5n0kmLkZJjRm8QcqpaHDeyKFd0Q05whL/qHwBjV7Jq5xgz1k+B9zRHG
         Q+6/LNF/fsLISRT21wnjfaddU3d6wfQBoE4WKiHWu4Q21isclfg4kXl8agokjeBIYlrK
         lPz3MPiT7zVXbvuWb2mzsCJYhrKaSW11mRf5eaCNeB2/stH74CjqPCM9UI/M12j/jqnS
         RXuQ==
X-Gm-Message-State: AOAM5336ulNFk0ivD/15Z8/EHPpiu5tYKH/8Yl7Cv+IvdqGeQAbSiLBf
        er085yhU4qoma+qsvQBKgiNlq4skUNE=
X-Google-Smtp-Source: ABdhPJxsyc7zBQNr0BkSVcm4dHpX21R6lLeulWFjQP08/gDVPosXR3Iy5TB7zlRNm0AB10hSSwok5A==
X-Received: by 2002:adf:8bc9:: with SMTP id w9mr658750wra.378.1624461860928;
        Wed, 23 Jun 2021 08:24:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o20sm6133265wms.3.2021.06.23.08.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:24:20 -0700 (PDT)
Message-Id: <1520a9ffb574652fda1d2a20c97dc859fa476945.1624461857.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.1624461857.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Jun 2021 15:24:14 +0000
Subject: [PATCH 4/6] ci(windows): transfer also the Git-tracked files to the
 test jobs
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
index a399114c0f..0f7516c9ef 100644
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

