Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F24EC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiCYTfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiCYTfB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:35:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F6280EE7
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so12155446wrg.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=un4TIsyi8AzHb+88PX5qngd/2+qgEVNpUqwtn/Os4uA=;
        b=qhjTSDen6TKfW1nPWN4ghIjatG0sAme4iCCBbVhzeltUbKhyefFgU34xtxiBlu5pWM
         HGD9mQsw+KMe0+Z+NIV+DO1s0b/wIfTM8L4UPaDxMgeNeD9Y55SSHcth6ma4VvNadBfN
         LlH/G4eVMV44i+SObcPLagzjAUxrbx5rPbbE6042c1hb0jQzeUuP9omrVyu4AxMMjCvm
         gWLbH0rvVY0T0rRAzJf2JRL84EpHF5RsaJfg1ffirPRI43sAoOLLcj/X1P69oKTYXmAK
         IfmvdpjB2fUj6U4AtEtGWdr6cG/k13W0kpZau1axaVLP6cVGy7A571tZAuiyHebmoSg4
         xsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=un4TIsyi8AzHb+88PX5qngd/2+qgEVNpUqwtn/Os4uA=;
        b=gRu+25sE0KtQN7k11gmv360LLJG764MlEpKxMpYSwTmckOkasPSTYkZZSDo+05LDAC
         zTgqqNweLdY80zLzxqIJwKAIJSHX0asROysXerHyloGENy1y+AV6tMkZAlrisedqPQiU
         lT5t/ALMvQznl83R3BAEkE7bEjSPMIAuO53w8Te+yj08Po+WSJycJEnvrVIfaB3T+lzg
         9Dz+rCb+tHKRS60Idoc7Ey9O518lP+6z2GqHv/1T9KscfkzE+1CNn3SWdrZrnRsCigjr
         Y56KrP2vPQSs0+EqwFDSxiTdxFKXA1CY6g+QTLzVk2m+gGcxoCGCt6Q8q8MiooTtc++m
         HPWQ==
X-Gm-Message-State: AOAM533dddSM7MsAdIhIdulv3iZfFgKcSEoSXiXDgDwMZ6N6ZAOAWtOh
        Zxx2pF8A2VOXvvt7agraz2q5z+LhR/fX6Q==
X-Google-Smtp-Source: ABdhPJwhJgmAY1bbaN+8AsJu7O/rhhAYd9XX4SUt78yc2TWFPVrp1gl0Y/q8bjWtAcfATK92fhtEjw==
X-Received: by 2002:a05:6000:178c:b0:204:670:5b20 with SMTP id e12-20020a056000178c00b0020406705b20mr10769623wrg.637.1648236259984;
        Fri, 25 Mar 2022 12:24:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c020600b0038cbb21fb00sm4999704wmi.39.2022.03.25.12.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:24:19 -0700 (PDT)
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
Subject: [RFC PATCH v3 2/6] tests: refactor --write-junit-xml code
Date:   Fri, 25 Mar 2022 20:24:11 +0100
Message-Id: <RFC-patch-v3-2.6-ad1e1465a81-20220325T183946Z-avarab@gmail.com>
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
index 515b1af7ed4..65b63359ddb 100644
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
@@ -810,19 +794,13 @@ test_failure_ () {
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
@@ -1099,10 +1077,7 @@ test_start_ () {
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
@@ -1153,12 +1128,7 @@ test_skip () {
 
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
@@ -1174,53 +1144,6 @@ test_at_end_hook_ () {
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
@@ -1243,7 +1166,7 @@ test_done () {
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
-	finalize_junit_xml
+	finalize_test_output
 
 	if test -z "$HARNESS_ACTIVE"
 	then
@@ -1534,22 +1457,7 @@ fi
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
2.35.1.1517.g20a06c426a7

