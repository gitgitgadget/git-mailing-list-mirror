Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3736CC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED14B2076B
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 15:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MiEIJf60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgITPfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 11:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITPfm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 11:35:42 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F6C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 08:35:42 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h6so10106098qtd.6
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7EEMBY2GzLYCvBC+lTLYq6VDCO9prnK5Q5vruHH4HRM=;
        b=MiEIJf60dOWpr0D/R/s5E8vvqHDYrZbLhpAHX/FuJTWBS2TiyRfqUsm13P1Vl15loM
         Hj4gYrijACUf0y/J+44tFYM6MgbDvXAIJOROLjEfWmAwF5LxoU3ZGBHk4/Ge8vQUjsuh
         fGEK2HcNWuiuPvT8EdzzQ9jUeOPr8gonzJOsJorN5hHtcuFF4YC/dG+baR3O6mQASAbL
         Csc1yGhNA1/X17RhJX2iTePKzBKn7QuQprneqSKMjaMkVbat56ps7GLLf8tn4LCsq+Sq
         Vyot0Ap4ygkijSOdRVmXNeyoMbNYxn1MX4TAmhopKx0vx5HIp9rO6uZ/jfjyMHUF1wlM
         QmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7EEMBY2GzLYCvBC+lTLYq6VDCO9prnK5Q5vruHH4HRM=;
        b=A77nRXA3bbE4d0tp37ytb6Ni8z1dMLuB58QgKV5gcT4TqGwJyTI4lcBti24BhMB00C
         mcFkW3/B6ubuqVR9rEk7dLeNSRFMqlAjDbd2Jcf+kOFXVPQcnOlMs8bQvBYyL/E4O4wY
         OO22hGk59MkBGovTrg1dg2EMNo712LajmJb1pOpBZQf3uYCN6mKZ5ZPw3Vq9Hbi6PMVD
         DG8mfp80rk06g5TD+q+0cTSRHbtTljhC2ssS95UQyYuzyL+hTFnyosWwkW3XxeWSCShI
         /4U5DmwNNFQF2qTtI7OotH7dV3K6Ztm66z0ORyULDdzy5teobga3LVZVKpZDy/BIOasi
         MSpA==
X-Gm-Message-State: AOAM532/vFSK55CQLxOSPqI/iJ2uwbKzj2cxqUgA8XTa74AVhdKpHQWn
        8WA9ksxFpb1sYDVR5kiu0a+mdQ==
X-Google-Smtp-Source: ABdhPJzzhUujPc1Ua46XTfEOnzrDNQHylaVk0kRT+iE2DtvDCyKjVuH059xN9lqcPCywmqWMbH4pZQ==
X-Received: by 2002:ac8:17d9:: with SMTP id r25mr37345054qtk.107.1600616141317;
        Sun, 20 Sep 2020 08:35:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e586:7467:2d4a:d620])
        by smtp.gmail.com with ESMTPSA id 71sm6569658qki.85.2020.09.20.08.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 08:35:40 -0700 (PDT)
Date:   Sun, 20 Sep 2020 11:35:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] builtin/rev-parse: learn --null-oid
Message-ID: <20200920153537.GA2726066@nand.local>
References: <cover.1600427894.git.liu.denton@gmail.com>
 <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
 <20200918141125.GB1602321@nand.local>
 <20200918212609.GC67496@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918212609.GC67496@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 09:26:09PM +0000, brian m. carlson wrote:
> What I typically do when I write shell scripts, and which may obviate
> the need for this patch is turn this:
>
>   [ "$oid" = 0000000000000000000000000000000000000000 ]
>
> into this:
>
>   echo "$oid" | grep -qsE '^0+$'
>
> This is slightly less efficient, but it's also backwards compatible
> with older Git version assuming you have a POSIX grep.

Yeah, I mostly just have no idea how common this is in the wild. If many
scripts care about the null OID, then a '--null-oid' makes sense to me.
But if it's only a few, then it does not.

> If you still want this option, then that's fine, but please make
> --null-oid take the same arguments as --show-object-format (and default
> to the same value).  Git will soon learn about writing SHA-1 while
> storing in SHA-256, and it makes everyone's life better if we can plan
> for the future by making it understand these options now.

Agreed.

> I'm not sure we need an empty tree and empty blob object, because it's
> pretty easy to write these:
>
>   git hash-object -t tree /dev/null
>   git hash-object -t blob /dev/null
>
> That's what I've done in some of the transition code at least.

I could go either way. This for some reason seems more common to me, so
I wouldn't mind making it easier for callers, but I don't care so much
because what you already wrote is easy enough as-is.

> --
> brian m. carlson: Houston, Texas, US

Thanks,
Taylor
