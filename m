Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB627C433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 21:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiAZV2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiAZV2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 16:28:50 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7832DC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:28:50 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id ay18-20020a17090b031200b001b53c85761aso2992778pjb.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fLYkfcUoEO+Lzf3amw2wAZoX/2cfnLvZCU4WPXre3TA=;
        b=rnWJfx6odGLrKTxKEeNr43q5AzBT0Z+JmQzD3JDdrvZGWwnmTnnof+XBw6DBHnuzZN
         rdLw5OjFAv4aTuYHXDeBs8uIKhXtp8wIa+b55geVaQ60JhWjjii5/vpWeO9Z36uAt9Xo
         yuB3revhlOcwt4olLEcd/Ctz+Fxnh1NRrVwHzNRerhC+92RPClmF6K202ctuIwPXPeyH
         8KQCQYefA3fI0t6tROieXml+8EDSBHxrOzz7KHreL7dJysMfMKJ/DXq0Rh5XOBRTjb7K
         /wx1WHzUrgR2rHzeQxnR62wzPoNutYx2Gxdh4iAo7Sp01frvLFZxDMkiko/AdgNz0D+g
         2N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fLYkfcUoEO+Lzf3amw2wAZoX/2cfnLvZCU4WPXre3TA=;
        b=I8XNYemFpjYvx4tgMT3IC4OJbcGqzTSXCkZhEcNNNqBBGCSLtHUlsSv+8jI7prv20/
         Kh6i4pxeaIiwY7o8FTYGolQeEj53AhvJJGh6O6cAApj2ZsUI+WUEOarLFVsKlTDoGZrw
         ozH0/Z6Kv3SVGnQuc+JuzlB88GqVdTOdyOLZGSzuNEtD3ZFVD2OnuGf3zgX4d3THIpZ5
         A4s9S9L6qW0RThTMvKJRGP3JP+ZOiPVcnIMPOev/ryVHG7i57CiMGBB/Gp9LEVlaIhrw
         7uudKcYMdFuFauYfG46IPtIV0UORoaecC1KPR4Vte3MS4jwQcKrPTLA7JhoNl8M/Ts7A
         uIUA==
X-Gm-Message-State: AOAM532y5w44Ik+/0sDOrVSFslBchcglOUWvwXnOj2kTXXJV5A0UUBpa
        zM8jmx/udO4MdsH0KqFXgq3qb3X0tHFKHCDnOaRE
X-Google-Smtp-Source: ABdhPJzLCtarh5URjO4V8pLWcniYSW9IdtQlOQ9hSQzLZN8WWddGkFBFxCn0vTFAMFyMHCY6DRjl9XBbrs7IMhVxcCfi
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1891:: with SMTP id
 x17mr364812pfh.73.1643232529977; Wed, 26 Jan 2022 13:28:49 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:28:47 -0800
In-Reply-To: <YfBvXS841To7ZXcp@nand.local>
Message-Id: <20220126212847.2860166-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YfBvXS841To7ZXcp@nand.local>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v3 8/9] midx: read `RIDX` chunk when present
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On Mon, Jan 24, 2022 at 11:27:01AM -0800, Jonathan Tan wrote:
> > > Note that we have two knobs that are adjusted for the new tests:
> > > GIT_TEST_MIDX_WRITE_REV and GIT_TEST_MIDX_READ_RIDX. The former controls
> > > whether the MIDX .rev is written at all, and the latter controls whether
> > > we read the MIDX's RIDX chunk.
> > >
> > > Both are necessary to ensure that the test added at the beginning of
> > > this series continues to work. This is because we always need to write
> > > the RIDX chunk in the MIDX in order to change its checksum, but we want
> > > to make sure reading the existing .rev file still works (since the RIDX
> > > chunk takes precedence by default).
> >
> > Could we disable the beginning-of-this-series test when the MIDX .rev is
> > not written instead? Then, we can test what the user would actually
> > experience (no reverse index in .midx, reverse index in .rev) instead of
> > simulating it by skipping over the reverse index section in .midx.
> >
> > If we can't do that, then I would agree that the approach in this patch
> > seems like the best approach.
> 
> I considered it, i.e., by having the two knobs be:
> 
>     - GIT_TEST_MIDX_WRITE_REV
>     - GIT_TEST_MIDX_WRITE_RIDX
> 
> where the pair (true, false) would correspond to what a corrupt
> repository would look like before this series. But I dislike that it
> allows the caller to alter the MIDX's checksum by controlling whether or
> not the chunk is written.

I think that if the user really wanted to manipulate the checksum by
using an environment variable for Git tests, they could just as easily
do so by using an old version of Git.

> So it's really looking at the same problem from two sides: do you make
> the RIDX chunk disappear by not reading it, or by never writing it in
> the first place? And although the latter is more "accurate", it did
> allow me to sidestep a lot of gory details like the ones I outlined in
> the second patch.
> 
> I don't remember everything fully, since some time has passed since I
> originally wrote this, but I remember encountering some of the races
> where you'd read the old bitmap in the new object order, and other
> annoyances.

I think that feeling the need to avoid the gory details and races in
test is an argument for also avoiding it in production (by not
supporting external .rev files any more), but I've already explained my
opinion on this and will leave it to others to decide.

In any case, I still think that this patch set in its current form is
worth merging - it is a strict improvement over what we had before (the
race condition I'm worried about has been there before this patch set).
