Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20321C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A2860F46
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhJXRGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJXRGS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:06:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0523FC061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:03:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r6-20020a1c4406000000b0032cb5539960so809704wma.0
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZqReXcztJ0B/9pNqxQPaJgakGqp7dwcQWEn06u3n1Xs=;
        b=SggtdhZdIQvk4vdIMdFeaeZRw0yLL120O1aReyaD1hneAM86hmTPBVYOYpJm8UdmtP
         bJ93CbgJKUzlDU82Ry/T2m79HpiGN7RIVRnhuJ5eUyvyEGnMG2U+66bgxGwt3xQ85vBz
         04o+DMyXvkr07HaTXnt6tDxpHaSESJF5zChxlikbQU6JHE5F13k1MVmQmSIi5WS5tuie
         tn7lioyHN1sBzbJ3SwDXVDPuXTduThK6R18q6MwVo3Ul5edf68w8GNoR4ErIb+K3vfpc
         Mv85ZfxsDfIXBh2tP3iOBL6rZXgINU6Owh8ocWGk9RKPZ/8R0PtmAwljf3wzxNSp4I1V
         I7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZqReXcztJ0B/9pNqxQPaJgakGqp7dwcQWEn06u3n1Xs=;
        b=pBU3PyzOpD4kwC/p9yN4vNqRmSXzUwNbLhzMFpV1W6kEAQ5kDW13Vz8CCh+B/LOG6n
         8xqR5UsBePko7o2IHHp9BTKHpBiylbXLk9d3x7nRmDpo8xL+iU65rGobPJyN8RuPH/PC
         jcqZYgxIP/uH2gSp3LfAO9ejUru6eu/nRPaKgz6Yo1kZISHjRjtVVVInweCZ6gO6lnH4
         bleseKaYYH6xw3R0Le8PTx742QPIwt090RhmjXhGJK4PCaUwN48mb786skLn+SyFP1RR
         xey6EMKzxIbzzpxJt10CXO6ofynNZ3Em7017bofiVHvnK7T0BUmAIjU2imkP1l/UawVD
         RJlA==
X-Gm-Message-State: AOAM532qA/rPYsruPXHeo6BnhWb/YYjzyZwPqj+T7/Bgq2HMdqgUKJkB
        +rpmFcWCbgx1P+TtdlCwrZE=
X-Google-Smtp-Source: ABdhPJxHzjCE8elSyeVLQqm2jxr16R5mwK2MI9BP6ADlVOGtGXoRr51RM68f+MfyYhumganOX3SKWw==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr7812768wmf.80.1635095035397;
        Sun, 24 Oct 2021 10:03:55 -0700 (PDT)
Received: from szeder.dev (94-21-23-225.pool.digikabel.hu. [94.21.23.225])
        by smtp.gmail.com with ESMTPSA id m12sm1250655wrq.69.2021.10.24.10.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:03:55 -0700 (PDT)
Date:   Sun, 24 Oct 2021 19:03:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Is t7006-pager.sh racy?
Message-ID: <20211024170349.GA2101@szeder.dev>
References: <xmqq1r4b8ezp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r4b8ezp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 23, 2021 at 05:04:42PM -0700, Junio C Hamano wrote:
> It seems under --stress it is fairly easy to break the said test,
> especially the one near the end

I couldn't reproduce a failure with --stress, but after a cursory look
into those tests I doubt that either that test or any of the
preceeding SIGPIPE tests added in c24b7f6736 (pager: test for exit
code with and without SIGPIPE, 2021-02-02) actually check what they
are supposed to.

>     test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
>             test_when_finished "rm pager-used trace.normal" &&
>             test_config core.pager ">pager-used; test-tool sigchain" &&
>             GIT_TRACE2="$(pwd)/trace.normal" &&
>             export GIT_TRACE2 &&
>             test_when_finished "unset GIT_TRACE2" &&
> 
>             if test_have_prereq !MINGW
>             then
>                     OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&

This way too convoluted contruct doesn't do what we expect it to do,
see below.

>                     test_match_signal 13 "$OUT"
>             else
>                     test_terminal git log
>             fi &&
> 
>             grep child_exit trace.normal >child-exits &&
>             test_line_count = 1 child-exits &&
>             grep " code:143 " child-exits &&
>             test_path_is_file pager-used
>     '
> 
> When it fails the code in child-exits is actually -1 not 143, a
> propagated pipe.
> 
> What makes us expect that the "git log" invocation should trigger a
> SIGPIPE in the first place?

A misunderstanding, perhaps, because those 'git log' commands with
their early-exiting pagers rarely trigger SIGPIPE.

>  test-sigchain emitting a few lines and
> exiting without ever reading from its standard input?

It's 'test_terminal.perl' emitting whatever it read from 'git log' to
the "| :" pipe, which doesn't ever read from its standard input.

> Will it
> reliably die soon enough before, or linger around until, we attempt
> to write to the pager?  If it does not die quickly enough, can we
> attempt to write, successfully fill the buffer between us and the
> pager, and wait to notice that test-sigchain exiting with non-zero,
> or something?

The history used in those tests is rather small, 'git log |wc -c'
shows that it outputs merely 811 bytes, which is not enough to fill
any kind of buffers.  So I think 'git log' can only get SIGPIPE if it
is still actively producing output after the pager command has already
exited.

The first two tests in the patch below use such an early-exiting pager
that is supposed to trigger a SIGPIPE, but without that unnecessarily
clever construct from the other tests, and demonstrate that 'git log'
usually exits with success; './t7006-pager.sh --no-chain-lint -r
1,2,101,109,110 --stress' usually takes a few repetitions to fail.

The third test below sends 'test_terminal's output to a non-reading
pipe stage, and along with the debug output added to
'test-terminal.perl' demonstrate that it's 'test_terminal' that
reliably gets SIGPIPE, or at least './t7006-pager.sh --no-chain-lint
-r 1,2,101,111 --stress' didn't fail in 1000+ repetitions.

All this means that when those tests run

    OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
    test_match_signal 13 "$OUT"

then though they intend to match a SIGPIPE in 'git log' supposedly
triggeres by the early-exiting pager, they mistakelly match the
unexpected SIGPIPE in 'test_terminal' triggered by "| :" instead.


  ---  >8  ---

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435..e3a2cacbb7 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -786,4 +786,35 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 	test_path_is_file pager-used
 '
 
+echo "'git log' output size: $(git log |wc -c)"
+
+test_expect_success TTY 'early pager exit rarely triggers SIGPIPE #1' '
+	test_when_finished "rm -f pager-used" &&
+	test_config core.pager ">pager-used; head -n 1; exit 0" &&
+
+	test_terminal git log &&
+	test_path_is_file pager-used
+'
+
+test_expect_success TTY 'early pager exit rarely triggers SIGPIPE #2' '
+	test_when_finished "rm -f pager-used" &&
+	test_config core.pager ">pager-used; head -n 1; exit 0" &&
+
+	echo 0 >expect.EC &&
+	# Needs --no-chain-lint
+	( test_terminal git log ; echo $? >EC ) &&
+	test_cmp expect.EC EC &&
+	test_path_is_file pager-used
+'
+
+test_expect_success TTY '"test_terminal ... | :" triggers SIGPIPE in test_terminal' '
+	test_when_finished "rm -f pager-used" &&
+	test_config core.pager ">pager-used; head -n 1; exit 0" &&
+
+	test_terminal git log 2>err | : &&
+	grep "test-terminal.perl caught SIGPIPE" err &&
+	! grep "test-terminal.perl: waitpid() for child process" err &&
+	test_path_is_file pager-used
+'
+
 test_done
diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 1bcf01a9a4..064623031c 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -22,11 +22,14 @@ sub start_child {
 	return $pid;
 }
 
+$SIG{PIPE} = sub { die "test-terminal.perl caught SIGPIPE: $!" };
+
 # Wait for $pid to finish.
 sub finish_child {
 	# Simplified from wait_or_whine() in run-command.c.
 	my ($pid) = @_;
 
+	warn "test-terminal: waitpid() for child process";
 	my $waiting = waitpid($pid, 0);
 	if ($waiting < 0) {
 		die "waitpid failed: $!";
