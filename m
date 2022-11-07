Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40344C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 23:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiKGXEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 18:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiKGXEm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 18:04:42 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428E42C66D
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 15:04:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a13so20009846edj.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 15:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P5pc/7q5yTkqVVJGN/SeCnp9t99zV8Yntt/vQy65TFI=;
        b=QMN0Cs+41QMZdXapdg1M4uJVdp19o9t77nBV3MXeraBVDtzPPLqumKMGIUJTpH3m70
         vPuSipUjy59wVl3ljQRjffLnw78ktl532rCxtahyqlxDMoHAK+xMZHGKGNdjfkGYIqZx
         QBTyiOxavq1mnr5+VGKq/rZUetbXtAIcRRBP3oWSJPVYJwm0VBgJZjnT6/sDqHwpnsDN
         tv0PkxMKEcnc9V14qFhDsENxZJ5GehKE29XdqM3aRd9LBR7rGUJHOd2yKod7+HFM5AzI
         sTad72VIYi3kdYGnmCu+a2BKlln8fYBRSQqQJ5+BqyNDhw0T7zbWZ+VtY1qoS/H95BQv
         XWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5pc/7q5yTkqVVJGN/SeCnp9t99zV8Yntt/vQy65TFI=;
        b=Kel+2wBi6V9Y4ty2Va1RjT1elQwk4fqnVqCqPpyDgqaD/FI0t8KXuUbATDEHUx9skw
         n6ceKfRPXzD5vpPp/rXXfIox6cfVfltuzco0/RRtL1yZr+PdY8vJekJH/IT9bF3Zega3
         79KuIcqthfdtnlc9F/u8ecIJdRAjrtec7ocEHtn5phJ+OBUR9pVXXA1Q/p0GcPoqRJxZ
         JOUjks0r7uXHthYzdGFLrW0OLdVZPnO0Nvuf21UoXFUSLCMni1Qzl0XYdNUABU6DEsJ1
         A7BFD9x+6EEj78NuaP5OAD6U3fp+0eMRgaVPbQUXHUQPn6Qr1z+7t6xC+A55mRdpjWn3
         b1jg==
X-Gm-Message-State: ACrzQf1aBP+Q9+OnDQFsUXM7F4Uhs3nRXy/rzDx/fIJUmc9rUM/1WDxt
        0mdBhAx8HsSXmxf7SZv2po5d0r0Wn/j3YA==
X-Google-Smtp-Source: AMsMyM5Ge/+cPSc3CpWyBri8BpKkPR/ygMqpIXRfp7SgQTl1fdRmSOasrwX/LIsMiSDOWOc4SV6wXw==
X-Received: by 2002:a05:6402:1e89:b0:461:a8b5:402a with SMTP id f9-20020a0564021e8900b00461a8b5402amr54000955edf.336.1667862274784;
        Mon, 07 Nov 2022 15:04:34 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id sb21-20020a1709076d9500b007815ca7ae57sm3981930ejc.212.2022.11.07.15.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:04:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osBAP-000Nru-1d;
        Tue, 08 Nov 2022 00:04:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid unnecessary builds
Date:   Mon, 07 Nov 2022 23:56:30 +0100
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
        <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
        <Y2liOzOFLyz4uzd0@nand.local>
        <85b30a45-e00e-44b5-ae4a-b09542a9fb19@github.com>
        <221107.865yfqv58k.gmgdl@evledraar.gmail.com>
        <114d4a72-1a75-71f3-8af6-6e82cd4fd54b@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <114d4a72-1a75-71f3-8af6-6e82cd4fd54b@github.com>
Message-ID: <221108.8635autlha.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Derrick Stolee wrote:

> On 11/7/22 4:03 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Nov 07 2022, Derrick Stolee wrote:
>>=20
>>> On 11/7/22 2:53 PM, Taylor Blau wrote:
>
>>>> I wonder how we should treat =C3=86var's concerns in this thread. I su=
spect
>>>> that the vast majority of workflows wouldn't be affected, but I don't
>>>> want to completely break =C3=86var's workflow, either ;-).
>>>>
>>>> Some kind of configuration mechanism like I proposed might be nice.
>>>> Thoughts?
>>>
>>> Taking a look at that sub-thread, I have two thoughts:
>>>
>>> 1. I don't think supporting a "multiple pushes of WIP work"
>>>    scenario is a good use of "free" resources. If you want to
>>>    test multiple versions of something, then use multiple
>>>    branches (and I think Johannes's patch allows concurrent
>>>    builds for distinct branch names).
>>=20
>> The setting Taylor proposed in
>> https://lore.kernel.org/git/Y2R3vJf1A2KOZwA7@nand.local/ is off by
>> default, i.e. it would behave the same way as what Johannes is
>> proposing, just give you (well, me) an opt-out from the default, without
>> patching main.yml on every branch.
>>=20
>> So it seems like a win-win, why force others to change their workflow?
>> Sure, I could push multiple branches, but you could also manually cancel
>> your outstanding jobs before re-pushing...
>>=20
>> I agree that cancelling the outstanding job is a better default, and if
>> we had to pick one or the other I'd say "sure", but if we can have
>> both...
>
>>> Either of these points may have an incorrect assumption, so
>>> I'm prepared to be wrong.
>>=20
>> I *think* you're wrong about #2, but I'm not sure either.
>
> At the very least, the configurable option requires fetching the
> repo and checking out at least one file. I don't know how much it
> actually saves one way or another.

It's already fetching the ci-config repo, so we're talking about the
marginal cost of running the bit of shellscript to check if
config-repo/ci/config/skip-concurrent is executable, and if not keeping
the default config.

>> I don't think you can be wrong about #1, "others should change their
>> workflow to fit a new worldview" is more of a value-judgment :)
>
> True, but I think that the workflow you are trying to keep valid
> is also indistinguishable to the typical flow of force-pushing
> during incremental rewrites, so preserving your workflow will
> continue to add costs to that behavior.

I don't think it will, per the above. I mean, pedantically yes: But the
cost of that "test -x and variable setting" is so trivial that it's not
worth worrying about.

> My value judgement is that experts can adapt their workflows as
> situations change for the better of the group.

Sure, I agree with that in zero-sum scenarios, or where it's a hassle to
provide two things, and we need to pick one etc. I just don't see that
being the case here.

> If the cost of doing the config option version is minimal over
> the global concurrency issue, then I say we should go that route.
> I just expect it to take up more resources than the strategy
> proposed in the initial patch.

Based on what? That you read it as us cloning the ci-config repo just
for this new proposed config, and missed that we're doing it already, or
...?

> I wonder how we could determine this. Should we run a few CI
> jobs with some force-pushes in either approach (config turned
> off) so we know that cost?

The incremental cost of that "test -x", or...? I'm not sure what you
mean here.
