Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AF2C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 10:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiGTKMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 06:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiGTKMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 06:12:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CB656BAD
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 03:12:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j22so32211479ejs.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HnKXhOneHyaUMnQ7FbIjZYsKfne2lMtP71yMtRP+dlo=;
        b=IzZGotn8LCA/vQWj6lhSc9zO0moHfzLL+CX7l85yyNAZzFGq3emWLoaRkqph5whxC4
         2EWLBhDn/6uQ3gwqVVqRBnjkeL9tdrxwRxSVtXillD/SL8DvXTD5MqH4X8cqKGYzp8jB
         VGWCj52H0c56ul261j6uu3uRJ7tpDp1Cx/Gs2P/JGHODQjf35/sT/+bMfEdJfE3zp9kH
         IqMUL7z3ascvzTTxH5WWN6T3uTYKpJ/OhYXhw2gjUrSWvoJSZuI8K3uK4Tx/dtnWQxPu
         IuEJ+ec4HnoGQDufpV4fj7Ym3jXDL4TsDeHrNUCgIrPWcl/6rDbKd7GNEBrWpzwlwVZK
         e8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HnKXhOneHyaUMnQ7FbIjZYsKfne2lMtP71yMtRP+dlo=;
        b=cOVXMSy91bnoctht/trD74TnEd80NgTtJPag/5L2P+3SAShxIBdPHUYVdpytDxmLPm
         SyA739WtS66jxYJa2THs2GE/0ZkaYecLyB6alfzPz8OKy3ARbAa5JczlkXDRXP9LjlRT
         15nUdIThRG8xQNnP3leYHMaSkMnRUN6wV37FUK6vzJqTCIWw3Rk+bdRV5CEAeY4BYaXL
         mgnRKhWr1YP1LtNJoNFFtRbfX7KJxuayPlH4SojPpM5bil7x3q4p0djODu6way6YnmWX
         rhkC4JuCe5Mag57ZNH6OjanYKSfODb0CXNVKtfxrmgO+6vuHeGnSoonJypp3lYqbyMmy
         fiCg==
X-Gm-Message-State: AJIora/y62jrU8GeYO4RnUCVlLvDgbdnjqxag6htnrXNrttmJfWxPHfa
        5lcgHAqCN+CDBt+EEvVV6tE7FsV7b9A2Sw==
X-Google-Smtp-Source: AGRyM1v3I+7pjBsPAd2vxh2EJE2kBQA7jngM31lg/teyT1KmiR/xCozYo1waXd6s2gG58j5I09IUpw==
X-Received: by 2002:a17:907:2808:b0:72b:50cd:2c8a with SMTP id eb8-20020a170907280800b0072b50cd2c8amr33376460ejc.246.1658311931821;
        Wed, 20 Jul 2022 03:12:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id sa8-20020a170906eda800b00726dbb16b8dsm7686825ejb.65.2022.07.20.03.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 03:12:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oE6gZ-003vfk-V8;
        Wed, 20 Jul 2022 12:12:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Gregory Szorc <gregory.szorc@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Race condition between repack and loose-objects maintenance task
Date:   Wed, 20 Jul 2022 11:52:11 +0200
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local>
 <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
 <YryKCl5J1Em89d3e@nand.local>
 <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
 <Yr0WLebMfBXZ1K7D@nand.local> <Yr0XMWWyD5C9uhlb@nand.local>
 <da675dd2-c9cf-c3b4-0231-58b3cf3ce9d7@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <da675dd2-c9cf-c3b4-0231-58b3cf3ce9d7@gmail.com>
Message-ID: <220720.86cze0um88.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 19 2022, Gregory Szorc wrote:

> On 6/29/2022 8:23 PM, Taylor Blau wrote:
>> On Wed, Jun 29, 2022 at 11:19:09PM -0400, Taylor Blau wrote:
>>>> However, I think there is yet another bug at play: running
>>>> `incremental-repack` appears to be able to repack the cruft packfile.
>>>> In doing so, it deletes its .mtimes file and the metadata inside.
>>>
>>> That sounds like a bug to me. I'll take a look into it and see what I
>>> can find.
>> I actually think that there are two bugs here.
>> One is that we run a MIDX repack and expire, which could lead to us
>> repacking the entire contents of the cruft pack and then expiring the
>> metadata file. This is a bug, and we should exclude cruft packs from
>> this computation.
>> Another bug can happen when the cruft pack gets written into the
>> MIDX
>> and is MIDX-expireable (meaning that no objects are selected from the
>> cruft pack). In that case, the `git multi-pack-index expire` step would
>> remove the cruft pack entirely, which is also incorrect.
>> I'll take a look at fixing both of these, and thanks for pointing
>> them
>> out!
>
> For posterity, when I disabled cruft packfiles after having it enabled
> for a few weeks, the next `git gc` invocation on a high traffic repo 
> resulted in >100k loose objects/files being created before they were
> summarily deleted by the GC's prune. This is significantly greater
> than the unreferenced object creation rate of the underlying repo. So
> it appears as if the MIDX stripping of the cruft packfile mtimes
> effectively disabled pruning, leading to a build-up of unreferenced objects.
>
> Fortunately I hadn't deployed cruft packfiles to production. If I had,
> the excessive filesystem churn on NFS would have caused an incident
> due to degraded performance.
>
> Since the interaction between cruft packfiles and MIDX appears to be
> buggy, I think I'm going to leave cruft packfiles disabled until these 
> features work better together.

I haven't looked deeply into whether there's any cruft packfile & MIDX
interaction at play here, but I suspect based on past experience that
this has nothing whatsoever to do with the MIDX.

It's because git suddenly found a bunch of objects that should be
evicted from the packs, as you disabled the cruft pack feature.

Here's a past test-case & report of mine where I ran into that:

    https://lore.kernel.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/

That was way before cruft packfiles were integrated, but from my
understanding of how they work the mechanism is exactly the same.

I.e. in that case I deleted a bunch of refs (tag objects), which caused
those to become unreferenced, so on the next "gc/repack" they were all
evicted from their respective packs, at which point the "gc.pruneExpire"
clock started ticking for them.

Whereas in your case you disabled "cruft packs", which are basically a
mechanism where git keeps such "unused" objects in a pack. Once you
disabled it git stopped considering the new *.mtimes file, and started
extracting these loose objects en-masse.

Which b.t.w. is something I think we might want to reconsider. I.e. we
just pass "--cruft" to pack-objects (see b757353676d
(builtin/pack-objects.c: --cruft without expiration, 2022-05-20)), but
don't have a "write cruft" v.s. "read cruft" setting (but see below).

The one thing that gives me pause here is your mention of "summarily
deleted by the GC's prune". Did you run "git prune --expire=now"
manually, or do you have a really aggressive "gc.pruneExpire" setting?
It's also posible that I'm entirely misunderstanding this whole thing...

Anyway.

Since that 2018-era post of mine I've thought a bit about how to best
handle this particular edge case.

I think the simplest implementation that would work well enough would be
to teach "git repack" to limit how many objects it's willing to extract
from a pack. I.e. we'd have the amount of "unreachable" objects we'd be
willing to eject from the pack limited, with check similar to how
"gc.auto" works (i.e. once we reach the limit we'd implicitly turn on
"--keep-unreachable").

It's far from perfect, and e.g. if the N objects you're extracting
happen to delta-compress particularly well you could still have cases
where e.g. a 1GB repo becomes a 10GB one with the new loose objects.

But it would allow us to limit the common case where we'd e.g. create 1k
new loose objects, not 100k or whatever.

It does have the downside that unless you'd disable that limit the "gc"
-> "gc.pruneExpire" window would become even more fuzzy. I.e. now if you
run "gc" the clock starts ticking right away, after this the clock would
start ticking whenever we happened to extract those objects.

So there's certainly less dumb ways to do this, and we'd need to make
sure that whatever limit we set is aggressive enough that we'd always
"stay ahead". I.e. if a repo just has a very high creation rate of
objects that become unreachable we'd need to ensure that we wouldn't
have an ever growing .git as our eviction rate wouldn't keep up with our
additions.

For cruft packs (this is a continuation of the "see below" above) we'd
do the same thing, but could benefit from knowing that such objects are
"already expired", so we could read the *.mtimes, and possibly expire
some right away.

Aside from some very obscure use-cases I think these these sort of
"loose explosion" are one-off events, so if we can smooth those out. The
various gc.* settings can be hard to reason about, but we really do try
to be gently by default, but notably fail very badly at that in some
known edge cases, such as this one.



