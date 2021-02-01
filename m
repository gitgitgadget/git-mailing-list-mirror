Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D544C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A92C64E08
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 14:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBAOxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhBAOwI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 09:52:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C8C06178C
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 06:49:42 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y187so13436899wmd.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 06:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fM7qUCPJGyb6Z+rE4xM6dI5yPatKD56tb+keMVbb+/E=;
        b=DzU1o9F0+VH+FCWV3E5Icylvw1mxbDeKs4gcU63z98IpRx3SU6t9Bo52x7e1cD5+Jv
         sQCBHtGPXTdMFY+VmpIXgjl0Ry1/xRE7qEOKoG9W7J9XB8kNECjF5VuWkgtrzN38rY6E
         euYt/Cjo442bOtc7c0JyblB0jNuKmBuvyfkDaXLDCc23805NITCH5sAhs3aclj3DhiH2
         lIv67O0yoywyVmEQFO00sT9RmsDzy3vneKEMy9cRdGhhdSFyESNi4x7C5Qjc3DbfEnGS
         cBRLTp4ayxeubTbRs1WWQwopf2I5n4p9+tFCcKzST2YPm9pd4NSKjxM96CMVcufFylh8
         RVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fM7qUCPJGyb6Z+rE4xM6dI5yPatKD56tb+keMVbb+/E=;
        b=e7XDNEcufGvrRD3g4jCvpP0SX0xnFiUk0biiXNxofx4n/Gbfw7hlhGIbCmP3+p81Jm
         vJaGh3zbM0xVm/zhDoiePJ2iLXmuEmmFihfd6bNzm8GaG9UkMe0fnxK7ZPi2iek+PO7e
         cdbxfxQmF0hQ814dJ28mk757F9fukx64w6YUNIBIwaHEh4+2xWiAEJpVli5MtDmGWwMU
         gK5b0O3fuPYH8webL32m7lvCei52ljYnizIhzL+nxiup8Zz9yq1BVadqpIqnLejRri7P
         or5qeN8RJUvK6JKSMQcW1gltt/smKVpPHUfhJFwd+PXMM4+MR3lu4+dXQ81/80z7NXrK
         rg9Q==
X-Gm-Message-State: AOAM5306XI/OPlAe96ejxp/EZEpw+Z6vi8Wv2dMypNnnmBESjV9XmodC
        ok0pi2douPo0jzNEny6VSsI71gquZsTHGw==
X-Google-Smtp-Source: ABdhPJxlInkfqcQeHtMdeA77esoYrBLC7WH1MBI1F3lC7hxlqqxtJXYx97FAB1ksksdfAWOaFuTaSw==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr14976334wmi.105.1612190980558;
        Mon, 01 Feb 2021 06:49:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k4sm28799954wrm.53.2021.02.01.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:49:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] pager: properly log pager exit code when signalled
Date:   Mon,  1 Feb 2021 15:49:21 +0100
Message-Id: <20210201144921.8664-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87im7cng42.fsf@evledraar.gmail.com>
References: <87im7cng42.fsf@evledraar.gmail.com>
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

I'm not quite sure about that BUG() case. Can we have a true in_signal
and not have a true WIFEXITED(status)? I haven't been able to think of
a test case for it.

1. The incorrect logging of the exit code in was seemingly copy/pasted
   into finish_command_in_signal() in ee4512ed481 (trace2: create new
   combined trace facility, 2019-02-22)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c    |  8 +++++--
 t/t7006-pager.sh | 61 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/run-command.c b/run-command.c
index ea4d0fb4b15..10e1c96c2bd 100644
--- a/run-command.c
+++ b/run-command.c
@@ -551,8 +551,12 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 
 	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
 		;	/* nothing */
-	if (in_signal)
-		return 0;
+	if (in_signal && WIFEXITED(status))
+		return WEXITSTATUS(status);
+	if (in_signal) {
+		BUG("was not expecting waitpid() status %d", status);
+		return -1;
+	}
 
 	if (waiting < 0) {
 		failed_errno = errno;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index c60886f43e6..1424466caf5 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -656,31 +656,74 @@ test_expect_success TTY 'git tag with auto-columns ' '
 	test_cmp expect actual
 '
 
-test_expect_success TTY,!MINGW 'git returns SIGPIPE on early pager exit' '
+test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
 	test_when_finished "rm pager-used" &&
 	test_config core.pager ">pager-used; head -n 1; exit 0" &&
+	GIT_TRACE2="$(pwd)/trace.normal" &&
+	export GIT_TRACE2 &&
+	test_when_finished "unset GIT_TRACE2" &&
 
-	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
-	test_match_signal 13 "$OUT" &&
+	if test_have_prereq !MINGW
+	then
+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		test_match_signal 13 "$OUT"
+	else
+		test_terminal git log
+	fi &&
+	grep "child_exit.* code:0 " trace.normal &&
 	test_path_is_file pager-used
 '
 
-test_expect_success TTY,!MINGW 'git returns SIGPIPE on early pager non-zero exit' '
+test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
 	test_when_finished "rm pager-used" &&
 	test_config core.pager ">pager-used; head -n 1; exit 1" &&
+	GIT_TRACE2="$(pwd)/trace.normal" &&
+	export GIT_TRACE2 &&
+	test_when_finished "unset GIT_TRACE2" &&
 
-	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
-	test_match_signal 13 "$OUT" &&
+	if test_have_prereq !MINGW
+	then
+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		test_match_signal 13 "$OUT"
+	else
+		test_terminal git log
+	fi &&
+	grep "child_exit.* code:1 " trace.normal &&
 	test_path_is_file pager-used
 '
 
-test_expect_success TTY,!MINGW 'git discards pager non-zero exit' '
+test_expect_success TTY 'git discards pager non-zero exit' '
 	test_when_finished "rm pager-used" &&
 	test_config core.pager "wc >pager-used; exit 1" &&
+	GIT_TRACE2="$(pwd)/trace.normal" &&
+	export GIT_TRACE2 &&
+	test_when_finished "unset GIT_TRACE2" &&
 
-	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
-	test "$OUT" -eq 0 &&
+	if test_have_prereq !MINGW
+	then
+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		test "$OUT" -eq 0
+	else
+		test_terminal git log
+	fi &&
+	grep "child_exit.* code:1 " trace.normal &&
 	test_path_is_file pager-used
 '
 
+test_expect_success TTY 'git logs nonexisting pager invocation' '
+	test_config core.pager "does-not-exist" &&
+	GIT_TRACE2="$(pwd)/trace.normal" &&
+	export GIT_TRACE2 &&
+	test_when_finished "unset GIT_TRACE2" &&
+
+	if test_have_prereq !MINGW
+	then
+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		test_match_signal 13 "$OUT"
+	else
+		test_terminal git log
+	fi &&
+	grep "child_exit.* code:-1 " trace.normal
+'
+
 test_done
-- 
2.30.0.284.gd98b1dd5eaa7

