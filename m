Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17539C433FE
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiDEFWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiDEFWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D34EF6F
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o20so4247698pla.13
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzwj0MPh8XM1pXNQAEBm1HAa9mV3A7ktmPBd86yNLys=;
        b=R2oiNa6o/KUE3g97glGvO55V+sk3nIY8ZFPSAeq6hi+VseWwMdU9u7ErLqzhMsSDOL
         RuecSP1Fum76rTXVzzUG6jilSCTVWRHKUyOPE3gE4Su8PPE63lOyV+hrFSYVdzV07Fm5
         LBPN2ChQsTYnZFzvVWGNV+d3zYtbx9CgDEo0mVQjOldeBRubFQ6zW20yCLbSA9gN/9Fe
         9KfaJCZG3SRdqnblaGQJrazotCkgDFGxxSxwpmJl1VukXXj2PbpCZbGM23Zv9UVqcmua
         zLU8fQeAd5tkAfZ4xqgWUlIDY+t/+HwMQbFhX2TP+oMcchYL+AziREG/uinAj6S9yyV1
         dS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzwj0MPh8XM1pXNQAEBm1HAa9mV3A7ktmPBd86yNLys=;
        b=fAkMBf2dlIMLimD/JBZXL73CtCN2IzDskdRi/tSVk4+N9RayS9qKVRaOZoW3j4gltB
         UXukBS0bJnkgmsLWpFgYETepm7MHFDyN0Rb9vHUMhOhyDI2pgRBbjjfhLxsuEsrde8Um
         Uux0Y87sOIQyC6ysPz3FsxUuybqU59uk95bpmLOhfE+EeS6OEtX5Wor+sHuXD4elfJPt
         qXRPqvwmH1dGWmQjEub5TByUvqplp/oxfJfEJN00BwIHszgp8qLPwcsAxAUoTco2JcsV
         PiBp17utMd8ULZIU1b+ROzmvTuidrekLv0xQDUJa1cv/b/SFYA7mdkqjl03plWTGrYqq
         M6tQ==
X-Gm-Message-State: AOAM532yOLhdNaznBHEIh1mbVVlsc5J3AH1CSxTtFb4f/UcX07498UCt
        kAiafsYKQNLIUvG8mOzsbmY=
X-Google-Smtp-Source: ABdhPJwdaGi7O8TEb4a6yaPRdKfbjUdH2VTnXoKiAP8WXMX2MqTUiPDL2+LFEdNB4v3HRGel9p/fcQ==
X-Received: by 2002:a17:90b:3b8f:b0:1c7:b62e:8e87 with SMTP id pc15-20020a17090b3b8f00b001c7b62e8e87mr2112016pjb.156.1649136036578;
        Mon, 04 Apr 2022 22:20:36 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:35 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 11/12] t/perf: add iteration setup mechanism to perf-lib
Date:   Mon,  4 Apr 2022 22:20:17 -0700
Message-Id: <20220405052018.11247-12-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Tests that affect the repo in stateful ways are easier to write if we
can run setup steps outside of the measured portion of perf iteration.

This change adds a "--setup 'setup-script'" parameter to test_perf. To
make invocations easier to understand, I also moved the prerequisites to
a new --prereq parameter.

The setup facility will be used in the upcoming perf tests for batch
mode, but it already helps in some existing tests, like t5302 and t7820.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/p4220-log-grep-engines.sh       |  3 +-
 t/perf/p4221-log-grep-engines-fixed.sh |  3 +-
 t/perf/p5302-pack-index.sh             | 15 +++---
 t/perf/p7519-fsmonitor.sh              | 18 ++------
 t/perf/p7820-grep-engines.sh           |  6 ++-
 t/perf/perf-lib.sh                     | 63 +++++++++++++++++++++++---
 6 files changed, 74 insertions(+), 34 deletions(-)

diff --git a/t/perf/p4220-log-grep-engines.sh b/t/perf/p4220-log-grep-engines.sh
index 2bc47ded4d1..03fbfbb85d3 100755
--- a/t/perf/p4220-log-grep-engines.sh
+++ b/t/perf/p4220-log-grep-engines.sh
@@ -36,7 +36,8 @@ do
 		else
 			prereq=""
 		fi
-		test_perf $prereq "$engine log$GIT_PERF_4220_LOG_OPTS --grep='$pattern'" "
+		test_perf "$engine log$GIT_PERF_4220_LOG_OPTS --grep='$pattern'" \
+			--prereq "$prereq" "
 			git -c grep.patternType=$engine log --pretty=format:%h$GIT_PERF_4220_LOG_OPTS --grep='$pattern' >'out.$engine' || :
 		"
 	done
diff --git a/t/perf/p4221-log-grep-engines-fixed.sh b/t/perf/p4221-log-grep-engines-fixed.sh
index 060971265a9..0a6d6dfc219 100755
--- a/t/perf/p4221-log-grep-engines-fixed.sh
+++ b/t/perf/p4221-log-grep-engines-fixed.sh
@@ -26,7 +26,8 @@ do
 		else
 			prereq=""
 		fi
-		test_perf $prereq "$engine log$GIT_PERF_4221_LOG_OPTS --grep='$pattern'" "
+		test_perf "$engine log$GIT_PERF_4221_LOG_OPTS --grep='$pattern'" \
+			--prereq "$prereq" "
 			git -c grep.patternType=$engine log --pretty=format:%h$GIT_PERF_4221_LOG_OPTS --grep='$pattern' >'out.$engine' || :
 		"
 	done
diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index c16f6a3ff69..14c601bbf86 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -26,9 +26,8 @@ test_expect_success 'set up thread-counting tests' '
 	done
 '
 
-test_perf PERF_EXTRA 'index-pack 0 threads' '
-	rm -rf repo.git &&
-	git init --bare repo.git &&
+test_perf 'index-pack 0 threads' --prereq PERF_EXTRA \
+	--setup 'rm -rf repo.git && git init --bare repo.git' '
 	GIT_DIR=repo.git git index-pack --threads=1 --stdin < $PACK
 '
 
@@ -36,17 +35,15 @@ for t in $threads
 do
 	THREADS=$t
 	export THREADS
-	test_perf PERF_EXTRA "index-pack $t threads" '
-		rm -rf repo.git &&
-		git init --bare repo.git &&
+	test_perf "index-pack $t threads" --prereq PERF_EXTRA \
+		--setup 'rm -rf repo.git && git init --bare repo.git' '
 		GIT_DIR=repo.git GIT_FORCE_THREADS=1 \
 		git index-pack --threads=$THREADS --stdin <$PACK
 	'
 done
 
-test_perf 'index-pack default number of threads' '
-	rm -rf repo.git &&
-	git init --bare repo.git &&
+test_perf 'index-pack default number of threads' \
+	--setup 'rm -rf repo.git && git init --bare repo.git' '
 	GIT_DIR=repo.git git index-pack --stdin < $PACK
 '
 
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 0b9129ca7bc..b1cb23880fb 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -60,18 +60,6 @@ then
 	esac
 fi
 
-if test -n "$GIT_PERF_7519_DROP_CACHE"
-then
-	# When using GIT_PERF_7519_DROP_CACHE, GIT_PERF_REPEAT_COUNT must be 1 to
-	# generate valid results. Otherwise the caching that happens for the nth
-	# run will negate the validity of the comparisons.
-	if test "$GIT_PERF_REPEAT_COUNT" -ne 1
-	then
-		echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
-		GIT_PERF_REPEAT_COUNT=1
-	fi
-fi
-
 trace_start () {
 	if test -n "$GIT_PERF_7519_TRACE"
 	then
@@ -175,10 +163,10 @@ setup_for_fsmonitor_hook () {
 
 test_perf_w_drop_caches () {
 	if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-		test-tool drop-caches
+		test_perf "$1" --setup "test-tool drop-caches" "$2"
+	else
+		test_perf "$@"
 	fi
-
-	test_perf "$@"
 }
 
 test_fsmonitor_suite () {
diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
index 8b09c5bf328..9bfb86842a9 100755
--- a/t/perf/p7820-grep-engines.sh
+++ b/t/perf/p7820-grep-engines.sh
@@ -49,13 +49,15 @@ do
 		fi
 		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
 		then
-			test_perf $prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'" "
+			test_perf "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'" \
+				--prereq "$prereq" "
 				git -c grep.patternType=$engine grep$GIT_PERF_7820_GREP_OPTS -- '$pattern' >'out.$engine' || :
 			"
 		else
 			for threads in $GIT_PERF_GREP_THREADS
 			do
-				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern' with $threads threads" "
+				test_perf "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern' with $threads threads"
+					--prereq PTHREADS,$prereq "
 					git -c grep.patternType=$engine -c grep.threads=$threads grep$GIT_PERF_7820_GREP_OPTS -- '$pattern' >'out.$engine.$threads' || :
 				"
 			done
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 932105cd12c..ab3687c28d4 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -189,19 +189,39 @@ exit $ret' >&3 2>&4
 }
 
 test_wrapper_ () {
-	test_wrapper_func_=$1; shift
+	local test_wrapper_func_="$1"; shift
+	local test_title_="$1"; shift
 	test_start_
-	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
-	test "$#" = 2 ||
-	BUG "not 2 or 3 parameters to test-expect-success"
+	test_prereq=
+	test_perf_setup_=
+	while test $# != 0
+	do
+		case $1 in
+		--prereq)
+			test_prereq=$2
+			shift
+			;;
+		--setup)
+			test_perf_setup_=$2
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	test "$#" = 1 || BUG "test_wrapper_ needs 2 positional parameters"
 	export test_prereq
-	if ! test_skip "$@"
+	export test_perf_setup_
+
+	if ! test_skip "$test_title_" "$@"
 	then
 		base=$(basename "$0" .sh)
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
 		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
 		base="$perf_results_dir"/"$PERF_RESULTS_PREFIX$(basename "$0" .sh)"."$test_count"
-		"$test_wrapper_func_" "$@"
+		"$test_wrapper_func_" "$test_title_" "$@"
 	fi
 
 	test_finish_
@@ -214,6 +234,16 @@ test_perf_ () {
 		echo "perf $test_count - $1:"
 	fi
 	for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
+		if test -n "$test_perf_setup_"
+		then
+			say >&3 "setup: $test_perf_setup_"
+			if ! test_eval_ $test_perf_setup_
+			then
+				test_failure_ "$test_perf_setup_"
+				break
+			fi
+
+		fi
 		say >&3 "running: $2"
 		if test_run_perf_ "$2"
 		then
@@ -237,11 +267,24 @@ test_perf_ () {
 	rm test_time.*
 }
 
+# Usage: test_perf 'title' [options] 'perf-test'
+#	Run the performance test script specified in perf-test with
+#	optional prerequisite and setup steps.
+# Options:
+#	--prereq prerequisites: Skip the test if prequisites aren't met
+#	--setup "setup-steps": Run setup steps prior to each measured iteration
+#
 test_perf () {
 	test_wrapper_ test_perf_ "$@"
 }
 
 test_size_ () {
+	if test -n "$test_perf_setup_"
+	then
+		say >&3 "setup: $test_perf_setup_"
+		test_eval_ $test_perf_setup_
+	fi
+
 	say >&3 "running: $2"
 	if test_eval_ "$2" 3>"$base".result; then
 		test_ok_ "$1"
@@ -250,6 +293,14 @@ test_size_ () {
 	fi
 }
 
+# Usage: test_size 'title' [options] 'size-test'
+#	Run the size test script specified in size-test with optional
+#	prerequisites and setup steps. Returns the numeric value
+#	returned by size-test.
+# Options:
+#	--prereq prerequisites: Skip the test if prequisites aren't met
+#	--setup "setup-steps": Run setup steps prior to the size measurement
+
 test_size () {
 	test_wrapper_ test_size_ "$@"
 }
-- 
2.34.1.78.g86e39b8f8d

