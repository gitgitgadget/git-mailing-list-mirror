Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E238C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiGSVFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbiGSVFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:05:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DF633A00
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id id17so2596503wmb.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZ52TPE5gW29BRFBtyrwCRZaU3DHLxmsF+cD+CmLmpE=;
        b=gsI3MdM9wfGvS0YIS/B+f7vHUHFd16Seqzu8IBZu9s0OA6h46XD4j5BLyhuB4QNeq5
         aYAqf46cYCMRmdRoyrNK4fM7nRUd+neluxIsQfWZlJ7mWpuisNCMtGffRUg7rW8DVsB1
         2O3IPtxnXisyt1oXeB+crXVIks+gSFLXTmilygGIGTSAvnVdBUMi8nqY35jbfTCOoWgL
         QaSvhP8aUh3nNngoUJbSJX5tmxjytmkgNJYryWD5pWwEVMAsMcgA1eLFgja1cDsPL/QW
         h5ekUHipg9ewOZdIr2+CxSAIx5qymZwA7kFRaypPqFeRiKLOCgrrSLxHKXtzu+xNb65M
         88MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZ52TPE5gW29BRFBtyrwCRZaU3DHLxmsF+cD+CmLmpE=;
        b=nH1QKZSJ4MprRSnkKgL7qZ2k2mQODH2bPPyREBprBn83CPYUEpJ2RvPZs6Iptwb/JZ
         iihumIMqcNfrHgtrRcEyJ2qyvnvdG+0DhpUEj/MBYns6kxC9Ebw0w75w1PmsqpJ+Zz7U
         4wC/9Zx+4Go+zhqFY8TKF8Gf6nYJMUQ5JBAaRxttct3QKJo/N8aR6kz7secPVkEgHHgt
         WF1E0G8wtGGnaSD3vVbah37oO1zzcaQdMly0VxkXEwAMPMrjJ20ugDtdC+PZ7a7cqm3Q
         gujSKE2nBI5CgVYYMfeA27yimGzin/AV9VBAeb+t5bPb4r+gH055rvr+kANd8oq5opG9
         k9ug==
X-Gm-Message-State: AJIora/LM16oapPRIHUFikRPOECYbKSrKwA2+Pqa5qoDxXasJt8ffsP3
        oe5ojpGr5i56+lVZCBUc8UAW9QRIhgd+xQ==
X-Google-Smtp-Source: AGRyM1vuMD29kljsl0GpHzt78YL1xIymZnduShGQLqsed8egsOcLI3ESNeQQprVSc5sNYM5+x6/rFQ==
X-Received: by 2002:a05:600c:35ca:b0:3a3:253b:708b with SMTP id r10-20020a05600c35ca00b003a3253b708bmr972816wmq.86.1658264736941;
        Tue, 19 Jul 2022 14:05:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c461800b003a050a391e8sm75091wmo.38.2022.07.19.14.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:05:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] test-lib.sh: add a --invert-exit-code switch
Date:   Tue, 19 Jul 2022 23:05:18 +0200
Message-Id: <patch-04.10-4aab7af60e3-20220719T205710Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1063.gd87c5b8cc23
In-Reply-To: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
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
 t/test-lib.sh    | 36 +++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 1 deletion(-)

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
index 118720493bb..7f730b0f94f 100644
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
@@ -1242,6 +1261,14 @@ test_done () {
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
@@ -1254,6 +1281,13 @@ test_done () {
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
2.37.1.1062.g385eac7fccf

