Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1B8C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF3664E5F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhBQTOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhBQTOd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:14:33 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB345C061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:13:52 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z32so10356637qtd.8
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ikj45vDcWvH5s0g8whoN2Tb8Mdk0lGkB23/O0TMa7Mo=;
        b=SMV4v6I0sK6VA0RCocPgQLS+KzxSjdd4GOl0sTvFV2bfca4VDtyxjcc8JgnyThf/fh
         1Yq0G6Y/7L0PU/JNGA7fnpLXn9C8hEvNlv9o02i5uAh2/WINA+Y9wD9M13mpUYKvVkRA
         Uaxa5daq1boLyAcCj7PSf37Qe6fNB48vtB/wsr5gf2QrHZm6Z14YNZEShx2aB0pKyPnH
         +WUQmHk4cfSiYZCbrq4n+zf3h15XUKaFRxBfGJco2X80CdQkGFM2wfFt/bdRPhWOBAQ2
         xMqDV9rRwR8cPqD4QxQrrQo5KYyXn+ymMj+F+PR1VLkuYrHiUBAxbTACpjkSA9vPHc3n
         zcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ikj45vDcWvH5s0g8whoN2Tb8Mdk0lGkB23/O0TMa7Mo=;
        b=JkmvF0dfoo3hwFV3UK+lF7JeAfBVw+/R4Yb0vfl6S3Jr44qZdT9Vcz2mbtHOgsyd51
         yK9Vwslxr1KPfNEKy9VJBAwkt/UbP+oBxgumj7REk5s0BrmJqGhLMH8MHQzdeuHBCUk1
         YNdvc8UBzLfeCgfWA/aRPPnxF2gZTpHmhxzgVziHRlJASqiqzSecwLcohOk4Xm9KuAZT
         NRAttxStIuY100ytoYbFvY7CWBqAfEkknE2Xm2Ywr7Xk+LUfda77zk4iCDlLBlcyGxd7
         MbJIvETxmxHd978bidYLMZrxV44+kRW4EtZascs/eLwHTfMWaJDG+EanJKy5rGiBEEqJ
         tr6g==
X-Gm-Message-State: AOAM532WMhgs9O8LR3ugtY2ERfL9UaA7HG7O+9p4YPAcNWKR8nFSGQY4
        fZ+TbnVkjrOnsTtx6kOQ80zM2w==
X-Google-Smtp-Source: ABdhPJydhPR8h4o6Ow+bmZZIrz8PvcZs5zAy6obeWzCaIcLewc1kocgpfQNBNHq1oPycNx2gMs85Kg==
X-Received: by 2002:a05:622a:18d:: with SMTP id s13mr783837qtw.52.1613589231785;
        Wed, 17 Feb 2021 11:13:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:aeda:db8b:7233:8f54])
        by smtp.gmail.com with ESMTPSA id x14sm435145qtq.47.2021.02.17.11.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:13:51 -0800 (PST)
Date:   Wed, 17 Feb 2021 14:13:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 5/8] p5303: measure time to repack with keep
Message-ID: <YC1q64fQxHBMxmyw@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <b5081c01b53beb568ef2e59956d25b36be9f24d0.1612411124.git.me@ttaylorr.com>
 <YCxcGKo7kyLwVvw+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCxcGKo7kyLwVvw+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 06:58:16PM -0500, Jeff King wrote:
> On Wed, Feb 03, 2021 at 10:59:13PM -0500, Taylor Blau wrote:
>
> > From: Jeff King <peff@peff.net>
> >
> > This is the same as the regular repack test, except that we mark the
> > single base pack as "kept" and use --assume-kept-packs-closed. The
>
> I don't think that option exists anymore. I guess we are just using
> --stdin-packs, which causes us to mark a pack as kept.
>
> I think we could just mark it in the filesystem and use
> --honor-pack-keep, which would make it independent of your new feature.
> At first I was going to say "but it doesn't matter either way", but...
>
> > theory is that this should be faster than the normal repack, because
> > we'll have fewer objects to traverse and process.
> >
> > Here are some timings on a recent clone of the kernel. In the
> > single-pack case, there is nothing do since there are no non-excluded
> > packs:
> >
> >   5303.5: repack (1)                          57.42(54.88+10.64)
> >   5303.6: repack with --stdin-packs (1)       0.01(0.01+0.00)
> >
> > and in the 50-pack case, it is much faster to use `--stdin-packs`, since
> > we avoid having to consider any objects in the excluded pack:
> >
> >   5303.10: repack (50)                        71.26(88.24+4.96)
> >   5303.11: repack with --stdin-packs (50)     3.49(11.82+0.28)
> >
> > but our improvements vanish as we approach 1000 packs.
> >
> >   5303.15: repack (1000)                      215.64(491.33+14.80)
> >   5303.16: repack with --stdin-packs (1000)   198.79(380.51+7.97)
> >
> > That's because the code paths around handling .keep files are known to
> > scale badly; they look in every single pack file to find each object.
>
> Well, part of it is just that with 1000 packs we have 20 times as many
> objects that are actually getting packed with --stdin-packs, compared to
> the 50-pack case. IIRC, each pack is a fixed-size slice and then the
> residual is put into the .keep pack. So the fact that the time gets
> closer to a full repack as we add more packs is expected: we are asking
> pack-objects to do more work!

No, the residual base pack isn't marked as kept on-disk. But the
--stdin-packs test treats it as such, by passing '^pack-$base_pack.pack'
as input to '--stdin-packs' (thus marking it as kept in-core).

> For showing the impact of the optimizations in patches 7 and 8, I think
> doing a full repack with --honor-pack-keep is a better test. Because
> then we're always doing a full traversal, and most of the work continues
> to scale with the repo size (though obviously not the actual shuffling
> of packed bytes around). That would get rid of the weird "no work to do"
> case in the single-pack tests, too.

I think you're suggesting that we change the "repack ($nr_packs)" test
to have the residual pack marked as kept (so we're measuring time it
takes to repack everything that _isn't_ in the base pack)?

That would allow a more direct comparison, but I think it's loosing out
on an important aspect which is how long it takes to pack the entire
repository. Maybe we want three.

What do you think?

> -Peff

Thanks,
Taylor
