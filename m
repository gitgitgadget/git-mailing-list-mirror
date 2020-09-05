Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A6C43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BCD2074B
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSgzAK00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIETEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgIETEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:04:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A706FC061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:04:53 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a15so12736470ejf.11
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0d8IPSAtA11ORPk6aXbFPeTGwloJEz4ZUKyeEtXhNmU=;
        b=LSgzAK00JQow4EhhJ6yG+zeQUtOk0vOjbYmmJUJgMTWoLrcpGqUQuNaf5HrGMt+534
         mL49DJVJ5SjcvdbyTLIkYQuOgBRgoc0uBOJU4yYsE5yGAqonggL+oXQlq4TDWe1O1kxo
         tZTGu9lW3sU1F2Isx4MPKCXsVwtoMVujULgORiufMKWIysl+n0cwRDQTWn5GYOTtkbRj
         RtWpGY/Q6IlYLPkUHUUtPpePNUGixly6jEOR0BMhnv8WCvjLeilgrHJAfDlfJgSO5dME
         PRb7+icWx0s0gnon56keTlSyARUzVQboJ9gKMO24gavJOm/anL39DypQLtAR/cth7yjP
         Hk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0d8IPSAtA11ORPk6aXbFPeTGwloJEz4ZUKyeEtXhNmU=;
        b=pE7B6+x31yEfcA3jYU0eirZV2yGcPG2SR/SWBpk7dNqc7ipgDgLVCrbGCvp+193YHK
         SaYMISChSopgj3FnYUOQiAee3MYv0dXhk0ORK8g3XBG4MK+AMFF4S9aC6hm7y2gqbY6l
         B+TWrPERUha35VI4q/ipn1I5UAaHKM1CHW0SJ4yQntYK/fF7VcWjOp3DwkENowEX/t/3
         rsoTOtiBiSNmcdudDtFHmv/6vV5TYGKlsLAuH9LVzKqHxVgtTAgE7tQoBZwgVaEUx8Lz
         FxA4086SYflvzeKnh6bm7zLu4/ykguZkmIk7lPEDnM7TBn2yPy7k+/Rb35DCpPKlvHIv
         qOhA==
X-Gm-Message-State: AOAM533fHM0Vh0N/oV49FB63GYlumDdEZSALnMIxx9yLiISgWQURvtw3
        pM3t/WMagMP9zfqzWevRNRo=
X-Google-Smtp-Source: ABdhPJywMv5UyDHWxGwEjwiIP3p46PMTNCLt0xcGns2TO5f/mlzUFbwCBaQaFerYqJKUVDwwR7e/mQ==
X-Received: by 2002:a17:906:258a:: with SMTP id m10mr8082947ejb.122.1599332692395;
        Sat, 05 Sep 2020 12:04:52 -0700 (PDT)
Received: from szeder.dev (84-236-109-131.pool.digikabel.hu. [84.236.109.131])
        by smtp.gmail.com with ESMTPSA id h5sm9688143ejk.41.2020.09.05.12.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2020 12:04:51 -0700 (PDT)
Date:   Sat, 5 Sep 2020 21:04:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        git <git@vger.kernel.org>, Junio Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 07/14] bloom: split 'get_bloom_filter()' in two
Message-ID: <20200905190449.GB6209@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
 <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
 <85h7sc9m0v.fsf@gmail.com>
 <20200905173825.GA6820@nand.local>
 <CANQwDwcWveN03h=Ex0GFo-Mm89UT8_HXFMQcZWdDx9MPZYYodQ@mail.gmail.com>
 <20200905180120.GB6820@nand.local>
 <CANQwDwcD5XD3e7ar=8HPupobOZGDN4bgQJBS1Ad1m2NDx8eurw@mail.gmail.com>
 <20200905183854.GC6820@nand.local>
 <20200905185534.GA7416@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200905185534.GA7416@nand.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 05, 2020 at 02:55:34PM -0400, Taylor Blau wrote:
> On Sat, Sep 05, 2020 at 02:38:54PM -0400, Taylor Blau wrote:
> > I don't know. I think my biggest objection is the size: we use the BIDX
> > chunk today to avoid having to write the length-zero Bloom filters; your
> > scheme would force us to write every filter. On the other hand, we could
> > continue to avoid writing length-zero filters, so long as the
> > commit-graph indicates that it knows this optimization.
> 
> Thinking about it a little bit more, I'm pretty sure that this isn't as
> easy as it sounds. Say that we:
> 
>   - continued to encode length-zero Bloom filters as equal adjacent
>     entries in the BIDX, but reserve the length-zero filter for commits
>     with no changed-paths, _or_ commits whose Bloom filters have not yet
>     been computed

No, use zero-length filters for commits whose Bloom filters have not
yet been computed, and use a one-byte all zero bits Bloom filter for
commits with no modified paths.

And this is exactly what I proposed earlier.

>   - write "too large" Bloom filters (i.e., commits with >= 512 changed
>     paths in a diff to their first parent) as a non-empty Bloom filter
>     with all bits set high.
> 
> I think we're still no better off today than before, because of the
> overloading in the length-zero Bloom filter. Because we would treat
> empty filters the same as ones that haven't been computed, we would
> recompute empty filters, and that would count against our
> '--max-new-filters' budget.
> 
> I don't see a non-convoluted way to split the overloaded length-zero
> case into something that is distinguishable without a format extension.

See above, no format extension needed.

> By the way, I think that your idea is good, and that it would be
> workable without the existing structure of the BIDX chunk (which itself
> made sense at the time that it was written).
> 
> So, I really want your idea to work. But, I think that ultimately the
> BFXL chunk is a more straightforward path forward.
> 
> 
> Thanks,
> Taylor
