Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B26C2BA80
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA6320730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjofB4kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDHEGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:21 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:40919 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgDHEGT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:19 -0400
Received: by mail-pj1-f41.google.com with SMTP id kx8so639508pjb.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGE3C35uALGSi+jQbWFuezr9Lt/mGlPAfYT4Loyh9KU=;
        b=rjofB4kgydZ+5tCR8TUHmOQ2aZVDkb0Lsig7G3P8jdjBgLX1y2v52rHgepmNRMb++t
         phhfjUCdf+/5yVW6pEcbb+MzFmOrDOBn+0XZEsP6CVfj5zLt0Nk0TH+AZ+Cph8wBBi+s
         aec81oBIEH42FXeDtTGQhR7IhCw2GZEtcbh8vZpJn5odz53RF6RDjv5Calk1qfp4ASFR
         TUjFVI8tChdQLxYOayDPT2gw649P0PfJzflCac5tqIS7fdJrzBzMtYTrFkD9ySwvoLFi
         YVdD480yxdAm9Ic7cyd7+0IOXa2KS9KAlYSHu6yCgBbHg9Uiy6MWl/KjsyYBFVPL2GsS
         L6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dGE3C35uALGSi+jQbWFuezr9Lt/mGlPAfYT4Loyh9KU=;
        b=ZaVAf24JnvDPpllyLGFdDIJDyD1uVbefHBTr72AoPPhrZMYru7d90rP/PhEMJNDDZB
         zTUiObRHlr/AYbZsBGecTNviIa65PK498erz/3hgd/ci1qfiSKCYAwkAI8VswgkH7H5e
         ddmyPlarh5JDR/ZZ/cyjnBs/TouO2fNBMT2IlTND8+UF9m19a6Lg430a6HoBhOgZInsf
         sMpVy9068lv8z4XOGWAwJyT07A0PwVknLRTOQ/h1aMhdBKq4dIgo7G46GWZV9ku9B2vX
         LEv6VpixC+tYl2sadpip/gssqlOgidD8o6+M3U9V1/o874TWR5M69I+QKtOxEOzWybK4
         leWw==
X-Gm-Message-State: AGi0PuYuEaJ/3STzP3SCd9ZVpVsD6zR2MorbBFBjMP2uyQSMIuopnUjN
        nQsyz/AmW2wqizdOpJWHc+M4akDiYx4=
X-Google-Smtp-Source: APiQypJQZS5s/sU3Rh872Dx2D1FkkZvGpFMOvP2d6sp2nw6rVKkKgQyUkcmYKPdiOOPBXCc7WhRmsg==
X-Received: by 2002:a17:90a:34e:: with SMTP id 14mr3090252pjf.32.1586318778321;
        Tue, 07 Apr 2020 21:06:18 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:17 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 12/12] ci: let GitHub Actions upload failed tests' directories
Date:   Wed,  8 Apr 2020 11:05:43 +0700
Message-Id: <0908d5ab9beb0e549bec8637f4d0e4ba1f85204d.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
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

