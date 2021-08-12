Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4338C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 22:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C41860FC3
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 22:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhHLWl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 18:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbhHLWl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 18:41:57 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F7C061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 15:41:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y1so10614248iod.10
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cQSb+O2MGVYid1Qoji23rsGsHh0gwq303TxnbeXqLR0=;
        b=Un/iTmukvQmcWCywZjIG3Go9wVev9hKNnkUwGE2qr2R4hz4Xtd3HbQq9OkkC7ggczF
         HTfiHl7gscTkPBDb00hNvodME/1owHJhvsT9S2WtmxH5xf6J64cb5TfeeFBiQy7S74Af
         nUeiamyfQPGL17JNR2NdSb8oLU7S18UB1g6yM9gjQOmsZnWI/scIS76d6AUWqPJFCZrF
         AJyAzuou/cQzrYquCNXuKpzSvWqdQQqlRVYYrKe3HenviilOvN1mMUPqfYz3dKJZzPmU
         7tkJ6s1ryzy4/7h+lxo6YUv0M+3CphUIlJkYD3FB00WVbJzuVYWiCMcqihnKJmrlGUx+
         NjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cQSb+O2MGVYid1Qoji23rsGsHh0gwq303TxnbeXqLR0=;
        b=H8CrjPiB1s0d8PrmiALVUPQ31QoxsGc4NjlLJJwvEAzxQjpkNtCPfZHzgFvIhw/rCW
         OeegaKIEBqOwdwYAfWrRngCdX85Wyy0GYQDJSwtd1sCMCeVVzUkwWHh1/5sF/cJGl6zk
         +qvdUKoe4XtaLJRW1EFEboyWvTJnpEE3M+x7P8GDRhhDQWbjQMzHjK9HZMH8x5sOryB4
         BAwt7AIjGZrD8g284baE165zx3UqiIjqjmw0Vb0hI3Qdn8wHnukQozAhjJB53mFrhMDo
         TzkhgEsbx7hLH7CLEpbQSTgftLYncv1EDpizNjaYB9O75eGHqOVz64R06SOxFjXKu04b
         lUng==
X-Gm-Message-State: AOAM5306fFQFpZjLqu548/RU2BRjHBC3r30nNd3VwBrp24bsu2wvbiek
        R/GYMgJa98rmzzNq9wa6kbC3mA==
X-Google-Smtp-Source: ABdhPJxmBgyV4kgNzl11ctUgzyxlyCgzUCuvfdaZ/Hm4jGgWSI4iYr3By/aaYz9A8JVLYuU9kmtZ9A==
X-Received: by 2002:a02:7312:: with SMTP id y18mr2946539jab.129.1628808090319;
        Thu, 12 Aug 2021 15:41:30 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:1990:f69a:6a7c:f79d])
        by smtp.gmail.com with ESMTPSA id v16sm2057199iox.6.2021.08.12.15.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 15:41:30 -0700 (PDT)
Date:   Thu, 12 Aug 2021 18:41:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 00/25] multi-pack reachability bitmaps
Message-ID: <YRWjluDhPlMyQfmx@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <YRWQ6G/dYJC5Of1q@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRWQ6G/dYJC5Of1q@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 05:21:44PM -0400, Jeff King wrote:
> On Tue, Jul 27, 2021 at 05:19:21PM -0400, Taylor Blau wrote:
>
> > Thanks in advance for your review. I think Peff still wanted to read through
> > patches 16-25, but that the first 15 or so should be in pretty good shape by
> > now.
>
> I think this is looking pretty close. There's the close_midx() thing
> discussed in patch 9 that I think we need to deal with. In the tests, I
> found some little nits. Nothing serious, but some of it at least is
> worth fixing.

Thanks; I think I fixed everything up that you mentioned. The big deals
were about close_object_store() versus close_midx(), and the changes to
t5326 in patch 18/25. I think the remaining comments on patches 19-25
were thinking aloud instead of recommending any changes.

> So I think with one more fairly trivial re-roll, we can think about
> merging this to 'next'.

Great. I have all of that prepared locally, but I'll wait until after
Monday to send it since I don't want to dilute the conversation away
from release hardening (I certainly don't mind your review, I just
figure folks would appreciate me *not* sending 25 new messages to their
inboxes ;-)).

> Thanks for your patience with my slow reviews, and for all your work on
> this. It's really quite a complicated topic. :)

Thanks for reviewing. I tried my best to break this series up from all
of the ones that it depends on, but there was only so much I could do to
isolate the complexity. I'm glad that it had a thorough set of eyes on
it.

I'll look forward to sending a hopefully-final reroll shortly after the
release so we can move onto a few more cosmetic topics on top to
integrate MIDX bitmaps more closely with `repack` and so on.

Thanks,
Taylor
