Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0579C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B112360F23
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhGZTzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhGZTze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:55:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF0FC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 13:36:02 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id m13so13497730iol.7
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bCkoNNVI0zGOZoKG03E1pNJtLGeN1u0ud1/5dnbV/xU=;
        b=rXPR0J0gprlb4y80eYGsYJQj10GxTTYWVQ/z2iKE/8FpkvM56UZ2rNMF4ph0EmyjHh
         GO0n0aGRDX4RcoscdqvxXsZbVsDNUwMYdIKPfddtGLJ8oHZ/gJgJykTT0QdDzyW9Cx6q
         GqZspaBA0BENuKAOubai9hKjyeNupuEJdmwUvo7Hvv84Kss/rHh7EEqcdFkFGl9gz5Ln
         rd0ORJDN0G1mqy1zLhflTY5ZLpgjl8gpt4p3VeJz6tSTKs5tMmIz5XR+USlPjbH3+A5A
         6oSpwu131L3zNhRhDzqsWLL3jXTvzOQMbP46kZmZAJdnvlADoM+AiJwMG51yvbhkvSUy
         48kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCkoNNVI0zGOZoKG03E1pNJtLGeN1u0ud1/5dnbV/xU=;
        b=O6poU/HgYlPMcOOqM6pVa6gCZkTLJGg9zSvXQ4ooNjBQOIyNQZkd2mkshQJXuLPQUD
         DVzwHpZNL0YLRl1HNQFEth4Gi/LFYuwMxrHIJKpJ5bBXjTreR4l+IkG3ecpvD1qASPRr
         cicXhhWIt75N80C+ytefTl5JewfKuf1WA49SatSTv3MIfawBaX6RD0X97F0dtTUZEJMU
         6+ZR2AqLAgJlzv2EZXWnItem3P9nzvh3Ks/5laDE4VKM18DBU/Uq5xr2TSESzL6zMJ51
         hFGu9s3ZSaunafIDv3pHyyazV8M0Zs5a5Y4tXsm3VSQKfksxRTDGC1Y2irjhWNARfPMn
         prvg==
X-Gm-Message-State: AOAM5320gdfFsQ4Llxi519Z34JkkHkDKCoIsLBP3py5mKflgEAWFamQW
        fI1/+OGlFoRlcG0MPG/nluj6+A==
X-Google-Smtp-Source: ABdhPJwe0aazQYVYjWQ3be3TLsdhd/Afz6CrDsh6A9Mji4SUkHWPQYWZiitos3LVj5S0SEMCe2XTdw==
X-Received: by 2002:a05:6638:14d6:: with SMTP id l22mr17964584jak.99.1627331761475;
        Mon, 26 Jul 2021 13:36:01 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:18ae:76f8:f6b8:4b88])
        by smtp.gmail.com with ESMTPSA id m184sm567071ioa.17.2021.07.26.13.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 13:36:01 -0700 (PDT)
Date:   Mon, 26 Jul 2021 16:36:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 13/24] pack-bitmap: read multi-pack bitmaps
Message-ID: <YP8csJZ+347qAjOe@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <7d44ba6299c06c956d5ac8ba01a0288d109c3cae.1624314293.git.me@ttaylorr.com>
 <YPgF4X2PeFvBuJXm@coredump.intra.peff.net>
 <YPinPFW50Mj8cVkP@nand.local>
 <YPqTTwqifHIWZRsn@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPqTTwqifHIWZRsn@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 06:00:47AM -0400, Jeff King wrote:
> On Wed, Jul 21, 2021 at 07:01:16PM -0400, Taylor Blau wrote:
> > > > +			if (bitmap_is_midx(bitmap_git)) {
> > > > +				/*
> > > > +				 * Can't reuse from a non-preferred pack (see
> > > > +				 * above).
> > > > +				 */
> > > > +				if (pos + offset >= objects_nr)
> > > > +					continue;
> > > > +			}
> > > > +			try_partial_reuse(bitmap_git, pack, pos + offset, reuse, &w_curs);
> > >
> > > ...and this likewise makes sure we never go past that first pack. Good.
> > >
> > > I think this "continue" could actually be a "break", as the loop is
> > > iterating over "offset" (and "pos + offset" always gets larger). In
> > > fact, it could break out of the outer loop as well (which is
> > > incrementing "pos"). It's probably a pretty small efficiency in
> > > practice, though.
> >
> > Yeah; you're right. And we'll save up to BITS_IN_EWORD cycles of this
> > loop. (I wonder if smart-enough compilers will realize the same
> > optimization that you did and turn that `continue` into a `break`
> > automatically, but that's neither here nor there).
>
> If you break all the way out, then it saves iterating over all of those
> other words that are not in the first pack, too. I.e., if your bitmap
> has 10 million bits (for a 10-million object clone), but your first pack
> only has a million objects in it, we'll call try_partial_reuse() 9
> million extra times.
>
> Fortunately, each call is super cheap, because the first thing it does
> is check if the requested bit is past the end of the pack. Which kind of
> makes me wonder if we could simplify this further by just letting
> try_partial_reuse() tell us when there's no point going further:
>
> [snip suggested diff]

All looks pretty good to me. I think that a goto is a little easier to
read than two identical "if (ret < 0)" checks. And having a comment
makes it clearer to me than the double if statements. So I'm content do
to that instead.

Thanks,
Taylor
