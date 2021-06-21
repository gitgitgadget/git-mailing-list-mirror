Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BD5C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DA36108E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhFURW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhFURWz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:22:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B19C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 10:20:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b3so10288560wrm.6
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pIsiFkZkOFt8i5nNfvq7biCrXhb62cfzCV2rn6DQx6U=;
        b=ngnVMbNKAmRLnzL90rCcUI6C8rbJ1gLvLORnbsBcgFHN7zEmAS4/Dm3H2ASzjUtY87
         gRvcuNTGd5V5wcaw23php0MjVJWcOohJgQNO9wmWuE6TZDH1AmwHcxZsTfEbo0fGaDar
         PPptSrVtAq8PK2S9hHltSQMmluEDXllR5he7lgx6x62qVNG6+qVdqAjD8jwFOWyxZJuk
         Fg3AruucpVUJNyA/mfLv2Q4vscQCV3HyNR1u0PUzemLgFvSZmIgrNWuTP41IcDRmNf23
         KBe4B7+9KITJP+Ty6RHWOHyAJSgo83/mf4luYkp7clvFBjpRvSxb2M2kv0eZLIkKl0bj
         KrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pIsiFkZkOFt8i5nNfvq7biCrXhb62cfzCV2rn6DQx6U=;
        b=uG62UwBcb28Jm3ouDbr3XEdu241gLI9oR4lE9slfTS2/LfdxPFYNMWLn9icjhSyhgT
         TbWmAD7+9MNgg9zLblRXRCEjauYhAStEQvIiLCEXghONAt6iGk9J07Su8UXLpRC/ygPU
         WbLUgeV0/4I+tC6bRShtEG2NjywG+KBwlAikpZsxftJefwfqTHe3Khpbtk2VBFm67z2e
         BFRZ/ygUJVaSkeGvt53BBp47eLVH0WTUj3DOI1yA6EaBwfgQAw4X6ZCzpuoSDj0a1HaL
         2iWB3Q4GKPvoQu6bOYlUdMbVYDebH6TrcszTl51RRhCM2aRCA0vCkxN4GI0kUL2iqry2
         3qvg==
X-Gm-Message-State: AOAM531SrWsttnxlo+Jlp3Cyrr71nj/wJEGxiUxiotIIRhK4NWkyHEBw
        qRzbMpqxOtGUXlQVzy6QnD4vWfblkxhU6uBpXFw=
X-Google-Smtp-Source: ABdhPJwDBw4KwzetfwuRSUzduVUlIdu/j0xMwTkgsGwBxzXtPFRkr3g8CtIb0uUWd6yJ6Yl6NkEM11MELzqvY2mBrvU=
X-Received: by 2002:a05:6000:1084:: with SMTP id y4mr28435253wrw.173.1624296039752;
 Mon, 21 Jun 2021 10:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAKuVd4DfvEhXDUvxaU_jjNk8JSZANM8jpSEOxi1cbSAp23ohjg@mail.gmail.com>
 <87czsg429h.fsf@evledraar.gmail.com>
In-Reply-To: <87czsg429h.fsf@evledraar.gmail.com>
From:   Tim Hutt <tdhutt@gmail.com>
Date:   Mon, 21 Jun 2021 18:20:28 +0100
Message-ID: <CAKuVd4Bfykm0xe0P5FMy3W8HuECJHqP-RGo+T_VK4hn43sgEpg@mail.gmail.com>
Subject: Re: Bug: branch checkout is detached if the case doesn't match
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah of course!

> git pack-refs --all

Yeah that "fixes" things so you get `fatal: invalid reference: MASTER`.

I guess `git checkout` checks whether `MASTER` exists (yes, according
to MacOS), but git log checks whether the current branch (`MASTER`)
matches `master` (it doesn't).

Very unfortunate, but I guess it's not worth fixing.

Cheers,

Tim

On Sun, 20 Jun 2021 at 23:09, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
>
> On Sun, Jun 20 2021, Tim Hutt wrote:
>
> > If you try to switch to a branch (e.g. `master`), but get the case wron=
g, e.g:
> >
> >     git switch MASTER
> >     git checkout MASTER
> >     git switch Master
> >     git checkout Master
> >
> > etc. then it autocorrects the case (bad idea but ok), but it also
> > enables the `--detach` flag! In other words
> >
> >     git switch Master
> >
> > acts like
> >
> >     git switch -d master
> >
> > Very unexpected!
>
> This behavior isn't intentionaly, but ultimately isn't with Git, but
> with your running of Git on a filesystem that doesn't respect POSIX
> semantics.
>
> The default FS on OSX is case insensitive, we store the "master"
> reference (unpacked) under that name on the FS, so this is emergent
> behavior. Can you reproduce this after a:
>
>     git pack-refs --all
>
> ?
>
> Even after that we'll have a .git/HEAD, and I know on OSX e.g. "git log
> head...<branch>" unintentionally resolved to "HEAD" too at some point
> (probably still).
>
> There's various workarounds in git's code to deal with funny behavior on
> OSX, but it's hard to catch them all as it means having to second-guess
> standard library calls. I think you're best off creating a
> case-sensitive partition on your computer and using git there if you
> want to avoid these cases entirely.
>
> > [System Info]
> > git version:
> > git version 2.32.0
> > cpu: x86_64
> > no commit associated with this build
> > sizeof-long: 8
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > uname: Darwin 20.4.0 Darwin Kernel Version 20.4.0: Fri Mar  5 01:14:14
> > PST 2021; root:xnu-7195.101.1~3/RELEASE_X86_64 x86_64
> > compiler info: clang: 12.0.5 (clang-1205.0.22.9)
> > libc info: no libc information available
> > $SHELL (typically, interactive shell): /bin/zsh
> >
> > [Enabled Hooks]
>
