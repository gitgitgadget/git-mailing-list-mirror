Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A427C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 13:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D4C2076B
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 13:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PWxN2nCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHKNsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbgHKNsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 09:48:14 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3070DC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 06:48:10 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so9434327qtp.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JOQv19P6tIen0yuFhUkgckQ/M3Vr3diTeHvxXHJbkWE=;
        b=PWxN2nCyoGyi8KwRO1cWOW+sgTDlldCgSGVCBg6J3SnfrcCHuRatj3T2H30f5xoxAl
         XLd15r6F150mQKohjQlwSMho50gDP9CBM0HbqZkU0nTja/bc61kSh45hJlVSnbANKBJU
         w6Ew2gvbZIn45Uj7OMS3oNJKyq3DZ9JOdcVmoo6p71g4q/j63IlmZU6clsJH7zNGWsba
         PlzabpAFIX1eOC6oAz0IscWS6Re8FWjkVkAYadE2eCtg/RGGd46FBh5z4UZX2smaQ0VE
         mEWgmk+BIt970G4dm2BZX6xze6l/BcQZoXAn6W+lgJiBj2QOK+vmOZIZ9j75etWucQSO
         ikhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JOQv19P6tIen0yuFhUkgckQ/M3Vr3diTeHvxXHJbkWE=;
        b=Uop1aouoZqtRGmyLrC6AclxfeWJLl+X5Qid3mR16qo6lm6kX8WrxBdRUENtj7h7YHF
         cEcBWv2ViXlu5wc44qeNBRH0O1TQPjkMigaH8zVbdSGzlMX2fJioHF5JldtUNRWyaQej
         3gu6RcQoJuMWnhUsIWDERHcFwkXq+9uslw9UKhdJINriEb8rq/gDLos5AiLXQdPmjeK9
         nf0yqHBWhnuGk32hz1BOAyekTMnHR2PeXNUKj0/4NbG8R6z7+hVa0Jrk2pA5W7dgSH8J
         fkjCCthJ6oYGThtYDJiiflMjJCkaK7x50mLW3AhDK9gMjMF54eH3RhCyjvTKYwLD8DTe
         DulQ==
X-Gm-Message-State: AOAM532N8jCgz/qMWeAOjETVGzEr6FulFuIMRwgIQg/fe7JtWowKkDSW
        z3JPmUwCM4Ngg9t+GWHaabBIiw==
X-Google-Smtp-Source: ABdhPJwZqjaWoAMxEn7HjKA/IO7lUPOqgnkwLwlho2chF1TJr5JODEJr34UACVF5U+5swP9unwOGhw==
X-Received: by 2002:ac8:45c7:: with SMTP id e7mr1141755qto.187.1597153689843;
        Tue, 11 Aug 2020 06:48:09 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id y3sm20480447qtj.55.2020.08.11.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 06:48:09 -0700 (PDT)
Date:   Tue, 11 Aug 2020 09:48:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2 12/14] commit-graph: add large-filters bitmap chunk
Message-ID: <20200811134807.GA26715@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
 <100b26d7c8a5e7ce21a950f33791eadab74e8e70.1596646576.git.me@ttaylorr.com>
 <xmqqbljoolhy.fsf@gitster.c.googlers.com>
 <20200805211730.GJ9546@syl.lan>
 <xmqqh7tgn37w.fsf@gitster.c.googlers.com>
 <20200805222531.GA30420@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805222531.GA30420@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 06:25:31PM -0400, Taylor Blau wrote:
> On Wed, Aug 05, 2020 at 03:21:39PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > On Wed, Aug 05, 2020 at 02:01:29PM -0700, Junio C Hamano wrote:
> > >> Taylor Blau <me@ttaylorr.com> writes:
> > >>
> > >> > @@ -71,6 +72,10 @@ struct commit_graph {
> > >> >  	const unsigned char *chunk_base_graphs;
> > >> >  	const unsigned char *chunk_bloom_indexes;
> > >> >  	const unsigned char *chunk_bloom_data;
> > >> > +	const unsigned char *chunk_bloom_large_filters;
> > >> > +
> > >> > +	size_t bloom_large_to_alloc;
> > >> > +	struct bitmap bloom_large;
> > >>
> > >> Hmph, is the API rich enough to allow users to release the resource
> > >> used by such an embedded bitmap?  I ask becuase...
> > >>
> > >> > @@ -2503,6 +2577,7 @@ void free_commit_graph(struct commit_graph *g)
> > >> >  	}
> > >> >  	free(g->filename);
> > >> >  	free(g->bloom_filter_settings);
> > >> > +	bitmap_free(g->bloom_large);
> > >> >  	free(g);
> > >> >  }
> > >>
> > >> ... this hunk cannot be possibly correct as-is, and cannot be made
> > >> correct without changing g->bloom_large to a pointer into a heap
> > >> allocated bitmap, because bitmap_free() wants to not just release
> > >> the resource held by the bitmap but the bitmap itself.
> > >
> > > Yuck, that's definitely wrong. Serves me right for sneaking this in
> > > after I had run `git rebase -x 'make -j40 DEVELOPER=1 test'
> > > upstream/master` ;-).
> > >
> > > Below the scissors line should do the trick. It should apply cleanly at
> > > this point in the series, but it'll produce a compilation failure on the
> > > very last patch (fixing it is straightforward and looks like the
> > > following diff):
> > >
> > > diff --git a/bloom.c b/bloom.c
> > > index d0c0fd049d..8d07209c6b 100644
> > > --- a/bloom.c
> > > +++ b/bloom.c
> > > @@ -52,7 +52,7 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
> > >                 start_index = 0;
> > >
> > >         if ((start_index == end_index) &&
> > > -           (g->bloom_large.word_alloc && !bitmap_get(&g->bloom_large, lex_pos))) {
> > > +           (g->bloom_large && !bitmap_get(g->bloom_large, lex_pos))) {
> > >                 /*
> > >                  * If the filter is zero-length, either (1) the filter has no
> > >                  * changes, (2) the filter has too many changes, or (3) it
> > >
> > > In either case, this will fix the bad free():
> > >
> > > --- >8 ---
> > >
> > > Subject: [PATCH] fixup! commit-graph: add large-filters bitmap chunk
> > >
> > > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > > ---
> > >  commit-graph.c | 18 ++++++++++--------
> > >  commit-graph.h |  2 +-
> > >  2 files changed, 11 insertions(+), 9 deletions(-)
> > > ...
> > > @@ -2360,6 +2361,7 @@ int write_commit_graph(struct object_directory *odb,
> > >  	free(ctx->graph_name);
> > >  	free(ctx->commits.list);
> > >  	free(ctx->oids.list);
> > > +	free(ctx->bloom_large);
> >
> > Is this correct, or shouldn't it be bitmap_free() instead?
>
> Ack, that should be 'bitmap_free()'. Double checking, 'bitmap_free' does
> handle a 'NULL' argument like 'free', so dealing with an old
> commit-graph lacking this chunk will work fine.
>
> Thanks for catching my mistake. I'm off tomorrow, Friday, and Monday,
> so my responses from now on may be intermittent, but I should have some
> time.

I'm back :). Let's squash the following into patch (bearing in mind that
you'll have to drop a '&' in the final patch of this series as a result
of this change):

--- >8 ---

Subject: [PATCH] fixup! commit-graph: add large-filters bitmap chunk

Makes the commit-graph's 'bloom_large' bitmap a pointer so that it can
be managed with the standard bitmap APIs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 18 ++++++++++--------
 commit-graph.h |  2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1fee49d171..384089be87 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -438,7 +438,10 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 				graph->bloom_large_to_alloc = get_be64(chunk_lookup + 4)
 							      - chunk_offset - sizeof(uint32_t);

-				graph->bloom_large.word_alloc = 0; /* populate when necessary */
+				/*
+				 * leave 'bloom_large' uninitialized, and
+				 * populate when necessary
+				 */
 				graph->chunk_bloom_large_filters = data + chunk_offset + sizeof(uint32_t);
 				graph->bloom_filter_settings->max_changed_paths = get_be32(data + chunk_offset);
 			}
@@ -960,17 +963,15 @@ static int get_bloom_filter_large_in_graph(struct commit_graph *g,
 	if (!g || !g->bloom_large_to_alloc)
 		return 0;

-	if (!g->bloom_large.word_alloc) {
+	if (!g->bloom_large) {
 		size_t i;
-		g->bloom_large.word_alloc = g->bloom_large_to_alloc;
-		g->bloom_large.words = xmalloc(g->bloom_large_to_alloc * sizeof(eword_t));
-
+		g->bloom_large = bitmap_word_alloc(g->bloom_large_to_alloc);
 		for (i = 0; i < g->bloom_large_to_alloc; i++)
-			g->bloom_large.words[i] = get_be64(g->chunk_bloom_large_filters
-							   + i * sizeof(eword_t));
+			g->bloom_large->words[i] = get_be64(g->chunk_bloom_large_filters
+							    + i * sizeof(eword_t));
 	}

-	return bitmap_get(&g->bloom_large, graph_pos - g->num_commits_in_base);
+	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
 }

 struct packed_oid_list {
@@ -2360,6 +2361,7 @@ int write_commit_graph(struct object_directory *odb,
 	free(ctx->graph_name);
 	free(ctx->commits.list);
 	free(ctx->oids.list);
+	bitmap_free(ctx->bloom_large);

 	if (ctx->commit_graph_filenames_after) {
 		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
diff --git a/commit-graph.h b/commit-graph.h
index f4fb996dd5..b1ab86a3c8 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -75,7 +75,7 @@ struct commit_graph {
 	const unsigned char *chunk_bloom_large_filters;

 	size_t bloom_large_to_alloc;
-	struct bitmap bloom_large;
+	struct bitmap *bloom_large;

 	struct bloom_filter_settings *bloom_filter_settings;
 };
--
2.28.0.rc1.13.ge78abce653

