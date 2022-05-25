Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0943C433FE
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbiEYL0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbiEYL03 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0D0972B6
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 206-20020a1c02d7000000b00397345f2c6fso486187wmc.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIAH4ji6WFj3RiIj2Y6NlD7lYR1h/OxJp3MXk3dTvS0=;
        b=mjJoLqCoRr46RexgYjn+Q2/nTUuD3UR0qwy2bGNh2UFIsjkseUA3+7r/vSRuZbvnMu
         wSo1lso9Xdwv6LXc1I4F9gPlqeW8qHLVl4N98YL27bTx2eZT/0FSRjpxOzOk9Oa2gWmF
         N442d4W7o99N41PcvUaUZs9afHF7Xa+Lxf+ZSyb/k7WxWhFPl7njs7686nUcK/p6ZFvQ
         JmOFTvSEcyzUtQWVEP4yXeL1On3w9ia9bNAnTOORNWGOpHFLHzRTmjZ4wzsepbA92YQh
         m21xT1o//TNSqLU9p9/D8Duef4hNtEUcbgwrfBq1wXLXYS2PT5udxtSQD2nOkhDAoFG6
         23Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIAH4ji6WFj3RiIj2Y6NlD7lYR1h/OxJp3MXk3dTvS0=;
        b=iqHn43ORG9ijBZ72MQPIG+0lpgA8HIEdYT5+TvxD7ALXRKu8aPwkY6kb1Q6D4rkdht
         Y0tVpk04lVNhC4RXNYi59M1NMuKPGJVv+CZxZQFvH5wUssrA0brj4O0EVXqxybUZfy+T
         kqBW21rPXWuazPu0+wpEzteKvNmprOIenUfodzjGrHO7iHXI+ERPT8VoDWons2RYIl2Y
         gCUtrMIRIdpj1SexVcT5Vk3NmTLORlZD+CKQxaaWZQJCbZSLsMnksQvIN01pvsGqQbTh
         5bwcTKS63V7IrmX2J23NsigEy9Q9+K3xpJTA1hJkqgHvYxjMhZqHVQCU+YsYXv3aUBua
         DZ2A==
X-Gm-Message-State: AOAM5300nYSLB6BUcn8lwkrITfqwUIwLMJMgRKEKrioTDxeXVzz26HPI
        yV3EC5qkwKvyok/crw2hVuYNTMMX98xWLg==
X-Google-Smtp-Source: ABdhPJxBNgdkBf1peJqzeT74udWiD3x9HgL5V0LA6spg1fJSu2t6OoHhExkYIC8MyxJBh24asal+QQ==
X-Received: by 2002:a05:600c:1d28:b0:397:65ef:fb9e with SMTP id l40-20020a05600c1d2800b0039765effb9emr4107272wms.136.1653477985832;
        Wed, 25 May 2022 04:26:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:25 -0700 (PDT)
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 06/14] ci: optionally mark up output in the GitHub workflow
Date:   Wed, 25 May 2022 13:25:55 +0200
Message-Id: <patch-v6-06.14-f5b39f1660d-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A couple of commands exist to spruce up the output in GitHub workflows:
https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions

In addition to the `::group::<label>`/`::endgroup::` commands (which we
already use to structure the output of the build step better), we also
use `::error::`/`::notice::` to draw the attention to test failures and
to test cases that were expected to fail but didn't.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh              |  4 +--
 t/test-lib-github-workflow-markup.sh | 50 ++++++++++++++++++++++++++++
 t/test-lib.sh                        |  5 ++-
 3 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 t/test-lib-github-workflow-markup.sh

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 93c03380d44..af4831a54c6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -795,7 +795,7 @@ test_verify_prereq () {
 }
 
 test_expect_failure () {
-	test_start_
+	test_start_ "$@"
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	BUG "not 2 or 3 parameters to test-expect-failure"
@@ -815,7 +815,7 @@ test_expect_failure () {
 }
 
 test_expect_success () {
-	test_start_
+	test_start_ "$@"
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	BUG "not 2 or 3 parameters to test-expect-success"
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
new file mode 100644
index 00000000000..d8dc969df4a
--- /dev/null
+++ b/t/test-lib-github-workflow-markup.sh
@@ -0,0 +1,50 @@
+# Library of functions to mark up test scripts' output suitable for
+# pretty-printing it in GitHub workflows.
+#
+# Copyright (c) 2022 Johannes Schindelin
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see http://www.gnu.org/licenses/ .
+#
+# The idea is for `test-lib.sh` to source this file when run in GitHub
+# workflows; these functions will then override (empty) functions
+# that are are called at the appropriate times during the test runs.
+
+start_test_output () {
+	test -n "$GIT_TEST_TEE_OUTPUT_FILE" ||
+	die "--github-workflow-markup requires --verbose-log"
+	github_markup_output="${GIT_TEST_TEE_OUTPUT_FILE%.out}.markup"
+	>$github_markup_output
+	GIT_TEST_TEE_OFFSET=0
+}
+
+# No need to override start_test_case_output
+
+finalize_test_case_output () {
+	test_case_result=$1
+	shift
+	case "$test_case_result" in
+	failure)
+		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
+		;;
+	fixed)
+		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
+		;;
+	esac
+	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
+	test-tool >>$github_markup_output path-utils skip-n-bytes \
+		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
+	echo >>$github_markup_output "::endgroup::"
+}
+
+# No need to override finalize_test_output
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 27e17c569d4..0a7e067ebdb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -204,6 +204,9 @@ parse_option () {
 	--write-junit-xml)
 		. "$TEST_DIRECTORY/test-lib-junit.sh"
 		;;
+	--github-workflow-markup)
+		. "$TEST_DIRECTORY/test-lib-github-workflow-markup.sh"
+		;;
 	--stress)
 		stress=t ;;
 	--stress=*)
@@ -1082,7 +1085,7 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
-	start_test_case_output
+	start_test_case_output "$@"
 }
 
 test_finish_ () {
-- 
2.36.1.1045.gf356b5617dd

