Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7EBC00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 18:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbiGZSSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZSSb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 14:18:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F2B31364
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:18:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fy29so27532114ejc.12
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gdNs62+GhBTMrljTJ59/oH9tnRrurFjElcrMZd+8hwk=;
        b=StMd/fArX+teLncaQeWZem80oFsyVBfkFxG8jLw3367p83oO9R9IXr7O9nij+QZV2F
         ZYhJuINFCb8k32nAID2HHj3vdF/PkGz8U8Xaqf+lrzV9DJKeLCE+mEPS634t5kgNqkb7
         R75rCoay+DPmXiKsWWfCkYeyuzoqBp8mDeS1OyVX1a7Xik/8l17bK6htyt6eRRRYnqO8
         gQJKDf7Bo4F46JaVKk4YXW/qvz1S/gXVUfCns0X91L7J3C6E/hBVUVqXJ8rmnThHHzjf
         +mdr0U/Ux5G7yYjT+lX8udzRhhRgyx06tdv/YqbygzCTQso3njLQmLmnbFjlSva7JQh+
         g0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gdNs62+GhBTMrljTJ59/oH9tnRrurFjElcrMZd+8hwk=;
        b=Oke9kIyYlV4b9q+qSKjhshiz+TdQzi5uXup01Zk45TnGIYMqVCCeFxHRMAKbWMsRwT
         CdXPZCP4EGv3Y+sEXHKJJh+JneKWYwTiYeR67W+q4IR0bo++vx4GCOpTOiTMXtc7wvpz
         0RvXRBGm2dIdrLXJGoBR8zu6ggu3W18y4jy3FFYzs0fufhJo7JdZ7kJVfQbw91fysyCA
         an62pp4OixEE9VbOxWtS+7EGOtlD9yhhdAnEA/RMlA06cJERaaFKnfKVVu8zf+8B8Fu9
         Sg14E/cKMV2l+eaGLBCQ4itTV8eMcCHVPXn28zpaA7mI4T9k6FY3CqrXtiptn9sVvbfi
         Fymg==
X-Gm-Message-State: AJIora/TrVMVGrKAGp/5yjeQz6E7k9/tuloJjG6lWQdOaWtTSJh3gGYN
        AXt15rX/tkvrSD8G2ySSh0wtjWoz1OWSww==
X-Google-Smtp-Source: AGRyM1uh8kjc6/IIoBH4BqSwD5Rw7nG2AL1NnBCNMI2EK8Vd/UpsaNtPvvsLP6o3MSdL8iwnyZ9QNw==
X-Received: by 2002:a17:907:3f07:b0:72b:54b2:f57f with SMTP id hq7-20020a1709073f0700b0072b54b2f57fmr14754341ejc.502.1658859507215;
        Tue, 26 Jul 2022 11:18:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c047000000b0043a85d7d15esm8764270edo.12.2022.07.26.11.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 11:18:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGP8T-006DZw-CL;
        Tue, 26 Jul 2022 20:18:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Gregory Szorc <gregory.szorc@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Race condition between repack and loose-objects maintenance task
Date:   Tue, 26 Jul 2022 20:11:34 +0200
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local>
 <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
 <YryKCl5J1Em89d3e@nand.local>
 <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
 <Yr0WLebMfBXZ1K7D@nand.local> <Yr0XMWWyD5C9uhlb@nand.local>
 <da675dd2-c9cf-c3b4-0231-58b3cf3ce9d7@gmail.com>
 <220720.86cze0um88.gmgdl@evledraar.gmail.com>
 <CAKQoGakMtqFW3FR3WqaKrX4P_xbjq2-KceD4ScnVc0-D=-3X=A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAKQoGakMtqFW3FR3WqaKrX4P_xbjq2-KceD4ScnVc0-D=-3X=A@mail.gmail.com>
Message-ID: <220726.86czdrn3f2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Gregory Szorc wrote:

> On Wed, Jul 20, 2022 at 3:12 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Tue, Jul 19 2022, Gregory Szorc wrote:
>>
>> > On 6/29/2022 8:23 PM, Taylor Blau wrote:
>> >> On Wed, Jun 29, 2022 at 11:19:09PM -0400, Taylor Blau wrote:
>>> [...]
>> > Since the interaction between cruft packfiles and MIDX appears to be
>> > buggy, I think I'm going to leave cruft packfiles disabled until these
>> > features work better together.
>>
>> I haven't looked deeply into whether there's any cruft packfile & MIDX
>> interaction at play here, but I suspect based on past experience that
>> this has nothing whatsoever to do with the MIDX.
>
> Taylor seemed to acknowledge a bug here a few posts back. Essentially:
>
> 1. Cruft packfile created
> 2. MIDX repack and expire treats the cruft packfile as a regular pack
> and folds its content into a new, regular packfile, deleting the
> mtimes file/metadata in the process.
>
> I don't fully grok the mechanism, but I believe the loss of the mtimes
> metadata effectively results in indefinite retention of unreferenced
> objects.

Maybe, but I don't see how indefinite retention would happen unless
you're flip-flopping back & forth.

If we're deleting the mtimes file but keeping the pack they're in we'd
notice that those packed objects are unreferenced on the next gc, so
we'd explode them into loose objects, and then the timer starts ticking
on their expiry.

It's a lot of churn, but once that timer expires we'll then expire those
objects.

>>
>> It's because git suddenly found a bunch of objects that should be
>> evicted from the packs, as you disabled the cruft pack feature.
>>
>> Here's a past test-case & report of mine where I ran into that:
>>
>>     https://lore.kernel.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/
>>
>> That was way before cruft packfiles were integrated, but from my
>> understanding of how they work the mechanism is exactly the same.
>>
>> I.e. in that case I deleted a bunch of refs (tag objects), which caused
>> those to become unreferenced, so on the next "gc/repack" they were all
>> evicted from their respective packs, at which point the "gc.pruneExpire"
>> clock started ticking for them.
>>
>> Whereas in your case you disabled "cruft packs", which are basically a
>> mechanism where git keeps such "unused" objects in a pack. Once you
>> disabled it git stopped considering the new *.mtimes file, and started
>> extracting these loose objects en-masse.
>>
>> Which b.t.w. is something I think we might want to reconsider. I.e. we
>> just pass "--cruft" to pack-objects (see b757353676d
>> (builtin/pack-objects.c: --cruft without expiration, 2022-05-20)), but
>> don't have a "write cruft" v.s. "read cruft" setting (but see below).
>>
>> The one thing that gives me pause here is your mention of "summarily
>> deleted by the GC's prune". Did you run "git prune --expire=3Dnow"
>> manually, or do you have a really aggressive "gc.pruneExpire" setting?
>> It's also posible that I'm entirely misunderstanding this whole thing...
>>
>> Anyway.
>>
>> Since that 2018-era post of mine I've thought a bit about how to best
>> handle this particular edge case.
>>
>> I think the simplest implementation that would work well enough would be
>> to teach "git repack" to limit how many objects it's willing to extract
>> from a pack. I.e. we'd have the amount of "unreachable" objects we'd be
>> willing to eject from the pack limited, with check similar to how
>> "gc.auto" works (i.e. once we reach the limit we'd implicitly turn on
>> "--keep-unreachable").
>>
>> It's far from perfect, and e.g. if the N objects you're extracting
>> happen to delta-compress particularly well you could still have cases
>> where e.g. a 1GB repo becomes a 10GB one with the new loose objects.
>>
>> But it would allow us to limit the common case where we'd e.g. create 1k
>> new loose objects, not 100k or whatever.
>>
>> It does have the downside that unless you'd disable that limit the "gc"
>> -> "gc.pruneExpire" window would become even more fuzzy. I.e. now if you
>> run "gc" the clock starts ticking right away, after this the clock would
>> start ticking whenever we happened to extract those objects.
>>
>> So there's certainly less dumb ways to do this, and we'd need to make
>> sure that whatever limit we set is aggressive enough that we'd always
>> "stay ahead". I.e. if a repo just has a very high creation rate of
>> objects that become unreachable we'd need to ensure that we wouldn't
>> have an ever growing .git as our eviction rate wouldn't keep up with our
>> additions.
>
> I agree this is a hard problem! In my case, the underlying repo sees a
> few thousand pushes daily. This results in ~30k new unreferenced
> objects on a typical workday. With NFS/EFS, we've observed that the
> entire filesystem can get slow once object loosening has written as
> few as a few thousand files. Given our high volume, I worry that
> imposing a loose object creation ceiling will perpetually throttle and
> we'll accumulate unreferenced objects indefinitely.

If you're feeling adventurous you may want to try to rebase or otherwise
experiment with this old series of mine, that never made it in:
https://lore.kernel.org/git/20181028225023.26427-1-avarab@gmail.com/

I don't run git on NFS anymore, but when I did I found that the main
contributor to loose object-related slowness on pushes was the collision
checking.

Whereas if you're willing to simply write duplicate objects ....
