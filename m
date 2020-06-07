Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A1C433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 12:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2DA2053B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 12:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG7ArwH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgFGMM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 08:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFGMM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 08:12:27 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3BCC08C5C2
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 05:12:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x18so586000lji.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rtEn0ly36QmKr7JjxDKAcl6BI+6+7QhcHvQJHNTlE+8=;
        b=ZG7ArwH/zwRoffERKbXpKWB+OQ7fwLb/0Vqkys8KGzCDuGpIUq1vKdV1xOsROcQOyJ
         uFuRWozFAJOeQ2RAXLFgxgmNpUUUZFO3iq38CfdTmbFGOvnoxfU6jqS/zhdIk0SrJ5Us
         AZMTJ4TWE+e6bHMPVs6UNi9yN2sj/YpYLJO+mtSyi3gA5y7NJIMjo/7LC96vQlTL7nte
         iQVtp3tEuT0RUj1YWel+8aalBgfhJRvzMy36+FqYY/u/KhxVqwljb1e+zUbgmVtEuQxc
         Ym9Fc+erq14egDqGRxUj+gKRiJzLAbU2h10Z9qZpMVDFW/OPrTHJJwwQ5NVfgk9P/qJU
         eZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=rtEn0ly36QmKr7JjxDKAcl6BI+6+7QhcHvQJHNTlE+8=;
        b=cPu5zrFS4Ntim6q9LI/BV8xHG1W4cmh6sih8mF25+zWcPud+jedcCJe3Y86zIwZGSf
         3SXZUYDBz4yeLMQ3J1gSMY3HEeJD9T/BOztkCIa8cj6WBoAJKnTCuNkWGWMGo4i/AHuO
         q9Crw02lrfR4cZ2onfiXEd2vIdngHQvyoySnRK4B7dTdJnkp97vO4IVrHrza3Mk3jI7s
         PDXNJ9t4aaoDZt4+lD1Rws77ilPwPx/rQk7J7cbg14UEm76Szi4y+EjRDAtSAZqD5Db1
         80KD+HE573Uyy2+JFw7C2Okep+DKblP2dcgsypXgrkU61PoPZPe38Ipjqp7s8IaIjPrh
         Cskg==
X-Gm-Message-State: AOAM533IXqLCm7PsTJ6ZE/JB+2aWdXb+nKLjJJqF3llutZgqzx7bJiR9
        6j1FnphEd8BiELptPhJIEvwXlXaphmQ=
X-Google-Smtp-Source: ABdhPJw7cdUHHNnhumNhHIYnCTSRJ1rq9jLhXhd0K5tOpFOvCtsNYELqt6+G/W2xqq05xBV28ydQig==
X-Received: by 2002:a05:651c:384:: with SMTP id e4mr8683078ljp.410.1591531944932;
        Sun, 07 Jun 2020 05:12:24 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id o4sm3377351lfb.75.2020.06.07.05.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 05:12:24 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSoC Patch 3/3] commit: convert commit->graph_pos to a slab
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
        <20200604072759.19142-4-abhishekkumar8222@gmail.com>
Date:   Sun, 07 Jun 2020 14:12:21 +0200
In-Reply-To: <20200604072759.19142-4-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Thu, 4 Jun 2020 12:57:59 +0530")
Message-ID: <85zh9ft6qi.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> The member graph_pos refers to the integer position used to identify a
> commit in commit-graph files. However, graph_pos is not useful in other
> contexts and bloats the struct.
>
> Let's move it to a commit-slab and shrink the struct by four bytes.
>
> Existing references to graph_pos are replaced using
> 'contrib/coccinelle/graph_pos.cocci'.
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  alloc.c                            |  1 -
>  bloom.c                            |  6 ++--
>  commit-graph.c                     | 50 +++++++++++++++++++++++-------
>  commit-graph.h                     |  3 ++
>  commit.c                           |  2 +-
>  commit.h                           |  2 --
>  contrib/coccinelle/graph_pos.cocci | 12 +++++++
>  7 files changed, 58 insertions(+), 18 deletions(-)
>  create mode 100644 contrib/coccinelle/graph_pos.cocci

I have reordered the chunks to make it easier to review.

> diff --git a/commit.h b/commit.h
> index 01e1c4c3eb..0b10464a10 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -10,8 +10,6 @@
>  #include "pretty.h"
>  #include "commit-slab.h"
>=20=20
> -#define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
> -
>  struct commit_list {
>  	struct commit *item;
>  	struct commit_list *next;
> diff --git a/commit-graph.h b/commit-graph.h
> index 653bd041ad..3cb59ba336 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -8,6 +8,7 @@
>  #include "object-store.h"
>  #include "oidset.h"
>=20=20
> +#define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
>  #define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
>  #define GENERATION_NUMBER_MAX 0x3FFFFFFF
>  #define GENERATION_NUMBER_ZERO 0

Those two chunks move COMMIT_NOT_FROM_GRAPH from commit.h to
commit-graph.h, because it is no longer needed in init_commit_node()
from alloc.c.  On the other hand the remaining commit-graph #define-s
were moved in first commit in series.


What I DO NOT SEE in this commit is actual *removal* of `graph_pos`
field from the `struct commit`, i.e.:

  diff --git a/commit.h b/commit.h
  index cc610400d5..01e1c4c3eb 100644
  --- a/commit.h
  +++ b/commit.h
  @@ -34,6 +34,5 @@ struct commit {
   	 */
   	struct tree *maybe_tree;
  -	uint32_t graph_pos;
   	unsigned int index;
   };
=20=20=20


> diff --git a/alloc.c b/alloc.c
> index cbed187094..f37fb3b8b6 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -108,7 +108,6 @@ void init_commit_node(struct repository *r, struct co=
mmit *c)
>  {
>  	c->object.type =3D OBJ_COMMIT;
>  	c->index =3D alloc_commit_index(r);
> -	c->graph_pos =3D COMMIT_NOT_FROM_GRAPH;
>  }
>
>  void *alloc_commit_node(struct repository *r)

This removes commit->graph_pos initialization from init_commit_node(),
and thus from alloc_commit_node(); the handling of COMMIT_NOT_FROM_GRAPH
is moved to setter and getter "methods", see below.

> diff --git a/commit-graph.c b/commit-graph.c
> index 9ce7d4acb1..7ff460b442 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -87,6 +87,34 @@ static int commit_pos_cmp(const void *va, const void *=
vb)
>  	       commit_pos_at(&commit_pos, b);
>  }
>=20=20
> +define_commit_slab(graph_pos_slab, uint32_t);
> +static struct graph_pos_slab graph_pos_slab =3D COMMIT_SLAB_INIT(1, grap=
h_pos_slab);
> +
> +uint32_t graph_pos(const struct commit *c)
> +{
> +	uint32_t *pos =3D graph_pos_slab_peek(&graph_pos_slab, c);
> +
> +	return pos ? *pos : COMMIT_NOT_FROM_GRAPH;
> +}
> +
> +static void set_graph_pos(const struct commit *c, const uint32_t positio=
n)
> +{
> +	unsigned int i =3D graph_pos_slab.slab_count;
> +	uint32_t *pos =3D graph_pos_slab_at(&graph_pos_slab, c);
> +
> +	/*
> +	 * commit-slab initializes with zero, overwrite this with
> +	 * COMMIT_NOT_FROM_GRAPH
> +	 */
> +	for (; i < graph_pos_slab.slab_count; ++i)
> +	{
> +		memset(graph_pos_slab.slab[i], COMMIT_NOT_FROM_GRAPH,
> +		       graph_pos_slab.slab_size * sizeof(uint32_t));
> +	}
> +
> +	*pos =3D position;
> +}
> +
>  define_commit_slab(generation_slab, uint32_t);
>  static struct generation_slab generation_slab =3D COMMIT_SLAB_INIT(1, ge=
neration_slab);
>=20=20
[...]
> @@ -142,4 +143,6 @@ void free_commit_graph(struct commit_graph *);
>  void disable_commit_graph(struct repository *r);
>=20=20
>  uint32_t generation(const struct commit *c);
> +
> +uint32_t graph_pos(const struct commit *c);
>  #endif


I wonder why those helper functions: graph_pos() and set_graph_pos()
were not introduced in the 1st patch of this series, together with
generation() and set_generation().

The same comments as for previous patch apply: if graph_pos was not
explicitely set, we want for it to be COMMIT_NOT_FROM_GRAPH (like
init_commit_node() did before this change).  If it is not on
commit-slab, it is not set -- this is handled by graph_pos() function.
However we allocate memory on slab in chunks, and set_graph_pos()
ensures that those extra allocated `graph_pos` values on commit-slab are
properly initialized to COMMIT_NOT_FROM_GRAPH, like init_commit_node()
did.


Note that we always have COMMIT_NOT_FROM_GRAPH for `graph_pos` if and
only if there is GENERATION_NUMBER_INFINITY for `generation`, so perhaps
putting those two together in `struct commit_graph_info` would make
sense.  But whether doing more work in "setter" set_*() functions or
doing extra conditional in "getter" *() would give better performance
needs (micro-)benchmarking.


> diff --git a/contrib/coccinelle/graph_pos.cocci b/contrib/coccinelle/grap=
h_pos.cocci
> new file mode 100644
> index 0000000000..0929164bdf
> --- /dev/null
> +++ b/contrib/coccinelle/graph_pos.cocci
> @@ -0,0 +1,12 @@
> +@@
> +struct commit *c;
> +expression E;
> +@@
> +- c->graph_pos =3D E
> ++ set_graph_pos(c, E)
> +
> +@@
> +struct commit *c;
> +@@
> +- c->graph_pos
> ++ graph_pos(c)

This is semantic patch that generates the rest of changes.  (If any of
those needs manual improvement, it is better left for a separate "manual
fixup" patch, in my opinion.)

> diff --git a/bloom.c b/bloom.c
> index 9b86aa3f59..5bee5bb0c1 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -34,14 +34,14 @@ static int load_bloom_filter_from_graph(struct commit=
_graph *g,
>  {
>  	uint32_t lex_pos, start_index, end_index;
>=20=20
> -	while (c->graph_pos < g->num_commits_in_base)
> +	while (graph_pos(c) < g->num_commits_in_base)
>  		g =3D g->base_graph;
>=20=20
>  	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
>  	if (!g->chunk_bloom_indexes)
>  		return 0;
>=20=20
> -	lex_pos =3D c->graph_pos - g->num_commits_in_base;
> +	lex_pos =3D graph_pos(c) - g->num_commits_in_base;
>=20=20
>  	end_index =3D get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
>

Here graph_pos(c) is used twice.

It probably needs to be checked (with benchmark) if it matters.


> @@ -188,7 +188,7 @@ struct bloom_filter *get_bloom_filter(struct reposito=
ry *r,
>=20=20
>  	if (!filter->data) {
>  		load_commit_graph_info(r, c);
> -		if (c->graph_pos !=3D COMMIT_NOT_FROM_GRAPH &&
> +		if (graph_pos(c) !=3D COMMIT_NOT_FROM_GRAPH &&
>  			r->objects->commit_graph->chunk_bloom_indexes) {
>  			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
>  				return filter;

> diff --git a/commit-graph.c b/commit-graph.c
> index 9ce7d4acb1..7ff460b442 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -697,7 +725,7 @@ static struct commit_list **insert_parent_or_die(stru=
ct repository *r,
>  	c =3D lookup_commit(r, &oid);
>  	if (!c)
>  		die(_("could not find commit %s"), oid_to_hex(&oid));
> -	c->graph_pos =3D pos;
> +	set_graph_pos(c, pos);
>  	return &commit_list_insert(c, pptr)->next;
>  }
>=20=20
> @@ -711,7 +739,7 @@ static void fill_commit_graph_info(struct commit *ite=
m, struct commit_graph *g,
>=20=20
>  	lex_index =3D pos - g->num_commits_in_base;
>  	commit_data =3D g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
> -	item->graph_pos =3D pos;
> +	set_graph_pos(item, pos);
>  	set_generation(item, get_be32(commit_data + g->hash_len + 8) >> 2);
>  }
>=20=20
> @@ -741,7 +769,7 @@ static int fill_commit_in_graph(struct repository *r,
>  	 * Store the "full" position, but then use the
>  	 * "local" position for the rest of the calculation.
>  	 */
> -	item->graph_pos =3D pos;
> +	set_graph_pos(item, pos);
>  	lex_index =3D pos - g->num_commits_in_base;
>=20=20
>  	commit_data =3D g->chunk_commit_data + (g->hash_len + 16) * lex_index;

> @@ -786,8 +814,8 @@ static int fill_commit_in_graph(struct repository *r,
>=20=20
>  static int find_commit_in_graph(struct commit *item, struct commit_graph=
 *g, uint32_t *pos)
>  {
> -	if (item->graph_pos !=3D COMMIT_NOT_FROM_GRAPH) {
> -		*pos =3D item->graph_pos;
> +	if (graph_pos(item) !=3D COMMIT_NOT_FROM_GRAPH) {
> +		*pos =3D graph_pos(item);
>  		return 1;

Here graph_pos(item) is used twice.

>  	} else {
>  		struct commit_graph *cur_g =3D g;
> @@ -843,11 +871,11 @@ static struct tree *load_tree_for_commit(struct rep=
ository *r,
>  	struct object_id oid;
>  	const unsigned char *commit_data;
>=20=20
> -	while (c->graph_pos < g->num_commits_in_base)
> +	while (graph_pos(c) < g->num_commits_in_base)
>  		g =3D g->base_graph;
>=20=20
>  	commit_data =3D g->chunk_commit_data +
> -			GRAPH_DATA_WIDTH * (c->graph_pos - g->num_commits_in_base);
> +			GRAPH_DATA_WIDTH * (graph_pos(c) - g->num_commits_in_base);
>=20=20
>  	hashcpy(oid.hash, commit_data);
>  	set_commit_tree(c, lookup_tree(r, &oid));

Here graph_pos(c) is used twice.

> @@ -861,7 +889,7 @@ static struct tree *get_commit_tree_in_graph_one(stru=
ct repository *r,
>  {
>  	if (c->maybe_tree)
>  		return c->maybe_tree;
> -	if (c->graph_pos =3D=3D COMMIT_NOT_FROM_GRAPH)
> +	if (graph_pos(c) =3D=3D COMMIT_NOT_FROM_GRAPH)
>  		BUG("get_commit_tree_in_graph_one called from non-commit-graph commit"=
);
>=20=20
>  	return load_tree_for_commit(r, g, (struct commit *)c);
> @@ -1247,7 +1275,7 @@ static void close_reachable(struct write_commit_gra=
ph_context *ctx)
>  			continue;
>  		if (ctx->split) {
>  			if ((!parse_commit(commit) &&
> -			     commit->graph_pos =3D=3D COMMIT_NOT_FROM_GRAPH) ||
> +			     graph_pos(commit) =3D=3D COMMIT_NOT_FROM_GRAPH) ||
>  			    flags =3D=3D COMMIT_GRAPH_SPLIT_REPLACE)
>  				add_missing_parents(ctx, commit);
>  		} else if (!parse_commit_no_graph(commit))
> @@ -1493,7 +1521,7 @@ static uint32_t count_distinct_commits(struct write=
_commit_graph_context *ctx)
>  			if (ctx->split) {
>  				struct commit *c =3D lookup_commit(ctx->r, &ctx->oids.list[i]);
>=20=20
> -				if (!c || c->graph_pos !=3D COMMIT_NOT_FROM_GRAPH)
> +				if (!c || graph_pos(c) !=3D COMMIT_NOT_FROM_GRAPH)
>  					continue;
>  			}
>=20=20
> @@ -1527,7 +1555,7 @@ static void copy_oids_to_commits(struct write_commi=
t_graph_context *ctx)
>  		ctx->commits.list[ctx->commits.nr] =3D lookup_commit(ctx->r, &ctx->oid=
s.list[i]);
>=20=20
>  		if (ctx->split && flags !=3D COMMIT_GRAPH_SPLIT_REPLACE &&
> -		    ctx->commits.list[ctx->commits.nr]->graph_pos !=3D COMMIT_NOT_FROM=
_GRAPH)
> +		    graph_pos(ctx->commits.list[ctx->commits.nr]) !=3D COMMIT_NOT_FROM=
_GRAPH)
>  			continue;
>=20=20
>  		if (ctx->split && flags =3D=3D COMMIT_GRAPH_SPLIT_REPLACE)
> diff --git a/commit.c b/commit.c
> index 8dad0f8446..da6de08b2b 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -339,7 +339,7 @@ struct tree *repo_get_commit_tree(struct repository *=
r,
>  	if (commit->maybe_tree || !commit->object.parsed)
>  		return commit->maybe_tree;
>=20=20
> -	if (commit->graph_pos !=3D COMMIT_NOT_FROM_GRAPH)
> +	if (graph_pos(commit) !=3D COMMIT_NOT_FROM_GRAPH)
>  		return get_commit_tree_in_graph(r, commit);
>=20=20
>  	return NULL;

Best,
--=20
Jakub Nar=C4=99bski
