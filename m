Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D23C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F0422253
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgLAXoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgLAXoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 18:44:09 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F2DC0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 15:43:29 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x24so2242582pfn.6
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GEgzPmSrD9+M5h4h8QH4GneJTNq1E05gf879PTQ3IzI=;
        b=w88+gUNX+rJcP6My2Rd5oZusFalBbD5Dwy5YDs1BtD1KBDW2B4eivqFDqwb/Z5dt/l
         rOimp9UPju4JrTIfHp3AWJweIDFAfVO9SgWU2+Pfh0y4f9w+1NE4grszO3GtjfFBFsb9
         3E3DTRNa5ye1yVm4sg4maP6tVK1FG6RckSoEdohkdw3HseHxs5Ratr8WzAfpUfFmZYtH
         9yc9nGx6PuqcXIKMiZQ+ZWy3wY7hplfkamjGvpVCfFu2IYVx3AuiD64MmKfGfMSQQQy2
         sNDO6uLdDWGfQDS09tKH3jsNjmomI2v/dYBhvKh/63FfQPCJyDxvSqRKs1qy+lvSGAO9
         RmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GEgzPmSrD9+M5h4h8QH4GneJTNq1E05gf879PTQ3IzI=;
        b=kpN4PbVDeiBuS3foa4rHX/MxNAKDn6/Nr2ellFxZElmGpe+PI9JixuRmdLWd8AFvjo
         ZDnl7pESCBpJOwhSTdM8do5QI894ir2O9RTUPohNj7K/+71ITQ/UFQycdYpMyhPQtxnC
         K0t8hREXgmJMONgdi/RAyXcZ32tN8dLAsrprb88DjdSTdpd+MIxGzuBM5N/tj+5/qSQj
         Rfry50/TjGc+uzWQbSlDBNMEt/cA8Wp2j/4YTXL3qZPAoaYG6m2fyHCCgZy+WH0+hWFW
         bEPpaUVHw8o5+V6uVFrTkijS0Qjz6itER13ESE9c1au8ADIC6+UDx47foFTEyfpYR+oo
         5chA==
X-Gm-Message-State: AOAM531pjFqRu/J340DT8MRhgFKGUTAp/ltwHm2zhFEpHQc8aXHb0g9y
        yyYmxdfYY5ie3PqaKmbVqPZ/Uw==
X-Google-Smtp-Source: ABdhPJzPZmiiSPn8NYBZz9JQZV5zCInb23uFxrcmDfmPXeBtb/Af6cyP5R8ZXhBXD3ODcmiULS2GGg==
X-Received: by 2002:a62:6003:0:b029:18c:796f:de1b with SMTP id u3-20020a6260030000b029018c796fde1bmr88486pfb.23.1606866209138;
        Tue, 01 Dec 2020 15:43:29 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i11sm16180pjl.53.2020.12.01.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 15:43:27 -0800 (PST)
Date:   Tue, 1 Dec 2020 18:43:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, peff@peff.net, martin.agren@gmail.com,
        gitster@pobox.com, git@vger.kernel.org, dstolee@microsoft.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <X8bVHQ1eyDkv2CLT@nand.local>
References: <X8bL7baFdXufk2jj@nand.local>
 <20201201233725.3396453-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201233725.3396453-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 03:37:25PM -0800, Jonathan Tan wrote:
> > Once we can reach a good decision there, I'll send a v3 (which currently
> > lives in my fork[2]).
>
> I did, but Stolee has a point that the algorithm will change later on.
> I'm OK with the parts I reviewed (patches 10 to 18).

Ah, good to know. I'll hold off on a v3, then, until you have had a
chance to look through the remaining handful of patches (if you were
planning on doing that). I haven't touched those locally, so it'll be
good to hear any comments you might have before sending another version.

Thanks for all of your very helpful review :-).

Taylor
