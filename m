Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892E3C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEBF20777
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBOv3rvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCYFlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:41:31 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42800 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYFl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:41:27 -0400
Received: by mail-wr1-f47.google.com with SMTP id h15so1317910wrx.9
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L7kQUzKOBxExsTka+a+C/tA1DcKmOKX5+TTECXmy1JY=;
        b=vBOv3rvbnxf9fB8X+XDyQzylfw32qjOj1PTmDRJEbaNOuLGsM6LRrrOem1iuVFW8M1
         cDcGpDh1QKlda/Rzn3hn4ZZk8Tjz8tvvXqJb4a4h0oNuJv5cYcPvKbyqw/3Ix+CP6h+g
         /l1JWBPIVnHmFRJiPT+39aq/uo9rBa/uP1pwTB+bO9t0+tMc2BBrNsVOtTR+hyNLTkTy
         00u01Q5SDY+vlPwO4Hou64lbHCLGAyAtXMhCznSCRPBvzhSwJtdiq/QSgL+nFu4hWy6G
         XgyH7GDQshjSXtSfwytszjw8RNA08GII2cO8RcEuSSN3r5DDb0ZiPIl6k+EJ7jtUxpMo
         eoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L7kQUzKOBxExsTka+a+C/tA1DcKmOKX5+TTECXmy1JY=;
        b=cPNcD6ymvOjxJzY29+hQFEQQ0eFJuCRbBDuj8s8SNjgclkWfc+KO12mBhcF6KCcfA+
         gms75A//rQvVZxiN4YwycSZqg53L3kg4xA5oAzwl3Ke9JG7stxDZTWNwqbwoOyyJBJSv
         IEmaeRoQpZ+CCjDcbdxkahqW6do+eUDBW1mdoMWR2l92W8RuVG7xVwdvIRiHetGNrCXt
         SI2MQfwgZP0Ggd03i6YLA/Q0lrs08MlBFcn8OtwrajS4i9Koxog09Yi6T1E7rHF3U8AN
         LZ4JzT2S3jWSU2l8dY62+H59vTth4lrjgM9iLsDGYXHQ9DbI8/6kR8hLgUM6VrlfPTm6
         zHrw==
X-Gm-Message-State: ANhLgQ35u8hx2IOYBHQ9mCdvJiC231vpQPxgqSIiFmbJXXYvBjT7d37e
        gGhHHsr/vWmy3VhpvUmEZ1yM/RTE
X-Google-Smtp-Source: ADFU+vtMCOshQiKp7wapoSjJ8d6kbiLIXaFDRQcdY40pBvLCpMs5ETl7KhyBm8Ffv03uU4Tqxiyy+Q==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr1397723wrr.48.1585114885509;
        Tue, 24 Mar 2020 22:41:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17sm888991wrp.11.2020.03.24.22.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:41:25 -0700 (PDT)
Message-Id: <0767c8b77c820cfc03bbc617da4dc9f20ba4a46a.1585114881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 05:41:20 +0000
Subject: [PATCH v2 4/5] tests: do not let lazy prereqs inside `test_expect_*`
 turn off tracing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `test_expect_*` functions use `test_eval_` and so does
`test_run_lazy_prereq_`. If tracing is enabled via the `-x` option,
`test_eval_` turns on tracing while evaluating the code block, and turns
it off directly after it.

This is unwanted for nested invocations.

One somewhat surprising example of this is when running a test that
calls `test_i18ngrep`: that function requires the `C_LOCALE_OUTPUT`
prereq, and that prereq is a lazy one, so it is evaluated via
`test_eval_`, the command tracing is turned off, and the test case
continues to run _without tracing the commands_.

Another somewhat surprising example is when one lazy prereq depends on
another lazy prereq: the former will call `test_have_prereq` with the
latter one, which in turn calls `test_eval_` and -- you guessed it --
tracing (if enabled) will be turned off _before_ returning to evaluating
the other lazy prereq.

As we will introduce just such a scenario with the GPG, GPGSM and
RFC1991 prereqs, let's fix that by introducing a variable that keeps
track of the current trace level: nested `test_eval_` calls will
increment and then decrement the level, and only when it reaches 0, the
tracing will _actually_ be turned off.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0000-basic.sh | 13 +++++++++++++
 t/test-lib.sh    |  6 ++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 3e440c078d5..b8597216200 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -833,6 +833,19 @@ then
 	exit 1
 fi
 
+test_expect_success 'lazy prereqs do not turn off tracing' "
+	run_sub_test_lib_test lazy-prereq-and-tracing \
+		'lazy prereqs and -x' -v -x <<-\\EOF &&
+	test_lazy_prereq LAZY true
+
+	test_expect_success lazy 'test_have_prereq LAZY && echo trace'
+
+	test_done
+	EOF
+
+	grep 'echo trace' lazy-prereq-and-tracing/err
+"
+
 test_expect_success 'tests clean up even on failures' "
 	run_sub_test_lib_test_err \
 		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ea1e5a05ed..dbf25348106 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -882,6 +882,7 @@ maybe_setup_valgrind () {
 	fi
 }
 
+_trace_level=0
 want_trace () {
 	test "$trace" = t && {
 		test "$verbose" = t || test "$verbose_log" = t
@@ -895,7 +896,7 @@ want_trace () {
 test_eval_inner_ () {
 	# Do not add anything extra (including LF) after '$*'
 	eval "
-		want_trace && set -x
+		want_trace && _trace_level=$(($_trace_level+1)) && set -x
 		$*"
 }
 
@@ -926,7 +927,8 @@ test_eval_ () {
 		test_eval_ret_=$?
 		if want_trace
 		then
-			set +x
+			test 1 = $_trace_level && set +x
+			_trace_level=$(($_trace_level-1))
 		fi
 	} 2>/dev/null 4>&2
 
-- 
gitgitgadget

