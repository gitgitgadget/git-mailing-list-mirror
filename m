Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B2AC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3DFE2225E
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0o7Ll8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgJOBUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387959AbgJOBTh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:19:37 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71BDC05BD3C
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:51:36 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id w17so1702654ilg.8
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MrCwDkQQYOOsR00mXHZBLSK5tLz2YyODX65r56gbcH0=;
        b=W0o7Ll8GGgDs4gnQqpPmTLSC1vwBR6b27FUGTPjghh5ARo4fwxgi5XOzvMVledDDD1
         WxnlXdtLOI8xSuK8ofwlNRN0wXeDhtuR+bfVhHOK8xAiIXySQ6k7HWsalfcvVUc6HrQz
         sqHQJXPGS1yQMn6bQZPCHE6YnSw4dhF1Oq/BQ7b8HZkM+B80oThPF171SXY6v9m6kc+Y
         GwwN3bofk7llJv0qKYAeUz2uqpRjWFf68aw9pz0hM3v5TOWYx4ehM+iFWPt2GFV/3Fbx
         72DQkmt5UuT3uSjcXOsUXWS0Ge437W7nmFTaUIR3uPc7rR0WzkQ2M1il2AJ3j+Dz7HOR
         UjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MrCwDkQQYOOsR00mXHZBLSK5tLz2YyODX65r56gbcH0=;
        b=IJNFsRZfNqXRPesqz7et7MMzxVfGxcR8JnF+jD6Rq/PG5SpmnjRaoOs/ZjCsEG1OYU
         xTSWkDiprmHNxgvSacr65O37aYWY6llsJ6EoBFAH3Wxpw42l4QSJHBAaeU3UEi6up6e8
         0VYchzynFcvtBNNZAxdC//d51SPVWFrmyw39ioCIws2nVveZQw9SG7XLf/zwqjFad/4s
         XhsL8ReLVFoS6Uno8zphtD2hb8WUswtyIXLjlseMsD/P6cleW7lDttWUpeGz46l+vUmq
         t9Ykbidptb3INhPtu31AB2yCsufdamIeviYpWWfDhXZWuOsy4RQz6f1t8cx6k4FJcW0b
         BUwA==
X-Gm-Message-State: AOAM533OqKmbZLUYQiQCAM4k/URK4AuC3pigcRbIfGJTj4CuP264S/b2
        +TTpwo0IYUmsVpbA3bNoqO0=
X-Google-Smtp-Source: ABdhPJxfvz7opyTBUBoFlGO58uqfXa0C5Q5+oEBP3Alqr/lBkqijAvhzA2OAN52sA8ND7G2JaNgJ6w==
X-Received: by 2002:a05:6e02:5c7:: with SMTP id l7mr1077950ils.43.1602715896118;
        Wed, 14 Oct 2020 15:51:36 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 128sm952626iow.50.2020.10.14.15.51.35
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2020 15:51:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git diff --submodule=diff and --stat/--dirstat/--name-only
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CA+3n-Tpb4BGM5W3e5vHwqkU-Tnh2gs0_K1ciEcJ25SnYe5PTOw@mail.gmail.com>
Date:   Wed, 14 Oct 2020 18:51:33 -0400
Cc:     Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D853766B-B4D8-46B3-A3BA-68519DCFC7C5@gmail.com>
References: <CA+3n-TrVncSq6kY8sTTw=LiOvLKe=6k1yBE8cmmR3i40CaXR6w@mail.gmail.com> <E3D98950-2EA1-4BFE-8A2D-CE8AEAF5AD39@gmail.com> <CA+3n-Tpb4BGM5W3e5vHwqkU-Tnh2gs0_K1ciEcJ25SnYe5PTOw@mail.gmail.com>
To:     Marc Sune <marcdevel@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marc,

> Le 14 oct. 2020 =C3=A0 10:35, Marc Sune <marcdevel@gmail.com> a =C3=A9cr=
it :
>=20
> Philippe,
>=20
> Missatge de Philippe Blain <levraiphilippeblain@gmail.com> del dia
> dc., 14 d=E2=80=99oct. 2020 a les 15:29:
>>=20
>> Hi Marc,
>>=20
>>> Le 14 oct. 2020 =C3=A0 06:14, Marc Sune <marcdevel@gmail.com> a =
=C3=A9crit :
>>>=20
>>> Hello all,
>>>=20
>>> First, thank you to the community for the great work. Worth saying =
it
>>> from time to time, I think.
>>>=20
>>> I am dealing with a couple of big repositories that use git
>>> submodules. They have nested submodules, and some of them are pretty
>>> huge. I came across:
>>>=20
>>> git diff --submodule=3Ddiff
>>>=20
>>> Which is very handy for creating some tooling, but it's obviously =
slow
>>> - in the order of tens of minutes in my case - for big diffs. I was
>>> only interested in the list files that changed, in this particular
>>> case, but:
>>>=20
>>> git diff --stat --submodule=3Ddiff
>>>=20
>>> doesn't seem to honour `--submodule=3Ddiff` and it doesn't go into =
the
>>> submodule(s) nor recurses, of course. Other options like `--dirstat`
>>> or `--name-only` seem to behave the same way.
>>>=20
>>> I've tried this v2.20.1 and the HEAD of master (d4a392452e) with the
>>> same results. Is this a missing feature, a bug or is it just the
>>> intended behaviour?
>>>=20
>>> Regards
>>> marc
>>=20
>> This would indeed be useful. It's a missing feature, and so intended =
behaviour
>> for the moment, I would say. It was discussed recently on the list =
[1] :
>>=20
>>=20
>> [1] =
https://lore.kernel.org/git/20200924063829.GA1851751@coredump.intra.peff.n=
et/t/#u
>=20
> Thank you for the pointer and the clarification.
>=20
> I am not sure extending `git diff` options (only) under
> `--submodule=3D`, e.g. `--submodule=3Dstat` is the way to go. It seems
> redundant to me.
>=20
> I am wondering if it would make sense to have basic options of git
> commands, e.g. `git diff --stat`, be honoured for submodules too, and
> just control whether git commands should get in the submodule(s) or
> not, and perhaps the depth of the recursion (optionally).

Did you try `git submodule foreach` ? If you are scripting, you could =
do:

    git diff --stat && git submodule foreach [--recursive] git diff =
--stat

Although here the recursion is an all-or-nothing business.

> For instance, I don't fully get the use-case(s) in which parts of the
> output are --stat (supermodule) and submodules show something
> different:
>=20
> git diff --stat --submodule=3Ddiff
> git diff --stat --submodule=3Dlog
>=20
> Specially for log, this sounds to me like it should be under `git
> log`, with the appropriate options.

I think 'log' is useful; it's more descriptive then having just a hash,
which is the default...

> Perhaps you can shed some light on
> the use-cases these combinations support.
>=20
> I would think something like:
>=20
> git diff --stat --submodule-follow
> git diff --stat --submodule-follow-depth=3D4
>=20
> git diff --names-only --submodule-follow
> git diff --dirstat --submodule-follow
> and for other commands (some sort of header line should be printed to
> note the history is under the submodule X):
>=20
> git log --submodule-follow
> git log --submodule-follow-depth=3D4
>=20
> and of course allowing `--` modifier:
>=20
> git log --submodule-follow -- libs/library1
>=20
> would be easier to use.

I'm not sure of the use case for these... The history
of the submodule project can be seen with `git -C path/to/submodule log`=20=

(or just `cd` there and `git log`), and the history of the gitlink in =
the superproject
with `git log -- path/to/submodule`...=20

It does not really make sense to interleave the history of the =
superproject and
the submodule in the same output, in my opinion at least.

> Let me know if any of this resonates, and if some patches along these
> lines would be welcomed

I can't really answer that, I'm just a small time contributor :)

> (might ask some help offlist).

You should ask on the list, on the mentoring list, or on IRC (see [1]).

[1] https://git-scm.com/docs/MyFirstContribution#getting-help

Cheers,
Philippe.

