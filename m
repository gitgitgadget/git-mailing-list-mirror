Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A5C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E01E64EBD
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhBBCAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhBBCAt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:00:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15261C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:00:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z6so18662500wrq.10
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNhhSf0aIokmEuOzrTve95ZGJhz8Cqrjx3VEjQ5T/1I=;
        b=RAVvC2nOnb3zOBRJJ8P17se6rgouhbH0KcnkdZt5qxRbUtZCfGNUqipo3Mdy9qET1G
         a9eTXEMM5kMR4PUy5fbUbQgvC17wDm01Y9z4YwsmqkbHqD70d/RmjlGgCfUVF/hMTAlZ
         vc5xp+XM1fIZT3wqUC/9e4EVhONk58ZIgjLWJ+uOyQRejm4M9F6SP+f2d+M1sis+Hxn0
         F9Qu0SPeOaFKRgayy5af4LINhN297eUsJvHS68snBbtQQvxTFhb/yGuS1rozQrzaGIlB
         ZdkGS2is0OR9dFccX/K4q6pgVZLLginVuPtAJRIV5WvZ3Wg/9TDSUcTNK/wO0a/ajdjG
         AS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNhhSf0aIokmEuOzrTve95ZGJhz8Cqrjx3VEjQ5T/1I=;
        b=qPQDslGVGW5ZkSSyU7yokoa+upNQ3Xf+YDMP69wU6ULn4Zki/iwArOZp7hMFtGfov/
         eWcaFF8j+OJRMmYC4lNDX/MPnuEOV+I5oFMWg9BQUcgoyYx8EnnusNhnfkjuaqruwJLn
         Grxjb1Ncv/42IUXp85GnRxBYebclCcDwjVGuwgCBU5pUu4hp6EvaYGv6bD+jyvYYAWYY
         m8y1RTrshzZw36wyEMKyNyNvr2NssYJfeNy/96fSvcDIGS4KVf3tuyhXbbVlRtAjcqBg
         DwdZay4JADsLfnqZTkEGQPjnG45h6giJGNYBg6QJiWDGKNRmQkd4DYuPgBFuwxLS2XW1
         RiEg==
X-Gm-Message-State: AOAM5306tnQk5U6d1dvLiqpDtFKJ9cTTpOXyzi/5RZfRDwsjtN2idZhf
        9HEHvHG9x/rlM8ecyNp5znPvvaT6wRcWWw==
X-Google-Smtp-Source: ABdhPJwVb2cuMUfOrSAAJwkcVI5U5LHKCEaV/MUDdgRts/6tm1XIJ9Wzwj9kBA8f35pUlmncXRdpIQ==
X-Received: by 2002:a5d:40c5:: with SMTP id b5mr21427766wrq.121.1612231207097;
        Mon, 01 Feb 2021 18:00:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y24sm986175wmi.47.2021.02.01.18.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:00:06 -0800 (PST)
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
Subject: [PATCH v2 0/5] pager: test for exit behavior & trace2 bug fix
Date:   Tue,  2 Feb 2021 02:59:56 +0100
Message-Id: <20210202020001.31601-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201144921.8664-1-avarab@gmail.com>
References: <20210201144921.8664-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v2 with better tests and some misc adjustments. As noted in v1 1-4
are just adding better test coverage for behavior we already have, and
fixing a small bug in trace2 output.

The 5/5 is a WIP start at respecting the pager's exit code and
ignoring the SIGPIPE. Junio had a suggestion to do that in
<xmqq8s87ld8y.fsf@gitster.c.googlers.com>, but as seen & noted there
it's quite a bit more complex when we have to deal with the atexit
sibling function.

Ævar Arnfjörð Bjarmason (5):
  pager: refactor wait_for_pager() function
  pager: test for exit code with and without SIGPIPE
  run-command: add braces for "if" block in wait_or_whine()
  pager: properly log pager exit code when signalled
  WIP pager: respect exit code of pager over SIGPIPE

 pager.c          |  24 +++++----
 run-command.c    |   7 ++-
 t/t7006-pager.sh | 130 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+), 13 deletions(-)

Range-diff:
2:  6509ae44751 = 1:  aab89cc8619 pager: refactor wait_for_pager() function
1:  cba284dcf55 ! 2:  edf513bb174 pager: test for exit code
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    pager: test for exit code
    +    pager: test for exit code with and without SIGPIPE
     
         Add tests for how git behaves when the pager itself exits with
         non-zero, as well as for us exiting with 141 when we're killed with
    @@ Commit message
         current behavior.
     
         This test construct is stolen from 7559a1be8a0 (unblock and unignore
    -    SIGPIPE, 2014-09-18).
    +    SIGPIPE, 2014-09-18). The reason not to make the test itself depend on
    +    the MINGW prerequisite is to make a subsequent commit easier to read.
     
         1. https://lore.kernel.org/git/87o8h4omqa.fsf@evledraar.gmail.com/
     
    @@ t/t7006-pager.sh: test_expect_success TTY 'git tag with auto-columns ' '
      	test_cmp expect actual
      '
      
    -+test_expect_success TTY,!MINGW 'git returns SIGPIPE on early pager exit' '
    ++test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
     +	test_when_finished "rm pager-used" &&
     +	test_config core.pager ">pager-used; head -n 1; exit 0" &&
     +
    -+	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    -+	test_match_signal 13 "$OUT" &&
    ++	if test_have_prereq !MINGW
    ++	then
    ++		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    ++		test_match_signal 13 "$OUT"
    ++	else
    ++		test_terminal git log
    ++	fi &&
     +	test_path_is_file pager-used
     +'
     +
    -+test_expect_success TTY,!MINGW 'git returns SIGPIPE on early pager non-zero exit' '
    ++test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
     +	test_when_finished "rm pager-used" &&
     +	test_config core.pager ">pager-used; head -n 1; exit 1" &&
     +
    -+	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    -+	test_match_signal 13 "$OUT" &&
    ++	if test_have_prereq !MINGW
    ++	then
    ++		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    ++		test_match_signal 13 "$OUT"
    ++	else
    ++		test_terminal git log
    ++	fi &&
     +	test_path_is_file pager-used
     +'
     +
    -+test_expect_success TTY,!MINGW 'git discards pager non-zero exit' '
    ++test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
     +	test_when_finished "rm pager-used" &&
     +	test_config core.pager "wc >pager-used; exit 1" &&
     +
    -+	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    -+	test "$OUT" -eq 0 &&
    ++	if test_have_prereq !MINGW
    ++	then
    ++		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    ++		test "$OUT" -eq 0
    ++	else
    ++		test_terminal git log
    ++	fi &&
    ++	test_path_is_file pager-used
    ++'
    ++
    ++test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
    ++	test_when_finished "rm pager-used" &&
    ++	test_config core.pager "wc >pager-used; does-not-exist" &&
    ++
    ++	if test_have_prereq !MINGW
    ++	then
    ++		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    ++		test "$OUT" -eq 0
    ++	else
    ++		test_terminal git log
    ++	fi &&
    ++	test_path_is_file pager-used
    ++'
    ++
    ++test_expect_success TTY 'git attempts to page to nonexisting pager command, gets SIGPIPE' '
    ++	test_config core.pager "does-not-exist" &&
    ++
    ++	if test_have_prereq !MINGW
    ++	then
    ++		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    ++		test_match_signal 13 "$OUT"
    ++	else
    ++		test_terminal git log
    ++	fi
    ++'
    ++
    ++test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
    ++	test_when_finished "rm pager-used" &&
    ++	test_config core.pager ">pager-used; test-tool sigchain" &&
    ++
    ++	if test_have_prereq !MINGW
    ++	then
    ++		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    ++		test_match_signal 13 "$OUT"
    ++	else
    ++		test_terminal git log
    ++	fi &&
     +	test_path_is_file pager-used
     +'
     +
-:  ----------- > 3:  0e4cbf80fe1 run-command: add braces for "if" block in wait_or_whine()
3:  d5db936bd11 ! 4:  527f69cf581 pager: properly log pager exit code when signalled
    @@ Commit message
         The wait_or_whine() is only called with a true "in_signal" from from
         finish_command_in_signal(), which in turn is only used in pager.c.
     
    -    I'm not quite sure about that BUG() case. Can we have a true in_signal
    -    and not have a true WIFEXITED(status)? I haven't been able to think of
    -    a test case for it.
    +    The "in_signal && !WIFEXITED(status)" case is not covered by
    +    tests. Let's log the default -1 in that case for good measure.
     
         1. The incorrect logging of the exit code in was seemingly copy/pasted
            into finish_command_in_signal() in ee4512ed481 (trace2: create new
    @@ Commit message
     
      ## run-command.c ##
     @@ run-command.c: static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
    - 
      	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
      		;	/* nothing */
    --	if (in_signal)
    + 	if (in_signal) {
     -		return 0;
    -+	if (in_signal && WIFEXITED(status))
    -+		return WEXITSTATUS(status);
    -+	if (in_signal) {
    -+		BUG("was not expecting waitpid() status %d", status);
    -+		return -1;
    -+	}
    ++		if (WIFEXITED(status))
    ++			code = WEXITSTATUS(status);
    ++		return code;
    + 	}
      
      	if (waiting < 0) {
    - 		failed_errno = errno;
     
      ## t/t7006-pager.sh ##
     @@ t/t7006-pager.sh: test_expect_success TTY 'git tag with auto-columns ' '
      	test_cmp expect actual
      '
      
    --test_expect_success TTY,!MINGW 'git returns SIGPIPE on early pager exit' '
    -+test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
    - 	test_when_finished "rm pager-used" &&
    ++test_expect_success 'setup trace2' '
    ++	GIT_TRACE2_BRIEF=1 &&
    ++	export GIT_TRACE2_BRIEF
    ++'
    ++
    + test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
    +-	test_when_finished "rm pager-used" &&
    ++	test_when_finished "rm pager-used trace.normal" &&
      	test_config core.pager ">pager-used; head -n 1; exit 0" &&
     +	GIT_TRACE2="$(pwd)/trace.normal" &&
     +	export GIT_TRACE2 &&
     +	test_when_finished "unset GIT_TRACE2" &&
      
    --	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    --	test_match_signal 13 "$OUT" &&
    -+	if test_have_prereq !MINGW
    -+	then
    -+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    -+		test_match_signal 13 "$OUT"
    -+	else
    -+		test_terminal git log
    -+	fi &&
    -+	grep "child_exit.* code:0 " trace.normal &&
    + 	if test_have_prereq !MINGW
    + 	then
    +@@ t/t7006-pager.sh: test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
    + 	else
    + 		test_terminal git log
    + 	fi &&
    ++
    ++	grep child_exit trace.normal >child-exits &&
    ++	test_line_count = 1 child-exits &&
    ++	grep " code:0 " child-exits &&
      	test_path_is_file pager-used
      '
      
    --test_expect_success TTY,!MINGW 'git returns SIGPIPE on early pager non-zero exit' '
    -+test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
    - 	test_when_finished "rm pager-used" &&
    + test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
    +-	test_when_finished "rm pager-used" &&
    ++	test_when_finished "rm pager-used trace.normal" &&
      	test_config core.pager ">pager-used; head -n 1; exit 1" &&
     +	GIT_TRACE2="$(pwd)/trace.normal" &&
     +	export GIT_TRACE2 &&
     +	test_when_finished "unset GIT_TRACE2" &&
      
    --	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    --	test_match_signal 13 "$OUT" &&
    -+	if test_have_prereq !MINGW
    -+	then
    -+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    -+		test_match_signal 13 "$OUT"
    -+	else
    -+		test_terminal git log
    -+	fi &&
    -+	grep "child_exit.* code:1 " trace.normal &&
    + 	if test_have_prereq !MINGW
    + 	then
    +@@ t/t7006-pager.sh: test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
    + 	else
    + 		test_terminal git log
    + 	fi &&
    ++
    ++	grep child_exit trace.normal >child-exits &&
    ++	test_line_count = 1 child-exits &&
    ++	grep " code:1 " child-exits &&
      	test_path_is_file pager-used
      '
      
    --test_expect_success TTY,!MINGW 'git discards pager non-zero exit' '
    -+test_expect_success TTY 'git discards pager non-zero exit' '
    - 	test_when_finished "rm pager-used" &&
    + test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
    +-	test_when_finished "rm pager-used" &&
    ++	test_when_finished "rm pager-used trace.normal" &&
      	test_config core.pager "wc >pager-used; exit 1" &&
     +	GIT_TRACE2="$(pwd)/trace.normal" &&
     +	export GIT_TRACE2 &&
     +	test_when_finished "unset GIT_TRACE2" &&
      
    --	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    --	test "$OUT" -eq 0 &&
    -+	if test_have_prereq !MINGW
    -+	then
    -+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    -+		test "$OUT" -eq 0
    -+	else
    -+		test_terminal git log
    -+	fi &&
    -+	grep "child_exit.* code:1 " trace.normal &&
    + 	if test_have_prereq !MINGW
    + 	then
    +@@ t/t7006-pager.sh: test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
    + 	else
    + 		test_terminal git log
    + 	fi &&
    ++
    ++	grep child_exit trace.normal >child-exits &&
    ++	test_line_count = 1 child-exits &&
    ++	grep " code:1 " child-exits &&
      	test_path_is_file pager-used
      '
      
    -+test_expect_success TTY 'git logs nonexisting pager invocation' '
    -+	test_config core.pager "does-not-exist" &&
    + test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
    +-	test_when_finished "rm pager-used" &&
    ++	test_when_finished "rm pager-used trace.normal" &&
    + 	test_config core.pager "wc >pager-used; does-not-exist" &&
     +	GIT_TRACE2="$(pwd)/trace.normal" &&
     +	export GIT_TRACE2 &&
     +	test_when_finished "unset GIT_TRACE2" &&
    + 
    + 	if test_have_prereq !MINGW
    + 	then
    +@@ t/t7006-pager.sh: test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
    + 	else
    + 		test_terminal git log
    + 	fi &&
     +
    -+	if test_have_prereq !MINGW
    -+	then
    -+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    -+		test_match_signal 13 "$OUT"
    -+	else
    -+		test_terminal git log
    ++	grep child_exit trace.normal >child-exits &&
    ++	test_line_count = 1 child-exits &&
    ++	grep " code:127 " child-exits &&
    + 	test_path_is_file pager-used
    + '
    + 
    + test_expect_success TTY 'git attempts to page to nonexisting pager command, gets SIGPIPE' '
    ++	test_when_finished "rm trace.normal" &&
    + 	test_config core.pager "does-not-exist" &&
    ++	GIT_TRACE2="$(pwd)/trace.normal" &&
    ++	export GIT_TRACE2 &&
    ++	test_when_finished "unset GIT_TRACE2" &&
    + 
    + 	if test_have_prereq !MINGW
    + 	then
    +@@ t/t7006-pager.sh: test_expect_success TTY 'git attempts to page to nonexisting pager command, gets
    + 		test_match_signal 13 "$OUT"
    + 	else
    + 		test_terminal git log
    +-	fi
     +	fi &&
    -+	grep "child_exit.* code:-1 " trace.normal
    -+'
     +
    - test_done
    ++	grep child_exit trace.normal >child-exits &&
    ++	test_line_count = 1 child-exits &&
    ++	grep " code:-1 " child-exits
    + '
    + 
    + test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
    +-	test_when_finished "rm pager-used" &&
    ++	test_when_finished "rm pager-used trace.normal" &&
    + 	test_config core.pager ">pager-used; test-tool sigchain" &&
    ++	GIT_TRACE2="$(pwd)/trace.normal" &&
    ++	export GIT_TRACE2 &&
    ++	test_when_finished "unset GIT_TRACE2" &&
    + 
    + 	if test_have_prereq !MINGW
    + 	then
    +@@ t/t7006-pager.sh: test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
    + 	else
    + 		test_terminal git log
    + 	fi &&
    ++
    ++	grep child_exit trace.normal >child-exits &&
    ++	test_line_count = 1 child-exits &&
    ++	grep " code:143 " child-exits &&
    + 	test_path_is_file pager-used
    + '
    + 
-:  ----------- > 5:  842f42340d0 WIP pager: respect exit code of pager over SIGPIPE
-- 
2.30.0.284.gd98b1dd5eaa7

