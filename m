Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F8BC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 09:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiKGJBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 04:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGJBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 04:01:07 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADC12AFA
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 01:01:04 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id y186so8135312yby.10
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 01:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=65pE1IWD1p/LsJxkUJ1KQeTYNvEXd0qorzjU6mMqCKM=;
        b=Ua+SfFl4w32TRV1NyaZNiE3W0K3aD9fVbRb83EFOivtYHqas0yPx+w2ks9zgLJcQXh
         usuZ7bESQHxG78/ts+H0vGBfQ6GzVLksfXpJMvaVk5qymhXTBwtkoMdQlHlqxi91jof1
         YK2zWsEsMFG0dxAYOZtPpmyLc+Fheeqd0TIixDmqHkVfRyKpi11giAA04mP/kiWQeILd
         I6KJ4nAHYV8E3nNRjvap2eeuQfK3oCFuWEq2DF1givm2dwujERnbpnma27TvRjQrxw+7
         ZMtVeQ6HNlXTNctaStmxQtuNbOuZep2BCYv7H+A4DwEwPtuvAzr11dCOs+AnJbxqOY1U
         jTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65pE1IWD1p/LsJxkUJ1KQeTYNvEXd0qorzjU6mMqCKM=;
        b=4bovcr2M/GvFjTURik1A0znfEdDF0dl0Yq6Qw3mHNtiYBlUhn5omNCc7qxHVBvFByp
         TCpe4qoIxPMBYzkF3mf/yPB3DQoUHgX6cdLzI8By4zgQISW0vNe/Jjo5Mphjw4fPT0ME
         XcLCnsplNqmu25rMNunm3nWaje/sKgwZKZJZ0MWmiNWffPNW59ekOk5qBliWXbyp0NXB
         u4xBEV1xi2TQ5xjlpXfYRnhVSvuPp/TNmNHFveHK7tnUGisZrtERxlyD/4tNxpc+FB+W
         EA1EKRuF7A7OF/SOYfYA+oq7aFx9MX+1Ru0M/1l89S1tzGCmvhJ6+B7VF8u4IrZRFIA/
         Mswg==
X-Gm-Message-State: ANoB5pkBP1rZVIC0w315eRf8M8SzyNiFRoWjGqw63noMQbPRRPLaagcR
        zQsA60H3w6vT9bKyJTXT2zNWlltGPpmhOoglMbfE5YASXq0=
X-Google-Smtp-Source: AA0mqf7skvSFIObXJV1fuoEptddVMCHE/uIbL0KQXZTI05qTIfFOLN62vgdbtXiriGhySoLHLqfy78U3TDC7R7FzXDY=
X-Received: by 2002:a25:40ce:0:b0:6d5:34ad:10c5 with SMTP id
 n197-20020a2540ce000000b006d534ad10c5mr9687443yba.494.1667811663533; Mon, 07
 Nov 2022 01:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <xmqqilkm9wv6.fsf@gitster.g> <CAP8UFD2HX6rK4TRP6ynUzWn4eoHa1FrbiFOtxBaxX-ZkBF3FJw@mail.gmail.com>
 <Y1wyVpHprWGxEDi/@nand.local>
In-Reply-To: <Y1wyVpHprWGxEDi/@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Nov 2022 10:00:52 +0100
Message-ID: <CAP8UFD31vHzV6fmvXLPadVFk3a_-MHgfQGUnO6tAftQxu7KE0w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Implement filtering repacks
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 9:49 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Oct 20, 2022 at 01:23:02PM +0200, Christian Couder wrote:
> > On Fri, Oct 14, 2022 at 6:46 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Christian Couder <christian.couder@gmail.com> writes:
> > >
> > > > For example one might want to clone with a filter to avoid too many
> > > > space to be taken by some large blobs, and one might realize after
> > > > some time that a number of the large blobs have still be downloaded
> > > > because some old branches referencing them were checked out. In this
> > > > case a filtering repack could remove some of those large blobs.
> > > >
> > > > Some of the comments on the patch series that John sent were related
> > > > to the possible data loss and repo corruption that a filtering repack
> > > > could cause. It's indeed true that it could be very dangerous, and we
> > > > agree that improvements were needed in this area.
> > >
> > > The wish is understandable, but I do not think this gives a good UI.
> > >
> > > This feature is, from an end-user's point of view, very similar to
> > > "git prune-packed", in that we prune data that is not necessary due
> > > to redundancy.  Nobody runs "prune-packed" directly; most people are
> > > even unaware of it being run on their behalf when they run "git gc".
> >
> > I am Ok with adding the --filter option to `git gc`, or a config
> > option with a similar effect. I wonder how `git gc` should implement
> > that option though.
> >
> > If we implement a new command called for example `git filter-packed`,
> > similar to `git prune-packed`, then this new command will call `git
> > pack-objects --filter=...`.
>
> Conceptually, yes, the two are similar. Though `prune-filtered` is
> necessarily going to differ in implementation from `prune-packed`, since
> we will have to write new pack(s), not just delete loose objects which
> appear in packs already.

Yeah, that's why I say `prune-filtered` will call `git pack-objects
--filter=...`.

> So it's really not just a matter of purely deleting redundant loose
> copies of objects like in the case of prune-packed. Here we really do
> care about potentially writing a new set of packs to satisfy the new
> filter constraint.

Yeah, I agree.

> Presumably that tool would implement creating the new packs according to
> the given --filter, and would similarly delete existing packs. That is
> basically what your implementation in repack already does, so I am not
> sure what the difference would be.

Indeed, there wouldn't be much difference implementation wise between
a new `git filter-packed` command like Junio suggested and the current
implementation I sent which implements the feature in `git repack`. (A
new `git filter-packed` would just duplicate the repack features that
are needed and just call `git pack-objects --filter=...`). That's why
I don't really see the point of a new `git filter-packed` command and
the version 2 I sent still implements the feature in `git repack`.

So I have a hard time understanding your comment unless you just agree with me.

> > Yeah. So to sum up, it looks like you are Ok with `git gc
> > --filter=...`  which is fine for me, even if I wonder if `git repack
> > --filter=...` could be a good first step as it is less likely to be
> > used automatically (so safer in a way) and it might be better for
> > implementation related performance reasons.
>
> If we don't intend to have `git repack --filter` part of our backwards
> compatibility guarantee, then I would prefer to see the implementation
> just live in git-gc from start to finish.

About the implementation living in `git gc` I wrote the following:

>>> `git gc` is already running `git repack` under the hood in a number of
>>> cases though. So running `git gc --filter=...` would in many cases
>>> call `git pack-objects` twice, as it would call it once through git
>>> repack and once through `git filter-packed`. Or am I missing something
>>> here?

Even if we don't have a `git filter-packed` command, if the feature is
implemented in `git gc` (but not in `git repack`) it would just call
`git pack-objects --filter=...` from there, which means that `git
pack-objects` would be called twice (once through `git repack` and
once for this new feature) by `git gc` in some cases, instead of just
once if the feature was implemented in `git repack` as `git gc` could
then just calls `git repack ... --filter=...` once.

That's why I think it's better for performance reasons if the feature
is implemented in `git repack`. If you don't want for some reason to
have `git repack --filter=...` part of our backwards compatibility
guarantee, then --filter can be a hidden and undocumented option in
`git repack`. Or maybe we could use a new env variable to instruct
`git repack` to pass some --filter option to `git pack-objects`, but
my opinion is that it's much simpler to just accept --filter to be a
regular, though dangerous, `git repack` option, and then add --filter
to `git gc`.

I am also Ok with adding --filter to `git gc` in this patch series and
have the doc say that it's better to use `git gc --filter` instead of
`git repack --filter` so that users could learn right away to use the
feature through `git gc` instead of through `git repack`.
