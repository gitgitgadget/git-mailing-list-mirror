Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41685C43381
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C0664EE4
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhBEWM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhBEOmy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:42:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4CDC061222
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:20:07 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lg21so12822330ejb.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sK2GKptTtXPn+p8kdpWj48PJgUgLLdRl8nhFEENrAxQ=;
        b=NSyuqyPExDjbItqh3PHHSfIBfwoFGnBNhdXkp5I9UA4KIuzfRzs84kh50lq7hqhJZ4
         KddlsdKrpquecqavsByhAWnBvGmMTzRc+0k7e3yG6fPZiksJrQ6tnj279Idp96dJO1zQ
         LPVbwLGFpNYJ3Klt0NyieDB4BqinuQgQESSTaVAvf+x9UHizGqTToVK58fdjqUYLuRVb
         Pc96+om4a0iMfEpjpBcRr4kcJQQeBsYZWRBLjeWzSeVxNfC9shJbXA0QLooRWZ+P89cd
         xAZ0Chr7U3q/JA0MlIXpr6tMvyORX6xU6+knHaoSh5vKpeWbRqqURxMreHQi2/OoV8ki
         n0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sK2GKptTtXPn+p8kdpWj48PJgUgLLdRl8nhFEENrAxQ=;
        b=l3KrxiFOF6sXUK5+0jJiIn8G6OQemyK8U06bMdH3VhSNGVpeUjVcaGkHxJcL/7jlWH
         7wrpvHJn8TQQe51eUAZZgl8FHeQRveHhB62RKPzTOyI0/ygwggTabNqDbLKxRA6Qyekm
         dZ0wnd92cEuNkj7EvxP6kQ0kSH1UG0RZpDXVs5OIr4gBtG2oUbT/YmLfDrQNDazB4QXo
         aj3AT7slD2frajoqitctmFewxf3vhGjAgmCq83IKOQ15d+bu86PV9AmxYmh4BYm4CVNj
         hgXs3BP37RQAAc4yXPHSTUw6jGGYaA1flf85I/3RfItzFRsbUBcd/3l5WSA91vsHSkgk
         WH8w==
X-Gm-Message-State: AOAM5331SSUWA3asG2bwG0EVTrnS3FXZHxep0NlF8oV9D3DX7wLkWHjw
        xZhZVM1DbiAtOkHhNhAdL1SlfENzghU=
X-Google-Smtp-Source: ABdhPJxxbj6KkaQmR2jZ+LKqgNbyFMVyOyH9Ld64fl5JQ1MA+xvtecEVman3hEX99crr8XZw82fvJQ==
X-Received: by 2002:a05:6000:48:: with SMTP id k8mr5487472wrx.340.1612535454417;
        Fri, 05 Feb 2021 06:30:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm12671584wrw.9.2021.02.05.06.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:30:53 -0800 (PST)
Message-Id: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:35 +0000
Subject: [PATCH v3 00/17] Refactor chunk-format into an API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a restart on the topic previously submitted [1] but dropped because
ak/corrected-commit-date was still in progress. This version is based on
that branch.

[1]
https://lore.kernel.org/git/pull.804.git.1607012215.gitgitgadget@gmail.com/

This version also changes the approach to use a more dynamic interaction
with a struct chunkfile pointer. This idea is credited to Taylor Blau [2],
but I started again from scratch. I also go further to make struct chunkfile
anonymous to API consumers. It is defined only in chunk-format.c, which
should hopefully deter future users from interacting with that data
directly.

[2] https://lore.kernel.org/git/X8%2FI%2FRzXZksio+ri@nand.local/

This combined API is beneficial to reduce duplicated logic. Or rather, to
ensure that similar file formats have similar protections against bad data.
The multi-pack-index code did not have as many guards as the commit-graph
code did, but now they both share a common base that checks for things like
duplicate chunks or offsets outside the size of the file.

Here are some stats for the end-to-end change:

 * 570 insertions(+), 456 deletions(-).
 * commit-graph.c: 107 insertions(+), 192 deletions(-)
 * midx.c: 164 insertions(+), 260 deletions(-)

While there is an overall increase to the code size, the consumers do get
smaller. Boilerplate things like abstracting method to match chunk_write_fn
and chunk_read_fn make up a lot of these insertions. The "interesting" code
gets a lot smaller and cleaner.


Updates in V3
=============

 * API methods use better types and changed their order to match internal
   data more closely.

 * Use hashfile_total() instead of internal data values.

 * The implementation of pair_chunk() uses read_chunk().

 * init_chunkfile() has an in-code doc comment warning against using the
   same struct chunkfile for reads and writes.

 * More multiplications are correctly cast in midx.c.

 * The chunk-format technical docs are expanded.


Updates in V2
=============

 * The method pair_chunk() now automatically sets a pointer while
   read_chunk() uses the callback. This greatly reduces the code size.

 * Pointer casts are now implicit instead of explicit.

 * Extra care is taken to not overflow when verifying chunk sizes on write.

Thanks, -Stolee

Derrick Stolee (17):
  commit-graph: anonymize data in chunk_write_fn
  chunk-format: create chunk format write API
  commit-graph: use chunk-format write API
  midx: rename pack_info to write_midx_context
  midx: use context in write_midx_pack_names()
  midx: add entries to write_midx_context
  midx: add pack_perm to write_midx_context
  midx: add num_large_offsets to write_midx_context
  midx: return success/failure in chunk write methods
  midx: drop chunk progress during write
  midx: use chunk-format API in write_midx_internal()
  chunk-format: create read chunk API
  commit-graph: use chunk-format read API
  midx: use chunk-format read API
  midx: use 64-bit multiplication for chunk sizes
  chunk-format: restore duplicate chunk checks
  chunk-format: add technical docs

 Documentation/technical/chunk-format.txt      | 116 +++++
 .../technical/commit-graph-format.txt         |   3 +
 Documentation/technical/pack-format.txt       |   3 +
 Makefile                                      |   1 +
 chunk-format.c                                | 180 ++++++++
 chunk-format.h                                |  65 +++
 commit-graph.c                                | 299 +++++-------
 midx.c                                        | 431 +++++++-----------
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5319-multi-pack-index.sh                   |   6 +-
 10 files changed, 648 insertions(+), 458 deletions(-)
 create mode 100644 Documentation/technical/chunk-format.txt
 create mode 100644 chunk-format.c
 create mode 100644 chunk-format.h


base-commit: 5a3b130cad0d5c770f766e3af6d32b41766374c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-848%2Fderrickstolee%2Fchunk-format%2Frefactor-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-848/derrickstolee/chunk-format/refactor-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/848

Range-diff vs v2:

  1:  243dcec94368 =  1:  243dcec94368 commit-graph: anonymize data in chunk_write_fn
  2:  814512f21671 !  2:  16c37d2370cf chunk-format: create chunk format write API
     @@ Commit message
           5. free the chunkfile struct using free_chunkfile().
      
          Helped-by: Taylor Blau <me@ttaylorr.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Makefile ##
     @@ chunk-format.c (new)
      +}
      +
      +void add_chunk(struct chunkfile *cf,
     -+	       uint64_t id,
     -+	       chunk_write_fn fn,
     -+	       size_t size)
     ++	       uint32_t id,
     ++	       size_t size,
     ++	       chunk_write_fn fn)
      +{
      +	ALLOC_GROW(cf->chunks, cf->chunks_nr + 1, cf->chunks_alloc);
      +
     @@ chunk-format.c (new)
      +int write_chunkfile(struct chunkfile *cf, void *data)
      +{
      +	int i;
     -+	size_t cur_offset = cf->f->offset + cf->f->total;
     ++	uint64_t cur_offset = hashfile_total(cf->f);
      +
      +	/* Add the table of contents to the current offset */
      +	cur_offset += (cf->chunks_nr + 1) * CHUNK_LOOKUP_WIDTH;
     @@ chunk-format.c (new)
      +	hashwrite_be64(cf->f, cur_offset);
      +
      +	for (i = 0; i < cf->chunks_nr; i++) {
     -+		uint64_t start_offset = cf->f->total + cf->f->offset;
     ++		off_t start_offset = hashfile_total(cf->f);
      +		int result = cf->chunks[i].write_fn(cf->f, data);
      +
      +		if (result)
      +			return result;
      +
     -+		if (cf->f->total + cf->f->offset - start_offset != cf->chunks[i].size)
     ++		if (hashfile_total(cf->f) - start_offset != cf->chunks[i].size)
      +			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
      +			    cf->chunks[i].size, cf->chunks[i].id,
     -+			    cf->f->total + cf->f->offset - start_offset);
     ++			    hashfile_total(cf->f) - start_offset);
      +	}
      +
      +	return 0;
     @@ chunk-format.h (new)
      +struct chunkfile *init_chunkfile(struct hashfile *f);
      +void free_chunkfile(struct chunkfile *cf);
      +int get_num_chunks(struct chunkfile *cf);
     -+typedef int (*chunk_write_fn)(struct hashfile *f,
     -+			      void *data);
     ++typedef int (*chunk_write_fn)(struct hashfile *f, void *data);
      +void add_chunk(struct chunkfile *cf,
     -+	       uint64_t id,
     -+	       chunk_write_fn fn,
     -+	       size_t size);
     ++	       uint32_t id,
     ++	       size_t size,
     ++	       chunk_write_fn fn);
      +int write_chunkfile(struct chunkfile *cf, void *data);
      +
      +#endif
  3:  70af6e3083f4 !  3:  e549e24d79af commit-graph: use chunk-format write API
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      -	chunks[2].write_fn = write_graph_chunk_data;
      +	cf = init_chunkfile(f);
      +
     -+	add_chunk(cf, GRAPH_CHUNKID_OIDFANOUT,
     -+		  write_graph_chunk_fanout, GRAPH_FANOUT_SIZE);
     -+	add_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP,
     -+		  write_graph_chunk_oids, hashsz * ctx->commits.nr);
     -+	add_chunk(cf, GRAPH_CHUNKID_DATA,
     -+		  write_graph_chunk_data, (hashsz + 16) * ctx->commits.nr);
     ++	add_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, GRAPH_FANOUT_SIZE,
     ++		  write_graph_chunk_fanout);
     ++	add_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, hashsz * ctx->commits.nr,
     ++		  write_graph_chunk_oids);
     ++	add_chunk(cf, GRAPH_CHUNKID_DATA, (hashsz + 16) * ctx->commits.nr,
     ++		  write_graph_chunk_data);
       
       	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0))
       		ctx->write_generation_data = 0;
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      -	}
      +	if (ctx->write_generation_data)
      +		add_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
     -+			  write_graph_chunk_generation_data,
     -+			  sizeof(uint32_t) * ctx->commits.nr);
     ++			  sizeof(uint32_t) * ctx->commits.nr,
     ++			  write_graph_chunk_generation_data);
      +	if (ctx->num_generation_data_overflows)
      +		add_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
     -+			  write_graph_chunk_generation_data_overflow,
     -+			  sizeof(timestamp_t) * ctx->num_generation_data_overflows);
     ++			  sizeof(timestamp_t) * ctx->num_generation_data_overflows,
     ++			  write_graph_chunk_generation_data_overflow);
      +	if (ctx->num_extra_edges)
      +		add_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES,
     -+			  write_graph_chunk_extra_edges,
     -+			  4 * ctx->num_extra_edges);
     ++			  4 * ctx->num_extra_edges,
     ++			  write_graph_chunk_extra_edges);
       	if (ctx->changed_paths) {
      -		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMINDEXES;
      -		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      -	chunks[num_chunks].id = 0;
      -	chunks[num_chunks].size = 0;
      +		add_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
     -+			  write_graph_chunk_bloom_indexes,
     -+			  sizeof(uint32_t) * ctx->commits.nr);
     ++			  sizeof(uint32_t) * ctx->commits.nr,
     ++			  write_graph_chunk_bloom_indexes);
      +		add_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
     -+			  write_graph_chunk_bloom_data,
      +			  sizeof(uint32_t) * 3
     -+				+ ctx->total_bloom_filter_data_size);
     ++				+ ctx->total_bloom_filter_data_size,
     ++			  write_graph_chunk_bloom_data);
      +	}
      +	if (ctx->num_commit_graphs_after > 1)
      +		add_chunk(cf, GRAPH_CHUNKID_BASE,
     -+			  write_graph_chunk_base,
     -+			  hashsz * (ctx->num_commit_graphs_after - 1));
     ++			  hashsz * (ctx->num_commit_graphs_after - 1),
     ++			  write_graph_chunk_base);
       
       	hashwrite_be32(f, GRAPH_SIGNATURE);
       
  4:  0cac7890bed7 =  4:  66ff49ed9309 midx: rename pack_info to write_midx_context
  5:  4a4e90b129ae =  5:  1d7484c0cffa midx: use context in write_midx_pack_names()
  6:  30ad423997b7 =  6:  ea0e7d40e537 midx: add entries to write_midx_context
  7:  2f1c496f3ab5 =  7:  b283a38fb775 midx: add pack_perm to write_midx_context
  8:  c4939548e51c =  8:  e7064512ab7f midx: add num_large_offsets to write_midx_context
  9:  b3cc73c22567 !  9:  7aa3242e15b7 midx: return success/failure in chunk write methods
     @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
       	stop_progress(&progress);
       
      -	if (written != chunk_offsets[num_chunks])
     -+	if (f->total + f->offset != chunk_offsets[num_chunks])
     ++	if (hashfile_total(f) != chunk_offsets[num_chunks])
       		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
      -		    written,
     -+		    f->total + f->offset,
     ++		    hashfile_total(f),
       		    chunk_offsets[num_chunks]);
       
       	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 10:  78744d3b7016 ! 10:  70f68c95e479 midx: drop chunk progress during write
     @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
       	}
      -	stop_progress(&progress);
       
     - 	if (f->total + f->offset != chunk_offsets[num_chunks])
     + 	if (hashfile_total(f) != chunk_offsets[num_chunks])
       		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
 11:  07dc0cf8c683 ! 11:  787cd7f18d2e midx: use chunk-format API in write_midx_internal()
     @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      -			case MIDX_CHUNKID_PACKNAMES:
      -				write_midx_pack_names(f, &ctx);
      -				break;
     -+	add_chunk(cf, MIDX_CHUNKID_PACKNAMES,
     -+		  write_midx_pack_names, pack_name_concat_len);
     -+	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT,
     -+		  write_midx_oid_fanout, MIDX_CHUNK_FANOUT_SIZE);
     ++	add_chunk(cf, MIDX_CHUNKID_PACKNAMES, pack_name_concat_len,
     ++		  write_midx_pack_names);
     ++	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT, MIDX_CHUNK_FANOUT_SIZE,
     ++		  write_midx_oid_fanout);
      +	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
     -+		  write_midx_oid_lookup, ctx.entries_nr * the_hash_algo->rawsz);
     ++		  ctx.entries_nr * the_hash_algo->rawsz,
     ++		  write_midx_oid_lookup);
      +	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
     -+		  write_midx_object_offsets,
     -+		  ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH);
     ++		  ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH,
     ++		  write_midx_object_offsets);
       
      -			case MIDX_CHUNKID_OIDFANOUT:
      -				write_midx_oid_fanout(f, &ctx);
     @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      -	}
      +	if (ctx.large_offsets_needed)
      +		add_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS,
     -+			write_midx_large_offsets,
     -+			ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH);
     ++			ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH,
     ++			write_midx_large_offsets);
       
     --	if (f->total + f->offset != chunk_offsets[num_chunks])
     +-	if (hashfile_total(f) != chunk_offsets[num_chunks])
      -		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
     --		    f->total + f->offset,
     +-		    hashfile_total(f),
      -		    chunk_offsets[num_chunks]);
      +	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
      +	write_chunkfile(cf, &ctx);
 12:  d8d8e9e2aa3f ! 12:  366eb2afee83 chunk-format: create read chunk API
     @@ Commit message
          read. If the same struct instance was used for both reads and writes,
          then there would be failures.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## chunk-format.c ##
     @@ chunk-format.c: int write_chunkfile(struct chunkfile *cf, void *data)
      +	return 0;
      +}
      +
     ++static int pair_chunk_fn(const unsigned char *chunk_start,
     ++			 size_t chunk_size,
     ++			 void *data)
     ++{
     ++	const unsigned char **p = data;
     ++	*p = chunk_start;
     ++	return 0;
     ++}
     ++
      +int pair_chunk(struct chunkfile *cf,
      +	       uint32_t chunk_id,
      +	       const unsigned char **p)
      +{
     -+	int i;
     -+
     -+	for (i = 0; i < cf->chunks_nr; i++) {
     -+		if (cf->chunks[i].id == chunk_id) {
     -+			*p = cf->chunks[i].start;
     -+			return 0;
     -+		}
     -+	}
     -+
     -+	return CHUNK_NOT_FOUND;
     ++	return read_chunk(cf, chunk_id, pair_chunk_fn, p);
      +}
      +
      +int read_chunk(struct chunkfile *cf,
     @@ chunk-format.c: int write_chunkfile(struct chunkfile *cf, void *data)
      +}
      
       ## chunk-format.h ##
     +@@
     + struct hashfile;
     + struct chunkfile;
     + 
     ++/*
     ++ * Initialize a 'struct chunkfile' for writing _or_ reading a file
     ++ * with the chunk format.
     ++ *
     ++ * If writing a file, supply a non-NULL 'struct hashfile *' that will
     ++ * be used to write.
     ++ *
     ++ * If reading a file, then supply the memory-mapped data to the
     ++ * pair_chunk() or read_chunk() methods, as appropriate.
     ++ *
     ++ * DO NOT MIX THESE MODES. Use different 'struct chunkfile' instances
     ++ * for reading and writing.
     ++ */
     + struct chunkfile *init_chunkfile(struct hashfile *f);
     + void free_chunkfile(struct chunkfile *cf);
     + int get_num_chunks(struct chunkfile *cf);
      @@ chunk-format.h: void add_chunk(struct chunkfile *cf,
     - 	       size_t size);
     + 	       chunk_write_fn fn);
       int write_chunkfile(struct chunkfile *cf, void *data);
       
      +int read_table_of_contents(struct chunkfile *cf,
 13:  8744d2785965 = 13:  7838ad32e2e0 commit-graph: use chunk-format read API
 14:  750c03253c95 ! 14:  6bddd9e63b9b midx: use chunk-format read API
     @@ midx.c: struct multi_pack_index *load_multi_pack_index(const char *object_dir, i
       	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
       
       	m->pack_names = xcalloc(m->num_packs, sizeof(*m->pack_names));
     +@@ midx.c: struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
     + cleanup_fail:
     + 	free(m);
     + 	free(midx_name);
     ++	free(cf);
     + 	if (midx_map)
     + 		munmap(midx_map, midx_size);
     + 	if (0 <= fd)
      
       ## t/t5319-multi-pack-index.sh ##
      @@ t/t5319-multi-pack-index.sh: test_expect_success 'verify bad OID version' '
 15:  83d292532a0f ! 15:  3cd97f389f1f midx: use 64-bit multiplication for chunk sizes
     @@ Commit message
          multiplication always. This allows us to properly predict the chunk
          sizes without risk of overflow.
      
     +    Other possible overflows were discovered by evaluating each
     +    multiplication in midx.c and ensuring that at least one side of the
     +    operator was of type size_t or off_t.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## midx.c ##
     +@@ midx.c: static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
     + 	const unsigned char *offset_data;
     + 	uint32_t offset32;
     + 
     +-	offset_data = m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH;
     ++	offset_data = m->chunk_object_offsets + (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH;
     + 	offset32 = get_be32(offset_data + sizeof(uint32_t));
     + 
     + 	if (m->chunk_large_offsets && offset32 & MIDX_LARGE_OFFSET_NEEDED) {
     +@@ midx.c: static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
     + 
     + static uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
     + {
     +-	return get_be32(m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH);
     ++	return get_be32(m->chunk_object_offsets +
     ++			(off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
     + }
     + 
     + static int nth_midxed_pack_entry(struct repository *r,
      @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
     - 	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT,
     - 		  write_midx_oid_fanout, MIDX_CHUNK_FANOUT_SIZE);
     + 	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT, MIDX_CHUNK_FANOUT_SIZE,
     + 		  write_midx_oid_fanout);
       	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
     --		  write_midx_oid_lookup, ctx.entries_nr * the_hash_algo->rawsz);
     -+		  write_midx_oid_lookup, (uint64_t)ctx.entries_nr * the_hash_algo->rawsz);
     +-		  ctx.entries_nr * the_hash_algo->rawsz,
     ++		  (size_t)ctx.entries_nr * the_hash_algo->rawsz,
     + 		  write_midx_oid_lookup);
       	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
     - 		  write_midx_object_offsets,
     - 		  ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH);
     -@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
     +-		  ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH,
     ++		  (size_t)ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH,
     + 		  write_midx_object_offsets);
     + 
       	if (ctx.large_offsets_needed)
       		add_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS,
     - 			write_midx_large_offsets,
     --			ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH);
     -+			(uint64_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH);
     +-			ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH,
     ++			(size_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH,
     + 			write_midx_large_offsets);
       
       	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
     - 	write_chunkfile(cf, &ctx);
 16:  669eeec707ab ! 16:  b9a1bddf615f chunk-format: restore duplicate chunk checks
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## chunk-format.c ##
     -@@ chunk-format.c: struct chunk_info {
     - 	chunk_write_fn write_fn;
     - 
     - 	const void *start;
     -+	unsigned found:1;
     - };
     - 
     - struct chunkfile {
      @@ chunk-format.c: int read_table_of_contents(struct chunkfile *cf,
       			   uint64_t toc_offset,
       			   int toc_length)
 17:  8f3985ab5df3 ! 17:  4c7d751f1e39 chunk-format: add technical docs
     @@ Documentation/technical/chunk-format.txt (new)
      +
      +Functions for working with chunk-based file formats are declared in
      +`chunk-format.h`. Using these methods provide extra checks that assist
     -+developers when creating new file formats, including:
     ++developers when creating new file formats.
      +
     -+ 1. Writing and reading the table of contents.
     ++Writing chunk-based file formats
     ++--------------------------------
      +
     -+ 2. Verifying that the data written in a chunk matches the expected size
     -+    that was recorded in the table of contents.
     ++To write a chunk-based file format, create a `struct chunkfile` by
     ++calling `init_chunkfile()` and pass a `struct hashfile` pointer. The
     ++caller is responsible for opening the `hashfile` and writing header
     ++information so the file format is identifiable before the chunk-based
     ++format begins.
      +
     -+ 3. Checking that a table of contents describes offsets properly within
     -+    the file boundaries.
     ++Then, call `add_chunk()` for each chunk that is intended for write. This
     ++populates the `chunkfile` with information about the order and size of
     ++each chunk to write. Provide a `chunk_write_fn` function pointer to
     ++perform the write of the chunk data upon request.
     ++
     ++Call `write_chunkfile()` to write the table of contents to the `hashfile`
     ++followed by each of the chunks. This will verify that each chunk wrote
     ++the expected amount of data so the table of contents is correct.
     ++
     ++Finally, call `free_chunkfile()` to clear the `struct chunkfile` data. The
     ++caller is responsible for finalizing the `hashfile` by writing the trailing
     ++hash and closing the file.
     ++
     ++Reading chunk-based file formats
     ++--------------------------------
     ++
     ++To read a chunk-based file format, the file must be opened as a
     ++memory-mapped region. The chunk-format API expects that the entire file
     ++is mapped as a contiguous memory region.
     ++
     ++Initialize a `struct chunkfile` pointer with `init_chunkfile(NULL)`.
     ++
     ++After reading the header information from the beginning of the file,
     ++including the chunk count, call `read_table_of_contents()` to populate
     ++the `struct chunkfile` with the list of chunks, their offsets, and their
     ++sizes.
     ++
     ++Extract the data information for each chunk using `pair_chunk()` or
     ++`read_chunk()`:
     ++
     ++* `pair_chunk()` assigns a given pointer with the location inside the
     ++  memory-mapped file corresponding to that chunk's offset. If the chunk
     ++  does not exist, then the pointer is not modified.
     ++
     ++* `read_chunk()` takes a `chunk_read_fn` function pointer and calls it
     ++  with the appropriate initial pointer and size information. The function
     ++  is not called if the chunk does not exist. Use this method to read chunks
     ++  if you need to perform immediate parsing or if you need to execute logic
     ++  based on the size of the chunk.
     ++
     ++After calling these methods, call `free_chunkfile()` to clear the
     ++`struct chunkfile` data. This will not close the memory-mapped region.
     ++Callers are expected to own that data for the timeframe the pointers into
     ++the region are needed.
     ++
     ++Examples
     ++--------
     ++
     ++These file formats use the chunk-format API, and can be used as examples
     ++for future formats:
     ++
     ++* *commit-graph:* see `write_commit_graph_file()` and `parse_commit_graph()`
     ++  in `commit-graph.c` for how the chunk-format API is used to write and
     ++  parse the commit-graph file format documented in
     ++  link:technical/commit-graph-format.html[the commit-graph file format].
     ++
     ++* *multi-pack-index:* see `write_midx_internal()` and `load_multi_pack_index()`
     ++  in `midx.c` for how the chunk-format API is used to write and
     ++  parse the multi-pack-index file format documented in
     ++  link:technical/pack-format.html[the multi-pack-index file format].
      
       ## Documentation/technical/commit-graph-format.txt ##
      @@ Documentation/technical/commit-graph-format.txt: CHUNK LOOKUP:

-- 
gitgitgadget
