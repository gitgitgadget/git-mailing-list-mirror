Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16CCC43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiGTVWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiGTVWM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105158854
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a11so5495501wmq.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wIyeUfSJ0Hqrv9uDgshxPwY+wCFJ3QsUE9TdE57oIKk=;
        b=VDDxX06sjMVuvbZuhqVwc6QKSM5nfaa0A38Arh1VmygmaVXMFiiawxwEa058gAVXJv
         xHicb1RkImEWRkr+xcobIpr2FpU9O54FgxuFcwJwhvQUo7jIiy6q/y9TdaETmqIYKwO+
         v8CcnnfomNR5LeAL+l/KO9S0maxbeDQ5JbqVEQTHBragQ3kUkIkx+ks+F1244FrMwlEx
         HF0Axk/2Q6mdIQNQluB6e9WocvRf7Wf1sV+vGRx/CikqzxTvOWI13QUM9ChB9zWhUNWk
         phCu+L2nB6vnCdUnIkHrf/RqCMOhGHaOKikOmuGAtjWLUUpaPtxLm23x1Et1G1flrJFs
         dOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wIyeUfSJ0Hqrv9uDgshxPwY+wCFJ3QsUE9TdE57oIKk=;
        b=dWox8tPnUCygbc2eXKojmiJF5Y8kxJHX8t7e/4OEzsuADpaV8NPuIy4agr/WmZli9P
         eY3CLmKiKwtXtDIH+6OVar5smcnXTZBc3DY80T8Ymp59OVm8SEcf0qr7/U818oTW1hXr
         wMQ0TIAbNH03Qj/XPKTkfT3dP7y+zSJ+tSZJx4g+tbKaA1pz8soT6sxc5QyJVsc1XvCY
         g1hKHAeyKgiMSONFSKtBw3sDA2nhCuXPQCxfigvNWVl5UGRkw9NTNwWRRBQoi1KFFOto
         vkGZpLd0D06s19SI+VKDeFddPlODBntfqmj1Ey9aTnzjXP4tgWZn1o1AZ2F6G4ibU7b5
         h6GA==
X-Gm-Message-State: AJIora9YDmftaPm+UZZVWVvR2pzhIzX8K6Hupk87AYJgSFZaPzrf5+GY
        oQjeer37OLkIVFVneCSGd3jc+7KSszqTDg==
X-Google-Smtp-Source: AGRyM1u2qaHZ4oL3foe0Exs/Ccmn7eqNhvj7efzVbgz65vZZk78j0VwHykOzNvY53P9vUI2D/XyBmw==
X-Received: by 2002:a1c:1985:0:b0:3a3:2cf8:ebe with SMTP id 127-20020a1c1985000000b003a32cf80ebemr3145271wmz.7.1658352127964;
        Wed, 20 Jul 2022 14:22:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/14] test-lib: add a --invert-exit-code switch
Date:   Wed, 20 Jul 2022 23:21:42 +0200
Message-Id: <patch-v2-04.14-668c25f4d7e-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to have those tests that fail return 0, and those
tests that succeed return 1. This is useful e.g. to run "--stress"
tests on tests that fail 99% of the time on some setup, i.e. to smoke
out the flaky run which yielded success.

In a subsequent commit a new SANITIZE=leak mode will make use of this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh    | 45 ++++++++++++++++++++++++++++--
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 17a268ccd1b..502b4bcf9ea 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -578,6 +578,78 @@ test_expect_success 'subtest: --run invalid range end' '
 	EOF_ERR
 '
 
+test_expect_success 'subtest: --invert-exit-code without --immediate' '
+	run_sub_test_lib_test_err full-pass \
+		--invert-exit-code &&
+	check_sub_test_lib_test_err full-pass \
+		<<-\EOF_OUT 3<<-EOF_ERR
+	ok 1 - passing test #1
+	ok 2 - passing test #2
+	ok 3 - passing test #3
+	# passed all 3 test(s)
+	1..3
+	# faking up non-zero exit with --invert-exit-code
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_success 'subtest: --invert-exit-code with --immediate: all passed' '
+	run_sub_test_lib_test_err full-pass \
+		--invert-exit-code --immediate &&
+	check_sub_test_lib_test_err full-pass \
+		<<-\EOF_OUT 3<<-EOF_ERR
+	ok 1 - passing test #1
+	ok 2 - passing test #2
+	ok 3 - passing test #3
+	# passed all 3 test(s)
+	1..3
+	# faking up non-zero exit with --invert-exit-code
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_success 'subtest: --invert-exit-code without --immediate: partial pass' '
+	run_sub_test_lib_test partial-pass \
+		--invert-exit-code &&
+	check_sub_test_lib_test partial-pass <<-\EOF
+	ok 1 - passing test #1
+	not ok 2 - # TODO induced breakage (--invert-exit-code): failing test #2
+	#	false
+	ok 3 - passing test #3
+	# failed 1 among 3 test(s)
+	1..3
+	# faked up failures as TODO & now exiting with 0 due to --invert-exit-code
+	EOF
+'
+
+test_expect_success 'subtest: --invert-exit-code with --immediate: partial pass' '
+	run_sub_test_lib_test partial-pass \
+		--invert-exit-code --immediate &&
+	check_sub_test_lib_test partial-pass \
+		<<-\EOF_OUT 3<<-EOF_ERR
+	ok 1 - passing test #1
+	not ok 2 - # TODO induced breakage (--invert-exit-code): failing test #2
+	#	false
+	1..2
+	# faked up failures as TODO & now exiting with 0 due to --invert-exit-code
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_success 'subtest: --invert-exit-code --immediate: got a failure' '
+	run_sub_test_lib_test partial-pass \
+		--invert-exit-code --immediate &&
+	check_sub_test_lib_test_err partial-pass \
+		<<-\EOF_OUT 3<<-EOF_ERR
+	ok 1 - passing test #1
+	not ok 2 - # TODO induced breakage (--invert-exit-code): failing test #2
+	#	false
+	1..2
+	# faked up failures as TODO & now exiting with 0 due to --invert-exit-code
+	EOF_OUT
+	EOF_ERR
+'
+
 test_expect_success 'subtest: tests respect prerequisites' '
 	write_and_run_sub_test_lib_test prereqs <<-\EOF &&
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 118720493bb..31213b5f95b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -238,6 +238,9 @@ parse_option () {
 			;;
 		esac
 		;;
+	--invert-exit-code)
+		invert_exit_code=t
+		;;
 	*)
 		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
 	esac
@@ -788,15 +791,31 @@ test_ok_ () {
 	finalize_test_case_output ok "$@"
 }
 
+_invert_exit_code_failure_end_blurb () {
+	say_color warn "# faked up failures as TODO & now exiting with 0 due to --invert-exit-code"
+}
+
 test_failure_ () {
 	failure_label=$1
 	test_failure=$(($test_failure + 1))
-	say_color error "not ok $test_count - $1"
+	local pfx=""
+	if test -n "$invert_exit_code" # && test -n "$HARNESS_ACTIVE"
+	then
+		pfx="# TODO induced breakage (--invert-exit-code):"
+	fi
+	say_color error "not ok $test_count - ${pfx:+$pfx }$1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	if test -n "$immediate"
 	then
 		say_color error "1..$test_count"
+		if test -n "$invert_exit_code"
+		then
+			finalize_test_output
+			_invert_exit_code_failure_end_blurb
+			GIT_EXIT_OK=t
+			exit 0
+		fi
 		_error_exit
 	fi
 	finalize_test_case_output failure "$failure_label" "$@"
@@ -1229,7 +1248,14 @@ test_done () {
 			esac
 		fi
 
-		if test -z "$debug" && test -n "$remove_trash"
+		if test -n "$stress" && test -n "$invert_exit_code"
+		then
+			# We're about to move our "$TRASH_DIRECTORY"
+			# to "$TRASH_DIRECTORY.stress-failed" if
+			# --stress is combined with
+			# --invert-exit-code.
+			say "with --stress and --invert-exit-code we're not removing '$TRASH_DIRECTORY'"
+		elif test -z "$debug" && test -n "$remove_trash"
 		then
 			test -d "$TRASH_DIRECTORY" ||
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
@@ -1242,6 +1268,14 @@ test_done () {
 			} ||
 			error "Tests passed but test cleanup failed; aborting"
 		fi
+
+		if test -z "$skip_all" && test -n "$invert_exit_code"
+		then
+			say_color warn "# faking up non-zero exit with --invert-exit-code"
+			GIT_EXIT_OK=t
+			exit 1
+		fi
+
 		test_at_end_hook_
 
 		GIT_EXIT_OK=t
@@ -1254,6 +1288,13 @@ test_done () {
 			say "1..$test_count"
 		fi
 
+		if test -n "$invert_exit_code"
+		then
+			_invert_exit_code_failure_end_blurb
+			GIT_EXIT_OK=t
+			exit 0
+		fi
+
 		GIT_EXIT_OK=t
 		exit 1 ;;
 
-- 
2.37.1.1064.gc96144cf387

