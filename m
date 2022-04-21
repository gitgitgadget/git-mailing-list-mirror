Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A5C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391457AbiDUSjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391435AbiDUSjp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED1646647
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so3998391wmn.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=116d7ytGoq9b0TIy7dKF1i3fjm0pS7vGtm61ZH06IQs=;
        b=fIXfq8JoTU7BktwK8MPqD7CJlMvjA4BRg3tlge9bMkvfEUg0YatmB6tVyXf+9czg1G
         0bWJeq4uOEJrhH+DqPOYK9yCcObx728UjXsiijDueWcu6ab4l3fnAt2QSbHETpX/9dNn
         Z7ovLBY9iOulVd9pYjGdEAFNPYgYI69o3S2LAtpEcU/PSN2IXGY8LzxjTYf+aU576kzQ
         ikP7btIz4OlqtO/USLpVJmQgUM7dw/RVvxggupMzIrzNAzxFtJCejXBX0MMdmG/r74Qx
         PwHYy6QMdqaHgT1psl7zWKSZwCNwHr8r0AbtYjlWlZCCl1zyLQwTppE4qrAaDJPtyeU1
         kUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=116d7ytGoq9b0TIy7dKF1i3fjm0pS7vGtm61ZH06IQs=;
        b=bB6jwzSvDc/ld2tyCiDofxXPWZ0pdWElHo2rO3rNikrgqXbxf+859Jyn/X7Cm918Tv
         n8GGDukjIsv50LiswU4i3FTm3jyNcn8WOpURwWYUVEwcLrXpLKif3HjIDAVO8PG00ILn
         XJDrFLqbGRGC7faJjdaDxIXpyxQnnUrjIXZhulcFrwjsjoQCh+8SY4FnD1G6ntYwmsFr
         PdcRn7VUcggakggX1WOwlBqELSMuv+m+k/hSja7XzvbfLPAcZhlzZvb18WMp4Y7mIVw0
         8QJ5NTIlzLUN8aiMSYR0XaN8/S2mfDiT/iROt8ozjxoaHbwSyrXX4dlzJAm7jGpLNdoe
         lH7w==
X-Gm-Message-State: AOAM531xCeUCg+vX1yUfBxQI1ts6m065KG3epyQGRJSrEoMTLrC4vCDy
        qwY+/TXiGdJXZmi31bmEfBQWsx8Amfp+ig==
X-Google-Smtp-Source: ABdhPJz+rbHMoBcHikxB29Fs275UvkEpHuqBVJ62ydkQOUQXviHvFRaKaXgPwbrY3L7aaieqnUY0OA==
X-Received: by 2002:a05:600c:4f4d:b0:392:9169:35c8 with SMTP id m13-20020a05600c4f4d00b00392916935c8mr9948961wmq.36.1650566205716;
        Thu, 21 Apr 2022 11:36:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0038ebf2858cbsm3108624wms.16.2022.04.21.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:36:45 -0700 (PDT)
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
Subject: [RFC PATCH v5 08/10] ci: optionally mark up output in the GitHub workflow
Date:   Thu, 21 Apr 2022 20:36:32 +0200
Message-Id: <RFC-patch-v5-08.10-5dd43a1624b-20220421T183001Z-avarab@gmail.com>
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
index 62a57b00730..8a63b4b64c9 100644
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
@@ -1081,7 +1084,7 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
-	start_test_case_output
+	start_test_case_output "$@"
 }
 
 test_finish_ () {
-- 
2.36.0.879.g3659959fcca

