Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991ACC00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 16:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiGZQWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 12:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbiGZQWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 12:22:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4350A275E7
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 09:22:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i205-20020a1c3bd6000000b003a2fa488efdso5883031wma.4
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 09:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T4uaLnmGYN+kYe5AHxlzlMAMFUkG2Bkm42rN+k3sro0=;
        b=p0QViIz41P0jiwEOF/YvCdCRUVgGBwYTK4D0a23Djq9oq9uQfolYAEMj3E5fRIJoTa
         sPo1Dv+39PJR+HCRtSuEchG5+jul4/izW1VLP65HLEbKrPooFvdcE8gddF4j5TioEqQa
         VvYYlewbEzChw3efATS19kFuCqsAWg6bmn3eWvKzPEsee6aUltKF1i2CMz/ymKisR6zW
         h2TEe7FCuG9nXlSkCUPqaz1xQAwya2MzX7HcXfr+CnWSEq45ReNXfyz4M7J05BZrcyHV
         0fOeDkbRQkZpVUfsNhCD3yti3ago9xdi2A1J5WyRT/mIEaf3lzq/s65gPyHrQ0h5wfjq
         UrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T4uaLnmGYN+kYe5AHxlzlMAMFUkG2Bkm42rN+k3sro0=;
        b=4W7TzWr1xeWdCy+4yijk4y6IKqV4MVrmjeGYO7tkcJOEDuPZhrW6pE1O4uXW5bO70j
         eJ6Igii2L1fcBkOBZuKFOQI9NAH0xBDQaITDgIXrrPFm9rw84fOLQ2Oin5bP+ZfEwsO0
         V6rZ5EAgVwmf3ghN67ATe1OquOTp/9bPbHnbaCHqZ7gdzxjAFb0NfgwKahgbeIf+VzIH
         XiAkJ4T3A7gUMnj9s3EhDgUCTvkwehRq0y8AbeUjRbIMTCXa8iG/gm66uePXYAvASgf0
         H67ahOKneplsxXy8fLQCyjlz7UPg0XVMzKh4j10YvvezdFmPrCeFFNCR2v4zrhoOxhf4
         QvnQ==
X-Gm-Message-State: AJIora8TtCxd83q8zhJEgcVk54/aOdl0ycdIBOjeLzhgLoj/rryEJtVh
        Yau/bwfwKpwhBTk88YZsjttErjyY+MmcThlQQr0=
X-Google-Smtp-Source: AGRyM1vg9EbjtF5sfeCHQ8YA6MOyp2OPLYLc1esgd5mDCEAh6gZ3Fv/Ux72gwRsT7dg0MdO9pB9sqigU+7ZBF5h5Few=
X-Received: by 2002:a05:600c:190c:b0:3a3:4293:3710 with SMTP id
 j12-20020a05600c190c00b003a342933710mr15096194wmq.81.1658852551449; Tue, 26
 Jul 2022 09:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local> <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
 <YryKCl5J1Em89d3e@nand.local> <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
 <Yr0WLebMfBXZ1K7D@nand.local> <Yr0XMWWyD5C9uhlb@nand.local>
 <da675dd2-c9cf-c3b4-0231-58b3cf3ce9d7@gmail.com> <220720.86cze0um88.gmgdl@evledraar.gmail.com>
In-Reply-To: <220720.86cze0um88.gmgdl@evledraar.gmail.com>
From:   Gregory Szorc <gregory.szorc@gmail.com>
Date:   Tue, 26 Jul 2022 09:22:19 -0700
Message-ID: <CAKQoGakMtqFW3FR3WqaKrX4P_xbjq2-KceD4ScnVc0-D=-3X=A@mail.gmail.com>
Subject: Re: Race condition between repack and loose-objects maintenance task
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 3:12 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Jul 19 2022, Gregory Szorc wrote:
>
> > On 6/29/2022 8:23 PM, Taylor Blau wrote:
> >> On Wed, Jun 29, 2022 at 11:19:09PM -0400, Taylor Blau wrote:
> >>>> However, I think there is yet another bug at play: running
> >>>> `incremental-repack` appears to be able to repack the cruft packfile=
.
> >>>> In doing so, it deletes its .mtimes file and the metadata inside.
> >>>
> >>> That sounds like a bug to me. I'll take a look into it and see what I
> >>> can find.
> >> I actually think that there are two bugs here.
> >> One is that we run a MIDX repack and expire, which could lead to us
> >> repacking the entire contents of the cruft pack and then expiring the
> >> metadata file. This is a bug, and we should exclude cruft packs from
> >> this computation.
> >> Another bug can happen when the cruft pack gets written into the
> >> MIDX
> >> and is MIDX-expireable (meaning that no objects are selected from the
> >> cruft pack). In that case, the `git multi-pack-index expire` step woul=
d
> >> remove the cruft pack entirely, which is also incorrect.
> >> I'll take a look at fixing both of these, and thanks for pointing
> >> them
> >> out!
> >
> > For posterity, when I disabled cruft packfiles after having it enabled
> > for a few weeks, the next `git gc` invocation on a high traffic repo
> > resulted in >100k loose objects/files being created before they were
> > summarily deleted by the GC's prune. This is significantly greater
> > than the unreferenced object creation rate of the underlying repo. So
> > it appears as if the MIDX stripping of the cruft packfile mtimes
> > effectively disabled pruning, leading to a build-up of unreferenced obj=
ects.
> >
> > Fortunately I hadn't deployed cruft packfiles to production. If I had,
> > the excessive filesystem churn on NFS would have caused an incident
> > due to degraded performance.
> >
> > Since the interaction between cruft packfiles and MIDX appears to be
> > buggy, I think I'm going to leave cruft packfiles disabled until these
> > features work better together.
>
> I haven't looked deeply into whether there's any cruft packfile & MIDX
> interaction at play here, but I suspect based on past experience that
> this has nothing whatsoever to do with the MIDX.

Taylor seemed to acknowledge a bug here a few posts back. Essentially:

1. Cruft packfile created
2. MIDX repack and expire treats the cruft packfile as a regular pack
and folds its content into a new, regular packfile, deleting the
mtimes file/metadata in the process.

I don't fully grok the mechanism, but I believe the loss of the mtimes
metadata effectively results in indefinite retention of unreferenced
objects.

>
> It's because git suddenly found a bunch of objects that should be
> evicted from the packs, as you disabled the cruft pack feature.
>
> Here's a past test-case & report of mine where I ran into that:
>
>     https://lore.kernel.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/
>
> That was way before cruft packfiles were integrated, but from my
> understanding of how they work the mechanism is exactly the same.
>
> I.e. in that case I deleted a bunch of refs (tag objects), which caused
> those to become unreferenced, so on the next "gc/repack" they were all
> evicted from their respective packs, at which point the "gc.pruneExpire"
> clock started ticking for them.
>
> Whereas in your case you disabled "cruft packs", which are basically a
> mechanism where git keeps such "unused" objects in a pack. Once you
> disabled it git stopped considering the new *.mtimes file, and started
> extracting these loose objects en-masse.
>
> Which b.t.w. is something I think we might want to reconsider. I.e. we
> just pass "--cruft" to pack-objects (see b757353676d
> (builtin/pack-objects.c: --cruft without expiration, 2022-05-20)), but
> don't have a "write cruft" v.s. "read cruft" setting (but see below).
>
> The one thing that gives me pause here is your mention of "summarily
> deleted by the GC's prune". Did you run "git prune --expire=3Dnow"
> manually, or do you have a really aggressive "gc.pruneExpire" setting?
> It's also posible that I'm entirely misunderstanding this whole thing...
>
> Anyway.
>
> Since that 2018-era post of mine I've thought a bit about how to best
> handle this particular edge case.
>
> I think the simplest implementation that would work well enough would be
> to teach "git repack" to limit how many objects it's willing to extract
> from a pack. I.e. we'd have the amount of "unreachable" objects we'd be
> willing to eject from the pack limited, with check similar to how
> "gc.auto" works (i.e. once we reach the limit we'd implicitly turn on
> "--keep-unreachable").
>
> It's far from perfect, and e.g. if the N objects you're extracting
> happen to delta-compress particularly well you could still have cases
> where e.g. a 1GB repo becomes a 10GB one with the new loose objects.
>
> But it would allow us to limit the common case where we'd e.g. create 1k
> new loose objects, not 100k or whatever.
>
> It does have the downside that unless you'd disable that limit the "gc"
> -> "gc.pruneExpire" window would become even more fuzzy. I.e. now if you
> run "gc" the clock starts ticking right away, after this the clock would
> start ticking whenever we happened to extract those objects.
>
> So there's certainly less dumb ways to do this, and we'd need to make
> sure that whatever limit we set is aggressive enough that we'd always
> "stay ahead". I.e. if a repo just has a very high creation rate of
> objects that become unreachable we'd need to ensure that we wouldn't
> have an ever growing .git as our eviction rate wouldn't keep up with our
> additions.

I agree this is a hard problem! In my case, the underlying repo sees a
few thousand pushes daily. This results in ~30k new unreferenced
objects on a typical workday. With NFS/EFS, we've observed that the
entire filesystem can get slow once object loosening has written as
few as a few thousand files. Given our high volume, I worry that
imposing a loose object creation ceiling will perpetually throttle and
we'll accumulate unreferenced objects indefinitely.

> For cruft packs (this is a continuation of the "see below" above) we'd
> do the same thing, but could benefit from knowing that such objects are
> "already expired", so we could read the *.mtimes, and possibly expire
> some right away.

I don't fully grok how pruning works in a cruft packfile world. My
naive hope is that the process creating the cruft packfile is able to
elide expired objects so we don't even bother with them during cruft
packfile generation. (It seems inefficient/avoidable that we write an
expired object - loose or cruft packed - from the context of a gc only
to delete it moments later.)

> Aside from some very obscure use-cases I think these these sort of
> "loose explosion" are one-off events, so if we can smooth those out. The
> various gc.* settings can be hard to reason about, but we really do try
> to be gently by default, but notably fail very badly at that in some
> known edge cases, such as this one.

I agree that my scenario of creating an explosion of loose objects is
a one-off. IMO not worth spending too much time thinking about. That
being said, ~daily pruning on a large enough repo starts to resemble
these one-off events. And I think you need something like cruft
packfiles to mitigate it. if cruft packfiles are ever enabled by
default, it may have a nice side-effect of preventing these one-offs!
(But again, I don't grok how pruning works in a cruft packfile world.)
