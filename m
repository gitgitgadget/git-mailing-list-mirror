Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36255C433E0
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 22:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DE820663
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 22:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpnG0TlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgFFWDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Jun 2020 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgFFWDq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jun 2020 18:03:46 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4C3C03E96A
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 15:03:45 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id e125so7952352lfd.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2020 15:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jaEwKnTnOynyH2jR+xRQC5FtpMMC2C6XRvO46XmjjRI=;
        b=ZpnG0TlXyeh4tqybDLmg98S1LiypQeNAqs3yGkirTyFGToYLHDVZ4fdpN1+1HxpfjB
         A408Ib8SHsrzCO6q5eSE+SqCt8CAaFsAUcQ6KuZPSopwmTPxhadQX4q4zuGVVLs4EwDu
         ECXleg+Voh0CNgWoiVSzRv5ma93LjvJJhZPWpby7OgpJ9eE191IY4qB1Ee+6NGouT3Bx
         Yv7VuZsPx3AG9/kH9envGrO0HSdKB3cNml6HvmRihsqvOQPeeXC8IbJaE7eU25sDPnut
         Vtr5BTPNJH0ukwpOkhDv4il2FwYMYXl4dYyaSsd87D0q/rXMT8AzIRS7pERzPk7dbL1G
         XvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=jaEwKnTnOynyH2jR+xRQC5FtpMMC2C6XRvO46XmjjRI=;
        b=WkS8hl5NLUJN++7hM2YOspxPELh9CLlq55G696x/Kq6FIyU+SUcg5njKSbvtyk8Od5
         /TPk7K/t6lSMqoPoopeuCzGiXBpesYBLLjYGnNkyQFDGyvEivNcRN++qU0AR/ltZjcDi
         cvjEqkJZKHYHfURiviOmoPQx32qUC7ksok+qYP6dOh7qFCtN61V1XYDjCB6JcbXyBxKm
         YOl8kN9edMdAPF13yKCMC7y0ZGrAnnjCbSn1BAqxqnj39NPy1ubj9745ouKJYGRUbxGQ
         ANpKGdgtSJ/u5+CptO8JjTQrwOaSLsY61wR0ZJlzvl9jw4gN3xAYEolbpMGyfwTFuFpu
         Kbew==
X-Gm-Message-State: AOAM531pdJKyEb6PBXJHDqxNCqeJ8AqiXpirW8IIX1gVmCMlFc5ARcG/
        vxqHQifx4HMJTxcmG/qmxy8=
X-Google-Smtp-Source: ABdhPJzbQuxQZzTGz0iKLXDFZ4pNitNDEBHe8ClVk/Ckf+fTF2vTviUfIMbUBWScsiztWOwg8zh74Q==
X-Received: by 2002:a05:6512:110e:: with SMTP id l14mr8189883lfg.25.1591481022741;
        Sat, 06 Jun 2020 15:03:42 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id 72sm2613318lfa.52.2020.06.06.15.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 15:03:41 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSoC Patch 2/3] commit: convert commit->generation to a slab
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
        <20200604072759.19142-3-abhishekkumar8222@gmail.com>
Date:   Sun, 07 Jun 2020 00:03:38 +0200
In-Reply-To: <20200604072759.19142-3-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Thu, 4 Jun 2020 12:57:58 +0530")
Message-ID: <85lfkzvolh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> In this commit, we will use the generation slab helpers introduced in
> last commit and replace existing uses of commit->generation using
> 'contrib/coccinelle/generation.cocci'
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  alloc.c                             |  1 -
>  blame.c                             |  2 +-
>  commit-graph.c                      | 39 +++++++++++-----------
>  commit-reach.c                      | 50 ++++++++++++++---------------
>  commit.c                            |  4 +--
>  commit.h                            |  1 -
>  contrib/coccinelle/generation.cocci | 12 +++++++
>  revision.c                          | 16 ++++-----
>  8 files changed, 68 insertions(+), 57 deletions(-)
>  create mode 100644 contrib/coccinelle/generation.cocci
>

For easier review I have changed the order of files, grouping together
different categories of changes.


First category is removing commit->generation and related changes:

> diff --git a/commit.h b/commit.h
> index cc610400d5..01e1c4c3eb 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -34,7 +34,6 @@ struct commit {
>  	 */
>  	struct tree *maybe_tree;
>  	uint32_t graph_pos;
> -	uint32_t generation;
>  	unsigned int index;
>  };
>=20=20

This is quite straightforward.

> diff --git a/alloc.c b/alloc.c
> index 1c64c4dd16..cbed187094 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -109,7 +109,6 @@ void init_commit_node(struct repository *r, struct co=
mmit *c)
>  	c->object.type =3D OBJ_COMMIT;
>  	c->index =3D alloc_commit_index(r);
>  	c->graph_pos =3D COMMIT_NOT_FROM_GRAPH;
> -	c->generation =3D GENERATION_NUMBER_INFINITY;
>  }
>=20=20
>  void *alloc_commit_node(struct repository *r)

But this change might need a more detailed write-up in the commit
message.

If I understand it correctly, this is function is used by generic commit
allocator, and given commit object may not need generation number. That
is why the default value of GENERATION_NUMBER_INFINITY is handled by new
"getters" and "setters", i.e. generation() and set_generation() -- which
are called only if commit-graph is present, I think.

The generation() returns GENERATION_NUMBER_INFINITY for commits not in
generation_slab, assuming that for all commits in the commit graph it
would be filled by commit-graph parsing -- just like init_commit_node()
would initialize commit->generation to this value.

Because <slabname>_at() (including generation_slab_at()) extends array
if necessary, we want all data on generation_slab to be correctly
initialized to GENERATION_NUMBER_INFINITY, just like init_commit_node()
would do it, because generation() "getter" cannot.  The commit might be
present on generation_slab just because allocation is done in chunks
(slabs).


Second category is semantic patch that generates the rest of changes
(which could be adjusted manually in subsequent commits).

> diff --git a/contrib/coccinelle/generation.cocci b/contrib/coccinelle/gen=
eration.cocci
> new file mode 100644
> index 0000000000..da13c44856
> --- /dev/null
> +++ b/contrib/coccinelle/generation.cocci
> @@ -0,0 +1,12 @@
> +@@
> +struct commit *c;
> +expression E;
> +@@
> +- c->generation =3D E
> ++ set_generation(c, E)
> +
> +@@
> +struct commit *c;
> +@@
> +- c->generation
> ++ generation(c)

I wonder if Coccinelle is able to automatically discard extra
parentheses (the problem noticed by Stolee in his reply) with the
following chunk:

  +@@
  +struct commit *c;
  +@@
  +- (c)->generation
  ++ generation(c)


Third category is all the changes that are just straight mechanical
changes being the result of applying the Coccinelle patch.

> diff --git a/blame.c b/blame.c
> index da7e28800e..50e6316076 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -1272,7 +1272,7 @@ static int maybe_changed_path(struct repository *r,
>  	if (!bd)
>  		return 1;
>=20=20
> -	if (origin->commit->generation =3D=3D GENERATION_NUMBER_INFINITY)
> +	if (generation(origin->commit) =3D=3D GENERATION_NUMBER_INFINITY)
>  		return 1;
>=20=20
>  	filter =3D get_bloom_filter(r, origin->commit, 0);
> diff --git a/commit-graph.c b/commit-graph.c
> index 63f419048d..9ce7d4acb1 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -120,9 +120,9 @@ static int commit_gen_cmp(const void *va, const void =
*vb)
>  	const struct commit *b =3D *(const struct commit **)vb;
>=20=20
>  	/* lower generation commits first */
> -	if (a->generation < b->generation)
> +	if (generation(a) < generation(b))
>  		return -1;
> -	else if (a->generation > b->generation)
> +	else if (generation(a) > generation(b))
>  		return 1;
>=20=20
>  	/* use date as a heuristic when generations are equal */
> @@ -712,7 +712,7 @@ static void fill_commit_graph_info(struct commit *ite=
m, struct commit_graph *g,
>  	lex_index =3D pos - g->num_commits_in_base;
>  	commit_data =3D g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
>  	item->graph_pos =3D pos;
> -	item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
> +	set_generation(item, get_be32(commit_data + g->hash_len + 8) >> 2);
>  }
>=20=20
>  static inline void set_commit_tree(struct commit *c, struct tree *t)
> @@ -754,7 +754,7 @@ static int fill_commit_in_graph(struct repository *r,
>  	date_low =3D get_be32(commit_data + g->hash_len + 12);
>  	item->date =3D (timestamp_t)((date_high << 32) | date_low);
>=20=20
> -	item->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
> +	set_generation(item, get_be32(commit_data + g->hash_len + 8) >> 2);
>=20=20
>  	pptr =3D &item->parents;
>=20=20
> @@ -1048,7 +1048,7 @@ static void write_graph_chunk_data(struct hashfile =
*f, int hash_len,
>  		else
>  			packedDate[0] =3D 0;
>=20=20
> -		packedDate[0] |=3D htonl((*list)->generation << 2);
> +		packedDate[0] |=3D htonl(generation((*list)) << 2);
>=20=20
>  		packedDate[1] =3D htonl((*list)->date);
>  		hashwrite(f, packedDate, 8);
> @@ -1280,8 +1280,8 @@ static void compute_generation_numbers(struct write=
_commit_graph_context *ctx)
>  					ctx->commits.nr);
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>  		display_progress(ctx->progress, i + 1);
> -		if (ctx->commits.list[i]->generation !=3D GENERATION_NUMBER_INFINITY &&
> -		    ctx->commits.list[i]->generation !=3D GENERATION_NUMBER_ZERO)
> +		if (generation(ctx->commits.list[i]) !=3D GENERATION_NUMBER_INFINITY &&
> +		    generation(ctx->commits.list[i]) !=3D GENERATION_NUMBER_ZERO)
>  			continue;
>=20=20
>  		commit_list_insert(ctx->commits.list[i], &list);
> @@ -1292,22 +1292,23 @@ static void compute_generation_numbers(struct wri=
te_commit_graph_context *ctx)
>  			uint32_t max_generation =3D 0;
>=20=20
>  			for (parent =3D current->parents; parent; parent =3D parent->next) {
> -				if (parent->item->generation =3D=3D GENERATION_NUMBER_INFINITY ||
> -				    parent->item->generation =3D=3D GENERATION_NUMBER_ZERO) {
> +				if (generation(parent->item) =3D=3D GENERATION_NUMBER_INFINITY ||
> +				    generation(parent->item) =3D=3D GENERATION_NUMBER_ZERO) {
>  					all_parents_computed =3D 0;
>  					commit_list_insert(parent->item, &list);
>  					break;
> -				} else if (parent->item->generation > max_generation) {
> -					max_generation =3D parent->item->generation;
> +				} else if (generation(parent->item) > max_generation) {
> +					max_generation =3D generation(parent->item);
>  				}
>  			}

Here generation(parent->item) is called three times, which is probably
cost effective to save the value to the local variable (as Stolee
noticed).

>=20=20
>  			if (all_parents_computed) {
> -				current->generation =3D max_generation + 1;
> +				set_generation(current, max_generation + 1);
>  				pop_commit(&list);
>=20=20
> -				if (current->generation > GENERATION_NUMBER_MAX)
> -					current->generation =3D GENERATION_NUMBER_MAX;
> +				if (generation(current) > GENERATION_NUMBER_MAX)
> +					set_generation(current,
> +						       GENERATION_NUMBER_MAX);
>  			}
>  		}
>  	}
> @@ -2314,8 +2315,8 @@ int verify_commit_graph(struct repository *r, struc=
t commit_graph *g, int flags)
>  					     oid_to_hex(&graph_parents->item->object.oid),
>  					     oid_to_hex(&odb_parents->item->object.oid));
>=20=20
> -			if (graph_parents->item->generation > max_generation)
> -				max_generation =3D graph_parents->item->generation;
> +			if (generation(graph_parents->item) > max_generation)
> +				max_generation =3D generation(graph_parents->item);
>=20=20
>  			graph_parents =3D graph_parents->next;
>  			odb_parents =3D odb_parents->next;
> @@ -2325,7 +2326,7 @@ int verify_commit_graph(struct repository *r, struc=
t commit_graph *g, int flags)
>  			graph_report(_("commit-graph parent list for commit %s terminates ear=
ly"),
>  				     oid_to_hex(&cur_oid));
>=20=20
> -		if (!graph_commit->generation) {
> +		if (!generation(graph_commit)) {
>  			if (generation_zero =3D=3D GENERATION_NUMBER_EXISTS)
>  				graph_report(_("commit-graph has generation number zero for commit %=
s, but non-zero elsewhere"),
>  					     oid_to_hex(&cur_oid));
> @@ -2345,10 +2346,10 @@ int verify_commit_graph(struct repository *r, str=
uct commit_graph *g, int flags)
>  		if (max_generation =3D=3D GENERATION_NUMBER_MAX)
>  			max_generation--;
>=20=20
> -		if (graph_commit->generation !=3D max_generation + 1)
> +		if (generation(graph_commit) !=3D max_generation + 1)
>  			graph_report(_("commit-graph generation for commit %s is %u !=3D %u"),
>  				     oid_to_hex(&cur_oid),
> -				     graph_commit->generation,
> +				     generation(graph_commit),
>  				     max_generation + 1);
>=20=20
>  		if (graph_commit->date !=3D odb_commit->date)
> diff --git a/commit-reach.c b/commit-reach.c
> index 4ca7e706a1..77c980054a 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -59,13 +59,13 @@ static struct commit_list *paint_down_to_common(struc=
t repository *r,
>  		struct commit_list *parents;
>  		int flags;
>=20=20
> -		if (min_generation && commit->generation > last_gen)
> +		if (min_generation && generation(commit) > last_gen)
>  			BUG("bad generation skip %8x > %8x at %s",
> -			    commit->generation, last_gen,
> +			    generation(commit), last_gen,
>  			    oid_to_hex(&commit->object.oid));
> -		last_gen =3D commit->generation;
> +		last_gen =3D generation(commit);
>=20=20
> -		if (commit->generation < min_generation)
> +		if (generation(commit) < min_generation)
>  			break;

Here generation(commit) is called three times (two times in the
exceptional case).

>=20=20
>  		flags =3D commit->object.flags & (PARENT1 | PARENT2 | STALE);
> @@ -176,7 +176,7 @@ static int remove_redundant(struct repository *r, str=
uct commit **array, int cnt
>  		repo_parse_commit(r, array[i]);
>  	for (i =3D 0; i < cnt; i++) {
>  		struct commit_list *common;
> -		uint32_t min_generation =3D array[i]->generation;
> +		uint32_t min_generation =3D generation(array[i]);
>=20=20
>  		if (redundant[i])
>  			continue;
> @@ -186,8 +186,8 @@ static int remove_redundant(struct repository *r, str=
uct commit **array, int cnt
>  			filled_index[filled] =3D j;
>  			work[filled++] =3D array[j];
>=20=20
> -			if (array[j]->generation < min_generation)
> -				min_generation =3D array[j]->generation;
> +			if (generation(array[j]) < min_generation)
> +				min_generation =3D generation(array[j]);
>  		}
>  		common =3D paint_down_to_common(r, array[i], filled,
>  					      work, min_generation);
> @@ -323,16 +323,16 @@ int repo_in_merge_bases_many(struct repository *r, =
struct commit *commit,
>  	for (i =3D 0; i < nr_reference; i++) {
>  		if (repo_parse_commit(r, reference[i]))
>  			return ret;
> -		if (reference[i]->generation < min_generation)
> -			min_generation =3D reference[i]->generation;
> +		if (generation(reference[i]) < min_generation)
> +			min_generation =3D generation(reference[i]);
>  	}
>=20=20
> -	if (commit->generation > min_generation)
> +	if (generation(commit) > min_generation)
>  		return ret;
>=20=20
>  	bases =3D paint_down_to_common(r, commit,
>  				     nr_reference, reference,
> -				     commit->generation);
> +				     generation(commit));
>  	if (commit->object.flags & PARENT2)
>  		ret =3D 1;
>  	clear_commit_marks(commit, all_flags);
> @@ -467,7 +467,7 @@ static enum contains_result contains_test(struct comm=
it *candidate,
>  	/* Otherwise, we don't know; prepare to recurse */
>  	parse_commit_or_die(candidate);
>=20=20
> -	if (candidate->generation < cutoff)
> +	if (generation(candidate) < cutoff)
>  		return CONTAINS_NO;
>=20=20
>  	return CONTAINS_UNKNOWN;
> @@ -492,8 +492,8 @@ static enum contains_result contains_tag_algo(struct =
commit *candidate,
>  	for (p =3D want; p; p =3D p->next) {
>  		struct commit *c =3D p->item;
>  		load_commit_graph_info(the_repository, c);
> -		if (c->generation < cutoff)
> -			cutoff =3D c->generation;
> +		if (generation(c) < cutoff)
> +			cutoff =3D generation(c);
>  	}
>=20=20
>  	result =3D contains_test(candidate, want, cache, cutoff);
> @@ -544,9 +544,9 @@ static int compare_commits_by_gen(const void *_a, con=
st void *_b)
>  	const struct commit *a =3D *(const struct commit * const *)_a;
>  	const struct commit *b =3D *(const struct commit * const *)_b;
>=20=20
> -	if (a->generation < b->generation)
> +	if (generation(a) < generation(b))
>  		return -1;
> -	if (a->generation > b->generation)
> +	if (generation(a) > generation(b))
>  		return 1;
>  	return 0;
>  }
> @@ -585,7 +585,7 @@ int can_all_from_reach_with_flag(struct object_array =
*from,
>=20=20
>  		list[nr_commits] =3D (struct commit *)from_one;
>  		if (parse_commit(list[nr_commits]) ||
> -		    list[nr_commits]->generation < min_generation) {
> +		    generation(list[nr_commits]) < min_generation) {
>  			result =3D 0;
>  			goto cleanup;
>  		}
> @@ -621,7 +621,7 @@ int can_all_from_reach_with_flag(struct object_array =
*from,
>=20=20
>  					if (parse_commit(parent->item) ||
>  					    parent->item->date < min_commit_date ||
> -					    parent->item->generation < min_generation)
> +					    generation(parent->item) < min_generation)
>  						continue;
>=20=20
>  					commit_list_insert(parent->item, &stack);
> @@ -665,8 +665,8 @@ int can_all_from_reach(struct commit_list *from, stru=
ct commit_list *to,
>  			if (from_iter->item->date < min_commit_date)
>  				min_commit_date =3D from_iter->item->date;
>=20=20
> -			if (from_iter->item->generation < min_generation)
> -				min_generation =3D from_iter->item->generation;
> +			if (generation(from_iter->item) < min_generation)
> +				min_generation =3D generation(from_iter->item);
>  		}
>=20=20
>  		from_iter =3D from_iter->next;
> @@ -677,8 +677,8 @@ int can_all_from_reach(struct commit_list *from, stru=
ct commit_list *to,
>  			if (to_iter->item->date < min_commit_date)
>  				min_commit_date =3D to_iter->item->date;
>=20=20
> -			if (to_iter->item->generation < min_generation)
> -				min_generation =3D to_iter->item->generation;
> +			if (generation(to_iter->item) < min_generation)
> +				min_generation =3D generation(to_iter->item);
>  		}
>=20=20
>  		to_iter->item->object.flags |=3D PARENT2;
> @@ -721,8 +721,8 @@ struct commit_list *get_reachable_subset(struct commi=
t **from, int nr_from,
>  		struct commit *c =3D *item;
>=20=20
>  		parse_commit(c);
> -		if (c->generation < min_generation)
> -			min_generation =3D c->generation;
> +		if (generation(c) < min_generation)
> +			min_generation =3D generation(c);
>=20=20
>  		if (!(c->object.flags & PARENT1)) {
>  			c->object.flags |=3D PARENT1;
> @@ -755,7 +755,7 @@ struct commit_list *get_reachable_subset(struct commi=
t **from, int nr_from,
>=20=20
>  			parse_commit(p);
>=20=20
> -			if (p->generation < min_generation)
> +			if (generation(p) < min_generation)
>  				continue;
>=20=20
>  			if (p->object.flags & PARENT2)
> diff --git a/commit.c b/commit.c
> index 87686a7055..8dad0f8446 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -731,9 +731,9 @@ int compare_commits_by_gen_then_commit_date(const voi=
d *a_, const void *b_, void
>  	const struct commit *a =3D a_, *b =3D b_;
>=20=20
>  	/* newer commits first */
> -	if (a->generation < b->generation)
> +	if (generation(a) < generation(b))
>  		return 1;
> -	else if (a->generation > b->generation)
> +	else if (generation(a) > generation(b))
>  		return -1;
>=20=20
>  	/* use date as a heuristic when generations are equal */
> diff --git a/revision.c b/revision.c
> index 60cca8c0b9..d76382007c 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -720,7 +720,7 @@ static int check_maybe_different_in_bloom_filter(stru=
ct rev_info *revs,
>  	if (!revs->repo->objects->commit_graph)
>  		return -1;
>=20=20
> -	if (commit->generation =3D=3D GENERATION_NUMBER_INFINITY)
> +	if (generation(commit) =3D=3D GENERATION_NUMBER_INFINITY)
>  		return -1;
>=20=20
>  	filter =3D get_bloom_filter(revs->repo, commit, 0);
> @@ -3314,7 +3314,7 @@ static void explore_to_depth(struct rev_info *revs,
>  	struct topo_walk_info *info =3D revs->topo_walk_info;
>  	struct commit *c;
>  	while ((c =3D prio_queue_peek(&info->explore_queue)) &&
> -	       c->generation >=3D gen_cutoff)
> +	       generation(c) >=3D gen_cutoff)
>  		explore_walk_step(revs);
>  }
>=20=20
> @@ -3330,7 +3330,7 @@ static void indegree_walk_step(struct rev_info *rev=
s)
>  	if (parse_commit_gently(c, 1) < 0)
>  		return;
>=20=20
> -	explore_to_depth(revs, c->generation);
> +	explore_to_depth(revs, generation(c));
>=20=20
>  	for (p =3D c->parents; p; p =3D p->next) {
>  		struct commit *parent =3D p->item;
> @@ -3354,7 +3354,7 @@ static void compute_indegrees_to_depth(struct rev_i=
nfo *revs,
>  	struct topo_walk_info *info =3D revs->topo_walk_info;
>  	struct commit *c;
>  	while ((c =3D prio_queue_peek(&info->indegree_queue)) &&
> -	       c->generation >=3D gen_cutoff)
> +	       generation(c) >=3D gen_cutoff)
>  		indegree_walk_step(revs);
>  }
>=20=20
> @@ -3414,8 +3414,8 @@ static void init_topo_walk(struct rev_info *revs)
>  		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
>  		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
>=20=20
> -		if (c->generation < info->min_generation)
> -			info->min_generation =3D c->generation;
> +		if (generation(c) < info->min_generation)
> +			info->min_generation =3D generation(c);
>=20=20
>  		*(indegree_slab_at(&info->indegree, c)) =3D 1;
>=20=20
> @@ -3473,8 +3473,8 @@ static void expand_topo_walk(struct rev_info *revs,=
 struct commit *commit)
>  		if (parse_commit_gently(parent, 1) < 0)
>  			continue;
>=20=20
> -		if (parent->generation < info->min_generation) {
> -			info->min_generation =3D parent->generation;
> +		if (generation(parent) < info->min_generation) {
> +			info->min_generation =3D generation(parent);
>  			compute_indegrees_to_depth(revs, info->min_generation);
>  		}

Best,
--
Jakub Nar=C4=99bski
