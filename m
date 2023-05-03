Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCB1C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 23:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjECXus (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 19:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjECXun (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 19:50:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC793D8
        for <git@vger.kernel.org>; Wed,  3 May 2023 16:50:20 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a5e0f5b1aso39766507b3.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683157819; x=1685749819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+dp9sa/BXQxsGAUG5WmyYhe4WIktLj+tGyWWQv+qKg=;
        b=dYQapsrwUDD/zmGtX/cd/5/d+XHFlxDYs9DhGP7yHTZWm516u61TNW+JLkhPMF7scA
         ZjsomUxhbc4y3tUmsQDweE1RnbRpcGb0kXfcpUnQKCMBkDCAKF53f5Sy6MIDgtB1DCf6
         9JWQrVjo5jGNzix3jQqS1cEBfwynFOYG3OlW02ucNzoloQJd8eld/Zj5zIaw4mpI08sE
         o0+uLNBcOUajrwPZLu8akav9MM7O7yt9nmNT7smJvGp9Z/XNHJjIApAgSb48WCx8a6qC
         HFC8QvDu1hmPPo/I+fVhoz045BjnG6AMnHIgtsqxgvYfmx0ydrdMP9/8bhylEWxbiE77
         YRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683157819; x=1685749819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+dp9sa/BXQxsGAUG5WmyYhe4WIktLj+tGyWWQv+qKg=;
        b=CY34NrbIct6kehdO+4K4Ga3F5nITehl+/2nhAKYmtPhRctVSlAwmsI7aWLPNv4/qF0
         DqZgzUwswTMJ4Cj8pUrsApah9Oi/5U14hDNTCbec346Iaux3VKHA0vY6uCDsNtZEWAK7
         XpOVjIHapFS7nznkXTejBV9R2jvYn23SXR2Dbo9NisG8BDMDXhjUUv5UykVOff+C4dBy
         4NdlBiIeAGH7qoGFwpN23NkjX1PCKmI3SkOV7iV1Lv8weWUwc7tcHY5Dc8v16BT9OJuj
         tOBzykqz5AohtUrIKHLFuwwTPFmC+HnNC4sT1PlFO1x+H6jgaOZoRKCWtt4Yy4/Hdv5r
         MbLw==
X-Gm-Message-State: AC+VfDy0FCLEo/MfgnL53Fm31rbowp39yAN867stCNTNVlrWtg6FHfi0
        yhF0EIDeVsMszusBXD50Oa0MAL0t+UC/Sgc44SxT7A==
X-Google-Smtp-Source: ACHHUZ66CAHvve02HxCr8Dxv/nWarQBB7epHIHpgAXY8lvH1mXqPE3EkjoFa15YrcGw3P7VTk3+MoQ==
X-Received: by 2002:a0d:dd8a:0:b0:559:e315:fc90 with SMTP id g132-20020a0ddd8a000000b00559e315fc90mr289999ywe.41.1683157819222;
        Wed, 03 May 2023 16:50:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j4-20020a0dc704000000b00545a08184desm8996351ywd.110.2023.05.03.16.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 16:49:04 -0700 (PDT)
Date:   Wed, 3 May 2023 19:48:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <ZFLyv0s/o8gr6IZH@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>
 <xmqqv8h9m2az.fsf@gitster.g>
 <xmqqjzxpm172.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzxpm172.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2023 at 04:42:41PM -0700, Junio C Hamano wrote:
> Storing them inside cruft packs may be a reasonable choice to make
> today, in the sense that among various object storage mechansim, the
> cruft pack mechanism may be the best fit in today's system, but it
> does not have to stay that way.  Naming the variable to specify the
> hooks with name "cruft" in them would make it hard to explain once
> we find an even better storage mechanism to store such a "not really
> used but want to keep" objects.

I dunno. I thought about this too, and I get your argument, but I am not
convinced that a future mechanism would lend itself well to keeping
around additional sets of objects in the same way cruft packs do. In
that case, we would prefer having called this `pack.extraCruftTips` and
relegating it to the cruft pack system.

We could make this more generic, and extend support to the legacy
prune-via-loose mechanism. But like I said to Peff, I have a hard time
imagining anybody using it.

So, I'm torn. I see what you're saying, but I think I still tend to fall
on the side of leaving it as-is.

Thanks,
Taylor
