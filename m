Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905F0C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbiCWUxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240731AbiCWUxK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:53:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4328B6D2
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:51:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r13so3825008wrr.9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FOz3K+n3nAw1cXK/RrFS9+yn7hc0nMT/zyObh+DIB24=;
        b=UcZO2/dMVtODdy7+iBBmfcT0nCSAH3CQDojPuJyXoscFgN1HAOMc82dsH3RFIfJ0Us
         DSw5P+oWaLrgSIuJ812r7F+oAeKaxq1OEJiW7nPIfKGYEhV1RGql421BvbLZ93FYSLw1
         ApkaLYN5WhLUY7dmOonXBirXB7BzmZ3FZaZApD6uqiDnAoPRCHQ+rkNSOhI63C+JvLAp
         LLDJafxMfdmq7dvnW/UHJCWsxr+ebESKRxaWCL/7c/M1mTax+NCdhILeC0vwEsegDiv1
         68ONu1SKgxprdsHJuY40W2BXWuae8L4uoMdvMWpMyBsMMOifyAjmYnGXPP6oBra7Pv6K
         dY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FOz3K+n3nAw1cXK/RrFS9+yn7hc0nMT/zyObh+DIB24=;
        b=oPaRx5qMVdssywkQOvJU++iR469RfvopripjC4dSFd3kWPYNSiFsc4YoY+IOavPGiY
         PLRVICNTV7JA/HfWnSfcvZfpMjXelKtuzB8l5zGYwPBhqUs0SIUXGLnkJYizG6J3mmXw
         1DgaXx+daiv1wH2cH1HigWCN/ANVqWrAYufyJ5fmcenjoR/v4OkY56tWRs5lfacQQx7n
         UUdSSA3UxDQ6xa9UXUObstSZN7mNrhMRWkq7Nk6W+7quPQ/vgAxFjVNHQPcrPt/ovNXj
         qA+Wohmi0ykdDldsZo898KsqEyRdgtMb58JYjz0JVjfvHVJwtmvMOK7HaijRHj2S3+RQ
         5F8g==
X-Gm-Message-State: AOAM532vm8kf/eseAKBc3za+ckJN8n3egEqPzADRecOQKEM0bOzvSTeH
        cJngTOMp4WTNXKNuKsSvma8oQdHHA+2I8Q==
X-Google-Smtp-Source: ABdhPJzaHqU9ztJHWw/lo3TEhnTvNiyBc0Ubh9ZxivhmJcIHDcjbdBWZUeXcymEQZ8Vx/jB0+oUBAg==
X-Received: by 2002:a5d:498b:0:b0:203:e5d5:622c with SMTP id r11-20020a5d498b000000b00203e5d5622cmr1665776wrq.153.1648068698388;
        Wed, 23 Mar 2022 13:51:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b00203f04ed4a8sm780166wrn.13.2022.03.23.13.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:51:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib: have --immediate emit valid TAP on failure
Date:   Wed, 23 Mar 2022 21:51:31 +0100
Message-Id: <patch-1.1-47b236139e6-20220323T204410Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "--immediate" option so that it emits valid TAP on
failure. Before this it would omit the required plan at the end,
e.g. under SANITIZE=leak we'd show a "No plan found in TAP output"
error from "prove":

    $ prove t0006-date.sh ::  --immediate
    t0006-date.sh .. Dubious, test returned 1 (wstat 256, 0x100)
    Failed 1/22 subtests

    Test Summary Report
    -------------------
    t0006-date.sh (Wstat: 256 Tests: 22 Failed: 1)
      Failed test:  22
      Non-zero exit status: 1
      Parse errors: No plan found in TAP output
    Files=1, Tests=22,  0 wallclock secs ( 0.02 usr  0.01 sys +  0.18 cusr  0.06 csys =  0.27 CPU)
    Result: FAIL

Now we'll emit output that doesn't result in TAP parsing failures:

    $ prove t0006-date.sh ::  --immediate
    t0006-date.sh .. Dubious, test returned 1 (wstat 256, 0x100)
    Failed 1/22 subtests

    Test Summary Report
    -------------------
    t0006-date.sh (Wstat: 256 Tests: 22 Failed: 1)
      Failed test:  22
      Non-zero exit status: 1
    Files=1, Tests=22,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.19 cusr  0.05 csys =  0.26 CPU)
    Result: FAIL

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Junio: When this is merged to "seen" there's a conflict like:

	<<<<<<< HEAD
		if test -n "$immediate"
		then
			say_color error "1..$test_count"
			_error_exit
		fi
	=======
		test "$immediate" = "" || _error_exit
		finalize_test_case_output failure "$failure_label" "$@"
	>>>>>>> origin/seen

The "solution" is to end up with:

	test_failure_ () {
		failure_label=$1
		test_failure=$(($test_failure + 1))
		say_color error "not ok $test_count - $1"
		shift
		printf '%s\n' "$*" | sed -e 's/^/#	/'
		if test -n "$immediate"
		then
			say_color error "1..$test_count"
			_error_exit
		fi
		finalize_test_case_output failure "$failure_label" "$@"
	}

Those scare quotes being because the "finalize_test_case_output" is in
the wrong place both before and after, but that's an existing bug in
eb53a5b8047 (ci: call `finalize_test_case_output` a little later,
2022-03-01), i.e. that alternate output mechanism wasn't doing the
right thing on --immediate output.

But this change and that merge resolution doesn't make that any worse,
so hopefully this can be queued anyway. Thanks!
		
 t/t0000-basic.sh | 13 +++++++++++++
 t/test-lib.sh    |  6 +++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 9dcbf518a78..17a268ccd1b 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -101,6 +101,19 @@ test_expect_success 'subtest: 2/3 tests passing' '
 	EOF
 '
 
+test_expect_success 'subtest: --immediate' '
+	run_sub_test_lib_test_err partial-pass \
+		--immediate &&
+	check_sub_test_lib_test_err partial-pass \
+		<<-\EOF_OUT 3<<-EOF_ERR
+	> ok 1 - passing test #1
+	> not ok 2 - failing test #2
+	> #	false
+	> 1..2
+	EOF_OUT
+	EOF_ERR
+'
+
 test_expect_success 'subtest: a failing TODO test' '
 	write_and_run_sub_test_lib_test failing-todo <<-\EOF &&
 	test_expect_success "passing test" "true"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 515b1af7ed4..4373f7d70b5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -806,7 +806,11 @@ test_failure_ () {
 	say_color error "not ok $test_count - $1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
-	test "$immediate" = "" || _error_exit
+	if test -n "$immediate"
+	then
+		say_color error "1..$test_count"
+		_error_exit
+	fi
 }
 
 test_known_broken_ok_ () {
-- 
2.35.1.1452.ga7cfc89151f

