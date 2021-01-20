Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C736EC433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9908B233ED
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390371AbhATPKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 10:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390857AbhATPC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 10:02:56 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940ACC061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 07:02:08 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id k193so4448575qke.6
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u24B6/+rT3U7XbSs5wv8voh9+39sO/n+xVRIFPdr2Oo=;
        b=ogL3HmQGwWWINISyJ+CHhQQgAqCoSm1ffCEVkp9cwAT0WhsL1YwLU5buntAXRfZV1i
         xK74HrtWxN3SI8ZIBUiAZRgCxkno76WTDAVXb0yXZf+KxhkOjY5rZLmQkK02xbO52Uv8
         Evqx22mMkYmCZYVU2lG9SF1mYzWs1QiymMdxDu26HQWNiLh5EKP9smOwWkx6zwTajm6V
         BxAJH/wS2EEn2vpxdErv9LY0qEEGw9z27agd3EkUA8YDVfXUva/ImoXJYL1r82ZJk4uG
         +gWKAb0SrEq1HhOEz0Rvh1OQ02R3VdSn7bfgT4SrNrTn1SncEOdINg/m6Kq0sVk+gQwC
         o7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u24B6/+rT3U7XbSs5wv8voh9+39sO/n+xVRIFPdr2Oo=;
        b=h3wgyRK0PBxiF53Pf73hKsjcrtwy38V0Cb+y6u0veqdxaEo5+OIWdh99/Hza4aE4MG
         9Znnc0IxxAUqUaORDmq+qRX7XiNjCkbWxIMZ63SdqjE8ifvbb4epqNJxJKZqgkOg9Ji4
         xtwBIOCx64cMaoCV80QX0IiefKr5zTgNN6jjqDb0FggV0qLO1yWpyaxEfI1QvCR6NcrG
         1nvCQAeKW26LGKof3OgfxGnHGxfmDDg2eXh0d1W3mHw8mouyX/+zTKrkmqApTYmh8A28
         b0Dl2ljrQouS/270ROLrUJqzsvyYJAVageTUDdYidmkGnng+8bi4lc21EsEBytGCVfDD
         ZWAQ==
X-Gm-Message-State: AOAM533V58NFkfSmBIBV8Bnf2ChLl2mB157YW2/oQ81Hy5uAyrLx+bcC
        cjEmBN2Xn/TkMEYgMtPrBN8ZHw==
X-Google-Smtp-Source: ABdhPJyTm2rTpD3q9KxSosBTfch4wXx3jvF6Mg6eTzM7bwp89VFYJ1aqvzK6HvbQ6sv2iLYJ7Rt3yA==
X-Received: by 2002:a37:bc81:: with SMTP id m123mr9725277qkf.191.1611154927846;
        Wed, 20 Jan 2021 07:02:07 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id b12sm1294027qtt.74.2021.01.20.07.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 07:02:07 -0800 (PST)
Date:   Wed, 20 Jan 2021 10:02:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAhF7HfOdu5AR42Q@nand.local>
References: <20210119143348.27535-1-jacob@gitlab.com>
 <20210119143348.27535-2-jacob@gitlab.com>
 <87lfco801g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfco801g.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 09:50:19AM +0100, Ævar Arnfjörð Bjarmason wrote:
> It seems we might just be able to delete this code on the server-side,
> per protocol-capabilities.txt:
>
>     Clients MUST be prepared for the case where a server has ignored
>     include-tag and has not actually sent tags in the pack.  In such
>     cases the client SHOULD issue a subsequent fetch to acquire the tags
>     that include-tag would have otherwise given the client.
>
> I.e. in the case where the server isn't playing along and I haven't set
> "+refs/tags/*:refs/tags/*". But as the test shows we don't do that
> following ourselves unless refs/tags/* is in the refspec (and then it's
> not really "following", we're just getting all the tags).

Reading your email, I see no reason not to do it, and that snippet from
protocol-capabilities.txt makes me feel even better about doing so.

I'd be happy to have Jacob's patch picked up in the meantime, but I
think that this is a good direction to pursue.

Thanks,
Taylor
