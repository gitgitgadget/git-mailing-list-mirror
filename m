Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7944CC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1ED2073E
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PQ/JfPh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgHDA5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgHDA5B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:57:01 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0EC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:57:01 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dd12so13254337qvb.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DqaqzzF3+y9uoolI2d6F/zFbKHyNTtdt29pbbWJv/JY=;
        b=PQ/JfPh2DpdUjgIFkr9ScQvYYK2X9/X+M0Fko8iOOhM01zjthOr59puVjM78VZ/R7s
         bP9DWHr7EcgX0oYp0vqJsGPw8jMw5jXVlgwggmWZuFCSERmXGnBtwgbbGzhxTnuQNCE8
         +YhQb2Ha3Qk/bAKFRbnaKLd8J/1WNjdb8lbV0kRcCzfHBHKg5HRl3/Ax8DhpuVf1eoHA
         U4ZWHt0BZluyUUFxL29qCuUIuV6KT+umDeiXbsnohRa5wTSP8V08vgusrFlvW+Gdm7Lu
         nT8IPHlfG6pKNuBuDNs4h3KjmnGI77PvozkcnJMWkUePqn+sKHikZ+62DvFULRlPVDDg
         1jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DqaqzzF3+y9uoolI2d6F/zFbKHyNTtdt29pbbWJv/JY=;
        b=kzchcNj7HVB0fI3+aw20dL7rUoXfxB3lhfbvHE/cz6/UOJL07j0ElC+sDBVyEpkEb8
         n0h1UogoJgCifL5M90Ls7in7GZRcax+vKhgQnsozIPpWsM39c69cPzw5zlaKYm6d+U7X
         oK5qy57o/Six9L8BLWnBTAZ9ALSg/2BUrv3HmvzxC6Ov3zBB3ZBU54pGWYlY1cnAUZ5R
         8khG9yrDndWjU2uEFmIjpAdGHc6xbT/y79vztQ96phc1tKStswBWT9Px1ueUQC1N5uTo
         Z4EoVECu/QYX8oEwuWRXonSWL8QUQ/GDBt46RCb7dZOQbNFMvlREmI9hqfFtQpDwxhLD
         RAqg==
X-Gm-Message-State: AOAM531DpRpVc4tGLmff08kTmBixPbJREPZVng3TF3jMK3vy2o5nNMAM
        aBKYXtfn9TTxDqV964lH0oPvvQ==
X-Google-Smtp-Source: ABdhPJwClWxywxmWFoW5ga44x3HYIQbIzyyou3NpoM/LWEPUeygsBmXs3VJ9s2baaimK3xmJIjC+jg==
X-Received: by 2002:a0c:bd8d:: with SMTP id n13mr10773414qvg.199.1596502620098;
        Mon, 03 Aug 2020 17:57:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id p189sm20938350qkb.61.2020.08.03.17.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:56:59 -0700 (PDT)
Date:   Mon, 3 Aug 2020 20:56:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/6] commit-graph: fix regression when computing bloom
 filter
Message-ID: <20200804005658.GB75662@syl.lan>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <91e6e97a66aff88e0b860e34659dddc3396c7f28.1595927632.git.gitgitgadget@gmail.com>
 <85eeonutj4.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85eeonutj4.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 02:46:55AM +0200, Jakub Narębski wrote:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > With 3d112755 (commit-graph: examine commits by generation number), Git
> > knew to sort by generation number before examining the diff when not
> > using pack order. c49c82aa (commit: move members graph_pos, generation
> > to a slab, 2020-06-17) moved generation number into a slab and
> > introduced a helper which returns GENERATION_NUMBER_INFINITY when
> > writing the graph. Sorting is no longer useful and essentially reverts
> > the earlier commit.
> >
> > Let's fix this by accessing generation number directly through the slab.
>
> It looks like unfortunate and unforeseen consequence of putting together
> graph position and generation number in the commit_graph_data struct.
> During writing of the commit-graph file generation number is computed,
> but graph position is undefined (yet), and commit_graph_generation()
> uses graph_pos field to find if the data for commit is initialized;
> in this case wrongly.
>
> Anyway, when writing the commit graph we first compute generation
> number, then (if requested) the changed-paths Bloom filter.  Skipping
> the unnecessary check is a good thing... assuming that commit_gen_cmp()
> is used only when writing the commit graph, and not when traversing it
> (because then some commits may not have generation number set, and maybe
> even do not have any data on the commit slab) - which is the case.
>
> >
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 1af68c297d..5d3c9bd23c 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
>
> We might want to add function comment either here or in the header that
> this comparisonn function is to be used only for `git commit-graph
> write`, and not for graph traversal (even if similar funnction exists in
> other modules).

I think that probably within the function is just fine, and that we can
avoid touching commit-graph.h here.

>
> > @@ -144,8 +144,9 @@ static int commit_gen_cmp(const void *va, const void *vb)
> >  	const struct commit *a = *(const struct commit **)va;
> >  	const struct commit *b = *(const struct commit **)vb;

Maybe something like:

  /*
   * Access the generation number directly with
   * 'commit_graph_data_at(...)->generation' instead of going through
   * the slab as usual to avoid accessing a yet-uncomputed value.
   */

Folks that are curious for more can blame this commit and read there.
I'd err on the side of being brief in the code comment and verbose in
the commit message than the other way around ;).

> >
> > -	uint32_t generation_a = commit_graph_generation(a);
> > -	uint32_t generation_b = commit_graph_generation(b);
> > +	uint32_t generation_a = commit_graph_data_at(a)->generation;
> > +	uint32_t generation_b = commit_graph_data_at(b)->generation;
> > +
> >  	/* lower generation commits first */
> >  	if (generation_a < generation_b)
> >  		return -1;
>
> Best,
> --
> Jakub Narębski

Thanks,
Taylor
