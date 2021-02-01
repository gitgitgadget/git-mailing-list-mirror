Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9F8C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5864D64DB1
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhBAMLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBAMLE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 07:11:04 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED07C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 04:10:23 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p20so4622329ejb.6
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 04:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=eVxK+TSg5YQTJY1OSH7EP3QnZgDDjjPHD4gm/yTPHzU=;
        b=hbTyeKFsQtNHatUL3U0UWV4KsvgEewjyHGXYw3N991dFNJZmEprmIYrysZ7JCxhj8/
         iDYPHB8NTEF+XCewUp9xrcc2VepbH7cZMXXnlqDqdbn+RSfZEnq6U4rA4hr8bbtW5SWW
         V+7Ap6AWX1FuR1cGMqjwJuSE5ghgTT4agHicRKUYdqVj4N/b62DF66R54IUfQxTvd9re
         5Ke94a5MyCUy9elcYNZ8l1ze1j0pNQoU4UYzY4zsASSaYXjKC4tlHQ/4HQlB3qJPqgNN
         76sMem2EbXd2UVuBiNAakBGZQaq+MzxZG9R213otOBFqRYR5F3Zy8rsqL3CSL4r4r0vm
         3gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=eVxK+TSg5YQTJY1OSH7EP3QnZgDDjjPHD4gm/yTPHzU=;
        b=sS3mFvCS0mOcNLv5+ivDeef1008aphpEPSEkj7mnAQOTB253e3OLVerjYyRdycgrqc
         5gHWYgK8l2UhF/UAC4sFcAbvxa4dOwmREz61qlSFnW4FnilpXfYYXoad6PGnAzT5aBFX
         2Svsa+oBr0xxdE3RMzCZ6IpMZWTRDBAiQMQ63mkCS/OcwKCx+ld91YulCs1y+nxHR8M/
         LEi2sNBNUH3iUUMhMwYtGkR2ih6txkEaPyr5s8zbz6rpptfnYs1pGBD5Jycn69liBsA0
         4lvlEs/L8+tXc9+5RAsfqSpbvq4Ot/ivUBqUWALbjvlh0xNc6sI3MdDPySDgzlF88lm0
         DIAA==
X-Gm-Message-State: AOAM5333LcuRunTC5Z//ebIpsJ+Nz4N9258nRUsBpKXnQdWagGzqKsJH
        lDk8ppNlp163j9BTIsMO9b+XYAt8rPMLHw==
X-Google-Smtp-Source: ABdhPJxZduBtpAxcmgdReH9IgPgGEVI70JUOg+aeGqx9rdPJsugw286b2xnH2/xHtm2mnji3N0wcXQ==
X-Received: by 2002:a17:906:3e96:: with SMTP id a22mr17255414ejj.144.1612181422338;
        Mon, 01 Feb 2021 04:10:22 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id y59sm8798510ede.59.2021.02.01.04.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:10:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Vincent Lefevre <vincent@vinc17.net>
Cc:     git@vger.kernel.org
Subject: Re: git fails with a broken pipe when one quits the pager
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210201103429.GT623063@zira.vinc17.org>
Date:   Mon, 01 Feb 2021 13:10:21 +0100
Message-ID: <87im7cng42.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 01 2021, Vincent Lefevre wrote:

> On 2021-01-31 21:49:49 +0100, =C3=AF=C2=BF=C2=BDvar Arnfj=C3=AF=C2=BF=C2=
=BDr=C3=AF=C2=BF=C2=BD Bjarmason wrote:
>> On Sun, Jan 31 2021, Vincent Lefevre wrote:
>> > FYI, I already have the exit status already in my prompt (the above
>> > commands were just for the example). Still, the git behavior is
>> > disturbing.
>> >
>> > Moreover, this doesn't solve the issue when doing something like
>> >
>> >   git log && some_other_command
>>=20
>> What issue? That we're returning an exit code per getting a SIGHUP here
>> is a feature. Consider:
>>=20
>>     git -c core.pager=3D/bin/false log && echo showed you the output
>
> If the pager exists with a non-zero exit status, it is normal to
> return a non-zero exit status. This was not the bug I reported.

Is it normal? Isn't this subject to the same race noted in
https://lore.kernel.org/git/20191115040909.GA21654@sigill.intra.peff.net/

I.e. we start the /bin/false process, then start spewing output to it,
so maybe we'll get a SIGPIPE first because it's not being consumed, or
maybe /bin/false (or whatever else exits with non-zero) will exit first.

Unrelated to that there's at least a bug in wait_for_pager_signal() in
how we log the pager's exit. We just rely on "ret" in
finish_command_in_signal() before calling trace2_child_exit(), but
should probably log -1 there or something and defer.

>> > No! I want to be warned about real SIGPIPEs.
>>=20
>> Not being able to write "git log" output is a real SIGPIPE.
>
> Which is not the case here, because the full output has never been
> requested by the user.

They requested it by running "git log", which e.g. for git.git is ~1
million lines. Then presumably paged down just a few pages and issued
"q" in their pager. At which point we'll fail on the write() in git-log.

The pager's exit status is usually/always 0 in those cases
(e.g. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/more.html)=
. So
we've got the SIGPIPE to indicate the output wasn't fully consumed.

>> Is it because in your mind it's got something to do with the "|" shell
>> piping construct? The SIGPIPE is sent by the kernel, so it's no less
>> expected in cases like:
>>=20
>>     git log && echo foo
>>=20
>> Than:
>>=20
>>     git log | cat
>
> See the difference (without the patch) between
>
> $ git log && echo foo; echo $?
> 141
>
> and
>
> $ git log | head; echo $?
> [...]
> 0

Presumably that first command is one where you exited your pager before
the output wasn't fully consumed, see above.

> [...]
>> Maybe we have users who'd like to work around zsh's "setopt
>> PRINT_EXIT_VALUE" mode (would you want this patch if you could make zsh
>> ignore 141?).
>
> zsh is working as expected, and as I've already said, I ***WANT***
> SIGPIPE to be reported by the shell, as it may indicate a real failure
> in a script. BTW, I even have a script using git that relies on that:
>
> { git rev-list --author "$@[-1]" HEAD &&
>   git rev-list --grep   "$@[-1]" HEAD } | \
>   git "${@[1,-2]:-lv}" --no-walk --stdin
>
> return $((pipestatus[2] ? pipestatus[2] : pipestatus[1]))
>
> Here it is important not to lose any information. No pager is
> involved, the full output is needed. If for some reason, the
> LHS of the pipe fails due to a SIGPIPE but the right hand side
> succeeds, the error will be reported.

Sorry, I really don't see how this is different. I think this goes back
to my "'|' shell piping construct[...]" question in the E-Mail you're
replying to.

in both the "git log &&" case and potentially here you'll get a program
writing to a pipe getting a SIGPIPE, which is then reflected in the exit
code.

> The fact is that with a pager, the SIGPIPE with a pager is normal.
> Thus with a pager, git is reporting a spurious SIGPIPE, and this
> is disturbing.

I don't get what you're trying to say here, sorry.

Maybe this helps. So first, I don't know if your report came out of
reading the recent "set -o pipefail" traffic on-list. As you can see in
[1] I'm not some zealot for PIPEFAIL always being returned no matter
what.

The difference between that though and what you're proposing is there
you have the shell getting an exit code and opting to ignore it, as
opposed to the program itself sweeping it under the rug.

I don't think either that just because you run a pager you're obligated
to ferry down a SIGPIPE if you get it. E.g. mysql and postgresql both
have interactive shells where you can open pagers. I didn't bother to
check, but you can imagine doing a "show tables" or whatever and only
viewing the first page, then quitting in the pager.

If that's part of a long interactive SQL session it would make no sense
for the eventual exit code of mysql(1) or psql(1) to reflect that.

But with git we're (mostly) executing one-shot commands, e.g. with "git
log" you give it some params, and it spews all the output at you, maybe
with the help of a pager.

So then if we fail on the write() I don't see how it doesn't make sense
to return the appropriate exit code for that failure downstream.

1. https://lore.kernel.org/git/20210116153554.12604-12-avarab@gmail.com/

