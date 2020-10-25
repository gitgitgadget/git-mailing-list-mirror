Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93F2C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668A720691
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfyyvT8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419176AbgJYWRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419171AbgJYWRV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:17:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51895C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:17:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m20so7723633ljj.5
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=orlzrYsipwztdnY1PBX5G5NQHelNYf9ArXGmjlPN6+U=;
        b=qfyyvT8nWSh/iA8l2mUX8sURI5Ydvc5mQQvK4sXg/PYPWNsBYKe2hlZd7WFFEsv1ua
         xKw4DXJo4oxlA2ijGebj1XwqKhKEKv5ltwj9FIuR+EbFWQfTTy56U1z6NhqtAKeHl84F
         QB5R/LA+KExW6TL4sTvZg6edVx8JLo6h3/wxb7yhgeY6SrYTxKYVvrniCk8NASMBqO94
         0a+KPr1glkJyg9d8L3dmG5HfaR8paSw/ZKWPZBWO7Vy/+DXZ+pozwtJsfKhAZoCiZb9O
         F4S72THUNHSySD81+DpEWG1Mn0qDj3SbV2X+xC79B70p+Xgxvmk9OQV1DHDX7Y4BqJoj
         M7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=orlzrYsipwztdnY1PBX5G5NQHelNYf9ArXGmjlPN6+U=;
        b=YIP4QdKpGKMsVTn2LjLm1fOY33Z3976VI46SyomWoAbQT6PYfV4sJCquCbo5d66hQA
         O/Dz7g2KoTJujkor0LERlHnK24Tq9adjUEUlrfoxIYqDDnsEiBfpgAbU/7jc9rohT7iK
         PxXk00h6s3KmF+LJraD6vDrWlDa1MSYvXYHVKG4kVavUGmvILbz2FDoWxsRXDme3I+h/
         Y4vpyRy7ANRNjoled+/Dd5+LcugZXcGi0jwMjXffz2V4oDGBrv64EulktbJEsjFS+BcX
         ovp128vFPz9PFgvF8u8iSGIRCnrnGaNaLoLDtzD5C7fMdI4Mw+JO/PA6TvpaKp4bdzrL
         mo0A==
X-Gm-Message-State: AOAM533V51hTX0Oy5GvZbGpFA/VrtVq4rzpXnusx7ld8GEIdnlttotcQ
        CJPKZ28PwknFLI/mjgvBe1I=
X-Google-Smtp-Source: ABdhPJwQJC1VU7ZYr8kLxD4MHqamlyxMGzDfiSNlhIytEiqF+dCeyubbbMjKKQiBBGZXlXjLnTpixQ==
X-Received: by 2002:a05:651c:1181:: with SMTP id w1mr4280514ljo.327.1603664239649;
        Sun, 25 Oct 2020 15:17:19 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id k21sm939926ljb.43.2020.10.25.15.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:18 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 05/10] commit-graph: add a slab to store topological levels
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <e067f653ad5d474eee5f40c13bb02fde26ebdb9b.1602079786.git.gitgitgadget@gmail.com>
Date:   Sun, 25 Oct 2020 23:17:17 +0100
In-Reply-To: <e067f653ad5d474eee5f40c13bb02fde26ebdb9b.1602079786.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:40
        +0000")
Message-ID: <85tuui0x3m.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> In a later commit we will introduce corrected commit date as the
> generation number v2. This value will be stored in the new seperate
> Generation Data chunk. However, to ensure backwards compatibility with
> "Old" Git we need to continue to write generation number v1, which is
> topological level, to the commit data chunk. This means that we need to
> compute both versions of generation numbers when writing the
> commit-graph file. Therefore, let's introduce a commit-slab to store
> topological levels; corrected commit date will be stored in the member
> `generation` of struct commit_graph_data.
>
> When Git creates a split commit-graph, it takes advantage of the
> generation values that have been computed already and present in
> existing commit-graph files.
>
> So, let's add a pointer to struct commit_graph as well as struct
> write_commit_graph_context to the topological level commit-slab
> and populate it with topological levels while writing a commit-graph
> file.

I think you meant here "add a pointer in `struct commit_graph` as well
as in `struct write_commit_graph_context`...".

Perhaps we should add the information that it is done that way to be
able to allocate topo_level_slab only when needed, in the
write_commit_graph(), and adding new member to those struct is required
to pass it through the call chain (modifying `struct commit_graph` is
needed for fill_commit_graph_info()).  But that might be too much detail
to put in the commit message.

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 47 ++++++++++++++++++++++++++++++++---------------
>  commit-graph.h |  1 +
>  2 files changed, 33 insertions(+), 15 deletions(-)
>

Let me reorder those files for easier review.

> diff --git a/commit-graph.h b/commit-graph.h
> index 8be247fa35..2e9aa7824e 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -73,6 +73,7 @@ struct commit_graph {
>  	const unsigned char *chunk_bloom_indexes;
>  	const unsigned char *chunk_bloom_data;
>=20=20
> +	struct topo_level_slab *topo_levels;
>  	struct bloom_filter_settings *bloom_filter_settings;
>  };

All right, here we add new member to `struct commit_graph` type.

> diff --git a/commit-graph.c b/commit-graph.c
> index bfc532de6f..cedd311024 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -962,6 +967,7 @@ struct write_commit_graph_context {
>  		 changed_paths:1,
>  		 order_by_pack:1;
>=20=20
> +	struct topo_level_slab *topo_levels;
>  	const struct commit_graph_opts *opts;
>  	size_t total_bloom_filter_data_size;
>  	const struct bloom_filter_settings *bloom_settings;

All right, here we add new member to `struct write_commit_graph_context`
type, which is local to commit-graph.c.

> @@ -64,6 +64,8 @@ void git_test_write_commit_graph_or_die(void)
>  /* Remember to update object flag allocation in object.h */
>  #define REACHABLE       (1u<<15)
>=20=20
> +define_commit_slab(topo_level_slab, uint32_t);
> +

All right, here we define new slab for storing topological levels; this
just defines new type. Note that we do not define any setters and
getters to handle non-zero initialization, like we have for
commit_graph_data_slab.

>  /* Keep track of the order in which commits are added to our list. */
>  define_commit_slab(commit_pos, int);
>  static struct commit_pos commit_pos =3D COMMIT_SLAB_INIT(1, commit_pos);
> @@ -768,6 +770,9 @@ static void fill_commit_graph_info(struct commit *ite=
m, struct commit_graph *g,
>  	item->date =3D (timestamp_t)((date_high << 32) | date_low);
>=20=20
>  	graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
> +
> +	if (g->topo_levels)
> +		*topo_level_slab_at(g->topo_levels, item) =3D get_be32(commit_data + g=
->hash_len + 8) >> 2;

I guess using get_be32() is repeated in this newly added part of code
because previous part would be changed to read in generation number v2,
if available, and we won't be then able to use

		*topo_level_slab_at(g->topo_levels, item) =3D graph_data->generation;

All right, that's smart.


I guess that in fill_commit_graph_info() we don't know if we are reading
commit-graph, when topo levels slab is not present, or whether we are
extending and writing the commit-graph file, when we need to fill it
with current commit-graph data.

The fact that fill_commit_graph_info() takes 'struct commit_graph' also
explains why we need to add pointer to a topo_levels slab to both
structs.

>  }
>=20=20
>  static inline void set_commit_tree(struct commit *c, struct tree *t)
[...]
> @@ -2142,6 +2146,7 @@ int write_commit_graph(struct object_directory *odb,
>  	int res =3D 0;
>  	int replace =3D 0;
>  	struct bloom_filter_settings bloom_settings =3D DEFAULT_BLOOM_FILTER_SE=
TTINGS;
> +	struct topo_level_slab topo_levels;
>=20=20
>  	if (!commit_graph_compatible(the_repository))
>  		return 0;
> @@ -2163,6 +2168,18 @@ int write_commit_graph(struct object_directory *od=
b,
>  							 bloom_settings.max_changed_paths);
>  	ctx->bloom_settings =3D &bloom_settings;
>=20=20
> +	init_topo_level_slab(&topo_levels);
> +	ctx->topo_levels =3D &topo_levels;
> +
> +	if (ctx->r->objects->commit_graph) {
> +		struct commit_graph *g =3D ctx->r->objects->commit_graph;
> +
> +		while (g) {
> +			g->topo_levels =3D &topo_levels;
> +			g =3D g->base_graph;
> +		}
> +	}
> +
>  	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
>  		ctx->changed_paths =3D 1;
>  	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {

All right, we need topo_level_slab only for writing the commit-graph, so
we allocate it with init_*_slab() in write_commit_graph(), and set
pointers to it in `struct write_commit_graph_context *ctx` and in
`struct commit_graph` for each layer in the commit graph.  This is
needed to pass it down the call-chain.

Looks good to me.

> @@ -1108,7 +1114,7 @@ static int write_graph_chunk_data(struct hashfile *=
f,
>  		else
>  			packedDate[0] =3D 0;
>=20=20
> -		packedDate[0] |=3D htonl(commit_graph_data_at(*list)->generation << 2);
> +		packedDate[0] |=3D htonl(*topo_level_slab_at(ctx->topo_levels, *list) =
<< 2);
>

All right, write_graph_chunk_data() is called from write_commit_graph(),
so we know that cxt->topo_levels is not NULL.

>  		packedDate[1] =3D htonl((*list)->date);
>  		hashwrite(f, packedDate, 8);
> @@ -1350,11 +1356,11 @@ static void compute_generation_numbers(struct wri=
te_commit_graph_context *ctx)
>  					_("Computing commit graph generation numbers"),
>  					ctx->commits.nr);
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
> -		timestamp_t generation =3D commit_graph_data_at(ctx->commits.list[i])-=
>generation;
> +		timestamp_t level =3D *topo_level_slab_at(ctx->topo_levels, ctx->commi=
ts.list[i]);
>

All right, we know that compute_generation_numbers() is called by the
write_commit_graph(), so we know that cxt->topo_levels is not NULL.

Also, we rename 'generation' to 'level' in preparation for the time when
we would be computing *both* topological level (for backward
compatibility) and corrected committer date (to be used as generation
number v2).  All right.

>  		display_progress(ctx->progress, i + 1);
> -		if (generation !=3D GENERATION_NUMBER_INFINITY &&
> -		    generation !=3D GENERATION_NUMBER_ZERO)
> +		if (level !=3D GENERATION_NUMBER_INFINITY &&
> +		    level !=3D GENERATION_NUMBER_ZERO)
>  			continue;

Same here, the results of renaming of 'generation' local variable to
'level'.

>=20=20
>  		commit_list_insert(ctx->commits.list[i], &list);
> @@ -1362,29 +1368,27 @@ static void compute_generation_numbers(struct wri=
te_commit_graph_context *ctx)
>  			struct commit *current =3D list->item;
>  			struct commit_list *parent;
>  			int all_parents_computed =3D 1;
> -			uint32_t max_generation =3D 0;
> +			uint32_t max_level =3D 0;

Similarly, we rename 'max_generation' to 'max_level'.

>=20=20
>  			for (parent =3D current->parents; parent; parent =3D parent->next) {
> -				generation =3D commit_graph_data_at(parent->item)->generation;
> +				level =3D *topo_level_slab_at(ctx->topo_levels, parent->item);
>=20=20
> -				if (generation =3D=3D GENERATION_NUMBER_INFINITY ||
> -				    generation =3D=3D GENERATION_NUMBER_ZERO) {
> +				if (level =3D=3D GENERATION_NUMBER_INFINITY ||
> +				    level =3D=3D GENERATION_NUMBER_ZERO) {
>  					all_parents_computed =3D 0;
>  					commit_list_insert(parent->item, &list);
>  					break;
> -				} else if (generation > max_generation) {
> -					max_generation =3D generation;
> +				} else if (level > max_level) {
> +					max_level =3D level;
>  				}
>  			}

Continuation of those renames.

>=20=20
>  			if (all_parents_computed) {
> -				struct commit_graph_data *data =3D commit_graph_data_at(current);
> -
> -				data->generation =3D max_generation + 1;
>  				pop_commit(&list);
>=20=20
> -				if (data->generation > GENERATION_NUMBER_V1_MAX)
> -					data->generation =3D GENERATION_NUMBER_V1_MAX;
> +				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
> +					max_level =3D GENERATION_NUMBER_V1_MAX - 1;
> +				*topo_level_slab_at(ctx->topo_levels, current) =3D max_level + 1;

This is a bit safer way to handle possible overflow: instead of

  final =3D max_found + 1;            /* set to maximum plus 1 */
  if (final > MAX_POSSIBLE_VALUE)   /* handle overflow */
      final =3D MAX_POSSIBLE_VALUE;

where we can have problems if MAX_POSSIBLE_VALUE overflows, we use the
following pattern:

  if (max_found > MAX_POSSIBLE_VALUE - 1)  /* handle overflow */
      max_found > MAX_POSSIBLE_VALUE - 1;
  final =3D max_found + 1;                   /* set to maximum plus 1 */

It is just a bit obscured by renaming variable and switch to using
commit slab.

It is not that important for topological level, where
GENERATION_NUMBER_V1_MAX is smaller than maximum possible value, but it
would be important for generation number v2.

>  			}
>  		}
>  	}

Best,
--
Jakub Nar=C4=99bski
