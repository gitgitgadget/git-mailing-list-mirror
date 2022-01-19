Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B812C433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 01:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbiASBL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 20:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiASBL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 20:11:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6512C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 17:11:58 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a18so3396667edj.7
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 17:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YxwPv8WP3lNXMGbtTpcX2gf+luAy7cJnOTrJlxGQ314=;
        b=j2km9Y24USZuXNc+JohHMMVOLxmBPqfwg5G8823ErLt0V19bNtz0KOM+UpD+jyqAqm
         WaFRIrLUO/GJy1/s4waSakgd0OnoiYKOURZka2g181UbSSaNWAhSpPEBzQyeqUJRBvP8
         b6FGlfO2/guDh1glvAn0qk02gw0us5PTu/OQMH4+XUPQg9v1zO7GesNdxl6cO6xpWxF2
         jz8h2tbOtVlK+r8ANtUsFIs3IJWatVUzNF0kpzTjCH5zpX1nWrOnMzo3s+FNmxS3Gx/L
         7yQpvhZGVUNbobehnhYe0gnJgK1k+acIeK+3ffX6Uyoi/pkYCVBxkRSidI2cDhc+o3Yl
         28hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YxwPv8WP3lNXMGbtTpcX2gf+luAy7cJnOTrJlxGQ314=;
        b=jXAv6QowrNBkAJEyNRzPyhpM7TTrI6NeWU1gUBa5wcz2MbMrBpPjtg1oPYx+c25lv7
         edwxddB4sTTmjLc+gvuYXo6A/KJYEnVp3lSc1ZElurNkTIH2Q2OmJw/JHBFV4IXYFqpg
         uJW++4Qu4YrAPBzkBrypFzT6jmncCIg+WgSwOzPCBFJ/wgGgVMf3Sj1vvqv7HywvSaOb
         w8MLKACz/jY7BdjPbBtkEJReD37G46vqo8vmcwEKUXisXt8NM1eY8F2idKyKgNPPAt71
         bl6opFXD+aEpqA8B5+CefDgvzor3rpz/2+rOL6KzxA/1jz7JehTAD9cN+am+fXuR7Hsh
         WwSQ==
X-Gm-Message-State: AOAM530WrQPWLhRUUuP16BEr4xhbPnCRjqY/0pdMTdkSqOPDecyIiK3X
        KkAMyiEsJxNjY45pvOFv0cE=
X-Google-Smtp-Source: ABdhPJwWouOdXUZTJR7glpvrJwwpITByQgiFqPuiyRkh4Oo8nyZXOXTB/O86OYdyRz4hXLCllxa57g==
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr13186568eda.179.1642554716768;
        Tue, 18 Jan 2022 17:11:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 9sm5783728ejt.181.2022.01.18.17.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 17:11:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9zVz-001hs2-I1;
        Wed, 19 Jan 2022 02:11:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
Date:   Wed, 19 Jan 2022 02:05:25 +0100
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
        <xmqqilumayfh.fsf@gitster.g> <xmqqzgny7xo7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
        <220118.86iluhoyio.gmgdl@evledraar.gmail.com>
        <xmqqh7a0ssuh.fsf@gitster.g>
        <220119.86o848o8ao.gmgdl@evledraar.gmail.com>
        <xmqq7dawpmfq.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq7dawpmfq.fsf@gitster.g>
Message-ID: <220119.86fspko7fo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Whereas the C11 warning is "just" recent FreeBSD && DEVELOPER=3D1.
>>
>> So I assumed if you weren't interested in the former before the final
>> you probably wouldn't be in the latter, but wanted to provide a more
>> narrow fix in case you were.
>
> If we muck with the inclusion of libgen.h, it then becomes a problem
> for everybody who builds on FreeBSD, not just the developer builds.
> IOW, it is not even narrower to begin with.  Giving the same
> potential breakage to everybody will make it easier to diagnose it,
> but because I do not trust -std=3Dgnu99 on today's FreeBSD, I think it
> is a problem we do not even have to solve.

The patch I submitted could trivially have an additional "#ifdef
DEVELOPER" or equivalent, which would narrow it down even further.

The reason it doesn't is because we provide -std=3Dgnu99 in
config.mak.dev, but that doesn't mean that we don't have to deal with
e.g. a user-supplied -std=3Dgnu99.

Except of course if we declare that we're not going to generally support
such a thing, and you should only provide such flags via
DEVELOPER/DEVOPTS, not manually in CFLAGS, which is fair enough.

>> I.e. the point of doing it is to avoid the one-time pain of anyone
>> building new releases of git on $OLD_OS/$OLD_DISTRO not having to run
>> into the compilation error that's fixed with NO_UNCOMPRESS2=3DY.
>> ...
>> If we then get this into v2.36.0 there'll be someone somewhere that
>> benefits, but I'd think the ship has sailed for most of those who'd
>> avoid the needless flag twiddling (git-packagers@ et al).
>
> I actually think it is a good thing.  It is what they brought onto
> themselves.  They can follow David's example next time.

Do you mean David Aguilar's addition of "NO_UNCOMPRESS2 =3D YesPlease" in
[1]? Isn't that mutually exclusive with pursuing my change to
auto-detect it[2] instead?

As noted I'm a bit "meh" on my own patch if it's not in the release. I'm
just trying to see where you stand, since you seemed to want a re-roll
of it post-release....

1. https://lore.kernel.org/git/20220116020520.26895-1-davvid@gmail.com/
2. https://lore.kernel.org/git/patch-1.1-9cea01a1395-20220117T170457Z-avara=
b@gmail.com/
