Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB3EC433E1
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69FD120781
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OxqV3ihH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHKVST (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgHKVSS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:18:18 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD33C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:18:18 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w9so10588745qts.6
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NOS+LiOMikT2r6X0sI203lilAq0VCSskFKNbM90hGwY=;
        b=OxqV3ihHJ7/lOd9O00QkuQFmaEjE9MmmnA9Db7aXBvpcHU8oH5FLIcmIRkz4V9y3mb
         2eznRYDpt9mlnFFbGe0iKemvAG+n+ggMxkpa9CBV2ehBLIYVA38tkYq3LIjVFIpWWaWj
         ABR2RINBzdBitqf/yamxRPI2kcX+yIBcVKL0HXvUxbaPwzP1NtkIt1HXv5dwY/5hrIKU
         JESEr4Cek+vsh+nLWgTARfWuwQdg4+YrhJ8uhhCVRvPlBnxrAVnWlItA/8mwL9acK59/
         N2ESp2Ey5gCrhyNj56nuFVFoK4xxIaqdJgQdStTJzo5F04SthbAP765O13SEAdktuzde
         +Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NOS+LiOMikT2r6X0sI203lilAq0VCSskFKNbM90hGwY=;
        b=uEvnrDB0u1mvghGHvnM0D0aI/RxQ1Omuh6Vq8hA7JE6VsOai2D862qR2qOwuwO+aXI
         wUee6DoJkRe4ivVHOqPQnyci54++ioeoOSMeP1XCWtix9mnEX4xHQoKmyB4+XMS64qMP
         QEI3Xy/woX9VfXQwGClQgHDYn/vdPevPv5JoI1Ah4IZWlbCMSwSEwcJSuWuGKSnRarH9
         6rW4McKWcyCFFTOr4Qywl0m1JbU/Qj66q6GoojSuJrKEkFDbrxerka4hMbjGNYWeXnv1
         NdcDSlE1RLYQT1rYPMOhtgqUXDiMjiK9qQ4Xm2sBNfv1bnoevF3J4o/sz77XT+xe356z
         EGMw==
X-Gm-Message-State: AOAM530qwyviq6STjndK6gYLRYOf9kx5JqAK3IoCMSLXiWinmGZDbZ5y
        jlg1RDswZe+c4hcJIt2qJHwZ8A==
X-Google-Smtp-Source: ABdhPJwy98Ky/4udzDozLxU9UgfAvCe+4CYFE/w0rIYRYluprQubK4RaprCEFmAzvvbC0pbHFS/S7Q==
X-Received: by 2002:ac8:387b:: with SMTP id r56mr3213922qtb.353.1597180697505;
        Tue, 11 Aug 2020 14:18:17 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id k5sm113489qke.18.2020.08.11.14.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:18:16 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:18:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, szeder.dev@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 12/14] commit-graph: add large-filters bitmap chunk
Message-ID: <20200811211815.GA65971@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <619e0c619dd12e2bea2b80c7d249ba66fe2a315c.1597178915.git.me@ttaylorr.com>
 <4f487dca-a938-b4c4-8b77-a202209459cb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f487dca-a938-b4c4-8b77-a202209459cb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 05:11:49PM -0400, Derrick Stolee wrote:
> On 8/11/20 4:52 PM, Taylor Blau wrote:
> > To allow using the existing bitmap code with 64-bit words, we write the
> > data in network byte order from the 64-bit words. This means we also
> > need to read the array from the commit-graph file by translating each
> > word from network byte order using get_be64() when loading the commit
> > graph. (Note that this *could* be delayed until first-use, but a later
> > patch will rely on this being initialized early, so we assume the
> > up-front cost when parsing instead of delaying initialization).
>
> I don't think this is correct to do. This means that every commit-graph
> load will load the entire large bloom filter chunk into memory before
> allowing a single commit to be read from the graph.
>
> In the case of a very large commit-graph (> 1 million commits), this
> would cause a significant initial cost that is not necessarily needed
> for anything. For example, "git log -1" will be delayed by this action.
>
> If I understand correctly, this bloom_large bitmap is only used when
> writing Bloom filters. At that point, reading the entire bitmap from
> disk into memory is inexpensive compared to the time saved by the
> feature.

That's not quite correct. By this point in the patch series, we only use
this bitmap for writing, but in the final patch, we will use it in
'load_bloom_filter_from_graph()' (see that patch for the details of why,
there is an explanatory comment to that effect).

So, the way that this lazy initialization was written was subtly
incorrect, since calling 'load_bloom_filter_from_graph' would return the
wrong value depending on what was or wasn't called before it (namely
whether or not we had initialized the bitmap).

> > @@ -429,6 +430,24 @@ struct commit_graph *parse_commit_graph(struct repository *r,
> >  				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
> >  			}
> >  			break;
> > +
> > +		case GRAPH_CHUNKID_BLOOMLARGE:
> > +			if (graph->chunk_bloom_large_filters)
> > +				chunk_repeated = 1;
> > +			else if (r->settings.commit_graph_read_changed_paths) {
>
> This is guarded against commitGraph.readChangedPaths, which is good,
> but that's not enough to claim that we need the bloom_large bitmap
> in this process.
>
> > +				size_t alloc = get_be64(chunk_lookup + 4) - chunk_offset - sizeof(uint32_t);
>
> If we store this inside the commit_graph struct, we can save this
> size for later so...
>
> > +				graph->chunk_bloom_large_filters = data + chunk_offset + sizeof(uint32_t);
> > +				graph->bloom_filter_settings->max_changed_paths = get_be32(data + chunk_offset);
>
> ...this portion can be done only when we are about to read from the
> bitmap.

Right, that all is clear.

>
> > +				if (alloc) {
> > +					size_t j;
> > +					graph->bloom_large = bitmap_word_alloc(alloc);
> > +
> > +					for (j = 0; j < graph->bloom_large->word_alloc; j++)
> > +						graph->bloom_large->words[j] = get_be64(
> > +							graph->chunk_bloom_large_filters + j * sizeof(eword_t));
> > +				}
>
>
>
> > +			}
> > +			break;
> >  		}
> >
> >  		if (chunk_repeated) {
> > @@ -443,7 +462,9 @@ struct commit_graph *parse_commit_graph(struct repository *r,
> >  		/* We need both the bloom chunks to exist together. Else ignore the data */
> >  		graph->chunk_bloom_indexes = NULL;
> >  		graph->chunk_bloom_data = NULL;
> > +		graph->chunk_bloom_large_filters = NULL;
> >  		FREE_AND_NULL(graph->bloom_filter_settings);
> > +		bitmap_free(graph->bloom_large);
>
> Perhaps this bitmap_free() needs a check to see if we
> initialized it (with my recommended lazy-loading), but
> maybe not?

It does not ('bitmap_free()' understands that a NULL argument is a noop,
like 'free()').
>
> >  	}
> >
> >  	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
> > @@ -932,6 +953,20 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
> >  	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
> >  }
> >
> > +static int get_bloom_filter_large_in_graph(struct commit_graph *g,
> > +					   const struct commit *c)
> > +{
> > +	uint32_t graph_pos = commit_graph_position(c);
> > +	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
> > +		return 0;
> > +
> > +	while (g && graph_pos < g->num_commits_in_base)
> > +		g = g->base_graph;
> > +
> > +	if (!(g && g->bloom_large))
> > +		return 0;
>
> Here is where we can check if the size of the chunk is
> non-zero and if the g->bloom_large bitmap is uninitialized.
> Since we are caring about this information, it is now time
> to do the network-byte transition of the full bitmap.

Yes, that's right. But again, we'll need to move this out to a
non-static helper function so that we can call it from bloom.c in the
final patch.

I'm admittedly a little unsure of what to do next, since the changes are
scoped to this and the remaining patches (really just this and the final
patch).

I guess I'll try the other approach of replacing these two patches
by sending emails in response so that Junio can take those (I'll avoid
sending a fixup patch).

> > +	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
> > +}
> >
> Thanks,
> -Stolee

Thanks,
Taylor
