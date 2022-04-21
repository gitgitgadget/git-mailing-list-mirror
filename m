Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EBFC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391428AbiDUSjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391422AbiDUSjf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BDDFAE
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p189so3724086wmp.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mP6wvTLf/dgvkcckh+5f84TeImwWu+K3byxCceeAyU=;
        b=OzK4ldPc+O+nlTb7ANrKv5/zc53KHecoDyInZN0WaMb+mAZycBm5lV7eyvw7xot5gm
         ZgPcJcchMjnprqM3Dw1pjRn19ufugFZ4z4E8q/sBWWbfP7JO0oBnnOHUL/9acO1xodfc
         gHxQmE6m+zMvFVasZlLWa7LMLNF5w7wnmbhI6yrskfi7qiH2jIXMUWwzA8MnKHyTrFdq
         NR6pFmSb/GJsfjMJGp0qAH7ZvmupmqRAIqZzO3M26zjySi1G4ztxUGf8LR/A2cbNAVU9
         6Zyq7oshtghk9JbAnK1OFQnSkEwst4Kj6VFpjhwj3aLGGHkYM/iHdX28jRCIb6bNzT7H
         qZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mP6wvTLf/dgvkcckh+5f84TeImwWu+K3byxCceeAyU=;
        b=YbGsv6JLGsM3QCC7s1yMQXh5tPvZoHEfy5hqykWSxbS5gOfdylV2iEoPGzlWa4x/U1
         Pk2esr03/6wa1itXZrzPT1MI6PlC2N082TSP1QFbPExcM6Hx7VlLEiuCeV41FL9YI+Gt
         uI2etQHnyY411qpYrsqNIh/5nDFv7O8MaTTaf9zz3gdJgdVH/tfGaj6Zae/jBwkIrYNH
         a9P65k6eijkv/0J8iMFkBNLGRHqxOTacFYdswdvQ5Uzk5pw2lQa9RqO+F+W4/c8n+6sj
         c0gbjpBusMtKfagcXdR7C54HMGvepJiYddIBBEiTSNqGrk4Gtl/qOrfpkeXIRrWVwFUe
         pGaw==
X-Gm-Message-State: AOAM532dcU5we58122EcFXQ6obVPcB+daR6CRVEEfLyaDryPB27lOFzF
        2UOD+dVhdZQpz385l+6ZEaMRlr9fOECEMw==
X-Google-Smtp-Source: ABdhPJz1V1AY29iuoMuprscDKcPv6/DetlnDyfim1NcQ7pimLo+ZVevA4aJgpw+HWf94EcLNFa8A5A==
X-Received: by 2002:a05:600c:1c89:b0:38e:d1a6:bf7a with SMTP id k9-20020a05600c1c8900b0038ed1a6bf7amr10017563wms.204.1650566202583;
        Thu, 21 Apr 2022 11:36:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0038ebf2858cbsm3108624wms.16.2022.04.21.11.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:36:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v5 05/10] ci: make it easier to find failed tests' logs in the GitHub workflow
Date:   Thu, 21 Apr 2022 20:36:29 +0200
Message-Id: <RFC-patch-v5-05.10-4291892fbd3-20220421T183001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
References: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com> <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When investigating a test failure, the time that matters most is the
time it takes from getting aware of the failure to displaying the output
of the failing test case.

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
UI by default. It is even marked as "successful", which makes it very
easy to miss that there is useful information hidden in there.

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
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 20 ++++----------------
 ci/print-test-failures.sh  | 32 ++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6835e942280..aa31c78d4c2 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -129,11 +129,7 @@ jobs:
       shell: bash
     - name: test
       shell: bash
-      run: . /etc/profile && make -C t -e
-    - name: ci/print-test-failures.sh
-      if: failure()
-      shell: bash
-      run: ci/print-test-failures.sh
+      run: . /etc/profile && make -C t -e || ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -218,11 +214,7 @@ jobs:
       shell: bash
     - name: test
       shell: bash
-      run: . /etc/profile && make -C t -e
-    - name: ci/print-test-failures.sh
-      if: failure()
-      shell: bash
-      run: ci/print-test-failures.sh
+      run: . /etc/profile && make -C t -e || ci/print-test-failures-github.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -265,10 +257,8 @@ jobs:
     - run: ci/lib.sh --build
     - run: make
     - run: ci/lib.sh --test
-    - run: make test
+    - run: make test || ci/print-test-failures-github.sh
       if: success()
-    - run: ci/print-test-failures.sh
-      if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v2
@@ -302,10 +292,8 @@ jobs:
     - run: make
     - run: ci/lib.sh --test
       if: success() && matrix.vector.skip-tests != 'yes'
-    - run: make test
+    - run: make test || ci/print-test-failures-github.sh
       if: success() && matrix.vector.skip-tests != 'yes'
-    - run: ci/print-test-failures.sh
-      if: failure() && matrix.vector.skip-tests != 'yes'
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v1
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 27df5081f8b..814c7799b68 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -8,13 +8,32 @@ set -e
 . ${0%/*}/lib-ci-type.sh
 . ${0%/*}/lib-tput.sh
 
-exit_code=
+case "$CI_TYPE" in
+github-actions)
+	exit_code=t
+	github_workflow_markup=t
+	;;
+*)
+	exit_code=
+	github_workflow_markup=
+	;;
+esac
+
 while test $# != 0
 do
 	case "$1" in
 	--exit-code)
 		exit_code=t
 		;;
+	--no-exit-code)
+		exit_code=
+		;;
+	--github-workflow-markup)
+		github_workflow_markup=t
+		;;
+	--no-github-workflow-markup)
+		github_workflow_markup=
+		;;
 	*)
 		echo "BUG: invalid $0 argument: $1" >&2
 		exit 1
@@ -40,9 +59,14 @@ do
 		TEST_OUT="${TEST_NAME}.out"
 		TEST_MARKUP="${TEST_NAME}.markup"
 
-		echo "------------------------------------------------------------------------"
-		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
-		echo "------------------------------------------------------------------------"
+		if test -n "$github_workflow_markup"
+		then
+			printf "\\e[33m\\e[1m=== Failed test: ${TEST_NAME} ===\\e[m\\n"
+		else
+			echo "------------------------------------------------------------------------"
+			echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
+			echo "------------------------------------------------------------------------"
+		fi
 		cat "t/test-results/${TEST_OUT}"
 
 		trash_dir="trash directory.$TEST_NAME"
-- 
2.36.0.879.g3659959fcca

