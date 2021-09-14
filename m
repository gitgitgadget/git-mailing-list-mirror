Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF27C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C7860F26
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbhINROB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhINRN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:13:58 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761DDC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:12:41 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b200so18107744iof.13
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kimyR/e1FfLtkvPZdMYvDO+VSOSq5Ak3jjZzN3tmzXo=;
        b=Gs6FqAoqlZQMnUatNu4Igk8pRSqG5tEHGQshTKRa8JOiIkE2kIonPpB/dB+3Klprxp
         WpCObmWixuukQhxvNYXqs50kpRZFwfBT2iZH3sCUc6do0pmMAcBNlfIA6AucdX4OqfJv
         jbbrEHfAeMfbPb2AzpEQMQUxyiQDhhUYWn10sw6lZcgAug/ON3ckT3riw4Avu+V5wU0Z
         N+dTxLcjm0g4EAp7cCru7FTbp1+5KBrhkRK0zbFUAn5VxWbgdR/xLuW1QOJGDjicvxTP
         vR0ObWsw9GW97wz1HLR6KiC7GVoNjdgTEflgcDotK3on/HOYc8EPXFlHAEdF9cYatcAx
         YwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kimyR/e1FfLtkvPZdMYvDO+VSOSq5Ak3jjZzN3tmzXo=;
        b=etnaY/72mBj/GsPRsx6u4sWIxMWEz8xobJItYOKVkHE/0ixNcBo/l4ekt1dGKwpOkY
         QTvy3LVmHFTvzL9FAb7q5p+UQ00yuBT/2lCVm2VOiG7wFDQthg0xLex8xh69IJsUlkO1
         oHE4ulpucEojL3U6eUEtt7b/goK8pSTnwJX++Z5kP3LrH6cCVLg6I0u6sszB1YNn/dDk
         Jp0MazwJzdlrmtvXJRNY+P5b/qOzhV7FfVL7Xdkfgw5sPA9N98G/pnR6q79cNpr3Kkmb
         rs1ZHM22wbe15vjAaA9bAEe1dRxdjnhbegmAe28qvnXJ/gEqZ1OEcJnh39onYXjVO1fO
         HV/w==
X-Gm-Message-State: AOAM531E0L/VBUuHOe99xbCZPsFfxuNm7GiHfQoVezCBl2iyksQslYh3
        LEUMiOwP+q3gSNpDHezZZaBsbELOIj8x/uKP
X-Google-Smtp-Source: ABdhPJwzmlGKH+8ZEZujfseHCZB1+fttx2/lt2ZbFfUXxgfLNwmWnlaxeqGO/GEL+Z4oduZBMGkWZg==
X-Received: by 2002:a02:7818:: with SMTP id p24mr15558501jac.72.1631639560855;
        Tue, 14 Sep 2021 10:12:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q11sm4464828ilg.85.2021.09.14.10.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:12:40 -0700 (PDT)
Date:   Tue, 14 Sep 2021 13:12:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/9] serve: provide "receive" function for session-id
 capability
Message-ID: <YUDYB0kQQsbKyIH9@nand.local>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDAtbHcbv6zNFxe@coredump.intra.peff.net>
 <YUDT5bnnMNtkc3KK@nand.local>
 <YUDWoiN7wczfNwU8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDWoiN7wczfNwU8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 01:06:42PM -0400, Jeff King wrote:
> On Tue, Sep 14, 2021 at 12:55:01PM -0400, Taylor Blau wrote:
>
> > On Tue, Sep 14, 2021 at 11:33:09AM -0400, Jeff King wrote:
> > > I had originally dropped has_capability() in a separate patch, to keep
> > > this one more readable. That breaks bisectability, but only with
> > > -Werror. I'm not sure where we should fall on that spectrum (I generally
> > > bisect with -Wno-error just because warnings may come and go when
> > > working with different compilers than what was normal at the time).
> >
> > I tend to fall the same way, especially when bisecting things in ancient
> > (to me) versions of Git where my current compiler complains. So I think
> > the approach that you took here is just fine.
>
> To be clear, the approach here is conservative: it will bisect even with
> -Werror. I think what you're saying is I _could_ have done the other
> approach, and put the removal into its own commit?

Yes. I would have been fine with dropping has_capability() in its own
patch, since the result would have been more readable (and since I never
bisect with `-Werror`). But this (the conservative approach of
persevering bisect-ability even with `-Werror` is fine with me, too).

> -Peff

Thanks,
Taylor
