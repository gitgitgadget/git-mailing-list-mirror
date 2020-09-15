Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E45C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 19:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D9120770
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 19:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VOfgUfLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgIOTcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 15:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgIOTci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 15:32:38 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3165C06178C
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 12:32:04 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id db4so2321170qvb.4
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wDHULpkCcDEGpO7QSZmKCcPeBagkYbOmwb9Ob262loo=;
        b=VOfgUfLA784aIEgmhZyfc2cB/9egnsaT8cbFHtdZyx8h3NNwdlXoGHhAyxTAcdvVrL
         rWw1XVQa1ySvvjqpJRwFiHE+MKqvYEV1H12NpXOhe5fvU+WK/lrRHcm9DRshaohtneUJ
         wY1+hxI6P8Ay+injuHUOx+xAdCpsN6N5IoOREVV8H680zS0v58WIwwSkonxMMuhf283w
         ZcmqeC7e0HeoZI4+fQX7XrmTSDq856MCka5btYSSFkVYkHC8BPjEx5lCvhaaiITWiHU3
         ZI2y5qNY10hHLlgElliZr6QMw7lkBxSmo7Ds6qdtB2dcBbZi1AdI/42gYyMOst8+yu4c
         NrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wDHULpkCcDEGpO7QSZmKCcPeBagkYbOmwb9Ob262loo=;
        b=J3Nl0KvKUz0HMPYbiUJnkJVeeOdTk9chBQtWUqX/CrjgSYg0/kiM9iSu/1YS01W5go
         IdK0JpsqTFCQQZd57rCG1nDMZVh7x7cdyFHf1a/QOtTcLnH6mh9cfigOAvewsMV6P13B
         0XIUk1bCj6bDgmznK0OAGDLV7hNrlLmGL5Fn1sgRbiyXUxVKDmJT1u3tRcXWf05273Wn
         2qKehwZCtYIb+NWdZETT6E2b/8Kweqnj/XlJh3VMqqrgvZMTINViRynixCz1J+VuIJt9
         TL+UpfOlTm2X3Eg6ZErwNGCaJLEXfMiZcoPGsk7bsLrOhjnaXVBO7bovOUPcM1zLZA8V
         740g==
X-Gm-Message-State: AOAM533D/zdx70TKvO3nMQ2XnlNW3yJN7j/YYbC1qf2XWq3TlrVovnp8
        Vj7It4ZrdvKYCpu6H3gRayLE3w==
X-Google-Smtp-Source: ABdhPJxTxDzZEwVwPzylTxrfnsfMcFMI2uZ20+LYiw4mf+6yd1+o6XZwyfgHUsG59E2/LQcH4UNFxg==
X-Received: by 2002:a0c:9a01:: with SMTP id p1mr3209926qvd.61.1600198324206;
        Tue, 15 Sep 2020 12:32:04 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:209c:e081:d56c:21a0])
        by smtp.gmail.com with ESMTPSA id w44sm18315766qth.9.2020.09.15.12.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:32:03 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:32:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
Message-ID: <20200915193201.GA1741@nand.local>
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
 <85ft7ivp1t.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85ft7ivp1t.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,

On Tue, Sep 15, 2020 at 09:05:18PM +0200, Jakub Narębski wrote:
> I'd like to point out that latest series of patches by Abhishek Kumar
> which are final part of 'Implement Generation Number v2' is at what I
> believe is next to final iteration:
>
>   "[PATCH v3 00/11] [GSoC] Implement Corrected Commit Date"
>   https://lore.kernel.org/git/pull.676.v3.git.1597509583.gitgitgadget@gmail.com/T/#u
>
> It is waiting for the decision on *how to implement storing* new
> generation number in the commit-graph file: should we store corrected
> commit date directly as 64 bit value, or should we store corrected
> commit date offset as 32 bit value with overflow handling?
>
> Switching from 64 bits to 32 bits halves the size of the GDAT
> (Generation DATa) chunk, but decreases the size of the commit-graph file
> by at most 7%.  For large repository, like MS Windows with 3M commits in
> 2019 it would mean decreasing the size of the commit-graph file by
> 11.8 MiB (if I calculated it correctly).
>
> Because corrected commit date offsets are not monotone, that is after
> value that doesn't fit in 32 bits (in parent) there can be one that does
> (in child).  It is extremely unlikely that in real repositories there
> would be that large corrections needed, but it can happen in theory, and
> therfore we need some way to handle overflow if we choose this option.
> And of course we should test that overflow handling works correctly.
>
> So there is tradeoff between complexity and commit-graph file size.

If you think that not being able to fit into 32 bits is unlikely, then I
don't think it makes sense to store those same values inside of 64 bits,
either.

Of course, that means implementing overflow detection, but that's a
small price to pay for shaving off extra data from the commit-graph
file.

> Best,
> --
> Jakub Narębski

Thanks,
Taylor
