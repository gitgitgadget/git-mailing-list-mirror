Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D568C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202D922D00
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mMgLnWtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgHERHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgHERBp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:01:45 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7686BC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:01:37 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 6so34228663qtt.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eoovlOOSFsFmnYOrIQaBIrPIWATADgMBL/EhdSKwpbY=;
        b=mMgLnWtZ1W5i7cRG/wbrPBWIfcF6mgJ0LCIC+V/GL2MsN1+US95vn1hEHG/Yfnow4x
         +pkuqCL7NKUgej7twd1zOXjLFL17a6toUy+mPrURZWt7CNdQZiAXqfgnj7BRo5ibtulg
         if/Qdo0bhVaB8QevxD8rVtaCjJ6C8JK+KsCtNTE5VqqY3V/++7XQyH5di23No5Wmuphk
         PSoX8E3SMANFdhqqmr52PWI4gp27hScp0wrY6fuStB9s6KKYby642JrBa6KvkWohydSD
         BNVNqGz3PPj/I2mLTr7eraOub4fgIdoqttV60Qsxzs9hab0/ZlP12IYIPeCDKkRU/W6W
         koKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eoovlOOSFsFmnYOrIQaBIrPIWATADgMBL/EhdSKwpbY=;
        b=RGJTvZ8CYkkQu+65ZTc4uXDIlbWBDTa8Nk3HRH9EsPW/vXWaFD+plQ6h1goTah8Osh
         ez7KibDn+obF8OJYmSgUjgDmVP2n7eahw8wuDljjUbE/4MHcjW+hJxqsg261icIxlHy/
         QeDDGWIGYg/IZFLlfOFyskqfb9rPSrUTMhm1RLFvFEPLLT6vGHAi9x9db8fZaw6aqm4N
         zU8wPov7aLvG0c+XoiXyauPiR00KljjoheVuySsh9DOYsTzOuy35ilQTC/+vfZqrb/ig
         TzD9Ub80kCRm4olnZu6cZj6a4Mhd+/MY6EqljvPQRmwe5Rg8lxzl/i+fHPHZLQpig3MR
         LywA==
X-Gm-Message-State: AOAM531mEUN1tYFqRshSjYAo6cG7zZywzzYYHsRsKrsvbMreXC+Ol6AO
        Brr8pzS7B2ow2RPLek76QTYFuEmWC/RzGA==
X-Google-Smtp-Source: ABdhPJxH+cuMgtTV8kTq5i5VMGRCc7uBTtF9zNBvrfA0Mp6f+MoaCTXyNoEhOrxtJ0rWw2LvtCBzcA==
X-Received: by 2002:aed:3947:: with SMTP id l65mr4489981qte.374.1596646893996;
        Wed, 05 Aug 2020 10:01:33 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id n23sm1953390qkk.105.2020.08.05.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:01:32 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:01:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 00/14] more miscellaneous Bloom filter improvements
Message-ID: <cover.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596480582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's a re-roll of mine and Stolee's series containing a grab bag of
changed-path Bloom filter improvements. The contents are described in
[1], but the culmination of this series is in adding the new 'BFXL'
chunk, and allowing callers to pass '--max-new-filters <n>' to
'git commit-graph write' commands.

Lots of little things have changed since last time, most notably a
moderate restructuring of the patches to slot in Stolee's fix for
'max_changes' not working properly in the diff machinery [2].

A range-diff is included below for convening, although I'm not sure how
illuminating it is to read compared to starting from scratch reading the
patches one by one...

Thanks again for all of the helpful review since last time.

[1]: https://lore.kernel.org/git/cover.1596480582.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/a08c26bb-54ec-13af-e503-fccd68727cf3@gmail.com/

Derrick Stolee (1):
  bloom/diff: properly short-circuit on max_changes

Taylor Blau (13):
  commit-graph: introduce 'get_bloom_filter_settings()'
  t4216: use an '&&'-chain
  commit-graph: pass a 'struct repository *' in more places
  t/helper/test-read-graph.c: prepare repo settings
  commit-graph: respect 'commitGraph.readChangedPaths'
  commit-graph.c: store maximum changed paths
  bloom: split 'get_bloom_filter()' in two
  bloom: use provided 'struct bloom_filter_settings'
  commit-graph.c: sort index into commits list
  csum-file.h: introduce 'hashwrite_be64()'
  commit-graph: add large-filters bitmap chunk
  commit-graph: rename 'split_commit_graph_opts'
  builtin/commit-graph.c: introduce '--max-new-filters=<n>'

 Documentation/config.txt                      |   2 +
 Documentation/config/commitgraph.txt          |   8 +
 Documentation/git-commit-graph.txt            |   4 +
 .../technical/commit-graph-format.txt         |  12 +
 blame.c                                       |   8 +-
 bloom.c                                       |  51 +++-
 bloom.h                                       |  23 +-
 builtin/commit-graph.c                        |  61 +++-
 commit-graph.c                                | 268 +++++++++++++-----
 commit-graph.h                                |  20 +-
 csum-file.h                                   |   6 +
 diff.h                                        |   2 -
 fuzz-commit-graph.c                           |   5 +-
 line-log.c                                    |   2 +-
 midx.c                                        |   3 +-
 repo-settings.c                               |   3 +
 repository.h                                  |   1 +
 revision.c                                    |   7 +-
 t/helper/test-bloom.c                         |   4 +-
 t/helper/test-read-graph.c                    |   3 +-
 t/t4216-log-bloom.sh                          | 148 ++++++++--
 t/t5324-split-commit-graph.sh                 |  13 +
 tree-diff.c                                   |   5 +-
 23 files changed, 518 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/config/commitgraph.txt

Range-diff against v1:
 [ ... rebased onto 'master' ]
 1:  08479793c1 ! 11:  001f3385ff commit-graph: introduce 'get_bloom_filter_settings()'
    @@ commit-graph.h: struct commit_graph *parse_commit_graph(void *graph_map, size_t

      ## revision.c ##
     @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
    - 	if (!revs->repo->objects->commit_graph)
    - 		return;

    + 	repo_parse_commit(revs->repo, revs->commits->item);
    +
    +-	if (!revs->repo->objects->commit_graph)
    +-		return;
    +-
     -	revs->bloom_filter_settings = revs->repo->objects->commit_graph->bloom_filter_settings;
     +	revs->bloom_filter_settings = get_bloom_filter_settings(revs->repo);
      	if (!revs->bloom_filter_settings)
 3:  d12fcc4a8d = 12:  e4d068a478 t4216: use an '&&'-chain
 2:  52f8f7424e ! 13:  afdc614c0d commit-graph: pass a 'struct repository *' in more places
    @@ Commit message
         corresponding to that repository.

         Add an additional parameter to pass the repository around in more
    -    places. In the next patch, we will remove the object directory (and
    -    instead reference it with 'r->odb').
    +    places.

         Signed-off-by: Taylor Blau <me@ttaylorr.com>

    @@ commit-graph.c: struct commit_graph *parse_commit_graph(void *graph_map, size_t
      }

     -static struct commit_graph *load_commit_graph_one(const char *graph_file,
    -+
     +static struct commit_graph *load_commit_graph_one(struct repository *r,
     +						  const char *graph_file,
      						  struct object_directory *odb)
 4:  42a0ca9549 = 14:  038e996ced t/helper/test-read-graph.c: prepare repo settings
 5:  e615077283 ! 15:  404f10319a commit-graph: respect 'commitgraph.readChangedPaths'
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>

      ## Commit message ##
    -    commit-graph: respect 'commitgraph.readChangedPaths'
    +    commit-graph: respect 'commitGraph.readChangedPaths'

         Git uses the 'core.commitGraph' configuration value to control whether
         or not the commit graph is used when parsing commits or performing a
    @@ Commit message
         Bloom filters. This can happen, for example, during a staged roll-out,
         or in the event of an incident.

    -    Introduce 'commitgraph.readChangedPaths' to control whether or not Bloom
    +    Introduce 'commitGraph.readChangedPaths' to control whether or not Bloom
         filters are read. Note that this configuration is independent from both:

           - 'core.commitGraph', to allow flexibility in using all parts of a
    @@ Documentation/config.txt: include::config/column.txt[]

      ## Documentation/config/commitgraph.txt (new) ##
     @@
    -+commitgraph.readChangedPaths::
    ++commitGraph.readChangedPaths::
     +	If true, then git will use the changed-path Bloom filters in the
     +	commit-graph file (if it exists, and they are present). Defaults to
     +	true. See linkgit:git-commit-graph[1] for more information.
 -:  ---------- > 16:  053991f048 commit-graph.c: store maximum changed paths
 8:  a494094c10 ! 17:  23525947c8 bloom: split 'get_bloom_filter()' in two
    @@ Commit message

         'get_bloom_filter' takes a flag to control whether it will compute a
         Bloom filter if the requested one is missing. In the next patch, we'll
    -    add yet another flag to this method, which would force all but one
    +    add yet another parameter to this method, which would force all but one
         caller to specify an extra 'NULL' parameter at the end.

         Instead of doing this, split 'get_bloom_filter' into two functions:
    @@ Commit message
         (so they can drop the parameter entirely and use the simpler version of
         the function).

    +    While we're at it, instrument the new 'get_or_compute_bloom_filter()'
    +    with two counters in the 'write_commit_graph_context' struct which store
    +    the number of filters that we computed, and the number of those which
    +    were too large to store.
    +
    +    It would be nice to drop the 'compute_if_not_present' flag entirely,
    +    since all remaining callers of 'get_or_compute_bloom_filter' pass it as
    +    '1', but this will change in a future patch and hence cannot be removed.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## blame.c ##
    @@ bloom.h: void add_key_to_filter(const struct bloom_key *key,
     +						 int compute_if_not_present,
     +						 int *computed);
     +
    -+#define get_bloom_filter(r, c) get_or_compute_bloom_filter((r), (c), 0, NULL)
    ++#define DEFAULT_BLOOM_MAX_CHANGES 512
    ++#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
    ++	(r), (c), 0, NULL)

      int bloom_filter_contains(const struct bloom_filter *filter,
      			  const struct bloom_key *key,

      ## commit-graph.c ##
    +@@ commit-graph.c: struct write_commit_graph_context {
    + 	const struct split_commit_graph_opts *split_opts;
    + 	size_t total_bloom_filter_data_size;
    + 	const struct bloom_filter_settings *bloom_settings;
    ++
    ++	int count_bloom_filter_found_large;
    ++	int count_bloom_filter_computed;
    + };
    +
    + static int write_graph_chunk_fanout(struct hashfile *f,
     @@ commit-graph.c: static int write_graph_chunk_bloom_indexes(struct hashfile *f,
      	uint32_t cur_pos = 0;

    @@ commit-graph.c: static int write_graph_chunk_bloom_data(struct hashfile *f,
      		size_t len = filter ? filter->len : 0;

      		display_progress(ctx->progress, ++ctx->progress_cnt);
    +@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
    + 	stop_progress(&ctx->progress);
    + }
    +
    ++static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
    ++{
    ++	struct json_writer jw = JSON_WRITER_INIT;
    ++
    ++	jw_object_begin(&jw, 0);
    ++	jw_object_intmax(&jw, "filter_found_large",
    ++			 ctx->count_bloom_filter_found_large);
    ++	jw_object_intmax(&jw, "filter_computed",
    ++			 ctx->count_bloom_filter_computed);
    ++	jw_end(&jw);
    ++
    ++	trace2_data_json("commit-graph", the_repository, "bloom_statistics", &jw);
    ++
    ++	jw_release(&jw);
    ++}
    ++
    + static void compute_bloom_filters(struct write_commit_graph_context *ctx)
    + {
    + 	int i;
     @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_context *ctx)
    - 			bitmap_set(ctx->bloom_large, pos);
    - 			ctx->count_bloom_filter_known_large++;
    - 		} else {
    --			struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
    -+			struct bloom_filter *filter = get_or_compute_bloom_filter(ctx->r, c, 1, NULL);
    - 			if (!filter->len) {
    - 				bitmap_set(ctx->bloom_large, pos);
    - 				ctx->count_bloom_filter_found_large++;
    + 		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
    +
    + 	for (i = 0; i < ctx->commits.nr; i++) {
    ++		int computed = 0;
    + 		struct commit *c = sorted_commits[i];
    +-		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
    ++		struct bloom_filter *filter = get_or_compute_bloom_filter(
    ++			ctx->r,
    ++			c,
    ++			1,
    ++			&computed);
    ++		if (computed) {
    ++			ctx->count_bloom_filter_computed++;
    ++			if (filter && !filter->len)
    ++				ctx->count_bloom_filter_found_large++;
    ++		}
    + 		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
    + 		display_progress(progress, i + 1);
    + 	}
    +
    ++	if (trace2_is_enabled())
    ++		trace2_bloom_filter_write_statistics(ctx);
    ++
    + 	free(sorted_commits);
    + 	stop_progress(&progress);
    + }

      ## line-log.c ##
     @@ line-log.c: static int bloom_filter_check(struct rev_info *rev,
    @@ t/helper/test-bloom.c: static void get_bloom_filter_for_commit(const struct obje
      	setup_git_directory();
      	c = lookup_commit(the_repository, commit_oid);
     -	filter = get_bloom_filter(the_repository, c, 1);
    -+	filter = get_or_compute_bloom_filter(the_repository, c, 1, NULL);
    ++	filter = get_or_compute_bloom_filter(the_repository, c, 1,
    ++					     NULL);
      	print_bloom_filter(filter);
      }

 -:  ---------- > 18:  4deb724fc1 bloom: use provided 'struct bloom_filter_settings'
 -:  ---------- > 19:  d1c4bbcaa9 bloom/diff: properly short-circuit on max_changes
 6:  b31c60d712 ! 20:  e92ccafcf7 commit-graph.c: sort index into commits list
    @@ Commit message
         (commit-graph: examine commits by generation number, 2020-03-30) for
         details).

    -    The subsequent patch will want to recover the new graph position of each
    +    A future patch will want to recover the new graph position of each
         commit. Since the 'packed_commit_list' already stores a double-pointer,
         avoid a 'COPY_ARRAY' and instead keep track of an index into the
         original list. (Use an integer index instead of a memory address, since
    @@ commit-graph.c: struct tree *get_commit_tree_in_graph(struct repository *r, cons
     -	int nr;
     -	int alloc;
     -};
    --
    +
      struct packed_oid_list {
      	struct object_id *list;
    - 	int nr;
     @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_context *ctx)
      {
      	int i;
    @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_cont
     +		&ctx->commits);

      	for (i = 0; i < ctx->commits.nr; i++) {
    + 		int computed = 0;
     -		struct commit *c = sorted_commits[i];
     +		int pos = sorted_commits[i];
     +		struct commit *c = ctx->commits.list[pos];
    - 		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
    - 		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
    - 		display_progress(progress, i + 1);
    + 		struct bloom_filter *filter = get_or_compute_bloom_filter(
    + 			ctx->r,
    + 			c,
 -:  ---------- > 21:  c42d678714 csum-file.h: introduce 'hashwrite_be64()'
 7:  ab78907233 ! 22:  100b26d7c8 commit-graph: add large-filters bitmap chunk
    @@ Metadata
      ## Commit message ##
         commit-graph: add large-filters bitmap chunk

    -    When a commit has 512 changed paths or greater, the commit-graph
    -    machinery represents it as a zero-length filter since having many
    -    entries in the Bloom filter has undesirable effects on the false
    -    positivity rate.
    +    When a commit has more than a certain number of changed paths (commonly
    +    512), the commit-graph machinery represents it as a zero-length filter.
    +    This is done since having many entries in the Bloom filter has
    +    undesirable effects on the false positivity rate.

         In addition to these too-large filters, the commit-graph machinery also
         represents commits with no filter and commits with no changed paths in
    @@ Commit message
         recomputing large filters over and over again.

         This is already undesirable, since it means that we are wasting
    -    considerable effort to discover that a commit has at least 512 changed
    +    considerable effort to discover that a commit with too many changed
         paths, only to throw that effort away (and then repeat the process the
         next time a roll-up is performed).

    -    In a subsequent patch, we will add a '--max-new-filters' option, which
    -    specifies an upper-bound on the number of new filters we are willing to
    -    compute from scratch. Suppose that there are 'N' too-large filters, and
    -    we specify '--max-new-filters=M'. If 'N >= M', it is unlikely that any
    -    filters will be generated, since we'll spend most of our effort on
    -    filters that we ultimately throw away. If 'N < M', filters will trickle
    -    in over time, but only at most 'M - N' per-write.
    +    In a subsequent patch, we will add a '--max-new-filters=<n>' option,
    +    which specifies an upper-bound on the number of new filters we are
    +    willing to compute from scratch. Suppose that there are 'N' too-large
    +    filters, and we specify '--max-new-filters=M'. If 'N >= M', it is
    +    unlikely that any filters will be generated, since we'll spend most of
    +    our effort on filters that we ultimately throw away. If 'N < M', filters
    +    will trickle in over time, but only at most 'M - N' per-write.

         To address this, add a new chunk which encodes a bitmap where the ith
         bit is on iff the ith commit has zero or at least 512 changed paths.
    -    When computing Bloom filters, first consult the relevant bitmap (in the
    -    case that we are rolling up existing layers) to see if computing the
    -    Bloom filter from scratch would be a waste of time.
    +    Likewise store the maximum number of changed paths we are willing to
    +    store in order to prepare for eventually making this value more easily
    +    customizable. When computing Bloom filters, first consult the relevant
    +    bitmap (in the case that we are rolling up existing layers) to see if
    +    computing the Bloom filter from scratch would be a waste of time.

         This patch implements a new chunk instead of extending the existing BIDX
         and BDAT chunks because modifying these chunks would confuse old
    -    clients. For example, consider setting the most-significant bit in an
    -    entry in the BIDX chunk to indicate that that filter is too-large. New
    -    clients would understand how to interpret this, but old clients would
    -    treat that entry as a really large filter.
    +    clients. (Eg., setting the most-significant bit in the BIDX chunk would
    +    confuse old clients and require a version bump).
    +
    +    To allow using the existing bitmap code with 64-bit words, we write the
    +    data in network byte order from the 64-bit words. This means we also
    +    need to read the array from the commit-graph file by translating each
    +    word from network byte order using get_be64() upon first use of the
    +    bitmap. This is only used when writing the commit-graph, so this is a
    +    relatively small operation compared to the other writing code.

         By avoiding the need to move to new versions of the BDAT and BIDX chunk,
         we can give ourselves more time to consider whether or not other
    @@ Commit message
         write a bitmap, but forces older clients to rewrite their commit-graphs
         (as well as reduces the theoretical largest Bloom filters we couldl
         write, and forces us to maintain the code necessary to translate BIDX
    -    chunks to BID2 ones).  Separately from this patch, I implemented this
    +    chunks to BID2 ones). Separately from this patch, I implemented this
         alternate approach and did not find it to be advantageous.

         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    @@ Documentation/technical/commit-graph-format.txt: CHUNK DATA:
          * The BDAT chunk is present if and only if BIDX is present.

     +  Large Bloom Filters (ID: {'B', 'F', 'X', 'L'}) [Optional]
    -+    * It contains a list of 'eword_t's (the length of this list is determined by
    -+      the width of the chunk) which is a bitmap. The 'i'th bit is set exactly
    -+      when the 'i'th commit in the graph has a changed-path Bloom filter with
    -+      zero entries (either because the commit is empty, or because it contains
    -+      more than 512 changed paths).
    -+    * The BFXL chunk is present on newer versions of Git iff the BIDX and BDAT
    -+      chunks are also present.
    ++    * It starts with a 32-bit unsigned integer specifying the maximum number of
    ++      changed-paths that can be stored in a single Bloom filter.
    ++    * It then contains a list of 64-bit words (the length of this list is
    ++      determined by the width of the chunk) which is a bitmap. The 'i'th bit is
    ++      set exactly when the 'i'th commit in the graph has a changed-path Bloom
    ++      filter with zero entries (either because the commit is empty, or because
    ++      it contains more than 512 changed paths).
    ++    * The BFXL chunk is present only when the BIDX and BDAT chunks are
    ++      also present.
    ++
     +
        Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
            This list of H-byte hashes describe a set of B commit-graph files that
            form a commit-graph chain. The graph position for the ith commit in this

    + ## bloom.h ##
    +@@ bloom.h: struct bloom_filter_settings {
    + 	 * The maximum number of changed paths per commit
    + 	 * before declaring a Bloom filter to be too-large.
    + 	 *
    +-	 * Not written to the commit-graph file.
    ++	 * Written to the 'BFXL' chunk (instead of 'BDAT').
    + 	 */
    + 	uint32_t max_changed_paths;
    + };
    +
      ## commit-graph.c ##
     @@ commit-graph.c: void git_test_write_commit_graph_or_die(void)
      #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      			break;
     +
     +		case GRAPH_CHUNKID_BLOOMLARGE:
    -+			if (graph->bloom_large.word_alloc)
    ++			if (graph->chunk_bloom_large_filters)
     +				chunk_repeated = 1;
     +			else if (r->settings.commit_graph_read_changed_paths) {
    -+				uint32_t alloc = get_be64(chunk_lookup + 4) - chunk_offset;
    ++				graph->bloom_large_to_alloc = get_be64(chunk_lookup + 4)
    ++							      - chunk_offset - sizeof(uint32_t);
     +
    -+				graph->bloom_large.word_alloc = alloc;
    -+				graph->bloom_large.words = (eword_t *)(data + chunk_offset);
    ++				graph->bloom_large.word_alloc = 0; /* populate when necessary */
    ++				graph->chunk_bloom_large_filters = data + chunk_offset + sizeof(uint32_t);
    ++				graph->bloom_filter_settings->max_changed_paths = get_be32(data + chunk_offset);
     +			}
     +			break;
      		}
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      		/* We need both the bloom chunks to exist together. Else ignore the data */
      		graph->chunk_bloom_indexes = NULL;
      		graph->chunk_bloom_data = NULL;
    -+		graph->bloom_large.words = NULL;
    -+		graph->bloom_large.word_alloc = 0;
    ++		graph->chunk_bloom_large_filters = NULL;
      		FREE_AND_NULL(graph->bloom_filter_settings);
      	}

    @@ commit-graph.c: struct tree *get_commit_tree_in_graph(struct repository *r, cons
     +	while (g && graph_pos < g->num_commits_in_base)
     +		g = g->base_graph;
     +
    -+	if (!(g && g->bloom_large.word_alloc))
    ++	if (!g || !g->bloom_large_to_alloc)
     +		return 0;
    ++
    ++	if (!g->bloom_large.word_alloc) {
    ++		size_t i;
    ++		g->bloom_large.word_alloc = g->bloom_large_to_alloc;
    ++		g->bloom_large.words = xmalloc(g->bloom_large_to_alloc * sizeof(eword_t));
    ++
    ++		for (i = 0; i < g->bloom_large_to_alloc; i++)
    ++			g->bloom_large.words[i] = get_be64(g->chunk_bloom_large_filters
    ++							   + i * sizeof(eword_t));
    ++	}
    ++
     +	return bitmap_get(&g->bloom_large, graph_pos - g->num_commits_in_base);
     +}
    -+
    +
      struct packed_oid_list {
      	struct object_id *list;
    - 	int nr;
     @@ commit-graph.c: struct write_commit_graph_context {
    - 	const struct split_commit_graph_opts *split_opts;
      	size_t total_bloom_filter_data_size;
      	const struct bloom_filter_settings *bloom_settings;
    -+	struct bitmap *bloom_large;
    -+
    +
     +	int count_bloom_filter_known_large;
    -+	int count_bloom_filter_found_large;
    -+	int count_bloom_filter_computed;
    + 	int count_bloom_filter_found_large;
    + 	int count_bloom_filter_computed;
    ++	struct bitmap *bloom_large;
      };

      static int write_graph_chunk_fanout(struct hashfile *f,
    @@ commit-graph.c: static int write_graph_chunk_bloom_data(struct hashfile *f,
      }

     +static int write_graph_chunk_bloom_large(struct hashfile *f,
    -+					  struct write_commit_graph_context *ctx)
    ++					 struct write_commit_graph_context *ctx)
     +{
    ++	size_t i, alloc = ctx->commits.nr / BITS_IN_EWORD;
    ++	if (ctx->commits.nr % BITS_IN_EWORD)
    ++		alloc++;
    ++	if (alloc > ctx->bloom_large->word_alloc)
    ++		BUG("write_graph_chunk_bloom_large: bitmap not large enough");
    ++
     +	trace2_region_enter("commit-graph", "bloom_large", ctx->r);
    -+	hashwrite(f, ctx->bloom_large->words, ctx->bloom_large->word_alloc * sizeof(eword_t));
    ++	hashwrite_be32(f, ctx->bloom_settings->max_changed_paths);
    ++	for (i = 0; i < ctx->bloom_large->word_alloc; i++)
    ++		hashwrite_be64(f, ctx->bloom_large->words[i]);
     +	trace2_region_leave("commit-graph", "bloom_large", ctx->r);
     +	return 0;
     +}
    @@ commit-graph.c: static int write_graph_chunk_bloom_data(struct hashfile *f,
      static int oid_compare(const void *_a, const void *_b)
      {
      	const struct object_id *a = (const struct object_id *)_a;
    -@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
    - 	stop_progress(&ctx->progress);
    - }
    +@@ commit-graph.c: static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
    + 	struct json_writer jw = JSON_WRITER_INIT;

    -+static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
    -+{
    -+	struct json_writer jw = JSON_WRITER_INIT;
    -+
    -+	jw_object_begin(&jw, 0);
    + 	jw_object_begin(&jw, 0);
     +	jw_object_intmax(&jw, "filter_known_large",
     +			 ctx->count_bloom_filter_known_large);
    -+	jw_object_intmax(&jw, "filter_found_large",
    -+			 ctx->count_bloom_filter_found_large);
    -+	jw_object_intmax(&jw, "filter_computed",
    -+			 ctx->count_bloom_filter_computed);
    -+	jw_end(&jw);
    -+
    -+	trace2_data_json("commit-graph", the_repository, "bloom_statistics", &jw);
    -+
    -+	jw_release(&jw);
    -+}
    -+
    - static void compute_bloom_filters(struct write_commit_graph_context *ctx)
    - {
    - 	int i;
    + 	jw_object_intmax(&jw, "filter_found_large",
    + 			 ctx->count_bloom_filter_found_large);
    + 	jw_object_intmax(&jw, "filter_computed",
     @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_context *ctx)
      	int *sorted_commits;

      	init_bloom_filters();
    -+	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD);
    ++	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD + 1);

      	if (ctx->report_progress)
      		progress = start_delayed_progress(
     @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_context *ctx)
    + 		&ctx->commits);
    +
      	for (i = 0; i < ctx->commits.nr; i++) {
    +-		int computed = 0;
      		int pos = sorted_commits[i];
      		struct commit *c = ctx->commits.list[pos];
    --		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
    --		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
    +-		struct bloom_filter *filter = get_or_compute_bloom_filter(
    +-			ctx->r,
    +-			c,
    +-			1,
    +-			ctx->bloom_settings,
    +-			&computed);
    +-		if (computed) {
    +-			ctx->count_bloom_filter_computed++;
    +-			if (filter && !filter->len)
    +-				ctx->count_bloom_filter_found_large++;
     +		if (get_bloom_filter_large_in_graph(ctx->r->objects->commit_graph, c)) {
     +			bitmap_set(ctx->bloom_large, pos);
     +			ctx->count_bloom_filter_known_large++;
     +		} else {
    -+			struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
    -+			if (!filter->len) {
    -+				bitmap_set(ctx->bloom_large, pos);
    -+				ctx->count_bloom_filter_found_large++;
    ++			int computed = 0;
    ++			struct bloom_filter *filter = get_or_compute_bloom_filter(
    ++				ctx->r,
    ++				c,
    ++				1,
    ++				ctx->bloom_settings,
    ++				&computed);
    ++			if (computed) {
    ++				ctx->count_bloom_filter_computed++;
    ++				if (filter && !filter->len) {
    ++					bitmap_set(ctx->bloom_large, pos);
    ++					ctx->count_bloom_filter_found_large++;
    ++				}
     +			}
     +			ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
    -+			ctx->count_bloom_filter_computed++;
    -+		}
    + 		}
    +-		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
      		display_progress(progress, i + 1);
      	}

    -+	if (trace2_is_enabled())
    -+		trace2_bloom_filter_write_statistics(ctx);
    -+
    - 	free(sorted_commits);
    - 	stop_progress(&progress);
    - }
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
      					  + ctx->total_bloom_filter_data_size;
      		chunks[num_chunks].write_fn = write_graph_chunk_bloom_data;
      		num_chunks++;
     +		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMLARGE;
    -+		chunks[num_chunks].size = sizeof(eword_t) * ctx->bloom_large->word_alloc;
    ++		chunks[num_chunks].size = sizeof(eword_t) * ctx->bloom_large->word_alloc
    ++					+ sizeof(uint32_t);
     +		chunks[num_chunks].write_fn = write_graph_chunk_bloom_large;
     +		num_chunks++;
      	}
      	if (ctx->num_commit_graphs_after > 1) {
      		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
    +@@ commit-graph.c: void free_commit_graph(struct commit_graph *g)
    + 	}
    + 	free(g->filename);
    + 	free(g->bloom_filter_settings);
    ++	bitmap_free(g->bloom_large);
    + 	free(g);
    + }
    +

      ## commit-graph.h ##
     @@
    @@ commit-graph.h: struct commit_graph {
      	const unsigned char *chunk_base_graphs;
      	const unsigned char *chunk_bloom_indexes;
      	const unsigned char *chunk_bloom_data;
    ++	const unsigned char *chunk_bloom_large_filters;
    ++
    ++	size_t bloom_large_to_alloc;
     +	struct bitmap bloom_large;

      	struct bloom_filter_settings *bloom_filter_settings;
    @@ t/t4216-log-bloom.sh: test_expect_success 'correctly report changes over limit'
     +
     +test_expect_success 'Bloom generation does not recompute too-large filters' '
     +	(
    -+		cd 513changes &&
    -+		git commit-graph write --reachable --changed-paths \
    ++		cd limits &&
    ++
    ++		# start from scratch and rebuild
    ++		rm -f .git/objects/info/commit-graph &&
    ++		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=10 \
    ++			git commit-graph write --reachable --changed-paths \
     +			--split=replace &&
     +		test_commit c1 filter &&
    ++
     +		test_bloom_filters_computed "--reachable --changed-paths --split=replace" \
    -+			1 0 1
    ++			2 0 1
     +	)
     +'

 9:  309e76bb17 ! 23:  2ee0b84351 commit-graph: rename 'split_commit_graph_opts'
    @@ Metadata
      ## Commit message ##
         commit-graph: rename 'split_commit_graph_opts'

    -    In a subsequent commit, additional options will be added to the
    -    commit-graph API, which themselves do not have to do with splitting.
    +    In the subsequent commit, additional options will be added to the
    +    commit-graph API which have nothing to do with splitting.

         Rename the 'split_commit_graph_opts' structure to the more-generic
         'commit_graph_opts' to encompass both.
    @@ commit-graph.c: struct write_commit_graph_context {
     +	const struct commit_graph_opts *opts;
      	size_t total_bloom_filter_data_size;
      	const struct bloom_filter_settings *bloom_settings;
    - 	struct bitmap *bloom_large;
    +
     @@ commit-graph.c: static void close_reachable(struct write_commit_graph_context *ctx)
      {
      	int i;
    @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     +	ctx->opts = opts;
      	ctx->total_bloom_filter_data_size = 0;

    - 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
    + 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      			}
      		}
10:  8b670571dc ! 24:  3b66ae4a9c builtin/commit-graph.c: introduce '--max-new-filters=<n>'
    @@ Commit message
         'max_new_filters' variable introduced by the previous patch.

         The command-line option '--max-new-filters' takes precedence over
    -    'graph.maxNewFilters', which is the default value.
    +    'commitGraph.maxNewFilters', which is the default value.
         '--no-max-new-filters' can also be provided, which sets the value back
         to '-1', indicating that an unlimited number of new Bloom filters may be
         generated. (OPT_INTEGER only allows setting the '--no-' variant back to
    @@ Commit message

      ## Documentation/config/commitgraph.txt ##
     @@
    -+commitgraph.maxNewFilters::
    ++commitGraph.maxNewFilters::
     +	Specifies the default value for the `--max-new-filters` option of `git
     +	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
     +
    - commitgraph.readChangedPaths::
    + commitGraph.readChangedPaths::
      	If true, then git will use the changed-path Bloom filters in the
      	commit-graph file (if it exists, and they are present). Defaults to

    @@ Documentation/git-commit-graph.txt: this option is given, future commit-graph wr
      +
     +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
     +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
    -+enforced. Overrides the `graph.maxNewFilters` configuration.
    ++enforced. Overrides the `commitGraph.maxNewFilters` configuration.
     ++
      With the `--split[=<strategy>]` option, write the commit-graph as a
      chain of multiple commit-graph files stored in
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      		OPT_EXPIRY_DATE(0, "expire-time", &write_opts.expire_time,
      			N_("only expire files older than a given date-time")),
     +		OPT_CALLBACK_F(0, "max-new-filters", &write_opts.max_new_filters,
    -+			NULL, N_("maximum number of Bloom filters to compute"),
    ++			NULL, N_("maximum number of changed-path Bloom filters to compute"),
     +			0, write_option_max_new_filters),
      		OPT_END(),
      	};
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)

     +static int git_commit_graph_config(const char *var, const char *value, void *cb)
     +{
    -+	if (!strcmp(var, "graph.maxnewfilters")) {
    ++	if (!strcmp(var, "commitgraph.maxnewfilters")) {
     +		write_opts.max_new_filters = git_config_int(var, value);
     +		return 0;
     +	}
    @@ builtin/commit-graph.c: int cmd_commit_graph(int argc, const char **argv, const
      			     builtin_commit_graph_usage,

      ## commit-graph.c ##
    +@@ commit-graph.c: struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
    + }
    +
    + static int get_bloom_filter_large_in_graph(struct commit_graph *g,
    +-					   const struct commit *c)
    ++					   const struct commit *c,
    ++					   uint32_t max_changed_paths)
    + {
    + 	uint32_t graph_pos = commit_graph_position(c);
    + 	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
     @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_context *ctx)
      	int i;
      	struct progress *progress = NULL;
    @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_cont
     +	int max_new_filters;

      	init_bloom_filters();
    - 	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD);
    + 	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD + 1);
     @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_context *ctx)
      		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
      		&ctx->commits);
    @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_cont
      	for (i = 0; i < ctx->commits.nr; i++) {
      		int pos = sorted_commits[i];
      		struct commit *c = ctx->commits.list[pos];
    -@@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_context *ctx)
    +-		if (get_bloom_filter_large_in_graph(ctx->r->objects->commit_graph, c)) {
    ++		if (get_bloom_filter_large_in_graph(ctx->r->objects->commit_graph,
    ++						    c,
    ++						    ctx->bloom_settings->max_changed_paths)) {
      			bitmap_set(ctx->bloom_large, pos);
      			ctx->count_bloom_filter_known_large++;
      		} else {
    --			struct bloom_filter *filter = get_or_compute_bloom_filter(ctx->r, c, 1, NULL);
    --			if (!filter->len) {
    --				bitmap_set(ctx->bloom_large, pos);
    --				ctx->count_bloom_filter_found_large++;
    -+			int computed = 0;
    -+			struct bloom_filter *filter = get_or_compute_bloom_filter(
    -+				ctx->r, c,
    +@@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_context *ctx)
    + 			struct bloom_filter *filter = get_or_compute_bloom_filter(
    + 				ctx->r,
    + 				c,
    +-				1,
     +				ctx->count_bloom_filter_computed < max_new_filters,
    -+				&computed);
    -+			if (computed) {
    -+				ctx->count_bloom_filter_computed++;
    -+				if (filter && !filter->len) {
    -+					bitmap_set(ctx->bloom_large, pos);
    -+					ctx->count_bloom_filter_found_large++;
    -+				}
    + 				ctx->bloom_settings,
    + 				&computed);
    + 			if (computed) {
    +@@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_context *ctx)
    + 					ctx->count_bloom_filter_found_large++;
    + 				}
      			}
     -			ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
    --			ctx->count_bloom_filter_computed++;
    -+			ctx->total_bloom_filter_data_size += sizeof(unsigned char) * (filter ? filter->len : 0);
    ++			if (filter)
    ++				ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
      		}
      		display_progress(progress, i + 1);
      	}
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation does not recompute t

     +test_expect_success 'Bloom generation is limited by --max-new-filters' '
     +	(
    -+		cd 513changes &&
    ++		cd limits &&
     +		test_commit c2 filter &&
     +		test_commit c3 filter &&
     +		test_commit c4 no-filter &&
     +		test_bloom_filters_computed "--reachable --changed-paths --split=replace --max-new-filters=2" \
    -+			1 0 2
    ++			2 0 2
     +	)
     +'
     +
     +test_expect_success 'Bloom generation backfills previously-skipped filters' '
     +	(
    -+		cd 513changes &&
    ++		cd limits &&
     +		test_bloom_filters_computed "--reachable --changed-paths --split=replace --max-new-filters=1" \
    -+			1 0 1
    ++			2 0 1
     +	)
     +'
     +
--
2.28.0.rc1.13.ge78abce653
