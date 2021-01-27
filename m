Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA9AC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4EB2076E
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhA0PGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhA0PCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:02:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826CFC061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u14so1944404wmq.4
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ms1U6NIMxhBEvvSgVTSYt9UCALDuBXR38CI1ZIOmQYE=;
        b=kNmDvmE+Xap4ORmkjZAsg1khFEhiVQMgrbSYbdm9ZYkrLwfVi/+HsFO6Y52Ex1s98a
         31n+NV1uwCUAAB+E3eYYLLRy0Eqklf4Qi+ddo+TtCif8bmscNwdtTpEa6htOOlk4oAjA
         AE+eYYhQ9VzV//hcPFB9NMklCHiL3lbvdW7GOBuv9hGex4eijHfc4K9o7jzEAnn2RyjY
         MlOOrKWE/TC+AsV1lcE4O68c8OLQtbR8dnsUsGgdt5CXyzV+FGL2tZfOGgMMdQwWcp9v
         iaZf4d5xRa4aM+5QZSspsnGzb7i2rUFBcHheDnTg5aqtsQ5bxw+0VTzSxRwyV4Usd13q
         50Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ms1U6NIMxhBEvvSgVTSYt9UCALDuBXR38CI1ZIOmQYE=;
        b=lAkHyx7yNg8ZLhgx9aN6uFLg/I96Fw+6cNVlFyTP3WrKFXrld9K+F5dvAeDjOLYu0d
         /j6T/XqSH1KLu50YpTIx/PnqaFWJ2GHuXLTy4HHQNQ1uyVybcP5UTEJERjUqFwybnlqG
         Df/ObSiefVIwfo1abbLKkYy3ZbtGOUtWLNbHCboKH1gdTCOH7aGL8+NbHzAaYpPcdrKX
         jf8ufy+Ui2WBCpTnwX8FB/peuosK8/fE4xApf7BFBf8CfT9hVVnWH9E0Z3+WO8bBbV4Y
         LrZftmtC8NBQ0x3bjgT0jeuPNMsJjVtu/R5pIF87DkzBq9EfL7gKniSGOZ+K5Hh1HWLF
         tMPQ==
X-Gm-Message-State: AOAM532Ue3LeC6iZZ0Ynun2kslzHIx7sOFxTAlf2wcyBvJ+tBK5t+OKw
        G9jWmhi8jhXNBO7rEveZec96cJME2Ys=
X-Google-Smtp-Source: ABdhPJwqC13pIdHRs1Ckj2YdoK3PcQ0zk1YwAW0mk+66JKV+lMNykPRpuEuAiN/tW6P1geNLoB5e9g==
X-Received: by 2002:a1c:3d56:: with SMTP id k83mr4577087wma.25.1611759718539;
        Wed, 27 Jan 2021 07:01:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r124sm2941731wmr.16.2021.01.27.07.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:01:57 -0800 (PST)
Message-Id: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:39 +0000
Subject: [PATCH v2 00/17] Refactor chunk-format into an API
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

 Documentation/technical/chunk-format.txt      |  54 +++
 .../technical/commit-graph-format.txt         |   3 +
 Documentation/technical/pack-format.txt       |   3 +
 Makefile                                      |   1 +
 chunk-format.c                                | 181 ++++++++
 chunk-format.h                                |  53 +++
 commit-graph.c                                | 299 +++++-------
 midx.c                                        | 424 +++++++-----------
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5319-multi-pack-index.sh                   |   6 +-
 10 files changed, 570 insertions(+), 456 deletions(-)
 create mode 100644 Documentation/technical/chunk-format.txt
 create mode 100644 chunk-format.c
 create mode 100644 chunk-format.h


base-commit: 5a3b130cad0d5c770f766e3af6d32b41766374c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-848%2Fderrickstolee%2Fchunk-format%2Frefactor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-848/derrickstolee/chunk-format/refactor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/848

Range-diff vs v1:

  1:  09b32829e4f !  1:  243dcec9436 commit-graph: anonymize data in chunk_write_fn
     @@ commit-graph.c: struct write_commit_graph_context {
      -				    struct write_commit_graph_context *ctx)
      +				    void *data)
       {
     -+	struct write_commit_graph_context *ctx =
     -+		(struct write_commit_graph_context *)data;
     ++	struct write_commit_graph_context *ctx = data;
       	int i, count = 0;
       	struct commit **list = ctx->commits.list;
       
     @@ commit-graph.c: static int write_graph_chunk_fanout(struct hashfile *f,
      -				  struct write_commit_graph_context *ctx)
      +				  void *data)
       {
     -+	struct write_commit_graph_context *ctx =
     -+		(struct write_commit_graph_context *)data;
     ++	struct write_commit_graph_context *ctx = data;
       	struct commit **list = ctx->commits.list;
       	int count;
       	for (count = 0; count < ctx->commits.nr; count++, list++) {
     @@ commit-graph.c: static const unsigned char *commit_to_sha1(size_t index, void *t
      -				  struct write_commit_graph_context *ctx)
      +				  void *data)
       {
     -+	struct write_commit_graph_context *ctx =
     -+		(struct write_commit_graph_context *)data;
     ++	struct write_commit_graph_context *ctx = data;
       	struct commit **list = ctx->commits.list;
       	struct commit **last = ctx->commits.list + ctx->commits.nr;
       	uint32_t num_extra_edges = 0;
     @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
      -					      struct write_commit_graph_context *ctx)
      +					     void *data)
       {
     -+	struct write_commit_graph_context *ctx =
     -+		(struct write_commit_graph_context *)data;
     ++	struct write_commit_graph_context *ctx = data;
       	int i, num_generation_data_overflows = 0;
       
       	for (i = 0; i < ctx->commits.nr; i++) {
     @@ commit-graph.c: static int write_graph_chunk_generation_data(struct hashfile *f,
      -						       struct write_commit_graph_context *ctx)
      +						      void *data)
       {
     -+	struct write_commit_graph_context *ctx =
     -+		(struct write_commit_graph_context *)data;
     ++	struct write_commit_graph_context *ctx = data;
       	int i;
       	for (i = 0; i < ctx->commits.nr; i++) {
       		struct commit *c = ctx->commits.list[i];
     @@ commit-graph.c: static int write_graph_chunk_generation_data_overflow(struct has
      -					 struct write_commit_graph_context *ctx)
      +					 void *data)
       {
     -+	struct write_commit_graph_context *ctx =
     -+		(struct write_commit_graph_context *)data;
     ++	struct write_commit_graph_context *ctx = data;
       	struct commit **list = ctx->commits.list;
       	struct commit **last = ctx->commits.list + ctx->commits.nr;
       	struct commit_list *parent;
     @@ commit-graph.c: static int write_graph_chunk_extra_edges(struct hashfile *f,
      -					   struct write_commit_graph_context *ctx)
      +					   void *data)
       {
     -+	struct write_commit_graph_context *ctx =
     -+		(struct write_commit_graph_context *)data;
     ++	struct write_commit_graph_context *ctx = data;
       	struct commit **list = ctx->commits.list;
       	struct commit **last = ctx->commits.list + ctx->commits.nr;
       	uint32_t cur_pos = 0;
     @@ commit-graph.c: static void trace2_bloom_filter_settings(struct write_commit_gra
      -					struct write_commit_graph_context *ctx)
      +					void *data)
       {
     -+	struct write_commit_graph_context *ctx =
     -+		(struct write_commit_graph_context *)data;
     ++	struct write_commit_graph_context *ctx = data;
       	struct commit **list = ctx->commits.list;
       	struct commit **last = ctx->commits.list + ctx->commits.nr;
       
     @@ commit-graph.c: static int write_graph_chunk_base_1(struct hashfile *f,
      -				  struct write_commit_graph_context *ctx)
      +				    void *data)
       {
     -+	struct write_commit_graph_context *ctx =
     -+		(struct write_commit_graph_context *)data;
     ++	struct write_commit_graph_context *ctx = data;
       	int num = write_graph_chunk_base_1(f, ctx->new_base_graph);
       
       	if (num != ctx->num_commit_graphs_after - 1) {
  2:  9bd273f8c94 !  2:  814512f2167 chunk-format: create chunk format write API
     @@ chunk-format.c (new)
      +		if (result)
      +			return result;
      +
     -+		if (cf->f->total + cf->f->offset != start_offset + cf->chunks[i].size)
     ++		if (cf->f->total + cf->f->offset - start_offset != cf->chunks[i].size)
      +			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
      +			    cf->chunks[i].size, cf->chunks[i].id,
      +			    cf->f->total + cf->f->offset - start_offset);
  3:  a3d6177a352 =  3:  70af6e3083f commit-graph: use chunk-format write API
  4:  9fe5ee8611c !  4:  0cac7890bed midx: rename pack_info to write_midx_context
     @@ midx.c: struct pack_list {
       			     const char *file_name, void *data)
       {
      -	struct pack_list *packs = (struct pack_list *)data;
     -+	struct write_midx_context *ctx = (struct write_midx_context *)data;
     ++	struct write_midx_context *ctx = data;
       
       	if (ends_with(file_name, ".idx")) {
      -		display_progress(packs->progress, ++packs->pack_paths_checked);
  5:  14a0246b982 !  5:  4a4e90b129a midx: use context in write_midx_pack_names()
     @@ midx.c: static struct pack_midx_entry *get_sorted_entries(struct multi_pack_inde
      -				    uint32_t num_packs)
      +static size_t write_midx_pack_names(struct hashfile *f, void *data)
       {
     -+	struct write_midx_context *ctx = (struct write_midx_context *)data;
     ++	struct write_midx_context *ctx = data;
       	uint32_t i;
       	unsigned char padding[MIDX_CHUNK_ALIGNMENT];
       	size_t written = 0;
  6:  79f479ef7d1 !  6:  30ad423997b midx: add entries to write_midx_context
     @@ midx.c: static size_t write_midx_pack_names(struct hashfile *f, void *data)
       {
      -	struct pack_midx_entry *list = objects;
      -	struct pack_midx_entry *last = objects + nr_objects;
     -+	struct write_midx_context *ctx = (struct write_midx_context *)data;
     ++	struct write_midx_context *ctx = data;
      +	struct pack_midx_entry *list = ctx->entries;
      +	struct pack_midx_entry *last = ctx->entries + ctx->entries_nr;
       	uint32_t count = 0;
     @@ midx.c: static size_t write_midx_oid_fanout(struct hashfile *f,
      +				    void *data)
       {
      -	struct pack_midx_entry *list = objects;
     -+	struct write_midx_context *ctx = (struct write_midx_context *)data;
     ++	struct write_midx_context *ctx = data;
      +	unsigned char hash_len = the_hash_algo->rawsz;
      +	struct pack_midx_entry *list = ctx->entries;
       	uint32_t i;
  7:  0b4ce3f1732 !  7:  2f1c496f3ab midx: add pack_perm to write_midx_context
     @@ midx.c: static size_t write_midx_oid_lookup(struct hashfile *f,
      +					void *data)
       {
      -	struct pack_midx_entry *list = objects;
     -+	struct write_midx_context *ctx = (struct write_midx_context *)data;
     ++	struct write_midx_context *ctx = data;
      +	struct pack_midx_entry *list = ctx->entries;
       	uint32_t i, nr_large_offset = 0;
       	size_t written = 0;
  8:  eabc7b73647 !  8:  c4939548e51 midx: add num_large_offsets to write_midx_context
     @@ midx.c: static size_t write_midx_object_offsets(struct hashfile *f,
      +				       void *data)
       {
      -	struct pack_midx_entry *list = objects, *end = objects + nr_objects;
     -+	struct write_midx_context *ctx = (struct write_midx_context *)data;
     ++	struct write_midx_context *ctx = data;
      +	struct pack_midx_entry *list = ctx->entries;
      +	struct pack_midx_entry *end = ctx->entries + ctx->entries_nr;
       	size_t written = 0;
  9:  909ca28e0ba !  9:  b3cc73c2256 midx: return success/failure in chunk write methods
     @@ midx.c: static struct pack_midx_entry *get_sorted_entries(struct multi_pack_inde
      -static size_t write_midx_pack_names(struct hashfile *f, void *data)
      +static int write_midx_pack_names(struct hashfile *f, void *data)
       {
     - 	struct write_midx_context *ctx = (struct write_midx_context *)data;
     + 	struct write_midx_context *ctx = data;
       	uint32_t i;
      @@ midx.c: static size_t write_midx_pack_names(struct hashfile *f, void *data)
       	if (i < MIDX_CHUNK_ALIGNMENT) {
     @@ midx.c: static size_t write_midx_pack_names(struct hashfile *f, void *data)
      +static int write_midx_oid_fanout(struct hashfile *f,
      +				 void *data)
       {
     - 	struct write_midx_context *ctx = (struct write_midx_context *)data;
     + 	struct write_midx_context *ctx = data;
       	struct pack_midx_entry *list = ctx->entries;
      @@ midx.c: static size_t write_midx_oid_fanout(struct hashfile *f,
       		list = next;
     @@ midx.c: static size_t write_midx_oid_fanout(struct hashfile *f,
      +static int write_midx_oid_lookup(struct hashfile *f,
      +				 void *data)
       {
     - 	struct write_midx_context *ctx = (struct write_midx_context *)data;
     + 	struct write_midx_context *ctx = data;
       	unsigned char hash_len = the_hash_algo->rawsz;
       	struct pack_midx_entry *list = ctx->entries;
       	uint32_t i;
     @@ midx.c: static size_t write_midx_oid_lookup(struct hashfile *f,
      +static int write_midx_object_offsets(struct hashfile *f,
      +				     void *data)
       {
     - 	struct write_midx_context *ctx = (struct write_midx_context *)data;
     + 	struct write_midx_context *ctx = data;
       	struct pack_midx_entry *list = ctx->entries;
       	uint32_t i, nr_large_offset = 0;
      -	size_t written = 0;
     @@ midx.c: static size_t write_midx_object_offsets(struct hashfile *f,
      +static int write_midx_large_offsets(struct hashfile *f,
      +				    void *data)
       {
     - 	struct write_midx_context *ctx = (struct write_midx_context *)data;
     + 	struct write_midx_context *ctx = data;
       	struct pack_midx_entry *list = ctx->entries;
       	struct pack_midx_entry *end = ctx->entries + ctx->entries_nr;
      -	size_t written = 0;
 10:  e613ffa9ac6 = 10:  78744d3b701 midx: drop chunk progress during write
 11:  49cfb4f63e2 = 11:  07dc0cf8c68 midx: use chunk-format API in write_midx_internal()
 12:  e3475633e1d ! 12:  d8d8e9e2aa3 chunk-format: create read chunk API
     @@ Commit message
      
           1. initialize a 'struct chunkfile' with init_chunkfile(NULL).
           2. call read_table_of_contents().
     -     3. for each chunk to parse, call pair_chunk() with appropriate pointers.
     +     3. for each chunk to parse,
     +        a. call pair_chunk() to assign a pointer with the chunk position, or
     +        b. call read_chunk() to run a callback on the chunk start and size.
           4. call free_chunkfile() to clear the 'struct chunkfile' data.
      
          We are re-using the anonymous 'struct chunkfile' data, as it is internal
     @@ chunk-format.c: int write_chunkfile(struct chunkfile *cf, void *data)
      +
      +int pair_chunk(struct chunkfile *cf,
      +	       uint32_t chunk_id,
     ++	       const unsigned char **p)
     ++{
     ++	int i;
     ++
     ++	for (i = 0; i < cf->chunks_nr; i++) {
     ++		if (cf->chunks[i].id == chunk_id) {
     ++			*p = cf->chunks[i].start;
     ++			return 0;
     ++		}
     ++	}
     ++
     ++	return CHUNK_NOT_FOUND;
     ++}
     ++
     ++int read_chunk(struct chunkfile *cf,
     ++	       uint32_t chunk_id,
      +	       chunk_read_fn fn,
      +	       void *data)
      +{
     @@ chunk-format.h: void add_chunk(struct chunkfile *cf,
      +			   uint64_t toc_offset,
      +			   int toc_length);
      +
     ++#define CHUNK_NOT_FOUND (-2)
     ++
      +/*
     -+ * When reading a table of contents, we find the chunk with matching 'id'
     -+ * then call its read_fn to populate the necessary 'data' based on the
     -+ * chunk start and size.
     ++ * Find 'chunk_id' in the given chunkfile and assign the
     ++ * given pointer to the position in the mmap'd file where
     ++ * that chunk begins.
     ++ *
     ++ * Returns CHUNK_NOT_FOUND if the chunk does not exist.
      + */
     ++int pair_chunk(struct chunkfile *cf,
     ++	       uint32_t chunk_id,
     ++	       const unsigned char **p);
     ++
      +typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
      +			     size_t chunk_size, void *data);
     -+
     -+
     -+#define CHUNK_NOT_FOUND (-2)
     -+int pair_chunk(struct chunkfile *cf,
     ++/*
     ++ * Find 'chunk_id' in the given chunkfile and call the
     ++ * given chunk_read_fn method with the information for
     ++ * that chunk.
     ++ *
     ++ * Returns CHUNK_NOT_FOUND if the chunk does not exist.
     ++ */
     ++int read_chunk(struct chunkfile *cf,
      +	       uint32_t chunk_id,
      +	       chunk_read_fn fn,
      +	       void *data);
 13:  7339990f07d ! 13:  8744d278596 commit-graph: use chunk-format read API
     @@ commit-graph.c: static int verify_commit_graph_lite(struct commit_graph *g)
       	return 0;
       }
       
     -+static int graph_read_oid_fanout(const unsigned char *chunk_start,
     -+				 size_t chunk_size, void *data)
     -+{
     -+	struct commit_graph *g = (struct commit_graph *)data;
     -+	g->chunk_oid_fanout = (uint32_t*)chunk_start;
     -+	return 0;
     -+}
     -+
      +static int graph_read_oid_lookup(const unsigned char *chunk_start,
      +				 size_t chunk_size, void *data)
      +{
     -+	struct commit_graph *g = (struct commit_graph *)data;
     ++	struct commit_graph *g = data;
      +	g->chunk_oid_lookup = chunk_start;
      +	g->num_commits = chunk_size / g->hash_len;
      +	return 0;
      +}
      +
     -+static int graph_read_data(const unsigned char *chunk_start,
     -+				 size_t chunk_size, void *data)
     -+{
     -+	struct commit_graph *g = (struct commit_graph *)data;
     -+	g->chunk_commit_data = chunk_start;
     -+	return 0;
     -+}
     -+
     -+static int graph_read_extra_edges(const unsigned char *chunk_start,
     -+				  size_t chunk_size, void *data)
     -+{
     -+	struct commit_graph *g = (struct commit_graph *)data;
     -+	g->chunk_extra_edges = chunk_start;
     -+	return 0;
     -+}
     -+
     -+static int graph_read_base_graphs(const unsigned char *chunk_start,
     -+				  size_t chunk_size, void *data)
     -+{
     -+	struct commit_graph *g = (struct commit_graph *)data;
     -+	g->chunk_base_graphs = chunk_start;
     -+	return 0;
     -+}
     -+
     -+static int graph_read_generation_data(const unsigned char *chunk_start,
     -+				      size_t chunk_size, void *data)
     -+{
     -+	struct commit_graph *g = (struct commit_graph *)data;
     -+	g->chunk_generation_data = chunk_start;
     -+	return 0;
     -+}
     -+
     -+static int graph_read_generation_overflow(const unsigned char *chunk_start,
     -+					  size_t chunk_size, void *data)
     -+{
     -+	struct commit_graph *g = (struct commit_graph *)data;
     -+	g->chunk_generation_data_overflow = chunk_start;
     -+	return 0;
     -+}
     -+
     -+static int graph_read_bloom_indices(const unsigned char *chunk_start,
     -+				    size_t chunk_size, void *data)
     -+{
     -+	struct commit_graph *g = (struct commit_graph *)data;
     -+	g->chunk_bloom_indexes = chunk_start;
     -+	return 0;
     -+}
     -+
      +static int graph_read_bloom_data(const unsigned char *chunk_start,
      +				  size_t chunk_size, void *data)
      +{
     -+	struct commit_graph *g = (struct commit_graph *)data;
     ++	struct commit_graph *g = data;
      +	uint32_t hash_version;
      +	g->chunk_bloom_data = chunk_start;
      +	hash_version = get_be32(chunk_start);
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      -						     / graph->hash_len;
      -			}
      -			break;
     --
     ++	cf = init_chunkfile(NULL);
     + 
      -		case GRAPH_CHUNKID_DATA:
      -			if (graph->chunk_commit_data)
      -				chunk_repeated = 1;
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      -			else
      -				graph->chunk_generation_data = data + chunk_offset;
      -			break;
     -+	cf = init_chunkfile(NULL);
     - 
     +-
      -		case GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW:
      -			if (graph->chunk_generation_data_overflow)
      -				chunk_repeated = 1;
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      -			}
      -			break;
      -		}
     -+	pair_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);
     -+	pair_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
     -+	pair_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_data, graph);
     -+	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, graph_read_extra_edges, graph);
     -+	pair_chunk(cf, GRAPH_CHUNKID_BASE, graph_read_base_graphs, graph);
     ++	pair_chunk(cf, GRAPH_CHUNKID_OIDFANOUT,
     ++		   (const unsigned char **)&graph->chunk_oid_fanout);
     ++	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
     ++	pair_chunk(cf, GRAPH_CHUNKID_DATA, &graph->chunk_commit_data);
     ++	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
     ++	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
      +	pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
     -+		   graph_read_generation_data, graph);
     ++		   &graph->chunk_generation_data);
      +	pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
     -+		   graph_read_generation_overflow, graph);
     ++		   &graph->chunk_generation_data_overflow);
       
      -		if (chunk_repeated) {
      -			error(_("commit-graph chunk id %08x appears multiple times"), chunk_id);
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      -		}
      +	if (r->settings.commit_graph_read_changed_paths) {
      +		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
     -+			   graph_read_bloom_indices, graph);
     -+		pair_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
     ++			   &graph->chunk_bloom_indexes);
     ++		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
      +			   graph_read_bloom_data, graph);
       	}
       
 14:  cb145e0e32a ! 14:  750c03253c9 midx: use chunk-format read API
     @@ midx.c: static char *get_midx_filename(const char *object_dir)
       	return xstrfmt("%s/pack/multi-pack-index", object_dir);
       }
       
     -+static int midx_read_pack_names(const unsigned char *chunk_start,
     -+				size_t chunk_size, void *data)
     -+{
     -+	struct multi_pack_index *m = (struct multi_pack_index *)data;
     -+	m->chunk_pack_names = chunk_start;
     -+	return 0;
     -+}
     -+
      +static int midx_read_oid_fanout(const unsigned char *chunk_start,
      +				size_t chunk_size, void *data)
      +{
     -+	struct multi_pack_index *m = (struct multi_pack_index *)data;
     ++	struct multi_pack_index *m = data;
      +	m->chunk_oid_fanout = (uint32_t *)chunk_start;
      +
      +	if (chunk_size != 4 * 256) {
     @@ midx.c: static char *get_midx_filename(const char *object_dir)
      +	}
      +	return 0;
      +}
     -+
     -+static int midx_read_oid_lookup(const unsigned char *chunk_start,
     -+				size_t chunk_size, void *data)
     -+{
     -+	struct multi_pack_index *m = (struct multi_pack_index *)data;
     -+	m->chunk_oid_lookup = chunk_start;
     -+	return 0;
     -+}
     -+
     -+static int midx_read_offsets(const unsigned char *chunk_start,
     -+			     size_t chunk_size, void *data)
     -+{
     -+	struct multi_pack_index *m = (struct multi_pack_index *)data;
     -+	m->chunk_object_offsets = chunk_start;
     -+	return 0;
     -+}
     -+
     -+static int midx_read_large_offsets(const unsigned char *chunk_start,
     -+				   size_t chunk_size, void *data)
     -+{
     -+	struct multi_pack_index *m = (struct multi_pack_index *)data;
     -+	m->chunk_large_offsets = chunk_start;
     -+	return 0;
     -+}
      +
       struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local)
       {
     @@ midx.c: struct multi_pack_index *load_multi_pack_index(const char *object_dir, i
      +				   MIDX_HEADER_SIZE, m->num_chunks))
      +		goto cleanup_fail;
      +
     -+	if (pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, midx_read_pack_names, m) == CHUNK_NOT_FOUND)
     ++	if (pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names) == CHUNK_NOT_FOUND)
       		die(_("multi-pack-index missing required pack-name chunk"));
      -	if (!m->chunk_oid_fanout)
     -+	if (pair_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m) == CHUNK_NOT_FOUND)
     ++	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m) == CHUNK_NOT_FOUND)
       		die(_("multi-pack-index missing required OID fanout chunk"));
      -	if (!m->chunk_oid_lookup)
     -+	if (pair_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, midx_read_oid_lookup, m) == CHUNK_NOT_FOUND)
     ++	if (pair_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup) == CHUNK_NOT_FOUND)
       		die(_("multi-pack-index missing required OID lookup chunk"));
      -	if (!m->chunk_object_offsets)
     -+	if (pair_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_offsets, m) == CHUNK_NOT_FOUND)
     ++	if (pair_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets) == CHUNK_NOT_FOUND)
       		die(_("multi-pack-index missing required object offsets chunk"));
       
     -+	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, midx_read_large_offsets, m);
     ++	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets);
      +
       	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
       
 15:  f6c58ff72d2 = 15:  83d292532a0 midx: use 64-bit multiplication for chunk sizes
 16:  62a23842aa6 = 16:  669eeec707a chunk-format: restore duplicate chunk checks
 17:  05cbd0a8d93 = 17:  8f3985ab5df chunk-format: add technical docs

-- 
gitgitgadget
