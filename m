Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA962C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiDMUAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbiDMT74 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:59:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4427A71EC4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r64so1755928wmr.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RUp5Hi/I1EuYlyvLWzR2Zl7Rsh7bXjgyLzzqHlMEm20=;
        b=IGy3aE0+T38XqnV93XFc5XjWbQZLkNbf5UWBTaIYiSUNaZdZ4xH3Zi2JdEvtNemVfb
         qXC5VNdkVKbU8HhZ+fXwfKxAgYDEv418uTJLan9GUkPrvez1OwaKQ5N+IZ8WCHR2dRSi
         hhvax5U7bq+JLa2yYk2xXBA41ZmFn/9XNV7n4kc8w9hPr2k7tyiUmoVNFB9sjaCE4EAN
         U5OL1lGewtv3gf5egD3soXrnQPiFiVe5X3Ue+iDSw/+F2NvXmVmGK2Ju/uMsC1/Evfbg
         r7Q5H8wQGgj1kNcEZrFipjCiMzSXP1DeAk8GPzo+HZbOLsPQrVGkcbnE/DcYSsWusgVY
         Zcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUp5Hi/I1EuYlyvLWzR2Zl7Rsh7bXjgyLzzqHlMEm20=;
        b=RLooRZWbyqBUS3krsqfqznzDbjMiwbQeCIouzxfX+nL0gK//NarKp264KfFWVp2n9i
         /nBtVK3KkLZP5V9WvIyeW+jj5WpcUnf/AcxrFR15BloQh+NDW3YBeFYShPLQg8MRrJlI
         Bf2vHua4GTOrE7LTme7v+i51v1FHbj2lHzSPvsvAfdW9nb6vnNdb4nygcFixUrjJ4cZf
         hJtUCUHrpV0DWyGJkaOIAHbzngCz4pITa4Hun7OdkFn1uL21rGne48DMQhUafDVx7AZ2
         KNPSbahZQ8ooqTSDGme+MOjZwI6Fzkq41iBI9pC5iDlKgIyTNbwSudorYGEj6mzatL8i
         ihDw==
X-Gm-Message-State: AOAM531tDrZK9N9Ed/+h3VJehkO3qMwXu7tDGGN0s/Wy5DNEWZsdUDKn
        tk6LitT2n3VFBalDbBbJ1DPPtJbk+gJ3Uw==
X-Google-Smtp-Source: ABdhPJwg2BAEZ52e083EmLtAfQks6E5xzmDqMgpTwZIEN4WNsACEmR126urSNCeQoWM2Qaeg8PBEjQ==
X-Received: by 2002:a1c:e916:0:b0:38e:ac96:f477 with SMTP id q22-20020a1ce916000000b0038eac96f477mr297450wmc.160.1649879851483;
        Wed, 13 Apr 2022 12:57:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm4547802wmq.27.2022.04.13.12.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:57:30 -0700 (PDT)
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
Subject: [RFC PATCH v4 1/6] ci: make it easier to find failed tests' logs in the GitHub workflow
Date:   Wed, 13 Apr 2022 21:57:23 +0200
Message-Id: <RFC-patch-v4-1.6-cc137c69ee1-20220413T195514Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
References: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com> <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
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
 .github/workflows/main.yml       | 20 ++++--------------
 ci/print-test-failures-github.sh | 35 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 16 deletions(-)
 create mode 100755 ci/print-test-failures-github.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6d25ec4ae3b..e55dda807f0 100644
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
+      run: . /etc/profile && make -C t -e || ci/print-test-failures-github.sh
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
@@ -301,10 +291,8 @@ jobs:
     - run: ci/lib.sh --build
     - run: make
     - run: ci/lib.sh --test
-    - run: make test
+    - run: make test || ci/print-test-failures-github.sh
       if: success() && matrix.vector.skip-tests != 'no'
-    - run: ci/print-test-failures.sh
-      if: failure() && matrix.vector.skip-tests != 'no'
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v1
diff --git a/ci/print-test-failures-github.sh b/ci/print-test-failures-github.sh
new file mode 100755
index 00000000000..218aaf19763
--- /dev/null
+++ b/ci/print-test-failures-github.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+. ${0%/*}/lib-ci-type.sh
+
+set -e
+
+case "$CI_TYPE" in
+github-actions)
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
+	;;
+*)
+	echo "Unhandled CI type: $CI_TYPE" >&2
+	exit 1
+	;;
+esac
+
+handle_failed_tests
-- 
2.36.0.rc2.843.g193535c2aa7

