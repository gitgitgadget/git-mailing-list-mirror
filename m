Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E3DC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 01:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1954061004
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 01:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhILBwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 21:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhILBwV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 21:52:21 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEFDC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 18:51:07 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id l10so6242439ilh.8
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 18:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c7O4qnvaa4A6O33AOqR2UqQ/SGiim7OnnX0sX2ddt4c=;
        b=dBkpPGlruFt4nyhmGdAn4M9k/JXic8PWNybQGPbfmjeFP88v3BF54nGTnGYibhfAti
         auegbcu19WUV3zl4b3C/4r4BtwA9gLM2Q71uyiHf9iZZ9aCqHYSMxWby05BFwihB+xGk
         KqOnXVFaTs0zYCdmvaqAia0WAUQaWWkvbAH/Inob51STGZ60KUGYOUX8myYL0lbs4lAK
         gGtgzvCT7Yv0BxcJdPqzgvTLPkXq+MtmULDQjzpX92NCXUBD0mFHlS0rJ0UgyGcPdbEw
         go0YXUY9rHIhQH5wPKMLtw3XMlK4sCHamNmnuJJcPNRaBPbbzPj2OXQQdkniOapXKyET
         bS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c7O4qnvaa4A6O33AOqR2UqQ/SGiim7OnnX0sX2ddt4c=;
        b=pgdd1nH6TcqeygD9OSwbJxv15cG0pgjmg/+y56AtAaxPSvuTV0iDNbAZQFoDSbjb++
         GwNBEoPrJHQdpht0jKV/JWtb3ymhRhiQ+MCEEgH0yW3RUK6qfyx4ZKIcKkg+LLP+6Nni
         xiHfRXzDgXj0nNm66flcGV+Ji9xn/3FNsHO7iQklVNcn5kZ4OOFtbBOjDAFzeHAZvnzc
         W4WVQpggZYu1wDsaNKlSCLCXwdXI64gbLtooltFZxrODlQMiftA4l0oY67dWLN2/d2SX
         RpjwdlO8bea9dBRklnbkmuvhVuCo5tpk3VZbDin2H/7AWx4kh3iNvRbqGdaVI4moP7zQ
         qf6g==
X-Gm-Message-State: AOAM532kFD51TuaT0l9KC++YpNgjBfPUzV9qgqPFDdHQeYqJC01HolnL
        G14QKF7XZoVZGTE0T/Q/SUZyBQ==
X-Google-Smtp-Source: ABdhPJzWMykT+wIJf1mdIyIO45dkgkq77K9VAgYsbpRwuz2JA2kBTXw21aiuk1Onz9d9kfV7IIgXJA==
X-Received: by 2002:a05:6e02:120e:: with SMTP id a14mr3237631ilq.222.1631411466032;
        Sat, 11 Sep 2021 18:51:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n2sm1920259ile.86.2021.09.11.18.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 18:51:05 -0700 (PDT)
Date:   Sat, 11 Sep 2021 21:51:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] packfile: use oidset for bad objects
Message-ID: <YT1dCAuCE7xIIIk/@nand.local>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
 <9cdf54db-132e-d771-e177-6673f7ad02bf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9cdf54db-132e-d771-e177-6673f7ad02bf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 07:59:40PM -0400, Derrick Stolee wrote:
> I initially hesitated to support the drop of
> nth_midxed_pack_entry(), since it was designed with things
> like midx bitmaps in mind (specifically, to also support
> lex-order-to-stable-order conversions).

I didn't know that nth_midxed_pack_entry was designed with either
purpose in mind, since it predates midx bitmaps by quite a bit.

> However, it seems that the midx bitmap series by Taylor is succeeding
> without needing such a translation.

Right, it looks like that function is only called by fill_midx_entry()
where it was inlined.

Thanks,
Taylor
