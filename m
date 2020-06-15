Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F14C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 16:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B05F2078A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 16:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="nvcl5SPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgFOQcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgFOQcC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 12:32:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A985CC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 09:32:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so7008325plt.5
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7lp5Fs5zyEpW2u/Nl4AMK6rZSVwWNN0I1z3JkTFhETY=;
        b=nvcl5SPcvizMVHUSx9AIYf4d1y7vB2PwDls5QjBk3gFx+YCQmuWVXbZcfp67hmuXS+
         6BBMpeMXDr3QGjgvqDfCtOAirAhzrQjyw4F2+YWJ8/fgP0dbt6k7iz9h2jnEYj5ik+S8
         jy4pBx2UqIOcCpWENS/VU4dj6a3h7YagoSpDRhjr+tKYnhPnrWpF/GOeCxpmNTaAeOr0
         oKygXqNN6j2NMj9kCofPjgCh4kK1LtUSOmrfQPuPqXwsEUqlkb/toF+cGawlGetdMUbs
         OVi9rLiRkxc7UgtpSQy3VNQ+jHnpBrNTpoA5LMXhP4eR0geonADjIHIjoFfGy2ccmI0q
         iOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7lp5Fs5zyEpW2u/Nl4AMK6rZSVwWNN0I1z3JkTFhETY=;
        b=rN0APdlix/suIpL2acHIb3bmzteTjq69GXUrW/7ud5P1qIELGSKlmWa3phDmLs8cr4
         wB31SD7TOJOdkGCBOxBC2IrFs58HR5+2IGDWP5I0tN1sGCIr+8oyeFFdY0l+/Hi9WEZF
         AUgziXCzWZyBCvFM6aiJGEHlwlaxTXfTk2kUgF4Gf5/2dVZR08wcAaMshmXhLqvcZIzr
         w01Ico+FWyejaFHdbXBHAj1Bnqnyg7rz8uERlWyLpVgitPvGX5ZfxNs1y8fSQZw3MAxT
         DO+seFM6WhT+AgXH+EW6ngj0TKmhxEukTM16XenFT3YUa3WPihtJwmsqjF612mHeWXql
         sdyg==
X-Gm-Message-State: AOAM531Krwtioq12B1JkSM88mA4NR4iELeqZ/av3+iCjJV5d8EujdIVd
        nGaYLgwxcCybtY8hIkOBjD7aaQ==
X-Google-Smtp-Source: ABdhPJyi813YpGjAYkwABSQtYBQvpM28Mt/jPxF1+4GLlpadfpZ8+Thfwh4qMiNhm0Z1f4NIbkSJsA==
X-Received: by 2002:a17:90b:895:: with SMTP id bj21mr154673pjb.148.1592238721072;
        Mon, 15 Jun 2020 09:32:01 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id e124sm14063065pfh.140.2020.06.15.09.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:32:00 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:31:59 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSOC Patch v2 3/4] commit-graph: use generation directly when
 writing commit-graph
Message-ID: <20200615163159.GC71506@syl.local>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-4-abhishekkumar8222@gmail.com>
 <85zh9dsemi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85zh9dsemi.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 08, 2020 at 06:31:49PM +0200, Jakub Narębski wrote:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>
> > commit_graph_generation() returns GENERATION_NUMBER_INFINITY if the
> > graph position for commit is COMMIT_NOT_FROM_GRAPH.
> >
> > While this is true when reading from a commit graph, no graph positions
> > are associated with a commit when writing a commit graph. Therefore, the
> > helper incorrectly returns GENERATION_NUMBER_INFINITY despite having a
> > finite generation number.
> >
> > Let's fix this by using generation number directly when writing a commit
> > graph.
>
> I think that to avoid having non-working patch (which can cause problems
> when bisecting), it would be a better idea to switch the order of
> patches 2 and 3.  This way we won't have incorrect behaviour.

Yup... agreed (with the additional caveat that the unused function in
the first patch also be moved into this new--larger--patch).

> >
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index f7cca4def4..0dc79e7c90 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -1070,7 +1070,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
> >  		else
> >  			packedDate[0] = 0;
> >
> > -		packedDate[0] |= htonl(commit_graph_generation((*list)) << 2);
> > +		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
> >
>
> All right.
>
> >  		packedDate[1] = htonl((*list)->date);
> >  		hashwrite(f, packedDate, 8);
> > @@ -1301,9 +1301,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  					_("Computing commit graph generation numbers"),
> >  					ctx->commits.nr);
> >  	for (i = 0; i < ctx->commits.nr; i++) {
> > +		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
> > +
> >  		display_progress(ctx->progress, i + 1);
> > -		if (commit_graph_generation(ctx->commits.list[i]) != GENERATION_NUMBER_INFINITY &&
> > -		    commit_graph_generation(ctx->commits.list[i]) != GENERATION_NUMBER_ZERO)
> > +		if (generation != GENERATION_NUMBER_INFINITY &&
> > +		    generation != GENERATION_NUMBER_ZERO)
> >  			continue;
> >
>
> All right; this also introduces local variable to avoid accessing the
> slab twice^W four times...
>
> >  		commit_list_insert(ctx->commits.list[i], &list);
> > @@ -1314,8 +1316,9 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  			uint32_t max_generation = 0;
> >
> >  			for (parent = current->parents; parent; parent = parent->next) {
> > -				if (commit_graph_generation(parent->item) == GENERATION_NUMBER_INFINITY ||
> > -				    commit_graph_generation(parent->item) == GENERATION_NUMBER_ZERO) {
> > +
> > +				if (generation == GENERATION_NUMBER_INFINITY ||
> > +				    generation == GENERATION_NUMBER_ZERO) {
> >  					all_parents_computed = 0;
> >  					commit_list_insert(parent->item, &list);
> >  					break;
>
> ... which is then used here.
>
> Best,
> --
> Jakub Narębski
Thanks,
Taylor
