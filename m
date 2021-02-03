Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352AAC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 02:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F0364F68
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 02:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhBCCpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhBCCpo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 21:45:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EE3C06174A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 18:45:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q2so10468911edi.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 18:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MwVmtxvY8+Y3aT7Scq4vctkdzrfkpAOmaig0T9hN9YA=;
        b=LGFQw4t/1nRxOENeehqlFO7vKvj8tpMDDSLPIL6ahfIFSjES4Fo5y7vN3+0vCr9+rO
         za5q5oilWHJbLGLHByLylevR2d8oO7j9ZCihucuw87Lke9RRGVHa1RES498dTe9ZKZoa
         oDfY5TKO5fOMEKuqpwdG70wTRvD619dliofTn4RhUcUC5ucGFy9crhJG3aJPFQaU1e5/
         Ju74FezBtz0pY1UsxDg5Dyhh7wNIA/4tTMn/EgMGfv+8vXD1Ugt3tzQiqLiyy92XIfUK
         n1Ixz1yvm38ACUO1x0sqzdWgDAJmToDYMO2f2lPM/stbRSuSA5YsQhFBW3sFQXAy+nfl
         o24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MwVmtxvY8+Y3aT7Scq4vctkdzrfkpAOmaig0T9hN9YA=;
        b=ERRpxEfvUbhle0xgxg9OXSLjXH4d5GRxHxoIbXMwGKzEpltpnyFmII7uSoM/6kHyED
         +gLstFoDIbg/NSdmrPw/tGPSXmmygF+QBhD/2qy5XWSzldzgrHB0CwDpPS/D41H7PFda
         a2scs4M/R4ee0zAH9JAuFoMeqDM8k5AQoTrzNofWpzK2Nq2BqwZqOOGs0Ijlv3X4BjCb
         nY9xITKM4ypEMR6/nFVtSpV9rx4PpGoODf0uLTNMDFXZZ2k9vxKEIfNLSof81xG+lCcE
         oQ2fzOUgEN5Rberws4noTmhw2IREqCfY767ateRUDQbxvVCUv75E0IFwgMjVNsQXGD4j
         j2ZQ==
X-Gm-Message-State: AOAM531CvnZwzOPvQE4bARuLvQFfEp37c4OL1Q5GdovM2T5gg9meYfxe
        2Nv2Kz4v9AKc3/2HwZqiIdA=
X-Google-Smtp-Source: ABdhPJzdRqHK0FKaKXY6Fr/TEmnA8Rnt3Ww4Lqoy8bs509iI1q4hbL8qjDZZEDtBMml1pLC+AvfCZQ==
X-Received: by 2002:a50:fe04:: with SMTP id f4mr962896edt.63.1612320302254;
        Tue, 02 Feb 2021 18:45:02 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id g16sm289129ejo.107.2021.02.02.18.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 18:45:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
 <87czxjomn8.fsf@evledraar.gmail.com>
 <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
 <87wnvrefbv.fsf@evledraar.gmail.com>
 <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
 <87tuqvdy1b.fsf@evledraar.gmail.com>
 <xmqqo8h3hybf.fsf@gitster.c.googlers.com>
 <xmqqczxjhwgv.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqczxjhwgv.fsf@gitster.c.googlers.com>
Date:   Wed, 03 Feb 2021 03:45:00 +0100
Message-ID: <87r1lxeuoj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 02 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sorry, but you still have lost me---I do not see if/why we even care
>> about atexit codepath.  As far as the end users are concered, they
>> are running "git" and observing the exit code from "git".  There,
>> reporting that "git" was killed by SIGPIPE, instead of exiting
>> normally, is not something they want to hear about after quitting
>> their pager, and that is why the signal reception codepath matters.
>
> (something I noticed that I left unsaid...)
>
> On the other hand, "git" spawns not just pager but other
> subprocesses (e.g. "hooks"), and it is entirely up to us what to do
> with the exit code from them.  When we care about making an external
> effect (e.g. post-$action hooks that are run for their side effects),
> we can ignore their exit status just fine.
>
> And I do not see why the "we waited before leaving, and noticed the
> pager exited with non-zero status" that we could notice in the
> atexit codepath has to be so special.  We _could_ (modulo the "exit
> there is not portable" you noted) make our exit status reflect that,
> but I do not think it is all that important a "failure" (as opposed
> to, say, we tried to show a commit message but failed to recode it
> into utf-8, or we tried to spawn the pager but failed to start a
> process) to clobber _our_ exit status with pager's exit status.

Because your patch upthread makes git's exit code on pager failure a
function of how your PIPE_BUF happens to be consumed on your OS.

You can see this if you do this:

    diff --git a/pager.c b/pager.c
    index ee435de6756..5124124ac36 100644
    --- a/pager.c
    +++ b/pager.c
    @@ -30,0 +31 @@ static void wait_for_pager_atexit(void)
    +       trace2_region_enter_printf("pager", "wait_for_pager_atexit", the_repository, "%d", 0);
    @@ -35,0 +37 @@ static void wait_for_pager_signal(int signo)
    +       trace2_region_enter_printf("pager", "wait_for_pager_signal", the_repository, "%d", 1);

And then e.g.:

    GIT_TRACE2_EVENT=/tmp/trace2.json ~/g/git/git -c core.pager="less; exit 1" log -100; echo $?

On my laptop & screen size I get around ~20 page lenghts with less
before I get to the end.

If I quit on the first page I get an exit code of 141, ditto the second,
on everything from the 3rd forward I get an exit code of 0. Because at
that point git's/the OS/pipe buffers etc. have flushed the rest to the
pager.

So:

 1. With something like your patch we'd get an exit code of !0 on pager
    failure only if the user won the PIPE_BUF roulette.

 2. With finishing up my "WIP/PATCH v2 5/5" we'd get consistent exit
    codes carried down, but that patch is insanity already, and
    finishing it would be even crazier.

So I haven't been advocating for #2, just the #0 of "I don't really see
the problem with the current behavior of SIGHUP, maybe configure your
shell?".

B.t.w. to <5772995f-c887-7f13-6b5f-dc44f4477dcb@kdbg.org> in the
side-thread: Having a smarter pager than just less isn't really all that
unusual, e.g. it's very handy on a remote system to type commands
interactively but sloooowly, but then configure a pager with some
combination of an ssh tunnel + nc + remote system's screen so you can
browse around without every search/page up/down taking 1-2 seconds.

It's also nice when a thing like that can quit as fast as possible when
it gets SIGHUP, not wait on the exit code of the spawned program, which
may involve tearing down an ssh session or whatever.

But I digress.

Getting back to the point, whatever anyone thinks of returning SIGHUP as
we do now or not, I think it's bonkers to ignore SIGHUP and *then*
return a non-zero *only in the non-atexit case*.

That just means that if you do have a broken pager you're going to get
flaky exits depending on the state of our flushed buffers, who's going
to be helped by such a fickle exit code?

So if we're going to change the behavior to not return SIGHUP, and don't
want to refactor our entire atexit() handling in #2 to be guaranteed to
pass down the pager's exit code, I don't see how anything except the
approach of just exit(0) in that case makes sense, which is what Denton
Liu's patch initially suggested doing.
