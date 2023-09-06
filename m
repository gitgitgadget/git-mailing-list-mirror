Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E40EB8FA5
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 04:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjIFEV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 00:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIFEV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 00:21:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C09FB2
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 21:21:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991c786369cso500484466b.1
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 21:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1693974114; x=1694578914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlfgGxPRjBRTEv3T2hB6Bh/cthv8PSP/fntA6ZEn82Q=;
        b=D/DkDviJS0Hb2aHVGkFO5HL50ZoJYeZM7sG24HB8EGNyZIWIF61ryL9ohsqDk5J5/r
         CzTMkNZR2E/ocQ2igb03mwhaXWpIsokbXTuYGrpjfm/1hceTsfqvrf2bN0XPn6jH4hXz
         ZKLWLJ51Lv0ECwg3aVaZqdzOi2uv01oThdFHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693974114; x=1694578914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlfgGxPRjBRTEv3T2hB6Bh/cthv8PSP/fntA6ZEn82Q=;
        b=hoqOlIbwf3ohx3uJp0ifpASrpCscEkMfeRzml21spA53bZXLugSbJIzO8Ees5uk9bf
         HdIB4wbpAQwg0+YEls9JEsMQDa0j7I4VUMXd5XFsVbv7M2dIssELX4EeKLV4XzTsITKr
         MSAiB7jfSAK93BK167YA1yzUk8aKUV24J/AZYqM2eOox2VqyMlSUGE/MFb91o1rIeioI
         V18VtuhiPD/pA+oZg1wDaPbM3XYRTUfvgIGZYySTBBYekGI+eQ70CEm7wpeKB4gxmGT+
         bf0KAIzZdBrQU/iSQlmg2JzbkKxHWW/hrZT1R88Qwa7cO8NFw8tPe6TGgKnpbi3gM+6V
         FMxQ==
X-Gm-Message-State: AOJu0YzHTUCULlC+X5tgUhC12X8Mi1M1mGFMpvnsc3KxQzUptujLA4Vb
        mrY1XFtcYdyTGwVIdjBANKHdIxpA7eu68oDCp6JE9w==
X-Google-Smtp-Source: AGHT+IF4F/VHVdf2Pd9PMT1Q7i5wse8vKuwxaqSZiR+tNjabfOhRhqq+oURrt4nbMqYl724hgQGc5Z4wU3MycFtHOeg=
X-Received: by 2002:a17:906:70d6:b0:9a4:88af:b82 with SMTP id
 g22-20020a17090670d600b009a488af0b82mr1079963ejk.77.1693974113817; Tue, 05
 Sep 2023 21:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogUxq59zj+=7UDiURYbydAwvymOqhEWaheT9fkU8HaP4Q@mail.gmail.com>
 <xmqqilp1znn1.fsf@gitster.g> <nycvar.QRO.7.76.6.2206182358350.349@tvgsbejvaqbjf.bet>
 <xmqqczf5lgk3.fsf@gitster.g> <CAPMMpojUrfSmpgWVh3TTn_uamPCcyHRQf2R3APSpEjsqujNXvA@mail.gmail.com>
 <xmqqpm2wqn6h.fsf@gitster.g>
In-Reply-To: <xmqqpm2wqn6h.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 6 Sep 2023 06:21:45 +0200
Message-ID: <CAPMMpoh7=riapMO-91e81MrK-uR+sm7ttgCu8433dNNQU0ZsQw@mail.gmail.com>
Subject: Re: Plumbing for mapping from a remote tracking ref to the remote ref?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2023 at 12:18=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > ...
> > Would something like the following be mutually agreeable?
> >
> >        $ git remote origin map-ref
> > refs/remotes/my-favorite-remotes/origin/someref
> >       refs/heads/someref
>
> With strainge line wrapping, I cannot quite tell what is the input
> and what is the output, but if you meant that the part up to the
> long-ish refname in the refs/remotes is the command line, and map-ref
> is the new subcommand name in the "git remote" command, i.e.
>
>     $ git remote map-ref origin refs/remotes/my-favorite-remotes/origin/s=
omeref
>
> is the input, to which the output
>
>     refs/heads/someref
>
> is given,

My apologies: in addition to automatic line wrapping, I also got the
arg order wrong.

Yes, this is what I meant.

> I am not sure what its value is.  First of all, the user
> is giving a ref in a hierarchy that is usually used for the remote
> whose name is "my-favorite-remotes".  What made this user _know_
> that the remote reference belongs to "origin"?

Understanding that it's dangerous to make assumptions about what's
typical, I am positing that the user typically knows what remote
they're working with / looking for stuff in. I would guess that the
set of repos, in the world, that have multiple remotes with different
ref path structures, mapped onto the same remote tracking ref
namespace, is much smaller than the set of repos that have some set of
refs mapped differently to the standard
"refs/heads/*:refs/remotes/originname/*" mapping. My "selfish" intent
was to address the latter, without worrying much about the former.

> Isn't that part of
> what the user may want to _find_ _out_, instead of required to give
> as input?

There's certainly value in enabling them to do so!

>
> So, no, I do not think it is agreeable at least not from this end,
> but I may be misunderstanding what you meant to present as your
> design.

No misunderstanding. I was unfortunately more concerned with "fitting
in" with other "git remote" subcommands (which take a remote name)
than making the most useful functionality.

>
> I would understand if it were more like
>
>     $ git remote refmap refs/remotes/somepath/{branch-A,branch-B}
>     origin:refs/heads/branch-A refs/remotes/somepath/branch-A
>     origin:refs/heads/branch-B refs/remotes/somepath/branch-B
>

This is a much better proposal, from my perspective!

> that is,
>
>  (1) the new subcommand (refmap) takes one or more refs from the
>      command line; they typically are in the refs/remotes hiearchy
>      and each asks which remote's which ref needs to be fetched to
>      update the ref.  Note that the user does *not* need to know
>      which remote the refs will be updated from.
>
>  (2) the subcommand goes through the "remote.*.fetch" configuration
>      items (and its older equivalents in .git/remotes, whose support
>      should come free if you used remote.c API properly) to find
>      what ref from what remote is fetched to update the refs given
>      from the command line.
>
>  (3) the output is "<remote>:<ref-at-remote> <our-remote-tracking-branch>=
"
>      one line at a time.
>
> Note that this format allows the "two remotes can both update the
> same remote tracking branches we have" arrangement.
>
