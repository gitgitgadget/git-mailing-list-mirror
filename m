Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC8BC43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5642074D
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DzzM8ylu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgIETtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgIETtb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:49:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9014BC061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:49:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o5so9545628qke.12
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=h2yXzuGkZL6hX9Dw9d6UZ7NwmtwQj23V2uwE/HYPMsQ=;
        b=DzzM8ylueK8dg9EW0AA63MYf4rpfkNnQCvX5Xn/moABw9mlydT6mlCocJj5wxXUptO
         5nH5pUxgS4pey7w8Uapa5g0/6Q+lJXll1r9h2Qp8RNKASHvqZ/JVmbteSy01Wy5Cqz07
         VPGCjRwJyedL7ruTx1BFzbFTcjnCqvbxVBNyZokg/fIXclpqn5aC81DVm+yRYWU7YNL8
         WI0hD2qWCi10Aq8WCblH9+BZjHKOLYV7RJ9rr9sPFegSkIq9I6rQ67l4mn3XhV6PRzaV
         MiuP6cS0NLOunOAO2CxkLnlECPEFd+QPOKKOjM3VumYBwvMn/OYr16TeuBfgM00xY1se
         xq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h2yXzuGkZL6hX9Dw9d6UZ7NwmtwQj23V2uwE/HYPMsQ=;
        b=jRoX/ixZIabXOELdCqhdGH+g76/iQzdVk7CEdE+EAab9+IeUxF4Hv9DkCdLEyRXOxM
         tZzHMEhUtOszORjn9/769AaQG5TQoopbKR1LkpIadD3xrMndHTF+Biek0rPik0SA1vO8
         SF0S0MZ0Zm5CBoxRSq0ut5i32GEB5Ts6pdipXSNLAi+BcL6SogUhtvz2PtU9arvccx9z
         f6dSsyiFfa+SLr9DsjpciGdzT3Lt+Z/c6pzIfaCPQypMbEQrG+2grP/KhgIJb7dicQfU
         0j/Jddez56PJbTdIIpEOoSUeS7Y9np78Yh754gJORv2QJX98oxUgL8yfdnwBJrNic2Qa
         0IBA==
X-Gm-Message-State: AOAM532FgNHJZpZ18aAY14G+8R9WFfWWJmNM4FMOvxZ8dROG9bcwPZNA
        WTM/fosNVTfcSJ2VSPjHLywQrw==
X-Google-Smtp-Source: ABdhPJzaR2ssEqFxhhlBZeNDkIgogRQvNgHTpEMjUnt+AovurapqRvyptORzZWHQUFny7ELZeEemAw==
X-Received: by 2002:a37:745:: with SMTP id 66mr13069232qkh.344.1599335370443;
        Sat, 05 Sep 2020 12:49:30 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f423:2c6a:683a:2c57])
        by smtp.gmail.com with ESMTPSA id d9sm7762286qtg.51.2020.09.05.12.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:49:29 -0700 (PDT)
Date:   Sat, 5 Sep 2020 15:49:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        git <git@vger.kernel.org>, Junio Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 07/14] bloom: split 'get_bloom_filter()' in two
Message-ID: <20200905194926.GA7964@nand.local>
References: <cover.1599172907.git.me@ttaylorr.com>
 <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
 <85h7sc9m0v.fsf@gmail.com>
 <20200905173825.GA6820@nand.local>
 <CANQwDwcWveN03h=Ex0GFo-Mm89UT8_HXFMQcZWdDx9MPZYYodQ@mail.gmail.com>
 <20200905180120.GB6820@nand.local>
 <CANQwDwcD5XD3e7ar=8HPupobOZGDN4bgQJBS1Ad1m2NDx8eurw@mail.gmail.com>
 <20200905183854.GC6820@nand.local>
 <20200905185534.GA7416@nand.local>
 <20200905190449.GB6209@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905190449.GB6209@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 05, 2020 at 09:04:50PM +0200, SZEDER Gábor wrote:
> On Sat, Sep 05, 2020 at 02:55:34PM -0400, Taylor Blau wrote:
> > On Sat, Sep 05, 2020 at 02:38:54PM -0400, Taylor Blau wrote:
> > > I don't know. I think my biggest objection is the size: we use the BIDX
> > > chunk today to avoid having to write the length-zero Bloom filters; your
> > > scheme would force us to write every filter. On the other hand, we could
> > > continue to avoid writing length-zero filters, so long as the
> > > commit-graph indicates that it knows this optimization.
> >
> > Thinking about it a little bit more, I'm pretty sure that this isn't as
> > easy as it sounds. Say that we:
> >
> >   - continued to encode length-zero Bloom filters as equal adjacent
> >     entries in the BIDX, but reserve the length-zero filter for commits
> >     with no changed-paths, _or_ commits whose Bloom filters have not yet
> >     been computed
>
> No, use zero-length filters for commits whose Bloom filters have not
> yet been computed, and use a one-byte all zero bits Bloom filter for
> commits with no modified paths.
>
> And this is exactly what I proposed earlier.

Fair enough, I bet that would work.

Junio, let's eject this series while I try to see if SZEDER's idea is
workable.

> > I don't see a non-convoluted way to split the overloaded length-zero
> > case into something that is distinguishable without a format extension.
>
> See above, no format extension needed.

Where?

Thanks,
Taylor
