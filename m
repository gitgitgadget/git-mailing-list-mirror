Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6942C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3BB20714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI+xG82n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgCZPff (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:35:35 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:45428 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgCZPfe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 11:35:34 -0400
Received: by mail-ed1-f45.google.com with SMTP id u59so7271243edc.12
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rQUbvxTSezPan3293Q6f6exzq1VQ8yKiUsD6iNm48yQ=;
        b=FI+xG82nEX2s0LPM0xB/Quiu9Rhb2vPnXjvfS3wmT+pZSnhfz/0EB4QxOHttF2j7dS
         cZbC+8wfneHoFXQhe5d/2AyFxNBvM4WVmhKiImHaM0fOVNnR2MLAGjOlYincsAaELlM7
         EMcA4P2kU4Zww+I1EhZWSfmxJ7OuNsQZMqWZZpJ0ZspUVIJmv+E1+JZ4WU67N/BLufbk
         1CPxR/hoLGn1hpqk6qGUG9P63JZdyGQmnYS9ia3No6EIaKwhtg03czxlQqBuTAhlEeni
         HOMd4bVTpCceQnRrdG16Qd3eafPYiIyU2M5hB9ny1vI0Ob07k8PlD36+OOU8mBq9tH7T
         S+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rQUbvxTSezPan3293Q6f6exzq1VQ8yKiUsD6iNm48yQ=;
        b=qjwPpPVY25aF0IVeOjM8cLISLt+DK6lvmjyt/1kW6zVX1rNCww3VHAli24kHVB+J11
         pQ+3vBgk+lnvNwjLWPYnP4QFcpFwkcvJEC8kJB4MBmp3d41xLUd3kxhsLq20WZnrMS2k
         MSeoJMWm7azf8cDVIuh5MURwZBurj+b7A4+3SR3IRgwyHltTRhu2Nipj6YUce3TcxLan
         Iz0lVoZ37LM6H7AbEzROZQdMwtT29QVMGRmEwmSKD3/4+YNgIWuPk67gK/t7+V5ANfEB
         o2YIAXhgnq5ntwpkgFsWZwjk53N14C63F63PpkuhtIfgN2o4aN5bGn3Z04TAwPV0gfS8
         RJ7A==
X-Gm-Message-State: ANhLgQ2BQrklMyIT45SqWnHgtQWmAEo2rvDyTjL4PmfWIg/QhhMe7qmA
        p6DLuBQlgYmRz5LVGDa9iIeWVfYN
X-Google-Smtp-Source: ADFU+vuf50zLbyZQ0p24XWCuD9WlzJ61v7EqpxsFK0DZ9ixF/9cq2pMx99s1iubyrKfNZBTrwPZ99A==
X-Received: by 2002:a17:906:1504:: with SMTP id b4mr8328113ejd.275.1585236932697;
        Thu, 26 Mar 2020 08:35:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id gr15sm337946ejb.12.2020.03.26.08.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:35:32 -0700 (PDT)
Message-Id: <f35830c0eba216b7b4f144409e302a87ff8b5c06.1585236929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
References: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 15:35:26 +0000
Subject: [PATCH v3 3/5] tests: do not let lazy prereqs inside `test_expect_*`
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
index 0ea1e5a05ed..529056be497 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -882,6 +882,7 @@ maybe_setup_valgrind () {
 	fi
 }
 
+trace_level_=0
 want_trace () {
 	test "$trace" = t && {
 		test "$verbose" = t || test "$verbose_log" = t
@@ -895,7 +896,7 @@ want_trace () {
 test_eval_inner_ () {
 	# Do not add anything extra (including LF) after '$*'
 	eval "
-		want_trace && set -x
+		want_trace && trace_level_=$(($trace_level_+1)) && set -x
 		$*"
 }
 
@@ -926,7 +927,8 @@ test_eval_ () {
 		test_eval_ret_=$?
 		if want_trace
 		then
-			set +x
+			test 1 = $trace_level_ && set +x
+			trace_level_=$(($trace_level_-1))
 		fi
 	} 2>/dev/null 4>&2
 
-- 
gitgitgadget

