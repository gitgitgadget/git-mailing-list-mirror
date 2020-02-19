Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC06C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 15:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ADF24670
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 15:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVCQdpDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgBSPNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:13:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40808 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSPNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 10:13:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18so735702ljo.7
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 07:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sQBUxnv/D1j1836IyumN6LF3VZbFnDOw6Uo+7top7Q4=;
        b=hVCQdpDRH0cwCcPLhmJ/xV7YB1BAReGdnfE588to12F05MIdnQ4oVyDYP5rGu+mI5w
         G+fcPyzusiMd5hFstXTyvaT17b+88LZ7+stdahbm7S2c6JyaRJYl/C8aJHyjGzCrK7ug
         w9bJxYvKF1Atef9hn73YeVeg//gIWkL6qHla/iWxdumDXWrYY0HLNWEVZ1aII4bm1Men
         QT3D5+XqYVlYuwqa4mZ/r8OsbFNdZhCi5j0cpF0Mr6VAY2nNVeuldeO5gUrTjKRS7AUt
         0to039jFrH4D9+q39MSjrsrcACWINQZXy774euaS5DeeoVIIkN38aP4NzrN8bGzhDlPK
         b16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=sQBUxnv/D1j1836IyumN6LF3VZbFnDOw6Uo+7top7Q4=;
        b=b4p9vAMWcQ/1wykc0APBK9ib2EpHYMne//9Exk29rWGNzgd9fXch9+NntgJ0ku0YOF
         xUgKvFj4LBWIeIvw1LAnzTqfxibq4BrAuBg0wTWpvBA+6lqdml4dT1X11f3PMBLIq2Ms
         lh1FHYEghiL3GIEzmYCik7zoe3sonCxI2XKKqmutALyTeOTarFoqPlTHksQOQXhvFVnY
         vU22zhBK53jJYvaublHlhPWHNuWbMST7q/mMPSH6fJKi2Xgey8BA1b2iwuA3NWt6MbR5
         qtgdphBesUPMww06aVg+rHCJV6EoPeWKjUjnlXdfKFjr0Vcfc7ik4oWQZSCkFTHd/8ea
         MH+w==
X-Gm-Message-State: APjAAAV+DshPf5qTikW9NWKFh4OsBL/gMGgovaun1x8iW3ZPC86F01T1
        QbBtIGErzcJh5vLAfp9QaFim1u51o5gtVw==
X-Google-Smtp-Source: APXvYqyZMeuPKgb9GM4lsCD+emQ123NTeUTL2tcs07mYPdzxqZfjoUv4J2ZraKsBv1SWmY3stx6oUA==
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr15487638ljj.148.1582125229813;
        Wed, 19 Feb 2020 07:13:49 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id d20sm1381606ljg.95.2020.02.19.07.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 07:13:48 -0800 (PST)
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
Subject: Re: [PATCH v2 07/11] commit-graph: write Bloom filters to commit graph file
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <39ee0610800d7d2d92785d392df941fc5a0b231b.1580943390.git.gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 16:13:42 +0100
In-Reply-To: <39ee0610800d7d2d92785d392df941fc5a0b231b.1580943390.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Wed, 05 Feb 2020 22:56:26
        +0000")
Message-ID: <86pneahaop.fsf@gmail.com>
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
> Update the technical documentation for commit-graph-format with the forma=
ts for
> the Bloom filter index (BIDX) and Bloom filter data (BDAT) chunks. Write =
the
> computed Bloom filters information to the commit graph file using this fo=
rmat.

Nice description.

The only minor nitpick is with the formating: it is 80-character wide,
which is a bit wide.

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  .../technical/commit-graph-format.txt         |  24 ++++
>  commit-graph.c                                | 118 +++++++++++++++++-
>  commit-graph.h                                |   7 +-
>  3 files changed, 145 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentat=
ion/technical/commit-graph-format.txt
> index a4f17441ae..22e511643d 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -17,6 +17,9 @@ metadata, including:
>  - The parents of the commit, stored using positional references within
>    the graph file.
>=20=20
> +- The Bloom filter of the commit carrying the paths that were changed be=
tween
> +  the commit and its first parent.
> +

All right.

Should we also state that it is optional (meta)data?  This would be
first optional piece of data stored in commit-graph, I think.

>  These positional references are stored as unsigned 32-bit integers
>  corresponding to the array position within the list of commit OIDs. Due
>  to some special constants we use to track parents, we can store at most
> @@ -93,6 +96,27 @@ CHUNK DATA:
>        positions for the parents until reaching a value with the most-sig=
nificant
>        bit on. The other bits correspond to the position of the last pare=
nt.
>=20=20
> +  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
> +    * The ith entry, BIDX[i], stores the number of 8-byte word blocks in=
 all
> +      Bloom filters from commit 0 to commit i (inclusive) in lexicograph=
ic
> +      order. The Bloom filter for the i-th commit spans from BIDX[i-1] to
> +      BIDX[i] (plus header length), where BIDX[-1] is 0.
> +    * The BIDX chunk is ignored if the BDAT chunk is not present.

All right.  Looks good.

> +
> +  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
> +    * It starts with header consisting of three unsigned 32-bit integers:
> +      - Version of the hash algorithm being used. We currently only supp=
ort
> +	value 1 which implies the murmur3 hash implemented exactly as described
> +	in https://en.wikipedia.org/wiki/MurmurHash#Algorithm

First a minor issue: shouldn't this nested unordered list be indented
with a hanging indent formatted with spaces?  That is be formatted like
the following:

  +  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
  +    * It starts with header consisting of three unsigned 32-bit integers:
  +      - Version of the hash algorithm being used. We currently only supp=
ort
  +        value 1 which implies the murmur3 hash implemented exactly as
  +        described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm

But the existing formatting with spaces and tabs might be fine as it is,
that is it renders as nested list with Asciidoc; it only looks a bit
weird as patch, not so as text.

Second, and more important: it is in my opinion not enough information,
at least if we are assuming that the information in this document should
be enough for clean-room reimplementation of Bloom filter functionality
(for example by JGit).  To generate compatible Bloom filters, one needs
also the information on how to create $k$ functionally-independent hash
functions out of murmur3 hash.  We do it currently using double hashing
technique; if that changes then the exact set of bits in the Bloom
filter would also change.

The additional description could look something like the following:

  +    * It starts with header consisting of three unsigned 32-bit integers:
  +      - Version of the hash algorithm being used. We currently only supp=
ort
  +        value 1 which implies the murmur3_32 hash implemented exactly as
  +        described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
  +        and double hashing technique with 0x293ae76f and 0x7e646e2c seeds
  +        as described in https://doi.org/10.1007/978-3-540-30494-4_26
  +        "Bloom Filters in Probabilistic Verification"

Also, it should be explicitly noted that we use murmur3_32, because
there is also 128-bit version of murmur3 hash.

> +      - The number of times a path is hashed and hence the number of bit=
 positions
> +	that cumulatively determine whether a file is present in the commit.

All right, in the original Bloom filter it was the number of different
hash functions.  With the double hashing technique, it is the number of
times a path is hashed.

> +      - The minimum number of bits 'b' per entry in the Bloom filter. If=
 the filter
> +	contains 'n' entries, then the filter size is the minimum number of 64-=
bit
> +	words that contain n*b bits.

All right, that means empty Bloom filter, representing "no changes",
with 'n' equal 0 entries, is represented as size 0 filter.  That is, if
we read this rule exactly as written.

Should we add the information that size 0 / length 0 filter is
considered "no data" case?  Or should we leave it to implementation?

There are two corner cases:
- "no changes" case, where all queries are answered with "no"
  can be represented as filter of size 0, or as Bloom filter with all
  bits set to 0
- "no data" case (used when there are more than 512 changed files)
  where all queries are answered with "maybe", currently represented
  as filter of size 0; can also be represented as Bloom filter with all
  bits set to 1

> +    * The rest of the chunk is the concatenation of all the computed Blo=
om
> +      filters for the commits in lexicographic order.

All right.

> +    * The BDAT chunk is present iff BIDX is present.

Perhaps we should spell 'iff' in full, that is 'if and only if'?

> +
>    Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
>        This list of H-byte hashes describe a set of B commit-graph files =
that
>        form a commit-graph chain. The graph position for the ith commit i=
n this
> diff --git a/commit-graph.c b/commit-graph.c
> index 32a315058f..4585b3b702 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -24,8 +24,10 @@
>  #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
>  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
>  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
> +#define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
> +#define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
>  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
> -#define MAX_NUM_CHUNKS 5
> +#define MAX_NUM_CHUNKS 7
>=20=20
>  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
>=20=20
> @@ -325,6 +327,32 @@ struct commit_graph *parse_commit_graph(void *graph_=
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
> +
> +		case GRAPH_CHUNKID_BLOOMDATA:
> +			if (graph->chunk_bloom_data)
> +				chunk_repeated =3D 1;
> +			else {
> +				uint32_t hash_version;
> +				graph->chunk_bloom_data =3D data + chunk_offset;
> +				hash_version =3D get_be32(data + chunk_offset);
> +
> +				if (hash_version !=3D 1)
> +					break;

Shouldn't we mark Bloom filter as not to be used?  Or is it left for
later commit?

In the future it might be good idea to notify the user (perhaps
protected with some advice.* option) that there is problem with Bloom
filter data, namely that we have encountered unsupported hash version.

> +
> +				graph->bloom_filter_settings =3D xmalloc(sizeof(struct bloom_filter_=
settings));

Why is this structure allocated dynamically?  We are leaking admittedly
a small amount of memory because we never free this xmalloc() result.

If we need this field being a pointer to struct to have NULL mean no
supported Bloom filter data, we could have instead use chunk_bloom_*
fields instead - we can set at least one of them to NULL.

> +				graph->bloom_filter_settings->hash_version =3D hash_version;
> +				graph->bloom_filter_settings->num_hashes =3D get_be32(data + chunk_o=
ffset + 4);
> +				graph->bloom_filter_settings->bits_per_entry =3D get_be32(data + chu=
nk_offset + 8);

All right; these 4 and 8 are sizeof(uint32_t) and 2*sizeof(uint32_t),
respectively.

> +			}
> +			break;
>  		}
>=20=20
>  		if (chunk_repeated) {
> @@ -343,6 +371,17 @@ struct commit_graph *parse_commit_graph(void *graph_=
map, int fd,
>  		last_chunk_offset =3D chunk_offset;
>  	}
>=20=20
> +	/* We need both the bloom chunks to exist together. Else ignore the dat=
a */
> +	if ((graph->chunk_bloom_indexes && !graph->chunk_bloom_data)
> +		 || (!graph->chunk_bloom_indexes && graph->chunk_bloom_data)) {
> +		graph->chunk_bloom_indexes =3D NULL;
> +		graph->chunk_bloom_data =3D NULL;
> +		graph->bloom_filter_settings =3D NULL;
> +	}
> +
> +	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data)
> +		load_bloom_filters();

Wouldn't it be simpler to rely on the fact that both Bloom chunks must
exists for it to matter, and write it like this:

  +	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
  +		load_bloom_filters();
  +	} else {
  +		graph->chunk_bloom_indexes =3D NULL;
  +		graph->chunk_bloom_data =3D NULL;
  +		graph->bloom_filter_settings =3D NULL;
  +	}

> +
>  	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_le=
n);
>=20=20
>  	if (verify_commit_graph_lite(graph)) {
> @@ -1040,6 +1079,59 @@ static void write_graph_chunk_extra_edges(struct h=
ashfile *f,
>  	}
>  }
>=20=20
> +static void write_graph_chunk_bloom_indexes(struct hashfile *f,
> +					    struct write_commit_graph_context *ctx)
> +{
> +	struct commit **list =3D ctx->commits.list;
> +	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> +	uint32_t cur_pos =3D 0;
> +	struct progress *progress =3D NULL;
> +	int i =3D 0;
> +
> +	if (ctx->report_progress)
> +		progress =3D start_delayed_progress(
> +			_("Writing changed paths Bloom filters index"),
> +			ctx->commits.nr);
> +
> +	while (list < last) {
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list);
> +		cur_pos +=3D filter->len;
> +		display_progress(progress, ++i);
> +		hashwrite_be32(f, cur_pos);
> +		list++;
> +	}
> +
> +	stop_progress(&progress);
> +}

All right, looks good.

> +
> +static void write_graph_chunk_bloom_data(struct hashfile *f,
> +					 struct write_commit_graph_context *ctx,
> +					 struct bloom_filter_settings *settings)
> +{
> +	struct commit **list =3D ctx->commits.list;
> +	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> +	struct progress *progress =3D NULL;
> +	int i =3D 0;
> +
> +	if (ctx->report_progress)
> +		progress =3D start_delayed_progress(
> +			_("Writing changed paths Bloom filters data"),
> +			ctx->commits.nr);
> +
> +	hashwrite_be32(f, settings->hash_version);
> +	hashwrite_be32(f, settings->num_hashes);
> +	hashwrite_be32(f, settings->bits_per_entry);
> +
> +	while (list < last) {
> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list);
> +		display_progress(progress, ++i);
> +		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
> +		list++;
> +	}
> +
> +	stop_progress(&progress);
> +}

All right, looks good.

Side note: why have while loop here instead of for loop, like in
previous patches?  I'm not saying this is a bad idea (especially with
same names for same variables).

> +
>  static int oid_compare(const void *_a, const void *_b)
>  {
>  	const struct object_id *a =3D (const struct object_id *)_a;
> @@ -1198,8 +1290,8 @@ static void compute_bloom_filters(struct write_comm=
it_graph_context *ctx)
>  	load_bloom_filters();
>=20=20
>  	if (ctx->report_progress)
> -		progress =3D start_progress(
> -			_("Computing commit diff Bloom filters"),
> +		progress =3D start_delayed_progress(
> +			_("Computing changed paths Bloom filters"),
>  			ctx->commits.nr);
>

Ooops.  This look like a fixup which should be made to the original
earlier commit instead, isn't it?

>  	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
> @@ -1444,6 +1536,7 @@ static int write_commit_graph_file(struct write_com=
mit_graph_context *ctx)
>  	struct strbuf progress_title =3D STRBUF_INIT;
>  	int num_chunks =3D 3;
>  	struct object_id file_hash;
> +	struct bloom_filter_settings bloom_settings =3D DEFAULT_BLOOM_FILTER_SE=
TTINGS;
>=20=20
>  	if (ctx->split) {
>  		struct strbuf tmp_file =3D STRBUF_INIT;
> @@ -1488,6 +1581,12 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>  		chunk_ids[num_chunks] =3D GRAPH_CHUNKID_EXTRAEDGES;
>  		num_chunks++;
>  	}
> +	if (ctx->changed_paths) {
> +		chunk_ids[num_chunks] =3D GRAPH_CHUNKID_BLOOMINDEXES;
> +		num_chunks++;
> +		chunk_ids[num_chunks] =3D GRAPH_CHUNKID_BLOOMDATA;
> +		num_chunks++;
> +	}

All right, adding chunks and counting them.

>  	if (ctx->num_commit_graphs_after > 1) {
>  		chunk_ids[num_chunks] =3D GRAPH_CHUNKID_BASE;
>  		num_chunks++;
> @@ -1506,6 +1605,15 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>  						4 * ctx->num_extra_edges;
>  		num_chunks++;
>  	}
> +	if (ctx->changed_paths) {
> +		chunk_offsets[num_chunks + 1] =3D chunk_offsets[num_chunks] +
> +						sizeof(uint32_t) * ctx->commits.nr;
> +		num_chunks++;
> +
> +		chunk_offsets[num_chunks + 1] =3D chunk_offsets[num_chunks] +
> +						sizeof(uint32_t) * 3 + ctx->total_bloom_filter_data_size;
> +		num_chunks++;
> +	}

All right, calculating chunk offsets.

>  	if (ctx->num_commit_graphs_after > 1) {
>  		chunk_offsets[num_chunks + 1] =3D chunk_offsets[num_chunks] +
>  						hashsz * (ctx->num_commit_graphs_after - 1);
> @@ -1543,6 +1651,10 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>  	write_graph_chunk_data(f, hashsz, ctx);
>  	if (ctx->num_extra_edges)
>  		write_graph_chunk_extra_edges(f, ctx);
> +	if (ctx->changed_paths) {
> +		write_graph_chunk_bloom_indexes(f, ctx);
> +		write_graph_chunk_bloom_data(f, ctx, &bloom_settings);
> +	}

All right, writing BIDX and BDAT chunks with default settings.

By the way, in the future, when appending to existing commit-graph file,
shouldn't we re-use existing settings even if they are different from
default settings?  But that is question for the future...

>  	if (ctx->num_commit_graphs_after > 1 &&
>  	    write_graph_chunk_base(f, ctx)) {
>  		return -1;
> diff --git a/commit-graph.h b/commit-graph.h
> index 952a4b83be..25fefefb3e 100644
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

All right.

> +
> +	struct bloom_filter_settings *bloom_filter_settings;

Why it is pointer to struct, instead of being just struct type?
Is there reason for that?

>  };
>=20=20
>  struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st=
);
> @@ -77,7 +82,7 @@ enum commit_graph_write_flags {
>  	COMMIT_GRAPH_WRITE_SPLIT      =3D (1 << 2),
>  	/* Make sure that each OID in the input is a valid commit OID. */
>  	COMMIT_GRAPH_WRITE_CHECK_OIDS =3D (1 << 3),
> -	COMMIT_GRAPH_WRITE_BLOOM_FILTERS =3D (1 << 4)
> +	COMMIT_GRAPH_WRITE_BLOOM_FILTERS =3D (1 << 4),

This looks like accidental change; if we want to use trailing comma in
enum, this change should be in my opinion done in the commit that added
COMMIT_GRAPH_WRITE_BLOOM_FILTERS (as I have written in a comment there).

>  };
>=20=20
>  struct split_commit_graph_opts {

Thank you for your work on this series.

Best,
--=20
Jakub Nar=C4=99bski
