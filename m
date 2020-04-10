Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1ADC2BB86
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E882087E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL1HxgYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgDJRSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:44 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39800 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJRSm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:42 -0400
Received: by mail-pj1-f66.google.com with SMTP id o1so135333pjs.4
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGE3C35uALGSi+jQbWFuezr9Lt/mGlPAfYT4Loyh9KU=;
        b=DL1HxgYSbss8wzIOp7YJ+TIZhymIOeURFWKcBdTEQkVn8KdjEYYPxabSik3jJgIZ1A
         0O1b2h9tTo7KDgWPCNE4a2A7II7cUKoWzOi03+fVdvdeyt1DBTnHgU5xyGlW1opV+bbV
         meXG5k3oDtuKBwxzMba0c1L1DkSxwThZ3axqAx2imSo774Ce5XjwjSnHnRyK9HOlhP8g
         CLIsY5rgssvBWXunHCdkLimujGYXoT+84tYyJaenmDnCrO7+OX78E3Kdvfmt7mwuKlzk
         FyXV4+OT6qsptOQk76AwUOntYLPgzGGVCFjImOzrbWDoFdc/Bl5iDLDuZpMFOgsBvqsz
         oH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dGE3C35uALGSi+jQbWFuezr9Lt/mGlPAfYT4Loyh9KU=;
        b=i8z3jO+9Bfjyg6HmO+togYFbTb1Tb4MlBM2C8KS7pk5wmvFm9NG0DRrdceZn1Cfpe9
         plqLOu0MMB3ywqz8ZR4qqQXCRkysdE0XrTFMY5y9FfxMFpJZ559DP3/PrOYIkdrvsqsw
         QOZu91C2pUWYRsgbhBncYZmGjBexYZpqExHkQqvNiJ+MFbEBTgyXX0ZKWHYE5pqtSYvX
         O0zc4X/yoR0FsuInf60yXDm9ylKd5gzcZ2V9hWZnYw7+2lAQjXu9aZt3vu0awJbnjrL3
         J6MleQQaosfs5UjhlHMd7fAxpKmPVLFuTobBvDeIE6022t5EFY3oeqSmxi2rY1g4RSBD
         4y9w==
X-Gm-Message-State: AGi0PuYN+dQIfnmMuyofDeMKrGdIn4Y3iLmlJ1zhmjDzOlIn1a898DI9
        gOW6q0/mgTJRKWn0LcYM0obkrl0U
X-Google-Smtp-Source: APiQypJ7CmAu1v6VBT3oRZR0lKnFP/0yzzaTyuk/t6YX+yX/C7qC+d4vvsvQxolyvH2EIi9KK9bEKQ==
X-Received: by 2002:a17:90a:d350:: with SMTP id i16mr6480004pjx.121.1586539122188;
        Fri, 10 Apr 2020 10:18:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:41 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 12/12] ci: let GitHub Actions upload failed tests' directories
Date:   Sat, 11 Apr 2020 00:18:14 +0700
Message-Id: <8de46ee1c6e0e9cab91008c27f097f6f37ed5ca8.1586538752.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586538752.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586538752.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Arguably, CI builds' most important task is to not only identify
regressions, but to make it as easy as possible to investigate what went
wrong.

In that light, we will want to provide users with a way to inspect the
tests' output as well as the corresponding directories.

This commit adds build steps that are only executed when tests failed,
uploading the relevant information as build artifacts. These artifacts
can then be downloaded by interested parties to diagnose the failures
more efficiently.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml | 18 ++++++++++++++++++
 ci/print-test-failures.sh  |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index e1ac6d23b4..fd4df939b5 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -63,6 +63,12 @@ jobs:
       shell: powershell
       run: |
         & .\git-sdk-64-minimal\usr\bin\bash.exe -lc ci/print-test-failures.sh
+    - name: Upload failed tests' directories
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      uses: actions/upload-artifact@v1
+      with:
+        name: failed-tests-windows
+        path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
     env:
       MSYSTEM: MINGW64
@@ -176,6 +182,12 @@ jobs:
     - run: ci/run-build-and-tests.sh
     - run: ci/print-test-failures.sh
       if: failure()
+    - name: Upload failed tests' directories
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      uses: actions/upload-artifact@v1
+      with:
+        name: failed-tests-${{matrix.vector.jobname}}
+        path: ${{env.FAILED_TEST_ARTIFACTS}}
   dockerized:
     strategy:
       matrix:
@@ -194,6 +206,12 @@ jobs:
     - run: ci/run-build-and-tests.sh
     - run: ci/print-test-failures.sh
       if: failure()
+    - name: Upload failed tests' directories
+      if: failure() && env.FAILED_TEST_ARTIFACTS != ''
+      uses: actions/upload-artifact@v1
+      with:
+        name: failed-tests-${{matrix.vector.jobname}}
+        path: ${{env.FAILED_TEST_ARTIFACTS}}
   static-analysis:
     env:
       jobname: StaticAnalysis
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index e688a26f0d..92a983a265 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -46,6 +46,13 @@ do
 			mv "$trash_dir" failed-test-artifacts
 			continue
 			;;
+		github-actions)
+			mkdir -p failed-test-artifacts
+			echo "::set-env name=FAILED_TEST_ARTIFACTS::t/failed-test-artifacts"
+			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
+			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+			continue
+			;;
 		*)
 			echo "Unhandled CI type: $CI_TYPE" >&2
 			exit 1
-- 
2.26.0.334.g6536db25bb

