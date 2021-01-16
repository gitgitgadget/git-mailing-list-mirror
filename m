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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9355C433E9
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7726B229C4
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbhAPSMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbhAPSME (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 13:12:04 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CB5C061573
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i63so10075066wma.4
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vy87z8zbisfDCnYdgPDthFrumsqO+Ujp/T4LsjBmfeE=;
        b=TehB0jjKcXWueIdKZ6nnHkJg8eqRGhvGHlDhxxXn8sxXACgg/hHJD3Mb5+gMtxbQ1B
         JtLqKe9kpJPFju3OMoaN0TUUaeS/aSpjXTDEfUO8vmKq0ERbBKrljxj60yJw0RoP7FSF
         cO/PnnTWDM9bVrSOFqIWsGlhRkkU04ljBTzfvIHKsMl4l9s881iKaWeP8n7mSoPqEXD5
         S7Bhy8q92EF0UP75Ahrl3LHZZO/8Z5PQVV22LNCVdONBvGaHsPEKc0Le4LOc9vOKEYL1
         sMV6oxxyYYa8+4BVC7Sr6hcl4ASx2h0qXBzWjCTkqEU1JQ3+WLjYkoXLlEBiuEafOqBY
         laJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vy87z8zbisfDCnYdgPDthFrumsqO+Ujp/T4LsjBmfeE=;
        b=XkYdq9D9S/Ie7LrOXGWYjFpI80hIy9AEHW86aq2iGfsGkTvIJ27LB6kc/su/zYtFXZ
         5RZvL2a7QRfNUEchwD0UG6zCR2gv/qNhOq7/n3In0+1LOfB+7prLBQYh37CZYine8svL
         Myx1He0Zs/W4BGHzxRPKlIkakOkhw3fIRQJcRBz+DjkfBKP4KTDWul6Gmur+nInpPse3
         /iu147qDYPgyK5QEe8sbB7brHJeykbrSKmLv9s3aQyMTqdtI8vr/ub6djmhUURYmif0c
         Ic1SxS4geJpUwZOao2wQbQtjDNhPseW+kgl/3ZP6K05CC9/+ZRQI01zU8TwRAkDOX4fG
         KUrQ==
X-Gm-Message-State: AOAM530abv0Qgnaw4t7m4Af03n9QS/REUrAVafY6KqXTYCFDS2e0scRk
        HWnzwhPQPelz8hwL+1uHwUbeNQrEBjs=
X-Google-Smtp-Source: ABdhPJz4FCao3ZcmfE7L4NAkZnbav7S3QZ8SP8YyEMzCqq9SCs12I7BPku/1zrp/gPn7pTiLaPS6OQ==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr8079042wmb.45.1610820681199;
        Sat, 16 Jan 2021 10:11:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm20173598wrv.97.2021.01.16.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 10:11:20 -0800 (PST)
Message-Id: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Jan 2021 18:11:07 +0000
Subject: [PATCH v6 00/11] [GSoC] Implement Corrected Commit Date
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series implements the corrected commit date offsets as generation
number v2, along with other pre-requisites.

Git uses topological levels in the commit-graph file for commit-graph
traversal operations like 'git log --graph'. Unfortunately, using
topological levels can result in a worse performance than without them when
compared with committer date as a heuristics. For example, 'git merge-base
v4.8 v4.9' on the Linux repository walks 635,579 commits using topological
levels and walks 167,468 using committer date. Since 091f4cf3 (commit: don't
use generation numbers if not needed, 2018-08-30), 'git merge-base' uses
committer date heuristic unless there is a cutoff because of the performance
hit.

Thus, the need for generation number v2 was born. New generation number
needed to provide good performance, increment updates, and backward
compatibility. Due to an unfortunate problem [1], we also needed a way to
distinguish between the old and new generation number without incrementing
graph version.

[1] https://public-inbox.org/git/87a7gdspo4.fsf@evledraar.gmail.com/

Various candidates were examined (https://github.com/derrickstolee/gen-test,
https://github.com/abhishekkumar2718/git/pull/1). The proposed generation
number v2, Corrected Commit Date with Mononotically Increasing Offsets
performed much worse than committer date (506,577 vs. 167,468 commits walked
for 'git merge-base v4.8 v4.9') and was dropped.

Using Generation Data chunk (GDAT) relieves the requirement of backward
compatibility as we would continue to store topological levels in Commit
Data (CDAT) chunk. Thus, Corrected Commit Date was chosen as generation
number v2. The Corrected Commit Date is defined as follows:

For a commit C, let its corrected commit date be the maximum of the commit
date of C and the corrected commit dates of its parents plus 1. Then
corrected commit date offset is the difference between corrected commit date
of C and commit date of C. As a special case, a root commit with the
timestamp zero has corrected commit date of 1 to be able to distinguish it
from GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit date).

We will introduce an additional commit-graph chunk, Generation DATa (GDAT)
chunk, and store corrected commit date offsets in GDAT chunk while storing
topological levels in CDAT chunk. The old versions of Git would ignore GDAT
chunk, using topological levels from CDAT chunk. In contrast, new versions
of Git would use corrected commit dates, falling back to topological level
if the generation data chunk is absent in the commit-graph file.

While storing corrected commit date offsets saves us 4 bytes per commit (as
compared with storing corrected commit dates directly), it's however
possible for the offset to overflow the space allocated. To handle such
cases, we introduce a new chunk, Generation Data Overflow (GDOV) that stores
the corrected commit date. For overflowing offsets, we set MSB and store the
position into the GDOV chunk, in a mechanism similar to the Extra Edges list
chunk.

For mixed generation number environment (for example new Git on the command
line, old Git used by GUI client), we can encounter a mixed-chain
commit-graph (a commit-graph chain where some of split commit-graph files
have GDAT chunk and others do not). As backward compatibility is one of the
goals, we can define the following behavior:

While reading a mixed-chain commit-graph version, we fall back on
topological levels as corrected commit dates and topological levels cannot
be compared directly.

When adding new layer to the split commit-graph file, and when merging some
or all layers (replacing them in the latter case), the new layer will have
GDAT chunk if and only if in the final result there would be no layer
without GDAT chunk just below it.

Thanks to Dr. Stolee, Dr. Narębski, and Taylor for their reviews.

I look forward to everyone's reviews!

Thanks

 * Abhishek

----------------------------------------------------------------------------

Improvements left for a future series:

 * Save commits with generation data overflow and extra edge commits instead
   of looping over all commits. cf. 858sbel67n.fsf@gmail.com
 * Verify both topological levels and corrected commit dates when present.
   cf. 85pn4tnk8u.fsf@gmail.com

Changes in version 6:

 * Fixed typos in commit message for "commit-graph: implement corrected
   commit date".
 * Removed an unnecessary else-block in "commit-graph: implement corrected
   commit date".
 * Validate mixed generation chain correctly while writing in "commit-graph:
   use generation v2 only if the entire chain does".
 * Die if the GDAT chunk indicates data has overflown but there are is no
   generation data overflow chunk.

Changes in version 5:

 * Explained a possible reason for no change in performance for
   "commit-graph: fix regression when computing bloom-filters"
 * Clarified about the addition of a new test for 11-digit octal
   implementations of ustar.
 * Fixed duplicate test names in "commit-graph: consolidate
   fill_commit_graph_info".
 * Swapped the order "commit-graph: return 64-bit generation number",
   "commit-graph: add a slab to store topological levels" to minimize lines
   changed.
 * Fixed the mismerge in "commit-graph: return 64-bit generation number"
 * Clarified the preparatory steps are for the larger goal of implementing
   generation number v2 in "commit-graph: return 64-bit generation number".
 * Moved the rename of "run_three_modes()" to "run_all_modes()" into a new
   patch "t6600-test-reach: generalize *_three_modes".
 * Explained and removed the checks for GENERATION_NUMBER_INFINITY that can
   never be true in "commit-graph: add a slab to store topological levels".
 * Fixed incorrect logic for verifying commit-graph in "commit-graph:
   implement corrected commit date".
 * Added minor improvements to commit message of "commit-graph: implement
   generation data chunk".
 * Added '--date ' option to test_commit() in 'test-lib-functions.sh' in
   "commit-graph: implement generation data chunk".
 * Improved coding style (also in tests) for "commit-graph: use generation
   v2 only if entire chain does".
 * Simplified test repository structure in "commit-graph: use generation v2
   only if entire chain does" as only the number of commits in a split
   commit-graph layer are relevant.
 * Added a new test in "commit-graph: use generation v2 only if entire chain
   does" to check if the layers are merged correctly.
 * Explicitly mentioned commit "091f4cf3" in the commit-message of
   "commit-graph: use corrected commit dates in paint_down_to_common()".
 * Minor corrections to documentation in "doc: add corrected commit date
   info".
 * Minor corrections to coding style.

Changes in version 4:

 * Added GDOV to handle overflows in generation data.
 * Added a test for writing tip graph for a generation number v2 graph chain
   in t5324-split-commit-graph.sh
 * Added a section on how mixed generation number chains are handled in
   Documentation/technical/commit-graph-format.txt
 * Reverted unimportant whitespace, style changes in commit-graph.c
 * Added header comments about the order of comparision for
   compare_commits_by_gen_then_commit_date in commit.h,
   compare_commits_by_gen in commit-graph.h
 * Elaborated on why t6404 fails with corrected commit date and must be run
   with GIT_TEST_COMMIT_GRAPH=1in the commit "commit-reach: use corrected
   commit dates in paint_down_to_common()"
 * Elaborated on write behavior for mixed generation number chains in the
   commit "commit-graph: use generation v2 only if entire chain does"
 * Added notes about adding the topo_level slab to struct
   write_commit_graph_context as well as struct commit_graph.
 * Clarified commit message for "commit-graph: consolidate
   fill_commit_graph_info"
 * Removed the claim "GDAT can store future generation numbers" because it
   hasn't been tested yet.

Changes in version 3:

 * Reordered patches as discussed in 2
   [https://lore.kernel.org/git/aee0ae56-3395-6848-d573-27a318d72755@gmail.com/].
 * Split "implement corrected commit date" into two patches - one
   introducing the topo level slab and other implementing corrected commit
   dates.
 * Extended split-commit-graph tests to verify at the end of test.
 * Use topological levels as generation number if any of split commit-graph
   files do not have generation data chunk.

Changes in version 2:

 * Add tests for generation data chunk.
 * Add an option GIT_TEST_COMMIT_GRAPH_NO_GDAT to control whether to write
   generation data chunk.
 * Compare commits with corrected commit dates if present in
   paint_down_to_common().
 * Update technical documentation.
 * Handle mixed generation commit chains.
 * Improve commit messages for "commit-graph: fix regression when computing
   bloom filter", "commit-graph: consolidate fill_commit_graph_info",
 * Revert unnecessary whitespace changes.
 * Split uint_32 -> timestamp_t change into a new commit.

Abhishek Kumar (11):
  commit-graph: fix regression when computing Bloom filters
  revision: parse parent in indegree_walk_step()
  commit-graph: consolidate fill_commit_graph_info
  t6600-test-reach: generalize *_three_modes
  commit-graph: add a slab to store topological levels
  commit-graph: return 64-bit generation number
  commit-graph: implement corrected commit date
  commit-graph: implement generation data chunk
  commit-graph: use generation v2 only if entire chain does
  commit-reach: use corrected commit dates in paint_down_to_common()
  doc: add corrected commit date info

 .../technical/commit-graph-format.txt         |  28 +-
 Documentation/technical/commit-graph.txt      |  77 +++++-
 commit-graph.c                                | 251 ++++++++++++++----
 commit-graph.h                                |  15 +-
 commit-reach.c                                |  38 +--
 commit-reach.h                                |   2 +-
 commit.c                                      |   4 +-
 commit.h                                      |   5 +-
 revision.c                                    |  13 +-
 t/README                                      |   3 +
 t/helper/test-read-graph.c                    |   4 +
 t/t4216-log-bloom.sh                          |   4 +-
 t/t5000-tar-tree.sh                           |  24 +-
 t/t5318-commit-graph.sh                       |  79 +++++-
 t/t5324-split-commit-graph.sh                 | 193 +++++++++++++-
 t/t6404-recursive-merge.sh                    |   5 +-
 t/t6600-test-reach.sh                         |  68 ++---
 t/test-lib-functions.sh                       |   6 +
 upload-pack.c                                 |   2 +-
 19 files changed, 667 insertions(+), 154 deletions(-)


base-commit: 4151fdb1c76c1a190ac9241b67223efd19f3e478
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-676%2Fabhishekkumar2718%2Fcorrected_commit_date-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-676/abhishekkumar2718/corrected_commit_date-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/676

Range-diff vs v5:

  1:  c4e817abf7d !  1:  4d8eb415578 commit-graph: fix regression when computing Bloom filters
     @@ Metadata
       ## Commit message ##
          commit-graph: fix regression when computing Bloom filters
      
     -    Before computing Bloom fitlers, the commit-graph machinery uses
     +    Before computing Bloom filters, the commit-graph machinery uses
          commit_gen_cmp to sort commits by generation order for improved diff
          performance. 3d11275505 (commit-graph: examine commits by generation
          number, 2020-03-30) claims that this sort can reduce the time spent to
     @@ Commit message
          'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
          while writing.
      
     -    Not all hope is lost, though: 'commit_graph_generation()' falls back to
     +    Not all hope is lost, though: 'commit_gen_cmp()' falls back to
          comparing commits by their date when they have equal generation number,
     -    and so since c49c82aa4c is purely a date comparision function. This
     +    and so since c49c82aa4c is purely a date comparison function. This
          heuristic is good enough that we don't seem to loose appreciable
     -    performance while computing Bloom filters. Applying this patch (compared
     -    with v2.29.1) speeds up computing Bloom filters by around ~4
     -    seconds.
     +    performance while computing Bloom filters.
     +
     +    Applying this patch (compared with v2.30.0) speeds up computing Bloom
     +    filters by factors ranging from 0.40% to 5.19% on various repositories [1].
      
          So, avoid the useless 'commit_graph_generation()' while writing by
          instead accessing the slab directly. This returns the newly-computed
          generation numbers, and allows us to avoid the heuristic by directly
          comparing generation numbers.
      
     +    [1]: https://lore.kernel.org/git/20210105094535.GN8396@szeder.dev/
     +
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## commit-graph.c ##
     -@@ commit-graph.c: static int commit_gen_cmp(const void *va, const void *vb)
     +@@ commit-graph.c: static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
     + 	return data;
     + }
     + 
     ++/* 
     ++ * Should be used only while writing commit-graph as it compares
     ++ * generation value of commits by directly accessing commit-slab.
     ++ */
     + static int commit_gen_cmp(const void *va, const void *vb)
     + {
       	const struct commit *a = *(const struct commit **)va;
       	const struct commit *b = *(const struct commit **)vb;
       
  2:  7645e0bcef0 =  2:  05dcb862818 revision: parse parent in indegree_walk_step()
  3:  ca646912b2b =  3:  dcb9891d819 commit-graph: consolidate fill_commit_graph_info
  4:  591935075f1 =  4:  4fbdee7ac90 t6600-test-reach: generalize *_three_modes
  5:  baae7006764 =  5:  fbd8feb5d8c commit-graph: add a slab to store topological levels
  6:  26bd6f49100 =  6:  855ff662a44 commit-graph: return 64-bit generation number
  7:  859c39eff52 !  7:  8fbe7486405 commit-graph: implement corrected commit date
     @@ Commit message
          of GDAT chunk, which is a reduction of around 6% in the size of
          commit-graph file.
      
     -    However, using offsets be problematic if one of commits is malformed but
     -    valid and has committerdate of 0 Unix time, as the offset would be the
     -    same as corrected commit date and thus require 64-bits to be stored
     -    properly.
     +    However, using offsets be problematic if a commit is malformed but valid
     +    and has committer date of 0 Unix time, as the offset would be the same
     +    as corrected commit date and thus require 64-bits to be stored properly.
      
          While Git does not write out offsets at this stage, Git stores the
          corrected commit dates in member generation of struct commit_graph_data.
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
       					break;
      -				} else if (level > max_level) {
      -					max_level = level;
     -+				} else {
     -+					if (level > max_level)
     -+						max_level = level;
     -+
     -+					if (corrected_commit_date > max_corrected_commit_date)
     -+						max_corrected_commit_date = corrected_commit_date;
       				}
     ++
     ++				if (level > max_level)
     ++					max_level = level;
     ++
     ++				if (corrected_commit_date > max_corrected_commit_date)
     ++					max_corrected_commit_date = corrected_commit_date;
       			}
       
     + 			if (all_parents_computed) {
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
       				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
       					max_level = GENERATION_NUMBER_V1_MAX - 1;
  8:  8403c4d0257 !  8:  6d0696ae216 commit-graph: implement generation data chunk
     @@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct c
      +		offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
      +
      +		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
     ++			if (!g->chunk_generation_data_overflow)
     ++				die(_("commit-graph requires overflow generation data but has none"));
     ++
      +			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
      +			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
      +		} else
  9:  a3a70a1edd0 !  9:  fba0d7f3dfe commit-graph: use generation v2 only if entire chain does
     @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph
       		g = g->base_graph;
       	}
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     - 		struct commit_graph *g = ctx->r->objects->commit_graph;
     + 	} else
     + 		ctx->num_commit_graphs_after = 1;
       
     - 		while (g) {
     -+			g->read_generation_data = 1;
     - 			g->topo_levels = &topo_levels;
     - 			g = g->base_graph;
     - 		}
     ++	validate_mixed_generation_chain(ctx->r->objects->commit_graph);
     ++
     + 	compute_generation_numbers(ctx);
     + 
     + 	if (ctx->changed_paths)
      @@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
       		 * also GENERATION_NUMBER_V1_MAX. Decrement to avoid extra logic
       		 * in the following condition.
 10:  093101f908b = 10:  ba1f2c5555f commit-reach: use corrected commit dates in paint_down_to_common()
 11:  20299e57457 = 11:  e571f03d8bd doc: add corrected commit date info

-- 
gitgitgadget
