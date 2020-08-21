Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6914BC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 13:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E26207BB
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 13:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdG/q/XU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHUNOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgHUNOh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 09:14:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5853C061385
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 06:14:36 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w25so1768374ljo.12
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RGHWWpkddF8qIJr8jPQtzUZBqR7rcvBTriM+C9LAPoc=;
        b=BdG/q/XUQXvp2sZOV2zCo6JgptT7+Ik01G9h9GDMZ6zBBAs+Cr0SjVqM+ZfQ3DhKeh
         uCn3jeK+n1Se91kAF7g2gDNFuL9aD3/wXNWwHDXTDqE/FkF9880ZUTkzQML0mwy4RoMv
         yTVRnTIE3JYgolTxBV5BQETOoklZ4MhowO7egZB7/wfPWfXzi54SThXHoRTBSRwvLK4V
         mYrwdsPNQrLk9f1AiDET2lgtf3J10Xtf2JG5QX2qor5H6LUNgHwlyC5LXo/FfXoLR6fN
         v7FV/hWAhJNwDFMvYPR5yZzp2z9FRyXuVOmi4ivocgjO1oZ9sFPwlKTnea1tcpYCDtKL
         uJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=RGHWWpkddF8qIJr8jPQtzUZBqR7rcvBTriM+C9LAPoc=;
        b=g485ZMLqYuA1LIW95yKOQ+QG9vz2762+TDitwoKqNSCG4tnLXZlsvcWIgn1s1UyOB0
         hWi0PY65aF44d+LNSVqwNoMAvW65nv3ve7PG4PruKXLEl0HylQQ6HmczahTXgHvYx8To
         5tyUMhIX/Vi5YWzcgy5c2nhBwlNaySBQmVwvdwpTZaBAzUi0xhrnaYb295xdIcMG7NYV
         FQiVnkaqKZllabvrajKqnHp48t/b+UDTueu4z5bs1K/W3PT5bGRpEmRFouePL3ECLDhw
         wcssrT8P7E9vdlrj627aRmPUvC+GuiycEpp9/qMonp0JHj1B9YW1lgvrv/1p6WQWzV3C
         9oPQ==
X-Gm-Message-State: AOAM530e78ANxWDGuhp+/jg9Z8oFJYMDdRfrbRfciDa4vVOcF4iNp4hH
        RgW8YgHJYdXIDgosF7G4H+A1ymduPnscgQ==
X-Google-Smtp-Source: ABdhPJy4/Ke1InBQBAgZMeWDM5f4oAqCSIODldvSPP/KiGuUwVggHOHIQ9bT6c7CrgPfWcbQGiTyBQ==
X-Received: by 2002:a2e:80d8:: with SMTP id r24mr1451713ljg.305.1598015675063;
        Fri, 21 Aug 2020 06:14:35 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id d13sm382108lfl.89.2020.08.21.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:14:33 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 05/11] commit-graph: return 64-bit generation number
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <6be759a9542114e4de41422efa18491085e19682.1597509583.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 15:14:34 +0200
In-Reply-To: <6be759a9542114e4de41422efa18491085e19682.1597509583.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:37
        +0000")
Message-ID: <85d03km98l.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> In a preparatory step, let's return timestamp_t values from
> commit_graph_generation(), use timestamp_t for local variables

All right, this is all good.

> and define GENERATION_NUMBER_INFINITY as (2 ^ 63 - 1) instead.

This needs more detailed examination.  There are two similar constants,
GENERATION_NUMBER_INFINITY and GENERATION_NUMBER_MAX.  The former is
used for newest commits outside the commit-graph, while the latter is
maximum number that commits in the commit-graph can have (because of the
storage limitations).  We therefore need GENERATION_NUMBER_INFINITY
to be larger than GENERATION_NUMBER_MAX, and it is (and was).

The GENERATION_NUMBER_INFINITY is because of the above requirement
traditionally taken as maximum value that can be represented in the data
type used to store commit's generation number _in memory_, but it can be
less.  For timestamp_t the maximum value that can be represented
is (2 ^ 63 - 1).

All right then.

>

The commit message says nothing about the new symbolic constant
GENERATION_NUMBER_V1_INFINITY, though.

I'm not sure it is even needed (see comments below).

> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 18 +++++++++---------
>  commit-graph.h |  4 ++--
>  commit-reach.c | 32 ++++++++++++++++----------------
>  commit-reach.h |  2 +-
>  commit.h       |  3 ++-
>  revision.c     | 10 +++++-----
>  upload-pack.c  |  2 +-
>  7 files changed, 36 insertions(+), 35 deletions(-)

I hope that changing the type returned by commit_graph_generation() and
stored in 'generation' field of `struct commit_graph_data` would mean
that the compiler or at least the linter would catch all the places that
need updating the type.

Just in case, I have performed a simple code search and it agrees with
the above list (one search result missing, in commit.c, was handled by
previous patch).

>
> diff --git a/commit-graph.c b/commit-graph.c
> index fb6e2bf18f..7f9f858577 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -99,7 +99,7 @@ uint32_t commit_graph_position(const struct commit *c)
>  	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
>  }
>
> -uint32_t commit_graph_generation(const struct commit *c)
> +timestamp_t commit_graph_generation(const struct commit *c)
>  {
>  	struct commit_graph_data *data =3D
>  		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
> @@ -115,8 +115,8 @@ uint32_t commit_graph_generation(const struct commit =
*c)
>  int compare_commits_by_gen(const void *_a, const void *_b)
>  {
>  	const struct commit *a =3D _a, *b =3D _b;
> -	const uint32_t generation_a =3D commit_graph_generation(a);
> -	const uint32_t generation_b =3D commit_graph_generation(b);
> +	const timestamp_t generation_a =3D commit_graph_generation(a);
> +	const timestamp_t generation_b =3D commit_graph_generation(b);
>
>  	/* older commits first */
>  	if (generation_a < generation_b)
> @@ -159,8 +159,8 @@ static int commit_gen_cmp(const void *va, const void =
*vb)
>  	const struct commit *a =3D *(const struct commit **)va;
>  	const struct commit *b =3D *(const struct commit **)vb;
>
> -	uint32_t generation_a =3D commit_graph_data_at(a)->generation;
> -	uint32_t generation_b =3D commit_graph_data_at(b)->generation;
> +	const timestamp_t generation_a =3D commit_graph_data_at(a)->generation;
> +	const timestamp_t generation_b =3D commit_graph_data_at(b)->generation;
>  	/* lower generation commits first */
>  	if (generation_a < generation_b)
>  		return -1;

All right.

> @@ -1338,7 +1338,7 @@ static void compute_generation_numbers(struct write=
_commit_graph_context *ctx)
>  		uint32_t generation =3D commit_graph_data_at(ctx->commits.list[i])->ge=
neration;

Shouldn't this be

-  		uint32_t generation =3D commit_graph_data_at(ctx->commits.list[i])->ge=
neration;
+  		timestamp_t generation =3D commit_graph_data_at(ctx->commits.list[i])-=
>generation;


>
>  		display_progress(ctx->progress, i + 1);
> -		if (generation !=3D GENERATION_NUMBER_INFINITY &&
> +		if (generation !=3D GENERATION_NUMBER_V1_INFINITY &&

Then there would be no need for this change, isn't it?

>  		    generation !=3D GENERATION_NUMBER_ZERO)
>  			continue;
>
> @@ -1352,7 +1352,7 @@ static void compute_generation_numbers(struct write=
_commit_graph_context *ctx)
>  			for (parent =3D current->parents; parent; parent =3D parent->next) {
>  				generation =3D commit_graph_data_at(parent->item)->generation;
>
> -				if (generation =3D=3D GENERATION_NUMBER_INFINITY ||
> +				if (generation =3D=3D GENERATION_NUMBER_V1_INFINITY ||

And this one either.

>  				    generation =3D=3D GENERATION_NUMBER_ZERO) {
>  					all_parents_computed =3D 0;
>  					commit_list_insert(parent->item, &list);
> @@ -2355,8 +2355,8 @@ int verify_commit_graph(struct repository *r, struc=
t commit_graph *g, int flags)
>  	for (i =3D 0; i < g->num_commits; i++) {
>  		struct commit *graph_commit, *odb_commit;
>  		struct commit_list *graph_parents, *odb_parents;
> -		uint32_t max_generation =3D 0;
> -		uint32_t generation;
> +		timestamp_t max_generation =3D 0;
> +		timestamp_t generation;

All right.

>
>  		display_progress(progress, i + 1);
>  		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> diff --git a/commit-graph.h b/commit-graph.h
> index 701e3d41aa..430bc830bb 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -138,13 +138,13 @@ void disable_commit_graph(struct repository *r);
>
>  struct commit_graph_data {
>  	uint32_t graph_pos;
> -	uint32_t generation;
> +	timestamp_t generation;
>  };

All right; this is the main part of this change.

>
>  /*
>   * Commits should be parsed before accessing generation, graph positions.
>   */
> -uint32_t commit_graph_generation(const struct commit *);
> +timestamp_t commit_graph_generation(const struct commit *);
>  uint32_t commit_graph_position(const struct commit *);

As is this one.

>
>  int compare_commits_by_gen(const void *_a, const void *_b);
> diff --git a/commit-reach.c b/commit-reach.c
> index c83cc291e7..470bc80139 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -32,12 +32,12 @@ static int queue_has_nonstale(struct prio_queue *queu=
e)
>  static struct commit_list *paint_down_to_common(struct repository *r,
>  						struct commit *one, int n,
>  						struct commit **twos,
> -						int min_generation)
> +						timestamp_t min_generation)
>  {
>  	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
>  	struct commit_list *result =3D NULL;
>  	int i;
> -	uint32_t last_gen =3D GENERATION_NUMBER_INFINITY;
> +	timestamp_t last_gen =3D GENERATION_NUMBER_INFINITY;
>
>  	if (!min_generation)
>  		queue.compare =3D compare_commits_by_commit_date;

All right.

> @@ -58,10 +58,10 @@ static struct commit_list *paint_down_to_common(struc=
t repository *r,
>  		struct commit *commit =3D prio_queue_get(&queue);
>  		struct commit_list *parents;
>  		int flags;
> -		uint32_t generation =3D commit_graph_generation(commit);
> +		timestamp_t generation =3D commit_graph_generation(commit);
>
>  		if (min_generation && generation > last_gen)
> -			BUG("bad generation skip %8x > %8x at %s",
> +			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
>  			    generation, last_gen,
>  			    oid_to_hex(&commit->object.oid));
>  		last_gen =3D generation;

All right.

> @@ -177,12 +177,12 @@ static int remove_redundant(struct repository *r, s=
truct commit **array, int cnt
>  		repo_parse_commit(r, array[i]);
>  	for (i =3D 0; i < cnt; i++) {
>  		struct commit_list *common;
> -		uint32_t min_generation =3D commit_graph_generation(array[i]);
> +		timestamp_t min_generation =3D commit_graph_generation(array[i]);
>
>  		if (redundant[i])
>  			continue;
>  		for (j =3D filled =3D 0; j < cnt; j++) {
> -			uint32_t curr_generation;
> +			timestamp_t curr_generation;
>  			if (i =3D=3D j || redundant[j])
>  				continue;
>  			filled_index[filled] =3D j;

All right.

> @@ -321,7 +321,7 @@ int repo_in_merge_bases_many(struct repository *r, st=
ruct commit *commit,
>  {
>  	struct commit_list *bases;
>  	int ret =3D 0, i;
> -	uint32_t generation, min_generation =3D GENERATION_NUMBER_INFINITY;
> +	timestamp_t generation, min_generation =3D GENERATION_NUMBER_INFINITY;
>
>  	if (repo_parse_commit(r, commit))
>  		return ret;

All right,

> @@ -470,7 +470,7 @@ static int in_commit_list(const struct commit_list *w=
ant, struct commit *c)
>  static enum contains_result contains_test(struct commit *candidate,
>  					  const struct commit_list *want,
>  					  struct contains_cache *cache,
> -					  uint32_t cutoff)
> +					  timestamp_t cutoff)

All right.

(Sidenote: this one I have missed in my simple search.)

>  {
>  	enum contains_result *cached =3D contains_cache_at(cache, candidate);
>
> @@ -506,11 +506,11 @@ static enum contains_result contains_tag_algo(struc=
t commit *candidate,
>  {
>  	struct contains_stack contains_stack =3D { 0, 0, NULL };
>  	enum contains_result result;
> -	uint32_t cutoff =3D GENERATION_NUMBER_INFINITY;
> +	timestamp_t cutoff =3D GENERATION_NUMBER_INFINITY;
>  	const struct commit_list *p;
>
>  	for (p =3D want; p; p =3D p->next) {
> -		uint32_t generation;
> +		timestamp_t generation;
>  		struct commit *c =3D p->item;
>  		load_commit_graph_info(the_repository, c);
>  		generation =3D commit_graph_generation(c);

All right.

> @@ -565,7 +565,7 @@ int can_all_from_reach_with_flag(struct object_array =
*from,
>  				 unsigned int with_flag,
>  				 unsigned int assign_flag,
>  				 time_t min_commit_date,
> -				 uint32_t min_generation)
> +				 timestamp_t min_generation)
>  {
>  	struct commit **list =3D NULL;
>  	int i;
> @@ -666,13 +666,13 @@ int can_all_from_reach(struct commit_list *from, st=
ruct commit_list *to,
>  	time_t min_commit_date =3D cutoff_by_min_date ? from->item->date : 0;
>  	struct commit_list *from_iter =3D from, *to_iter =3D to;
>  	int result;
> -	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
> +	timestamp_t min_generation =3D GENERATION_NUMBER_INFINITY;
>
>  	while (from_iter) {
>  		add_object_array(&from_iter->item->object, NULL, &from_objs);
>
>  		if (!parse_commit(from_iter->item)) {
> -			uint32_t generation;
> +			timestamp_t generation;
>  			if (from_iter->item->date < min_commit_date)
>  				min_commit_date =3D from_iter->item->date;
>
> @@ -686,7 +686,7 @@ int can_all_from_reach(struct commit_list *from, stru=
ct commit_list *to,
>
>  	while (to_iter) {
>  		if (!parse_commit(to_iter->item)) {
> -			uint32_t generation;
> +			timestamp_t generation;
>  			if (to_iter->item->date < min_commit_date)
>  				min_commit_date =3D to_iter->item->date;
>

All right.

> @@ -726,13 +726,13 @@ struct commit_list *get_reachable_subset(struct com=
mit **from, int nr_from,
>  	struct commit_list *found_commits =3D NULL;
>  	struct commit **to_last =3D to + nr_to;
>  	struct commit **from_last =3D from + nr_from;
> -	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
> +	timestamp_t min_generation =3D GENERATION_NUMBER_INFINITY;
>  	int num_to_find =3D 0;
>
>  	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
>
>  	for (item =3D to; item < to_last; item++) {
> -		uint32_t generation;
> +		timestamp_t generation;
>  		struct commit *c =3D *item;
>
>  		parse_commit(c);

All right.

> diff --git a/commit-reach.h b/commit-reach.h
> index b49ad71a31..148b56fea5 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -87,7 +87,7 @@ int can_all_from_reach_with_flag(struct object_array *f=
rom,
>  				 unsigned int with_flag,
>  				 unsigned int assign_flag,
>  				 time_t min_commit_date,
> -				 uint32_t min_generation);
> +				 timestamp_t min_generation);
>  int can_all_from_reach(struct commit_list *from, struct commit_list *to,
>  		       int commit_date_cutoff);
>

All right.

> diff --git a/commit.h b/commit.h
> index e901538909..bc0732a4fe 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -11,7 +11,8 @@
>  #include "commit-slab.h"
>
>  #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
> -#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> +#define GENERATION_NUMBER_INFINITY ((1ULL << 63) - 1)
> +#define GENERATION_NUMBER_V1_INFINITY 0xFFFFFFFF
>  #define GENERATION_NUMBER_MAX 0x3FFFFFFF
>  #define GENERATION_NUMBER_ZERO 0
>

Why do we even need GENERATION_NUMBER_V1_INFINITY?  It is about marking
out-of-graph commits, and it is about in-memory storage.

We would need separate GENERATION_NUMBER_V1_MAX and GENERATION_NUMBER_V2_MAX
because of different _on-disk_ storage, or in other words file format
limitations.  But that is for the future commit.

> diff --git a/revision.c b/revision.c
> index ecf757c327..411852468b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3290,7 +3290,7 @@ define_commit_slab(indegree_slab, int);
>  define_commit_slab(author_date_slab, timestamp_t);
>
>  struct topo_walk_info {
> -	uint32_t min_generation;
> +	timestamp_t min_generation;
>  	struct prio_queue explore_queue;
>  	struct prio_queue indegree_queue;
>  	struct prio_queue topo_queue;

All right.

> @@ -3336,7 +3336,7 @@ static void explore_walk_step(struct rev_info *revs)
>  }
>
>  static void explore_to_depth(struct rev_info *revs,
> -			     uint32_t gen_cutoff)
> +			     timestamp_t gen_cutoff)
>  {
>  	struct topo_walk_info *info =3D revs->topo_walk_info;
>  	struct commit *c;

All right.

> @@ -3379,7 +3379,7 @@ static void indegree_walk_step(struct rev_info *rev=
s)
>  }
>
>  static void compute_indegrees_to_depth(struct rev_info *revs,
> -				       uint32_t gen_cutoff)
> +				       timestamp_t gen_cutoff)
>  {
>  	struct topo_walk_info *info =3D revs->topo_walk_info;
>  	struct commit *c;
> @@ -3437,7 +3437,7 @@ static void init_topo_walk(struct rev_info *revs)
>  	info->min_generation =3D GENERATION_NUMBER_INFINITY;
>  	for (list =3D revs->commits; list; list =3D list->next) {
>  		struct commit *c =3D list->item;
> -		uint32_t generation;
> +		timestamp_t generation;
>
>  		if (parse_commit_gently(c, 1))
>  			continue;

All right.

> @@ -3498,7 +3498,7 @@ static void expand_topo_walk(struct rev_info *revs,=
 struct commit *commit)
>  	for (p =3D commit->parents; p; p =3D p->next) {
>  		struct commit *parent =3D p->item;
>  		int *pi;
> -		uint32_t generation;
> +		timestamp_t generation;
>
>  		if (parent->object.flags & UNINTERESTING)
>  			continue;

All right.

> diff --git a/upload-pack.c b/upload-pack.c
> index 80ad9a38d8..bcb8b5dfda 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -497,7 +497,7 @@ static int got_oid(struct upload_pack_data *data,
>
>  static int ok_to_give_up(struct upload_pack_data *data)
>  {
> -	uint32_t min_generation =3D GENERATION_NUMBER_ZERO;
> +	timestamp_t min_generation =3D GENERATION_NUMBER_ZERO;
>
>  	if (!data->have_obj.nr)
>  		return 0;

All right.


Best,
--=20
Jakub Nar=C4=99bski
