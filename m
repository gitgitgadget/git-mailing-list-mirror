Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8A1C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 02:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhLKCVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 21:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLKCVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 21:21:25 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3980DC061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:17:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y12so34495122eda.12
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=17AmNep75OKpL9AWeix/sZep1JS9cvWY1nfCpuka0x0=;
        b=odH8abbW6Lboki8c1FqOz2GaFSKq6sfD+gQzE2zUeSHV57aOGhZmtmrtykTtMZLtKP
         8zLOEA9/Q3Wi+0auQZ5/SCUbxeld+qlkUAcLylJ2nAtBAzjuuBhgQN95dQbvWD9tHBQS
         Qo3lkym4F3AFNBQuQ5x9L3EwRLqZqSyTRD9bTNzd5+WJG8zHMMNDlOFmmahWGROOcZeQ
         1ZiMGtYVyCTPqyab/MwDyIrI1AVthqnW/odLVIbPXD4UZD3UFzWGkeUY2h9vl1LFq+gE
         KvwAYd2bgOqEYwerncZdpkd0I6nTTO0dNGhEEn9AY2L49VUQSHLiKjWulG00aVnvfanK
         9yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=17AmNep75OKpL9AWeix/sZep1JS9cvWY1nfCpuka0x0=;
        b=0r5E7fusQZVg6QcaK14x/eql+phC7QZiSmQT6fDJ28h6knYz32hV4ltLRbvYUKeOxQ
         GHz94DX6g+Cw+4+a+u8Wd6upVF7j6v/99D07BwbeDnOvBnflx83SD3in8RRb02UPSTJr
         rNHXjXLPETKeeoGuFAVe3khY90ikqONP2erxDc8nj6nRVP0+8sc5dNHt6AbbSbp6t2Wp
         iDl1bGF/u8p8cirTFdboRZd9/ApWB66MgjiluvJX6PHBsAaCZJ6hajQOWRrjnEpctHws
         kI+hN5qjNE70x55A/xGfFwBl0vq7k+/34jlu7PzS4THhbNd4N2OlehcXySk/tHIy+/rY
         B5GA==
X-Gm-Message-State: AOAM533WUGMg8bCCcPaSjsEeLDnud1M6nABXBQNOpPCTAnX5BFUGpd27
        ds05QhwtR5U93xvI6F8JIs4=
X-Google-Smtp-Source: ABdhPJyxIACGnN/FfyeEUqNBQfUBMuA9YywSKXwz+3Dym8Hu41fxI5rOHzqOWEIbi9E9Yn0oaG2Pyg==
X-Received: by 2002:a17:906:2c16:: with SMTP id e22mr28607459ejh.501.1639189067583;
        Fri, 10 Dec 2021 18:17:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m16sm2269603edd.61.2021.12.10.18.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:17:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvrxK-000Qqc-Ci;
        Sat, 11 Dec 2021 03:17:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
Date:   Sat, 11 Dec 2021 02:07:32 +0100
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
        <xmqq8rwuv3i2.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2112110044010.90@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2112110044010.90@tvgsbejvaqbjf.bet>
Message-ID: <211211.86mtl7c2b9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 11 2021, Johannes Schindelin wrote:

> Hi Junio,
> [...]
> We do have a very different understanding of "fairly easily" in that case.
> Three iterations, and three weeks time spent on implementing what you
> suggest, only to see broken by the merge of the `ab/ci-updates` patch
> series, suggesting a fixup for the incorrect merge, seeing that fixup
> rejected, and then more discussing, all of that does not strike me as
> "fairly easily". It strikes me as "a lot of time and effort was spent,
> mostly stepping on toes".

I sent you a working path to a fixup in [1] on the 23rd of November
where we won't go from running zero tests in compile-only to running
just the scalar test.

Junio replied[2] ("the above" referring to [1]):

    I think the above shows that it is a bug in the topic itself,

You didn't reply further in that fixup thread, and then your v9 re-roll
a week later still had the same issue[3] discussed therein. I again
pointed that out[4]:

    Is it intentional that the previously compile-only "pedantic" job is now
    running the scalar tests?

You didn't reply, but in your v10 decided to make the current iteration
of this series have no CI testing at all, and cited the interaction with
ab/ci-updates[4]:

    because a recent unrelated patch series does not interact well with the=
m.

Which I think is clearly inaccurate, because...

> Granted, if `ab/ci-updates` would not have happened, it would have been
> much easier. Or if `ab/ci-updates` had waited until `js/scalar` advanced
> to `next`. But the way it happened was (unnecessarily?) un-easy.

...your initial patch to run the scalar tests in CI[5] was part of v7, and
had the issue described above. It pre-dates the v1 of ab/ci-updates
being on-list by a couple of days[6].

So yes, I do think it was "easy", as in that was an easy fix-up. You
just didn't follow up on it and submitted re-rolls with the already
noted breakage.

I don't blame you for that, maybe you were busy, it slipped through
etc.

But I don't accept that delays in this topic are my fault, or something
to the effect that that this whole saga represents some failure of the
review process.

Our topics textually/semantically conflicted, it happens. I offered a
fixup & way forward. Fixing it was trivial, and still is. You just
didn't follow-up.

> [...]
>> If "The Scalar Functional Tests" that were designed with Azure Repos in
>> mind is not a good fit to come into contrib/scalar/, it is fine not to
>> have it here---lack of it would not make the test target you have in
>> contrib/scalar/Makefile any less valuable, I would think.
>
> The test target won't go anywhere, no worries. Just like the test target
> in contrib/subtree/ does not go anywhere.
>
> And just like `contrib/subtree/`, it does not have to be run as part of
> Git's CI build.

But unlike contrib/completion, which we do run as part of Git's CI
build[7]?

>> Unless you are saying that "make -C contrib/scalar test" is useless,
>> that is.  But I do not think that is the case.
>
> It is as useful as `make -C contrib/subtree test`. Which, as =C3=86var wi=
ll
> readily offer, is broken, because it does not ensure that top-level `make
> all` is executed and therefore in a fresh checkout will fail.

Before the scalar topic there was only one "make" entry point to build
libgit.a, contrib/scalar/Makefile makes that two. That was the immediate
prompt for the fixup discussion in [1].

So no, I won't offer that "make -C contrib/subtree test" is broken, it
doesn't try to build libgit.a and errors out right away if git isn't
built.

Your scalar patches do try, get most of the way there, and fail.

Your bicycle isn't broken if it doesn't make coffee, but if your fridge
has a built-in coffee maker and it doesn't work it's broken, at least as
it pertains to its coffee making function.

I think I made that distinction clear in [8], but apparently not clear
enough, as you seem to be under the impression that I was conveying the
opposite of the idea I was trying to get across.

> Of course, I disagree that it is "broken". It works as designed. It is in
> the contrib/ part of the tree, i.e. safely in the realm of "you have to
> build Git first, and then the thing in contrib/". In other words, the idea
> to "fix" this kind of "broken"ness is a solution in search of a problem.

I agree with that, but it's your proposed patches that contain the build
integration you're describing as unnecessary for "contrib/subtree/". In
v8->v8 of the series you changed the CI integration from:

    make -C contrib/scalar test

To:

    make && make -C contrib/scalar test

While keeping the bits in contrib/scalar/Makefile that made it go most
of the way towards a working "libgit.a" useful for testing, but it
breaks before we get everything we need to run the "test" target.

Which I find to be odd given the above comparison to contib/subtree/. If
you have to build git first at the top level why is it trying and
failing to build git? "contrib/subtree" doesn't.

> [...]
> I would find those things quite a bit more useful than to force regular
> Git contributors who want to change libgit.a (even if it is just pointless
> refactoring) to pay attention to contrib/scalar/ in CI, when there is
> still no clear answer whether Scalar will even become a first-class Git
> command eventually (which I hope it will, of course).

It's in-tree, scalar.c is compiled by default, so they'll have to choice
but to pay attention to it.

The question is whether we should have test and CI coverage for code in
that state.

1. https://lore.kernel.org/git/211123.86ilwjujmd.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/xmqqo86a92jm.fsf@gitster.g/
3. https://lore.kernel.org/git/pull.1005.v10.git.1638538470.gitgitgadget@gm=
ail.com/
4. https://lore.kernel.org/git/211130.861r2xelmx.gmgdl@evledraar.gmail.com/
5. https://lore.kernel.org/git/1b0328fa236a35c2427b82f53c32944e513580d3.163=
7158762.git.gitgitgadget@gmail.com/
6. https://lore.kernel.org/git/cover-0.2-00000000000-20211119T135343Z-avara=
b@gmail.com/
7. https://lore.kernel.org/git/211210.86a6h9duay.gmgdl@evledraar.gmail.com/
8. https://lore.kernel.org/git/211123.86ee77uj18.gmgdl@evledraar.gmail.com/
9. https://lore.kernel.org/git/pull.1005.v9.git.1638273289.gitgitgadget@gma=
il.com/
