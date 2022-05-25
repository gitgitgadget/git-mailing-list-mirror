Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9E7C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiEYL0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbiEYL03 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBCB9AE73
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l30so1103715wrb.8
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6QDCyEa4Rgy5RCVZUotM7es1zxqhDK8/5O0uabIrdk=;
        b=Lc4XqoWd9ykYsYinRmfErIa2qZd0NbNlVmVvpcKuY3WuU6PESZrjpBZmnHn+Bejcpi
         TsQuqaRz8LSFHdAfJweOCpazWQBiGvzFJdNLO/y3VgUy01/tpnLa3muqhUeczlwW+mQO
         rz+EMgnKjzvQkwL/Wc3k8f5qBriyFUXIc4y1DUBTJSXR2Umz1iDPYWkTxU8bkVBz4t8r
         ENxhr/6rmQoVgyC4FJrR0798vBnrO37WMomymhat5YTsdfIuUQFxuyZ8xYcT7QGIUDEc
         kBiSXRR77xjSLlmGHc2o367uT1idn43L1cZBrWm1kEIMhj2NGV950CjPheGC2nYjn1/6
         oKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6QDCyEa4Rgy5RCVZUotM7es1zxqhDK8/5O0uabIrdk=;
        b=h+apOYiRjWQYHaRDSqX/HFA4X/ueWB+DWuSw2dTzszmbUJa4O67KLoQ5KmYs2eWJXe
         /WcsHCBu5T4Hhyjwl1a3lvsXGagLmRuAFGxRqoh4xYpioKHZrUSXQxfUALBpK2pnbDdq
         bK6o/rJP7q9EPbfbiUiB5UsVg7uY8Updi/pTlaZ1VO2ghrky+Zg6lDlcSambvOPzJ72C
         EUBx/LogwWPWgPtnkGLQII5+1C72aQuj3O1zD5IJHE6U+cgMHNyb7W/9fu9JqUNKAOrO
         eiTEP4i/bMLed7zH4l3td/U6CN9AK10HLxOuR78CP1LwtEJwcXOVMoHSO/Z1ez3oONFI
         0clg==
X-Gm-Message-State: AOAM531b9MKx6ug92Rdm9B/NGJtih9SDr1+Iu4Fz6uREK0IfgPGpthgm
        GE7KqWNo3X12Bs5lU9GTy3YzT9dAKcOe9A==
X-Google-Smtp-Source: ABdhPJxbPJqZAil7SjukxJGfnrDbhaCAfpJ+kdc9N3EVtkFgV/v+3Hwx5o0xsiaAd3BK/SuQNTxXKA==
X-Received: by 2002:adf:d1e7:0:b0:20f:dd30:489b with SMTP id g7-20020adfd1e7000000b0020fdd30489bmr12023005wrd.94.1653477986805;
        Wed, 25 May 2022 04:26:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:26 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 07/14] ci: make it easier to find failed tests' logs in the GitHub workflow
Date:   Wed, 25 May 2022 13:25:56 +0200
Message-Id: <patch-v6-07.14-e713ca6041b-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When investigating a test failure, the time that matters most is the
time it takes from getting aware of the failure to displaying the output
of the failing test case.

You currently have to know a lot of implementation details when
investigating test failures in the CI runs. The first step is easy: the
failed job is marked quite clearly, but when opening it, the failed step
is expanded, which in our case is the one running
`make` or 'make test`. When failing in the latter we only show a
high-level view of what went wrong: it prints the output of `prove`
which merely tells the reader which test script failed, along with the failed
test numbers.

To diagnose those failures in detail the user has then had to know
that they should expand the subsequent "Run ci/print-test-failures.sh"
step. Because that step always exits successfully it's not expanded by
default (the GitHub CI only expands the last failing step), making it
easy to miss that there is useful information hidden in there.

This change does a couple of things to improve the situation:

 * We now make use of the "exit code" feature of
   ci/print-test-failures.sh added in a preceding commit, thus if "make
   test" fails we'll pick up that we have failing tests, and fail in
   ci/print-test-failures.sh too.

   Note that we still exit successfully from ci/print-test-failures.sh
   if we don't have logs of any failed tests in t/test-results. Thus
   if we fail in "make" (i.e. when building), or even in "make test"
   in a way that doesn't yield a failed test (e.g. the t/Makefile
   itself failing) we'll correctly "zoom in" on the (hopefully
   failing) "make test" instead.

   As before if there was no previously failed step the
   ci/print-test-failures.sh step is skipped entirely (see
   .github/workflows/main.yml)

   To make the script DWYM the ci/print-test-failures.sh defaults to
   an "auto" mode. Thus since we turn on --github-workflow-markup in
   ci/lib.sh we'll write *.markup files, and will pick up on that in
   ci/print-test-failures.sh.

   The "$github_workflow_markup" being "auto" (or "t") on failure is
   also what makes us exit non-zero. We could also add
   --[no-]exit-code arguments, but at this point we only need this for
   the "*.markup" mode, so let's leave that for now.

   By having this be "auto" well pick up on whatever the GIT_TEST_OPTS
   setting is, which as we'll see in a subsequent commit will be
   useful if we'd like to configure the CI to emit it only some of the
   time.

 * The ci/print-test-failures.sh now makes use of the GitHub markdown
   introduced for t/test-lib.sh in the preceding commit. I.e. in GitHub
   CI we'll now run with --github-workflow-markup in GIT_TEST_OPTS,
   which causes our "--verbose" output in
   "t/test-results/$TEST_OUT.markup" to be in the GitHub CI-specific
   Markdown format.

The new output is easier to read since it makes use of collapsible grouping.
Initially, readers will see the high-level view of what actually happened.
To drill down, the "group" for the specific failing test(s) can be expanded.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                 |  2 +-
 ci/print-test-failures.sh | 62 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 80e89f89b7f..422399b1305 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -189,7 +189,7 @@ MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
 case "$CI_TYPE" in
 github-actions)
 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
-	GIT_TEST_OPTS="--verbose-log -x"
+	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 8d4d2225371..f45e36bdefc 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -8,25 +8,70 @@ set -e
 . ${0%/*}/lib-ci-type.sh
 . ${0%/*}/lib-tput.sh
 
+github_workflow_markup=auto
+case "$CI_TYPE" in
+github-actions)
+	github_workflow_markup=t
+	;;
+esac
+
+while test $# != 0
+do
+	case "$1" in
+	--github-workflow-markup)
+		github_workflow_markup=t
+		;;
+	--no-github-workflow-markup)
+		github_workflow_markup=
+		;;
+	*)
+		echo "BUG: invalid $0 argument: $1" >&2
+		exit 1
+		;;
+	esac
+	shift
+done
+
 if ! ls t/test-results/*.exit >/dev/null 2>/dev/null
 then
 	echo "Build job failed before the tests could have been run"
 	exit
 fi
 
+failed=
 for TEST_EXIT in t/test-results/*.exit
 do
 	if [ "$(cat "$TEST_EXIT")" != "0" ]
 	then
+		failed=t
 		TEST_NAME="${TEST_EXIT%.exit}"
 		TEST_NAME="${TEST_NAME##*/}"
 		TEST_OUT="${TEST_NAME}.out"
 		TEST_MARKUP="${TEST_NAME}.markup"
 
-		echo "------------------------------------------------------------------------"
-		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
-		echo "------------------------------------------------------------------------"
-		cat "t/test-results/${TEST_OUT}"
+		do_markup=
+		case "$github_workflow_markup" in
+		t)
+			do_markup=t
+			;;
+		auto)
+			if test -f "t/test-results/$TEST_MARKUP"
+			then
+				do_markup=t
+			fi
+			;;
+		esac
+
+		if test -n "$do_markup"
+		then
+			printf "\\e[33m\\e[1m=== Failed test: ${TEST_NAME} ===\\e[m\\n"
+			cat "t/test-results/$TEST_MARKUP"
+		else
+			echo "------------------------------------------------------------------------"
+			echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
+			echo "------------------------------------------------------------------------"
+			cat "t/test-results/${TEST_OUT}"
+		fi
 
 		trash_dir="trash directory.$TEST_NAME"
 		case "$CI_TYPE" in
@@ -48,4 +93,13 @@ then
 	then
 		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
 	fi
+
+	case "$github_workflow_markup" in
+	t|auto)
+		exit 1
+		;;
+	'')
+		exit 0
+		;;
+	esac
 fi
-- 
2.36.1.1045.gf356b5617dd

