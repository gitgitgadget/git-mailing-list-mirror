Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A02C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BBA2225D
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WM0mD19m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409369AbgJTUJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409366AbgJTUJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:09:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CF1C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 13:09:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f21so2977191qko.5
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RvRzkv+4fdhpdfhgCl0uYmn1fPy60LId7Y5Wv2a+Odc=;
        b=WM0mD19mmtcyo32TZJV+cKsOk63LHen6H8x450sX8pz/YRDzs+L4Rjpc9J7rd48iLY
         G/yvFHEIxClZISIxfQFm0FWWqDgXfMkBEHv1dCY2FmKBnXitDY30BmIAHK5S0152EjuH
         lbm87e/6QlH6YwaqRpUvReac9ShLr0p95P1yAmN3EySLW1ZA5q4rGRPOUlFS9TDxKT7X
         qYHPF7P9JojgkbZs2bqjXbPEToc1mtC3vvFYfc/u/wAZOEQhmN9oj3x4Ne18NuGV29fk
         4s7fHuH8MHB8bR1CHnbT9iLaaIvrpWigJBa8uIFp87qQXemn1GnRWF1sjMaNvbQQGGlb
         ToCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RvRzkv+4fdhpdfhgCl0uYmn1fPy60LId7Y5Wv2a+Odc=;
        b=boInxxNyt8cyZuZZ9+/FfhwcoewgCwNR+vAtqNE6RaihzVeOC+Q9kqNZweTVKdw1uS
         wB+3yXix0y5wVOtGzNg26MOAGzVHcVPvqS7ZkHKPHQqtGNLvMWr7CCJTGLM3nTI0NJP7
         66BpQg56QqRBIXcotI7PXAHQbd5kKjzUoAdI0udyRtclCqHRF01TXHMS+xppIfZGls5u
         3RBPF2tysbOSWUB/PzR221re/ksEc2EHZ83tX/aRjIZk2msb0zBClOZKw/lxCD7f+A+P
         plCkLmR9vLMDBR+CA7lvn4cDwsr3kbRBoNKbK27pMW8oZIFAebeMD+Tz1Nc062t95GoS
         fCfw==
X-Gm-Message-State: AOAM533LeDnjUmab4HNEg3QLTAatRJDVsIV+LWQunpWnz6HsHpgnGcGN
        OrZdCmzQab4V6X6Hv8Gzy0p/iQ==
X-Google-Smtp-Source: ABdhPJzI3SB8K01QHE63Ygv/Ljg5hWuAMuwusQoBUAqQioCXs5iMfxUZacRresm+dtz5FzdbNTGuCg==
X-Received: by 2002:a05:620a:62b:: with SMTP id 11mr2626811qkv.229.1603224549838;
        Tue, 20 Oct 2020 13:09:09 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id i90sm1269518qtd.92.2020.10.20.13.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 13:09:09 -0700 (PDT)
Date:   Tue, 20 Oct 2020 16:09:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/5][Outreachy] t7201: avoid using cd outside of
 subshells
Message-ID: <20201020200907.GA75186@nand.local>
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-5-charvi077@gmail.com>
 <cf26c039-0870-ced6-5347-ab3f24343105@gmail.com>
 <CAPSFM5ejRWUc2mCtqTPH4a6Q-WWUC4mQHU=bsHkjJOdG4kwW0g@mail.gmail.com>
 <3b501a3a-b675-3eb7-975a-cc9206f15057@gmail.com>
 <CAPSFM5fvBt+x840XOwzwPBvXK7_1qB-sb+_M3LoPuKv_P=VvDA@mail.gmail.com>
 <20201019202456.GC42778@nand.local>
 <CAPSFM5fr4dY0tNdUrxdjhBQohX_sH0X-5m1VGHF-GAtpx0rQXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPSFM5fr4dY0tNdUrxdjhBQohX_sH0X-5m1VGHF-GAtpx0rQXA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi,

On Tue, Oct 20, 2020 at 11:08:55AM +0530, Charvi Mendiratta wrote:
> > Usually it never hurts to just send the patch, since any feedback that a
> > reviewer has now is equally good even after you have sent a patch. Plus,
> > it's easier to review the concrete patch you want applied, instead of a
> > hypothetical of what you might send.
>
> Yes, I completely agree with you . Its my fault, I will send it in the
> patch and will
> take care of not repeating this again .

It's not your fault: there's no fault to be assigned when submitting
your first few patches to the list. You're doing much better than I did
;-).

> > That said, a couple of notes:
> >
> > [...]
> >
> Thanks Taylor, I will do the changes as you mentioned and send it in the
> next patch .

Thanks!
Taylor
