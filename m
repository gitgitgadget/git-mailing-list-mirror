Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB21C433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7D164F02
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355319AbhCDAXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhCCP2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 10:28:30 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC3C061760
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 07:27:22 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id q85so24305955qke.8
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bmz7bo1UdYH+cuLhX7XtgLV8nuzBCUyj+ldZh/QrXsA=;
        b=jf/0ZgPuMbihyIdrVT3rzWiK8tIwl68p60ssrh/aL4il5lcHM5W8N16fAwzd2OdDkV
         fMQqlkjQ1NJgxjDHj/kBF02WFzWvw5N/kIaVgP7FheTIbro95QnIGhbwiH1K6TfpvAZn
         5R0/fjklt2AECkoIvRSEzLGfYnv/CJNncT4T34q0iepKGMpNDdx0JZfR7M4epcMxCEAS
         had0i3x8LijBDXWQo3ZLGWmBeWtvyr81nWuIFAT16T6gKao4xR8WdOZ4VwEcvxShG69k
         N/I0j30635dDGo09DNcG0IVEpi4NuaiyWAKda5c39xztfLgJwgjL5k0VWaYtnYuTMYMb
         n16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bmz7bo1UdYH+cuLhX7XtgLV8nuzBCUyj+ldZh/QrXsA=;
        b=BFGPdUcHpY4FxaKWdi4Jy8naGlg79CReN1N9k0i0E7BHtRNVW39CYoGFyLreNyZQyV
         wZmOWoAl6MSgbqeIkUmTALKK4xmZDcWomYl6eOZm0R6TRKDp6WAx83OJDykPtj92dncR
         dE/LoD5PitKkVFAdYt0gCUJaTrCdqWPNuAXgEUFikZaULoC0hdPSNWstamKSr2UFi5p5
         JfCNmz78tMvAmvIObrhj1IYzlcfypwmTpCvjsyxjHXruBly9Rcp9RQ6syGPhdfagtD29
         eutGiZzOsvZcAzvA4KKKftfWXwgSEGddIlAh67vDgvw8RSsDU1I9FD8SCqN+WuqKmtu9
         5yQg==
X-Gm-Message-State: AOAM533ussaedqrlws4ZnAOuweePuuqvdPrGC9R/50lU3xauj10FYHYM
        5mQaXeHYjJRfjVD1aX5W5N+Vdw==
X-Google-Smtp-Source: ABdhPJx3R2/g965ThQRr9K3VBREtZvHD+LsmVrLqfwYj72Gfv/19BdyCBpW3scf0eRW9LBNuMYOwZw==
X-Received: by 2002:a05:620a:2013:: with SMTP id c19mr24014039qka.403.1614785242018;
        Wed, 03 Mar 2021 07:27:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe2:f960:a24a:8111])
        by smtp.gmail.com with ESMTPSA id z65sm15567520qtd.15.2021.03.03.07.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 07:27:21 -0800 (PST)
Date:   Wed, 3 Mar 2021 10:27:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 13/15] pack-revindex: read multi-pack reverse indexes
Message-ID: <YD+q1lmA8lFzDMT2@nand.local>
References: <d4e01a44e72998f88dc253cd04845ac2e6bb165b.1614193703.git.me@ttaylorr.com>
 <20210302183620.11040-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210302183620.11040-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 02, 2021 at 10:36:20AM -0800, Jonathan Tan wrote:
> > midx_to_pack_pos() is the trickiest, since it needs to find an object's
> > position in the psuedo-pack order, but that order can only be recovered
> > in the .rev file itself. This mapping can be implemented with a binary
> > search, but note that the thing we're binary searching over isn't an
> > array, but rather a _permutation_.
> >
> > So, when comparing two items, it's helpful to keep in mind the
> > difference. Instead of a traditional binary search, where you are
> > comparing two things directly, here we're comparing a (pack, offset)
> > tuple with an index into the multi-pack index. That index describes
> > another (pack, offset) tuple, and it is _those_ two tuples that are
> > compared.
>
> Well, the binary search is indeed over an array :-)

:-). This might be more clearer as:

  ...isn't an array of values, but rather a permuted order of those values.

> The patch itself looks good.

Thanks.

Taylor
