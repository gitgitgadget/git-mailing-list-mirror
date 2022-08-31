Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327B1ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 19:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiHaThW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiHaThV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 15:37:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01638D9D7D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:37:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a36so15925561edf.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=o2gLmIOV6Lkeieb7R1ZJCFsqLS65Sfneq/7JzZ5QGHQ=;
        b=G2r0fn11Kf0XKdOFFKWq67NpvdLmGMpRPtCpHpQ7vyzqBRXANqrmGdhOq48je9O3kF
         tZZDv6aFjqm5P2NkbcfcXqdt+x8Ij7XyfoSlG7xWFsD4cKZr4fZ1/wVe86FJaV4nyCsI
         q1nGk6SSZpc+NrQv5NEw7LvkyF4woOd6Sk0dwuDNQi4Y7uWLkxBRX92tcqeVyLDqgdDH
         4m4zOUTl+SdreXgi/QrvfA5MOisN76uzrcLiJoQBhS1pqjfR2Zh/e14fP2UMGb8RDYm7
         5wFn9jx26etwxKm1mFI6dlaamzQ7/xiR92Splp6+JCGRE3j8eAllL1tvG9wdk+DXPpiE
         qn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=o2gLmIOV6Lkeieb7R1ZJCFsqLS65Sfneq/7JzZ5QGHQ=;
        b=LbVbYt63c7u2gSBZgRspos12QjIcoxAF/jfaHvBrJRzhMvZlRJMDiTKNsNEvi9hYE7
         mo0h4fhBKCnReZjLfvBlVK+0zAaMj+fbiqvEwO9eDLlBlUct+kyViVbH1NUJKDF1Svyo
         BgHMnk1YBsQGmQ0m07mJOLU8GxJH9RpA3SICYQnc0U2rlGBX2wS5mx5edhvSllKGD0ya
         Frwg7JfF9GCgR3Ayfcf/Jq1l+Urk1RQViP8HloAg8mRHkdodXBHmotamDw92dHwjgYRC
         zY8dI78kQgREevX3jrzfs9c0SMiUgfFTqi70hd1ElokAi5eduGF6hUOgwC3ldhQyVgs/
         h8Uw==
X-Gm-Message-State: ACgBeo0l8IZ/lIqurtDLBXxeO9t90zuztxQRFJ3S3fOg/OpBOXR/Skk9
        I9HIHOSd0apdGERcENJOf4VBPOO+M8zOfQ==
X-Google-Smtp-Source: AA6agR7GmkKUn5P6VK+TbSESVqpXyQLaPvkjt1l8D0AsGSjqnO86Fv5J1FnwlfyW85eTyrT/E2nMPA==
X-Received: by 2002:a05:6402:190d:b0:447:ed22:84eb with SMTP id e13-20020a056402190d00b00447ed2284ebmr21956393edz.379.1661974638389;
        Wed, 31 Aug 2022 12:37:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090632c700b0073ddd36ba8csm7528964ejk.145.2022.08.31.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:37:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTTWX-000Rdl-0S;
        Wed, 31 Aug 2022 21:37:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Date:   Wed, 31 Aug 2022 21:29:30 +0200
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
 <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
 <xmqqfshl3pbp.fsf@gitster.g> <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
 <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net> <xmqqczcnymtd.fsf@gitster.g>
 <20220831084403.GA13663@szeder.dev>
 <220831.867d2oa95p.gmgdl@evledraar.gmail.com>
 <20220831180526.GA1802@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220831180526.GA1802@szeder.dev>
Message-ID: <220831.86pmgg8as3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 31 2022, SZEDER G=C3=A1bor wrote:

> On Wed, Aug 31, 2022 at 02:13:51PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Wed, Aug 31 2022, SZEDER G=C3=A1bor wrote:
>>> [...]
>> If you remove the "done:" line in cmd_format_patch() buiiltin/log.c runs
>> in ~200ms instead of ~40s for me. Perhaps we should be discussing
>> removing or refactoring that one line of code instead? :)
>>=20
>> Removing coccinelle rules because we're seeing slowness somewhere seems
>> particularly short-sighted to me.
>
> It's not just slowness, it's drastic slowness.  I'm looking at two
> "from scratch" 'make coccicheck' runs here, one with 'unused.cocci'
> taking 9m51s, one without taking 4m56s.  So 'unused.cocci' effectively
> doubled the runtime, and wastes other developers' time and resources.
>
> I don't see anything wrong with removing a semantic patch that is as
> slow as 'unused.cocci' in its current form on our current codebase.
> We can always re-add it later, after those interested managed to
> figure out a way to address its slowness, and updated the semantic
> patch and/or the codebase accordingly.
>
>> Maybe we do run into intractable problems somewhere with it being slow,
>
> Looking at the runtimes I showed above, I think deeming it intractable
> is fully justified.
>
>> and we'd also like to cater to more "interactive" use.
>>=20
>> But we shouldn't do that by removing rules until we get below some
>> runtime limit, but rather by creating a "batch" category or something
>> (just like we have "pending") now.
>>=20
>> Or, just actually look into why it's slow and fix those issues and/or
>> report them upstream.
>
> IMO this should be the other way around: if applying a semantic patch
> is this slow, then first look into why it's slow, fix it, and only
> then submit it for merging.  A semantic patch this slow shouldn't have
> been merged in the first place.

If we're playing hypotheticals then if it hadn't been merged in the
first place we'd have the UNUSED() macro all over the place on master
now, and several *other* rules would probably be more broken (but I
haven't looked into the cooci guts enough), we just wouldn't notice
since "unused" is currently the only "look ahead" rule that fired &
caught it :)

>> There's nothing in unused.cocci that we either aren't running into
>> elsewhere, or wouldn't run into if we had 10x the coccinelle rules we
>> have now (which I think would be a good direction, we should rely on it
>> more heavily).
>
> Several developers have already stated that they might run 'make
> coccicheck' more often if it weren't so slow.  I think we must keep
> this in mind when adding new semantic patches, and should aim for a
> good return of investment between the usefulness of the semantic patch
> and its overhead.  'unused.cocci' doesn't seem to strike a good
> balance here.
>
> I doubt that I would ever run 'make coccicheck' if we had 10x as many
> semantic patches.

I think we're just describing our workflows by proxy here.

For me I generally take wasting a computer's time over a person's time
any day.

We should always be optimizing for saving people's time over CPUs,
because the latter is relatively cheap.

Granted unused.cocci isn't doing much in the grand scheme of things, but
if you know it's there it's one more thing you can let your eyes wander
over in patch review. You don't need to worry if some "struct strbuf"
(or similar) is really being used, or is leftover boilerplate.

Yes, it would be useful if coccicheck were currently fast enough to run
as part of an edit-save-compile-check cycle, but like e.g. -fanalyzer
it's much too slow for that for most people. So it gets run as some
"batch' job.

I think most people who use it in git.git are doing so by pushing to
CI. There it doesn't really matter that it takes longer now, because as
long as it's not slower than the longest running job it won't hold up
the total CI runtime, which is in the ~1hr range anyway.

So that's how I use it (when based off master). I also run it when I
build my local git, but that's a "kick it off in the background and
wait" type of operation. It runs tests, then other tests with other
compilers, SANITIZE=3Daddress etc. etc.

So I'm sorry if I tripped up some workflow for you with this change, but
I do still think it's worth it.

>> I've found that being able to have a ccache-like tool for "spatch"[1]
>> solved almost all of the practical performance concerns I had with
>> it. I.e. I can just run things in a batch, and usually any interactive
>> use will hit things already in cache.
>
> Well, perhaps that's why you didn't notice just how slow
> 'unused.cocci' can be... :)  Please don't forget about the runtime of
> a default "from scratch" 'make coccicheck'.

I did notice FWIW, but since I'm mainly looking at CI and other "batch"
operations when looking at "coccicheck" I thought the trade-off was
worth it.
