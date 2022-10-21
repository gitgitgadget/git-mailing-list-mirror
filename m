Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B871DC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJUWHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJUWHF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:07:05 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12882930AE
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:07:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h203so3494565iof.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHVXLEjQD4nwXohNEmVpcH0oWveYdJefHpaIFd0YPMo=;
        b=jjMMa64w56WicrGd4Ypj56lECCtF+QqFLCPSsexVfQOiiPPKs2wQa3cM2AO0RfajiU
         hWZqAclxS2+IqPGTBDnXHOeCGDrna49EHsw71nDuDgC3VL6hq9/07v8iM14SR9xoG8Dn
         RhZxTfLRV5esmunraziM0qWoz81SAaq4ByzsXhtuXB/x53z463xZl4txgImyDoafIege
         JsJE2cnvEjj5UPOppQA+pVAAOPxWseQNQQNBBMkIV+gbKEjrFUzJ2YE92lgKedfeWr96
         +X7RsDgOibAaHaPZNks27egDV7Z73rGEu1gVFtO8JDy4dNkH8IoRYIdqjzosPwpPOluq
         cYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHVXLEjQD4nwXohNEmVpcH0oWveYdJefHpaIFd0YPMo=;
        b=YjlcrT2x1nlW8vr391hmqoCr+/ieIsGdUlzQnouBLfUzm+GZf1/goiH2KJx4BZdTvf
         SQPYOLb+pBmrLvLtbPot4tlAb/ThZDmcDV6njm0pzgBLFgqpppU0cANEocxtlTCLpFTk
         WCbG3Z2xji26/JMDUnH1Fwxb4Iz3Qlvp8Sf1jI5/wgPKPAieotFmQNE8Weil1Q7ZNors
         QvX2alcT0S5O9qS6UlrpUqmGGzUY+Fq6ucj9c3uJA4KBY7YWgwj18zOjfS9TaDSUFLmV
         IAcJ53zd9i9FYMOcHTFH49cDgob+3cF2hdZBbsNvwt1loIZ28pN1lq2gQCTqdLKD3aB/
         HzvQ==
X-Gm-Message-State: ACrzQf2DRsoCQKcv/++6RnRZIR2HdVQLcBE0P6ErEmdduHtO5NXXDNVB
        QxtDNEgTNmkPiz7uMg6IMbgpIg3VddBx4+8d
X-Google-Smtp-Source: AMsMyM4CuFOExh9XgmJyiavje0F4Y7NS6707Xz4/vm+vK+CV3kzbRyYhKgIrMjnfkyV1QLbYtQh8jw==
X-Received: by 2002:a05:6638:4782:b0:363:c5a0:2aec with SMTP id cq2-20020a056638478200b00363c5a02aecmr16111264jab.242.1666390024250;
        Fri, 21 Oct 2022 15:07:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ay33-20020a5d9da1000000b0067ba7abc4cesm4717624iob.50.2022.10.21.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:07:03 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:07:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 4/6] shortlog: support arbitrary commit format
 `--group`s
Message-ID: <Y1MYBj5zcPza70/f@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
 <4a36c0ca4e840d53e2fd257e2d97498ced6fb28c.1666320509.git.me@ttaylorr.com>
 <Y1IyppKatD7piHOO@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1IyppKatD7piHOO@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 01:48:22AM -0400, Jeff King wrote:
> > +test_expect_success 'shortlog multiple --group=format' '
> > +	git shortlog -s --date="format:%Y" --group="format:%cN (%cd)" \
> > +		HEAD >actual &&
> > +	cat >expect <<-\EOF &&
> > +	     4	C O Mitter (2005)
> > +	     1	Sin Nombre (2005)
> > +	EOF
> > +	test_cmp expect actual
> > +'
>
> ...but this one seems redundant. It is not using multiple formats. And
> you test that later, in the "can match multiple format groups" test. Is
> this one just leftover from development?

Oops, yes. Thanks for catching it, I'll drop this one.

> > +test_expect_success 'shortlog bogus --group' '
> > +	test_must_fail git shortlog --group=bogus HEAD 2>err &&
> > +	grep "unknown group type" err
> > +'
>
> This one is a nice inclusion. I was surprised we didn't have it already. :)

:-).

Thanks,
Taylor
