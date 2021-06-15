Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F12C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 07:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAE261428
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 07:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhFOHxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 03:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhFOHxb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 03:53:31 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3E9C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 00:51:27 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id d19so13254103oic.7
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=IApKMdmkCsF1Q89S3tjZlNIve73FHAb21fLbO5YE+ZA=;
        b=eBQiVXXDiY/OLSfxuAvgU/+LBqwBA61pRyy24ab9z/vUUliY8cclC7Ql5LLTy2W5CI
         xvCoHxE4St7lvF03/sTistc3Mc+m2lBJZiFyQWjx2L3C87Qo874+WkE7B3EmgmCQNcmQ
         u8JXR3L2XCB1Gr0gClQmxnqsWsblrqDh2yPks2i/rzMq+mHy7feaNred2XRz7oJqGCjK
         BbgbmXhrvd/FjqLWRWtPbgexX1SCsb7/wXcMgpFtCBG8WzEd9jzjLaS7+hunAuSwNmvh
         nVlmdQrSZnJOSVWs1rqaONzbZ/CY9iUscLQ85Tgizy9ck+yUBTrtc6HfGnkG8AFmUkAq
         GuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=IApKMdmkCsF1Q89S3tjZlNIve73FHAb21fLbO5YE+ZA=;
        b=YCAV/GgKr1RHy1G2haiA4iWWN6kwgQyLMELpUU4leH7i0+vQYCMhbVh9W/Xpf8Y5KP
         3+ZAOKyLmPPHOWjDK0i8Vne0kQ7Rr1J1V80X3i041KMhOXKtk5OgfE+dFYX/JtcaZ/Ok
         RqvMnV5w2RyYtOB3dCsjxZywjEHbWIHXJikZ+ga4ygRSv2rx1gOKYv7xAd3OhI3KF2Vu
         Di+VOqVkLHp0HrSwHqAmdQZzqWJSmKnv3cwczxpOhuIENeFXb8sXu4cJksoUoOpc4P9V
         jJq41ek6Ar/CXp8GzPkap1HCXUG0/NomZcYg8ziVL7y2bG5FLIjR5B0c7IsYP7o79p0j
         5TSA==
X-Gm-Message-State: AOAM530n+goJOgXbWbzQv4avLZHu+whpaegkOoJ5DdCjFLMngB4bYZXJ
        9+xM3qb5mygyLJVgDpEND8w=
X-Google-Smtp-Source: ABdhPJyqmeyXkOOgYVET3iMRdR5D//7tkJGnkLcm7NF9Km2R5B1Ln3vDJZW8nxgxfL/ZygAGWA/MgA==
X-Received: by 2002:aca:1201:: with SMTP id 1mr2259236ois.6.1623743486881;
        Tue, 15 Jun 2021 00:51:26 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x199sm3467036oif.5.2021.06.15.00.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 00:51:26 -0700 (PDT)
Date:   Tue, 15 Jun 2021 02:51:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60c85bfd112a9_e633208d5@natae.notmuch>
In-Reply-To: <CABPp-BGZ2H1MVgw9RvSdogLMdqsX3n89NkkDYDa2VM3TRHn7tg@mail.gmail.com>
References: <20210613225836.1009569-1-felipe.contreras@gmail.com>
 <20210613225836.1009569-5-felipe.contreras@gmail.com>
 <CABPp-BGZ2H1MVgw9RvSdogLMdqsX3n89NkkDYDa2VM3TRHn7tg@mail.gmail.com>
Subject: Re: [PATCH 4/4] xdiff/xmerge: fix chg0 initialization
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Sun, Jun 13, 2021 at 4:04 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > chg0 is needed when style is XDL_MERGE_DIFF3, xdl_refine_conflicts()
> > currently is only called when level >= XDL_MERGE_ZEALOUS, which cannot
> > happen since the level is capped to XDL_MERGE_EAGER.
> >
> > However, if at some point in the future we decide to not cap diff3, or
> > introduce a similar uncapped mode, an uninitialized chg0 would cause a
> > crash.
> 
> If this cannot happen now, and is needed by your other posted patch,
> why aren't these two patches either combined or posted as part of the
> same series?

Because I found the fix *after* I sent the patch, and after Jeff posted
a way to reproduce the issue he experienced in the past.

v2 of the series has the fix included, but I was waiting for feedback on
v1.

> (I think a separate submission _only_ makes sense if you
> explicitly withdraw the other patch from consideration, otherwise it
> feels dangerous to submit patches this way).

More than 50% of my patches get either completely ignored, or commented,
and then ignored. The vast majority of them don't have a valid reason
for rejection.

I thought this series had a better chance of being merged before the
zdiff3 series, and the chg0 is orthogonal to the zdiff3 series anyway
(in my view).

Plus, I don't see the harm in sending the same patch in two different
series. Especially if the chances of both series being merged any time
soon is very low.

> > Let's initialize it to be safe.
> 
> Is it being safe, or is it hacking around a hypothetical future
> segfault?

It's being safe.

> Are these values reasonable,

I spent about two hours of my own free time--with no corporation backing
up my git work--to familiarize myself with the code and the values are
as reasonable as I could make them.

If m->chg0 is 0, xdl_orig_copy will ignore the chunk, so m->i0 is
irrelevant, but just to be consistent I copied the original i0.

Once again: the only value that matters is m->chg0, and it's completely
safe to set it to 0.

Much more reasonable than garbage, like
1774234 which we currently have sometimes.

> or did you just initialize them to known garbage rather than letting
> them be unknown garbage?

No.

> Are there other values that need to be changed for the xdiff data
> structures to be consistent?

No.

> Will future code readers be helped by this initialization,

Yes.

> or will it introduce inconsistencies (albeit initialized ones) in
> existing data structures that make it harder for future readers to
> reason about?

No.

> I'm somewhat worried by the cavalier posting of the zdiff3 patch[1],

When Uwe sent the patch [1] nobody said it was a "cavalier posting".
Jeff King said "I think the patch is correct".

> and am worried you're continuing more of the same here, especially
> since in your previous post[2] you said that you didn't know whether
> this particular change made sense and haven't posted anything yet to
> state why it does.

Nobody pays me to work on git. I comment when I have time. Yesterday was
my birthday and I spent my free time doing other things.

When I sent that mail it was "Sun, 13 Jun 2021 16:24:50 -0500", when I
sent the patch it was "Sun, 13 Jun 2021 17:58:36 -0500". After spending
more than an hour and a half reading the code, and trying different
approaches I became more confident that there was no better approach. At
least not one that was easily found.

I am 99% certain that m->chg0 = 0 is safe, and produces a reasonable
output.

What I didn't know at 16:24 is if there was something better we could
do. But by 17:58 I became much more certain that there wasn't, although
I'm still not sure.

Degrees of confidence vary with time.

> Peff already pointed out that you reposted the zdiff3 patch that had
> knonw segfaults without even stating as much[3].

He knew that. I didn't.

> That's one thing that needs to be corrected, but I think there are
> more that should be pointed out.  Peff linked to the old thread which
> is how you found out about the patches, but the old thread also
> included things that Junio wanted to see if zdiff3 were to be added as
> an option[4],

That thread included many things, including links to other threads.

> and discussed some concerns about the implementation that would need
> to be addressed[5].

That link is a mail from Jeff stating that he disagrees with Junio in at
least one point, and said:

  But again, we don't do this splitting now. So I don't think it's
  something that should make or break a decision to have zdiff3. Without
  the splitting, I can see it being quite useful.

> Given the fact that Peff liked the original zdiff3 patch and tried it
> for over a month and took time to report on it and argue for such a
> feature, I would have expected that when you reposted the zdiff3 patch
> that you would have provided some more detailed explanation of how it
> works and why it's right (and included some fixes with it rather than
> separate),

I didn't want to override Uwe's wording, especially since both Junio and
Jeff often complain about my commit messages, and it isn't rare that
they end up rewritten.

> and that you would have included multiple new testcases to the
> testsuite both to make sure we don't cause any obvious bugs and to
> provide some samples of how the option functions,

It is not uncommon for v1 of a patch series to be missing something.
Uwe's patch series [1] did not include tests either, and nobody focused
on that. It is completely reasonable to assume that a reboot of the
series wouldn't initially focus on that either.

That being said, I did test zdiff3 with the whole testing framework, and
I did explain how.

> and also likely include in the cover letter some kind of explanation
> of additional testing done to try to assure us that the new mode is
> safe to use (e.g. "I ran this on hundreds of linux kernel commits,
> with X% of them showing a difference.  They typically looked like <Y>"
> or "I've run with this for a month without issue, and occasionally
> have re-checked a merge afterwards and found that the conflicts were
> much easier to view because of...").

I typically don't send cover letters for single patches (just like Uwe
didn't [1]), but I did add an explanation of what tests I ran below the
commit message of the patch, as is customary.

> Short of all that, I would have at least expected the patches to be
> posted as RFC and stating any known shortcomings and additional work
> you planned on doing after gathering some feedback.

I had not planned to do any additional work, as I don't usually plan how
I spend my free time. I happened to have free time when I saw Jeff mail
about a way to reproduce and I felt motivated to investigate further.
One thing lead to another and fortunately I found the fix quickly
enough.

> You didn't do any of that, making me wonder whether this patch is a
> solid fix, or whether it represents just hacking around the first edge
> case you ran into and posting a shot in the dark.  It could well be
> either; how are we to know whether we should trust these patches?

By assuming good faith [2], and simply asking questions. I don't think
assuming the worst and calling into question the competence of a
contributor is a good approach.


Morevoer, this is not *my* patch, this is a patch from the community, to
the community, and it's in the best interest of the community that it
gets developed *collaboratively*.

I took Uwe's patch and added my two cents, not for me, but for the
community. I don't need zdiff3, I'm perfectly fine with diff3, but I
would like a better default conflict style than merge, for the
community. That's why I spend a considerable amount of time reading the
old threads, and familiarizing myself with the xdiff/xmerge code of
which I basically knew nothing about.

This is something I wish more people did, and then perhaps we wouldn't
need to wait 8 years for a simple crash fix for a feature many people
probably would like, which again, I'm 99% certain is correct.


To be crystal clear: this is not *my itch*, I did the patch
altrusticially for the community. The fix correct--at least to the best
knowledge of everyone involved so far. If you want to deride the hours I
spent working for the community for free which resulted in a patch that
most likely is a net positive, feel free, I think this doesn't help the
community, which needs more of this kind of work, not less.

Cheers.

[1] https://lore.kernel.org/git/1362602202-29749-1-git-send-email-u.kleine-koenig@pengutronix.de/
[2] https://en.wikipedia.org/wiki/Wikipedia:Assume_good_faith

-- 
Felipe Contreras
