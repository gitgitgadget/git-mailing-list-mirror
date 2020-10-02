Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E0BC4727E
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 00:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7667C2168B
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 00:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fotquRQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbgJBAis (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 20:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733249AbgJBAis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 20:38:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BDFC0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 17:38:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so221528pfn.8
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 17:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K9ThW1rr+zsJ86TT9oMRW+uUaFnmmHi8WQa4Z/Ah8vo=;
        b=fotquRQ1r/pKgqJ9z7+/sNXCAkfRB+wPPxv7FJypUAL0nnu+IzcLSSU+XciPaEeo+l
         vwWgT99g7w2M0j2pBHEOTCYva9euga0oGpYHiNLkj4VU+WPswrxdyGbOXNEd+CC7m/Eg
         9q/2LqUFEdI3qT957S5BQB25ss2yCnTwtebkdLAV99E4OdbkYatwz4fLREJFWU2e1zVv
         QLhNN+ixRfwOQpjwOygQ/MGkRFGIhJQj54e4kQki3CJZA6jzYyBkGHxv25P1Op30pgUk
         GTYOjPeAIwJK94YoYmlimlbp3rwLQfqQdKFLSGi5S+oSARJvrQ+m95cYfekDyxjYW0+7
         S+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K9ThW1rr+zsJ86TT9oMRW+uUaFnmmHi8WQa4Z/Ah8vo=;
        b=LnHFF/IhVcyZhRxXoZRhv1SbNLDBCskwcwjMvFS0eBLDPM0smGBID9asSsCKOV3pDp
         pSBvGvIUXCQlDrWm9beTwKfWw60EEEE19yJZLefkE34Nh2sGOJskHBqrZmiIzlqm2Mzu
         BjobbGHOkOX5HDhjSxWhLQcR6LvaVuO7mCztHalHFvMt63SMB9o3rbDWU9l+2h4Hhhke
         dBVQSinSOq5SN6U8aa/z4aXCEt4GV8K1UnpwuE8uyFDRyPFspqh7R/1LyCbz4XVKw8iC
         V4CNmRLGKrg5GYddNc3Wt3MIxgptw4AuBv+k87M4jDPQrog37/9O2hk9/vvQxpnPepr0
         SV/Q==
X-Gm-Message-State: AOAM5338WrNR6CX0nzp3gVwju9UAmkDkRRYcfLOqnypEA4Ixcof/CCfn
        IcDzXC6u2ep4/sECH2+Z5Vjmk3fuTOc=
X-Google-Smtp-Source: ABdhPJzVso0PKkcCIzF7U3Oq0lFumohTYI/ozhi4rUv2o1sJNIkXVY3x8VwFx1gstWaM1ws1hyaodA==
X-Received: by 2002:a62:3605:0:b029:151:ee7f:d910 with SMTP id d5-20020a6236050000b0290151ee7fd910mr5213745pfa.49.1601599127551;
        Thu, 01 Oct 2020 17:38:47 -0700 (PDT)
Received: from localhost ([2402:800:63a8:8180:8ec1:c51e:c16e:7fd])
        by smtp.gmail.com with ESMTPSA id u4sm7144305pfk.166.2020.10.01.17.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 17:38:45 -0700 (PDT)
Date:   Fri, 2 Oct 2020 07:38:44 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 6/7] maintenance: recommended schedule in
 register/start
Message-ID: <20201002003844.GA28643@danh.dev>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
 <f609c1bde27558db2a9601ac34f8a51ce86f0e2c.1599846561.git.gitgitgadget@gmail.com>
 <CAN0heSqkJoqXKP5ccaGMA1_ppd0bcQ7G0ozUH+H7tBMonhcrjQ@mail.gmail.com>
 <bb9cd08f-1e59-ae19-b184-545688451203@gmail.com>
 <3e18199a-1dcb-057d-4753-03d5acfcc036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e18199a-1dcb-057d-4753-03d5acfcc036@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-01 16:38:48-0400, Derrick Stolee <stolee@gmail.com> wrote:
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 7628a6d157..52fff86844 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -37,6 +37,21 @@ register::
>  	`maintenance.<task>.schedule`. The tasks that are enabled are safe
>  	for running in the background without disrupting foreground
>  	processes.
> ++
> +If your repository has no `maintenance.<task>.schedule` configuration
> +values set, then Git will use a recommended default schedule that performs
> +background maintenance that will not interrupt foreground commands. The
> +default schedule is as follows:

I don't mind about using a default schedule (but someone else might).
I think some distributions will be paranoia with this change and shiped
with disable by default in system config.

> ++
> +* `gc`: disabled.
> +* `commit-graph`: hourly.
> +* `prefetch`: hourly.

However, no `prefetch` in default schedule, please.
IIUC, this is a network operation, if someone is on the go and paying
their internet based on their traffic, this will be a disaster.


> +* `loose-objects`: daily.
> +* `incremental-repack`: daily.

And I would say no incremental-repack, too.
Users don't want to a large operation of IO on some random time of the day,
be it when they open their PC in the morning, or when they want to close
their laptop to go home.

----------(Windows rant ahead)
I still remember those days that Windows 8 was introduced,
Back in that days, my computer still uses the old 7200rpm HDD.
I was super-angry that whenever Windows is started, it starts some IO
disk-caching, indexing that hung my computer for a good 10 minutes.
While that same computer can run Windows 7 and other OS fine.
I don't particularly care how much my computer is faster after that.
I want my computer usable at that time, instead of wasting a good 10
minutes on nothing.
---------(Windows rant end)

Either the users know what are they doing, or we don't do anything at
all. Let's them do it on their free time.

IOW, Please let users opt in instead of opt out of this features.

-- 

Danh
