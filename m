Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC82C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 20:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632D1610C8
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 20:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhIQUvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 16:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhIQUvw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 16:51:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB77C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 13:50:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z94so34352900ede.8
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 13:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=09geCO5DFEIt/4JFJui1xXWJ7C/OfFlfFpC4Z543MHU=;
        b=qOIaQJBkoUm43lZP7wjzRpncKFhUTRjGnYwv//w0sMnT3IJis2wcxzOgswNgJHKL+3
         TJQYkURAVcL/Sox39s2fN1vhryolzc19XNCaXyssca+1nPdFK86mlD9Q+MrJ6/+esmu7
         ZjvVuPhA7dOpelGTJlrsFiipgRU9iXVkWKHT3bT7/w68ZdkDBZp2ISaLY9PonX6UcQSB
         HfrT3Sm8Whwm9/AXomDVi872xUan0YiHHl46bzwZLzyEFwA6IbBdU5INkJ7C36mxEQ0Q
         6VpXIkF/4qzdFUcOwWXGJQ4oKMhS/q830je1S03yaPZXtwPnBlNLxfmNX/MeWfIfj78e
         MhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=09geCO5DFEIt/4JFJui1xXWJ7C/OfFlfFpC4Z543MHU=;
        b=w3HJlhFRCzXyvgj5xDpAMXz9KuV+FC6wsTVva9JzTCNbKs+kzFDI5bcQ0b+YO2dQVT
         U6DTd9XGDMGPrCxiWTKFrZAcc1GLoLKsN+8liuVmbcv2wEDvi2G7/jmiUOMX6AeRnvBH
         mI88mXEoIgJkGm54g3N0Tvwb2EGn4tcOQJcP2g0R9x6JX+X/cwwSu6l23nID+PieWnfB
         ggLmdA0I0S8hapxoiFjQPJ3oAQ1j9jBiahlA5a44naNG9TJSVjDmhHTLXPsBAj36dlB5
         KOgd+y1bI8fyoI1LLgInPCLRg+zo7zAfno96xVzEXJKiMDD8uokpQUJ0B/X1NgT4QtfM
         oRug==
X-Gm-Message-State: AOAM531NoVkWCiabKwyAedubEI7TEYJc4nGh1ubzx9FbEPHjkQR+0D8z
        BW9aIA6D2WC3K6r8P3oOh9ec3A==
X-Google-Smtp-Source: ABdhPJzGdE6yq+IdedeawZCHUVdom7dZVTiHuBZt1fG08NQl2DTmR0rB7Hc7X6YzFk31ZD1UvtNBYw==
X-Received: by 2002:a17:906:368e:: with SMTP id a14mr14184296ejc.60.1631911828270;
        Fri, 17 Sep 2021 13:50:28 -0700 (PDT)
Received: from vmiklos.hu (178-164-193-17.pool.digikabel.hu. [178.164.193.17])
        by smtp.gmail.com with ESMTPSA id v8sm2750747ejy.79.2021.09.17.13.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 13:50:27 -0700 (PDT)
Date:   Fri, 17 Sep 2021 22:50:25 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
        bedhanger@gmx.de
Subject: Re: [PATCH 2/2] request-pull: mark translatable strings
Message-ID: <YUT/kfsQnMaOQHRk@vmiklos.hu>
References: <20210916113516.76445-1-bagasdotme@gmail.com>
 <20210916113516.76445-3-bagasdotme@gmail.com>
 <YUNKIj44AlW0tkXk@danh.dev>
 <xmqqbl4stg91.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbl4stg91.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Sep 16, 2021 at 01:30:50PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> I haven't done or seen any official survey, but I would not be
> surprised if English were used as the official project language by
> the majority of projects that accept pull request messages.

That would be also my expectation.

But I don't have a strong opinion on this, I already have LC_MESSAGES=C
configured, and I assume many developers have a similar setting (to e.g.
get easily searchable error messages).

Regards,

Miklos
