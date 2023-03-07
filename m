Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90E6C61DA4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 00:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCGAur (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCGAum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 19:50:42 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F39251FAE
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 16:50:41 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id h7so3549947ila.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 16:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678150241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8p8nw8rUsnbmy2e9CWJT16xs76/cJooBC1MVT7oIsUE=;
        b=p5JM1P6LZXljIrnMWDAqgWAyM/L8bTeeGHawi+rRRfuVIpPszVEB6sbiYslJ1XIN1O
         8lTRp6EjMGmrJkNZcSPmhdmoK4bdhfN/o2t/iDebUwOMRwCdXQU7Z0xbTIap/9qtXFW2
         FoUDiMLnolZ6JF+JzuguRAAPop6PDIqErnalWhXhri0Xd+EWwalmIfhbPjkPA1bvHcav
         cI83PFyd0PXP5m/V+GrHdKpAgfRVl6SkunHQJKsGr392pQsC2Xg6DW4KqmYwGvR1ksg0
         k6XSxW769puIz48pQTE3Jziqjj36xloZjOGa2ie3Cqlbzae889IEZPsD6hWdIramT9oe
         xYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678150241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p8nw8rUsnbmy2e9CWJT16xs76/cJooBC1MVT7oIsUE=;
        b=cAPQ2KCVYhaWj6vyPbpOKXh7mo7nT3PRxCZMxUnYC4RKuqfan93TbuzlLeTgaZB2xG
         ylzSM+TSQEAwvyvT7JvVWacwx7bfnwsuGq2R3kmdd3OrluJDVykSIWKLpggQ/Kv0IsSx
         FwUNb6kfnvIaqCTrPlPetqOFIx+3yXE4+IZPz6WKsR846OwuiGDsWYU6Z7naYQQKYplg
         2obw+fdAaGhJB1K2PbqghqlBa57Ip2U7hjMwY/Hu1frbTqSrqayoKy6NTXGaI6HbgQFk
         PoX/9AMeMPt8zaNTn2WtgGMvQOADBP/MZy8TnxDcYbzqAo8jsbLf4VuuSPc03jLOIjoo
         q+Tw==
X-Gm-Message-State: AO0yUKX3mTQ3RJ5GavtCaCwCbZSqyiQGtDXQMO2Wb165sjlvCovzbLxD
        RVlLZzRgl9pbyiUwzgMjnB9iQw==
X-Google-Smtp-Source: AK7set+VyjyMDf3PrATIVx8HLNO/rMagn9YOYjPP1rmOygQU7xpob76XLKScDS5fo6+hDwjFwfz7dQ==
X-Received: by 2002:a05:6e02:2182:b0:317:9098:1d with SMTP id j2-20020a056e02218200b003179098001dmr10920451ila.31.1678150240719;
        Mon, 06 Mar 2023 16:50:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i21-20020a02ca15000000b003ed2b203106sm3587772jak.164.2023.03.06.16.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:50:40 -0800 (PST)
Date:   Mon, 6 Mar 2023 19:50:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 6/8] commit-graph: introduce `ensure_generations_valid()`
Message-ID: <ZAaKX8eUeAHBhA7B@nand.local>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <f31994ac78aa7aff11d923a77be6b0652f3af70d.1678111599.git.gitgitgadget@gmail.com>
 <xmqqttyx90gr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttyx90gr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 10:52:20AM -0800, Junio C Hamano wrote:
> "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Taylor Blau <me@ttaylorr.com>
> >
> > Use the just-introduced compute_reachable_generation_numbers_1() to
> > implement a function which dynamically computes topological levels (or
> > corrected commit dates) for out-of-graph commits.
> >
> > This will be useful for the ahead-behind algorithm we are about to
> > introduce, which needs accurate topological levels on _all_ commits
> > reachable from the tips in order to avoid over-counting.
>
> Interesting and nice to see it done with so small a change thanks to
> the previous refactoring.

Stolee did all of the hard work ;-). But chiming in to say that I
remember all of these changes well and they look faithful to my original
read of them (as well as what I wrote in this patch).

So, LGTM so far.

Thanks,
Taylor
