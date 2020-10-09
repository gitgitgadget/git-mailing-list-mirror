Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2F5C433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2EB222B9
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BRG5a7UM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbgJIS2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388114AbgJIS2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 14:28:38 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB548C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 11:28:36 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z33so4809062qth.8
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8pvox6nTsAkYLzbpPRhGVc2y09yCmEnSvFrOWxSncx8=;
        b=BRG5a7UMOpIc1SDqgFrpKD1oMQRDfiA7M3oa3yREp5kAlGJ3vJCEbIMU0VmR7TcY38
         pCgurx6fHzS9QepsxD2kzpxvn4496rSbCKtUje9ORuckU2cDUTTnxCneafRoibIkRlfC
         1V9HNl+mEHKvAspSj9TbJE0dFTZLQOSpwkHnVP68OniicGBzsx3XpaBWE6kUticCjyoj
         OfNEp8horm1QkDgJ0wwC6DIt55LQ1rGx1op9vlxJWwZU638Suwm7vP4HnDxKYjPk7FHO
         IkEpe9bapogJKqZO6ks88yIEWciw1FK5HteK2cse/j7e2HjuS1LVCVs2iyZXFfN0cp9p
         65xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8pvox6nTsAkYLzbpPRhGVc2y09yCmEnSvFrOWxSncx8=;
        b=PGwC2GIp3gI+X5C9kKfdyk+660NiviCiLeRNd33A2BNGEg+Mt3g9gXhm2RYxUEqKXr
         esGNH06UWxWB8XPblg1XYt34BywylSUTWbynzjyyiC7+KEE8KK2+uUJLfp6MsB6hL9tV
         u1OJmemYi3Vvj9hWvX+5+yA1Yh6iSlxaxrUnEdP/gxmQOPwGTQG62yy874m62EhYKLi5
         ARUKdZ4i+6P4OWuTAR5v+z8aQzOznKlu+VSLtX0a527NjVBqrcY1G9La8rBCwooOOBOy
         +fABucIBc+vIKl3iOEqM4YahlQ3LZ7zBlxgOgJnuPaYQ/YnW3Ik0HCFJoBuldkwCzlJG
         r6Xg==
X-Gm-Message-State: AOAM531+WRuPXyQJypQ1i7dd7jIYG3cxs76M8K8NUTcG+a34ajmceCme
        7KbURmnpHNWT5Xb94JxwHBiZnw==
X-Google-Smtp-Source: ABdhPJy2kzhuT7k8FdAG5SISseW/bzySTkef1rv6kG4nfvEUIfcvv6LBFKVgFVoxqfr015bC0SqG3w==
X-Received: by 2002:aed:2489:: with SMTP id t9mr14799784qtc.358.1602268115921;
        Fri, 09 Oct 2020 11:28:35 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:b0d1:9fbe:54fa:3044])
        by smtp.gmail.com with ESMTPSA id a66sm6912957qkd.47.2020.10.09.11.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 11:28:35 -0700 (PDT)
Date:   Fri, 9 Oct 2020 14:28:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Taylor Blau <me@ttaylorr.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
Message-ID: <20201009182833.GA437455@nand.local>
References: <20201007210609.GA1984296@coredump.intra.peff.net>
 <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
 <20201008120658.GA2689590@coredump.intra.peff.net>
 <52782500-274e-2c72-39e2-be4252959d47@gmail.com>
 <5bbdaed5-df29-8bfe-01c2-eb2462dcca22@gmail.com>
 <267a9f46-cce9-0bd3-f28d-55e71cc8a399@virtuell-zuhause.de>
 <0d25e0ab-31ab-54c2-b518-bd9c0b0c4b7a@gmail.com>
 <2f30099a-4a3d-00f7-bb08-ca6c1f76bcd4@virtuell-zuhause.de>
 <64de22fd-2e1b-aaab-3a8e-f6f1d630a46e@gmail.com>
 <20201009175506.GA957408@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201009175506.GA957408@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 01:55:06PM -0400, Jeff King wrote:
> On Fri, Oct 09, 2020 at 01:46:07PM -0400, Derrick Stolee wrote:
>
> > > Can you reproduce it if you do
> > >
> > > git config core.commitGraph false
> > > git config fetch.writeCommitGraph true
> > > ?
> >
> > I _can_ repro it in this case! I think there must be something
> > very interesting going on where the commit-graph is parsed in
> > _some_ places, but not in others. This is something that I can
> > really start to dig into.
>
> Here's a much more minimal reproduction:
>
>   git init repo
>   cd repo
>
>   git commit --allow-empty -m one
>   git rev-parse HEAD |
>   git -c core.commitGraph=false \
>       commit-graph write --split=no-merge --stdin-commits
>   git rev-parse HEAD |
>   git -c core.commitGraph=false \
>       commit-graph write --split=no-merge --stdin-commits
>
>   git commit --allow-empty -m two
>   git rev-parse HEAD |
>   git commit-graph write --split --stdin-commits
>
> The final write will die() with the "unexpected duplicate" message.

Makes sense; the second commit-graph write won't know that 'one' is
already in the graph because 'core.commitGraph' prevents
'prepare_commit_graph()' from actually loading the graph (actually
loading the graph would be enough to stop the second write from
occurring at all.)

I'm of two minds about what we could be doing here:

  - On the one hand we could be ignoring `core.commitGraph` setting
    during commit-graph writes and forcibly loading the commit-graph
    anyway.

  - But on the other hand, writing a commit graph with `core.commitGraph` set
    to false makes no sense. So, I'd almost rather have us die()
    immediately if core.commitGraph is set to false.

I think I'd advocate for the latter, along with Stolee's patch to not
die in the case of duplicate commits in multiple layers of the graph.

> -Peff

Thanks,
Taylor
