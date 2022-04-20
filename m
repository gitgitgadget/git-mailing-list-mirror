Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182F6C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 17:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380941AbiDTRMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380924AbiDTRMj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 13:12:39 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E752632D
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:09:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 17so2670952lji.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A/5tmc2xs0VR2zxefUc51vpqPR4WSY74Z29hdresjGw=;
        b=Sx+zQ7mH0ev/kYVj7Pr2anmI09YwuuiYtHRohTUCtvDWM8tu8v8c7+XGqr5gZD/G7i
         1h5rrYHKoigJsfPKMNweKx9oonYjAvNeMwzuwpV6RL1Uzso1TAbIpT482mEhkTwqoXiq
         N6T4dInWETGeLfrebJ8M5VNoks6Hkpi+Jn0k2zWpcIXFyWiVGVViLaIRQ1eqgxnzePJb
         D/JJyuXaULSMfkA8CiALZeOefpVzKyDC1HCLH0/I8v67poxP5smlGNJoqNzOEYqvJX+X
         ZYVBMR/Cjw9CRTvKB3KV2PPCAsW2MwwLVldBfFS8P2hTDW4Ake9Xrha9Bh3vyczwGD6I
         4LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A/5tmc2xs0VR2zxefUc51vpqPR4WSY74Z29hdresjGw=;
        b=Rb+8mZHX0FpPfCTLbIy3J/smRPArcNEADiHnT43GU4zS1l8qjqaypxxdXR4V3cdPbX
         OU5tZSLf9RfN/leRkcsFBfYgF0qGfdcdKMwRzoMBIRH6CtYPlQqnq/CNl6ZCXgGlBWVc
         C0ow4ugRquRL4FZF1Vw5NgfFjZ7Hl6D5c+X3Gpo20Z0CfpDXk9rE4sZh1HWEe4gHwsdY
         1ZM2aGT+fpq6tIj95kCDFGbKgORF5yQm/T0zV3u7oUpbdfQPlMkstqFDy+mYo62N5Iez
         TuLK0OW99E36srOqfPQ3KOMbrisb3WBAYz6uhnutlH8TPNKUmElRRoHdhZSPHmK/TDRW
         NPPA==
X-Gm-Message-State: AOAM530oAXc3dKS74XHblaUHh7GdXOWmmQocv0IUQUGUqwEoKexDw3zE
        H7vvL9te8anwF4BTZ1crTsFo0uNj11ik5ggqNTyK4A==
X-Google-Smtp-Source: ABdhPJyyQ1KLpkaKz/OO7XJMsj6D7Gze/Zz2xO3mCpHdsO1TC1mDr7W2ZwUdBYgFx3h344LfCz7+tP6pqjecZpzR1PE=
X-Received: by 2002:a05:651c:a08:b0:249:88e2:569c with SMTP id
 k8-20020a05651c0a0800b0024988e2569cmr14130031ljq.88.1650474590108; Wed, 20
 Apr 2022 10:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
 <Yl9Hn0C0TwalASC0@google.com> <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
 <xmqqr15rr9k6.fsf@gitster.g>
In-Reply-To: <xmqqr15rr9k6.fsf@gitster.g>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 20 Apr 2022 10:09:38 -0700
Message-ID: <CAJoAoZm7p32Hn=TLQeWUqp_nMjo_TQ2whR4F=cXk4c6PV1M5bA@mail.gmail.com>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 9:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> It *is* true that run-command.c:pp_start_one() sets child_process:err=
=3D-1
> >> for the child and run-command.c:run_hook_ve() didn't do that; that -1
> >> means that start_command() will create a new fd for the child's stderr=
.
> >> Since run_hook_ve() didn't care about the child's stderr before, I
> >> wonder if that is why? Could it be that now that we're processing the
> >> child's stderr, the child no longer thinks stderr is in tty, because t=
he
> >> parent is consuming its output?
> >
> > Exactly, stderr is redirected to a pipe so that we can buffer the
> > output from each process and then write it to the real stdout when the
> > process has finished to avoid the output from different processes
> > getting mixed together. Ideally in this case we'd see that stdout is a
> > tty and create a pty rather than a pipe when buffering the output from
> > the process.
>
> Ah, thanks, and sigh.  That means this was an unintended regression
> caused by use of parallel infrastructure, mixed with a bit of "the
> original problem report wrote hook properly so that when it is not
> connected to a terminal (such as in this new implementation) it
> refrains to do terminal-y things like coloring, so everything is
> working as intended" ;-).
>
> IIRC, the parallel subprocess stuff was invented to spawn multiple
> tasks we internally need (like "checkout these submodules") that are
> not interactive (hence does not need access to stdin) en masse, and
> the output buffering is there to avoid interleaving the output that
> would make it unreadable.
>
> Use of the parallel subprocess API means that we inherently cannot
> give access to the standard input to the hooks.  The users of the
> original run_hooks_ve() API would be OK with that, because it did
> .no_stdin=3D1 before the problematic hooks API rewrite, but I wonder
> what our plans should be for hooks that want to go interactive.
> They could open /dev/tty themselves (and that would have been the
> only way to go interactive even in the old world order, so it is
> perfectly acceptable to keep it that way with .no_stdin=3D1), but if
> they run in parallel, the end-user would not know whom they are
> typing to (and which output lines are the prompts they are expected
> to respond to).
>
> In the longer term, there are multiple possible action items.
>
>  * We probably would want to design a bit better anti-interleaving
>    machinery than "buffer everything and show only after the process
>    exists", if we want to keep using the parallel subprocess API.
>    And that would help the original "do this thing in multiple
>    submodules at the same time" use case, too.

I've noticed this too, but for very noisy things which are
parallelized, I'm not sure a better user experience is possible. I
suppose we could pick the "first" job in the task queue and print that
output as it comes in, so that users are aware that *something* is
happening?

[job 0 starts]
[job 1 starts]
job 0 says 0-foo
[job 1 says 1-foo, but it's buffered]
job 0 says 0-bar
[job 1 says 1-bar, but it's buffered]
[job 0 finishes]
[we replay the buffer from job 1 so far:]
job 1 says 1-foo
job 1 says 1-bar
job 1 says 1-baz
[job 1 finishes]

I think it could be possible, but then job 1 still will never learn
that it's a tty, because it's being buffered to prevent interleaving,
even if we have the illusion of non-buffering.

>
>  * We should teach hooks API to make it _optional_ to use the
>    parallel subprocess API.  If we are not spawning hooks in
>    parallel today, there is no reason to incur this regression by
>    using the parallel subprocess API---this was a needress bug, and
>    I am angry.

To counter, I think that having hooks invoked via two different
mechanisms depending on how many are provided or whether they are
parallelized is a mess to debug and maintain. I still stand by the
decision to use the parallel subprocess API, which I think was
reasonable to expect to do the same thing when jobs=3D1, and I think we
should continue to do so. It simplifies the hook code significantly.

>
>  * the hooks API should learn a mechanism for multiple hooks to
>    coordinate their executions.  Perhaps they indicate their
>    preference if they are OK to be run in parallel, and those that
>    want isolation will be run one-at-a-time before or after others
>    run in parallel, or something.

There is such a mechanism for hooks overall, but not yet for
individual hooks. I know we discussed it at length[1] before, and
decided it would be okay to figure this out later on. I suppose "later
on" may have come :)

>
>  * The hooks API should learn a mechanism for us to tell what
>    execution environment they are in.  Ideally, the hooks, if it is
>    sane to run under the parallel subprocess API, shouldn't have
>    been learning if they are talking to an interactive human user by
>    looking at isatty(), but we should have been explicitly telling
>    them that they are, perhaps by exporting an environment
>    variable.  There may probably be more clue hooks writers want
>    other than "am I talking to human user?" that we would want to
>    enumerate before going this route.

Hm. I was going to mention that =C3=86var and I discussed the possibility
of setting an environment variable for hook child processes, telling
them which hook they are being run as - e.g.
"GIT_HOOK=3Dprepare-commit-msg" - but I suppose that relying on that
alone doesn't tell us anything about whether the parent is being run
in tty. I agree it could be very useful to simply pass
GIT_PARENT_ISATTY to hooks (and I suppose other child processes).
Could we simply do that from start_command() or something else deep in
run-command.h machinery? Then Anthony's use case becomes

if [-t 1|| GIT_PARENT_ISATTY]
 ...

and no need to examine Git version.

 - Emily

1: https://lore.kernel.org/git/20210527000856.695702-2-emilyshaffer%40googl=
e.com
under "Parallelization with dependencies" (and preceding
conversations)
