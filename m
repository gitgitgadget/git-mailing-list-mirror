Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ECAC433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554F5206DB
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hheIsLsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgFENAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgFENAi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74B2C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so9030594wmc.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=AMImRG8On05j+CtQb9NobXzAuUoNQeAtZ7bwcAuBRS8=;
        b=hheIsLsiM2U61N9aJxvXY+fHB+2dHd+hBx0Ba6+xoPIFSSSB0jzVis5z5oHSvQNh5B
         /4YNmuVjEYMIISrKH1jdE3EQFKwXtZz93dAtCChOi7N2I0aoYT8EEtiJnKaTgyKPhyuu
         iX5ekiH4Aavpq0B//dNrVj530g07QIVYA77DrsY6jE1+AtJ7KX8DuxazJLKV1BbRJUWM
         7l8naZ3OYf+adSYlDuNn8fnK9W3ChZxrI187KBIQKwom+i04Ejg4VZgGkgs+IGL9et3z
         L/1nSslC10jBTH2yaWSo7zfHUOPdoKwm+healyhodJ5hOhNHX2WO/cxE5H6MFzl59U+C
         Obaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=AMImRG8On05j+CtQb9NobXzAuUoNQeAtZ7bwcAuBRS8=;
        b=f/mnwi5GHHN+CVNjNOzLJ8DINeIlEV2NbTz13zysywtLnWIiKkchoyiikvk0GdpsiK
         gIFE7BlsYuurQIH2xZHfkYLIYphVmsOXYT25dRCBxeexf46HAg3MhLPdpzxVkX4gC4fR
         buS3f/j7jEoWOTit9NzfRR9VddMzou5f/yaKjzELX8tuZgXxgGWeaoO1AeAv4zkO87ZJ
         VlqvPGGhRjXWXOFgo0DHiv74wdhy/Vj4KxW34Cw/XC9lLdHX2Ht4eSnTDeeBrXYegkh8
         52cKFw607G1sy/xBoQ8AsHpcg3lJgBz3xbjRWewyBUfsme1mosS6jU5x38Gs+7+SAdSX
         6IdA==
X-Gm-Message-State: AOAM531rRNAX5oeQGs7TGSUyTM5rlGx64EwJR0EJJfnCNPBqffp3CKrK
        3GUZMOJKXMP33eUgJ29k3JF3okxo
X-Google-Smtp-Source: ABdhPJzwNMBp/2e4/TTP0O21B3AHjAiuMFDhNxUAIbxmQ0ZH+B4UxXLtHNDhYX1DspaQ220v4BFW7A==
X-Received: by 2002:a1c:3987:: with SMTP id g129mr2606359wma.139.1591362035466;
        Fri, 05 Jun 2020 06:00:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11sm11954709wrm.13.2020.06.05.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:34 -0700 (PDT)
Message-Id: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:22 +0000
Subject: [PATCH 00/10] Szeder's commit-graph cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/line-log-on-bloom.

Since Szeder so kindly shared his alternate Bloom filter implementation [1],
I thought it worth my time to start the process of updating the patches to
apply to more recent code in Git. Here is the effort to update the almost
obviously-good commit-graph cleanups that he presented in that series.

[1] https://lore.kernel.org/git/20200529085038.26008-1-szeder.dev@gmail.com/

The range-diff below was created by applying his entire series onto v2.25.0
and then doing cherry-picks as appropriate onto ds/line-log-on-bloom and
correcting conflicts. I have Szeder's original series available as
"szeder-bloom" on my fork [2].

[2] https://github.com/derrickstolee/git/tree/szeder-bloom

As expected, the write_commit_graph_file() cleanups were the most difficult,
in part because we added extra chunks with the changed-path Bloom filters.

I did not include this commit since we already handle it mostly with the
MAX_NUM_CHUNKS macro from 08fd81c9 (commit-graph: implement
write_commit_graph(), 2018-04-02):

11:  56e3c4f57b3 <  -:  ----------- commit-graph: allocate the 'struct chunk_info' array dinamically

There were a few cleanups that I did not apply because they are more
involved to handle the conflicts with the changed-path Bloom filters,
especially because we pass a "struct bloom_filter_settings" in the method
signatures for the write_graph_chunk_bloom_*() functions:

12:  28fb1b5bdfe <  -:  ----------- commit-graph: unify the signatures of all write_graph_chunk_*() functions
13:  1e1e59e2592 <  -:  ----------- commit-graph: simplify write_commit_graph_file() #3
14:  6f0d912e4b8 <  -:  ----------- commit-graph: check chunk sizes after writing

I'm not saying that we shouldn't do these changes. I'm just saying that they
are more involved and can wait for a second series. No need to rush things.

The rest will need to be completely re-implemented to keep the other things
in mind, like split commit-graphs and the existing changed-path Bloom
filters. However, the following commits would be particularly interesting to
have equivalents on top of our existing Bloom filter implementation. That
would allow a more fair comparison between the two options:

26:  3951fdedf6a <  -:  ----------- commit-graph: deduplicate modified path Bloom filters
27:  5aba19a2766 <  -:  ----------- commit-graph: load modified path Bloom filters for merge commits
29:  f87b37bf08e <  -:  ----------- commit-graph: extract init and free write_commit_graph_context
34:  8b40ec4cd30 <  -:  ----------- commit-graph: use modified path Bloom filters with wildcards, if possible

Full range diff:

 1:  7a8dbfba53a !  1:  af84c253b24 tree-walk.c: don't match submodule entries for 'submod/anything'
    @@ Commit message
         Fix this by rejecting submodules as partial pathnames when their
         trailing slash is followed by anything.

         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## t/t4010-diff-pathspec.sh ##
     @@ t/t4010-diff-pathspec.sh: test_expect_success 'setup submodules' '
 2:  df25e984c58 !  2:  1e1671e7c69 commit-graph: fix parsing the Chunk Lookup table
    @@ Commit message
         but that is a more invasive change, less suitable for 'maint', so that
         will be done in later patches.

    +    This additional flexibility of scanning more chunks breaks a test for
    +    "git commit-graph verify" so alter that test to mutate the commit-graph
    +    to have an even lower chunk count.
    +
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## commit-graph.c ##
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(void *graph_map, int fd,
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(void *graph_map, int fd,
              uint32_t chunk_id;
              uint64_t chunk_offset;
              int chunk_repeated = 0;
    +
    + ## t/t5318-commit-graph.sh ##
    +@@ t/t5318-commit-graph.sh: test_expect_success 'detect bad hash version' '
    + '
    + 
    + test_expect_success 'detect low chunk count' '
    +-    corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\02" \
    ++    corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\01" \
    +         "missing the .* chunk"
    + '
    + 
 3:  598f7f9a978 !  3:  a09d0bd5b7a commit-graph-format.txt: all multi-byte numbers are in network byte order
    @@ Commit message

         Clarify that all multi-byte integers are in network byte order.

         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## Documentation/technical/commit-graph-format.txt ##
     @@ Documentation/technical/commit-graph-format.txt: the body into "chunks" and provide a binary lookup table at the beginning
 4:  b29e5d39ed6 !  4:  32a6f11cc47 commit-slab: add a function to deep free entries on the slab
    @@ Commit message
         Use it in get_shallow_commits() in 'shallow.c' to replace an
         open-coded iteration over a commit slab's entries.

         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## commit-slab-decl.h ##
     @@ commit-slab-decl.h: struct slabname {                            \
    @@ shallow.c: int is_repository_shallow(struct repository *r)
       * supports a "valid" flag.
       */
      define_commit_slab(commit_depth, int *);
    -+void free_depth_in_slab(int **ptr)
    ++static void free_depth_in_slab(int **ptr)
     +{
     +    FREE_AND_NULL(*ptr);
     +}
 5:  18f4db7bfb9 !  5:  1a70ff05aea diff.h: drop diff_tree_oid() & friends' return value
    @@ Commit message
         [2] diff_tree_oid() traces back to diff-tree.c:main() in 9174026cfe as
             well.

         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## diff.h ##
     @@ diff.h: struct combine_diff_path *diff_tree_paths(
    @@ revision.c: static int rev_compare_tree(struct rev_info *revs,
     -               &revs->pruning) < 0)
     -        return REV_TREE_DIFFERENT;
     +    diff_tree_oid(&t1->object.oid, &t2->object.oid, "", &revs->pruning);
    -     return tree_difference;
    - }
    + 
    +     if (!nth_parent)
    +         if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
    +@@ revision.c: static int rev_compare_tree(struct rev_info *revs,

      static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
      {
    @@ tree-diff.c: static struct combine_diff_path *ll_diff_tree_paths(
          const struct object_id **parents_oid, int nparent,
          struct strbuf *base, struct diff_options *opt);
     -static int ll_diff_tree_oid(const struct object_id *old_oid,
    +-                const struct object_id *new_oid,
    +-                struct strbuf *base, struct diff_options *opt);
     +static void ll_diff_tree_oid(const struct object_id *old_oid,
    -                 const struct object_id *new_oid,
    -                 struct strbuf *base, struct diff_options *opt);
    ++                 const struct object_id *new_oid,
    ++                 struct strbuf *base, struct diff_options *opt);

    + /*
    +  * Compare two tree entries, taking into account only path/S_ISDIR(mode),
     @@ tree-diff.c: static void try_to_follow_renames(const struct object_id *old_oid,
          q->nr = 1;
      }

     -static int ll_diff_tree_oid(const struct object_id *old_oid,
    +-                const struct object_id *new_oid,
    +-                struct strbuf *base, struct diff_options *opt)
     +static void ll_diff_tree_oid(const struct object_id *old_oid,
    -                 const struct object_id *new_oid,
    -                 struct strbuf *base, struct diff_options *opt)
    ++                 const struct object_id *new_oid,
    ++                 struct strbuf *base, struct diff_options *opt)
      {
    +     struct combine_diff_path phead, *p;
    +     pathchange_fn_t pathchange_old = opt->pathchange;
     @@ tree-diff.c: static int ll_diff_tree_oid(const struct object_id *old_oid,
          }

    @@ tree-diff.c: static int ll_diff_tree_oid(const struct object_id *old_oid,
      }

     -int diff_root_tree_oid(const struct object_id *new_oid, const char *base, struct diff_options *opt)
    -+void diff_root_tree_oid(const struct object_id *new_oid, const char *base,
    ++void diff_root_tree_oid(const struct object_id *new_oid,
    ++            const char *base,
     +            struct diff_options *opt)
      {
     -    return diff_tree_oid(NULL, new_oid, base, opt);
 6:  bf336f109e6 !  6:  636c2069659 commit-graph: clean up #includes
    @@ Commit message
         'commit-graph.c' includes 'dir.h', but doesn't actually use anything
         from there, so let's drop that #include as well.

         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## commit-graph.c ##
     @@
    @@ commit-graph.h
     -#include "repository.h"
     -#include "string-list.h"
     -#include "cache.h"
    -+#include "hash.h"
    + #include "object-store.h"

      #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
    - #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
    +@@ commit-graph.h: void git_test_write_commit_graph_or_die(void);

      struct commit;
    + struct bloom_filter_settings;
     +struct repository;
     +struct raw_object_store;
     +struct string_list;

    - char *get_commit_graph_filename(const char *obj_dir);
    + char *get_commit_graph_filename(struct object_directory *odb);
      int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 7:  b7f0f831bcf !  7:  cd9e033d1b1 commit-graph: simplify parse_commit_graph() #1
    @@ Commit message
         and, consequently, have to update the 'detect incorrect chunk count'
         test in 't5318-commit-graph.sh' as well.

         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## commit-graph.c ##
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 8:  f2752000052 !  8:  83641b5e49e commit-graph: simplify parse_commit_graph() #2
    @@ Commit message
         iteration, so we can calculate the size of each chunk right away,
         right where we store its starting offset.

         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## commit-graph.c ##
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(void *graph_map, int fd,
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(void *graph_map, int fd,
     +    next_chunk_offset = get_be64(chunk_lookup + 4);
     +    for (i = 0; i < graph->num_chunks; i++) {
              uint32_t chunk_id;
    -         uint64_t chunk_offset;
    +-        uint64_t chunk_offset;
    ++        uint64_t chunk_offset = next_chunk_offset;
              int chunk_repeated = 0;

              chunk_id = get_be32(chunk_lookup + 0);
     -        chunk_offset = get_be64(chunk_lookup + 4);
    -+        chunk_offset = next_chunk_offset;
    -+        next_chunk_offset = get_be64(chunk_lookup + 4 +
    -+                         GRAPH_CHUNKLOOKUP_WIDTH);

              chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
    ++        next_chunk_offset = get_be64(chunk_lookup + 4);

    +         if (chunk_offset > graph_size - the_hash_algo->rawsz) {
    +             error(_("commit-graph improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(void *graph_map, int fd,
              case GRAPH_CHUNKID_OIDLOOKUP:
                  if (graph->chunk_oid_lookup)
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(void *graph_map, int fd,
     -        last_chunk_offset = chunk_offset;
          }

    -     hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
    +     if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {

I'm stepping out of the range-diff to point out that this change is mostly
stylistic.

 9:  4e184b8743c !  9:  9b818b9cb91 commit-graph: simplify write_commit_graph_file() #1
    @@ Commit message
         fill the arrays of chunk IDs and sizes in one go, eliminating one set
         of repeated conditions.

         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## commit-graph.c ##
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
          struct hashfile *f;
          struct lock_file lk = LOCK_INIT;
    -     uint32_t chunk_ids[6];
    --    uint64_t chunk_offsets[6];
    -+    uint64_t chunk_sizes[6];
    +     uint32_t chunk_ids[MAX_NUM_CHUNKS + 1];
    +-    uint64_t chunk_offsets[MAX_NUM_CHUNKS + 1];
    ++    uint64_t chunk_sizes[MAX_NUM_CHUNKS + 1];
          const unsigned hashsz = the_hash_algo->rawsz;
          struct strbuf progress_title = STRBUF_INIT;
          int num_chunks = 3;
     +    uint64_t chunk_offset;
          struct object_id file_hash;
    +     const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;

    -     if (ctx->split) {
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
          }

    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
     +    chunk_sizes[1] = hashsz * ctx->commits.nr;
          chunk_ids[2] = GRAPH_CHUNKID_DATA;
     +    chunk_sizes[2] = (hashsz + 16) * ctx->commits.nr;
    ++
          if (ctx->num_extra_edges) {
              chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
    -+        chunk_sizes[3] = 4 * ctx->num_extra_edges;
    ++        chunk_sizes[num_chunks] = 4 * ctx->num_extra_edges;
    +         num_chunks++;
    +     }
    +     if (ctx->changed_paths) {
    +         chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMINDEXES;
    ++        chunk_sizes[num_chunks] = sizeof(uint32_t) * ctx->commits.nr;
    +         num_chunks++;
    +         chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMDATA;
    ++        chunk_sizes[num_chunks] = sizeof(uint32_t) * 3
    ++                      + ctx->total_bloom_filter_data_size;
              num_chunks++;
          }
          if (ctx->num_commit_graphs_after > 1) {
              chunk_ids[num_chunks] = GRAPH_CHUNKID_BASE;
    -+        chunk_sizes[4] = hashsz * (ctx->num_commit_graphs_after - 1);
    ++        chunk_sizes[num_chunks] = hashsz * (ctx->num_commit_graphs_after - 1);
              num_chunks++;
          }

    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
     -                        4 * ctx->num_extra_edges;
     -        num_chunks++;
     -    }
    +-    if (ctx->changed_paths) {
    +-        chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
    +-                        sizeof(uint32_t) * ctx->commits.nr;
    +-        num_chunks++;
    +-
    +-        chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
    +-                        sizeof(uint32_t) * 3 + ctx->total_bloom_filter_data_size;
    +-        num_chunks++;
    +-    }
     -    if (ctx->num_commit_graphs_after > 1) {
     -        chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
     -                        hashsz * (ctx->num_commit_graphs_after - 1);
10:  344dd337da5 ! 10:  5984fb01ebc commit-graph: simplify write_commit_graph_file() #2
    @@ Commit message
         'struct chunk_info'.  This will allow more cleanups in the following
         patches.

         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## commit-graph.c ##
     @@ commit-graph.c: static int write_graph_chunk_base(struct hashfile *f,
    @@ commit-graph.c: static int write_graph_chunk_base(struct hashfile *f,
          int fd;
          struct hashfile *f;
          struct lock_file lk = LOCK_INIT;
    --    uint32_t chunk_ids[6];
    --    uint64_t chunk_sizes[6];
    -+    struct chunk_info chunks[6];
    +-    uint32_t chunk_ids[MAX_NUM_CHUNKS + 1];
    +-    uint64_t chunk_sizes[MAX_NUM_CHUNKS + 1];
    ++    struct chunk_info chunks[MAX_NUM_CHUNKS + 1];
          const unsigned hashsz = the_hash_algo->rawsz;
          struct strbuf progress_title = STRBUF_INIT;
          int num_chunks = 3;
    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
     -    chunk_sizes[1] = hashsz * ctx->commits.nr;
     -    chunk_ids[2] = GRAPH_CHUNKID_DATA;
     -    chunk_sizes[2] = (hashsz + 16) * ctx->commits.nr;
    +-
     +    chunks[0].id = GRAPH_CHUNKID_OIDFANOUT;
     +    chunks[0].size = GRAPH_FANOUT_SIZE;
     +    chunks[1].id = GRAPH_CHUNKID_OIDLOOKUP;
    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
     +    chunks[2].size = (hashsz + 16) * ctx->commits.nr;
          if (ctx->num_extra_edges) {
     -        chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
    --        chunk_sizes[3] = 4 * ctx->num_extra_edges;
    +-        chunk_sizes[num_chunks] = 4 * ctx->num_extra_edges;
     +        chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
     +        chunks[num_chunks].size = 4 * ctx->num_extra_edges;
              num_chunks++;
          }
    +     if (ctx->changed_paths) {
    +-        chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMINDEXES;
    +-        chunk_sizes[num_chunks] = sizeof(uint32_t) * ctx->commits.nr;
    ++        chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMINDEXES;
    ++        chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
    +         num_chunks++;
    +-        chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMDATA;
    +-        chunk_sizes[num_chunks] = sizeof(uint32_t) * 3
    ++        chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMDATA;
    ++        chunks[num_chunks].size = sizeof(uint32_t) * 3
    +                       + ctx->total_bloom_filter_data_size;
    +         num_chunks++;
    +     }
          if (ctx->num_commit_graphs_after > 1) {
     -        chunk_ids[num_chunks] = GRAPH_CHUNKID_BASE;
    --        chunk_sizes[4] = hashsz * (ctx->num_commit_graphs_after - 1);
    +-        chunk_sizes[num_chunks] = hashsz * (ctx->num_commit_graphs_after - 1);
     +        chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
     +        chunks[num_chunks].size = hashsz * (ctx->num_commit_graphs_after - 1);
              num_chunks++;
11:  56e3c4f57b3 <  -:  ----------- commit-graph: allocate the 'struct chunk_info' array dinamically
12:  28fb1b5bdfe <  -:  ----------- commit-graph: unify the signatures of all write_graph_chunk_*() functions
13:  1e1e59e2592 <  -:  ----------- commit-graph: simplify write_commit_graph_file() #3
14:  6f0d912e4b8 <  -:  ----------- commit-graph: check chunk sizes after writing
15:  0ab955aac32 <  -:  ----------- commit-graph-format.txt: document the modified path Bloom filter chunks
16:  4c128d51dfe <  -:  ----------- Add a generic and minimal Bloom filter implementation
17:  41f02bc38f7 <  -:  ----------- Import a streaming-capable Murmur3 hash function implementation
18:  e5fd1da48d4 <  -:  ----------- commit-graph: write "empty" Modified Path Bloom Filter Index chunk
19:  2dd882ec601 <  -:  ----------- commit-graph: add commit slab for modified path Bloom filters
20:  f30e495c2b0 <  -:  ----------- commit-graph: fill the Modified Path Bloom Filter Index chunk
21:  e904cb58301 <  -:  ----------- commit-graph: load and use the Modified Path Bloom Filter Index chunk
22:  c71647ca374 <  -:  ----------- commit-graph: write the Modified Path Bloom Filters chunk
23:  50898d42291 <  -:  ----------- commit-graph: load and use the Modified Path Bloom Filters chunk
24:  dc96f0d9822 <  -:  ----------- commit-graph: check all leading directories in modified path Bloom filters
25:  7cbf1bc6b66 <  -:  ----------- commit-graph: check embedded modified path Bloom filters with a mask
26:  3951fdedf6a <  -:  ----------- commit-graph: deduplicate modified path Bloom filters
27:  5aba19a2766 <  -:  ----------- commit-graph: load modified path Bloom filters for merge commits
28:  93fc6af1d2f <  -:  ----------- commit-graph: write Modified Path Bloom Filter Merge Index chunk
29:  f87b37bf08e <  -:  ----------- commit-graph: extract init and free write_commit_graph_context
30:  943b0d9554c <  -:  ----------- commit-graph: move write_commit_graph_reachable below write_commit_graph
31:  47b26ea61aa <  -:  ----------- t7007-show: make the first test compatible with the next patch
32:  9201b71071c <  -:  ----------- PoC commit-graph: use revision walk machinery for '--reachable'
33:  5c72d97e5e9 <  -:  ----------- commit-graph: write modified path Bloom filters in "history order"
34:  8b40ec4cd30 <  -:  ----------- commit-graph: use modified path Bloom filters with wildcards, if possible

Thanks, -Stolee

SZEDER Gábor (10):
  tree-walk.c: don't match submodule entries for 'submod/anything'
  commit-graph: fix parsing the Chunk Lookup table
  commit-graph-format.txt: all multi-byte numbers are in network byte
    order
  commit-slab: add a function to deep free entries on the slab
  diff.h: drop diff_tree_oid() & friends' return value
  commit-graph: clean up #includes
  commit-graph: simplify parse_commit_graph() #1
  commit-graph: simplify parse_commit_graph() #2
  commit-graph: simplify write_commit_graph_file() #1
  commit-graph: simplify write_commit_graph_file() #2

 .../technical/commit-graph-format.txt         |   2 +-
 commit-graph.c                                | 113 ++++++++----------
 commit-graph.h                                |   6 +-
 commit-slab-decl.h                            |   1 +
 commit-slab-impl.h                            |  13 ++
 commit-slab.h                                 |  10 ++
 diff.h                                        |  10 +-
 revision.c                                    |   9 +-
 shallow.c                                     |  14 +--
 t/t4010-diff-pathspec.sh                      |   4 +-
 t/t5318-commit-graph.sh                       |   5 +-
 tree-diff.c                                   |  30 +++--
 tree-walk.c                                   |   9 +-
 13 files changed, 117 insertions(+), 109 deletions(-)


base-commit: f32dde8c12d941065be848a9f66239df96bde216
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-650%2Fderrickstolee%2Fbloom-improvements-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-650/derrickstolee/bloom-improvements-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/650
-- 
gitgitgadget
