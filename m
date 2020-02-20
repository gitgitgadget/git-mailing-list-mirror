Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3DAC11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0946124673
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+ULatVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBTSse (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:48:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41155 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTSsd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 13:48:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so5317700ljc.8
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 10:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/HKCPnG33wysgVc9Ent3dFfIj+AIAZEEt/Nl/qYv6EI=;
        b=k+ULatVAecs7qZ1H0hT7qDOVa1LVMrm9qrJJp4XKLz/+CObh/2HAyx2waiVM2Yyayz
         8bLg30uh2VeXnvQ3GCqOt4nrYXygKrAVUuYazMmTMQO8bilubnGSZQx6mxq1Ij0PTkFf
         OrFoq2210i7XbcmP1Lq0coF0BnP3UkkqgGOlJoZjmBU5P2vh+qBK+r8BWfbkUOj/XufA
         kYaoePBpoJ9yOXdiarimkacX41Vz4ERmMOslvEHz0rGHKC8iOWrYW39zVj6LMqmiWi+n
         bojRsRgC5ZRdiRpPL3uMeGv0o6MnZPwx30iTpnqCRXiGRwTIwD1EbGq5mOqCpc54QQHB
         8oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=/HKCPnG33wysgVc9Ent3dFfIj+AIAZEEt/Nl/qYv6EI=;
        b=jAUDtlhlddRgjXaIVPAN6QRi1jvOERegk7+O47Z7irQx6zTYObmHIkjgIQvZU+ALdG
         tdHg03xvzHHPsQ7tFej/45pyyLzh0Qqi389O+E66N276gVY5vNu/r/JzXiQXPP1jbbtO
         3VH7AnS/NcAXRR5LPnEtHosj2DLDhWJMd5LWxTgUIEAihaCy74+B+/0IgLcIyFdYF4T5
         HtvZjKdVs2hnr7hKXQp5cu26JzJP9L6XnxLNzG/kIJRxguDlHU3osxC021PI0CiltFEQ
         qkbgOAHNXWwXR+KilawvYJfo0uu+atUSFzdHMCzxlmQrl8Te4qkaOgRAxLr8MLhZyhfa
         rYRQ==
X-Gm-Message-State: APjAAAUM/PwcXZ36bl4RmAtgEkLUKg0SvHCrfQRi1kyfh1FmAMjUW6y6
        HrG4q0N8+xzBrnzt1hmhi4s=
X-Google-Smtp-Source: APXvYqyKlppISyL6Ij3RqyJbXDfPf3mI2LEpRALBxdge50VWN9/ca+Mbzs+1itNf0+hLmHrF177QBQ==
X-Received: by 2002:a2e:868c:: with SMTP id l12mr19763316lji.194.1582224509750;
        Thu, 20 Feb 2020 10:48:29 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id b13sm189345lfi.77.2020.02.20.10.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 10:48:28 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Garima Singh <garimasigit@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 08/11] commit-graph: reuse existing Bloom filters during write.
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <b20c8d2b2096bf10fe1a5f37a5181c57873a9676.1580943390.git.gitgitgadget@gmail.com>
Date:   Thu, 20 Feb 2020 19:48:21 +0100
In-Reply-To: <b20c8d2b2096bf10fe1a5f37a5181c57873a9676.1580943390.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Wed, 05 Feb 2020 22:56:27
        +0000")
Message-ID: <86r1ypf62y.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
>
> Read previously computed Bloom filters from the commit-graph file if
> possible to avoid recomputing during commit-graph write.

All right, what is written makes sense for this point in patch series.

But it my opinion it is more important to state that this commit adds
"parsing" of the Bloom filter data from commit-graph file.  This means
that it needs to be calculated only once, then stored in commit-graph,
ready to be re-used.

>
> See Documentation/technical/commit-graph-format for the format in which
> the Bloom filter information is written to the commit graph file.
>
> To read Bloom filter for a given commit with lexicographic position
> 'i' we need to:
> 1. Read BIDX[i] which essentially gives us the starting index in BDAT for
>    filter of commit i+1. It is essentially the index past the end
>    of the filter of commit i. It is called end_index in the code.
>
> 2. For i>0, read BIDX[i-1] which will give us the starting index in BDAT
>    for filter of commit i. It is called the start_index in the code.
>    For the first commit, where i =3D 0, Bloom filter data starts at the
>    beginning, just past the header in the BDAT chunk. Hence, start_index
>    will be 0.
>
> 3. The length of the filter will be end_index - start_index, because
>    BIDX[i] gives the cumulative 8-byte words including the ith
>    commit's filter.
>
> We toggle whether Bloom filters should be recomputed based on the
> compute_if_null flag.

Nitpick: the flag (the parameter) is called compute_if_not_present, not
compute_if_null.

All right, this explanation is nice and clear.

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  bloom.c               | 49 ++++++++++++++++++++++++++++++++++++++++++-
>  bloom.h               |  4 +++-
>  commit-graph.c        |  7 ++++---
>  t/helper/test-bloom.c |  2 +-
>  4 files changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/bloom.c b/bloom.c
> index 818382c03b..90d84dc713 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -1,5 +1,7 @@
>  #include "git-compat-util.h"
>  #include "bloom.h"
> +#include "commit.h"
> +#include "commit-slab.h"
>  #include "commit-graph.h"
>  #include "object-store.h"
>  #include "diff.h"
> @@ -127,8 +129,39 @@ void add_key_to_filter(struct bloom_key *key,
>  	}
>  }
>=20=20
> +static int load_bloom_filter_from_graph(struct commit_graph *g,
> +				   struct bloom_filter *filter,
> +				   struct commit *c)
> +{
> +	uint32_t lex_pos, start_index, end_index;
> +
> +	while (c->graph_pos < g->num_commits_in_base)
> +		g =3D g->base_graph;
> +
> +	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
> +	if (!g->chunk_bloom_indexes)
> +		return 0;
> +
> +	lex_pos =3D c->graph_pos - g->num_commits_in_base;

All right, this finds lexicographical position of the commit following
the chain of incremental commit-graph files, and also check if the
commit-graph fragment that contains the commit in question has Bloom
filter data included.

> +
> +	end_index =3D get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
> +
> +	if (lex_pos)

Wouldn't it be better to be more explicit, and write

  +	if (lex_pos > 0)


> +		start_index =3D get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
> +	else
> +		start_index =3D 0;

All right, here we find start_index and end_index.

It might be good idea to at least assert() that start_index <=3D end_index,
though that should not happen (that is why I propose for this check to
be compiled on only for debug builds).

> +
> +	filter->len =3D end_index - start_index;
> +	filter->data =3D (uint64_t *)(g->chunk_bloom_data +
> +					sizeof(uint64_t) * start_index +
> +					BLOOMDATA_CHUNK_HEADER_SIZE);

All right, nice use of constant.

> +
> +	return 1;
> +}
> +
>  struct bloom_filter *get_bloom_filter(struct repository *r,
> -				      struct commit *c)
> +				      struct commit *c,
> +				      int compute_if_not_present)
>  {
>  	struct bloom_filter *filter;
>  	struct bloom_filter_settings settings =3D DEFAULT_BLOOM_FILTER_SETTINGS;
> @@ -141,6 +174,20 @@ struct bloom_filter *get_bloom_filter(struct reposit=
ory *r,
>=20=20
>  	filter =3D bloom_filter_slab_at(&bloom_filters, c);
>=20=20
> +	if (!filter->data) {
> +		load_commit_graph_info(r, c);
> +		if (c->graph_pos !=3D COMMIT_NOT_FROM_GRAPH &&
> +			r->objects->commit_graph->chunk_bloom_indexes) {

All right, the limitation that the top layer of incremental commit graph
needs to have Bloom filters enabled for it to be even considered is
reasonable tradeoff, in my opinion.

> +			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
> +				return filter;
> +			else
> +				return NULL;

If it should have filter, return it, otherwise return NULL.

I wonder however when it can return NULL (and whether it should compute
Bloom filters if required instead).

> +		}
> +	}
> +
> +	if (filter->data || !compute_if_not_present)
> +		return filter;

If we have filter from slab, return it.  All right.

However, according to documentation contained in comments in
commit-slab.h, bloom_filter_slab_at() will allocate the location to
store the data, and return freshly allocated memory... fortunately it
uses xcalloc() so returned bloom_filter would have ->len =3D=3D 0 and
->data =3D=3D 0.

> +
>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive =3D 1;
>  	diffopt.max_changes =3D max_changes;
> diff --git a/bloom.h b/bloom.h
> index 7f40c751f7..76f8a9ad0c 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -13,6 +13,7 @@ struct bloom_filter_settings {
>=20=20
>  #define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
>  #define BITS_PER_WORD 64
> +#define BLOOMDATA_CHUNK_HEADER_SIZE 3*sizeof(uint32_t)

All right.

>=20=20
>  /*
>   * A bloom_filter struct represents a data segment to
> @@ -47,7 +48,8 @@ void add_key_to_filter(struct bloom_key *key,
>  					   struct bloom_filter_settings *settings);
>=20=20
>  struct bloom_filter *get_bloom_filter(struct repository *r,
> -				      struct commit *c);
> +				      struct commit *c,
> +				      int compute_if_not_present);
>

All right, adding new parameter (changing function signature).

>  int bloom_filter_contains(struct bloom_filter *filter,
>  			  struct bloom_key *key,
> diff --git a/commit-graph.c b/commit-graph.c
> index 4585b3b702..c0e9834bf2 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1094,7 +1094,7 @@ static void write_graph_chunk_bloom_indexes(struct =
hashfile *f,
>  			ctx->commits.nr);
>=20=20
>  	while (list < last) {
> -		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list);
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list, 0);
>  		cur_pos +=3D filter->len;
>  		display_progress(progress, ++i);
>  		hashwrite_be32(f, cur_pos);
> @@ -1123,7 +1123,7 @@ static void write_graph_chunk_bloom_data(struct has=
hfile *f,
>  	hashwrite_be32(f, settings->bits_per_entry);
>=20=20
>  	while (list < last) {
> -		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list);
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list, 0);
>  		display_progress(progress, ++i);
>  		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
>  		list++;

All right, if needed (that is, if '--changed-path' option from the
future commit is provided to 'git commit-graph write'),
compute_bloom_filters() would be called befor write_commit_graph_file(),
which in turn runs write_graph_chunk_bloom_index() and *_data().


Actually, when writing Bloom data chunks (BIDX and BDAT) we could have
requested recomputing filters if necessary: slab storage works as
memoization, so you would calculate Bloom filter data for each commit in
the commit-graph only once.  And write_graph_chunk_bloom_indexes()
and write_graph_chunk_bloom_data() are called only if ctx->changed_paths
is true.

So it would work with

  +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list, 1);

Only in the future we would really need to call with compute_if_not_present
parameter set to falsy value.

> @@ -1304,7 +1304,7 @@ static void compute_bloom_filters(struct write_comm=
it_graph_context *ctx)
>=20=20
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>  		struct commit *c =3D sorted_by_pos[i];
> -		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, c);
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, c, 1);
>  		ctx->total_bloom_filter_data_size +=3D sizeof(uint64_t) * filter->len;
>  		display_progress(progress, i + 1);
>  	}
> @@ -2314,6 +2314,7 @@ void free_commit_graph(struct commit_graph *g)
>  		g->data =3D NULL;
>  		close(g->graph_fd);
>  	}
> +	free(g->bloom_filter_settings);
>  	free(g->filename);
>  	free(g);

Shouldn't this fixup be added to earlier commit?

>  }
> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> index 331957011b..9b4be97f75 100644
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -47,7 +47,7 @@ static void get_bloom_filter_for_commit(const struct ob=
ject_id *commit_oid)
>  	struct bloom_filter *filter;
>  	setup_git_directory();
>  	c =3D lookup_commit(the_repository, commit_oid);
> -	filter =3D get_bloom_filter(the_repository, c);
> +	filter =3D get_bloom_filter(the_repository, c, 1);
>  	print_bloom_filter(filter);
>  }

I would like to see some tests, but that needs to wait for patch that
adds --changed-paths option to the 'write' subcommand.

Things to be tested:
1. That after reading commit-graph with Bloom filter:
   - that commit(s) in commit-graph have Bloom filter
   - that commits outside commit-graph do not have Bloom filter
2. That incremental commit-graph feature works:
   - for commits in deeper layer that have Bloom filter chunks
   - for commits in deeper layer that do not have Bloom filter chunks

Best,
--=20
Jakub Nar=C4=99bski
