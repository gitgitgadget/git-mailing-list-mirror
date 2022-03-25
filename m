Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DC9C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiCYTfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiCYTe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:34:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1D2280C03
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j18so12121894wrd.6
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZI2xxi6PznYWtcgWMwuyCaFV9HWoUmAUdxMgQYduw0=;
        b=UFQ3Dq4AE87BpyO8R5mY3GXBR1u6mQb7u6GvzwbYDt+l90pnFha3lYyMIu1AqtAu8W
         sl+kK1JXvOBhwwumwPYeVsNi8NCJIhV0YjKG2hZbU0jto9YSN9164YNi9P49cVv8eOVV
         uLVZYnA80l+16pBslfPqNU7yse1LYLVoZDKJUNw0JOpde4JvXVldfM0jiCMtkFn9DwoZ
         KpgGs6kdV5pwk2h/nV78DTkc673MtUt9O9gfuFLbi1tMngvjLwfYSU6+JL7aOgc7i9ra
         YKJ3yd4TqXgk2pjN6d0XsP+1390vqZTODpaO/ISFFFVO9ekFbhUGtDrsP6yqx8vLqc5G
         F+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZI2xxi6PznYWtcgWMwuyCaFV9HWoUmAUdxMgQYduw0=;
        b=MQwqt1aqVF38neyvXudld4+KCTQQZulJT2QA8ZsAmug5okXI/zJ0UcZ9ep2YkYBOb+
         ehdTKtZcV56eigP/s2MsA+21kkA5jZfjq3mth17F4J9jhTk7V1BcZcQRfuaGxscqhr/5
         f5ZzK7/fY48jkUmynnMlHrCrreuq16SnRJS+w5rk/IYN55f8tP2n21D2K8vpiuqSFVdF
         IY56s7AENubIlU4iNrX2B+O9nKEpkmYrVto3qj0haxkVzQYEvo6TThhAbJqolR5Vpgpa
         uzKpHfz1bajQuWL7KVnO3hxW1FK6Ez06fjg5FzzJSrVRTlf8755xHc3pWfEymCaLxCj5
         zZqw==
X-Gm-Message-State: AOAM531SdrypdVycieV6SWz1Woghs/WaGEyoOvZZDxrJ13NHTpOvbfNi
        vipcUF8tAiSphjnB6fQIZZtaEfwey4u79A==
X-Google-Smtp-Source: ABdhPJzxaAC3cxG7Af4h8jAVu8GOYJeVdEsVT6EAZ3fyW7WoyJ2bGgCrDLNZBxMXA8D8ATZtJp86ag==
X-Received: by 2002:adf:82b2:0:b0:203:f34d:dff with SMTP id 47-20020adf82b2000000b00203f34d0dffmr10341331wrc.661.1648236261878;
        Fri, 25 Mar 2022 12:24:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c020600b0038cbb21fb00sm4999704wmi.39.2022.03.25.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:24:21 -0700 (PDT)
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
Subject: [RFC PATCH v3 4/6] ci: optionally mark up output in the GitHub workflow
Date:   Fri, 25 Mar 2022 20:24:13 +0100
Message-Id: <RFC-patch-v3-4.6-429c256ac62-20220325T183946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
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
index 0f439c99d61..4e86f7d9d0e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -719,7 +719,7 @@ test_verify_prereq () {
 }
 
 test_expect_failure () {
-	test_start_
+	test_start_ "$@"
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	BUG "not 2 or 3 parameters to test-expect-failure"
@@ -739,7 +739,7 @@ test_expect_failure () {
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
index 65b63359ddb..5ba4051d588 100644
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
@@ -1077,7 +1080,7 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
-	start_test_case_output
+	start_test_case_output "$@"
 }
 
 test_finish_ () {
-- 
2.35.1.1517.g20a06c426a7

