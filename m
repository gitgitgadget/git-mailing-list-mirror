Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622D6C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbiEYL0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbiEYL00 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767AB9CCA3
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so3151711wms.3
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYfYAlR0fWadogSSzkvQW0EPjNlg/8AWBp7e1GEt4RQ=;
        b=HAJAuPFK5wV82UDn0Bxv0hOM0x5limN8LPsByrsBQ1Z24N9MoZPKvMe/0gJd8+0iiX
         5aaxWt4q5ghxD4UK3nq9/K2ScrbZjoLlGKIpTNycaWnCNdnZGlbkfo6rYHmwYMwExALf
         ar30Itck5h6V3RxwwkTWK5xFhN9Qj4a2drJY3M3mp1oBZo583PZyM0hQfdk+y7f4KBDO
         MtUTMoVSm+/h06Fwd/5z4YaLTnpCJSVkxaI0oRWBOQ2Ts27K34VAtZ9g1BOv4YVw8MCR
         C+dVG8x74Hizfss5fArxKfPAWpnJSsmEEdcMqN/nvzzdFFt3baXJf/Rv5vs4A6nTTH4Z
         lAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYfYAlR0fWadogSSzkvQW0EPjNlg/8AWBp7e1GEt4RQ=;
        b=CHUEr57hFor6iwfcTU/LuJaUf9XtCfXFlPmCT9UEr+WjocCjK3WXH5GQfVcx23R+HY
         STsB9wAFuwfAb8Wko8Dmbr0jGMn2PLjLONb/TZ2rB1m3esmtl7/LNNMZ62Q80gUWY5Ct
         nFoTNa0JP/Dg9bX1+QFt510rtMr3mvxa/eL2i58zBs9waitKwRZpBWwRjic6Tnyj56+q
         eIEmsGOXX5sRNyFEmNh5DGXCYhnZFOfselv+uYMsepGSC4iKkllKln6rv343LAHzpAhL
         TuTIPo5CpY7M5xmhSIwfxqSWGzxZjatMBkotz8p4Mm2PmUbiwURHu2xrRh0epX5LtoE1
         Bu/Q==
X-Gm-Message-State: AOAM53305d0S4tzkXc5pPp6ahX2L23Tvck98X8LRgHcpdCtvXE7Riuov
        DyRlQmdGL2CKUZtnGQ2zqJj/WwP+m0+8DQ==
X-Google-Smtp-Source: ABdhPJzW/MMZKNpGpw+FmkpkYsJp1MhqL5ZOXaFJ0qsQ3Xwc96AX90FqDvhlNS8xJ9X67a4Wynd+Fw==
X-Received: by 2002:a05:600c:5127:b0:397:4862:e474 with SMTP id o39-20020a05600c512700b003974862e474mr7830577wms.68.1653477983594;
        Wed, 25 May 2022 04:26:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:23 -0700 (PDT)
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
Subject: [PATCH v6 04/14] tests: refactor --write-junit-xml code
Date:   Wed, 25 May 2022 13:25:53 +0200
Message-Id: <patch-v6-04.14-a75846a12f2-20220525T100743Z-avarab@gmail.com>
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
index 8ba5ca15345..27e17c569d4 100644
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
@@ -664,7 +670,7 @@ exec 6<&0
 exec 7>&2
 
 _error_exit () {
-	finalize_junit_xml
+	finalize_test_output
 	GIT_EXIT_OK=t
 	exit 1
 }
@@ -774,35 +780,13 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
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
@@ -815,19 +799,13 @@ test_failure_ () {
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
@@ -1104,10 +1082,7 @@ test_start_ () {
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
@@ -1158,12 +1133,7 @@ test_skip () {
 
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
@@ -1179,53 +1149,6 @@ test_at_end_hook_ () {
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
@@ -1248,7 +1171,7 @@ test_done () {
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
-	finalize_junit_xml
+	finalize_test_output
 
 	if test -z "$HARNESS_ACTIVE"
 	then
@@ -1539,22 +1462,7 @@ fi
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
2.36.1.1045.gf356b5617dd

