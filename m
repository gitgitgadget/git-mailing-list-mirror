Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F38C433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097672078E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="rW/fPNFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbgG1QMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbgG1QMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:12:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EEFC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:12:53 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 11so19204089qkn.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yMktkal7FzjiGVE7CkeNVGEnSJrVang4aCOCinWH9Fc=;
        b=rW/fPNFCIVwYuU+5bexcOjcdKm38m8CnbipFj0aTtagMw60ZkfdEMnuqQbrntYg9sz
         V5691DmHRCKJzjqjA5D4qyHAXJuJmLr4/ha+wagPOQyi7VQKuvp0u3dJZyUkjec80X5l
         FYtfsevnEedc6ulXZV5tvzCmql1txsHpYcBvyrA4X4AQKoB3s+pNU8fzOH578hLjNpj/
         PQhljjG0ZN01nZF6TTKHUWlWn9e29xQBOtf5WXJuuGuyhKpFPS5zj26Fc8Xwl6jwq1GL
         AnedAXDsCjmT7J7uVQxajbqw2vXMyFrirO454QmhhNvdm3fbVpfEINJi4Q5txczdILY3
         agQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yMktkal7FzjiGVE7CkeNVGEnSJrVang4aCOCinWH9Fc=;
        b=fKhYbsa2hL//Gmt5mNRuOL3q4ezNM9/2dIG4DZ7mktxv53kLLIOwJIfQZfBjBLjmky
         nWggu7EUZPLhwijKgSKWr0PBTbqEy/Y7a3QLLnpNVWa/Etb/YV+tHDzwAvR7le7xUt/o
         K2/wJCgIh9rmuLGPcjjNGsI34xyrQ40s8Yv7TbpHpwe0ZD1C1IVWBk7zes1ggH/9irMF
         STddzQX+Ud/u/V5Aa5IoW1lAocLK7M1FhF2ipy5R8wgaXCDJG/yss9n0zQ8rjqv8404w
         AdI3Z6XgGInK2SLGFy70oNGODeXD91Xf2f1KFukAIXM7l3Sn+kgNiNhGvC3Xkuo42Q1a
         hOAw==
X-Gm-Message-State: AOAM530HZZ5UZIMrWhG8MdyGK1rEblRC0yh5f70yf0F+KHxvmNCYZFyn
        vFb7fbl+y3796quptBR2cR1PSg==
X-Google-Smtp-Source: ABdhPJyrUR9VH0OeUexIgn4YcUtcKoJw4xfp0jLvfB++6q1O9DlksQEFpAebdmHnCqsOGmlbBBEy1A==
X-Received: by 2002:a05:620a:4d9:: with SMTP id 25mr23933200qks.411.1595952772514;
        Tue, 28 Jul 2020 09:12:52 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id f189sm21655523qke.15.2020.07.28.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 09:12:51 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:12:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH 5/6] commit-graph: implement generation data chunk
Message-ID: <20200728161250.GF87373@syl.lan>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <80ea7da3435396edcb19423ab602962d31585209.1595927632.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80ea7da3435396edcb19423ab602962d31585209.1595927632.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 09:13:50AM +0000, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> One of the essential pre-requisites before implementing generation
> number as to distinguish between generation numbers v1 and v2 while

s/as/is

> still being compatible with old Git.

Maybe you could add a section here to talk about why this is needed
specifically? That is, you mention it's a prerequisite, but a reader in
a year or two may not remember why. Adding that information here would
be good.

> We are going to introduce a new chunk called Generation Data chunk (or
> GDAT). GDAT stores generation number v2 (and any subsequent versions),
> whereas CDAT will still store topological level.
>
> Old Git does not understand GDAT chunk and would ignore it, reading
> topological levels from CDAT. Newer versions of Git can parse GDAT and
> take advantage of newer generation numbers, falling back to topological
> levels when GDAT chunk is missing (as it would happen with a commit
> graph written by old Git).

...this is exactly the paragraph that I was looking for above. Could you
swap the order of these last two paragraphs? I think that it would make
the patch message far clearer.
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c                | 33 +++++++++++++++++++++++++++++----
>  commit-graph.h                |  1 +
>  t/helper/test-read-graph.c    |  2 ++
>  t/t4216-log-bloom.sh          |  4 ++--
>  t/t5318-commit-graph.sh       | 19 +++++++++++--------
>  t/t5324-split-commit-graph.sh | 12 ++++++------
>  6 files changed, 51 insertions(+), 20 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 1c98f38d69..ab714f4a76 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -38,11 +38,12 @@ void git_test_write_commit_graph_or_die(void)
>  #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
>  #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
>  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
> +#define GRAPH_CHUNKID_GENERATION_DATA 0x47444154 /* "GDAT" */
>  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
>  #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
>  #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
>  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
> -#define MAX_NUM_CHUNKS 7
> +#define MAX_NUM_CHUNKS 8

Ugh. I am simultaneously working on a new chunk myself (so a bad
conflict resolution would look at both of us incrementing this number
to the same value without generating a conflict.)

I think the right thing to do here would be to define an enum over chunk
names, and then index an array by that enum (where the value at each
index is the chunk identifier). Then, the last value of that enum would
be a '__COUNT' which you could use to initialize the array (as well as
within the commit-graph writing routines).

Anyway, I think that it's probably not worth it in the meantime, but it
is something that Junio should look out for when merging (if yours and
my topic happen to get merged around the same time, which they may not).

>  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
>
> @@ -389,6 +390,13 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size)
>  				graph->chunk_commit_data = data + chunk_offset;
>  			break;
>
> +		case GRAPH_CHUNKID_GENERATION_DATA:
> +			if (graph->chunk_generation_data)
> +				chunk_repeated = 1;
> +			else
> +				graph->chunk_generation_data = data + chunk_offset;
> +			break;
> +
>  		case GRAPH_CHUNKID_EXTRAEDGES:
>  			if (graph->chunk_extra_edges)
>  				chunk_repeated = 1;
> @@ -768,7 +776,10 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
>  	date_low = get_be32(commit_data + g->hash_len + 12);
>  	item->date = (timestamp_t)((date_high << 32) | date_low);
>
> -	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> +	if (g->chunk_generation_data)
> +		graph_data->generation = get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
> +	else
> +		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
>  }
>
>  static inline void set_commit_tree(struct commit *c, struct tree *t)
> @@ -1100,6 +1111,17 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>  	}
>  }
>
> +static void write_graph_chunk_generation_data(struct hashfile *f,
> +					      struct write_commit_graph_context *ctx)
> +{
> +	struct commit **list = ctx->commits.list;
> +	int count;
> +	for (count = 0; count < ctx->commits.nr; count++, list++) {
> +		display_progress(ctx->progress, ++ctx->progress_cnt);
> +		hashwrite_be32(f, commit_graph_data_at(*list)->generation);
> +	}
> +}
> +

This pointer arithmetic is not necessary. Why not like:

  int i;
  for (i = 0; i < ctx->commits.nr; i++) {
    struct commit *c = ctx->commits.list[i];
    display_progress(ctx->progress, ++ctx->progress_cnt);
    hashwrite_be32(f, commit_graph_data_at(c)->generation);
  }

instead?

>  static void write_graph_chunk_extra_edges(struct hashfile *f,
>  					  struct write_commit_graph_context *ctx)
>  {
> @@ -1605,7 +1627,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  	uint64_t chunk_offsets[MAX_NUM_CHUNKS + 1];
>  	const unsigned hashsz = the_hash_algo->rawsz;
>  	struct strbuf progress_title = STRBUF_INIT;
> -	int num_chunks = 3;
> +	int num_chunks = 4;
>  	struct object_id file_hash;
>  	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
>
> @@ -1656,6 +1678,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
>  	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
>  	chunk_ids[2] = GRAPH_CHUNKID_DATA;
> +	chunk_ids[3] = GRAPH_CHUNKID_GENERATION_DATA;
>  	if (ctx->num_extra_edges) {
>  		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
>  		num_chunks++;
> @@ -1677,8 +1700,9 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
>  	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
>  	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
> +	chunk_offsets[4] = chunk_offsets[3] + sizeof(uint32_t) * ctx->commits.nr;
>
> -	num_chunks = 3;
> +	num_chunks = 4;
>  	if (ctx->num_extra_edges) {
>  		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
>  						4 * ctx->num_extra_edges;
> @@ -1728,6 +1752,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  	write_graph_chunk_fanout(f, ctx);
>  	write_graph_chunk_oids(f, hashsz, ctx);
>  	write_graph_chunk_data(f, hashsz, ctx);
> +	write_graph_chunk_generation_data(f, ctx);
>  	if (ctx->num_extra_edges)
>  		write_graph_chunk_extra_edges(f, ctx);
>  	if (ctx->changed_paths) {
> diff --git a/commit-graph.h b/commit-graph.h
> index 98cc5a3b9d..e3d4ba96f4 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -67,6 +67,7 @@ struct commit_graph {
>  	const uint32_t *chunk_oid_fanout;
>  	const unsigned char *chunk_oid_lookup;
>  	const unsigned char *chunk_commit_data;
> +	const unsigned char *chunk_generation_data;
>  	const unsigned char *chunk_extra_edges;
>  	const unsigned char *chunk_base_graphs;
>  	const unsigned char *chunk_bloom_indexes;
> diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
> index 6d0c962438..1c2a5366c7 100644
> --- a/t/helper/test-read-graph.c
> +++ b/t/helper/test-read-graph.c
> @@ -32,6 +32,8 @@ int cmd__read_graph(int argc, const char **argv)
>  		printf(" oid_lookup");
>  	if (graph->chunk_commit_data)
>  		printf(" commit_metadata");
> +	if (graph->chunk_generation_data)
> +		printf(" generation_data");
>  	if (graph->chunk_extra_edges)
>  		printf(" extra_edges");
>  	if (graph->chunk_bloom_indexes)
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index c855bcd3e7..780855e691 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -33,11 +33,11 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
>  	git commit-graph write --reachable --changed-paths
>  '
>  graph_read_expect () {
> -	NUM_CHUNKS=5
> +	NUM_CHUNKS=6
>  	cat >expect <<- EOF
>  	header: 43475048 1 1 $NUM_CHUNKS 0
>  	num_commits: $1
> -	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
> +	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
>  	EOF
>  	test-tool read-graph >actual &&
>  	test_cmp expect actual
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 26f332d6a3..3ec5248d70 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -71,16 +71,16 @@ graph_git_behavior 'no graph' full commits/3 commits/1
>
>  graph_read_expect() {
>  	OPTIONAL=""
> -	NUM_CHUNKS=3
> +	NUM_CHUNKS=4
>  	if test ! -z $2
>  	then
>  		OPTIONAL=" $2"
> -		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
> +		NUM_CHUNKS=$((4 + $(echo "$2" | wc -w)))
>  	fi
>  	cat >expect <<- EOF
>  	header: 43475048 1 1 $NUM_CHUNKS 0
>  	num_commits: $1
> -	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
> +	chunks: oid_fanout oid_lookup commit_metadata generation_data$OPTIONAL
>  	EOF
>  	test-tool read-graph >output &&
>  	test_cmp expect output
> @@ -433,7 +433,7 @@ GRAPH_BYTE_HASH=5
>  GRAPH_BYTE_CHUNK_COUNT=6
>  GRAPH_CHUNK_LOOKUP_OFFSET=8
>  GRAPH_CHUNK_LOOKUP_WIDTH=12
> -GRAPH_CHUNK_LOOKUP_ROWS=5
> +GRAPH_CHUNK_LOOKUP_ROWS=6
>  GRAPH_BYTE_OID_FANOUT_ID=$GRAPH_CHUNK_LOOKUP_OFFSET
>  GRAPH_BYTE_OID_LOOKUP_ID=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
>  			    1 * $GRAPH_CHUNK_LOOKUP_WIDTH))
> @@ -451,11 +451,14 @@ GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
>  GRAPH_BYTE_COMMIT_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
>  GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4))
>  GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3))
> -GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 11))
>  GRAPH_BYTE_COMMIT_DATE=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
>  GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
> -GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
> -			     $GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
> +GRAPH_GENERATION_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
> +				$GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
> +GRAPH_GENERATION_DATA_WIDTH=4
> +GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_GENERATION_DATA_OFFSET + 3))
> +GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_GENERATION_DATA_OFFSET + \
> +			     $GRAPH_GENERATION_DATA_WIDTH * $NUM_COMMITS))
>  GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
>  GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
>
> @@ -594,7 +597,7 @@ test_expect_success 'detect incorrect generation number' '
>  '
>
>  test_expect_success 'detect incorrect generation number' '
> -	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
> +	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\00" \
>  		"non-zero generation number"
>  '
>
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 269d0964a3..096a96ec41 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -14,11 +14,11 @@ test_expect_success 'setup repo' '
>  	graphdir="$infodir/commit-graphs" &&
>  	test_oid_init &&
>  	test_oid_cache <<-EOM
> -	shallow sha1:1760
> -	shallow sha256:2064
> +	shallow sha1:2132
> +	shallow sha256:2436
>
> -	base sha1:1376
> -	base sha256:1496
> +	base sha1:1408
> +	base sha256:1528
>  	EOM
>  '
>
> @@ -29,9 +29,9 @@ graph_read_expect() {
>  		NUM_BASE=$2
>  	fi
>  	cat >expect <<- EOF
> -	header: 43475048 1 1 3 $NUM_BASE
> +	header: 43475048 1 1 4 $NUM_BASE
>  	num_commits: $1
> -	chunks: oid_fanout oid_lookup commit_metadata
> +	chunks: oid_fanout oid_lookup commit_metadata generation_data
>  	EOF
>  	test-tool read-graph >output &&
>  	test_cmp expect output
> --
> gitgitgadget
>

All of this looks good to me.

Thanks,
Taylor
