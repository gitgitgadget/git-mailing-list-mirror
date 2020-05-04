Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CA7C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B62020707
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="FzO48s6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgEDWPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 18:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgEDWPD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 18:15:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0458CC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 15:15:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o18so62569pgg.8
        for <git@vger.kernel.org>; Mon, 04 May 2020 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sppQ4AAdMEXkYaiH2ztAqvfqaty6jdyrCVbaIt4fzC0=;
        b=FzO48s6ckJYIE40JoMuV868B88pbF6Z+rwHq6g9sVDpdyf71XsFZ+If4L0YmioiIp2
         VqYLtLeg+WBJfTjoiKHvowu9u8TpWLw8vaT3H0FJj1kmfwfmmfs8YoEuZttMw+b1W0Go
         A47YwpGXmJ4DKW96JMFLxgTxCY4CYnviau6cG7ekm50KUWBoJ0jhxioTaF01lpHGIKLW
         OuBpEc0tq95FPGOD1Bm6KKGo9+DDHRJnJ0r7d1149JNAN/FV8gkvtwI4kG+DubYJ/U0b
         r6jkhmfVKwVO4wsvouBJoA6mFGyunKaSB2lhZkYahka4ROxSqlMlBETboc7y0RSzObOa
         PGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sppQ4AAdMEXkYaiH2ztAqvfqaty6jdyrCVbaIt4fzC0=;
        b=RczVYsYUFj3nwxhpEWQ/XwXayYJbzXq0DsfMQcV819L00X6ZDiBUBckHPrg0RkST15
         S3f5jkB/17GZAy+zFqhfxeA9nEkp0kdt1ey7f0StkPBlf+jkReXmugfKjkPtLpauYhoX
         w3eADfHUZJzLbTdPAwJY13KnMAdyN2nsHuxOZMShnKkVBWhozmhbVZncCmkuihHssetu
         1NlxiakZTJOcgSmXAmfLkvJq0IUgMaTEUpOPdo/sVSJ876cRHkRvgLDf4mLauCGWlelN
         z5MNysj3HjnYRenJncgpRShysiqpSpxQK+jEPxlddho5ywmuJ+G3k5XZ8kT6BdTmgBlj
         hL+A==
X-Gm-Message-State: AGi0PubXNhuP5ZZl9wJE0OUTbCLIkeBC5hkBleRLHOCrMGsTvgtlJh6M
        DuvRLVZw3mwyEOUOfFcMMPvSS/7bCnlXGA==
X-Google-Smtp-Source: APiQypIspaILMiKWe1miTHFTE2+d2xDxOzCPxXHuOprtuECf45TiSYIGbahZ0l0B7vqaIjGmsR9O9A==
X-Received: by 2002:aa7:8593:: with SMTP id w19mr48794pfn.97.1588630502295;
        Mon, 04 May 2020 15:15:02 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id p66sm84970pfb.65.2020.05.04.15.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:15:01 -0700 (PDT)
Date:   Mon, 4 May 2020 16:15:00 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: avoid memory leaks
Message-ID: <20200504221500.GG45250@syl.local>
References: <20200504191324.201663-1-jonathantanmy@google.com>
 <16be6de4-3453-2fc2-2881-7068bf674517@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16be6de4-3453-2fc2-2881-7068bf674517@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 04:20:41PM -0400, Derrick Stolee wrote:
> On 5/4/2020 3:13 PM, Jonathan Tan wrote:
> > A fuzzer running on the entry point provided by fuzz-commit-graph.c
> > revealed a memory leak when parse_commit_graph() creates a struct
> > bloom_filter_settings and then returns early due to error. Fix that
> > error by always freeing that struct first (if it exists) before
> > returning early due to error.
>
> This fuzzer is an excellent tool that I hope can continue to be
> extended to other features. Here is a case where it found an error in
> a feature long after the integration was introduced.
>
> > While making that change, I also noticed another possible memory leak -
> > when the BLOOMDATA chunk is provided but not BLOOMINDEXES. Also fix that
> > error.
>
> Thanks for discovering these issues, and for fixing them!
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Since it already appears to be queued, I'm not sure that my review is
adding much. But, this fix looks very good to me, and I am grateful for
you running a fuzzer against this code, and finding/fixing bugs in it.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> Thanks,
> -Stolee

Thanks,
Taylor
