Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3AEC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1952080A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufKzSwii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgAGQB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:01:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39687 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgAGQB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 11:01:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id l2so116195lja.6
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rjm0bMb7tW2/NI7zkiShSK0fJtyaC3SvBzu8PSDoJaQ=;
        b=ufKzSwiiHVJkLYaJG2s/tPr2tm03oJyclW3pFfWoE2lcH43nLzcnOrMNWJBOvOmKVu
         Zbwj+JvT3dyEqOtBzaY05Viqg6Wd90HLE/GlhOH8Gdxa9WH5oCFiEQl/rHheK+5+Ocrm
         GI/0VQl+Y52Ce1VYQVnsaM+ZbtSR9rjl/I0Y/3s3ZZppQmTFyTODfzdiyXbE+3bXYe9D
         tRrvHBuxenzOJeHGG0hGNYItiZCtYuVlpwcRxEY7Ywrwdkrxd5n9AF/ArTyKGhe07+oN
         rDDIuQ0gGsymuBUuV2wS+fcD2yRoD1HEJvzAkeO9Uz8/2nFIBpFdNW7Acyc/RSlJbgU4
         PG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=rjm0bMb7tW2/NI7zkiShSK0fJtyaC3SvBzu8PSDoJaQ=;
        b=F067tPNZJTKt0irtlIt+KeGLfy2wwKe9hUu62h7pKHh4J+sGzN3oNkAZV0bvI9HgwV
         S5BbEEpGAhBFQlQvQ2OZEdvI0U2OHNuhSR8A0Og5f7TX+MBIAZC/v8RgtgL+IzSb3PFB
         /D+3y/GnHMvqOCIQmu8+h7LeizhbUv3NzcIoyVKe9vN9furlkKW67qlGDvPPf18bfzNU
         +wFs/qSuY9gAUJ0JTLQ/503+swDjLjXY0mMnS+EsL5ZCEDMK3NsJKxtDpqrfNMI4FIG6
         OBurDquvjAXpu1ATp6yV8gtHj972HOmNRso5JZr+JW02Ysba5ILKyA9Vs/oqZls2mx6B
         cZdQ==
X-Gm-Message-State: APjAAAXozj/+8DmoHyNjodEU782l7wbhXAvgzdR2jxgUXah6bHecsFAT
        CIraqHJrjD/o4g3Kpk/ri6s=
X-Google-Smtp-Source: APXvYqzQANk+kgbpLp5nypE0XJpLTJEDnc5ZPlDkh+dvLo74PkJZzWPFadAwQ/uxDrRsfrUKJuSqMw==
X-Received: by 2002:a2e:800b:: with SMTP id j11mr127966ljg.126.1578412914449;
        Tue, 07 Jan 2020 08:01:54 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 ([158.75.2.110])
        by smtp.gmail.com with ESMTPSA id w1sm44355lfe.96.2020.01.07.08.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 08:01:53 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 5/9] commit-graph: write changed path bloom filters to commit-graph file.
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <7648021072ca11153ac65c90f0ebed5973f20e1a.1576879520.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 17:01:50 +0100
In-Reply-To: <7648021072ca11153ac65c90f0ebed5973f20e1a.1576879520.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Fri, 20 Dec 2019 22:05:16
        +0000")
Message-ID: <867e23xnkh.fsf@gmail.com>
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
> Write bloom filters to the commit-graph using the format described in
> Documentation/technical/commit-graph-format.txt
>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>

Looks good to me.

> ---
>  commit-graph.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  commit-graph.h |  5 ++++
>  2 files changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 8c4941eeaa..def2ade166 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -24,7 +24,9 @@
>  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
>  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
>  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
> -#define MAX_NUM_CHUNKS 5
> +#define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
> +#define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
> +#define MAX_NUM_CHUNKS 7

Very minor nitpick: shouldn't we follow the order in the
commit-graph-format.txt document (i.e. "BASE" as last chunk and last
preprocessor constant)?

>=20=20
>  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
>=20=20
> @@ -282,6 +284,32 @@ struct commit_graph *parse_commit_graph(void *graph_=
map, int fd,
>  				chunk_repeated =3D 1;
>  			else
>  				graph->chunk_base_graphs =3D data + chunk_offset;
> +			break;
> +
> +		case GRAPH_CHUNKID_BLOOMINDEXES:
> +			if (graph->chunk_bloom_indexes)
> +				chunk_repeated =3D 1;
> +			else
> +				graph->chunk_bloom_indexes =3D data + chunk_offset;
> +			break;

All right.

> +
> +		case GRAPH_CHUNKID_BLOOMDATA:
> +			if (graph->chunk_bloom_data)
> +				chunk_repeated =3D 1;
> +			else {
> +				uint32_t hash_version;
> +				graph->chunk_bloom_data =3D data + chunk_offset;
> +				hash_version =3D get_be32(data + chunk_offset);

All right, now I see why all those header values for BDAT chunk are
defined to be 32-bit integers.  For code simplicity.

> +
> +				if (hash_version !=3D 1)
> +					break;

What does it mean for Git?  Behave as if there were no Bloom filter
data?

> +
> +				graph->settings =3D xmalloc(sizeof(struct bloom_filter_settings));
> +				graph->settings->hash_version =3D hash_version;
> +				graph->settings->num_hashes =3D get_be32(data + chunk_offset + 4);
> +				graph->settings->bits_per_entry =3D get_be32(data + chunk_offset + 8=
);

All right, looks O.K.

> +			}
> +			break;
>  		}
>=20=20
>  		if (chunk_repeated) {
> @@ -996,6 +1024,39 @@ static void write_graph_chunk_extra_edges(struct ha=
shfile *f,
>  	}
>  }
>=20=20
> +static void write_graph_chunk_bloom_indexes(struct hashfile *f,
> +					    struct write_commit_graph_context *ctx)
> +{
> +	struct commit **list =3D ctx->commits.list;
> +	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> +	uint32_t cur_pos =3D 0;
> +
> +	while (list < last) {
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list);
> +		cur_pos +=3D filter->len;
> +		hashwrite_be32(f, cur_pos);
> +		list++;
> +	}

Why not follow the write_graph_chunk_oids() example, instead of
write_graph_chunk_data(), that is use simply:

  +	struct commit **list =3D ctx->commits.list;
  +	uint32_t cur_pos =3D 0;
  +
  +	for (count =3D 0; count < ctx->commits.nr; count++, list++) {
  +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list);
  +		cur_pos +=3D filter->len;
  +		hashwrite_be32(f, cur_pos);
  +	}

I guess using here

  +		cur_pos +=3D get_bloom_filter(ctx->r, *list)->len;

would be too cryptic, and hard to debug?

Also, wouldn't we need

  +		display_progress(ctx->progress, ++ctx->progress_cnt);

before hashwrite_be32()?

> +}
> +
> +static void write_graph_chunk_bloom_data(struct hashfile *f,
> +					 struct write_commit_graph_context *ctx,
> +					 struct bloom_filter_settings *settings)
> +{
> +	struct commit **first =3D ctx->commits.list;

Even if we decide to use `while` loop, like write_graph_chunk_data(),
and not `for` loop, like write_graph_chunk_oids(), why the change from
`struct commit **list =3D ...` to `struct commit **first =3D ...`?

> +	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> +
> +	hashwrite_be32(f, settings->hash_version);
> +	hashwrite_be32(f, settings->num_hashes);
> +	hashwrite_be32(f, settings->bits_per_entry);

All right, simple.

> +
> +	while (first < last) {
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *first);

Hmmm... wouldn't this compute Bloom filter second time?
get_bloom_filter() does work unconditionally.

Wouldn't

  +		struct bloom_filter *filter =3D bloom_filter_slab_at(&bloom_filters, *=
first);

be enough?

Or make get_bloom_filter() use *_peek() to check if Bloom filter for
given commit was already computed, and only if it returns NULL do the
work.

> +		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));

Might need display_progress() before hashwrote().

> +		first++;
> +	}
> +}
> +
>  static int oid_compare(const void *_a, const void *_b)
>  {
>  	const struct object_id *a =3D (const struct object_id *)_a;
> @@ -1388,6 +1449,7 @@ static int write_commit_graph_file(struct write_com=
mit_graph_context *ctx)
>  	struct strbuf progress_title =3D STRBUF_INIT;
>  	int num_chunks =3D 3;
>  	struct object_id file_hash;
> +	struct bloom_filter_settings bloom_settings =3D DEFAULT_BLOOM_FILTER_SE=
TTINGS;
>=20=20
>  	if (ctx->split) {
>  		struct strbuf tmp_file =3D STRBUF_INIT;
> @@ -1432,6 +1494,12 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>  		chunk_ids[num_chunks] =3D GRAPH_CHUNKID_EXTRAEDGES;
>  		num_chunks++;
>  	}
> +	if (ctx->bloom) {
> +		chunk_ids[num_chunks] =3D GRAPH_CHUNKID_BLOOMINDEXES;
> +		num_chunks++;
> +		chunk_ids[num_chunks] =3D GRAPH_CHUNKID_BLOOMDATA;
> +		num_chunks++;
> +	}

Looks all right.

>  	if (ctx->num_commit_graphs_after > 1) {
>  		chunk_ids[num_chunks] =3D GRAPH_CHUNKID_BASE;
>  		num_chunks++;
> @@ -1450,6 +1518,13 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>  						4 * ctx->num_extra_edges;
>  		num_chunks++;
>  	}
> +	if (ctx->bloom) {
> +		chunk_offsets[num_chunks + 1] =3D chunk_offsets[num_chunks] + sizeof(u=
int32_t) * ctx->commits.nr;
> +		num_chunks++;
> +
> +		chunk_offsets[num_chunks + 1] =3D chunk_offsets[num_chunks] + sizeof(u=
int32_t) * 3 + ctx->total_bloom_filter_size;
> +		num_chunks++;
> +	}

Better wrap those long lines, like above:

  +	if (ctx->bloom) {
  +		chunk_offsets[num_chunks + 1] =3D chunk_offsets[num_chunks] +
  +						sizeof(uint32_t) * ctx->commits.nr;
  +		num_chunks++;
  +
  +		chunk_offsets[num_chunks + 1] =3D chunk_offsets[num_chunks] +
  +						sizeof(uint32_t) * 3 + ctx->total_bloom_filter_size;
  +		num_chunks++;
  +	}

>  	if (ctx->num_commit_graphs_after > 1) {
>  		chunk_offsets[num_chunks + 1] =3D chunk_offsets[num_chunks] +
>  						hashsz * (ctx->num_commit_graphs_after - 1);
> @@ -1487,6 +1562,10 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>  	write_graph_chunk_data(f, hashsz, ctx);
>  	if (ctx->num_extra_edges)
>  		write_graph_chunk_extra_edges(f, ctx);
> +	if (ctx->bloom) {
> +		write_graph_chunk_bloom_indexes(f, ctx);
> +		write_graph_chunk_bloom_data(f, ctx, &bloom_settings);
> +	}

All right.

>  	if (ctx->num_commit_graphs_after > 1 &&
>  	    write_graph_chunk_base(f, ctx)) {
>  		return -1;
> diff --git a/commit-graph.h b/commit-graph.h
> index 952a4b83be..2202ad91ae 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -10,6 +10,7 @@
>  #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_=
LOAD"
>=20=20
>  struct commit;
> +struct bloom_filter_settings;
>=20=20
>  char *get_commit_graph_filename(const char *obj_dir);
>  int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
> @@ -58,6 +59,10 @@ struct commit_graph {
>  	const unsigned char *chunk_commit_data;
>  	const unsigned char *chunk_extra_edges;
>  	const unsigned char *chunk_base_graphs;
> +	const unsigned char *chunk_bloom_indexes;
> +	const unsigned char *chunk_bloom_data;
> +
> +	struct bloom_filter_settings *settings;

Should this be part of `struct commit_graph`?  Shouldn't we free() this
data, or is it a pointer into xmmap-ped file... no it isn't -- we
xalloc() it, so we should free() it.

I think it should be done in 'cleanup:' section of write_commit_graph(),
but I am not entirely sure.

>  };
>=20=20
>  struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st=
);

Best,
--=20
Jakub Nar=C4=99bski
