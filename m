Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF88C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiDMT77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiDMT75 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:59:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB760AB2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q20so1765245wmq.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdZsdqcvnMAC9yoT2tEaziilvrew0DGTqUvmkLqULBg=;
        b=QXkMQg36mfeYydjj4z5Fu/l/ACCa8Pz3HRl8NrDCQZ3IPAbdvksl5lL9D1BcNi0SGQ
         lJfvYtv02WMDLe37JyWTLGe1V09Gd7tEarGgmmfS33nkNVvpoQd6f93pEjFbSU5XrQoN
         XgGeQjSr14sTx97YhXGV7yLTQLvJloZmavmozqZGLPe+3ro5J0SY3Ow5mnN/7jotzzpv
         Ow/3plErc57FEMw0O5dVOEcCmbw60974w3W17fOv/vGmOhGmJIcrY74Ks8+HHjwzaz5b
         wvJ9Ug/Pu6ZbfsNtKQMbSEzeFRH9laQLMOgEX5xEIy6D4H+FnookB3Mp49Z+N5aWf9JW
         T6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdZsdqcvnMAC9yoT2tEaziilvrew0DGTqUvmkLqULBg=;
        b=Lo5ibm89bY+qCswknRx917rafQinrcXl2WKpjkILw1xuTg1MnEAYOnRNVZjW3QUU/0
         2olaxtLfzRHJANgb8IGHF+kKFiqh7qSkpvc+wta4vF/P8KikiH03iFVpijosE6XztOnT
         +EkeX+2G1LkAX6eYFszvs9UAvunADle+wgV7H7k2OU2HqB80IGy4kynvrsPCWVIVFw2W
         JGSCvBRjz38V1A7IfbgrlkFukP56LDubRy5tukLtdBDlN4jQy/hUmSa+fh2oVIcObAUu
         PYfsrRMVjLAHfbe9UghuF7cLuZYNNicn3h8Hw2QQxLHlmw1YJ6GFsAXa+vOiJskG4B6H
         Ms9g==
X-Gm-Message-State: AOAM53090rH2fkw9/w9SgIB/B3j04KxfiwY05rGszD+agVPIlqJBTS/v
        z3T5oe/CPKFn/MoCkrnfUgjnI6u+wKFDRA==
X-Google-Smtp-Source: ABdhPJw6mzcMpwDEIQhK4UAiT3YEtKrXQ55I38/pji9pKP6+RAGs4SXDAIijr8lpA10rtkvZJRYSMA==
X-Received: by 2002:a1c:3bd6:0:b0:38f:4e30:6c2f with SMTP id i205-20020a1c3bd6000000b0038f4e306c2fmr315221wma.66.1649879852441;
        Wed, 13 Apr 2022 12:57:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm4547802wmq.27.2022.04.13.12.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:57:31 -0700 (PDT)
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
Subject: [RFC PATCH v4 2/6] tests: refactor --write-junit-xml code
Date:   Wed, 13 Apr 2022 21:57:24 +0200
Message-Id: <RFC-patch-v4-2.6-91f96c4f210-20220413T195514Z-avarab@gmail.com>
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

The code writing JUnit XML is interspersed directly with all the code in
`t/test-lib.sh`, and it is therefore not only ill-separated, but
introducing yet another output format would make the situation even
worse.

Let's introduce an abstraction layer by hiding the JUnit XML code behind
four new functions that are supposed to be called before and after each
test and test case.

This is not just an academic exercise, refactoring for refactoring's
sake. We _actually_ want to introduce such a new output format, to
make it substantially easier to diagnose test failures in our GitHub
workflow, therefore we do need this refactoring.

This commit is best viewed with `git show --color-moved
--color-moved-ws=allow-indentation-change <commit>`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-junit.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh       | 124 ++++++-------------------------------------
 2 files changed, 142 insertions(+), 108 deletions(-)
 create mode 100644 t/test-lib-junit.sh

diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
new file mode 100644
index 00000000000..9d55d74d764
--- /dev/null
+++ b/t/test-lib-junit.sh
@@ -0,0 +1,126 @@
+# Library of functions to format test scripts' output in JUnit XML
+# format, to support Git's test suite result to be presented in an
+# easily digestible way on Azure Pipelines.
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
+# The idea is for `test-lib.sh` to source this file when the user asks
+# for JUnit XML; these functions will then override (empty) functions
+# that are are called at the appropriate times during the test runs.
+
+start_test_output () {
+	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
+	mkdir -p "$junit_xml_dir"
+	junit_xml_base=${1##*/}
+	junit_xml_path="$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
+	junit_attrs="name=\"${junit_xml_base%.sh}\""
+	junit_attrs="$junit_attrs timestamp=\"$(TZ=UTC \
+		date +%Y-%m-%dT%H:%M:%S)\""
+	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
+	junit_suite_start=$(test-tool date getnanos)
+	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+	then
+		GIT_TEST_TEE_OFFSET=0
+	fi
+}
+
+start_test_case_output () {
+	junit_start=$(test-tool date getnanos)
+}
+
+finalize_test_case_output () {
+	test_case_result=$1
+	shift
+	case "$test_case_result" in
+	ok)
+		set "$*"
+		;;
+	failure)
+		junit_insert="<failure message=\"not ok $test_count -"
+		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
+		junit_insert="$junit_insert $(xml_attr_encode \
+			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+			   then
+				test-tool path-utils skip-n-bytes \
+					"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
+			   else
+				printf '%s\n' "$@" | sed 1d
+			   fi)")"
+		junit_insert="$junit_insert</failure>"
+		if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+		then
+			junit_insert="$junit_insert<system-err>$(xml_attr_encode \
+				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
+		fi
+		set "$1" "      $junit_insert"
+		;;
+	fixed)
+		set "$* (breakage fixed)"
+		;;
+	broken)
+		set "$* (known breakage)"
+		;;
+	skip)
+		message="$(xml_attr_encode "$skipped_reason")"
+		set "$1" "      <skipped message=\"$message\" />"
+		;;
+	esac
+
+	junit_attrs="name=\"$(xml_attr_encode "$this_test.$test_count $1")\""
+	shift
+	junit_attrs="$junit_attrs classname=\"$this_test\""
+	junit_attrs="$junit_attrs time=\"$(test-tool \
+		date getnanos $junit_start)\""
+	write_junit_xml "$(printf '%s\n' \
+		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
+	junit_have_testcase=t
+}
+
+finalize_test_output () {
+	if test -n "$junit_xml_path"
+	then
+		test -n "$junit_have_testcase" || {
+			junit_start=$(test-tool date getnanos)
+			write_junit_xml_testcase "all tests skipped"
+		}
+
+		# adjust the overall time
+		junit_time=$(test-tool date getnanos $junit_suite_start)
+		sed -e "s/\(<testsuite.*\) time=\"[^\"]*\"/\1/" \
+			-e "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
+			-e '/^ *<\/testsuite/d' \
+			<"$junit_xml_path" >"$junit_xml_path.new"
+		mv "$junit_xml_path.new" "$junit_xml_path"
+
+		write_junit_xml "  </testsuite>" "</testsuites>"
+		write_junit_xml=
+	fi
+}
+
+write_junit_xml () {
+	case "$1" in
+	--truncate)
+		>"$junit_xml_path"
+		junit_have_testcase=
+		shift
+		;;
+	esac
+	printf '%s\n' "$@" >>"$junit_xml_path"
+}
+
+xml_attr_encode () {
+	printf '%s\n' "$@" | test-tool xml-encode
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 531cef097db..62a57b00730 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -137,6 +137,12 @@ mark_option_requires_arg () {
 	store_arg_to=$2
 }
 
+# These functions can be overridden e.g. to output JUnit XML
+start_test_output () { :; }
+start_test_case_output () { :; }
+finalize_test_case_output () { :; }
+finalize_test_output () { :; }
+
 parse_option () {
 	local opt="$1"
 
@@ -196,7 +202,7 @@ parse_option () {
 		tee=t
 		;;
 	--write-junit-xml)
-		write_junit_xml=t
+		. "$TEST_DIRECTORY/test-lib-junit.sh"
 		;;
 	--stress)
 		stress=t ;;
@@ -663,7 +669,7 @@ exec 6<&0
 exec 7>&2
 
 _error_exit () {
-	finalize_junit_xml
+	finalize_test_output
 	GIT_EXIT_OK=t
 	exit 1
 }
@@ -773,35 +779,13 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
 # the test_expect_* functions instead.
 
 test_ok_ () {
-	if test -n "$write_junit_xml"
-	then
-		write_junit_xml_testcase "$*"
-	fi
+	finalize_test_case_output ok "$@"
 	test_success=$(($test_success + 1))
 	say_color "" "ok $test_count - $@"
 }
 
 test_failure_ () {
-	if test -n "$write_junit_xml"
-	then
-		junit_insert="<failure message=\"not ok $test_count -"
-		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
-		junit_insert="$junit_insert $(xml_attr_encode \
-			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
-			   then
-				test-tool path-utils skip-n-bytes \
-					"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
-			   else
-				printf '%s\n' "$@" | sed 1d
-			   fi)")"
-		junit_insert="$junit_insert</failure>"
-		if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
-		then
-			junit_insert="$junit_insert<system-err>$(xml_attr_encode \
-				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
-		fi
-		write_junit_xml_testcase "$1" "      $junit_insert"
-	fi
+	finalize_test_case_output failure "$@"
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
@@ -814,19 +798,13 @@ test_failure_ () {
 }
 
 test_known_broken_ok_ () {
-	if test -n "$write_junit_xml"
-	then
-		write_junit_xml_testcase "$* (breakage fixed)"
-	fi
+	finalize_test_case_output fixed "$@"
 	test_fixed=$(($test_fixed+1))
 	say_color error "ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
-	if test -n "$write_junit_xml"
-	then
-		write_junit_xml_testcase "$* (known breakage)"
-	fi
+	finalize_test_case_output broken "$@"
 	test_broken=$(($test_broken+1))
 	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
@@ -1103,10 +1081,7 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
-	if test -n "$write_junit_xml"
-	then
-		junit_start=$(test-tool date getnanos)
-	fi
+	start_test_case_output
 }
 
 test_finish_ () {
@@ -1157,12 +1132,7 @@ test_skip () {
 
 	case "$to_skip" in
 	t)
-		if test -n "$write_junit_xml"
-		then
-			message="$(xml_attr_encode "$skipped_reason")"
-			write_junit_xml_testcase "$1" \
-				"      <skipped message=\"$message\" />"
-		fi
+		finalize_test_case_output skip "$@"
 
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
@@ -1178,53 +1148,6 @@ test_at_end_hook_ () {
 	:
 }
 
-write_junit_xml () {
-	case "$1" in
-	--truncate)
-		>"$junit_xml_path"
-		junit_have_testcase=
-		shift
-		;;
-	esac
-	printf '%s\n' "$@" >>"$junit_xml_path"
-}
-
-xml_attr_encode () {
-	printf '%s\n' "$@" | test-tool xml-encode
-}
-
-write_junit_xml_testcase () {
-	junit_attrs="name=\"$(xml_attr_encode "$this_test.$test_count $1")\""
-	shift
-	junit_attrs="$junit_attrs classname=\"$this_test\""
-	junit_attrs="$junit_attrs time=\"$(test-tool \
-		date getnanos $junit_start)\""
-	write_junit_xml "$(printf '%s\n' \
-		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
-	junit_have_testcase=t
-}
-
-finalize_junit_xml () {
-	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
-	then
-		test -n "$junit_have_testcase" || {
-			junit_start=$(test-tool date getnanos)
-			write_junit_xml_testcase "all tests skipped"
-		}
-
-		# adjust the overall time
-		junit_time=$(test-tool date getnanos $junit_suite_start)
-		sed -e "s/\(<testsuite.*\) time=\"[^\"]*\"/\1/" \
-			-e "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
-			-e '/^ *<\/testsuite/d' \
-			<"$junit_xml_path" >"$junit_xml_path.new"
-		mv "$junit_xml_path.new" "$junit_xml_path"
-
-		write_junit_xml "  </testsuite>" "</testsuites>"
-		write_junit_xml=
-	fi
-}
-
 test_atexit_cleanup=:
 test_atexit_handler () {
 	# In a succeeding test script 'test_atexit_handler' is invoked
@@ -1247,7 +1170,7 @@ test_done () {
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
-	finalize_junit_xml
+	finalize_test_output
 
 	if test -z "$HARNESS_ACTIVE"
 	then
@@ -1538,22 +1461,7 @@ fi
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
 
-if test -n "$write_junit_xml"
-then
-	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
-	mkdir -p "$junit_xml_dir"
-	junit_xml_base=${0##*/}
-	junit_xml_path="$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
-	junit_attrs="name=\"${junit_xml_base%.sh}\""
-	junit_attrs="$junit_attrs timestamp=\"$(TZ=UTC \
-		date +%Y-%m-%dT%H:%M:%S)\""
-	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
-	junit_suite_start=$(test-tool date getnanos)
-	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
-	then
-		GIT_TEST_TEE_OFFSET=0
-	fi
-fi
+start_test_output "$0"
 
 # Convenience
 # A regexp to match 5 and 35 hexdigits
-- 
2.36.0.rc2.843.g193535c2aa7

