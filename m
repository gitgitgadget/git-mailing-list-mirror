Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84750C433F5
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 01:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiCZBJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 21:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCZBJO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 21:09:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347F914A6C6
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 18:07:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id pv16so18487916ejb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 18:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=w85WY7L1hibdu3QBeMxu5A2XYhKpzFUvKuPZXREDaHY=;
        b=U247HfGE2LZoth/kWNkyVb69/DPH5h26DFtb1e7kWcFkbpmxQd7l2igHERv4IqTqWC
         ipDWmT6/r/wNBBnPys+qRetY1vBFaH3UZTZcPuGCgkdqZRpXG+f7MaiRC2kkXr45WuM/
         gqQkemCt63P+K4k12RvDnY45eTqIYQxSz+xzXBBHVveMIfu4kAnpYKmYz/jr5hQtnxOs
         Wk4SastSDdg2icSAd1n1OjKdbUsJBCxEp028kh5ikBUtlmVuvOEMNYe91rSJMIbomqti
         EIPF/SJXve4WDhcjA5YUGfrUq92bVBlO1AORB9Pa61G0OvQqeu/i6zxxkmG2ww2lVCRy
         LRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=w85WY7L1hibdu3QBeMxu5A2XYhKpzFUvKuPZXREDaHY=;
        b=lagA5gN3MV+8StBVHctuUWxnhjaLWBBN4k+LKhCjOihCD6V1BSjI/7/k7jdPm/XQ5f
         iOF43s0lwjvDUcQkwwY8ThlnnC66EiF3HF5RB4zZCS30zzHJy6uLc/R6UKjiy/LHI6Or
         1yILAxJQxFwmmXX3FzEOYmiFoOAb2DfHWxyhsZt+o/iYr+L1NrRMfCDH4k1O3CprEvLC
         IEjpnEdCQb+t9l4Y6tGs6cysA5oG+2nRZaAtuk/2wuM/c/VwzueLut6q+5E+TPdaiEHN
         dMlme6IagGJtTu3PyUhQS94DXiZO0t0QNQRoq+UVV9iFE59h80rWVGE1WTLvQp1XJWjY
         r3kw==
X-Gm-Message-State: AOAM531EMoDLPEXPJSaCOs8NvK5Ocb0F6x+lkoLDcawc2f5iiLpt5znL
        TfpwWf/gz6bMz7zGiGlkt20=
X-Google-Smtp-Source: ABdhPJzGBaYG9Dw0YMo9e/D3APcDCMsl86p2oAh3nx7u2ROwdBSqk+AN2hA9Dqu9FgdCexf7WVO7Uw==
X-Received: by 2002:a17:906:dc8d:b0:6db:572b:df24 with SMTP id cs13-20020a170906dc8d00b006db572bdf24mr14975198ejc.193.1648256857598;
        Fri, 25 Mar 2022 18:07:37 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f3-20020a1709067f8300b006ce051bf215sm2888357ejr.192.2022.03.25.18.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 18:07:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXuu0-002KoV-D6;
        Sat, 26 Mar 2022 02:07:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
Date:   Sat, 26 Mar 2022 01:59:49 +0100
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
 <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <320b3dde-a84e-0074-bed8-57061293b2b0@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <320b3dde-a84e-0074-bed8-57061293b2b0@github.com>
Message-ID: <220326.861qypldwn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 25 2022, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> A re-roll of my improvements my series to simplify the CI setup a lot
>> (see diffstat), much of it was dealing with constraints that went away
>> with Travis et al. CI for this series (OSX runners failing for
>> unrelated reasons):
>>=20
>>     https://github.com/avar/git/actions/runs/2040223909
>>=20
>> For a much more detailed summary of how the output looks before/after
>> see v1[].
>>=20
>> This series heavily conflicts with Johannes's
>> js/ci-github-workflow-markup in "seen", but in the v1 I suggested
>> basing that series on top of this one, because it can benefit a lot
>> from these simplifications.
>>=20
>> I'll reply to this series with a proposed rebasing of that series on
>> top of this one, which allows for removing almost all of its changes
>> to "ci/" with no harm to its end-goals, i.e. the splitting up of
>> "make" and "make test" output is something it'll get for free from
>> this series.
>>=20
>> Junio: Since that series has been stalled on still-outstanding
>> performance issues for a couple of months I was hoping we could queue
>> this instead, and perhaps in addition if Johannes approves of the
>> proposed re-roll on top of his.
>>=20
>> There's some forward progress on the performance issues (this[2] reply
>> of Victoria Dye's from yesterday), but fully resolving those will
>> probably take a bit...
>>=20
>> Whereas even though this one is relatively large I don't think there's
>> anything controversial here. The one concern that's been raised has
>> been Johannes's objection to removing some of the dead Azure code
>> (which was needed to move forward here). I asked how he'd prefer to
>> move forward with that in [3], but there hasn't been a reply to that
>> in >1 month.
>>=20
>
> While the largeness of a series shouldn't necessarily block it, the lack =
of
> overarching structure or purpose in this one makes it really difficult for
> me to review with much confidence (I can't speak for everyone, but it may=
 be
> one of the reasons for the general lack of feedback). If you believe all =
of
> these patches as thematically-related enough to warrant being in a single
> series, then it would help a lot if you could:
>
> 1. Clearly describe the purpose of the series (yes they're all CI
>    improvements, but *why* these particular improvements, and why do they
>    all need to go together?)=20
> 2. Outline the "path" these commits take to accomplishing that purpose ("=
The
>    first 3 commits do X because Y. Then, the next 4 commits do A because =
B."
>    etc. or whatever format fits your writing style, as long as the
>    information is there).
> 3. Reorganize commits as necessary to keep the above outline from jumping
>    back and forth between topics.=20

The v1 summary described it about as clearly as I was able to:
https://lore.kernel.org/git/cover-00.25-00000000000-20220221T143936Z-avarab=
@gmail.com/

> Personally, I think this could (should?) be split into at least two serie=
s:
> one that breaks up 'run-build-and-tests.sh' (and is more directly relevant
> to dscho's series), and one that does the cleanup/flag change/other work.
> The two appear to be independent, and the resulting two series would be a
> much more manageable 10-15 commits each.=20

To rephrase that a bit, every commit here passes CI and is atomic, so it
could be split up into 25 parts (at least).

But it's really not doing different things, it's a single-topic series:
It's changing CI "step" targets that are shellscripts that do N things
to instead be single command invocations at the "step" level, driven by
the CI recipe itself.

To do that we need to pass state that we previously re-setup for every
"step" via $GITHUB_ENV, whose state we then helpfully show (this is just
a standard GitHub CI feature) in a drop-down at the start of every
"step".

So yes, it could be split up in the sense that we could get partway
there and continue with the rest some other time, but I really think the
UX experience is *much better* if it's not a partial conversion.

I.e. at the tip of this series you can reliably look at that $GITHUB_ENV
view to see what the full and relevant environment was for that "make",
"make test" or whatever.

If we just do that partially you might get that for "make" if it failed,
but if your tests failed we'd have a failure in the proverbial
ci/load-lib.sh-do-setup-stuff-and-run-make-test-at-some-point.sh.

Which I think makes the UX much less useful, i.e. you really want to
*always* find this information in the same place.
