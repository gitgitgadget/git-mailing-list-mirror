Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24905C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 06:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE572075F
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 06:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3wHtMn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHYGQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHYGQh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 02:16:37 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77621C061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 23:16:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z18so694493pjr.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UAE3GTQ6YDyoZclE9zqYfBC3gVIZeyTqTLI7Hhnjt2o=;
        b=F3wHtMn8XgsN1hwT16JzgV7i99qh/LzEV06lpgoq/ZXKjz7/8CODvJ8ERQDXxO0XvT
         3hNe0xfbqJ9GRbBYyw+lHEWspG/1FS+QtbHXoDrSYvef6KU2zCqzKyA2AI3o/R/dDTB/
         s5cJbKntT5dFIBk6TJOOvfEXcxwWwULOCwgiVKC3V3KEmZ57Kmju1HOVp+Jnftp5RNBk
         TpB/4S5e/jdlcPTkblQPrjx4tb6Pd/XMZZhd2ApGlw6mMLiT29a6bdN1514894MbI0V7
         wf1qqRBN6TKlsggcooYVJ65u2dJZ0/C4znBPMajD+jzYzLXMNeU2lUF0o0pMiOwaFcGT
         cuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=UAE3GTQ6YDyoZclE9zqYfBC3gVIZeyTqTLI7Hhnjt2o=;
        b=tkAA7DjO5NbkJ93DIFBAXDhzYJkunAmSekzUFP8bY4mAo5VfU2ept5AGVPWK0lAjF/
         l33R8RrOpeeAF5RHfoxuWitV1qL0XRIyslATfmW0bq0/vwTmTRYNDcG1v7k8JSKFaDCd
         zmN06O1TQPLWgwW8lHKPAOnY1Uua7d2jdvUqvL4jGfzoTRcTd/ZasFTOqFBe0A7/MkAy
         lPRepqpgyldtB98tFGJAJkFO/kgBxULJGOFZ9Ob49jYnTL1tUboLcmvpWf2j/L3N5ABA
         H7jogiaMpuKCc5ZHTwW3xguin5KedEYNpdKBkYgHPlGZS5NIOGy6X1h7rE5RRUiZqvgi
         pStQ==
X-Gm-Message-State: AOAM5321IpSiAPSBRhwGrskPQQlihKOCzSYFfC0QogkoEtQv5xGIL97L
        2k1a2uk7xZrlpI7WZhsvab0QkeOI9baimg==
X-Google-Smtp-Source: ABdhPJy86oAiXqOXWSR4Ab6HN4LQZXhUr+/S1Va5SXoUZExIOvaL99hCC+Aj06mA+VcPgL7z+01KdQ==
X-Received: by 2002:a17:90a:f28a:: with SMTP id fs10mr312907pjb.219.1598336196532;
        Mon, 24 Aug 2020 23:16:36 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:e90:1a28:66a3:8a14:5b8a:edc3])
        by smtp.gmail.com with ESMTPSA id n11sm1219047pfq.120.2020.08.24.23.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 23:16:36 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:44:18 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v3 06/11] commit-graph: add a slab to store topological
 levels
Message-ID: <20200825061418.GA629699@Abhishek-Arch>
Reply-To: 85d03jlu05.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <b347dbb01b9254ab8d79fbbd0f7c2b637efde62e.1597509583.git.gitgitgadget@gmail.com>
 <85d03jlu05.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85d03jlu05.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 08:43:38PM +0200, Jakub Narębski wrote:
> Hello,
> 
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > As we are writing topological levels to commit data chunk to ensure
> > backwards compatibility with "Old" Git and the member `generation` of
> > struct commit_graph_data will store corrected commit date in a later
> > commit, let's introduce a commit-slab to store topological levels while
> > writing commit-graph.
> 
> In my opinion the above it would be easier to follow if rephrased in the
> following way:
> 
>   In a later commit we will introduce corrected commit date as the
>   generation number v2.  This value will be stored in the new separate
>   GDAT chunk.  However to ensure backwards compatibility with "Old" Git
>   we need to continue to write generation number v1, which is
>   topological level, to the commit data chunk (CDAT).  This means that
>   we need to compute both versions of generation numbers when writing
>   the commit-graph file.  Let's therefore introduce a commit-slab
>   to store topological levels; corrected commit date will be stored
>   in the member `generation` of struct commit_graph_data.
> 
> What do you think?
> 

Yes, that's better.

> 
> By the way, do I understand it correctly that in backward-compatibility
> mode (that is, in mixed-version environment where at least some
> commit-graph files were written by "Old" Git and are lacking GDAT chunk
> and generation number v2 data) the `generation` member of commit graph
> data chunk will be populated and will store generation number v1, that
> is topological level? And that the commit-slab for topological levels is
> only there for writing and re-writing?
> 

No, the topo_levels commit-slab would be always populated when we write
a commit data chunk. The topo_level slab is a workaround for the fact
that we are trying to write two independent values (corrected commit
date offset, topological levels) but have one struct member to store them in
(data->generation).

If we are in a mixed-version environment, we could avoid initializing
the slab and fill the topological levels into data->generation instead,
but that's not how it is implemented right now.

> >
> > When Git creates a split commit-graph, it takes advantage of the
> > generation values that have been computed already and present in
> > existing commit-graph files.
> >
> > So, let's add a pointer to struct commit_graph to the topological level
> > commit-slab and populate it with topological levels while writing a
> > split commit-graph.
> 
> All right, looks sensible.

I have extend the last paragraph to include write_commit_graph_context
as well as:

  So, let's add a pointer to struct commit_graph as well as struct
  write_commit_graph_context to the topological level commit-slab and
  populate it with topological levels while writing a commit-graph file.

> 
> >
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c | 47 ++++++++++++++++++++++++++++++++---------------
> >  commit-graph.h |  1 +
> >  commit.h       |  1 +
> >  3 files changed, 34 insertions(+), 15 deletions(-)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 7f9f858577..a2f15b2825 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -64,6 +64,8 @@ void git_test_write_commit_graph_or_die(void)
> >  /* Remember to update object flag allocation in object.h */
> >  #define REACHABLE       (1u<<15)
> >
> > +define_commit_slab(topo_level_slab, uint32_t);
> > +
> 
> All right.
> 
> Also, here we might need GENERATION_NUMBER_V1_INFINITY, but I don't
> think it would be necessary.
> 
> >  /* Keep track of the order in which commits are added to our list. */
> >  define_commit_slab(commit_pos, int);
> >  static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
> > @@ -759,6 +761,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
> >  	item->date = (timestamp_t)((date_high << 32) | date_low);
> >
> >  	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> > +
> > +	if (g->topo_levels)
> > +		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
> >  }
> 
> All right, here we store topological levels on commit-slab to avoid
> recomputing them.
> 
> Do I understand it correctly that the `topo_levels` member of the `struct
> commit_graph` would be non-null only when we are updating the
> commit-graph?
> 

Yes, that's correct.

> >
> >  static inline void set_commit_tree(struct commit *c, struct tree *t)
> > @@ -953,6 +958,7 @@ struct write_commit_graph_context {
> >  		 changed_paths:1,
> >  		 order_by_pack:1;
> >
> > +	struct topo_level_slab *topo_levels;
> >  	const struct split_commit_graph_opts *split_opts;
> >  	size_t total_bloom_filter_data_size;
> >  	const struct bloom_filter_settings *bloom_settings;
> 
> Why do we need `topo_levels` member *both* in `struct commit_graph` and
> in `struct write_commit_graph_context`?
> 
> [After examining the change further I have realized why both are needed,
>  and written about the reasoning later in this email.]
> 
> 
> Note that the commit message talks only about `struct commit_graph`...
> 
> > @@ -1094,7 +1100,7 @@ static int write_graph_chunk_data(struct hashfile *f,
> >  		else
> >  			packedDate[0] = 0;
> >
> > -		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
> > +		packedDate[0] |= htonl(*topo_level_slab_at(ctx->topo_levels, *list) << 2);
> 
> All right, here we prepare for writing to the CDAT chunk using data that
> is now stored on newly introduced topo_levels slab (either computed, or
> taken from commit-graph file being rewritten).
> 
> Assuming that ctx->topo_levels is not-null, and that the values are
> properly calculated before this -- and we did compute topological levels
> before writing the commit-graph.
> 
> >
> >  		packedDate[1] = htonl((*list)->date);
> >  		hashwrite(f, packedDate, 8);
> > @@ -1335,11 +1341,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  					_("Computing commit graph generation numbers"),
> >  					ctx->commits.nr);
> >  	for (i = 0; i < ctx->commits.nr; i++) {
> > -		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
> > +		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
> 
> All right, so that is why this 'generation' variable was not converted
> to timestamp_t type.
> 
> >
> >  		display_progress(ctx->progress, i + 1);
> > -		if (generation != GENERATION_NUMBER_V1_INFINITY &&
> > -		    generation != GENERATION_NUMBER_ZERO)
> > +		if (level != GENERATION_NUMBER_V1_INFINITY &&
> > +		    level != GENERATION_NUMBER_ZERO)
> >  			continue;
> 
> Here we use GENERATION_NUMBER*_INFINITY to check if the commit is
> outside commit-graph files, and therefore we would need its topological
> level computed.
> 
> However, I don't understand how it works.  We have had created the
> commit_graph_data_at() and use it instead of commit_graph_data_slab_at()
> to provide default values for `struct commit_graph`... but only for
> `graph_pos` member.  It is commit_graph_generation() that returns
> GENERATION_NUMBER_INFINITY for commits not in graph.
> 
> But neither commit_graph_data_at()->generation nor topo_level_slab_at()
> handles this special case, so I don't see how 'generation' variable can
> *ever* be GENERATION_NUMBER_INFINITY, and 'level' variable can ever be
> GENERATION_NUMBER_V1_INFINITY for commits not in graph.
> 
> Does it work *accidentally*, because the default value for uninitialized
> data on commit-slab is 0, which matches GENERATION_NUMBER_ZERO?  It
> certainly looks like it does.  And GENERATION_NUMBER_ZERO is an artifact
> of commit-graph feature development history, namely the short time where
> Git didn't use any generation numbers and stored 0 in the place set for
> it in the commit-graph format...  On the other hand this is not the case
> for corrected commit date (generation number v2), as it could
> "legitimately" be 0 if some root commit (without any parents) had
> committerdate of epoch 0, i.e. 1 January 1970 00:00:00 UTC, perhaps
> caused by malformed but valid commit object.
> 
> Ugh...

It works accidentally.

Our decision to avoid the cost of initializing both
commit_graph_data->generation and commit_graph_data->graph_pos has
led to some unwieldy choices - the complexity of helper functions,
bypassing helper functions when writing a commit-graph file [1].

I want to re-visit how commit_graph_data slab is defined in a future series.

[1]: https://lore.kernel.org/git/be28ab7b-0ae4-2cc5-7f2b-92075de3723a@gmail.com/

> 
> >
> >  		commit_list_insert(ctx->commits.list[i], &list);
> > @@ -1347,29 +1353,27 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  			struct commit *current = list->item;
> >  			struct commit_list *parent;
> >  			int all_parents_computed = 1;
> > -			uint32_t max_generation = 0;
> > +			uint32_t max_level = 0;
> >
> >  			for (parent = current->parents; parent; parent = parent->next) {
> > -				generation = commit_graph_data_at(parent->item)->generation;
> > +				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
> >
> > -				if (generation == GENERATION_NUMBER_V1_INFINITY ||
> > -				    generation == GENERATION_NUMBER_ZERO) {
> > +				if (level == GENERATION_NUMBER_V1_INFINITY ||
> > +				    level == GENERATION_NUMBER_ZERO) {
> >  					all_parents_computed = 0;
> >  					commit_list_insert(parent->item, &list);
> >  					break;
> > -				} else if (generation > max_generation) {
> > -					max_generation = generation;
> > +				} else if (level > max_level) {
> > +					max_level = level;
> >  				}
> >  			}
> 
> This is the same case as for previous chunk; see the comment above.
> 
> This code checks if parents have generation number / topological level
> computed, and tracks maximum value of it among all parents.
> 
> >
> >  			if (all_parents_computed) {
> > -				struct commit_graph_data *data = commit_graph_data_at(current);
> > -
> > -				data->generation = max_generation + 1;
> >  				pop_commit(&list);
> >
> > -				if (data->generation > GENERATION_NUMBER_MAX)
> > -					data->generation = GENERATION_NUMBER_MAX;
> > +				if (max_level > GENERATION_NUMBER_MAX - 1)
> > +					max_level = GENERATION_NUMBER_MAX - 1;
> > +				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
> 
> OK, this is safer way of handling GENERATION_NUMBER*_MAX, especially if
> this value can be maximum value that can be safely stored in a given
> data type.  Previously GENERATION_NUMBER_MAX was smaller than maximum
> value that can be safely stored in uint32_t, so generation+1 had no
> chance to overflow.  This is no longer the case; the reorganization done
> here leads to more defensive code (safer).
> 
> All good.  However I think that we should clamp the value of topological
> level to the maximum value that can be safely stored *on disk*, in the
> 30 bits of the CDAT chunk reserved for generation number v1.  Otherwise
> the code to write topological level would get more complicated.
> 
> In my opinion the symbolic constant used here should be named
> GENERATION_NUMBER_V1_MAX, and its value should be at most (2 ^ 30 - 1);
> it should be the current value of GENERATION_NUMBER_MAX, that is
> 0x3FFFFFFF.
> 
> >  			}
> >  		}
> >  	}
> > @@ -2101,6 +2105,7 @@ int write_commit_graph(struct object_directory *odb,
> >  	uint32_t i, count_distinct = 0;
> >  	int res = 0;
> >  	int replace = 0;
> > +	struct topo_level_slab topo_levels;
> >
> 
> All right, we will be using topo_level slab for writing the
> commit-graph, and only for this purpose, so it is good to put it here.
> 
> >  	if (!commit_graph_compatible(the_repository))
> >  		return 0;
> > @@ -2179,6 +2184,18 @@ int write_commit_graph(struct object_directory *odb,
> >  		}
> >  	}
> >
> > +	init_topo_level_slab(&topo_levels);
> > +	ctx->topo_levels = &topo_levels;
> > +
> > +	if (ctx->r->objects->commit_graph) {
> > +		struct commit_graph *g = ctx->r->objects->commit_graph;
> > +
> > +		while (g) {
> > +			g->topo_levels = &topo_levels;
> > +			g = g->base_graph;
> > +		}
> > +	}
> 
> All right, now I see why we need `topo_levels` member both in the
> `struct write_commit_graph_context` and in `struct commit_graph`.
> The former is for functions that write the commit-graph, the latter for
> fill_commit_graph_info() functions that is deep in the callstack, but it
> needs to know whether to load topological level to commit-slab, or maybe
> put it as generation number (and in the future -- discard it, if not
> needed).
> 
> 
> Sidenote: this fragment of code, that fills with a given value some
> member of the `struct commit_graph` throughout the split commit-graph
> chain, will be repeated as similar code in patches later in series.
> However without resorting to preprocessor macros I have no idea how to
> generalize it to avoid code duplication (well, almost).
> 

The pattern is: iterate over the commit-graph chain and assign a member
(here, topo_level and in the other patch, read_generation_data) a value
(the address of topo_level slab, 1/0 depending on whether it is a mixed
generation chain).

We could generalize this in a future series but I don't think it is
worthwhile.

> > +
> >  	if (pack_indexes) {
> >  		ctx->order_by_pack = 1;
> >  		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
> > diff --git a/commit-graph.h b/commit-graph.h
> > index 430bc830bb..1152a9642e 100644
> > --- a/commit-graph.h
> > +++ b/commit-graph.h
> > @@ -72,6 +72,7 @@ struct commit_graph {
> >  	const unsigned char *chunk_bloom_indexes;
> >  	const unsigned char *chunk_bloom_data;
> >
> > +	struct topo_level_slab *topo_levels;
> >  	struct bloom_filter_settings *bloom_filter_settings;
> >  };
> 
> All right: `struct commit_graph` is public, `struct
> write_commit_graph_context` is not.
> 
> >
> > diff --git a/commit.h b/commit.h
> > index bc0732a4fe..bb846e0025 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -15,6 +15,7 @@
> >  #define GENERATION_NUMBER_V1_INFINITY 0xFFFFFFFF
> >  #define GENERATION_NUMBER_MAX 0x3FFFFFFF
> 
> The name GENERATION_NUMBER_MAX for 0x3FFFFFFF should be instead
> GENERATION_NUMBER_V1_MAX, but that may be done in a later commit.
> 
> >  #define GENERATION_NUMBER_ZERO 0
> > +#define GENERATION_NUMBER_V2_OFFSET_MAX 0xFFFFFFFF
> 
> This value is never used, so why it is defined in this commit.
> 

Moved down to the patch actually uses it.

> >
> >  struct commit_list {
> >  	struct commit *item;
> 
> Best,
> -- 
> Jakub Narębski
