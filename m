Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7442C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353219AbiALMnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbiALMnR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:43:17 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F83CC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:43:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u21so9469859edd.5
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UUQDAIN7dImFEnGs+P+M2DlaWmLllIrljPPQj24++cA=;
        b=nVwzEpK3LP29UhA3zK53pZ0lB2vdHrEGnWXUbLWb3jdRnxF8bq+lj6bD+TXA5LXdnO
         RApjTLEE6vH5+crdm0ejGKGn4spG7QdPdHTKN5gQdzOAY/W75clY+nl6n4PCX88E1xKL
         4L8TiZ6tNqA/wlbuXo2x7Z1iY3kcM9je/bX3XU8eEA+tQzpLtyjD2bk9QgHTFvOJnO6u
         9UJZ7CCqB1LuPCK5ePFLY8rTjWwjtIt+ddH2I/2jVZD7840sJrgbp4kB3ubqWzQhC7lz
         GStf8awyQJYswqiiwPwCMzQF2E/OPlJ61BubxMT6oNhpdv8E4FWdBOEKvqqZAR0dT6DZ
         dzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UUQDAIN7dImFEnGs+P+M2DlaWmLllIrljPPQj24++cA=;
        b=vfzAt/4Vx6Yi0tsWtgMxAr5oDKryik3n812NzUzymUJe7c4JSr4Z1PVDqBhrVlExwc
         Yff65GATwV0vQcaqDeg3zLldMfwDZOMaabJ1dsR/PPislU2il4blxpJtQCyMwQDlyYRz
         ahAUfg9DR4x07GO7/t7Jwg+W8N/iu6vbOYD1xxufLMGu/oiKKEtgE1QR4qkA4hpSFzVH
         2GYvb4kXv1DmCweIF545UqS/TIebQs7H8T3xUAeCt3xVzQ1u6is9JJi9dsPuv5G7hCLh
         UpUgvOKBmQA4umzqeOrJoGvUwSzwoJblNIKvggQs9obHeezXZYJA0kMlsQsPV58pi3kO
         YclQ==
X-Gm-Message-State: AOAM533+7lXRciAt6OjDbkYnuJqwBJF091LXwuMXLVBfODJSp04NnPTl
        XGARD0nQXseKwSLFc0+gY+4=
X-Google-Smtp-Source: ABdhPJyQlQzO0bCmDXbG5EzO5xXhEEyGnZB1KFrD8gtnWp+VA/iW3uafcaS1X3ZN/RIHXHxsQ1q0CA==
X-Received: by 2002:aa7:cd9a:: with SMTP id x26mr8985796edv.159.1641991395820;
        Wed, 12 Jan 2022 04:43:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gs14sm4512248ejc.183.2022.01.12.04.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:43:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7cyA-000iUN-R3;
        Wed, 12 Jan 2022 13:43:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
Date:   Wed, 12 Jan 2022 13:42:29 +0100
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
 <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
 <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
 <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
Message-ID: <220112.86a6g1xgyl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Derrick Stolee wrote:

> On 12/20/2021 11:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Dec 20 2021, Derrick Stolee wrote:
>>=20
>>> On 12/12/2021 3:13 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> But we've also grown a hard dependency on this directory within git
>>>> itself. Since 94c0956b609 (sparse-checkout: create builtin with 'list'
>>>> subcommand, 2019-11-21) released with v2.25.0 the "git
>>>> sparse-checkout" command has wanted to add exclusions to
>>>> "info/sparse-checkout". It didn't check or create the leading
>>>> directory, so if it's omitted the command will die.
>>>
>>>> Even if that behavior were fixed we'd be left with older versions of
>>>> "git" dying if that was attempted if they used a repository
>>>> initialized without a template.
>>>
>>> This, I don't understand. Why can't we add a
>>> safe_create_leading_directories() to any place where we try to
>>> create a sparse-checkout file?
>>>
>>> This would fix situations where older versions were init'd with a
>>> different template or if the user deleted the info dir. The change
>>> you've made here doesn't fix those cases, which is what you are
>>> claiming is the reason to not do the other fix that seems like it
>>> would.
>>>
>>> What am I misunderstanding here?
>>=20
>> I'll clarify that a bit in any re-roll.
>>=20
>> Pedantically nothing changes, i.e. you can create a repository with an
>> empty template now, and it'll break on both the sparse-checkout on that
>> version, and any previous version that had that un-noticed issue.
>
> You continue after this with more motivations for adding 'init'=20
> unconditionally, which I am not fighting.
>
> What I _am_ saying is important is that if we are trying to write
> a file to a known location and its parent directory doesn't exist,
> then we should create it. Not doing so is a bug and should be
> fixed, no matter how rare such a thing is to occur. As you've
> shown, it is not required to have an info directory until we need
> one (e.g. for sparse-checkout or an excludes file).
>
> If you're not planning to add that to this series, then I'll add it
> to my list. I do think it would fit well into this one, though.

Just so we'll avoid stepping on each other's toes, what's the status of
your plan/non-plan to work on that more isolated fix, perhaps you have
one that's unsubmitted?
