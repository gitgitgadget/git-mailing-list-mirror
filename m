Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B390C433E9
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710B964ED9
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhBBCBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhBBCAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:00:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEDCC0613ED
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:00:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so18757396wrx.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkcQ3Z/ZVzXEnJrNco3wtBCYLs+WMu1oVBQwfU46ksM=;
        b=c8S7X80/4EC56ixCQzNRTVt91PDbarCxIoTtS+m1PeHuYGYZuhLBqEzA/VC9EKz1E7
         koxJE3S8QC2oFAKewrB/2oQcBkGB6+NbMUb9Dw4Hp0VQwS5pv9se9y+5hXJ1ExkHDhkM
         BYqjiSNQVL0oR1AxpiIqT7v7jXif9BXc0N62m17awx8G4f2HASa05Z0apzdwV+Crj0Bg
         gkRqKBv26AuBiWSqphZp8S9xp8V5KeAiIjKYwerrT4BS0aKw2Eas5PlHDLwUX36Est0U
         RSTitiAjYh3GECpRSc7urXn96onTrpW8ot90greyh1kdzVaNc/QUBAd8IO2PsB5Fwm2T
         4u8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkcQ3Z/ZVzXEnJrNco3wtBCYLs+WMu1oVBQwfU46ksM=;
        b=AfX8fS1aKChJrnYN9CILyCHX0PChCPRfwNQToERM2k761i3qo1YM43LZzRs4UgQEzG
         yWzR8IYXJAdMamj81yUni2fmJ+sXowxpwd6COpTbRuEkYQc18cI5Sve24wbFWf726nac
         ELn1I8CEqJBKKaQLYyUA8Vt6gpABDxM769o9tREvIPSU7F7ANVzvkYgvzB/FBvrVFX12
         UfbzEC8GNAICynk7JMCE9n5iLx4MTe3AJMLO+uwksgpL0undSkg0xL+BUIVinnVTnzXM
         bkCEZTd8YI/BBmRl98wV8IsibyufkwoXyoIG79ZanYBcxu3RkW+ax4Mta97cgsPWDX4j
         nYQA==
X-Gm-Message-State: AOAM530ihw3zZuzXjzY0cBnlvx5HD2/+u/9puEHrGcl+7ai1YT6glb+m
        nEAIzBsIP9d0fSCWmCLPxbaJFeCUy1/VlQ==
X-Google-Smtp-Source: ABdhPJyNgzf2f2iDwEJJ5+kvn9YZ4xuaG7mYq2hxGLI+Is1Po/r1dlu+vFoq9tnNQuXv7bW+rJ/ezg==
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr21813142wrt.248.1612231211542;
        Mon, 01 Feb 2021 18:00:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y24sm986175wmi.47.2021.02.01.18.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:00:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] pager: properly log pager exit code when signalled
Date:   Tue,  2 Feb 2021 03:00:00 +0100
Message-Id: <20210202020001.31601-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201144921.8664-1-avarab@gmail.com>
References: <20210201144921.8664-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git invokes a pager that exits with non-zero the common case is
that we'll already return the correct SIGPIPE failure from git itself,
but the exit code logged in trace2 has always been incorrectly
reported[1]. Fix that and log the correct exit code in the logs.

Since this gives us something to test outside of our recently-added
tests needing a !MINGW prerequisite, let's refactor the test to run on
MINGW and actually check for SIGPIPE outside of MINGW.

The wait_or_whine() is only called with a true "in_signal" from from
finish_command_in_signal(), which in turn is only used in pager.c.

The "in_signal && !WIFEXITED(status)" case is not covered by
tests. Let's log the default -1 in that case for good measure.

1. The incorrect logging of the exit code in was seemingly copy/pasted
   into finish_command_in_signal() in ee4512ed481 (trace2: create new
   combined trace facility, 2019-02-22)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c    |  4 +++-
 t/t7006-pager.sh | 60 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index 00e68f37aba..509841bf273 100644
--- a/run-command.c
+++ b/run-command.c
@@ -552,7 +552,9 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
 		;	/* nothing */
 	if (in_signal) {
-		return 0;
+		if (WIFEXITED(status))
+			code = WEXITSTATUS(status);
+		return code;
 	}
 
 	if (waiting < 0) {
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0aa030962b1..0e7cf75435e 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -656,9 +656,17 @@ test_expect_success TTY 'git tag with auto-columns ' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup trace2' '
+	GIT_TRACE2_BRIEF=1 &&
+	export GIT_TRACE2_BRIEF
+'
+
 test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
-	test_when_finished "rm pager-used" &&
+	test_when_finished "rm pager-used trace.normal" &&
 	test_config core.pager ">pager-used; head -n 1; exit 0" &&
+	GIT_TRACE2="$(pwd)/trace.normal" &&
+	export GIT_TRACE2 &&
+	test_when_finished "unset GIT_TRACE2" &&
 
 	if test_have_prereq !MINGW
 	then
@@ -667,12 +675,19 @@ test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
 	else
 		test_terminal git log
 	fi &&
+
+	grep child_exit trace.normal >child-exits &&
+	test_line_count = 1 child-exits &&
+	grep " code:0 " child-exits &&
 	test_path_is_file pager-used
 '
 
 test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
-	test_when_finished "rm pager-used" &&
+	test_when_finished "rm pager-used trace.normal" &&
 	test_config core.pager ">pager-used; head -n 1; exit 1" &&
+	GIT_TRACE2="$(pwd)/trace.normal" &&
+	export GIT_TRACE2 &&
+	test_when_finished "unset GIT_TRACE2" &&
 
 	if test_have_prereq !MINGW
 	then
@@ -681,12 +696,19 @@ test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
 	else
 		test_terminal git log
 	fi &&
+
+	grep child_exit trace.normal >child-exits &&
+	test_line_count = 1 child-exits &&
+	grep " code:1 " child-exits &&
 	test_path_is_file pager-used
 '
 
 test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
-	test_when_finished "rm pager-used" &&
+	test_when_finished "rm pager-used trace.normal" &&
 	test_config core.pager "wc >pager-used; exit 1" &&
+	GIT_TRACE2="$(pwd)/trace.normal" &&
+	export GIT_TRACE2 &&
+	test_when_finished "unset GIT_TRACE2" &&
 
 	if test_have_prereq !MINGW
 	then
@@ -695,12 +717,19 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
 	else
 		test_terminal git log
 	fi &&
+
+	grep child_exit trace.normal >child-exits &&
+	test_line_count = 1 child-exits &&
+	grep " code:1 " child-exits &&
 	test_path_is_file pager-used
 '
 
 test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
-	test_when_finished "rm pager-used" &&
+	test_when_finished "rm pager-used trace.normal" &&
 	test_config core.pager "wc >pager-used; does-not-exist" &&
+	GIT_TRACE2="$(pwd)/trace.normal" &&
+	export GIT_TRACE2 &&
+	test_when_finished "unset GIT_TRACE2" &&
 
 	if test_have_prereq !MINGW
 	then
@@ -709,11 +738,19 @@ test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
 	else
 		test_terminal git log
 	fi &&
+
+	grep child_exit trace.normal >child-exits &&
+	test_line_count = 1 child-exits &&
+	grep " code:127 " child-exits &&
 	test_path_is_file pager-used
 '
 
 test_expect_success TTY 'git attempts to page to nonexisting pager command, gets SIGPIPE' '
+	test_when_finished "rm trace.normal" &&
 	test_config core.pager "does-not-exist" &&
+	GIT_TRACE2="$(pwd)/trace.normal" &&
+	export GIT_TRACE2 &&
+	test_when_finished "unset GIT_TRACE2" &&
 
 	if test_have_prereq !MINGW
 	then
@@ -721,12 +758,19 @@ test_expect_success TTY 'git attempts to page to nonexisting pager command, gets
 		test_match_signal 13 "$OUT"
 	else
 		test_terminal git log
-	fi
+	fi &&
+
+	grep child_exit trace.normal >child-exits &&
+	test_line_count = 1 child-exits &&
+	grep " code:-1 " child-exits
 '
 
 test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
-	test_when_finished "rm pager-used" &&
+	test_when_finished "rm pager-used trace.normal" &&
 	test_config core.pager ">pager-used; test-tool sigchain" &&
+	GIT_TRACE2="$(pwd)/trace.normal" &&
+	export GIT_TRACE2 &&
+	test_when_finished "unset GIT_TRACE2" &&
 
 	if test_have_prereq !MINGW
 	then
@@ -735,6 +779,10 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 	else
 		test_terminal git log
 	fi &&
+
+	grep child_exit trace.normal >child-exits &&
+	test_line_count = 1 child-exits &&
+	grep " code:143 " child-exits &&
 	test_path_is_file pager-used
 '
 
-- 
2.30.0.284.gd98b1dd5eaa7

