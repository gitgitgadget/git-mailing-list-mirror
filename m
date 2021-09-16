Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD18C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518AC610A6
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbhIPSpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242883AbhIPSpI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 14:45:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D8C0F9CA0
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 10:15:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id bb10so4322536plb.2
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S0+XzVbd2n1ukW72gFOtKoXLMF16m1Ci8Tu2cQ3VKAg=;
        b=k0nDvg6ef7Df9Ku7OSZKX6ymJMCI/zlJZpc9vNBBnv9UuGxCZElOoiqpbPTRunv4EI
         g56ch7kk1RIgiq8JYKTC8SmZr1+y6le5Th/bPTJoqSMo3Cln1MZokWHnedM8AeWMJNRX
         wsX2RLq+UZcypPv9LKrZG9DGsjaneKrndsnai/BxqCT5ZlY8eeFip1G0qWPNiypAKkkK
         Z+tGwcuWj5LZQuDioqWgx6GgtpOem3F2faI0Gpf3mFlIo4GHeOY6bDi4ay7DySwrMJrZ
         u8yh5dKImUACplmJtkCbDyE9aJTG+ngbXKp/+tlo0UGbceHm//6F4+9v1TFAeNiqZAh5
         EWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S0+XzVbd2n1ukW72gFOtKoXLMF16m1Ci8Tu2cQ3VKAg=;
        b=2pvspMgTi5Nk5/jijOIjo82OCenk3W0RRUShnd3IGEZRhxSWBy7xS/xP1Hfp7DnP0w
         oBnwmiTfzOki4X/OWGdcepJeM2BFJoGlnuGh72q8DqIiEBT8IgUOBwi5mprHEWLGPVfn
         tY0vKbMBsGn3vDebr100gRmMO/09iZqkWXqmCtY8oLoDEDxiiGU5qAq/MzYt4CdJc2vU
         YCPt+cO8iEsnWDVohMWHYW9b5gvzKOjTzycm/3+OqLMmCHfZ/acW2qCKgwrGzN7vmVcq
         ubFfvySnafwmOdLsGy61Hg4GzqhqSeXmlOrxKcSF0y1e0/ev+FkHL76GvT8vGFuMf7Lr
         xpZg==
X-Gm-Message-State: AOAM530Co7noAFQde5sePSmdAmM3+TsGEbz09fwuh2J0pkt8C5QINa4N
        8V/g5u8eNlo0iiYrMjwjub3CPA==
X-Google-Smtp-Source: ABdhPJynTR6aiiiP3q9G9tRLfHOSCG/Yedj59w30zRGzOccJ6XWwwEMk+7Mwx6xURBCSW/X2WC2lvg==
X-Received: by 2002:a17:90b:4b49:: with SMTP id mi9mr15795542pjb.79.1631812523635;
        Thu, 16 Sep 2021 10:15:23 -0700 (PDT)
Received: from chooglen-macbookpro.roam.corp.google.com ([2620:15c:2d1:206:a5be:2e8a:d727:158e])
        by smtp.gmail.com with ESMTPSA id v17sm3559859pff.6.2021.09.16.10.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:15:22 -0700 (PDT)
From:   Glen Choo <chooglen@google.com>
X-Google-Original-From: Glen Choo <chooglen@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 16 Sep 2021 10:15:20 -0700
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH 3/3] gc: perform incremental repack when implictly enabled
Message-ID: <YUN7qEJ2C9wuAuEu@chooglen-macbookpro.roam.corp.google.com>
References: <20210913181221.42635-1-chooglen@google.com>
 <20210913181221.42635-4-chooglen@google.com>
 <e890300b-4a9d-8c08-84f2-c20b28214da2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e890300b-4a9d-8c08-84f2-c20b28214da2@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 11:00:34AM +0700, Bagas Sanjaya wrote:
> I was wonder what the correlations between checking if MIDX is enabled and
> performing incremental repack are. What are these?

(I'm not an expert on the issue, so don't take what I say as definitive :))

Here's what I was able to find in Documentation/git-maintenance.txt:

  The `incremental-repack` job repacks the object directory
	using the `multi-pack-index` feature.[...]

My guess at the intended behavior is that disabling midx should make
git-maintenance behave as if it were unaware of midx features, such as
incremental repack. This is quite akin to the documented behavior of fsck in
this patch series, where fsck only verifies midx and commit-graphs when the
respective features are enabled.
