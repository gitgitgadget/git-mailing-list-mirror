Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F39C433DF
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 20:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DE02080D
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 20:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fadBGgJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgGTUJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgGTUJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 16:09:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91817C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 13:09:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so998722qkk.7
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YFJ487lKT+GZEdY5E6iTEkuHUJEvf1QWYDWh4d9Bi3Q=;
        b=fadBGgJlBXtG1Hx0HfxR/9rauRLBaYIAmJ51DZV/cy/ntIata6OqWM9sDM2sJ/hu9V
         VbF0YKvAVOd35oV4c+adA+toYxKia+Wd1Jg6tqA59Gu0X6qQyRzSsmHceJuXZii/qf3G
         k+ii0Q7TM0CAWfQ1JHQMriSqqp4Pmk4nG6qOsHxy1u2q/b4vT5sAD58rmhtKT5zu/v+z
         ulw2Xo3s/FUj39qskExTLk36ThV466ScXQ0qXtoaUcB/6o7JNVoECBO7BOWWZMtMsHjx
         ICEJgCevOp6dGtkcyFsfl7gYHBKIia7kq7Zvo0k29QBsTKeD+deTAib16QjTBqNAxfrc
         +TXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YFJ487lKT+GZEdY5E6iTEkuHUJEvf1QWYDWh4d9Bi3Q=;
        b=Kx2zqA17+hT6XH6H8hiHvnfjJ9mGPJ+kXTDfEiS1JU1TYeDMm9xvwL4euChEnTLLtR
         z6bxHtdGn9HqHTkZOs8P14a7N6GgH19435BS0GZrr0vV1FTpeUTMpMaVnZhVWhofzl5a
         wTbm8GZoK2jl4Kl7pkSY3pc7zx0xoKsrbM0U2MFqQ8ChMck4UnpPWGrOrJYyy7xGDhtJ
         9UJk/PFmOKMPVTE6yPifFyMGsgExfRbPe9KgPeiBsof7zODK4mRGLDXnBmzHDvMiGFGZ
         iI6NfaKRR1GY2CnjA4sAJvFml0aCdo4JTi/0yFHw/5u9LYhneiVwp0uHsHDHyFg8N91u
         Ba6Q==
X-Gm-Message-State: AOAM532nRInuk7Dvsf2+goewgJpbN6z0Geg1VU1brlQVdqu7n6N3xQW6
        kAgIPgARs0xTHdxL73dZXenpGQ==
X-Google-Smtp-Source: ABdhPJwUXca1lMIN6iQZUKlz/X1hsb4KeoDSxxsufyujSfI7cAOUs7ihUWKz0J9g5Cktt9eoNa1mQA==
X-Received: by 2002:ae9:e809:: with SMTP id a9mr22935639qkg.315.1595275776758;
        Mon, 20 Jul 2020 13:09:36 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1456:25db:8327:2471])
        by smtp.gmail.com with ESMTPSA id p186sm483935qkf.33.2020.07.20.13.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:09:35 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:09:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 0/4] upload-pack: custom allowed object filters
Message-ID: <20200720200934.GC91942@syl.lan>
References: <cover.1593720075.git.me@ttaylorr.com>
 <20200708084136.GA2324177@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200708084136.GA2324177@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 08, 2020 at 04:41:36AM -0400, Jeff King wrote:
> On Thu, Jul 02, 2020 at 04:06:14PM -0400, Taylor Blau wrote:
>
> >   [uploadpack]
> >   	allowAnySHA1InWant = true
> >   	allowFilter = true
> >   [uploadpack "filter"]
> >   	allow = false
> >   [uploadpack "filter.blob:limit"]
> >   	allow = true
> >   [uploadpack "filter.blob:none"]
> >   	allow = true
> >   [uploadpack "filter.tree"]
> >   	allow = true
> >   	maxDepth = 0
>
> I thought the previous discussion landed on:
>
>   uploadpackfilter.blob:none.allow
>
> etc, to avoid the confusing appearance of four-level keys (and the weird
> case sensitivity implications that would cause).

Yup, I agree. I added a little bit more detail to this response in
another email that I posted shortly above in this thread.

Rest assured that I haven't forgotten about this series, I've just been
busy and not feeling too pressured to get back to it since we're well
into the release-candidate phase, and shouldn't be worrying about this
until after 2.28.0.

If you're interested, I have what I will eventually call 'v2' of this
series at:

  https://github.com/ttaylorr/git/tree/tb/upload-pack-filter-config

> -Peff

Thanks,
Taylor
