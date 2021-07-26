Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6884C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B484E60F5B
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhGZSHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZSHw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 14:07:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC87C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:48:21 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y200so13239542iof.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DhQE+FVc5gsiSQp4ZM9qhDyGsDMAbdihoT/pvqJxK24=;
        b=kYgTILXA96iCcJdDVbdhZWFTHYFJ0RJmHNV/Nx5plnDN3etJO701EE8ykv/44sCjP1
         KiLVA2zLYto/xBaQiq8Hgaza/pR+2UUtyUjsQw7zD4GKrCo/TqgPNCryDlfDulHGcYOY
         5H+oyWWbN6Vz6arAPh5pQwsjgAJ050dGEFCSfZtQ5eqipgfnLCoR23L+xEHEBtK9AD3S
         MuKDiyVf97imknNEk9NcF/qPxQ/9hA6E/htEfk3HJITkaNP8KAXHS6JiWe4cB37yYN20
         hVhKFmWSpFw591Wj/kkakeSjjTQunt3Ym6zmCY3/4taXdehjEr8K+DY/P32WgBDXW7+E
         w6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DhQE+FVc5gsiSQp4ZM9qhDyGsDMAbdihoT/pvqJxK24=;
        b=HdJp8fL3NWbDkaOkGnbjJSxwoiZzn0wzQwUyHh0CO7wE3R+tf62E1o4Zfi4/2Y40TU
         LGZ1ZAT587LZO9SCNMBBjSvkKxXUbfnzWm+HNdiK12SHVTo1J0gt+gvmzLz8R41FqhKg
         RpkKlLVMvhWxqdFjflUBai8Cn+qk2yqMlJGyyCbgjzgotzFA/+t0owEEfB8+dHP8OnMe
         prrcP40sIO8VopqLE4InAMyqSfLBR81VQBso67j/cAQ3JwoZGeY+ca0Rt/kXlYssEAhD
         GjEj+PtKbWqgWsLkAH4rbp/UGaXWh/3wU0F0YrDDOk/Mcitvv0beHASMAbUPE1ySYI8/
         TRJw==
X-Gm-Message-State: AOAM531xMUmOdL0ecDyD4KmkmwPL5VVpr8PMJ1CvI9JSwCrL0kZZdmx8
        uTE4PS26CdK65AaS1Ev8rnBl2w==
X-Google-Smtp-Source: ABdhPJztWUDegVLuHrvYnk5aI2YvxlS+DPBlxvH+amo24rHMQalNkJ7GI7FFhObeFKmC02rcxSFNrQ==
X-Received: by 2002:a5d:925a:: with SMTP id e26mr15968968iol.195.1627325300881;
        Mon, 26 Jul 2021 11:48:20 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:18ae:76f8:f6b8:4b88])
        by smtp.gmail.com with ESMTPSA id x10sm264712ill.26.2021.07.26.11.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:48:20 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:48:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 02/24] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Message-ID: <YP8Dc9rHLrUmYQMl@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
 <YPft87yCjR9e+93E@coredump.intra.peff.net>
 <YPhXb9Zns8S6aIod@nand.local>
 <YPpx0KoGUX0KfdSw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPpx0KoGUX0KfdSw@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 03:37:52AM -0400, Jeff King wrote:
> I thought about suggesting that it be called "err" or "ret" or
> something. And then we do not have to care that fill_bitmap_commit()
> only returns an error in the non-closed state. We are simply propagating
> its error-return back up the stack.

Hmm. For whatever the inconvience costs us, I do like that the variable
can be named specifically like "open" or "closed" as opposed to the more
generic "err" or "ret".

So I'll probably keep it is unless you feel strongly (which I suspect
you do not).

Thanks,
Taylor
