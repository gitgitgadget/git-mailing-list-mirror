Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BE0C433E3
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA48C206F1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcpsNj1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgFOUO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbgFOUO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:14:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF69CC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:14:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so855720wmh.5
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=j6ivDCxC5U8C7/9bJ9G66og3l4XFJZqIXhyehYxPET8=;
        b=qcpsNj1X3qRr4dkxBL6EV3ExolhlhfiS7Ay0gfB9urDvxcdeXKQQu97YVEn34t4QiN
         70YVCdHrQdn9dlXk5lcJH464EKY2/fTXOXDQyedtqJaId4NF48Skh2sPpjWW44TKEmeG
         NtK9NG04j9EdiOpI2kY/l522MQcI6LQuVGxMzWzScJtU9L9l8vwkdUq9cjXAO0mvOrXs
         ijlZM7HRN0dXldok1eWtHdr8OSWjU4X9CrfMRBQM5Uz7b8fdtdgh9apeUQlJ7hw65qI5
         7MHGPu5vyUb5TYyDDRWHGuQMxdaDP2JgKxnqYBaJpAVDmmeRpjfCxEmlv696hnjfuRUK
         NCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=j6ivDCxC5U8C7/9bJ9G66og3l4XFJZqIXhyehYxPET8=;
        b=VRX0udbw3oZlrVMn+ZX9B3SmgYNzZQzgb3fBPUzePjtjHTFb+Cx/yo10EywmPzBqag
         qPhAv3x5b2MJw9u3qJpXUXv4LSc8fqAfobWTRbI5eMBhTA76PcgeLcnS3tDXrPgInUPl
         xboHdKe4HqKTrEXngyBZRjtwj1ZzVzVlu8DlEIb9bPMJETFbVm1XyFv5MiPRgTaZO4p+
         fU/0yMa2vpe2QQKOWcUuKxhXT6DDugCUW/8haAqzD5O/RSIFl4+bPA9l93vLE+4Hhb/k
         rKnYIQPz/sRfq2Ltn7QwGqgZGJPGKVWtk+oDN0AL+p+zdKkJihxJcmt3du/pd8SIAvrh
         at/w==
X-Gm-Message-State: AOAM532ZD1KPJahK/uU471WmqpzdiZkCx796ytbpshNcfR3QOCGUH3g6
        imjPUGenq8bnp0EKqnrbM985zTXP
X-Google-Smtp-Source: ABdhPJyiQpwTaULD1kRiD2ATID1WQYSBS5IbZ0f9onWkMA+O6vtES9LoNF0WV49vLKiMGbMOgF5q7A==
X-Received: by 2002:a1c:188:: with SMTP id 130mr1003325wmb.93.1592252094965;
        Mon, 15 Jun 2020 13:14:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm27187007wrb.94.2020.06.15.13.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:14:54 -0700 (PDT)
Message-Id: <pull.659.git.1592252093.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 20:14:45 +0000
Subject: [PATCH 0/8] More commit-graph/Bloom filter improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This builds on sg/commit-graph-cleanups, which took several patches from
Szeder's series [1] and applied them almost directly to a more-recent
version of Git [2].

[1] https://lore.kernel.org/git/20200529085038.26008-1-szeder.dev@gmail.com/
[2] 
https://lore.kernel.org/git/pull.650.git.1591362032.gitgitgadget@gmail.com/

This series adds a few extra improvements, several of which are rooted in
Szeder's original series. I maintained his authorship and sign-off, even
though the patches did not apply or cherry-pick at all.

 1. commit-graph: place bloom_settings in context
 2. commit-graph: unify the signatures of all write_graph_chunk_*()
    functions
 3. commit-graph: simplify chunk writes into loop
 4. commit-graph: check chunk sizes after writing
 5. commit-graph: check all leading directories in changed path Bloom
    filters

Patch 1 is a new preparation patch to then apply Szeder's ideas in the next
four. Some are refactoring or defensive programming, but Patch 5 presents a
meaningful performance improvement. By creating bloom_keys for each leading
directory in a path, we can greatly improve the false-positive rate.

 6. bloom: enforce a minimum size of 8 bytes

Patch 6 is based on a comment of Szeder's that since we are using 1-byte
alignment in the filters, that some small filters do not fit the theoretical
analysis that calculated the expected false-positive rate. By increasing the
minimum (non-zero) filter size, we can gain significant performance benefits
while increasing the file size a small amount.

 7. commit-graph: change test to die on parse, not load
 8. commit-graph: persist existence of changed-paths

The final two patches handle the unresolved usability issue: if a user
writes a commit-graph with --changed-paths, the next write will probably
clear them out. Think about gc.writeCommitGraph or fetch.writeCommitGraph,
which do not allow for the --changed-paths option directly. Another idea is
to add a config option, but I will leave that to others [3].

[3] https://github.com/gitgitgadget/git/pull/633

Here is an analysis of the range-diff between this series and Szeder's PoC
submission.

These patches either are part of sg/commit-graph-cleanups or were discarded
as unnecessary.

 1:  7a8dbfba53a <  -:  ----------- tree-walk.c: don't match submodule entries for 'submod/anything'
 2:  df25e984c58 <  -:  ----------- commit-graph: fix parsing the Chunk Lookup table
 3:  598f7f9a978 <  -:  ----------- commit-graph-format.txt: all multi-byte numbers are in network byte order
 4:  b29e5d39ed6 <  -:  ----------- commit-slab: add a function to deep free entries on the slab
 5:  18f4db7bfb9 <  -:  ----------- diff.h: drop diff_tree_oid() & friends' return value
 6:  bf336f109e6 <  -:  ----------- commit-graph: clean up #includes
 7:  b7f0f831bcf <  -:  ----------- commit-graph: simplify parse_commit_graph() #1
 8:  f2752000052 <  -:  ----------- commit-graph: simplify parse_commit_graph() #2
 9:  4e184b8743c <  -:  ----------- commit-graph: simplify write_commit_graph_file() #1
10:  344dd337da5 <  -:  ----------- commit-graph: simplify write_commit_graph_file() #2
11:  56e3c4f57b3 <  -:  ----------- commit-graph: allocate the 'struct chunk_info' array dinamically

This first patch enables the next refactoring patch.

 -:  ----------- >  1:  c966969071b commit-graph: place bloom_settings in context

This patch is recognized as similar, but all differences are due to
whitespace corrections and the new write_graph_chunk_*() methods.

12:  28fb1b5bdfe !  2:  65eb15221c8 commit-graph: unify the signatures of all write_graph_chunk_*() functions
    @@ Commit message
         This opens up the possibility for further cleanups and foolproofing in
         the following two patches.

         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## commit-graph.c ##
     @@ commit-graph.c: struct write_commit_graph_context {
    -     const struct split_commit_graph_opts *split_opts;
    +     struct bloom_filter_settings bloom_settings;
      };

     -static void write_graph_chunk_fanout(struct hashfile *f,
    +-                     struct write_commit_graph_context *ctx)
     +static int write_graph_chunk_fanout(struct hashfile *f,
    -                      struct write_commit_graph_context *ctx)
    ++                    struct write_commit_graph_context *ctx)
      {
          int i, count = 0;
    +     struct commit **list = ctx->commits.list;
     @@ commit-graph.c: static void write_graph_chunk_fanout(struct hashfile *f,

              hashwrite_be32(f, count);
          }
    ++
     +    return 0;
      }

     -static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
    +-                   struct write_commit_graph_context *ctx)
     +static int write_graph_chunk_oids(struct hashfile *f,
    -                    struct write_commit_graph_context *ctx)
    ++                  struct write_commit_graph_context *ctx)
      {
          struct commit **list = ctx->commits.list;
          int count;
          for (count = 0; count < ctx->commits.nr; count++, list++) {
              display_progress(ctx->progress, ++ctx->progress_cnt);
     -        hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
    -+        hashwrite(f, (*list)->object.oid.hash, the_hash_algo->rawsz);
    ++        hashwrite(f, (*list)->object.oid.hash, (int)the_hash_algo->rawsz);
          }
    ++
     +    return 0;
      }

    @@ commit-graph.c: static const unsigned char *commit_to_sha1(size_t index, void *t
      }

     -static void write_graph_chunk_data(struct hashfile *f, int hash_len,
    +-                   struct write_commit_graph_context *ctx)
     +static int write_graph_chunk_data(struct hashfile *f,
    -                    struct write_commit_graph_context *ctx)
    ++                  struct write_commit_graph_context *ctx)
      {
          struct commit **list = ctx->commits.list;
    +     struct commit **last = ctx->commits.list + ctx->commits.nr;
     @@ commit-graph.c: static void write_graph_chunk_data(struct hashfile *f, int hash_len,
                  die(_("unable to parse commit %s"),
                      oid_to_hex(&(*list)->object.oid));
    @@ commit-graph.c: static void write_graph_chunk_data(struct hashfile *f, int hash_

              list++;
          }
    ++
     +    return 0;
      }

     -static void write_graph_chunk_extra_edges(struct hashfile *f,
    +-                      struct write_commit_graph_context *ctx)
     +static int write_graph_chunk_extra_edges(struct hashfile *f,
    -                       struct write_commit_graph_context *ctx)
    ++                     struct write_commit_graph_context *ctx)
      {
          struct commit **list = ctx->commits.list;
    +     struct commit **last = ctx->commits.list + ctx->commits.nr;
     @@ commit-graph.c: static void write_graph_chunk_extra_edges(struct hashfile *f,

              list++;
          }
    ++
    ++    return 0;
    + }
    + 
    +-static void write_graph_chunk_bloom_indexes(struct hashfile *f,
    +-                        struct write_commit_graph_context *ctx)
    ++static int write_graph_chunk_bloom_indexes(struct hashfile *f,
    ++                       struct write_commit_graph_context *ctx)
    + {
    +     struct commit **list = ctx->commits.list;
    +     struct commit **last = ctx->commits.list + ctx->commits.nr;
    +@@ commit-graph.c: static void write_graph_chunk_bloom_indexes(struct hashfile *f,
    +     }
    + 
    +     stop_progress(&progress);
    ++    return 0;
    + }
    + 
    +-static void write_graph_chunk_bloom_data(struct hashfile *f,
    +-                     struct write_commit_graph_context *ctx)
    ++static int write_graph_chunk_bloom_data(struct hashfile *f,
    ++                    struct write_commit_graph_context *ctx)
    + {
    +     struct commit **list = ctx->commits.list;
    +     struct commit **last = ctx->commits.list + ctx->commits.nr;
    +@@ commit-graph.c: static void write_graph_chunk_bloom_data(struct hashfile *f,
    +     }
    + 
    +     stop_progress(&progress);
     +    return 0;
      }

      static int oid_compare(const void *_a, const void *_b)
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
    -             chunks_nr * ctx->commits.nr);
    +             num_chunks * ctx->commits.nr);
          }
          write_graph_chunk_fanout(f, ctx);
     -    write_graph_chunk_oids(f, hashsz, ctx);
    @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
     +    write_graph_chunk_data(f, ctx);
          if (ctx->num_extra_edges)
              write_graph_chunk_extra_edges(f, ctx);
    -     if (ctx->num_commit_graphs_after > 1 &&
    +     if (ctx->changed_paths) {

These patches follow the same intent, but are significantly different
because they are updated with split commit-graphs and the existing
changed-path Bloom filters.

13:  1e1e59e2592 <  -:  ----------- commit-graph: simplify write_commit_graph_file() #3
 -:  ----------- >  3:  3d24b9802df commit-graph: simplify chunk writes into loop
14:  6f0d912e4b8 <  -:  ----------- commit-graph: check chunk sizes after writing
 -:  ----------- >  4:  bdca834e6da commit-graph: check chunk sizes after writing
24:  dc96f0d9822 <  -:  ----------- commit-graph: check all leading directories in modified path Bloom filters
 -:  ----------- >  5:  9975fc96f12 commit-graph: check all leading directories in changed path Bloom filters

These three patches are a few valuable improvements of my own design:

 -:  ----------- >  6:  2a5f1e17528 bloom: enforce a minimum size of 8 bytes
 -:  ----------- >  7:  60bbc15d24a commit-graph: change test to die on parse, not load
 -:  ----------- >  8:  db5b8fe8439 commit-graph: persist existence of changed-paths

At this point, we have updated the existing changed-path Bloom filter
implementation to be on even terms with Szeder's modified-path Bloom filter
implementation.

The next batch of patches contain Szeder's implementation. These implement a
completely different file format, so they are not intended as ways to move
forward. If there is a significant improvement to be found by using this
file format instead of the established one (comparing the old implementation
with these patches), then we could consider swapping the optional chunks for
those that he proposes.

While I had the motivation and energy to defend the current implementation
by applying Szeder's (excellent) ideas to the existing format, I do not have
intent to go through the effort to compare the file formats explicitly at
this point. I would be interested to read a performance analysis, if someone
were to provide one now.

15:  0ab955aac32 <  -:  ----------- commit-graph-format.txt: document the modified path Bloom filter chunks
16:  4c128d51dfe <  -:  ----------- Add a generic and minimal Bloom filter implementation
17:  41f02bc38f7 <  -:  ----------- Import a streaming-capable Murmur3 hash function implementation
18:  e5fd1da48d4 <  -:  ----------- commit-graph: write "empty" Modified Path Bloom Filter Index chunk
19:  2dd882ec601 <  -:  ----------- commit-graph: add commit slab for modified path Bloom filters
20:  f30e495c2b0 <  -:  ----------- commit-graph: fill the Modified Path Bloom Filter Index chunk
21:  e904cb58301 <  -:  ----------- commit-graph: load and use the Modified Path Bloom Filter Index chunk
22:  c71647ca374 <  -:  ----------- commit-graph: write the Modified Path Bloom Filters chunk
23:  50898d42291 <  -:  ----------- commit-graph: load and use the Modified Path Bloom Filters chunk
25:  7cbf1bc6b66 <  -:  ----------- commit-graph: check embedded modified path Bloom filters with a mask
26:  3951fdedf6a <  -:  ----------- commit-graph: deduplicate modified path Bloom filters
27:  5aba19a2766 <  -:  ----------- commit-graph: load modified path Bloom filters for merge commits
28:  93fc6af1d2f <  -:  ----------- commit-graph: write Modified Path Bloom Filter Merge Index chunk
29:  f87b37bf08e <  -:  ----------- commit-graph: extract init and free write_commit_graph_context
30:  943b0d9554c <  -:  ----------- commit-graph: move write_commit_graph_reachable below write_commit_graph
31:  47b26ea61aa <  -:  ----------- t7007-show: make the first test compatible with the next patch
32:  9201b71071c <  -:  ----------- PoC commit-graph: use revision walk machinery for '--reachable'
33:  5c72d97e5e9 <  -:  ----------- commit-graph: write modified path Bloom filters in "history order"

This patch is likely worth investigating again:

34:  8b40ec4cd30 <  -:  ----------- commit-graph: use modified path Bloom filters with wildcards, if possible

Thanks, -Stolee

Derrick Stolee (4):
  commit-graph: place bloom_settings in context
  bloom: enforce a minimum size of 8 bytes
  commit-graph: change test to die on parse, not load
  commit-graph: persist existence of changed-paths

SZEDER Gábor (4):
  commit-graph: unify the signatures of all write_graph_chunk_*()
    functions
  commit-graph: simplify chunk writes into loop
  commit-graph: check chunk sizes after writing
  commit-graph: check all leading directories in changed path Bloom
    filters

 Documentation/git-commit-graph.txt |   5 +-
 bloom.c                            |   4 ++
 builtin/commit-graph.c             |   5 +-
 commit-graph.c                     | 112 ++++++++++++++++++++---------
 commit-graph.h                     |   3 +-
 revision.c                         |  35 ++++++---
 revision.h                         |   6 +-
 t/t4216-log-bloom.sh               |   4 +-
 t/t5318-commit-graph.sh            |   2 +-
 9 files changed, 124 insertions(+), 52 deletions(-)


base-commit: 7fbfe07ab4d4e58c0971dac73001b89f180a0af3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-659%2Fderrickstolee%2Fbloom-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-659/derrickstolee/bloom-2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/659
-- 
gitgitgadget
