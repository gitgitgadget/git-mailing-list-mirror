Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8C2C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE5B2086A
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tdjMvXBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHEWZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHEWZe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:25:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF408C061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 15:25:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s23so34947978qtq.12
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vzZ6LGSypNvx1evkHmyEjr2ZDvjHRXH2A9qQ6w+LWJE=;
        b=tdjMvXBLW5PBRZtoef5/aTf3Wjg3Oef7dmx1A4xxj4aCYt6x+O7f8KEFvrd9Mh8rMq
         32PbMJ4sYrOvcod86UEFqBog9gNEyHzzWYQzI/hKMfSuAEbJPW4dVrGUi+hZcSOhsvgc
         D5mYr9IMBACimovb8Ha446vanmnKDamTR2HOgOFTab0Nrtw3Hj8s1awNPVuMOg1VF7P6
         M9KGmcEyKs06tWn9XN4JuqiH32Y8yjYPrYQEG8hS2FfhdzGZ+907z01eWxVZH7I7lmxP
         HGbv8TreNPDYt/fV/JJaPEP6jjZ7JpDDuhLDRHruX9Rsoz4JOuy5ZgVgXoyF8TldzUQw
         qAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzZ6LGSypNvx1evkHmyEjr2ZDvjHRXH2A9qQ6w+LWJE=;
        b=Dyz9DXCpk/+nIiXLwlpjZNKw/4xUx5XHic66cDrdxgvXw5Gn3OpCp9fr9INVwyCS+O
         fJ7d2MOhmX7hVBdT2xjUwZ6pKY6YpXrBVKls1szOcFjnwp7FSMT+4jEkuDj1f27irKub
         m2O7K15GJiVssEnanpZBkq0To2HMf+osNyGQp+tJTzsHdFiztdiyFwEBq9BCtsTiiPwA
         l0p/EodYJvmHSuFSPyoh5mV+lhcC7/tmw8BVORnj2/MkkfCC8ZLN59KbwwTyX2aN3x0B
         CNBB7v9ulvwq0jJDX6VRaJwE1Bkku+qqiYvNKNLVUQ9wNsVVGi4l1ZOdwUNk/BAbLPMX
         Me8g==
X-Gm-Message-State: AOAM533klKKEjmKANGX8CoKKY/r++Th6we92eMfH1sOdxnTrHBnyog9N
        n05OuTJnaAXPyXhwKaVFVD/6yQ==
X-Google-Smtp-Source: ABdhPJxd0j6FSsT9VaveXrAFvpYNSiciay8DefjHamfxj2yhU8A1W9TjwYTsYzxLOJoxidkdCBqUOg==
X-Received: by 2002:ac8:44cd:: with SMTP id b13mr5709665qto.308.1596666333073;
        Wed, 05 Aug 2020 15:25:33 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id t93sm3212932qtd.97.2020.08.05.15.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 15:25:32 -0700 (PDT)
Date:   Wed, 5 Aug 2020 18:25:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2 12/14] commit-graph: add large-filters bitmap chunk
Message-ID: <20200805222531.GA30420@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
 <100b26d7c8a5e7ce21a950f33791eadab74e8e70.1596646576.git.me@ttaylorr.com>
 <xmqqbljoolhy.fsf@gitster.c.googlers.com>
 <20200805211730.GJ9546@syl.lan>
 <xmqqh7tgn37w.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7tgn37w.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 03:21:39PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Wed, Aug 05, 2020 at 02:01:29PM -0700, Junio C Hamano wrote:
> >> Taylor Blau <me@ttaylorr.com> writes:
> >>
> >> > @@ -71,6 +72,10 @@ struct commit_graph {
> >> >  	const unsigned char *chunk_base_graphs;
> >> >  	const unsigned char *chunk_bloom_indexes;
> >> >  	const unsigned char *chunk_bloom_data;
> >> > +	const unsigned char *chunk_bloom_large_filters;
> >> > +
> >> > +	size_t bloom_large_to_alloc;
> >> > +	struct bitmap bloom_large;
> >>
> >> Hmph, is the API rich enough to allow users to release the resource
> >> used by such an embedded bitmap?  I ask becuase...
> >>
> >> > @@ -2503,6 +2577,7 @@ void free_commit_graph(struct commit_graph *g)
> >> >  	}
> >> >  	free(g->filename);
> >> >  	free(g->bloom_filter_settings);
> >> > +	bitmap_free(g->bloom_large);
> >> >  	free(g);
> >> >  }
> >>
> >> ... this hunk cannot be possibly correct as-is, and cannot be made
> >> correct without changing g->bloom_large to a pointer into a heap
> >> allocated bitmap, because bitmap_free() wants to not just release
> >> the resource held by the bitmap but the bitmap itself.
> >
> > Yuck, that's definitely wrong. Serves me right for sneaking this in
> > after I had run `git rebase -x 'make -j40 DEVELOPER=1 test'
> > upstream/master` ;-).
> >
> > Below the scissors line should do the trick. It should apply cleanly at
> > this point in the series, but it'll produce a compilation failure on the
> > very last patch (fixing it is straightforward and looks like the
> > following diff):
> >
> > diff --git a/bloom.c b/bloom.c
> > index d0c0fd049d..8d07209c6b 100644
> > --- a/bloom.c
> > +++ b/bloom.c
> > @@ -52,7 +52,7 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
> >                 start_index = 0;
> >
> >         if ((start_index == end_index) &&
> > -           (g->bloom_large.word_alloc && !bitmap_get(&g->bloom_large, lex_pos))) {
> > +           (g->bloom_large && !bitmap_get(g->bloom_large, lex_pos))) {
> >                 /*
> >                  * If the filter is zero-length, either (1) the filter has no
> >                  * changes, (2) the filter has too many changes, or (3) it
> >
> > In either case, this will fix the bad free():
> >
> > --- >8 ---
> >
> > Subject: [PATCH] fixup! commit-graph: add large-filters bitmap chunk
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  commit-graph.c | 18 ++++++++++--------
> >  commit-graph.h |  2 +-
> >  2 files changed, 11 insertions(+), 9 deletions(-)
> > ...
> > @@ -2360,6 +2361,7 @@ int write_commit_graph(struct object_directory *odb,
> >  	free(ctx->graph_name);
> >  	free(ctx->commits.list);
> >  	free(ctx->oids.list);
> > +	free(ctx->bloom_large);
>
> Is this correct, or shouldn't it be bitmap_free() instead?

Ack, that should be 'bitmap_free()'. Double checking, 'bitmap_free' does
handle a 'NULL' argument like 'free', so dealing with an old
commit-graph lacking this chunk will work fine.

Thanks for catching my mistake. I'm off tomorrow, Friday, and Monday,
so my responses from now on may be intermittent, but I should have some
time.

Thanks,
Taylor
