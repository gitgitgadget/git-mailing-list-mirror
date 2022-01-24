Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5304C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344661AbiAXTBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345068AbiAXS7q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:59:46 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0988BC061190
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r14so15389045wrp.2
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x3+QTZjSRvoWaKsczsulWNBMqebhwXtC5ksMNH2RWTM=;
        b=X9iwkbvURgzMUObixEj/bC/vqpKBaz4bNBOH1gUGrIduLse3fA9sEmeR0opruxQNB8
         8S5fRnVIfphk2NMdMB+BrubuZsCwSAKi87Shk7msQ3BqhU2KmGrwjKOE8LZqFp4bZzDX
         8hyXRnXyke2fgcp3Mn/gekSK55Ajn6bhtAXEzeWMKDBzhCgGBfhY3hV6ZDgpuLeiEOy9
         wOSZxjVs4SC6NF3zYIIfQp/poAOT55vb6HIRssapPwrc1qR9aBXxTwtb7XONSfjsMKiu
         GpWJX3yIliFM/i9GzbMV1+z3E4HKPETDX5/Nju1JdP8sem7RkXR0Yzgxcfms90slPjp5
         zk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x3+QTZjSRvoWaKsczsulWNBMqebhwXtC5ksMNH2RWTM=;
        b=OvqqokmA7cnuvAYlc07ZwUbDjO2L65VoP3UbkS2TnudOWVGmpm1KZ1BKRU8xh14f7V
         WQS89skSpw4Jke71m9Xs0J0FsJ/tulgwIcJv8NqS9TY1oLP5gR9Pmm1YtDHEfVNKfpoU
         dHwDnEKmtWtcngpSU+Rwrk27kzXzeSuu/lAQYSwH7dVLt/3p7CdQgrhGMJdBSy49d5Fm
         GDXFUHYtNJ+03XGOmiBvrSc46/tGbBi+rW6zLLtYxa/x3AHmxdbYgoRPM8hi1/r04oC6
         cteOHqKBinRZl4eIqVYCTuBhzCQGHDibw5POEu4wJXFKEocW845aChiWAakPs2TWj3eB
         Tyew==
X-Gm-Message-State: AOAM533RKIYaIVyoMhe2OewnebVvgjSfBWIRDzCNXeHWQbAe89JT8ea5
        F8IuBqq5eFuC6zTKnLbiNQ0uIpQ9N38=
X-Google-Smtp-Source: ABdhPJwoijrb8VJ4ETWOZlNNcwSO5Xu/ExJCcS89i/El0cO+vj/0IqPrOedBj2vvrHP4bHjp+2TVKQ==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr15153417wrx.662.1643050585359;
        Mon, 24 Jan 2022 10:56:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm96477wmq.42.2022.01.24.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:56:24 -0800 (PST)
Message-Id: <94dcbe1bc437dc9738cfc635e9085d743eb4ec98.1643050574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 18:56:10 +0000
Subject: [PATCH 5/9] tests: refactor --write-junit-xml code
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
index 0f7a137c7d8..e13e1cb9124 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -107,6 +107,12 @@ mark_option_requires_arg () {
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
 
@@ -166,7 +172,7 @@ parse_option () {
 		tee=t
 		;;
 	--write-junit-xml)
-		write_junit_xml=t
+		. "$TEST_DIRECTORY/test-lib-junit.sh"
 		;;
 	--stress)
 		stress=t ;;
@@ -613,7 +619,7 @@ exec 6<&0
 exec 7>&2
 
 _error_exit () {
-	finalize_junit_xml
+	finalize_test_output
 	GIT_EXIT_OK=t
 	exit 1
 }
@@ -723,35 +729,13 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
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
@@ -760,19 +744,13 @@ test_failure_ () {
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
@@ -1049,10 +1027,7 @@ test_start_ () {
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
@@ -1103,12 +1078,7 @@ test_skip () {
 
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
@@ -1124,53 +1094,6 @@ test_at_end_hook_ () {
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
@@ -1193,7 +1116,7 @@ test_done () {
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
-	finalize_junit_xml
+	finalize_test_output
 
 	if test -z "$HARNESS_ACTIVE"
 	then
@@ -1484,22 +1407,7 @@ fi
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
gitgitgadget

