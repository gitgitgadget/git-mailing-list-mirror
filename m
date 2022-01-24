Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C44C4332F
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbiAXTBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344824AbiAXS7R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:59:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A175CC06127D
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:22 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u15so15390816wrt.3
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+WgQC6mVmYEOoBPfo1TF1x/EPmyp1B7i6UgGdnGKrBY=;
        b=ZasrQ6nIlEW0Rxf2mjciwrKV9O96bEoI7d69r9czDwpV1wqnQcvCqJUyd/QGbpropq
         6DKFMjEDuwlb20N+nERkemHQZCBYL9ftAghTpxkJ5n9uDGxdxH2BbOq4ybzy3WwIEXhQ
         ATjjEP4jD3ha7iHnIMHpoYpGPNOTmO75FCymsdYSq3wSkPFiZ0HFLsEupEM4Ax/tr5v3
         VG6KAUtZHnLlCRUKnODd4+r73hW9aXx/2NdK0J171QECqpQKAYkgoDp9Mah3wScJz8BL
         NNYRRjt2LlVvUXxXzqLpDGBH18O+YPU06cZclqu4SzN8BM3JoQMH+mH8THW7sE19yoVr
         vOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+WgQC6mVmYEOoBPfo1TF1x/EPmyp1B7i6UgGdnGKrBY=;
        b=epjWHhtksY0lfmo6JkPFjR3sIXlsSeHcAMHrwNKbrXRLF+8Sjm/ZiQQJa1y9LBb62B
         1o6hVvoyTh/ci0DEuBsyn3/N37/XAOEv+re9eLpjW/jAuO9A+n9LFvEJZl7O9tuivtr5
         Az0zaLbJ7DulJu+mizpwkIKTip7xEAWjpjPUGiV/XEIJH/z/b/pD0c7dql6O19ENECGm
         JAmW1BClRN10i9+aX+k5hXCLylHcKlIwlcwUOanOXGOZmcqjjZBHz2ab8Qm9h7a+Plue
         3jD2ugRqQ0y3fDVOcJWBB073Cr2fKe1+uxXw6KaooO6r32pdKktnKC87oyf7+Jbdf1iu
         v+pQ==
X-Gm-Message-State: AOAM533jMEC6g1p2k69kvS4/YSSMau8bABrcraMocBIVIc5whnosQVuJ
        0/WXG2oCU/rXryH4c0wAzHPb5z51j+g=
X-Google-Smtp-Source: ABdhPJyDvK8MP8SU67/Hlb3G2uv1B0s4Eg/KZprznQmMxRkuMzmN0799gdl3aNU45RHNThdjSmpXOA==
X-Received: by 2002:a05:6000:1634:: with SMTP id v20mr15301031wrb.376.1643050581019;
        Mon, 24 Jan 2022 10:56:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm4383451wrs.55.2022.01.24.10.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:56:20 -0800 (PST)
Message-Id: <98891b0d3f7927086350cc9523736ae2eb7c1ee2.1643050574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 18:56:08 +0000
Subject: [PATCH 3/9] ci: make it easier to find failed tests' logs in the
 GitHub workflow
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

You currently have to know a lot of implementation details when
investigating test failures in the CI runs. The first step is easy: the
failed job is marked quite clearly, but when opening it, the failed step
is expanded, which in our case is the one running
`ci/run-build-and-tests.sh`. This step, most notably, only offers a
high-level view of what went wrong: it prints the output of `prove`
which merely tells the reader which test script failed.

The actually interesting part is in the detailed log of said failed
test script. But that log is shown in the CI run's step that runs
`ci/print-test-failures.sh`. And that step is _not_ expanded in the web
UI by default.

Let's help the reader by showing the failed tests' detailed logs in the
step that is expanded automatically, i.e. directly after the test suite
failed.

This also helps the situation where the _build_ failed and the
`print-test-failures` step was executed under the assumption that the
_test suite_ failed, and consequently failed to find any failed tests.

An alternative way to implement this patch would be to source
`ci/print-test-failures.sh` in the `handle_test_failures` function to
show these logs. However, over the course of the next few commits, we
want to introduce some grouping which would be harder to achieve that
way (for example, we do want a leaner, and colored, preamble for each
failed test script, and it would be trickier to accommodate the lack of
nested groupings in GitHub workflows' output).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 12 ------------
 ci/lib.sh                  | 23 +++++++++++++++++++++++
 ci/run-build-and-tests.sh  |  3 ++-
 ci/run-test-slice.sh       |  3 ++-
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c35200defb9..3fa88b78b6d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -119,10 +119,6 @@ jobs:
     - name: test
       shell: bash
       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
-    - name: ci/print-test-failures.sh
-      if: failure()
-      shell: bash
-      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -204,10 +200,6 @@ jobs:
       env:
         NO_SVN_TESTS: 1
       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
-    - name: ci/print-test-failures.sh
-      if: failure()
-      shell: bash
-      run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -261,8 +253,6 @@ jobs:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
-    - run: ci/print-test-failures.sh
-      if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -292,8 +282,6 @@ jobs:
     - uses: actions/checkout@v1
     - run: ci/install-docker-dependencies.sh
     - run: ci/run-build-and-tests.sh
-    - run: ci/print-test-failures.sh
-      if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v1
diff --git a/ci/lib.sh b/ci/lib.sh
index ebb502640fa..2b2c0932320 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -78,6 +78,10 @@ check_unignored_build_artifacts () {
 	}
 }
 
+handle_failed_tests () {
+	return 1
+}
+
 # GitHub Action doesn't set TERM, which is required by tput
 export TERM=${TERM:-dumb}
 
@@ -123,6 +127,25 @@ then
 	CI_JOB_ID="$GITHUB_RUN_ID"
 	CC="${CC:-gcc}"
 	DONT_SKIP_TAGS=t
+	handle_failed_tests () {
+		mkdir -p t/failed-test-artifacts
+		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
+
+		for test_exit in t/test-results/*.exit
+		do
+			test 0 != "$(cat "$test_exit")" || continue
+
+			test_name="${test_exit%.exit}"
+			test_name="${test_name##*/}"
+			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
+			cat "t/test-results/$test_name.out"
+
+			trash_dir="t/trash directory.$test_name"
+			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
+			tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+		done
+		return 1
+	}
 
 	cache_dir="$HOME/none"
 
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index b70373c172f..e49f9eaa8c0 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -51,7 +51,8 @@ esac
 make
 if test -n "$run_tests"
 then
-	make test
+	make test ||
+	handle_failed_tests
 fi
 check_unignored_build_artifacts
 
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index f8c2c3106a2..63358c23e11 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -12,6 +12,7 @@ esac
 
 make --quiet -C t T="$(cd t &&
 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
-	tr '\n' ' ')"
+	tr '\n' ' ')" ||
+handle_failed_tests
 
 check_unignored_build_artifacts
-- 
gitgitgadget

