Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B1C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 18:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9484D2072D
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 18:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Pq3RGLsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgIESzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgIESzn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 14:55:43 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694DDC061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 11:55:43 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f2so9556912qkh.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cM3btOv0o/ASlcD2RKoGqom5AP9IVPzKxaZv++05dD0=;
        b=Pq3RGLspBj8GBz3JgqH8DlqNYVGy/wMx2/ttaJwAWEjcXu8tTBYtweFjknynx855QO
         8+tvioxgpOoeFy6K7cAqRTmJKp9FxfdRet8FZEDeJQnlwN6dFzbkFZpnxdJ58bYTmjMj
         DuOF5+ZSrOucWOVrUiduAp+DA6kP27H0hAIHCMPIds9NkDsPLd5+LWd9rdgv8EcWwQ3c
         FNfacjCvolzduug3v9kUf94ZuEUYVpdKrsXkdrW45VbyxjBo7/uP+ZvSoQ55HGaEs8YC
         Jtzgp232DI/EUQCQEIBWviZ/3XU9TmLLAOecCQTEjlIW90cYszYBiLFysdtTw3bCDruh
         q+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cM3btOv0o/ASlcD2RKoGqom5AP9IVPzKxaZv++05dD0=;
        b=mMXA6wLZl5obQxlf6eYJvQDkErrMmkDVTqcJxcs+HqU4q11WNI1wzmEvdS8w6oEuOT
         a9jRWpx3xAXpSOE3te6EWX2X2FkIzogauJCzxJhnYNJko+rKqL2zgpBKM3pjTQyaTyEt
         X0amRB3GArp7iyNnCz6Mot55kXAdLuiw36k9hAsPRcqD0E2IhiHYkAVDrz5FLogEkuBv
         vWFb9Up5+lf/ejfYXfKCQpAHXHEXIpYUB6OZtZfXvIRQxrCZiHBnMmydRIB7gZEQJFT4
         Xi3rc6QGX50rZGBHbZfXRof0sFQbbFFhxH9taXM4V9U79+zk2JspQ2gHnVL0RLxnIBM5
         azCg==
X-Gm-Message-State: AOAM533eE7CQtehKU5BLOThTWEk5XN1dpmaxWcA5yxTs8IUCsiBFGJBo
        i1dpf5htYmBBnlTt8UlDnJUvJaD/uZ0FsAfJ
X-Google-Smtp-Source: ABdhPJzLP3yS/RYJKqLR+iqgNWgP+3sRfKoDl3X1UYx53cmZ9A1hK1pvnwNibtjoMGReV6dfTWAmpA==
X-Received: by 2002:a37:7c2:: with SMTP id 185mr12448570qkh.304.1599332138064;
        Sat, 05 Sep 2020 11:55:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f423:2c6a:683a:2c57])
        by smtp.gmail.com with ESMTPSA id i7sm7557072qtb.27.2020.09.05.11.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 11:55:37 -0700 (PDT)
Date:   Sat, 5 Sep 2020 14:55:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 07/14] bloom: split 'get_bloom_filter()' in two
Message-ID: <20200905185534.GA7416@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
 <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
 <85h7sc9m0v.fsf@gmail.com>
 <20200905173825.GA6820@nand.local>
 <CANQwDwcWveN03h=Ex0GFo-Mm89UT8_HXFMQcZWdDx9MPZYYodQ@mail.gmail.com>
 <20200905180120.GB6820@nand.local>
 <CANQwDwcD5XD3e7ar=8HPupobOZGDN4bgQJBS1Ad1m2NDx8eurw@mail.gmail.com>
 <20200905183854.GC6820@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200905183854.GC6820@nand.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 05, 2020 at 02:38:54PM -0400, Taylor Blau wrote:
> I don't know. I think my biggest objection is the size: we use the BIDX
> chunk today to avoid having to write the length-zero Bloom filters; your
> scheme would force us to write every filter. On the other hand, we could
> continue to avoid writing length-zero filters, so long as the
> commit-graph indicates that it knows this optimization.

Thinking about it a little bit more, I'm pretty sure that this isn't as
easy as it sounds. Say that we:

  - continued to encode length-zero Bloom filters as equal adjacent
    entries in the BIDX, but reserve the length-zero filter for commits
    with no changed-paths, _or_ commits whose Bloom filters have not yet
    been computed

  - write "too large" Bloom filters (i.e., commits with >= 512 changed
    paths in a diff to their first parent) as a non-empty Bloom filter
    with all bits set high.

I think we're still no better off today than before, because of the
overloading in the length-zero Bloom filter. Because we would treat
empty filters the same as ones that haven't been computed, we would
recompute empty filters, and that would count against our
'--max-new-filters' budget.

I don't see a non-convoluted way to split the overloaded length-zero
case into something that is distinguishable without a format extension.
By the way, I think that your idea is good, and that it would be
workable without the existing structure of the BIDX chunk (which itself
made sense at the time that it was written).

So, I really want your idea to work. But, I think that ultimately the
BFXL chunk is a more straightforward path forward.


Thanks,
Taylor
