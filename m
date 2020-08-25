Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C12C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 06:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68D720782
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 06:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQVzykEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgHYGwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgHYGwN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 02:52:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA35C061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 23:52:13 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so6553069pfw.9
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L4ztozr+lenY6oM7jKua06Q3nqQhGj7eJgGpZ+Ypk3U=;
        b=FQVzykEYAWlcUd18gokk6vGFqi2lsbcOiyWJihQjSag2Std1IOdGeeZlXXYRS4xVqh
         bAQZpZoNwMZhlDsXWDqvRkI4BlmPGr4+eAzZp3fl1uKHvBumbwIVD8m0Pmr/Xwce0u6b
         TvXARU6u75yXIHHEqc0uLmRlILc7o2VaqKcW5cxiZDeUq2QXDNIkp2FzrZGjPizimJH9
         oDCnnar9wIeEo+paK3rYzRCZAjZfdkP+Yd6Pvi1KG+rNCWYcpiJipIov/TG63KKHqxVO
         mco+GI2/cTnxRZBt3+JsZ7FGVTRzMWqR33g7is4bYCf3kZk23v09HpWGmQf8A3V38rRp
         R/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=L4ztozr+lenY6oM7jKua06Q3nqQhGj7eJgGpZ+Ypk3U=;
        b=atBCb/SNjjntCrH+iLPPFuyoPKaAQoaedHTzwkG2/oQWRNJt3dVR7KmSjMMksKBsyK
         NZQOe2TSA0donvwTf4fMmm8NtPaz5qnfKzkfY/WosnZeZA3STC07zzuXQdZmweLHLviE
         o7lnzfYKAkR48FlaQzr4NmZF/7zuGCPvGED1q380kg3+k8skDdi5NC4UF2AHMzYXv+a+
         /PuY1sKaSyobNHLaTG0Emm1X9CakJftEmkXqtKy3wsJD9wYeKa+sVD+1c7ZCm9PqBfYp
         XtpgzgSFLdD2gpJgOSZue0UhYWZCKAD57Gw1xs+aqaeLyUR4fki2dwtPsX9ZjtABTOiu
         l5/w==
X-Gm-Message-State: AOAM5332NJ31jx+VwUXsk1vyBm68cTtKzB4YRfmNSjZrff+bQl9jsr6t
        xRipqlfQxTY0fxkpE09GUQ4=
X-Google-Smtp-Source: ABdhPJy8WF1gXAeWztn2FV+eu6J/7ahzf9vSLQ4IBMLmZD1rp78QT6+Uk7PdsPt6qaRrTBM596fznw==
X-Received: by 2002:a63:4857:: with SMTP id x23mr5848332pgk.440.1598338332755;
        Mon, 24 Aug 2020 23:52:12 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:e90:1a28:66a3:8a14:5b8a:edc3])
        by smtp.gmail.com with ESMTPSA id l12sm1583117pjq.31.2020.08.24.23.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 23:52:12 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:19:54 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, me@ttaylorr.com, stolee@gmail.com
Subject: Re: [PATCH v3 07/11] commit-graph: implement corrected commit date
Message-ID: <20200825064954.GA645690@Abhishek-Arch>
Reply-To: 85wo1rk0iy.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <4074ace65be3094d35dd0aaedb89eb5a0ec98cee.1597509583.git.gitgitgadget@gmail.com>
 <85wo1rk0iy.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85wo1rk0iy.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 22, 2020 at 02:05:41AM +0200, Jakub Narębski wrote:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > With most of preparations done, let's implement corrected commit date.
> >
> > The corrected commit date for a commit is defined as:
> >
> > * A commit with no parents (a root commit) has corrected commit date
> >   equal to its committer date.
> > * A commit with at least one parent has corrected commit date equal to
> >   the maximum of its commit date and one more than the largest corrected
> >   commit date among its parents.
> 
> Good.
> 
> >
> > To minimize the space required to store corrected commit date, Git
> > stores corrected commit date offsets into the commit-graph file. The
> > corrected commit date offset for a commit is defined as the difference
> > between its corrected commit date and actual commit date.
> 
> Perhaps we should add more details about data type sizes in question.

Will add.

> 
> Storing corrected commit date requires sizeof(timestamp_t) bytes, which
> in most cases is 64 bits (uintmax_t).  However corrected commit date
> offsets can be safely stored^* using only 32 bits.  This halves the size
> of GDAT chunk, reducing per-commit storage from 2*H + 16 + 8 bytes to
> 2*H + 16 + 4 bytes, which is reduction of around 6%, not including
> header, fanout table (OIDF) and extra edges list (EDGE).
> 
> Which might mean that the extra complication is not worth it, and we
> should store corrected commit date directly instead.
> 
> *) unless for example one of commits is malformed but valid,
>    and has committerdate of 0 Unix time, 1 January 1970.
> 
> >
> > While Git does not write out offsets at this stage, Git stores the
> > corrected commit dates in member generation of struct commit_graph_data.
> > It will begin writing commit date offsets with the introduction of
> > generation data chunk.
> 
> OK, so the agenda for introducing geeration number v2 is as follows:
> - compute generation numbers v2, i.e. corrected commit date
> - store corrected commit date [offsets] in new GDAT chunk,
>   unless backward-compatibility concerns require us to not to
> - load [and compute] corrected commit date from commit-graph
>   storing it as 'generation' field of `struct commit_graph_data`,
>   unless backward-compatibility concerns require us to store
>   topological levels (generation number v1) in there instead
> 

The last point is not correct. We always store topological levels into
the topo_levels slab introduced and always store corrected commit date
into data->generation, regardless of backward compatibility concerns.

We could avoid initializing topo_slab if we are not writing generation
data chunk (and thus don't need corrected commit dates) but that
wouldn't have an impact on run time while writing commit-graph because
computing corrected commit dates is cheap as the main cost is in walking
the graph and writing the file.

> Because the reachability condition for corrected commit date and for
> topological level is exactly the same, we don't need to do anything to
> take advantage of generation number v2.
> 
> Though we can use generation number v2 in more cases, where we turned
> off use of generation numbers because v1 gave worse performance than
> date heuristics.
> 
> Did I got this right?
> 
> >
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c | 58 +++++++++++++++++++++++++++-----------------------
> >  1 file changed, 31 insertions(+), 27 deletions(-)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index a2f15b2825..fd69534dd5 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -169,11 +169,6 @@ static int commit_gen_cmp(const void *va, const void *vb)
> >  	else if (generation_a > generation_b)
> >  		return 1;
> >
> > -	/* use date as a heuristic when generations are equal */
> > -	if (a->date < b->date)
> > -		return -1;
> > -	else if (a->date > b->date)
> > -		return 1;
> 
> At first I was wondering why this tie-breaking is beig removed; wouldn't
> be needed for backward-compatibility?  But then I remembered that this
> comparison function is used _only_ for sorting commits when writing
> Bloom filters, for `git commit-graph write --reachable --changed-paths ...`
> 
> Assuming that when writing the commit graph we always compute geeration
> number v2 and 'generation' field stores corrected commit date, we don't
> need to use date as a heuristic when generations are equal, and it would
> not help in tie-breaking anyway.
> 
> All right.
> 
> >  	return 0;
> >  }
> >
> > @@ -1342,10 +1337,14 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  					ctx->commits.nr);
> >  	for (i = 0; i < ctx->commits.nr; i++) {
> >  		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
> > +		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
> 
> All right, so the pattern is to add 'corrected_commit_date' stuff after
> 'topological_level' stuff.
> 
> >
> >  		display_progress(ctx->progress, i + 1);
> >  		if (level != GENERATION_NUMBER_V1_INFINITY &&
> > -		    level != GENERATION_NUMBER_ZERO)
> > +		    level != GENERATION_NUMBER_ZERO &&
> > +		    corrected_commit_date != GENERATION_NUMBER_INFINITY &&
> > +		    corrected_commit_date != GENERATION_NUMBER_ZERO
> > +		    )
> >  			continue;
> >
> >  		commit_list_insert(ctx->commits.list[i], &list);
> > @@ -1354,17 +1353,26 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  			struct commit_list *parent;
> >  			int all_parents_computed = 1;
> >  			uint32_t max_level = 0;
> > +			timestamp_t max_corrected_commit_date = 0;
> >
> >  			for (parent = current->parents; parent; parent = parent->next) {
> >  				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
> > +				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
> >
> >  				if (level == GENERATION_NUMBER_V1_INFINITY ||
> > -				    level == GENERATION_NUMBER_ZERO) {
> > +				    level == GENERATION_NUMBER_ZERO ||
> > +				    corrected_commit_date == GENERATION_NUMBER_INFINITY ||
> > +				    corrected_commit_date == GENERATION_NUMBER_ZERO
> > +				    ) {
> >  					all_parents_computed = 0;
> >  					commit_list_insert(parent->item, &list);
> >  					break;
> > -				} else if (level > max_level) {
> > -					max_level = level;
> > +				} else {
> > +					if (level > max_level)
> > +						max_level = level;
> > +
> > +					if (corrected_commit_date > max_corrected_commit_date)
> > +						max_corrected_commit_date = corrected_commit_date;
> >  				}
> >  			}
> >
> > @@ -1374,6 +1382,10 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  				if (max_level > GENERATION_NUMBER_MAX - 1)
> >  					max_level = GENERATION_NUMBER_MAX - 1;
> >  				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
> > +
> > +				if (current->date > max_corrected_commit_date)
> > +					max_corrected_commit_date = current->date - 1;
> > +				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
> >  			}
> >  		}
> >  	}
> 
> All right.  Looks good to me.
> 
> > @@ -2372,8 +2384,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
> >  	for (i = 0; i < g->num_commits; i++) {
> >  		struct commit *graph_commit, *odb_commit;
> >  		struct commit_list *graph_parents, *odb_parents;
> > -		timestamp_t max_generation = 0;
> > -		timestamp_t generation;
> > +		timestamp_t max_corrected_commit_date = 0;
> > +		timestamp_t corrected_commit_date;
> 
> This is simple, and perhaps unnecessary, rename of variables.
> Shouldn't we however verify *both* topological level, and
> (if exists) corrected commit date?

The problem with verifying both topological level and corrected commit
dates is that we would have to re-fill commit_graph_data slab with commit
data chunk as we cannot modify data->generation otherwise, essentially
repeating the whole verification process.

While it's okay for now, I might take this up in a future series [1].

[1]: https://lore.kernel.org/git/4043ffbc-84df-0cd6-5c75-af80383a56cf@gmail.com/

> 
> >
> >  		display_progress(progress, i + 1);
> >  		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> > @@ -2412,9 +2424,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
> >  					     oid_to_hex(&graph_parents->item->object.oid),
> >  					     oid_to_hex(&odb_parents->item->object.oid));
> >
> > -			generation = commit_graph_generation(graph_parents->item);
> > -			if (generation > max_generation)
> > -				max_generation = generation;
> > +			corrected_commit_date = commit_graph_generation(graph_parents->item);
> > +			if (corrected_commit_date > max_corrected_commit_date)
> > +				max_corrected_commit_date = corrected_commit_date;
> 
> Actually, commit_graph_generation(<commit>) can return either corrected
> commit date, or topological level, the latter in backward-compatibility
> case (if at least one commit-graph file is lacking GDAT chunk, because
> [some of] it was created by the "Old" Git).
> 
> >
> >  			graph_parents = graph_parents->next;
> >  			odb_parents = odb_parents->next;
> > @@ -2436,20 +2448,12 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
> >  		if (generation_zero == GENERATION_ZERO_EXISTS)
> >  			continue;
> >
> > -		/*
> > -		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
> > -		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
> > -		 * extra logic in the following condition.
> > -		 */
> > -		if (max_generation == GENERATION_NUMBER_MAX)
> > -			max_generation--;
> 
> All right, this was needed for checking the correctness of topological
> levels (generation number v1) because we were checking not that it
> fullfills the reachability condition, but more strict one: namely that
> topological level of commit is equal to maximum of topological levels of
> its parents plus one.
> 
> The comment about checking both generation number v1 and v2 still
> applies.
> 
> > -
> > -		generation = commit_graph_generation(graph_commit);
> > -		if (generation != max_generation + 1)
> > -			graph_report(_("commit-graph generation for commit %s is %u != %u"),
> > +		corrected_commit_date = commit_graph_generation(graph_commit);
> > +		if (corrected_commit_date < max_corrected_commit_date + 1)
> > +			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
> >  				     oid_to_hex(&cur_oid),
> > -				     generation,
> > -				     max_generation + 1);
> > +				     corrected_commit_date,
> > +				     max_corrected_commit_date + 1);
> 
> All right, we check less strict condition for corrected commit date.
> 
> >
> >  		if (graph_commit->date != odb_commit->date)
> >  			graph_report(_("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime),
> 
> Best,
> -- 
> Jakub Narębski
