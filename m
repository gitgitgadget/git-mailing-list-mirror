Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09142C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 00:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiLFAMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 19:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiLFAMs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 19:12:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7667B632B
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 16:12:44 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t17so2417076eju.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 16:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tZWGAjiNxxVT8n3HxRcmNuZ3wr+u/FVjCI/25uUCe3U=;
        b=Gw/Y24rO9a4Z+Zi4SsN/7tb0qacpJlJodxIIPmvgOU6R3SrimRH1gFx2CdzqtJXSPj
         /cA2wBRNRwwEcWT3m1j+jWtjXV6CSCGTqKkyV/2YTCi5eyLaor6PiEln7jVep1zk2Aur
         PKRckTZy359MxBmKiXZCwX7W3uRPKbhKt3ZmOtipFevBa38EDGIkN3wECbvCopFRtXhw
         VSuTN3SyYDnfBa9gUjgdCIwbR2Nxlxyt9/mxzNDIVMnabVBRjQyz9VRVh1usDjyUzWE1
         4EiJe3l55ar/SJhfNa9HvHZkbKMTqVWw7jrN46+Ai5zN0W4l399THLRNFCDseM86/g4i
         qFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZWGAjiNxxVT8n3HxRcmNuZ3wr+u/FVjCI/25uUCe3U=;
        b=RUj/0wNwdWmnOk7scpkR/cIg0NELe5oai+pxLR8Nyeq051EGWUTn6FCvnuEAm5yA8S
         y3ALI67Pl92iAsjDkx/OnTuMwZ9aOW9xaW/V3ZXHYsYtKVb+zWRd7/IZngZqfmLImexr
         kciBafeIyBt62o59escmdLb+rbUhnodFLOBMLcELy5FpJrtJLmOOx+3bjVb6onBamidb
         iWN2VMJ0eZLc2DN1Cb1FUR15AmEddJvURk4Nioa1P2H0ZA7Yfo/uxeNk5G5WnsBTDtnU
         FyJHWkIRARKzFGY3EKnXoYek9RgPEGVEePIinH8Z4tsxQyd0VaqoQa9nKP6x6qoT+gKS
         pcaw==
X-Gm-Message-State: ANoB5pmiSzOygmses/XHSqGovbMe97mmfP4wkleIiVLNqbD3cfXyY2NI
        MetpmEBfXG2ZChQiac8yA0M=
X-Google-Smtp-Source: AA0mqf7tjmaeG+s++CxMKTP3XIiOQlg5y+LScc/yvFL8Qh5spNguHqaEqkSQMEAiEpg1bAV2No40lg==
X-Received: by 2002:a17:906:1682:b0:78d:6ba1:74dd with SMTP id s2-20020a170906168200b0078d6ba174ddmr73066418ejd.119.1670285562777;
        Mon, 05 Dec 2022 16:12:42 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id iy17-20020a170907819100b007c03fa39c33sm6692192ejc.71.2022.12.05.16.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:12:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2LZh-003Lnn-2j;
        Tue, 06 Dec 2022 01:12:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Date:   Tue, 06 Dec 2022 00:46:50 +0100
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
 <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
 <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
 <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
 <Y45/8WnuUnP9gOMo@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y45/8WnuUnP9gOMo@nand.local>
Message-ID: <221206.864ju9e6fa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 05 2022, Taylor Blau wrote:

> On Sat, Dec 03, 2022 at 02:41:04AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> > I have similar feelings to you here. Back when cmake support was
>> > introduced, I explicitly wanted it to be something for people who cared
>> > about it, but that wouldn't bother people who didn't use it:
>> >
>> >   https://lore.kernel.org/git/20200427200852.GC1728884@coredump.intra.=
peff.net/
>> >
>> > I stand by that sentiment, but it seems to have crept up as a required
>> > thing to deal with, and that is mostly because of CI. Using cmake in CI
>> > is good for telling developers when a change they make has broken cmak=
e.
>> > But it also makes cmake their problem, and not the folks interested in
>> > cmake.
>>
>> That's a bit of a pain, but I don't think the main problem is its
>> integration with CI. It's that there doesn't really seem to be an
>> interest in its active maintenance & review from its supposed main
>> target audience.
>>
>> Case in point this "ab/cmake-nix-and-ci" topic: It's been queued for
>> around 2 months now.
>
> I think CI *is* the problem here. The CMake bits are basically a black
> box to me (and I suspect a large number of other contributors, too). But
> when it breaks, the only reason we as a project end up noticing it is
> because it has fallout in CI.
>
> I would not be sad to make CI failures that are derived from CMake
> "soft" failures in the sense that they don't make the build red. But I
> think it's masking over a couple of bigger issues:
>
>   - Why do we "support" two build systems in CI if one is supposed to
>     only be here for those that care about it? IOW, even if we say that
>     CMake support is nominally an opt-in thing, in reality it isn't
>     because of the dependency via CI.

I'm just trying to point out that that wouldn't be such a big deal if
the cmake parts were being actively maintained.

>   - Why do we only *notice* these failures in CI? I found during my time
>     as interim-maintainer the task of tracking down CI failures to quite
>     frustrating. It is often quite difficult to reproduce CI failures
>     locally (especially with exotic build and test configurations[^1]).
>
> It would be nice to be able to more easily see these failures locally
> before they hit CI. E.g., is it possible that I would work on a feature
> which somehow breaks the CMake build, and fail to notice it if I use
> "make" locally?

Yes, some things will just work. E.g. it regex-parses out the Makefile
to pick up the list of built-ins, so when we add a new one we'd usually
not need to patch the cmake bits. Although that regex parsing is its own
problem for some Makefile changes.

To be fair the cases where we've needed to keep it in lockstep since it
was added aren't that many. If you skim this and look for commits that
alter both (or cmake quickly after the Makefile) you can spot them:

      git log --oneline --no-merges --full-diff --stat 1c966423263..origin/=
master -- contrib/buildsystems/CMakeLists.txt -- Makefile=20

> Personally, I would not be sad to see CMake removed from the tree
> entirely because it has not seen enough maintenance and seems to be
> quite a headache.
>
> Thanks,
> Taylor
>
> [^1]: Not to mention non-Linux failures, though I think that is sort of
>   par for the course if you're not using one of those platforms
>   yourself.

I wouldn't mind either to see it gone, but when that was last discussed
some people chimed in to say that it really made things easier on
Windows, and I'm inclined to believe them.

So I'm not trying to take their toys away, just changing it so that if
you run into these cmake issues it'll be trivial to debug them, as
you'll be able to test & run it outside of Windows.

Now, I'm about to send out a v6 of it, which should address the last
remaining Windows/VS issues.

I'm not testing directly there, as I don't have such an installation, so
it's possible I'm wrong. Maybe it works in CI, but still breaks for some
reason when driven from VS.

But I think if we can't get anyone who's running Windows+VS to be
interested enough in this to test it the better thing is to just take
this series.

Maybe it breaks some subtle aspect of the VS integration, but then
that'll be easier to fix on top than recovering from a "git rm" of it.
