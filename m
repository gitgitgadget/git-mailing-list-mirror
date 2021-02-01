Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3153C43381
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E1A64EA7
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhBAPpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhBAPpH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 10:45:07 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16776C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 07:44:27 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f14so807805ejc.8
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 07:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WqQXAXMXilFqwKdTsmAUwBtONUx8d2+ziQzwnXGfv7c=;
        b=EbY7Sl4Vj1iwzDs5xCd2946umEPBtOs2CP2P8bsZOs1GxUeZXJdvEVIthXdcgICn19
         09tIGCDIWLSnJP9yx+7ZnEU2kW7ZL0u4iapdLQyhe2Pux2bcemfi+Lxi4uAWrp/F+ttq
         jBJZrSBwB3iC9Rg85G1WENAkZ1AIWE5qnWKv2dqRrVQb28FLlz1aX5Ew/hPYiSdX0aHq
         +ibhDvjZUdAGD2JtunAuVa7LRKmuhUCopKAyrV2AQgxbuO+VDnuJ4gZ+TePxRqp5EYug
         hGeoa2EYLc1dPUFIykmgvVwWH0UMlSZMQaKvf5bsg6h6dD/8ttYoAzQWDQnbOTvicUsM
         YK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WqQXAXMXilFqwKdTsmAUwBtONUx8d2+ziQzwnXGfv7c=;
        b=YxW/nyYSgNSQFq9b0jMFlMWpLTIqm03obQ7vDB0cBZOu9L1gIKOiok9zJ5YnbP5g7W
         NzIOySxmYt/cCxJk+VWKBruM/Y0HIFNv87JC+xwnlhklKNoSJVKPobVh+nyypG5NZJdF
         dIoBJJI/IXWsFnYLYx22JV+ZZ4Ls0sqVtOtW7aJSe05obxIMlViw54YXrRd7Selh0pxw
         Yd5y5HFRmKtd1bgy0+jZ1sdvD6Kzj90us0otVg/lDv/QNCsdqCKEh/++FykNXHUaiMW6
         KvaCDOn/awOrsKqvRAo+qUGxG51tYjYJlIcQSol9TUNTJShR8cLc1kq60PyHio2gzBHs
         arOQ==
X-Gm-Message-State: AOAM531C+1+Hk1WDOsxN7PCXB5uHFeiN7NUyWfnceTkLePWzuJpsO1dS
        7q8A+BnVrv5O87ZCouV9+WI=
X-Google-Smtp-Source: ABdhPJwd4PaU5f4PNnY/GjfYuYCG3vrGxWrjC+co0fVeezV7gIyWixbjrwx3byLPaddzy05Y7ZRe5g==
X-Received: by 2002:a17:906:ce24:: with SMTP id sd4mr2874740ejb.21.1612194265573;
        Mon, 01 Feb 2021 07:44:25 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id u2sm8157150ejb.65.2021.02.01.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:44:24 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Vincent Lefevre <vincent@vinc17.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: git fails with a broken pipe when one quits the pager
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
        <8735yhq3lc.fsf@evledraar.gmail.com>
        <20210131033652.GK623063@zira.vinc17.org>
        <87o8h4omqa.fsf@evledraar.gmail.com>
        <20210201103429.GT623063@zira.vinc17.org>
        <87im7cng42.fsf@evledraar.gmail.com>
        <20210201144857.GB24560@zira.vinc17.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210201144857.GB24560@zira.vinc17.org>
Date:   Mon, 01 Feb 2021 16:44:24 +0100
Message-ID: <87a6snokrr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 01 2021, Vincent Lefevre wrote:

> On 2021-02-01 13:10:21 +0100, =C3=AF=C2=BF=C2=BDvar Arnfj=C3=AF=C2=BF=C2=
=BDr=C3=AF=C2=BF=C2=BD Bjarmason wrote:
>>=20
n>> On Mon, Feb 01 2021, Vincent Lefevre wrote:
>>=20
>> > On 2021-01-31 21:49:49 +0100, =C3=AF=C2=BF=C2=BDvar Arnfj=C3=AF=C2=BF=
=C2=BDr=C3=AF=C2=BF=C2=BD Bjarmason wrote:
>> >> On Sun, Jan 31 2021, Vincent Lefevre wrote:
>> >> > FYI, I already have the exit status already in my prompt (the above
>> >> > commands were just for the example). Still, the git behavior is
>> >> > disturbing.
>> >> >
>> >> > Moreover, this doesn't solve the issue when doing something like
>> >> >
>> >> >   git log && some_other_command
>> >>=20
>> >> What issue? That we're returning an exit code per getting a SIGHUP he=
re
>> >> is a feature. Consider:
>> >>=20
>> >>     git -c core.pager=3D/bin/false log && echo showed you the output
>> >
>> > If the pager exists with a non-zero exit status, it is normal to
>> > return a non-zero exit status. This was not the bug I reported.
>>=20
>> Is it normal? Isn't this subject to the same race noted in
>> https://lore.kernel.org/git/20191115040909.GA21654@sigill.intra.peff.net/
>
> There's a race only because the command is buggy under bash's
> pipefail.
>
> Something like
>
>   git status -s -b | head -1
>
> is fine by default, because the exist status of the LHS command is
> ignored. With pipefail, you may start getting SIGPIPE exit codes,
> which, depending on the context, you may want to ignore or not.
> I suppose that the user who writes something like the above would
> like to ignore SIGPIPE.
>
> So, that should be:
>
>   { git status -s -b; if [[ $? =3D 141 ]]; then return 0; fi } | head -1
>
> (though that's 100% safe only if git catches/blocks/ignores SIGPIPE
> and detect the broken pipe with EPIPE, so that an abnormal termination
> due to a "kill -PIPE ..." from another process would not be ignored).
>
> It appears that pipefail was designed mainly for scripts. So, having
> to handle SIGPIPE like that is OK in scripts. For interactive use,
> this would be bad, but that's not the purpose of pipefail (or bash
> should have an option to regard 141 as 0 in any LHS command).
>
> FYI, I have a zsh function to automatically pipe some commands to
> "less" when connected to a terminal (a bit like what git does),
> where I explicitly ignore SIGPIPE for the command:

I think there's some confusion here. I'm not referring to how "set -o
pipefail" behaves in bash. But pointing to Jeff King's simple example[1]
of how a command like "git status -sb" might exit (note that it may
print more than 1 line) due to a race with how SIGPIPE interacts with
exit statuses. That's *nix/POSIX behavior, nothing to do with bash.

The same will apply to a pager we launch on a command like "git log".

As Chris Torek noted in a side-thread[2] the buffers involved here are
OS-defined. In the general case you may get a PIPEFAIL or not depending
on whether you e.g. cross a PIPE_BUF boundary to get from line 1 to 2 of
your output, while "head -n 1" is consuming it.

But then consider a pager like:

    while (wantit())
	    consume_and_print_output();
    sleep(10);
    exit(1);

Now we can just exit early if it decides it doesn't want our output, as
we'll likely get a SIGPIPE, but if we're ignoring SIGPIPE and we want to
distinguish that from non-zero pager exit codes, we need to wait 10
seconds until waitpid() tells us what the exit status is.

That's obviously a contrived example, but demonstrates the race
condition involved.

1. https://lore.kernel.org/git/20191115040909.GA21654@sigill.intra.peff.net/
2. https://lore.kernel.org/git/CAPx1Gverh2E2h5JOSOfJ7JYvbhjv8hJNLE8y4VA2fNv=
0La8Rtw@mail.gmail.com/

>> >>=20
>> >> Not being able to write "git log" output is a real SIGPIPE.
>> >
>> > Which is not the case here, because the full output has never been
>> > requested by the user.
>>=20
>> They requested it by running "git log", which e.g. for git.git is ~1
>> million lines. Then presumably paged down just a few pages and issued
>> "q" in their pager. At which point we'll fail on the write() in git-log.
>
> But when outputting to a pager, this should not be regarded as an
> error: the reason is either the user has quit the pager normally
> (after having read what he wanted to read: the user did not need
> more output) or the pager has terminated in an abnormal way, in
> which case the exit status of the pager should be non-zero.

In an ideal world, or something we can plausibly implement in a portable
manner on systems that exist in the wild?

Yes I agree that this sort of behavior would be stupid e.g. for an
integrated GUI application, but that's not what we've got. We're calling
an arbitrary user-supplied command and piping output to it, and are then
going to get SIGPIPE or an exit code back.

>> The pager's exit status is usually/always 0 in those cases
>> (e.g. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/more.ht=
ml).
>
> Yes, and there's no reason to return anything else, as quitting the
> pager before reading the full output is not an error.
>
>> So we've got the SIGPIPE to indicate the output wasn't fully
>> consumed.
>
> But the user doesn't care: he quit the pager because he didn't
> need more output. So there is no need to signal that the output
> wasn't fully consumed. The user already knew that before quitting
> the pager!

As noted above, this is assuming way too much about the functionality of
the pager command. We can get a SIGPIPE without the user's intent in
this way. Consider e.g. piping to some remote system via netcat.

>> > [...]
>> >> Maybe we have users who'd like to work around zsh's "setopt
>> >> PRINT_EXIT_VALUE" mode (would you want this patch if you could make z=
sh
>> >> ignore 141?).
>> >
>> > zsh is working as expected, and as I've already said, I ***WANT***
>> > SIGPIPE to be reported by the shell, as it may indicate a real failure
>> > in a script. BTW, I even have a script using git that relies on that:
>> >
>> > { git rev-list --author "$@[-1]" HEAD &&
>> >   git rev-list --grep   "$@[-1]" HEAD } | \
>> >   git "${@[1,-2]:-lv}" --no-walk --stdin
>> >
>> > return $((pipestatus[2] ? pipestatus[2] : pipestatus[1]))
>> >
>> > Here it is important not to lose any information. No pager is
>> > involved, the full output is needed. If for some reason, the
>> > LHS of the pipe fails due to a SIGPIPE but the right hand side
>> > succeeds, the error will be reported.
>>=20
>> Sorry, I really don't see how this is different. I think this goes back
>> to my "'|' shell piping construct[...]" question in the E-Mail you're
>> replying to.
>>=20
>> in both the "git log &&" case and potentially here you'll get a program
>> writing to a pipe getting a SIGPIPE, which is then reflected in the exit
>> code.
>
> I mean that there are SIGPIPEs that one does not want to ignore
> (because they would indicate a problem -- in general in scripts),
> and other ones that should be ignored because they don't indicate
> an error.
>
>> > The fact is that with a pager, the SIGPIPE with a pager is normal.
>> > Thus with a pager, git is reporting a spurious SIGPIPE, and this
>> > is disturbing.
>>=20
>> I don't get what you're trying to say here, sorry.
>
> I mean that when the user quits the pager, there is no reason to
> report an error because the user explicitly wanted to quit now.

Sure, in an ideal world. But we don't get a SIGUSERPRESSEDTHEQBUTTON, we
get a SIGPIPE.

> Similarly, if I run a text viewer on a file, I don't want a SIGPIPE
> to be reported if I do not go to the end of the file (if a pipe was
> used to read the file, e.g. to do some filtering, as "less" can do).

Yes, that makes perfect sense. Neither would I, but that text viewer is
one process, so it doesn't have to deal with IPC and propagating exit
codes from failed IPC.

>> Maybe this helps. So first, I don't know if your report came out of
>> reading the recent "set -o pipefail" traffic on-list. As you can see in
>> [1] I'm not some zealot for PIPEFAIL always being returned no matter
>> what.
>
> This is not related. And [1] is from 2021 (with a thread started
> in 2019), while my report dates back to 2018:
>
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D914896

Indeed, I just misread (or didn't read in the first place) the times
involved. I started reading at Denton Liu's patch sent a couple of days
ago.

> Moreover, [1] is only about the use of pipes in the shell command.
> My bug report is about the internal use of a pager by git.

I probably shouldn't have linked to that thread, but as as noted at the
start of the E-Mail I was referring to it for the SIGPIPE behavior
discussed there, not bash/set -o pipefail etc.

>> The difference between that though and what you're proposing is there
>> you have the shell getting an exit code and opting to ignore it, as
>> opposed to the program itself sweeping it under the rug.
>>=20
>> I don't think either that just because you run a pager you're obligated
>> to ferry down a SIGPIPE if you get it. E.g. mysql and postgresql both
>> have interactive shells where you can open pagers. I didn't bother to
>> check, but you can imagine doing a "show tables" or whatever and only
>> viewing the first page, then quitting in the pager.
>>=20
>> If that's part of a long interactive SQL session it would make no sense
>> for the eventual exit code of mysql(1) or psql(1) to reflect that.
>>=20
>> But with git we're (mostly) executing one-shot commands, e.g. with "git
>> log" you give it some params, and it spews all the output at you, maybe
>> with the help of a pager.
>>=20
>> So then if we fail on the write() I don't see how it doesn't make sense
>> to return the appropriate exit code for that failure downstream.
>
> This depends on the kind of error. I agree for an unexpected error.
> But for a broken pipe because git started a pager on its own and
> the user chose to quit the pager, this should not be regarded as
> an error.

As noted above, we don't have a way of knowing that, we're not the
pager.

It also seems to me that whether git should report errors, and what 3rd
party tools that might invoke git are going to do with a SIGPIPE exit
code is being mixed up here.

And then whether it makes sense to ignore SIGPIPE for all users, or
e.g. if it's some opt-in setting in some situations that users might
want to turn on because they're aware of how their pager behaves and
want to work around some zsh mode.

>> 1. https://lore.kernel.org/git/20210116153554.12604-12-avarab@gmail.com/

