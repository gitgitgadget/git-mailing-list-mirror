Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB4EC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C455564D99
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBKCgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBKCgP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 21:36:15 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF9C06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:35:35 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d3so3174791qtr.10
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pUpV7e5kl/rO4xnpJjarUaSDSID/SQKHE0ulEkmd2C8=;
        b=sFAVwNcu6yPi6Xh1xd3yJwKAMnATpywzugAjnyWnYeYPnOgrZCW1wjtaYQ8UATvTLe
         85lt/7X5jKvw380r6dnc4PA9QXwaORymQKkVWwZdjQt4NwlMx2hMkR1NxBgHzAfwF9ez
         J61Iq/hp2WHk9VyEH76yd1Iid39mfWngbirqeXsFW9HT8g3N8IRP2P010T5zE/6k9VF2
         IALqy6k5XRz8k9JSh1hNZnhuIXoLhlc/bSzgTOA3NRWRXXYnqqj/08fNO/6CcRrEoCUs
         nLUExwt/wDrr411uVhxzYWJjuPUNV6kvaBdVDsPLjsJbpzgarDfjuHsZlGbEjVVcWoT0
         zBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pUpV7e5kl/rO4xnpJjarUaSDSID/SQKHE0ulEkmd2C8=;
        b=P3DbN1kKjNHr+I5PDyBfin6gJWUzbwyXRHLVdwf2TooBjPKLcr8Cco7MiASPseRlh9
         JkNo4ad+1KtlkreO/Y0fYjgRnrd9YCvjR5f8N2R766NEnTN7u07GqKTsSM0TDGcPRwtb
         HyXODkUXRuEX/PGmuYf6SmDFRkRI7iIemYN6OBlHl9hwAyQhEHu05F/YpuMPQ0Pwe6kZ
         rZktTX920mkcoFAzJJW2CydhM/MMX1y+6RiWRCEDyMmwNIpMiYtK3u+tP42mM1Z9CFz5
         wPTKroRsWl1ArjDS8cZ0Cp8w3iQ9GYEswJfi3DbCTqk0dQm8EkNEqgEluK/8GBvd2eyx
         wVdw==
X-Gm-Message-State: AOAM53264jiBqksYpM5d9/wXkLK6zqXzMd2SYNFoEgn1HBY5YE/WRJWE
        U0ev9XrcAHzPzgiKv3p2lNB5Ng==
X-Google-Smtp-Source: ABdhPJwZYz1zysfsDNw0qk4TtfGaSzcJlgQt9vmGCzbdUKgHcJsnvpfo9rRllK4t2IDOEcsdAq9pAA==
X-Received: by 2002:ac8:5c41:: with SMTP id j1mr5703178qtj.306.1613010934452;
        Wed, 10 Feb 2021 18:35:34 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:666f:3d4:2894:5ee9])
        by smtp.gmail.com with ESMTPSA id a203sm2912592qkb.31.2021.02.10.18.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 18:35:34 -0800 (PST)
Date:   Wed, 10 Feb 2021 21:35:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 4/9] midx: keep track of the checksum
Message-ID: <YCSX9FeUu17v13Al@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <b4b842fa1e8c711af30cc93b6f1100661791416c.1612998106.git.me@ttaylorr.com>
 <d03263c7-56d3-575c-4ab7-56a617daf34a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d03263c7-56d3-575c-4ab7-56a617daf34a@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 09:33:36PM -0500, Derrick Stolee wrote:
> On 2/10/21 6:02 PM, Taylor Blau wrote:
> > +	unsigned char midx_hash[GIT_MAX_RAWSZ];
>
> I was initially thinking we should use something like
> 'struct object_id' here, but the hash we are storing
> doesn't correspond to an object, which would be
> confusing. I suppose this is the most correct thing
> to do.

Yeah. There are a number of places that abuse the unsigned char array
inside of object_id, but there's no good reason to.

Thanks,
Taylor
