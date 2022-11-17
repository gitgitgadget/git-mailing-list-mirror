Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CCCC433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 18:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiKQSKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiKQSJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 13:09:58 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CD26D4A5
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 10:09:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n21so7060661ejb.9
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 10:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zPgIJcg9xEwvD5cklhjwSeC9QE28fUH4t2t3q4CCkx4=;
        b=VkwQGsI7WL8I34ntUK2v05S2iTxdhZys54ZMVwrRQrrJrZ3He0kpEvkZypalllzxa9
         ixjaqIZcIkWd7KXAVlXIRWJrnY/uAjs8ftwjKInss1QH4J9+nvzM6cZbcfXMcm/y83VH
         pz5QJq06RNkAsnZaWXoO7uHEV8EGKFvaUJz+A45j722UkoQeWQvupY0LjZEWnBGdPTzU
         JAYBBUxdywVI47m3++Uio3P81OClrudKv+Bgs3Thoc4dNa4jUV+dAuUHVhZ8nlpwy5ZK
         Q6Efq/RQnUrBO0tYCnIr3+KFGehUuo+i6DvReX7vibbN3hMajQckCJB2qW3G5DXbCA1T
         3HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPgIJcg9xEwvD5cklhjwSeC9QE28fUH4t2t3q4CCkx4=;
        b=6KveQsUIRDJPUW2GmciVVdSRo9baNB9EoQrotDbWEhzv1evRpoIpNXYiZOALfXJ6lA
         qSQCyGWvnTd1Jf8vfPO2F9bpwM5hEPmLbawrZSvGrlM3TsQhUc9qHBRcROFT1G/nbeGL
         PuOiLbdJAu2pc+A62FivNJfIw7aIODl+o6fzftsryVKAQ7EMrjTWfvliGO/qm6jhq61a
         gBfk+mHhtoy1tCoFGRM1OywWUh8WgfiG+4iey0aPGYRIng7zR4ckLUC5kgvncPZnibk/
         F6Ji7Rl1smgJloCM/jHiOQWN3xFbZsKGGkR4kRu+uVCdj/kmIWRm8NU3szJi1jsZS3WR
         dYNQ==
X-Gm-Message-State: ANoB5pmAaf6F9cc8Uoz7ByrVh4cuFRyvr0ur/fOJrI3sLv3oqflYkaEY
        ainlHfgEhqqgecLcB0tbqMI=
X-Google-Smtp-Source: AA0mqf62WsCVGVDAWQsn5miHbiUsynotxbnBadF5iUSwtSD2uqQPOPJQo6tleZDWq4BcA1cf446neA==
X-Received: by 2002:a17:907:d092:b0:7ad:7e85:8056 with SMTP id vc18-20020a170907d09200b007ad7e858056mr3087768ejc.40.1668708595436;
        Thu, 17 Nov 2022 10:09:55 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id h2-20020a170906260200b0078d38cda2b1sm651309ejc.202.2022.11.17.10.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:09:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovjKk-004weR-0x;
        Thu, 17 Nov 2022 19:09:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 00/10] Get rid of "git --super-prefix"
Date:   Thu, 17 Nov 2022 19:07:04 +0100
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
 <kl6lk03xnm1h.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221115.868rkdknmz.gmgdl@evledraar.gmail.com>
 <kl6lsfiivcau.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6lsfiivcau.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221117.86y1s9h2q5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 16 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Nov 14 2022, Glen Choo wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> It's also proposing to replace Glen's one-patch[6], which is working
>>>> around the problem shown in the test added in 1/10 here. Per
>>>> downthread of [7] I think Glen was aiming for getting a more narrow
>>>> fix in case we split off 9/10 here into some later fix.
>>>>
>>>> As we're fixing an edge case in something that's always been broken
>>>> (and thus wouldn't backport) I think it's better to just fix the
>>>> problem directly, rather than introducing new "--super-prefix" use,
>>>> just to take it away later.
>>>
>>> I still prefer that we take the one-patch to unbreak new releases,
>>> because partial clone + submodules is absolutely broken (e.g. it's
>>> already causing quite a lot of headaches at $DAYJOB) and the patch is
>>> obviously harmless.
>>>
>>> And more importantly, it lets us take our time with this series and get
>>> it right without time pressure. It's not as pressing as, e.g. a
>>> regression fix, but it does render certain Git setups unusable.
>>>
>>> With regards to urgency and when to choose "small and harmless fixes vs
>>> bigger and better fixes", I think Junio has generally made those calls
>>> in the past. @Taylor if you have an opinion, I'd love to hear it.
>>
>> I feel like I'm missing something here. What's the regression? The test
>> you're adding here didn't work at all until 0f5e8851737 (Merge branch
>> 'rc/fetch-refetch', 2022-04-04), as the command didn't exist yet. That
>> commit went out with v2.36.0.
>>
>> If it never worked there's no regression, and we wouldn't be merging
>> down a fix for older point-releases.
>>
>> Or is there some case I've missed here which did work before, doesn't
>> now, but just isn't captured in this test? If so what case is that, and
>> when did it break?
>
> Right, this wasn't meant to be a regression fix at all. There's good
> reason to believe that this was always broken, so I never went digging
> to see if it ever worked.
>
> Even so, it doesn't change the fact that it's a use case that we've
> expected to work, but doesn't due to some internal silliness, and that
> we could fix it without invoking questions of the "--super-prefix"
> design and dragging out the process (which is admittedly what I should
> have done in the first place). Since we have such an easy fix in front
> of us, I don't feel good about not fixing this before the next release.
>
> At any rate, I'm wiling to accept that I'm being overly cautious,
> because it's quite likely that this series will make it into the next
> release. (We could technically we unbreak 'next', though I don't know
> who distributes that other than internally @ Google.) I'm ok to drop my
> patch for now, but I'll revive it if it starts to look like this series
> won't make it into the next release.

Understood, I'm re-rolling this v2, will send it out soon.

I'll keep that patch out for now, but if we're starting to run up
against the next release how about we split it out? So it'll depend on
how fast we can review & test this, and if/when Taylor is OK with
merging it down.

I really don't care if the fix comes first, but just thought I was
missing something and it didn't seem urgent, as it was in the "never
worked" and not "a regression" category AFAICT. But if you'd still like
it shout, and I'll just stack it at the start...

