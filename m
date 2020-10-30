Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C3BC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 12:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E0E206ED
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 12:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXjW11CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgJ3M4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3M4F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 08:56:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D250C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 05:45:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 184so7705814lfd.6
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9eDgfe8D3I1CRXy3pPEsLIw3P8++aBzDw9j3RBGB1Uw=;
        b=MXjW11CLRD0F2JAJU09VWBDs/XkrMW0K9zlekj35XWykLnSdK0oMvEBaRYqOWnEp/P
         Oi57fukSSeee28YOQCmKWevvuMgFbDcUr5SYn2tm6eWjsafX4Xbw515pZdGRT72aKXo6
         7Y4xVKR5MHwfgTjtzwDtdqcDe2Fsa2Z0qIAt4WAwI3QPqs8Qt8DQPnZk4IkZekASzRtG
         naqsANQXaezVST95qMBtR6tfkv/VStP0f5CrTOeyDqvI4IH0GfrCMA6GQf2yjB59DOmd
         y5YoHEcRraNjQzVRHeNaUTfdS4CwjwvI7GO67xjmu24PMWLfF6Kz7UK1KfvVlvmz16Rp
         qMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=9eDgfe8D3I1CRXy3pPEsLIw3P8++aBzDw9j3RBGB1Uw=;
        b=c9frXC9WI8ODw9msFcW/NY+7E2X9T0E1ORdQaE1tADNJRwpOQAiOM6v24D7NgDF2QN
         GaFgvcIZ/wcfv5djfhJAc8FAGhvcwebq/efJ4Ebom6VtR6Y1u8mlTVNn2WynYEafsCxS
         RIJqz1mGFLI1uXQXsDxr6ux6gT2eYsSvoOVa4qRAyjz1Fk+N0QP3Kg/rneuoy7Knqr+e
         41BUl6O1xuuVGUYbllOisUGhpo9atyN/HLj3sJbi+7Beu325lfteFHSu6ixy/h7thq+j
         fxv0WZby0Rgq81a5Cs+2r4G2B6DgcrQsD+ri8LdCd33JhGLwU3Ng55wNWgFQ1p7j4BR/
         ugNA==
X-Gm-Message-State: AOAM533eMJBYB0PmFHkeMKP+2s80lKiozCXoY/HozUQZBzQ+e+97g6FT
        YQ7sTj5IisetSDdTjHRjQUM=
X-Google-Smtp-Source: ABdhPJwO4vQ3EOFSs05nCCbiKE+jBJWDNZLsfYUTR5v7YWr3w81pvoZvpzfvhq1wxYXZLkpcY66GQg==
X-Received: by 2002:a19:7003:: with SMTP id h3mr781934lfc.350.1604061932220;
        Fri, 30 Oct 2020 05:45:32 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id i23sm660951ljb.138.2020.10.30.05.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 05:45:31 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 07/10] commit-graph: implement generation data chunk
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <b903efe2ea11bc0b7e1ef8f239ed34f72caa4f03.1602079786.git.gitgitgadget@gmail.com>
Date:   Fri, 30 Oct 2020 13:45:29 +0100
In-Reply-To: <b903efe2ea11bc0b7e1ef8f239ed34f72caa4f03.1602079786.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:42
        +0000")
Message-ID: <854kmbx4pi.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tl;dr summary: the code writing GDOV chunk could be made more performant
(I think), but that could be left for the future commit.

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> As discovered by =C3=86var, we cannot increment graph version to
> distinguish between generation numbers v1 and v2 [1]. Thus, one of
> pre-requistes before implementing generation number was to distinguish
> between graph versions in a backwards compatible manner.

Minor nitpick: I think you meant "implementing generation number v2",
to be more precise.

>
> We are going to introduce a new chunk called Generation Data chunk (or

Very minor nitpick: perhaps s/Generation Data/Generation DATa/, to provide
mnemonics for chunk name.

> GDAT). GDAT stores corrected committer date offsets whereas CDAT will
> still store topological level.

Minor nitpick: I think the second sentence should use consistent
grammatical tense (but I am not a native English speaker); also
s/level/levels/:

    GDAT will store corrected committer date offsets, whereas CDAT will
    still store topological levels.

But it is perfectly understandable as it is.

>
> Old Git does not understand GDAT chunk and would ignore it, reading
> topological levels from CDAT. New Git can parse GDAT and take advantage
> of newer generation numbers, falling back to topological levels when
> GDAT chunk is missing (as it would happen with a commit graph written
> by old Git).

Minor nitpick: I think we use commit-graph with dash when writing about
the commit-graph file, like below.

>
> We introduce a test environment variable 'GIT_TEST_COMMIT_GRAPH_NO_GDAT'
> which forces commit-graph file to be written without generation data
> chunk to emulate a commit-graph file written by old Git.

All right.

>
> While storing corrected commit date offset instead of the corrected
> commit date saves us 4 bytes per commit, it's possible for the offsets
> to overflow the 4-bytes allocated. As such overflows are exceedingly
> rare, we use the following overflow management scheme:

Perhaps it would be good idea to write the idea in full from start, as
the commit message is intended to be read stadalone and not in the
context of the patch series.  On the other hand it might be too much
detail in already [necessarily] lengthty commit message.

Perhaps something like the following proposal would read better.

  To minimize the space required to store corrected commit date, Git
  stores corrected commit date offsets into the commit-graph file,
  instead of corrected commit dates themselves. This saves us 4 bytes
  per commit, decreasing the GDAT chunk size by half, but it's possible
  for the offset to overflow the 4-bytes allocated for storage. As such
  overflows are and should be exceedingly rare, we use the following
  overflow management scheme:


NOTE: this overflow handling is a *new* code (or new-ish code, as it is
inspired and similar to EDGE chunk data handling), so it needs more
careful review.

>
> We introduce a new commit-graph chunk, GENERATION_DATA_OVERFLOW ('GDOV')

Minor issue: why GENERATION_DATA_OVERFLOW and not Generation Data
OVerflow, like for the GDAT chunk?

> to store corrected commit dates for commits with offsets greater than
> GENERATION_NUMBER_V2_OFFSET_MAX.
>
> If the offset is greater than GENERATION_NUMBER_V2_OFFSET_MAX, we set
> the MSB of the offset and the other bits store the position of corrected
> commit date in GDOV chunk, similar to how Extra Edge List is maintained.
>
> We test the overflow-related code with the following repo history:
>
>            F - N - U
>           /         \
> U - N - U            N
>          \          /
>            N - F - N

Do we need such complex history? I guess we need to test the handling of
merge commits too.

>
> Where the commits denoted by U have committer date of zero seconds
> since Unix epoch, the commits denoted by N have committer date of
> 1112354055 (default committer date for the test suite) seconds since
> Unix epoch and the commits denoted by F have committer date of
> (2 ^ 31 - 2) seconds since Unix epoch.
>
> The largest offset observed is 2 ^ 31, just large enough to overflow.
>
> [1]: https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c                | 98 +++++++++++++++++++++++++++++++++--
>  commit-graph.h                |  3 ++
>  commit.h                      |  1 +
>  t/README                      |  3 ++
>  t/helper/test-read-graph.c    |  4 ++
>  t/t4216-log-bloom.sh          |  4 +-
>  t/t5318-commit-graph.sh       | 70 ++++++++++++++++++++-----
>  t/t5324-split-commit-graph.sh | 12 ++---
>  t/t6600-test-reach.sh         | 68 +++++++++++++-----------
>  9 files changed, 206 insertions(+), 57 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 03948adfce..71d0b243db 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -38,11 +38,13 @@ void git_test_write_commit_graph_or_die(void)
>  #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
>  #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
>  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
> +#define GRAPH_CHUNKID_GENERATION_DATA 0x47444154 /* "GDAT" */
> +#define GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW 0x47444f56 /* "GDOV" */
>  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
>  #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
>  #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
>  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
> -#define MAX_NUM_CHUNKS 7
> +#define MAX_NUM_CHUNKS 9

All right.

>=20=20
>  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
>=20=20
> @@ -61,6 +63,8 @@ void git_test_write_commit_graph_or_die(void)
>  #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
>  			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
>=20=20
> +#define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)
> +

All right, though the naming convention is different from the one used
for EDGE chunk: GRAPH_EXTRA_EDGES_NEEDED and GRAPH_EDGE_LAST_MASK.

>  /* Remember to update object flag allocation in object.h */
>  #define REACHABLE       (1u<<15)
>=20=20
> @@ -385,6 +389,20 @@ struct commit_graph *parse_commit_graph(struct repos=
itory *r,
>  				graph->chunk_commit_data =3D data + chunk_offset;
>  			break;
>=20=20
> +		case GRAPH_CHUNKID_GENERATION_DATA:
> +			if (graph->chunk_generation_data)
> +				chunk_repeated =3D 1;
> +			else
> +				graph->chunk_generation_data =3D data + chunk_offset;
> +			break;
> +
> +		case GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW:
> +			if (graph->chunk_generation_data_overflow)
> +				chunk_repeated =3D 1;
> +			else
> +				graph->chunk_generation_data_overflow =3D data + chunk_offset;
> +			break;
> +

Necessary but unavoidable boilerplate for adding new chunks to the
commit-graph file format.  All right.

>  		case GRAPH_CHUNKID_EXTRAEDGES:
>  			if (graph->chunk_extra_edges)
>  				chunk_repeated =3D 1;
> @@ -745,8 +763,8 @@ static void fill_commit_graph_info(struct commit *ite=
m, struct commit_graph *g,
>  {
>  	const unsigned char *commit_data;
>  	struct commit_graph_data *graph_data;
> -	uint32_t lex_index;
> -	uint64_t date_high, date_low;
> +	uint32_t lex_index, offset_pos;
> +	uint64_t date_high, date_low, offset;

All right, we are adding two new variables: `offset` to read data stored
in GDAT chunk, and `offset_pos` to help read data from GDOV chunk if
necessary i.e. to handle overflow in corrected commit data offset
storage.

>=20=20
>  	while (pos < g->num_commits_in_base)
>  		g =3D g->base_graph;
> @@ -764,7 +782,16 @@ static void fill_commit_graph_info(struct commit *it=
em, struct commit_graph *g,
>  	date_low =3D get_be32(commit_data + g->hash_len + 12);
>  	item->date =3D (timestamp_t)((date_high << 32) | date_low);
>=20=20
> -	graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
> +	if (g->chunk_generation_data) {
> +		offset =3D (timestamp_t) get_be32(g->chunk_generation_data + sizeof(ui=
nt32_t) * lex_index);

Style: why space after the `(timestamp_t)` cast operator?

Though CodingGuidelines do not say anything on this topic... perhaps the
space after cast operator makes it more readable?

> +
> +		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {

All right, so the CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW is equivalent of
GRAPH_EXTRA_EDGES_NEEDED.

> +			offset_pos =3D offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;

Hmmm... instead of using bitwise and on an equivalent to the
GRAPH_EDGE_LAST_MASK, we utilize the fact that we know that the MSB bit
is set, so we can clear it with bitwise xor.  Clever trick.

> +			graph_data->generation =3D get_be64(g->chunk_generation_data_overflow=
 + 8 * offset_pos);
> +		} else
> +			graph_data->generation =3D item->date + offset;

All right, this handles the case when we have generation number v2, with
or without overflow.

> +	} else
> +		graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> =
2;

All right, this handles the case where we have only generation number
v1, like for commit-graph file written by old Git.

>=20=20
>  	if (g->topo_levels)
>  		*topo_level_slab_at(g->topo_levels, item) =3D get_be32(commit_data + g=
->hash_len + 8) >> 2;
> @@ -942,6 +969,7 @@ struct write_commit_graph_context {
>  	struct packed_oid_list oids;
>  	struct packed_commit_list commits;
>  	int num_extra_edges;
> +	int num_generation_data_overflows;
>  	unsigned long approx_nr_objects;
>  	struct progress *progress;
>  	int progress_done;
> @@ -960,7 +988,8 @@ struct write_commit_graph_context {
>  		 report_progress:1,
>  		 split:1,
>  		 changed_paths:1,
> -		 order_by_pack:1;
> +		 order_by_pack:1,
> +		 write_generation_data:1;
>=20=20
>  	struct topo_level_slab *topo_levels;
>  	const struct commit_graph_opts *opts;

All right, this adds necessary fields to `struct write_commit_graph_context=
`.

> @@ -1120,6 +1149,44 @@ static int write_graph_chunk_data(struct hashfile =
*f,
>  	return 0;
>  }
>=20=20
> +static int write_graph_chunk_generation_data(struct hashfile *f,
> +					      struct write_commit_graph_context *ctx)
> +{
> +	int i, num_generation_data_overflows =3D 0;

Minor nitpick: in my opinion there should be empty line here, between
the variables declaration and the code... however not all
write_graph_chunk_*() functions have it.

> +	for (i =3D 0; i < ctx->commits.nr; i++) {
> +		struct commit *c =3D ctx->commits.list[i];
> +		timestamp_t offset =3D commit_graph_data_at(c)->generation - c->date;
> +		display_progress(ctx->progress, ++ctx->progress_cnt);

All right.

> +
> +		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
> +			offset =3D CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_dat=
a_overflows;
> +			num_generation_data_overflows++;
> +		}

Hmmm... shouldn't we store these commits that need overflow handling
(with corrected commit date offset greater than GENERATION_NUMBER_V2_OFFSET=
_MAX)
in a list or a queue, to remember them for writing GDOV chunk?

We could store oids, or we could store commits themselves, for example:

		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
			offset =3D CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW | num_generation_data_o=
verflows;
			num_generation_data_overflows++;

			ALLOC_GROW(ctx->gdov_commits.list, ctx->gdov_commits.nr + 1, ctx->gdov_c=
ommits.alloc);
			ctx->commits.list[ctx->gdov_commits.nr] =3D c;
            ctx->gdov_commits.nr++;
		}

Though in the above proposal we could get rid of `num_generation_data_overf=
lows`,=20
as it should be the same as `ctx->gdov_commits.nr`.

I have called the extra commit list member of write_commit_graph_context
`gdov_commits`, but perhaps a better name would be `commits_gen_v2_overflow=
`,=20
or similar more descriptive name.

> +
> +		hashwrite_be32(f, offset);
> +	}
> +
> +	return 0;
> +}

All right.

> +
> +static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
> +						       struct write_commit_graph_context *ctx)
> +{
> +	int i;
> +	for (i =3D 0; i < ctx->commits.nr; i++) {

Here we loop over *all* commits again, instead of looping over those
very rare commits that need overflow handling for their corrected commit
date data.

Though this possible performance issue^* could be fixed in the future commi=
t.

*) It needs to be actually benchmarked which version is faster.

With the change proposed above (and required changes to the `struct
write_commit_graph_context`) it could look like this:

	for (i =3D 0; i < ctx->gcov_commits.nr; i++) {


> +		struct commit *c =3D ctx->commits.list[i];
> +		timestamp_t offset =3D commit_graph_data_at(c)->generation - c->date;
> +		display_progress(ctx->progress, ++ctx->progress_cnt);
> +
> +		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX) {
> +			hashwrite_be32(f, offset >> 32);
> +			hashwrite_be32(f, (uint32_t) offset);
> +		}
> +	}

The above would be as simple as the following:

		struct commit *c =3D ctx->gcov_commits.list[i];
		timestamp_t offset =3D commit_graph_data_at(c)->generation - c->date;
		display_progress(ctx->progress, ++ctx->progress_cnt);

		hashwrite_be64(f, offset);

Assumming that there would be hashwrite_be64(), it would be the
following otherwise:

		hashwrite_be32(f, offset >> 32);
		hashwrite_be32(f, (uint32_t)offset);

> +
> +	return 0;
> +}
> +
>  static int write_graph_chunk_extra_edges(struct hashfile *f,
>  					 struct write_commit_graph_context *ctx)
>  {
> @@ -1399,7 +1466,11 @@ static void compute_generation_numbers(struct writ=
e_commit_graph_context *ctx)
>=20=20
>  				if (current->date && current->date > max_corrected_commit_date)
>  					max_corrected_commit_date =3D current->date - 1;
> +

This is a bit unrelated change, adding this empty line.

>  				commit_graph_data_at(current)->generation =3D max_corrected_commit_d=
ate + 1;
> +
> +				if (commit_graph_data_at(current)->generation - current->date > GENE=
RATION_NUMBER_V2_OFFSET_MAX)
> +					ctx->num_generation_data_overflows++;

All right, we need to track number of commits that need overflow
handling for generation number v2 to know what size GDOV chunk would
need to be.

>  			}
>  		}
>  	}
> @@ -1765,6 +1836,21 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>  	chunks[2].id =3D GRAPH_CHUNKID_DATA;
>  	chunks[2].size =3D (hashsz + 16) * ctx->commits.nr;
>  	chunks[2].write_fn =3D write_graph_chunk_data;
> +
> +	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0))
> +		ctx->write_generation_data =3D 0;

All right, here we handle GIT_TEST_COMMIT_GRAPH_NO_GDAT.

> +	if (ctx->write_generation_data) {
> +		chunks[num_chunks].id =3D GRAPH_CHUNKID_GENERATION_DATA;
> +		chunks[num_chunks].size =3D sizeof(uint32_t) * ctx->commits.nr;
> +		chunks[num_chunks].write_fn =3D write_graph_chunk_generation_data;
> +		num_chunks++;
> +	}

All right, the GDAT chunk consist of <number of commits> entries.

> +	if (ctx->num_generation_data_overflows) {
> +		chunks[num_chunks].id =3D GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW;
> +		chunks[num_chunks].size =3D sizeof(timestamp_t) * ctx->num_generation_=
data_overflows;
> +		chunks[num_chunks].write_fn =3D write_graph_chunk_generation_data_over=
flow;
> +		num_chunks++;
> +	}

All right, that's what num_generation_data_overflows was for.

>  	if (ctx->num_extra_edges) {
>  		chunks[num_chunks].id =3D GRAPH_CHUNKID_EXTRAEDGES;
>  		chunks[num_chunks].size =3D 4 * ctx->num_extra_edges;
> @@ -2170,6 +2256,8 @@ int write_commit_graph(struct object_directory *odb,
>  	ctx->split =3D flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
>  	ctx->opts =3D opts;
>  	ctx->total_bloom_filter_data_size =3D 0;
> +	ctx->write_generation_data =3D 1;
> +	ctx->num_generation_data_overflows =3D 0;
>=20=20
>  	bloom_settings.bits_per_entry =3D git_env_ulong("GIT_TEST_BLOOM_SETTING=
S_BITS_PER_ENTRY",
>  						      bloom_settings.bits_per_entry);
> diff --git a/commit-graph.h b/commit-graph.h
> index 2e9aa7824e..19a02001fd 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -6,6 +6,7 @@
>  #include "oidset.h"
>=20=20
>  #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
> +#define GIT_TEST_COMMIT_GRAPH_NO_GDAT "GIT_TEST_COMMIT_GRAPH_NO_GDAT"
>  #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON=
_PARSE"
>  #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANG=
ED_PATHS"
>=20=20
> @@ -68,6 +69,8 @@ struct commit_graph {
>  	const uint32_t *chunk_oid_fanout;
>  	const unsigned char *chunk_oid_lookup;
>  	const unsigned char *chunk_commit_data;
> +	const unsigned char *chunk_generation_data;
> +	const unsigned char *chunk_generation_data_overflow;

All right, two new chunks: GDAT and GDOV.

>  	const unsigned char *chunk_extra_edges;
>  	const unsigned char *chunk_base_graphs;
>  	const unsigned char *chunk_bloom_indexes;
> diff --git a/commit.h b/commit.h
> index 33c66b2177..251d877fcf 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -14,6 +14,7 @@
>  #define GENERATION_NUMBER_INFINITY ((1ULL << 63) - 1)
>  #define GENERATION_NUMBER_V1_MAX 0x3FFFFFFF
>  #define GENERATION_NUMBER_ZERO 0
> +#define GENERATION_NUMBER_V2_OFFSET_MAX ((1ULL << 31) - 1)

Should we use this form, or hexadecimal constant?

   #define GENERATION_NUMBER_V2_OFFSET_MAX 0x7FFFFFFF

But I think the current definition is more explicit: all bits set to one
except for the most significant digit.  All right.

>=20=20
>  struct commit_list {
>  	struct commit *item;
> diff --git a/t/README b/t/README
> index 2adaf7c2d2..975c054bc9 100644
> --- a/t/README
> +++ b/t/README
> @@ -379,6 +379,9 @@ GIT_TEST_COMMIT_GRAPH=3D<boolean>, when true, forces =
the commit-graph to
>  be written after every 'git commit' command, and overrides the
>  'core.commitGraph' setting to true.
>=20=20
> +GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D<boolean>, when true, forces the
> +commit-graph to be written without generation data chunk.
> +

All right. Nice have it documented.

>  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D<boolean>, when true, forces
>  commit-graph write to compute and write changed path Bloom filters for
>  every 'git commit-graph write', as if the `--changed-paths` option was
> diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
> index 5f585a1725..75927b2c81 100644
> --- a/t/helper/test-read-graph.c
> +++ b/t/helper/test-read-graph.c
> @@ -33,6 +33,10 @@ int cmd__read_graph(int argc, const char **argv)
>  		printf(" oid_lookup");
>  	if (graph->chunk_commit_data)
>  		printf(" commit_metadata");
> +	if (graph->chunk_generation_data)
> +		printf(" generation_data");
> +	if (graph->chunk_generation_data_overflow)
> +		printf(" generation_data_overflow");
>  	if (graph->chunk_extra_edges)
>  		printf(" extra_edges");
>  	if (graph->chunk_bloom_indexes)

All right, updating `test-tool read-graph` with new chunks.

> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index d11040ce41..dbde016188 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -40,11 +40,11 @@ test_expect_success 'setup test - repo, commits, comm=
it graph, log outputs' '
>  '
>=20=20
>  graph_read_expect () {
> -	NUM_CHUNKS=3D5
> +	NUM_CHUNKS=3D6
>  	cat >expect <<- EOF

Sidenote: I have just noticed this, and as I see it is not something you
wrote, but usually we write it with no space after the dash and before
'EOF':

   	cat >expect <<-EOF

>  	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
>  	num_commits: $1
> -	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
> +	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_ind=
exes bloom_data
>  	EOF
>  	test-tool read-graph >actual &&
>  	test_cmp expect actual

All right, updating expect value for `test-tool read-graph` in the usual
case, with generation number chunk.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 2ed0c1544d..0328e98564 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -76,7 +76,7 @@ graph_git_behavior 'no graph' full commits/3 commits/1
>  graph_read_expect() {
>  	OPTIONAL=3D""
>  	NUM_CHUNKS=3D3
> -	if test ! -z $2
> +	if test ! -z "$2"

All right, that is straighforward fix, which is now needed.

>  	then
>  		OPTIONAL=3D" $2"
>  		NUM_CHUNKS=3D$((3 + $(echo "$2" | wc -w)))
> @@ -103,14 +103,14 @@ test_expect_success 'exit with correct error on bad=
 input to --stdin-commits' '
>  	# valid commit and tree OID
>  	git rev-parse HEAD HEAD^{tree} >in &&
>  	git commit-graph write --stdin-commits <in &&
> -	graph_read_expect 3
> +	graph_read_expect 3 generation_data
>  '
>=20=20
>  test_expect_success 'write graph' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "3"
> +	graph_read_expect "3" generation_data
>  '
>=20=20
>  test_expect_success POSIXPERM 'write graph has correct permissions' '
> @@ -219,7 +219,7 @@ test_expect_success 'write graph with merges' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "10" "extra_edges"
> +	graph_read_expect "10" "generation_data extra_edges"
>  '
>=20=20
>  graph_git_behavior 'merge 1 vs 2' full merge/1 merge/2
> @@ -254,7 +254,7 @@ test_expect_success 'write graph with new commit' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "11" "extra_edges"
> +	graph_read_expect "11" "generation_data extra_edges"
>  '
>=20=20
>  graph_git_behavior 'full graph, commit 8 vs merge 1' full commits/8 merg=
e/1
> @@ -264,7 +264,7 @@ test_expect_success 'write graph with nothing new' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "11" "extra_edges"
> +	graph_read_expect "11" "generation_data extra_edges"
>  '
>=20=20
>  graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 m=
erge/1
> @@ -274,7 +274,7 @@ test_expect_success 'build graph from latest pack wit=
h closure' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	cat new-idx | git commit-graph write --stdin-packs &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "9" "extra_edges"
> +	graph_read_expect "9" "generation_data extra_edges"
>  '
>=20=20
>  graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8=
 merge/1
> @@ -287,7 +287,7 @@ test_expect_success 'build graph from commits with cl=
osure' '
>  	git rev-parse merge/1 >>commits-in &&
>  	cat commits-in | git commit-graph write --stdin-commits &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "6"
> +	graph_read_expect "6" "generation_data"
>  '
>=20=20
>  graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commit=
s/8 merge/1
> @@ -297,7 +297,7 @@ test_expect_success 'build graph from commits with ap=
pend' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git rev-parse merge/3 | git commit-graph write --stdin-commits --append=
 &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "10" "extra_edges"
> +	graph_read_expect "10" "generation_data extra_edges"
>  '
>=20=20
>  graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 me=
rge/1
> @@ -307,7 +307,7 @@ test_expect_success 'build graph using --reachable' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write --reachable &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "11" "extra_edges"
> +	graph_read_expect "11" "generation_data extra_edges"
>  '
>=20=20
>  graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 me=
rge/1
> @@ -328,7 +328,7 @@ test_expect_success 'write graph in bare repo' '
>  	cd "$TRASH_DIRECTORY/bare" &&
>  	git commit-graph write &&
>  	test_path_is_file $baredir/info/commit-graph &&
> -	graph_read_expect "11" "extra_edges"
> +	graph_read_expect "11" "generation_data extra_edges"
>  '

All those just add "generation_data" (aka GDAT) to expected chunks. All
right.

>=20=20
>  graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare comm=
its/8 merge/1
> @@ -454,8 +454,9 @@ test_expect_success 'warn on improper hash version' '
>=20=20
>  test_expect_success 'git commit-graph verify' '
>  	cd "$TRASH_DIRECTORY/full" &&
> -	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
> -	git commit-graph verify >output
> +	git rev-parse commits/8 | GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1 git commit-=
graph write --stdin-commits &&
> +	git commit-graph verify >output &&

All right, this simply adds GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1.  I assume
this is needed because this test is also setup for the following commits
_without_ even saying that in the test name (bad practice, in my
opinion), and the comment above this test says the following:

  # the verify tests below expect the commit-graph to contain
  # exactly the commits reachable from the commits/8 branch.
  # If the file changes the set of commits in the list, then the
  # offsets into the binary file will result in different edits
  # and the tests will likely break.

So the following tests are fragile (though perhaps unavoidably fragile),
and without this change they would not work, I assume.

> +	graph_read_expect 9 extra_edges

I guess that this is here to check that GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1
work as intended, and that the following "verify" tests wouldn't break.
I understand its necessity, even if I don't quite like having a test
that checks multiple things.  This is a minor issue, though.

All right.


We might want to have a separate test that checks that we get
commit-graph with and without GDAT chunk depending on whether we use
GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1.  On the other hand, this environment
variable is there purely for tests, so the question is should we test
the test infrastructure?

>  '
>=20=20
>  NUM_COMMITS=3D9
> @@ -741,4 +742,47 @@ test_expect_success 'corrupt commit-graph write (mis=
sing tree)' '
>  	)
>  '
>=20=20
> +test_commit_with_date() {
> +  file=3D"$1.t" &&
> +  echo "$1" >"$file" &&
> +  git add "$file" &&
> +  GIT_COMMITTER_DATE=3D"$2" GIT_AUTHOR_DATE=3D"$2" git commit -m "$1"
> +  git tag "$1"
> +}

Here we add a helper function.  All right.

I wonder though if it wouldn't be a better idea to add `--date <date>`
option to the test_commit() function in test-lib-functions.sh (which
option would set GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, and also
set notick=3Dyes).

For example:

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f1ae935fee..a1f9a2b09b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -202,6 +202,12 @@ test_commit () {
 		--signoff)
 			signoff=3D"$1"
 			;;
+        --date)
+            notick=3Dyes
+            GIT_COMMITTER_DATE=3D"$2"
+            GIT_AUTHOR_DATE=3D"$2"
+            shift
+            ;;
 		-C)
 			indir=3D"$2"
 			shift


> +

It would be nice to have there comment describing the shape of the
revision history we generate here, that currenly is present only in the
commmit message.

# We test the overflow-related code with the following repo history:
#
#               4:F - 5:N - 6:U
#              /               \
# 1:U - 2:N - 3:U               M:N
#              \               /
#               7:N - 8:F - 9:N
#
# Here the commits denoted by U have committer date of zero seconds
# since Unix epoch, the commits denoted by N have committer date
# starting from 1112354055 seconds since Unix epoch (default committer
# date for the test suite), and the commits denoted by F have committer
# date of (2 ^ 31 - 2) seconds since Unix epoch.
#
# The largest offset observed is 2 ^ 31, just large enough to overflow.
#

> +test_expect_success 'overflow corrected commit date offset' '
> +	objdir=3D".git/objects" &&
> +	UNIX_EPOCH_ZERO=3D"1970-01-01 00:00 +0000" &&
> +	FUTURE_DATE=3D"@2147483646 +0000" &&

It is a bit funny to see UNIX_EPOCH_ZERO spelled one way, and
FUTURE_DATE other way.

Wouldn't be more readable to use UNIX_EPOCH_ZERO=3D"@0 +0000"?

> +	test_oid_cache <<-EOF &&
> +	oid_version sha1:1
> +	oid_version sha256:2
> +	EOF
> +	cd "$TRASH_DIRECTORY" &&
> +	mkdir repo &&
> +	cd repo &&
> +	git init &&
> +	test_commit_with_date 1 "$UNIX_EPOCH_ZERO" &&
> +	test_commit 2 &&
> +	test_commit_with_date 3 "$UNIX_EPOCH_ZERO" &&
> +	git commit-graph write --reachable &&
> +	graph_read_expect 3 generation_data &&
> +	test_commit_with_date 4 "$FUTURE_DATE" &&
> +	test_commit 5 &&
> +	test_commit_with_date 6 "$UNIX_EPOCH_ZERO" &&
> +	git branch left &&
> +	git reset --hard 3 &&
> +	test_commit 7 &&
> +	test_commit_with_date 8 "$FUTURE_DATE" &&
> +	test_commit 9 &&
> +	git branch right &&
> +	git reset --hard 3 &&
> +	git merge left right &&

We have test_merge() function in test-lib-functions.sh, perhaps we
should use it here.

> +	git commit-graph write --reachable &&
> +	graph_read_expect 10 "generation_data generation_data_overflow" &&

All right, we write the commit-graph and check that it has both GDAT and
GDOV chunks present.

> +	git commit-graph verify

All right, we checks that created commit graph with GDAT and GDOV passes
'git commit-graph verify` checks.

> +'
> +
> +graph_git_behavior 'overflow corrected commit date offset' repo left rig=
ht

All right, here we compare the Git behavior with the commit-graph to the
behavior without it... however I think that those two tests really
should have distinct (different) test names. Currently they both use
'overflow corrected commit date offset'.

> +
>  test_done
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index c334ee9155..651df89ab2 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -13,11 +13,11 @@ test_expect_success 'setup repo' '
>  	infodir=3D".git/objects/info" &&
>  	graphdir=3D"$infodir/commit-graphs" &&
>  	test_oid_cache <<-EOM
> -	shallow sha1:1760
> -	shallow sha256:2064
> +	shallow sha1:2132
> +	shallow sha256:2436
>=20=20
> -	base sha1:1376
> -	base sha256:1496
> +	base sha1:1408
> +	base sha256:1528
>=20=20
>  	oid_version sha1:1
>  	oid_version sha256:2
> @@ -31,9 +31,9 @@ graph_read_expect() {
>  		NUM_BASE=3D$2
>  	fi
>  	cat >expect <<- EOF
> -	header: 43475048 1 $(test_oid oid_version) 3 $NUM_BASE
> +	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
>  	num_commits: $1
> -	chunks: oid_fanout oid_lookup commit_metadata
> +	chunks: oid_fanout oid_lookup commit_metadata generation_data
>  	EOF
>  	test-tool read-graph >output &&
>  	test_cmp expect output

All right, we now expect the commit graph to include the GDAT chunk...
though shouldn't be there old expected value for no GDAT, for future
tests?  But perhaps this is not necessary.

Note that I have not checked the details, but it looks OK to me.

> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index f807276337..e2d33a8a4c 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -55,10 +55,13 @@ test_expect_success 'setup' '
>  	git show-ref -s commit-5-5 | git commit-graph write --stdin-commits &&
>  	mv .git/objects/info/commit-graph commit-graph-half &&
>  	chmod u+w commit-graph-half &&
> +	GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1 git commit-graph write --reachable &&
> +	mv .git/objects/info/commit-graph commit-graph-no-gdat &&
> +	chmod u+w commit-graph-no-gdat &&

All right, this prepares for testing one more mode.  The run_all_modes()
function would test the following cases:
 - no commit-graph
 - commit-graph for all commits, with GDAT
 - commit-graph with half of commits, with GDAT
 - commit-graph for all commits, without GDAT

>  	git config core.commitGraph true
>  '
>=20=20
> -run_three_modes () {
> +run_all_modes () {
>  	test_when_finished rm -rf .git/objects/info/commit-graph &&
>  	"$@" <input >actual &&
>  	test_cmp expect actual &&
> @@ -67,11 +70,14 @@ run_three_modes () {
>  	test_cmp expect actual &&
>  	cp commit-graph-half .git/objects/info/commit-graph &&
>  	"$@" <input >actual &&
> +	test_cmp expect actual &&
> +	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
> +	"$@" <input >actual &&
>  	test_cmp expect actual
>  }
>=20=20
> -test_three_modes () {
> -	run_three_modes test-tool reach "$@"
> +test_all_modes () {
> +	run_all_modes test-tool reach "$@"
>  }

All right.

Though to reduce "noise" in this patch, the rename of run_three_modes()
to run_all_modes() and test_three_modes() to test_all_modes() could have
been done in a separate preparatory patch.  It would be pure refactoring
patch, without introducing any new functionality.

>=20=20
>  test_expect_success 'ref_newer:miss' '
> @@ -80,7 +86,7 @@ test_expect_success 'ref_newer:miss' '
>  	B:commit-4-9
>  	EOF
>  	echo "ref_newer(A,B):0" >expect &&
> -	test_three_modes ref_newer
> +	test_all_modes ref_newer
>  '
>=20=20
>  test_expect_success 'ref_newer:hit' '
> @@ -89,7 +95,7 @@ test_expect_success 'ref_newer:hit' '
>  	B:commit-2-3
>  	EOF
>  	echo "ref_newer(A,B):1" >expect &&
> -	test_three_modes ref_newer
> +	test_all_modes ref_newer
>  '
>=20=20
>  test_expect_success 'in_merge_bases:hit' '
> @@ -98,7 +104,7 @@ test_expect_success 'in_merge_bases:hit' '
>  	B:commit-8-8
>  	EOF
>  	echo "in_merge_bases(A,B):1" >expect &&
> -	test_three_modes in_merge_bases
> +	test_all_modes in_merge_bases
>  '
>=20=20
>  test_expect_success 'in_merge_bases:miss' '
> @@ -107,7 +113,7 @@ test_expect_success 'in_merge_bases:miss' '
>  	B:commit-5-9
>  	EOF
>  	echo "in_merge_bases(A,B):0" >expect &&
> -	test_three_modes in_merge_bases
> +	test_all_modes in_merge_bases
>  '
>=20=20
>  test_expect_success 'in_merge_bases_many:hit' '
> @@ -117,7 +123,7 @@ test_expect_success 'in_merge_bases_many:hit' '
>  	X:commit-5-7
>  	EOF
>  	echo "in_merge_bases_many(A,X):1" >expect &&
> -	test_three_modes in_merge_bases_many
> +	test_all_modes in_merge_bases_many
>  '
>=20=20
>  test_expect_success 'in_merge_bases_many:miss' '
> @@ -127,7 +133,7 @@ test_expect_success 'in_merge_bases_many:miss' '
>  	X:commit-8-6
>  	EOF
>  	echo "in_merge_bases_many(A,X):0" >expect &&
> -	test_three_modes in_merge_bases_many
> +	test_all_modes in_merge_bases_many
>  '
>=20=20
>  test_expect_success 'in_merge_bases_many:miss-heuristic' '
> @@ -137,7 +143,7 @@ test_expect_success 'in_merge_bases_many:miss-heurist=
ic' '
>  	X:commit-6-6
>  	EOF
>  	echo "in_merge_bases_many(A,X):0" >expect &&
> -	test_three_modes in_merge_bases_many
> +	test_all_modes in_merge_bases_many
>  '
>=20=20
>  test_expect_success 'is_descendant_of:hit' '
> @@ -148,7 +154,7 @@ test_expect_success 'is_descendant_of:hit' '
>  	X:commit-1-1
>  	EOF
>  	echo "is_descendant_of(A,X):1" >expect &&
> -	test_three_modes is_descendant_of
> +	test_all_modes is_descendant_of
>  '
>=20=20
>  test_expect_success 'is_descendant_of:miss' '
> @@ -159,7 +165,7 @@ test_expect_success 'is_descendant_of:miss' '
>  	X:commit-7-6
>  	EOF
>  	echo "is_descendant_of(A,X):0" >expect &&
> -	test_three_modes is_descendant_of
> +	test_all_modes is_descendant_of
>  '
>=20=20
>  test_expect_success 'get_merge_bases_many' '
> @@ -174,7 +180,7 @@ test_expect_success 'get_merge_bases_many' '
>  		git rev-parse commit-5-6 \
>  			      commit-4-7 | sort
>  	} >expect &&
> -	test_three_modes get_merge_bases_many
> +	test_all_modes get_merge_bases_many
>  '
>=20=20
>  test_expect_success 'reduce_heads' '
> @@ -196,7 +202,7 @@ test_expect_success 'reduce_heads' '
>  			      commit-2-8 \
>  			      commit-1-10 | sort
>  	} >expect &&
> -	test_three_modes reduce_heads
> +	test_all_modes reduce_heads
>  '
>=20=20
>  test_expect_success 'can_all_from_reach:hit' '
> @@ -219,7 +225,7 @@ test_expect_success 'can_all_from_reach:hit' '
>  	Y:commit-8-1
>  	EOF
>  	echo "can_all_from_reach(X,Y):1" >expect &&
> -	test_three_modes can_all_from_reach
> +	test_all_modes can_all_from_reach
>  '
>=20=20
>  test_expect_success 'can_all_from_reach:miss' '
> @@ -241,7 +247,7 @@ test_expect_success 'can_all_from_reach:miss' '
>  	Y:commit-8-5
>  	EOF
>  	echo "can_all_from_reach(X,Y):0" >expect &&
> -	test_three_modes can_all_from_reach
> +	test_all_modes can_all_from_reach
>  '
>=20=20
>  test_expect_success 'can_all_from_reach_with_flag: tags case' '
> @@ -264,7 +270,7 @@ test_expect_success 'can_all_from_reach_with_flag: ta=
gs case' '
>  	Y:commit-8-1
>  	EOF
>  	echo "can_all_from_reach_with_flag(X,_,_,0,0):1" >expect &&
> -	test_three_modes can_all_from_reach_with_flag
> +	test_all_modes can_all_from_reach_with_flag
>  '
>=20=20
>  test_expect_success 'commit_contains:hit' '
> @@ -280,8 +286,8 @@ test_expect_success 'commit_contains:hit' '
>  	X:commit-9-3
>  	EOF
>  	echo "commit_contains(_,A,X,_):1" >expect &&
> -	test_three_modes commit_contains &&
> -	test_three_modes commit_contains --tag
> +	test_all_modes commit_contains &&
> +	test_all_modes commit_contains --tag
>  '
>=20=20
>  test_expect_success 'commit_contains:miss' '
> @@ -297,8 +303,8 @@ test_expect_success 'commit_contains:miss' '
>  	X:commit-9-3
>  	EOF
>  	echo "commit_contains(_,A,X,_):0" >expect &&
> -	test_three_modes commit_contains &&
> -	test_three_modes commit_contains --tag
> +	test_all_modes commit_contains &&
> +	test_all_modes commit_contains --tag
>  '
>=20=20
>  test_expect_success 'rev-list: basic topo-order' '
> @@ -310,7 +316,7 @@ test_expect_success 'rev-list: basic topo-order' '
>  		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
>  		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
>  	>expect &&
> -	run_three_modes git rev-list --topo-order commit-6-6
> +	run_all_modes git rev-list --topo-order commit-6-6
>  '
>=20=20
>  test_expect_success 'rev-list: first-parent topo-order' '
> @@ -322,7 +328,7 @@ test_expect_success 'rev-list: first-parent topo-orde=
r' '
>  		commit-6-2 \
>  		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
>  	>expect &&
> -	run_three_modes git rev-list --first-parent --topo-order commit-6-6
> +	run_all_modes git rev-list --first-parent --topo-order commit-6-6
>  '
>=20=20
>  test_expect_success 'rev-list: range topo-order' '
> @@ -334,7 +340,7 @@ test_expect_success 'rev-list: range topo-order' '
>  		commit-6-2 commit-5-2 commit-4-2 \
>  		commit-6-1 commit-5-1 commit-4-1 \
>  	>expect &&
> -	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
> +	run_all_modes git rev-list --topo-order commit-3-3..commit-6-6
>  '
>=20=20
>  test_expect_success 'rev-list: range topo-order' '
> @@ -346,7 +352,7 @@ test_expect_success 'rev-list: range topo-order' '
>  		commit-6-2 commit-5-2 commit-4-2 \
>  		commit-6-1 commit-5-1 commit-4-1 \
>  	>expect &&
> -	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
> +	run_all_modes git rev-list --topo-order commit-3-8..commit-6-6
>  '
>=20=20
>  test_expect_success 'rev-list: first-parent range topo-order' '
> @@ -358,7 +364,7 @@ test_expect_success 'rev-list: first-parent range top=
o-order' '
>  		commit-6-2 \
>  		commit-6-1 commit-5-1 commit-4-1 \
>  	>expect &&
> -	run_three_modes git rev-list --first-parent --topo-order commit-3-8..co=
mmit-6-6
> +	run_all_modes git rev-list --first-parent --topo-order commit-3-8..comm=
it-6-6
>  '
>=20=20
>  test_expect_success 'rev-list: ancestry-path topo-order' '
> @@ -368,7 +374,7 @@ test_expect_success 'rev-list: ancestry-path topo-ord=
er' '
>  		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
>  		commit-6-3 commit-5-3 commit-4-3 \
>  	>expect &&
> -	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..c=
ommit-6-6
> +	run_all_modes git rev-list --topo-order --ancestry-path commit-3-3..com=
mit-6-6
>  '
>=20=20
>  test_expect_success 'rev-list: symmetric difference topo-order' '
> @@ -382,7 +388,7 @@ test_expect_success 'rev-list: symmetric difference t=
opo-order' '
>  		commit-3-8 commit-2-8 commit-1-8 \
>  		commit-3-7 commit-2-7 commit-1-7 \
>  	>expect &&
> -	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
> +	run_all_modes git rev-list --topo-order commit-3-8...commit-6-6
>  '
>=20=20
>  test_expect_success 'get_reachable_subset:all' '
> @@ -402,7 +408,7 @@ test_expect_success 'get_reachable_subset:all' '
>  			      commit-1-7 \
>  			      commit-5-6 | sort
>  	) >expect &&
> -	test_three_modes get_reachable_subset
> +	test_all_modes get_reachable_subset
>  '
>=20=20
>  test_expect_success 'get_reachable_subset:some' '
> @@ -420,7 +426,7 @@ test_expect_success 'get_reachable_subset:some' '
>  		git rev-parse commit-3-3 \
>  			      commit-1-7 | sort
>  	) >expect &&
> -	test_three_modes get_reachable_subset
> +	test_all_modes get_reachable_subset
>  '
>=20=20
>  test_expect_success 'get_reachable_subset:none' '
> @@ -434,7 +440,7 @@ test_expect_success 'get_reachable_subset:none' '
>  	Y:commit-2-8
>  	EOF
>  	echo "get_reachable_subset(X,Y)" >expect &&
> -	test_three_modes get_reachable_subset
> +	test_all_modes get_reachable_subset

All those are pure renames of test_three_modes() to test_all_modes(),
which now does tests for one more mode -- without GDAT.

All right.

>  '
>=20=20
>  test_done

Best,
--=20
Jakub Nar=C4=99bski
