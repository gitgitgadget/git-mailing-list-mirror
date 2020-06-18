Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8DDC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8012070A
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT5xcA7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgFRBs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbgFRBs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 21:48:58 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BA0C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:48:58 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s13so3286259otd.7
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ft3fAmy3BJ2/npl9aeLAZh/+QMdTbGbUPeIVnRcsLzk=;
        b=IT5xcA7QKPJLXKvw7o23Ovry5dM1U0+je3v1FLSth9+ZECFqkEJLNQBa5idyuQwqVk
         3Dq/+ryH9k+8jRLoVzO/osDPDS1Zi3zgjt1fdd6AOi0O9NjOykMHHYWsI/mnJwc3PGBP
         hhWuiF9BryY1SDkvWE2zLsiR9IMxquQTRAP+aHEXTP2YOMgOacAjDdhcK3wwZVZIgP1h
         bFNk3modVZlwa/D6EefRvQIEjFT7vUxTejvk7BcB4lk7fK58OyZ04Zo3VfHA51TPH0h7
         pOjFGeaE23GiuqFNv84DNaZ+Ox6yP3nPyk82PB2iOuivFTwZjS1kHodYa+CKS+iiG7U3
         Znpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ft3fAmy3BJ2/npl9aeLAZh/+QMdTbGbUPeIVnRcsLzk=;
        b=TT9TnOw9NYzwKjeW2tpPnjvUdNnx+5bL7M6M8sSVWUVWEKO4vtwfCVSGow4rux8vRt
         xGRTfROGYs/6X4wJNixGzWVssuMR2/Mjw30gokKRMcvv1KEvi0Z9lzb2SkKxfvWIuDtY
         CTsXNIjWZ9GRD9qwcrYXJTnRiZ7li3hTDmlXlC7Cb4V3dQX4yFxVdQj+j0CdLbotruOw
         n0dWqKL4qgYKEFFoSXLG37o89E3hM8TWSVTwBV3ppwkKKHgRyYoHn/wrg+l7CMG+VCYq
         xELqhJElNhztjHucN+QLxOyzz6cDesqYKUFBKdiCqtKHfYZWY2naeoNhL2iLVt3fGTv5
         i1YA==
X-Gm-Message-State: AOAM532n2sQfOJ4vYELPfpRdw6EFeDv93lpKtbdtIzvTIgNJBY3lkdcz
        dD1+F4HXeqgfonwmdrXLgzw=
X-Google-Smtp-Source: ABdhPJwEjAvHBrqIyzvqjMMVMm+slbYD3BiKhUxPIqgpJIHyJ2JSpnMyRiFoFNqJgup4HAXOObdvrA==
X-Received: by 2002:a9d:3a6:: with SMTP id f35mr1497335otf.299.1592444937922;
        Wed, 17 Jun 2020 18:48:57 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r13sm386295oop.33.2020.06.17.18.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 18:48:57 -0700 (PDT)
Subject: Re: [PATCH 00/10] Szeder's commit-graph cleanups
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2e5594f5-5da9-0b7a-7bdf-122d8e615cd4@gmail.com>
Date:   Wed, 17 Jun 2020 21:48:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/5/2020 9:00 AM, Derrick Stolee via GitGitGadget wrote:
> This is based on ds/line-log-on-bloom.
> 
> Since Szeder so kindly shared his alternate Bloom filter implementation [1],
> I thought it worth my time to start the process of updating the patches to
> apply to more recent code in Git. Here is the effort to update the almost
> obviously-good commit-graph cleanups that he presented in that series.
> 
> [1] https://lore.kernel.org/git/20200529085038.26008-1-szeder.dev@gmail.com/

Hello everyone,

Is anyone available to look at this series? Hopefully all of the changes
are simple to read. Szeder did a great job crafting small patches, and
hopefully I didn't butcher them too much applying them to recent commits.

Thanks,
-Stolee
