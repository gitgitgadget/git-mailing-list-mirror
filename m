Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10D8C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F2A61283
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhKSU7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhKSU7s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:59:48 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B46CC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:56:46 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x6so35968082edr.5
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oW6qvCZUNBJF0dSIKWykcBplytTJ7ofL0vqsSVbpwQU=;
        b=XskytkrNqyWJ7eyYLsNeacBPBfOTjFlhTIfkNjnHU+9KPQ4h9SPkJXtREZTcA2S9ot
         BCk6AdNV2G3rFUGJaoxvZ8Bt+Dtrd2x9jbsKNW4lB1K+ewYatIlIMNd8LllhOQ402S95
         2yBSARqa92nmPbAz3hW8/10vR1UL1bCP7Vxn2Nv2LOI4cTNE30FadIF5/wXUmBukHhIJ
         8z8Gud/k/TifJOj7gzrUVnLN6+0pOg6vLRjphs8mliI0Ekmu9Ou+BxVfoB67rPp/5Zmk
         sCZuaMMvm3i2TvWRpxIRsW0NkqxWo4ks1sgSxtI6xlFxMGdVKV8ordA7AF46Ef5Enmap
         Vdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oW6qvCZUNBJF0dSIKWykcBplytTJ7ofL0vqsSVbpwQU=;
        b=sS8MjdxynMp+GhdmquVG5UF2ODh5z99tTTceA8D6dKp5hMpAmHbUIuDBMhFuDVu6Ok
         Ch8qrdnFw3Vh5npRTyVw2/PbBTZRXoDW6kFUs4igDhzP5qL5SoT5lQsKgymcPmbo2L3/
         4ZLyz2+hcbzUBl8uX1KDWqgethgxdvfF0HX7B3n48gRr4ayjP46StB82y3urAWSgJmFJ
         Xm/cTkm3WFmi1U+SM8iEGNHmyT+A5N8k3ts9SW2LbkYCZNa/et5OZsr7WZBPGCgY7/Kw
         CD5uzbIDPE9m7puorYVYgRYXcCsslPFCYb30boqdG8NCUqslOUTUbow8cq69bw/oUiXb
         dzyw==
X-Gm-Message-State: AOAM533XRfZVhElF6czJ+rWC4t3O9Z8EiBZcjbksDCG5ATmeycK9ehd/
        lXF0JYE6knhjW5EcQWjcnv0=
X-Google-Smtp-Source: ABdhPJx9MAWHclxNnzITeRu2WNl1iScDqvIgFVz4K319Zgoi32FJSKOSOY8tlg2D6hg5Be3iE4PHGA==
X-Received: by 2002:aa7:c313:: with SMTP id l19mr29153615edq.209.1637355404924;
        Fri, 19 Nov 2021 12:56:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d1sm451781edn.56.2021.11.19.12.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:56:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1moAw7-000oJj-Mk;
        Fri, 19 Nov 2021 21:56:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/2] CI: use shorter names for CI jobs, less truncation
Date:   Fri, 19 Nov 2021 21:48:07 +0100
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
 <xmqqbl2fq5oa.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqbl2fq5oa.fsf@gitster.g>
Message-ID: <211119.864k873lv8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This changes the names used in GitHub CI to be shorter, because the
>> current ones are so long that they overflow the pop-up tooltips in the
>> GitHub UI.
>>
>> New pop-up visible at: https://github.com/avar/git/tree/avar/ci-shorter-=
names
>>
>> Full CI run at (currently pending, I had a trivial last-minute
>> update):
>> https://github.com/avar/git/runs/4264929546?check_suite_focus=3Dtrue
>
> I have found the labels on "Jobs" on the left hand side pane
> irritatingly unhelpful.  For example, "regular (linux-gcc-default,
> gcc..."  does not tell me much about how it is different from
> "regular (linux-gcc, gcc, ubunt...".

Yeah, I've needed to look it up most times..

> The question I ask most often is "which one of these ones is the job
> that runs tests twice, the second time with nonstandard settings?",
> or "Only windows-test(4) is failing, but not vs-test(4); what area
> did we break?  What is in (4)?".

Because I had to look: It's a splitting method Johannes came up with,
first stat() all the tests, sort by size, then chunk them up, and use
the Nth as a way of dividing those chunks.

Maybe he feels strongly about it, but I think a better approach is just
to hardcode t0xxx, t1xxx or whatever, then if one is unusually slow have
a t1[0-4]xx & t1[5-9]xx or whatever, I.e. just manually partition them
as a one-off.

These jobs take ~30m anyway, so if one is a tad slower than another it
doesn't really matter as much as seeing at a glance where in the test
suite the failure is.

I nicely split these all up in a follow-up, along with removing the
travis CI, but anticipated the usual objections about too much of a
scatterbrain series.

But yeah, I think all of that would be great to have, I can submit that
as a v2, sound goood?

AFAICT the whole "stick this all into one job" way of doing the
GIT_TEST_* CI is a workaround for some Travis-specific thing.

Or a micro-optimization for trying to max out our total CPU time, but
anyway it doesn't seem worth it. By far most of the time is spent in the
tests themselves, not the build.

A WIP split I had of this, e.g. there's a linux-sha256 job,
linux-TEST-vars for the big GIT_TEST_* accumulation etc:
https://github.com/avar/git/runs/4265312207?check_suite_focus=3Dtrue

We could (and I'd like to..., but not now) cache the build directory
between runs. Much faster compilations, and if it breaks, well then our
Makefile dependencies are broken, which is also nice to spot in CI (and
the cachewillexpire) ...

> I do not think relabelling "windows" -> "w32" (why not "win", by the
> way?), "vs" -> "w32/VS", or "regular (\(.*\))" -> "\1" helps me very
> much in these questions.  I however think the blame for it lies
> mostly on the original naming, not your effort in this series.

I'll pick "win" next time, as noted in some other follow-up replies.
