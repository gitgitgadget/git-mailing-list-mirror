Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A0C433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF7764F5C
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhCOXHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhCOXH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:07:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B10C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:07:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e26so7541779pfd.9
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zo7yi15ZmiVPw60lfuHd4uU6Bcp9ZLfvx4gJvO2nm3Y=;
        b=m+0AlWdSJPeI8jAYR0MI9WILflwT/QoBR1qyXjs66k57qRsXbSSHMnAy7ifA5brQm9
         1LE1wOXuSxPBuXQ605KTrJeCm2kvFjqzV2KjdREGz4xiikS1+VBMnF9y9cl4LK+bS2ie
         W7plfaiURqJlprS01KszT++nApMTON0lXw6VWEOeFEVOxYyCdhAshall4YgU3Dva3pSR
         8xtTzEZJDxN/BPiepk7WaJIMCGRxUkkpb8ISivYQrelhFcCu4CDiZLhoev++iSDxV90z
         op5RVVQY9qX2yav+BxuENfaqbS3E7AQQHiQUm8SOMM62DwhhAzZts9IOj+iMDKFRZJty
         5xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zo7yi15ZmiVPw60lfuHd4uU6Bcp9ZLfvx4gJvO2nm3Y=;
        b=gvBQ5CckD0Vu9F1zz5t1oRkyBTPzsqd0LZGXO6QKTENSKpT4MVA89w5oTUMc3lOXHN
         D+seHUNaQGiVpfIAsipY6wUgVYPxEQH2D2wGdsuzuf93O2wuB/1ojvSl6MhjezQ5c9a5
         lMRANkbMkiHsPz7ywt6dOlly5iq0MhzakeZjdPSuKIVK4FJSYKByB/9j0bN49AhQ7HZf
         UNh5e5iGZwyTbHwgP80FG+kTKpyCfZkci8YPhMKtU1qenS0yC4HJe/nkJ1BYfWXS3v+e
         36KeLPNaDPy1Zo5263m11TFCP5ry5nUJjDWqWdctMZNOErpIghyHF7KmoQogcmoVWg9j
         H+1A==
X-Gm-Message-State: AOAM530WuiGWNj8JsN6UjxnZGa0R1UwlsWrKpb0C5lIW9Y3G6hQWBt0T
        m56M07Vce3aBpebe+SZM6VlT7dY300U=
X-Google-Smtp-Source: ABdhPJzpTNGaJAWPTlez/vBJ0rOSFrarOaP8Zskm3OYNgxXN9kwEwhrDcz/4J/YVl27/LVI4GXPbdg==
X-Received: by 2002:a63:4753:: with SMTP id w19mr1150515pgk.394.1615849646044;
        Mon, 15 Mar 2021 16:07:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:b1c9:41e8:dd7a:142b])
        by smtp.gmail.com with ESMTPSA id 35sm13857899pgm.64.2021.03.15.16.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:07:25 -0700 (PDT)
Date:   Mon, 15 Mar 2021 16:07:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1: drop trailing semicolon from macro definition
Message-ID: <YE/oq5dPDB6PvD22@google.com>
References: <f8122736-e729-5d35-e1e1-78a213816d4a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8122736-e729-5d35-e1e1-78a213816d4a@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe. wrote:

> 23119ffb4e (block-sha1: put expanded macro parameters in parentheses,
> 2012-07-22) added a trailing semicolon to the definition of SHA_MIX
> without explanation.  It doesn't matter with the current code, but make
> sure to avoid potential surprises by removing it again.
>
> This allows the macro to be used almost like a function: Users can
> combine it with operators of their choice, but still must not pass an
> expression with side-effects as a parameter, as it would be evaluated
> multiple times.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  block-sha1/sha1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Yes, it was just a typo.
