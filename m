Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1788DC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BD120776
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="P2XBoiJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgDWVCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDWVCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:02:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE81C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:02:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k18so2840692pll.6
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=teOsHM7KDyEqsA8hshEokNOdIjFzTOmBdJnBc6uyNUU=;
        b=P2XBoiJqz+kTjw8jM1z+Shm9devvdUjo05t20XlkXNFWlHCQ+ZQ5j1IVc7Yk227/mC
         Euh8Zf4anKOHuI8C7Qw6WMFmREiUlnO2WALK9nfAY+k0XSUfzAePFREdy5GyW0A/ObNt
         EDNw6147mPsyFGFEdTG/eoSTtmE7IYuk1Q+ronL0Ldd4fOxYx7yXmaM57m6GScq2ffzg
         hWX4EJeSSKnfNP+N4IXkUEgGHmItQE99zCNFxQWwX07fX2lB0s2/gIofb7FFagVX65Ia
         E4t5gRBB1Undzq77aRNIgmAI66Xi15JpGGE6jrnQdgNOPnvixk/dM7vF4anMPiQOrUiv
         HrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=teOsHM7KDyEqsA8hshEokNOdIjFzTOmBdJnBc6uyNUU=;
        b=m/ErNBZaxutwQKNjxVQQfxmJ9mASZ6covDeBD2E9f5f63SyBmYOxcRQ3cFctLwzsAR
         8JIg6x2b8zcL05LhczGJCq8Iilhe7gJmEGTBYCsHcDlrjDHd7LAU/yF4ZSv5NlNrfuMW
         ZyLstoCjAOwlEccka53SnvmdefhIU9DnPjp8m7UJy77XmmePrElNgVRSVOfb6zh84AqP
         lSlvKUQuWBR5U4XCKtr56H0LqTLoVx/kmLRFBj1zODeKnvNtC2bM0a/1mysuvCTMDc9L
         8wXhoQ1LONQJKSmzhzkZu3VtPQ0hEO84jikXVAmP5lNclqSv1NMfvvSVxOr42FPbFdsJ
         4V9A==
X-Gm-Message-State: AGi0PuYRtcA9P6VHGEKTL5XcBnTHl1pRdccXZMOvZFXGfawA2ifammfG
        m6fSXAK8V54k3es7Ne1DhyXWRQ==
X-Google-Smtp-Source: APiQypKH2fGoU2S+RCTFaMLg31P2FAct+nADgtoHis2nU7OQyVuu2Jii1HZRyYr0CwNCarLkZK6ZbA==
X-Received: by 2002:a17:90b:128d:: with SMTP id fw13mr2813698pjb.23.1587675770767;
        Thu, 23 Apr 2020 14:02:50 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c1sm3442952pfo.152.2020.04.23.14.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:02:49 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:02:48 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] test-bloom: check that we have expected arguments
Message-ID: <20200423210248.GB46862@syl.local>
References: <20200423205851.GA1633985@coredump.intra.peff.net>
 <20200423205914.GB1634224@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423205914.GB1634224@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 04:59:14PM -0400, Jeff King wrote:
> If "test-tool bloom" is not fed a command, or if arguments are missing
> for some commands, it will just segfault. Let's check argc and write a
> friendlier usage message.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Looks all good.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
