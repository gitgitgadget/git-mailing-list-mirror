Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B0BC433E6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80D622583
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgL1LQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgL1LQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:16:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E6C061795
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t16so11046180wra.3
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=gwcSzjtfguk0xih7fFk6rRskxstyqwf42JQIWLFZwTU=;
        b=c7JF0tLiqCVPKcn0AjKn0NswALOXKKXP+ZbBfBaCmF5Z38jVy6M6PK4fZQsv2+ijiY
         wes7xFOuB3G3s1H48TF0M8Ibp2kUjfsPB2DoTplWcxqcRfmdFntu+NKo8N4J7Z92GeYS
         Lh9mGc6uYfHACLA+JcwzqUn4KTsgMGgav1taHxKgtJiBJtPJpCZD7cetDEnz4QsnYF+C
         fzam9QZov27g8sd7Fa1IBA+A06DpXzR/3wsuQseB7kWbxuSdJ8uaBszAhMQ0WOHHWMY/
         tZ+STJL2tgYWkKyhF5sCWudjc7SlZNWkHjSXU/20NefrgDO0MLyHEJE2Ycrk3XRcn1Kq
         1rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=gwcSzjtfguk0xih7fFk6rRskxstyqwf42JQIWLFZwTU=;
        b=irnjSGDTNaZZw6eB7TtJshshHt2L5O8AgolHHgp6XL7LNSIbKsk2e3zNEI5eUp8Pzt
         +GLkE6OQeiDegnP7gNBIQdnzeqTFbNeBkuVwLek8mZkB3+DMaZV6oaP26n+1x7MxNtxv
         siV7Q+iKIEJkFLOOHhMOtNUExZnff5vIGA3ccVrXi+ZCjYJdPa8HGpglGaCqIf6RjiwW
         3kElwlsjelPmCmppderaTi9FWTcsuoRwzFIYQCWRuTaeCHxvjYB3lVrIhARoVc1zzRzT
         6zLf2KkvMEFay+GMLPBFib1ZuHH0j12dp34LEH6aF55zeka079qa+W6EmwyeoU7uVEGT
         04/w==
X-Gm-Message-State: AOAM531oSwRKyqJ80udb9Pqi0Fgd778V0Nk6x0RATcvoMDW32fxk85iH
        ysMhA0VLaJRdYilZf1Q0PuXPZyCnE/0=
X-Google-Smtp-Source: ABdhPJxqIQ4XwM/tL0Sq7dw+Bvp2JEF/AVxExSN1jneq9PHt9ZaqzILcNioJ/kF3u/AnzQHTjYesjQ==
X-Received: by 2002:adf:83a6:: with SMTP id 35mr28948398wre.274.1609154170902;
        Mon, 28 Dec 2020 03:16:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm18590711wmf.35.2020.12.28.03.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:16:10 -0800 (PST)
Message-Id: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 11:15:57 +0000
Subject: [PATCH v5 00/11] [GSoC] Implement Corrected Commit Date
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
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
 commit-graph.c                                | 243 ++++++++++++++----
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
 19 files changed, 659 insertions(+), 154 deletions(-)


base-commit: 4a0de43f4923993377dbbc42cfc0a1054b6c5ccf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-676%2Fabhishekkumar2718%2Fcorrected_commit_date-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-676/abhishekkumar2718/corrected_commit_date-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/676

Range-diff vs v4:

  1:  fae81b534b1 !  1:  c4e817abf7d commit-graph: fix regression when computing Bloom filters
     @@ Metadata
       ## Commit message ##
          commit-graph: fix regression when computing Bloom filters
      
     -    commit_gen_cmp is used when writing a commit-graph to sort commits in
     -    generation order before computing Bloom filters. Since c49c82aa (commit:
     -    move members graph_pos, generation to a slab, 2020-06-17) made it so
     -    that 'commit_graph_generation()' returns 'GENERATION_NUMBER_INFINITY'
     -    during writing, we cannot call it within this function. Instead, access
     -    the generation number directly through the slab (i.e., by calling
     -    'commit_graph_data_at(c)->generation') in order to access it while
     -    writing.
     +    Before computing Bloom fitlers, the commit-graph machinery uses
     +    commit_gen_cmp to sort commits by generation order for improved diff
     +    performance. 3d11275505 (commit-graph: examine commits by generation
     +    number, 2020-03-30) claims that this sort can reduce the time spent to
     +    compute Bloom filters by nearly half.
      
     -    While measuring performance with `git commit-graph write --reachable
     -    --changed-paths` on the linux repository led to around 1m40s for both
     -    HEAD and master (and could be due to fault in my measurements), it is
     -    still the "right" thing to do.
     +    But since c49c82aa4c (commit: move members graph_pos, generation to a
     +    slab, 2020-06-17), this optimization is broken, since asking for a
     +    'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
     +    while writing.
     +
     +    Not all hope is lost, though: 'commit_graph_generation()' falls back to
     +    comparing commits by their date when they have equal generation number,
     +    and so since c49c82aa4c is purely a date comparision function. This
     +    heuristic is good enough that we don't seem to loose appreciable
     +    performance while computing Bloom filters. Applying this patch (compared
     +    with v2.29.1) speeds up computing Bloom filters by around ~4
     +    seconds.
     +
     +    So, avoid the useless 'commit_graph_generation()' while writing by
     +    instead accessing the slab directly. This returns the newly-computed
     +    generation numbers, and allows us to avoid the heuristic by directly
     +    comparing generation numbers.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
  2:  4470d916428 =  2:  7645e0bcef0 revision: parse parent in indegree_walk_step()
  3:  18bb3318a12 !  3:  ca646912b2b commit-graph: consolidate fill_commit_graph_info
     @@ Commit message
          fill_commit_in_graph().
      
          fill_commit_graph_info() used to not load committer data from commit data
     -    chunk. However, with the corrected committer date, we have to load
     -    committer date to calculate generation number value.
     +    chunk. However, with the upcoming switch to using corrected committer
     +    date as generation number v2, we will have to load committer date to
     +    compute generation number value anyway.
      
          e51217e15 (t5000: test tar files that overflow ustar headers,
          30-06-2016) introduced a test 'generate tar with future mtime' that
     -    creates a commit with committer date of (2 ^ 36 + 1) seconds since
     +    creates a commit with committer date of (2^36 + 1) seconds since
          EPOCH. The CDAT chunk provides 34-bits for storing committer date, thus
          committer time overflows into generation number (within CDAT chunk) and
          has undefined behavior.
      
          The test used to pass as fill_commit_graph_info() would not set struct
     -    member `date` of struct commit and loads committer date from the object
     +    member `date` of struct commit and load committer date from the object
          database, generating a tar file with the expected mtime.
      
          However, with corrected commit date, we will load the committer date
     @@ Commit message
          mtime.
      
          The ustar format (the header format used by most modern tar programs)
     -    only has room for 11 (or 12, depending om some implementations) octal
     -    digits for the size and mtime of each files.
     +    only has room for 11 (or 12, depending on some implementations) octal
     +    digits for the size and mtime of each file.
      
     -    Thus, setting a timestamp of 2 ^ 33 + 1 would overflow the 11-octal
     -    digit implementations while still fitting into commit data chunk.
     +    As the CDAT chunk is overflow by 12-octal digits but not 11-octal
     +    digits, we split the existing tests to test both implementations
     +    separately and add a new explicit test for 11-digit implementation.
      
     -    Since we want to test 12-octal digit implementations of ustar as well,
     -    let's modify the existing test to no longer use commit-graph file.
     +    To test the 11-octal digit implementation, we create a future commit
     +    with committer date of 2^34 - 1, which overflows 11-octal digits without
     +    overflowing 34-bits of the Commit Date chunks.
     +
     +    To test the 12-octal digit implementation, the smallest committer date
     +    possible is 2^36 + 1, which overflows the CDAT chunk and thus
     +    commit-graph must be disabled for the test.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     @@ t/t5000-tar-tree.sh: test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can
       	test_cmp expect actual
       '
       
     -+test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
     +-test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
     ++test_expect_success TIME_IS_64BIT 'set up repository with far-future (2^34 - 1) commit' '
      +	rm -f .git/index &&
      +	echo foo >file &&
      +	git add file &&
     @@ t/t5000-tar-tree.sh: test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can
      +		git commit -m "tempori parendum"
      +'
      +
     -+test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
     ++test_expect_success TIME_IS_64BIT 'generate tar with far-future mtime' '
      +	git archive HEAD >future.tar
      +'
      +
     @@ t/t5000-tar-tree.sh: test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can
      +	test_cmp expect actual
      +'
      +
     - test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
     ++test_expect_success TIME_IS_64BIT 'set up repository with far-far-future (2^36 + 1) commit' '
       	rm -f .git/index &&
       	echo content >file &&
       	git add file &&
     @@ t/t5000-tar-tree.sh: test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can
       		git commit -m "tempori parendum"
       '
       
     +-test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
     ++test_expect_success TIME_IS_64BIT 'generate tar with far-far-future mtime' '
     + 	git archive HEAD >future.tar
     + '
     + 
  -:  ----------- >  4:  591935075f1 t6600-test-reach: generalize *_three_modes
  5:  e067f653ad5 !  5:  baae7006764 commit-graph: add a slab to store topological levels
     @@ Commit message
          commit-graph: add a slab to store topological levels
      
          In a later commit we will introduce corrected commit date as the
     -    generation number v2. This value will be stored in the new seperate
     -    Generation Data chunk. However, to ensure backwards compatibility with
     -    "Old" Git we need to continue to write generation number v1, which is
     -    topological level, to the commit data chunk. This means that we need to
     -    compute both versions of generation numbers when writing the
     -    commit-graph file. Therefore, let's introduce a commit-slab to store
     +    generation number v2. Corrected commit dates will be stored in the new
     +    seperate Generation Data chunk. However, to ensure backwards
     +    compatibility with "Old" Git we need to continue to write generation
     +    number v1 (topological levels) to the commit data chunk. Thus, we need
     +    to compute and store both versions of generation numbers to write the
     +    commit-graph file.
     +
     +    Therefore, let's introduce a commit-slab `topo_level_slab` to store
          topological levels; corrected commit date will be stored in the member
          `generation` of struct commit_graph_data.
      
     -    When Git creates a split commit-graph, it takes advantage of the
     -    generation values that have been computed already and present in
     -    existing commit-graph files.
     +    The macros `GENERATION_NUMBER_INFINITY` and `GENERATION_NUMBER_ZERO`
     +    mark commits not in the commit-graph file and commits written by a
     +    version of Git that did not compute generation numbers respectively.
     +    Generation numbers are computed identically for both kinds of commits.
     +
     +    A "slab-miss" should return `GENERATION_NUMBER_INFINITY` as the commit
     +    is not in the commit-graph file. However, since the slab is
     +    zero-initialized, it returns 0 (or rather `GENERATION_NUMBER_ZERO`).
     +    Thus, we no longer need to check if the topological level of a commit is
     +    `GENERATION_NUMBER_INFINITY`.
      
     -    So, let's add a pointer to struct commit_graph as well as struct
     -    write_commit_graph_context to the topological level commit-slab
     -    and populate it with topological levels while writing a commit-graph
     -    file.
     +    We will add a pointer to the slab in `struct write_commit_graph_context`
     +    and `struct commit_graph` to populate the slab in
     +    `fill_commit_graph_info` if the commit has a pre-computed topological
     +    level as in case of split commit-graphs.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
       					_("Computing commit graph generation numbers"),
       					ctx->commits.nr);
       	for (i = 0; i < ctx->commits.nr; i++) {
     --		timestamp_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
     -+		timestamp_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
     +-		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
     ++		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
       
       		display_progress(ctx->progress, i + 1);
      -		if (generation != GENERATION_NUMBER_INFINITY &&
      -		    generation != GENERATION_NUMBER_ZERO)
     -+		if (level != GENERATION_NUMBER_INFINITY &&
     -+		    level != GENERATION_NUMBER_ZERO)
     ++		if (level != GENERATION_NUMBER_ZERO)
       			continue;
       
       		commit_list_insert(ctx->commits.list[i], &list);
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
       
      -				if (generation == GENERATION_NUMBER_INFINITY ||
      -				    generation == GENERATION_NUMBER_ZERO) {
     -+				if (level == GENERATION_NUMBER_INFINITY ||
     -+				    level == GENERATION_NUMBER_ZERO) {
     ++				if (level == GENERATION_NUMBER_ZERO) {
       					all_parents_computed = 0;
       					commit_list_insert(parent->item, &list);
       					break;
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
      -				data->generation = max_generation + 1;
       				pop_commit(&list);
       
     --				if (data->generation > GENERATION_NUMBER_V1_MAX)
     --					data->generation = GENERATION_NUMBER_V1_MAX;
     -+				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
     -+					max_level = GENERATION_NUMBER_V1_MAX - 1;
     +-				if (data->generation > GENERATION_NUMBER_MAX)
     +-					data->generation = GENERATION_NUMBER_MAX;
     ++				if (max_level > GENERATION_NUMBER_MAX - 1)
     ++					max_level = GENERATION_NUMBER_MAX - 1;
      +				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
       			}
       		}
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
      +	struct topo_level_slab topo_levels;
       
     - 	if (!commit_graph_compatible(the_repository))
     - 		return 0;
     + 	prepare_repo_settings(the_repository);
     + 	if (!the_repository->settings.core_commit_graph) {
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       							 bloom_settings.max_changed_paths);
       	ctx->bloom_settings = &bloom_settings;
  4:  011b0aa497d !  6:  26bd6f49100 commit-graph: return 64-bit generation number
     @@ Metadata
       ## Commit message ##
          commit-graph: return 64-bit generation number
      
     -    In a preparatory step, let's return timestamp_t values from
     -    commit_graph_generation(), use timestamp_t for local variables and
     -    define GENERATION_NUMBER_INFINITY as (2 ^ 63 - 1) instead.
     +    In a preparatory step for introducing corrected commit dates, let's
     +    return timestamp_t values from commit_graph_generation(), use
     +    timestamp_t for local variables and define GENERATION_NUMBER_INFINITY
     +    as (2 ^ 63 - 1) instead.
      
          We rename GENERATION_NUMBER_MAX to GENERATION_NUMBER_V1_MAX to
          represent the largest topological level we can store in the commit data
     @@ commit-graph.c: static int commit_gen_cmp(const void *va, const void *vb)
       	if (generation_a < generation_b)
       		return -1;
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 					_("Computing commit graph generation numbers"),
     - 					ctx->commits.nr);
     - 	for (i = 0; i < ctx->commits.nr; i++) {
     --		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
     -+		timestamp_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
     - 
     - 		display_progress(ctx->progress, i + 1);
     - 		if (generation != GENERATION_NUMBER_INFINITY &&
     -@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 				data->generation = max_generation + 1;
     + 			if (all_parents_computed) {
       				pop_commit(&list);
       
     --				if (data->generation > GENERATION_NUMBER_MAX)
     --					data->generation = GENERATION_NUMBER_MAX;
     -+				if (data->generation > GENERATION_NUMBER_V1_MAX)
     -+					data->generation = GENERATION_NUMBER_V1_MAX;
     +-				if (max_level > GENERATION_NUMBER_MAX - 1)
     +-					max_level = GENERATION_NUMBER_MAX - 1;
     ++				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
     ++					max_level = GENERATION_NUMBER_V1_MAX - 1;
     + 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
       			}
       		}
     - 	}
      @@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
       	for (i = 0; i < g->num_commits; i++) {
       		struct commit *graph_commit, *odb_commit;
     @@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_grap
       			max_generation--;
       
       		generation = commit_graph_generation(graph_commit);
     + 		if (generation != max_generation + 1)
     +-			graph_report(_("commit-graph generation for commit %s is %u != %u"),
     ++			graph_report(_("commit-graph generation for commit %s is %"PRItime" != %"PRItime),
     + 				     oid_to_hex(&cur_oid),
     + 				     generation,
     + 				     max_generation + 1);
      
       ## commit-graph.h ##
      @@ commit-graph.h: void disable_commit_graph(struct repository *r);
     @@ commit-reach.c: int repo_in_merge_bases_many(struct repository *r, struct commit
       	struct commit_list *bases;
       	int ret = 0, i;
      -	uint32_t generation, max_generation = GENERATION_NUMBER_ZERO;
     -+	timestamp_t generation, max_generation = GENERATION_NUMBER_INFINITY;
     ++	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
       
       	if (repo_parse_commit(r, commit))
       		return ret;
  6:  694ef1ec08d !  7:  859c39eff52 commit-graph: implement corrected commit date
     @@ Commit message
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## commit-graph.c ##
     -@@ commit-graph.c: static int commit_gen_cmp(const void *va, const void *vb)
     - 	else if (generation_a > generation_b)
     - 		return 1;
     - 
     --	/* use date as a heuristic when generations are equal */
     --	if (a->date < b->date)
     --		return -1;
     --	else if (a->date > b->date)
     --		return 1;
     - 	return 0;
     - }
     - 
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
       					ctx->commits.nr);
       	for (i = 0; i < ctx->commits.nr; i++) {
     - 		timestamp_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
     + 		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
      +		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
       
       		display_progress(ctx->progress, i + 1);
     - 		if (level != GENERATION_NUMBER_INFINITY &&
     --		    level != GENERATION_NUMBER_ZERO)
     -+		    level != GENERATION_NUMBER_ZERO &&
     -+		    corrected_commit_date != GENERATION_NUMBER_INFINITY &&
     -+		    corrected_commit_date != GENERATION_NUMBER_ZERO
     -+		    )
     +-		if (level != GENERATION_NUMBER_ZERO)
     ++		if (level != GENERATION_NUMBER_ZERO &&
     ++		    corrected_commit_date != GENERATION_NUMBER_ZERO)
       			continue;
       
       		commit_list_insert(ctx->commits.list[i], &list);
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
       
       			for (parent = current->parents; parent; parent = parent->next) {
       				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
     --
      +				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
     - 				if (level == GENERATION_NUMBER_INFINITY ||
     --				    level == GENERATION_NUMBER_ZERO) {
     -+				    level == GENERATION_NUMBER_ZERO ||
     -+				    corrected_commit_date == GENERATION_NUMBER_INFINITY ||
     -+				    corrected_commit_date == GENERATION_NUMBER_ZERO
     -+				    ) {
     + 
     +-				if (level == GENERATION_NUMBER_ZERO) {
     ++				if (level == GENERATION_NUMBER_ZERO ||
     ++				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
       					all_parents_computed = 0;
       					commit_list_insert(parent->item, &list);
       					break;
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
       			}
       		}
       	}
     -@@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
     - 		if (generation_zero == GENERATION_ZERO_EXISTS)
     - 			continue;
     - 
     --		/*
     --		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
     --		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
     --		 * extra logic in the following condition.
     --		 */
     --		if (max_generation == GENERATION_NUMBER_V1_MAX)
     --			max_generation--;
     --
     - 		generation = commit_graph_generation(graph_commit);
     --		if (generation != max_generation + 1)
     --			graph_report(_("commit-graph generation for commit %s is %u != %u"),
     -+		if (generation < max_generation + 1)
     -+			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
     - 				     oid_to_hex(&cur_oid),
     - 				     generation,
     - 				     max_generation + 1);
  7:  b903efe2ea1 !  8:  8403c4d0257 commit-graph: implement generation data chunk
     @@ Commit message
      
          As discovered by Ævar, we cannot increment graph version to
          distinguish between generation numbers v1 and v2 [1]. Thus, one of
     -    pre-requistes before implementing generation number was to distinguish
     -    between graph versions in a backwards compatible manner.
     +    pre-requistes before implementing generation number v2 was to
     +    distinguish between graph versions in a backwards compatible manner.
      
     -    We are going to introduce a new chunk called Generation Data chunk (or
     -    GDAT). GDAT stores corrected committer date offsets whereas CDAT will
     -    still store topological level.
     +    We are going to introduce a new chunk called Generation DATa chunk (or
     +    GDAT). GDAT will store corrected committer date offsets whereas CDAT
     +    will still store topological level.
      
          Old Git does not understand GDAT chunk and would ignore it, reading
          topological levels from CDAT. New Git can parse GDAT and take advantage
          of newer generation numbers, falling back to topological levels when
     -    GDAT chunk is missing (as it would happen with a commit graph written
     +    GDAT chunk is missing (as it would happen with a commit-graph written
          by old Git).
      
          We introduce a test environment variable 'GIT_TEST_COMMIT_GRAPH_NO_GDAT'
          which forces commit-graph file to be written without generation data
          chunk to emulate a commit-graph file written by old Git.
      
     -    While storing corrected commit date offset instead of the corrected
     -    commit date saves us 4 bytes per commit, it's possible for the offsets
     -    to overflow the 4-bytes allocated. As such overflows are exceedingly
     -    rare, we use the following overflow management scheme:
     +    To minimize the space required to store corrrected commit date, Git
     +    stores corrected commit date offsets into the commit-graph file, instea
     +    of corrected commit dates. This saves us 4 bytes per commit, decreasing
     +    the GDAT chunk size by half, but it's possible for the offset to
     +    overflow the 4-bytes allocated for storage. As such overflows are and
     +    should be exceedingly rare, we use the following overflow management
     +    scheme:
      
     -    We introduce a new commit-graph chunk, GENERATION_DATA_OVERFLOW ('GDOV')
     +    We introduce a new commit-graph chunk, Generation Data OVerflow ('GDOV')
          to store corrected commit dates for commits with offsets greater than
          GENERATION_NUMBER_V2_OFFSET_MAX.
      
     @@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct c
       
      -	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
      +	if (g->chunk_generation_data) {
     -+		offset = (timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     ++		offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
      +
      +		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
      +			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
     @@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct c
       	if (g->topo_levels)
       		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
      @@ commit-graph.c: struct write_commit_graph_context {
     - 	struct packed_oid_list oids;
     + 	struct oid_array oids;
       	struct packed_commit_list commits;
       	int num_extra_edges;
      +	int num_generation_data_overflows;
     @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
      +					      struct write_commit_graph_context *ctx)
      +{
      +	int i, num_generation_data_overflows = 0;
     ++
      +	for (i = 0; i < ctx->commits.nr; i++) {
      +		struct commit *c = ctx->commits.list[i];
      +		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
     @@ commit-graph.c: static int write_graph_chunk_data(struct hashfile *f,
       					 struct write_commit_graph_context *ctx)
       {
      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 
       				if (current->date && current->date > max_corrected_commit_date)
       					max_corrected_commit_date = current->date - 1;
     -+
       				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
      +
      +				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       
       	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
       						      bloom_settings.bits_per_entry);
     +@@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
     + 			continue;
     + 
     + 		/*
     +-		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
     +-		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
     +-		 * extra logic in the following condition.
     ++		 * If we are using topological level and one of our parents has
     ++		 * generation GENERATION_NUMBER_V1_MAX, then our generation is
     ++		 * also GENERATION_NUMBER_V1_MAX. Decrement to avoid extra logic
     ++		 * in the following condition.
     + 		 */
     +-		if (max_generation == GENERATION_NUMBER_V1_MAX)
     ++		if (!g->chunk_generation_data && max_generation == GENERATION_NUMBER_V1_MAX)
     + 			max_generation--;
     + 
     + 		generation = commit_graph_generation(graph_commit);
     +-		if (generation != max_generation + 1)
     +-			graph_report(_("commit-graph generation for commit %s is %"PRItime" != %"PRItime),
     ++		if (generation < max_generation + 1)
     ++			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
     + 				     oid_to_hex(&cur_oid),
     + 				     generation,
     + 				     max_generation + 1);
      
       ## commit-graph.h ##
      @@
     @@ t/t5318-commit-graph.sh: test_expect_success 'corrupt commit-graph write (missin
       	)
       '
       
     -+test_commit_with_date() {
     -+  file="$1.t" &&
     -+  echo "$1" >"$file" &&
     -+  git add "$file" &&
     -+  GIT_COMMITTER_DATE="$2" GIT_AUTHOR_DATE="$2" git commit -m "$1"
     -+  git tag "$1"
     -+}
     ++# We test the overflow-related code with the following repo history:
     ++#
     ++#               4:F - 5:N - 6:U
     ++#              /                \
     ++# 1:U - 2:N - 3:U                M:N
     ++#              \                /
     ++#               7:N - 8:F - 9:N
     ++#
     ++# Here the commits denoted by U have committer date of zero seconds
     ++# since Unix epoch, the commits denoted by N have committer date
     ++# starting from 1112354055 seconds since Unix epoch (default committer
     ++# date for the test suite), and the commits denoted by F have committer
     ++# date of (2 ^ 31 - 2) seconds since Unix epoch.
     ++#
     ++# The largest offset observed is 2 ^ 31, just large enough to overflow.
     ++#
      +
     -+test_expect_success 'overflow corrected commit date offset' '
     ++test_expect_success 'set up and verify repo with generation data overflow chunk' '
      +	objdir=".git/objects" &&
     -+	UNIX_EPOCH_ZERO="1970-01-01 00:00 +0000" &&
     ++	UNIX_EPOCH_ZERO="@0 +0000" &&
      +	FUTURE_DATE="@2147483646 +0000" &&
      +	test_oid_cache <<-EOF &&
      +	oid_version sha1:1
     @@ t/t5318-commit-graph.sh: test_expect_success 'corrupt commit-graph write (missin
      +	mkdir repo &&
      +	cd repo &&
      +	git init &&
     -+	test_commit_with_date 1 "$UNIX_EPOCH_ZERO" &&
     ++	test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
      +	test_commit 2 &&
     -+	test_commit_with_date 3 "$UNIX_EPOCH_ZERO" &&
     ++	test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
      +	git commit-graph write --reachable &&
      +	graph_read_expect 3 generation_data &&
     -+	test_commit_with_date 4 "$FUTURE_DATE" &&
     ++	test_commit --date "$FUTURE_DATE" 4 &&
      +	test_commit 5 &&
     -+	test_commit_with_date 6 "$UNIX_EPOCH_ZERO" &&
     ++	test_commit --date "$UNIX_EPOCH_ZERO" 6 &&
      +	git branch left &&
      +	git reset --hard 3 &&
      +	test_commit 7 &&
     -+	test_commit_with_date 8 "$FUTURE_DATE" &&
     ++	test_commit --date "$FUTURE_DATE" 8 &&
      +	test_commit 9 &&
      +	git branch right &&
      +	git reset --hard 3 &&
     -+	git merge left right &&
     ++	test_merge M left right &&
      +	git commit-graph write --reachable &&
      +	graph_read_expect 10 "generation_data generation_data_overflow" &&
      +	git commit-graph verify
      +'
      +
     -+graph_git_behavior 'overflow corrected commit date offset' repo left right
     ++graph_git_behavior 'generation data overflow chunk repo' repo left right
      +
       test_done
      
     @@ t/t6600-test-reach.sh: test_expect_success 'setup' '
       	git config core.commitGraph true
       '
       
     --run_three_modes () {
     -+run_all_modes () {
     - 	test_when_finished rm -rf .git/objects/info/commit-graph &&
     - 	"$@" <input >actual &&
     - 	test_cmp expect actual &&
     -@@ t/t6600-test-reach.sh: run_three_modes () {
     +@@ t/t6600-test-reach.sh: run_all_modes () {
       	test_cmp expect actual &&
       	cp commit-graph-half .git/objects/info/commit-graph &&
       	"$@" <input >actual &&
     @@ t/t6600-test-reach.sh: run_three_modes () {
       	test_cmp expect actual
       }
       
     --test_three_modes () {
     --	run_three_modes test-tool reach "$@"
     -+test_all_modes () {
     -+	run_all_modes test-tool reach "$@"
     - }
     - 
     - test_expect_success 'ref_newer:miss' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'ref_newer:miss' '
     - 	B:commit-4-9
     - 	EOF
     - 	echo "ref_newer(A,B):0" >expect &&
     --	test_three_modes ref_newer
     -+	test_all_modes ref_newer
     - '
     - 
     - test_expect_success 'ref_newer:hit' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'ref_newer:hit' '
     - 	B:commit-2-3
     - 	EOF
     - 	echo "ref_newer(A,B):1" >expect &&
     --	test_three_modes ref_newer
     -+	test_all_modes ref_newer
     - '
     - 
     - test_expect_success 'in_merge_bases:hit' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases:hit' '
     - 	B:commit-8-8
     - 	EOF
     - 	echo "in_merge_bases(A,B):1" >expect &&
     --	test_three_modes in_merge_bases
     -+	test_all_modes in_merge_bases
     - '
     - 
     - test_expect_success 'in_merge_bases:miss' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases:miss' '
     - 	B:commit-5-9
     - 	EOF
     - 	echo "in_merge_bases(A,B):0" >expect &&
     --	test_three_modes in_merge_bases
     -+	test_all_modes in_merge_bases
     - '
     - 
     - test_expect_success 'in_merge_bases_many:hit' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:hit' '
     - 	X:commit-5-7
     - 	EOF
     - 	echo "in_merge_bases_many(A,X):1" >expect &&
     --	test_three_modes in_merge_bases_many
     -+	test_all_modes in_merge_bases_many
     - '
     - 
     - test_expect_success 'in_merge_bases_many:miss' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:miss' '
     - 	X:commit-8-6
     - 	EOF
     - 	echo "in_merge_bases_many(A,X):0" >expect &&
     --	test_three_modes in_merge_bases_many
     -+	test_all_modes in_merge_bases_many
     - '
     - 
     - test_expect_success 'in_merge_bases_many:miss-heuristic' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'in_merge_bases_many:miss-heuristic' '
     - 	X:commit-6-6
     - 	EOF
     - 	echo "in_merge_bases_many(A,X):0" >expect &&
     --	test_three_modes in_merge_bases_many
     -+	test_all_modes in_merge_bases_many
     - '
     - 
     - test_expect_success 'is_descendant_of:hit' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'is_descendant_of:hit' '
     - 	X:commit-1-1
     - 	EOF
     - 	echo "is_descendant_of(A,X):1" >expect &&
     --	test_three_modes is_descendant_of
     -+	test_all_modes is_descendant_of
     - '
     - 
     - test_expect_success 'is_descendant_of:miss' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'is_descendant_of:miss' '
     - 	X:commit-7-6
     - 	EOF
     - 	echo "is_descendant_of(A,X):0" >expect &&
     --	test_three_modes is_descendant_of
     -+	test_all_modes is_descendant_of
     - '
     - 
     - test_expect_success 'get_merge_bases_many' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'get_merge_bases_many' '
     - 		git rev-parse commit-5-6 \
     - 			      commit-4-7 | sort
     - 	} >expect &&
     --	test_three_modes get_merge_bases_many
     -+	test_all_modes get_merge_bases_many
     - '
     - 
     - test_expect_success 'reduce_heads' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'reduce_heads' '
     - 			      commit-2-8 \
     - 			      commit-1-10 | sort
     - 	} >expect &&
     --	test_three_modes reduce_heads
     -+	test_all_modes reduce_heads
     - '
     - 
     - test_expect_success 'can_all_from_reach:hit' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'can_all_from_reach:hit' '
     - 	Y:commit-8-1
     - 	EOF
     - 	echo "can_all_from_reach(X,Y):1" >expect &&
     --	test_three_modes can_all_from_reach
     -+	test_all_modes can_all_from_reach
     - '
     - 
     - test_expect_success 'can_all_from_reach:miss' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'can_all_from_reach:miss' '
     - 	Y:commit-8-5
     - 	EOF
     - 	echo "can_all_from_reach(X,Y):0" >expect &&
     --	test_three_modes can_all_from_reach
     -+	test_all_modes can_all_from_reach
     - '
     - 
     - test_expect_success 'can_all_from_reach_with_flag: tags case' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'can_all_from_reach_with_flag: tags case' '
     - 	Y:commit-8-1
     - 	EOF
     - 	echo "can_all_from_reach_with_flag(X,_,_,0,0):1" >expect &&
     --	test_three_modes can_all_from_reach_with_flag
     -+	test_all_modes can_all_from_reach_with_flag
     - '
     - 
     - test_expect_success 'commit_contains:hit' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'commit_contains:hit' '
     - 	X:commit-9-3
     - 	EOF
     - 	echo "commit_contains(_,A,X,_):1" >expect &&
     --	test_three_modes commit_contains &&
     --	test_three_modes commit_contains --tag
     -+	test_all_modes commit_contains &&
     -+	test_all_modes commit_contains --tag
     - '
     - 
     - test_expect_success 'commit_contains:miss' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'commit_contains:miss' '
     - 	X:commit-9-3
     - 	EOF
     - 	echo "commit_contains(_,A,X,_):0" >expect &&
     --	test_three_modes commit_contains &&
     --	test_three_modes commit_contains --tag
     -+	test_all_modes commit_contains &&
     -+	test_all_modes commit_contains --tag
     - '
     - 
     - test_expect_success 'rev-list: basic topo-order' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: basic topo-order' '
     - 		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
     - 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
     - 	>expect &&
     --	run_three_modes git rev-list --topo-order commit-6-6
     -+	run_all_modes git rev-list --topo-order commit-6-6
     - '
     - 
     - test_expect_success 'rev-list: first-parent topo-order' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: first-parent topo-order' '
     - 		commit-6-2 \
     - 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
     - 	>expect &&
     --	run_three_modes git rev-list --first-parent --topo-order commit-6-6
     -+	run_all_modes git rev-list --first-parent --topo-order commit-6-6
     - '
     - 
     - test_expect_success 'rev-list: range topo-order' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: range topo-order' '
     - 		commit-6-2 commit-5-2 commit-4-2 \
     - 		commit-6-1 commit-5-1 commit-4-1 \
     - 	>expect &&
     --	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
     -+	run_all_modes git rev-list --topo-order commit-3-3..commit-6-6
     - '
     - 
     - test_expect_success 'rev-list: range topo-order' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: range topo-order' '
     - 		commit-6-2 commit-5-2 commit-4-2 \
     - 		commit-6-1 commit-5-1 commit-4-1 \
     - 	>expect &&
     --	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
     -+	run_all_modes git rev-list --topo-order commit-3-8..commit-6-6
     - '
     - 
     - test_expect_success 'rev-list: first-parent range topo-order' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: first-parent range topo-order' '
     - 		commit-6-2 \
     - 		commit-6-1 commit-5-1 commit-4-1 \
     - 	>expect &&
     --	run_three_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
     -+	run_all_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
     - '
     - 
     - test_expect_success 'rev-list: ancestry-path topo-order' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: ancestry-path topo-order' '
     - 		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
     - 		commit-6-3 commit-5-3 commit-4-3 \
     - 	>expect &&
     --	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
     -+	run_all_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
     - '
     - 
     - test_expect_success 'rev-list: symmetric difference topo-order' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'rev-list: symmetric difference topo-order' '
     - 		commit-3-8 commit-2-8 commit-1-8 \
     - 		commit-3-7 commit-2-7 commit-1-7 \
     - 	>expect &&
     --	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
     -+	run_all_modes git rev-list --topo-order commit-3-8...commit-6-6
     - '
     - 
     - test_expect_success 'get_reachable_subset:all' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'get_reachable_subset:all' '
     - 			      commit-1-7 \
     - 			      commit-5-6 | sort
     - 	) >expect &&
     --	test_three_modes get_reachable_subset
     -+	test_all_modes get_reachable_subset
     - '
     - 
     - test_expect_success 'get_reachable_subset:some' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'get_reachable_subset:some' '
     - 		git rev-parse commit-3-3 \
     - 			      commit-1-7 | sort
     - 	) >expect &&
     --	test_three_modes get_reachable_subset
     -+	test_all_modes get_reachable_subset
     - '
     - 
     - test_expect_success 'get_reachable_subset:none' '
     -@@ t/t6600-test-reach.sh: test_expect_success 'get_reachable_subset:none' '
     - 	Y:commit-2-8
     - 	EOF
     - 	echo "get_reachable_subset(X,Y)" >expect &&
     --	test_three_modes get_reachable_subset
     -+	test_all_modes get_reachable_subset
     - '
     - 
     - test_done
     +
     + ## t/test-lib-functions.sh ##
     +@@ t/test-lib-functions.sh: test_commit () {
     + 		--signoff)
     + 			signoff="$1"
     + 			;;
     ++		--date)
     ++			notick=yes
     ++			GIT_COMMITTER_DATE="$2"
     ++			GIT_AUTHOR_DATE="$2"
     ++			shift
     ++			;;
     + 		-C)
     + 			indir="$2"
     + 			shift
  8:  8ec119edc66 !  9:  a3a70a1edd0 commit-graph: use generation v2 only if entire chain does
     @@ Commit message
          1. "New" Git writes a commit-graph with the GDAT chunk.
          2. "Old" Git writes a split commit-graph on top without a GDAT chunk.
      
     -    Because of the current use of inspecting the current layer for a
     -    chunk_generation_data pointer, the commits in the lower layer will be
     -    interpreted as having very large generation values (commit date plus
     -    offset) compared to the generation numbers in the top layer (topological
     -    level). This violates the expectation that the generation of a parent is
     -    strictly smaller than the generation of a child.
     +    If each layer of split commit-graph is treated independently, as it was
     +    the case before this commit, with Git inspecting only the current layer
     +    for chunk_generation_data pointer, commits in the lower layer (one with
     +    GDAT) whould have corrected commit date as their generation number,
     +    while commits in the upper layer would have topological levels as their
     +    generation. Corrected commit dates usually have much larger values than
     +    topological levels. This means that if we take two commits, one from the
     +    upper layer, and one reachable from it in the lower layer, then the
     +    expectation that the generation of a parent is smaller than the
     +    generation of a child would be violated.
      
          It is difficult to expose this issue in a test. Since we _start_ with
          artificially low generation numbers, any commit walk that prioritizes
     @@ Commit message
          commits in the lower layer before allowing the topo-order queue to write
          anything to output (depending on the size of the upper layer).
      
     -    When writing the new layer in split commit-graph, we write a GDAT chunk
     -    only if the topmost layer has a GDAT chunk. This guarantees that if a
     -    layer has GDAT chunk, all lower layers must have a GDAT chunk as well.
     +    Therefore, When writing the new layer in split commit-graph, we write a
     +    GDAT chunk only if the topmost layer has a GDAT chunk. This guarantees
     +    that if a layer has GDAT chunk, all lower layers must have a GDAT chunk
     +    as well.
      
          Rewriting layers follows similar approach: if the topmost layer below
          the set of layers being rewritten (in the split commit-graph chain)
     @@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct c
       	item->date = (timestamp_t)((date_high << 32) | date_low);
       
      -	if (g->chunk_generation_data) {
     -+	if (g->chunk_generation_data && g->read_generation_data) {
     - 		offset = (timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
     ++	if (g->read_generation_data) {
     + 		offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
       
       		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
      @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
     - 		}
     - 	}
     + 		if (i < ctx->num_commit_graphs_after)
     + 			ctx->commit_graph_hash_after[i] = xstrdup(oid_to_hex(&g->oid));
       
     -+	if (!ctx->write_generation_data && g->chunk_generation_data)
     -+		ctx->write_generation_data = 1;
     ++		/*
     ++		 * If the topmost remaining layer has generation data chunk, the
     ++		 * resultant layer also has generation data chunk.
     ++		 */
     ++		if (i == ctx->num_commit_graphs_after - 2)
     ++			ctx->write_generation_data = !!g->chunk_generation_data;
      +
     - 	if (flags != COMMIT_GRAPH_SPLIT_REPLACE)
     - 		ctx->new_base_graph = g;
     - 	else if (ctx->num_commit_graphs_after != 1)
     + 		i--;
     + 		g = g->base_graph;
     + 	}
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       		struct commit_graph *g = ctx->r->objects->commit_graph;
       
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       			g->topo_levels = &topo_levels;
       			g = g->base_graph;
       		}
     -@@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     - 
     - 		g = ctx->r->objects->commit_graph;
     +@@ commit-graph.c: int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
     + 		 * also GENERATION_NUMBER_V1_MAX. Decrement to avoid extra logic
     + 		 * in the following condition.
     + 		 */
     +-		if (!g->chunk_generation_data && max_generation == GENERATION_NUMBER_V1_MAX)
     ++		if (!g->read_generation_data && max_generation == GENERATION_NUMBER_V1_MAX)
     + 			max_generation--;
       
     -+		if (g && !g->chunk_generation_data)
     -+			ctx->write_generation_data = 0;
     -+
     - 		while (g) {
     - 			ctx->num_commit_graphs_before++;
     - 			g = g->base_graph;
     -@@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     - 
     - 		if (ctx->opts)
     - 			replace = ctx->opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
     -+
     -+		if (replace)
     -+			ctx->write_generation_data = 1;
     - 	}
     - 
     - 	ctx->approx_nr_objects = approximate_object_count();
     + 		generation = commit_graph_generation(graph_commit);
      
       ## commit-graph.h ##
      @@ commit-graph.h: struct commit_graph {
     @@ commit-graph.h: struct commit_graph {
       	const uint32_t *chunk_oid_fanout;
      
       ## t/t5324-split-commit-graph.sh ##
     -@@ t/t5324-split-commit-graph.sh: test_expect_success '--split=replace with partial Bloom data' '
     - 	verify_chain_files_exist $graphdir
     +@@ t/t5324-split-commit-graph.sh: test_expect_success 'prevent regression for duplicate commits across layers' '
     + 	git -C dup commit-graph verify
       '
       
     ++NUM_FIRST_LAYER_COMMITS=64
     ++NUM_SECOND_LAYER_COMMITS=16
     ++NUM_THIRD_LAYER_COMMITS=7
     ++NUM_FOURTH_LAYER_COMMITS=8
     ++NUM_FIFTH_LAYER_COMMITS=16
     ++SECOND_LAYER_SEQUENCE_START=$(($NUM_FIRST_LAYER_COMMITS + 1))
     ++SECOND_LAYER_SEQUENCE_END=$(($SECOND_LAYER_SEQUENCE_START + $NUM_SECOND_LAYER_COMMITS - 1))
     ++THIRD_LAYER_SEQUENCE_START=$(($SECOND_LAYER_SEQUENCE_END + 1))
     ++THIRD_LAYER_SEQUENCE_END=$(($THIRD_LAYER_SEQUENCE_START + $NUM_THIRD_LAYER_COMMITS - 1))
     ++FOURTH_LAYER_SEQUENCE_START=$(($THIRD_LAYER_SEQUENCE_END + 1))
     ++FOURTH_LAYER_SEQUENCE_END=$(($FOURTH_LAYER_SEQUENCE_START + $NUM_FOURTH_LAYER_COMMITS - 1))
     ++FIFTH_LAYER_SEQUENCE_START=$(($FOURTH_LAYER_SEQUENCE_END + 1))
     ++FIFTH_LAYER_SEQUENCE_END=$(($FIFTH_LAYER_SEQUENCE_START + $NUM_FIFTH_LAYER_COMMITS - 1))
     ++
     ++# Current split graph chain:
     ++#
     ++#     16 commits (No GDAT)
     ++# ------------------------
     ++#     64 commits (GDAT)
     ++#
      +test_expect_success 'setup repo for mixed generation commit-graph-chain' '
     -+	mkdir mixed &&
      +	graphdir=".git/objects/info/commit-graphs" &&
     -+	test_oid_cache <<-EOM &&
     ++	test_oid_cache <<-EOF &&
      +	oid_version sha1:1
      +	oid_version sha256:2
     -+	EOM
     -+	cd "$TRASH_DIRECTORY/mixed" &&
     -+	git init &&
     -+	git config core.commitGraph true &&
     -+	git config gc.writeCommitGraph false &&
     -+	for i in $(test_seq 3)
     -+	do
     -+		test_commit $i &&
     -+		git branch commits/$i || return 1
     -+	done &&
     -+	git reset --hard commits/1 &&
     -+	for i in $(test_seq 4 5)
     -+	do
     -+		test_commit $i &&
     -+		git branch commits/$i || return 1
     -+	done &&
     -+	git reset --hard commits/2 &&
     -+	for i in $(test_seq 6 10)
     -+	do
     -+		test_commit $i &&
     -+		git branch commits/$i || return 1
     -+	done &&
     -+	git commit-graph write --reachable --split &&
     -+	git reset --hard commits/2 &&
     -+	git merge commits/4 &&
     -+	git branch merge/1 &&
     -+	git reset --hard commits/4 &&
     -+	git merge commits/6 &&
     -+	git branch merge/2 &&
     -+	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
     -+	test-tool read-graph >output &&
     -+	cat >expect <<-EOF &&
     -+	header: 43475048 1 $(test_oid oid_version) 4 1
     -+	num_commits: 2
     -+	chunks: oid_fanout oid_lookup commit_metadata
      +	EOF
     -+	test_cmp expect output &&
     -+	git commit-graph verify
     ++	git init mixed &&
     ++	(
     ++		cd mixed &&
     ++		git config core.commitGraph true &&
     ++		git config gc.writeCommitGraph false &&
     ++		for i in $(test_seq $NUM_FIRST_LAYER_COMMITS)
     ++		do
     ++			test_commit $i &&
     ++			git branch commits/$i || return 1
     ++		done &&
     ++		git commit-graph write --reachable --split &&
     ++		graph_read_expect $NUM_FIRST_LAYER_COMMITS &&
     ++		test_line_count = 1 $graphdir/commit-graph-chain &&
     ++		for i in $(test_seq $SECOND_LAYER_SEQUENCE_START $SECOND_LAYER_SEQUENCE_END)
     ++		do
     ++			test_commit $i &&
     ++			git branch commits/$i || return 1
     ++		done &&
     ++		GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
     ++		test_line_count = 2 $graphdir/commit-graph-chain &&
     ++		test-tool read-graph >output &&
     ++		cat >expect <<-EOF &&
     ++		header: 43475048 1 $(test_oid oid_version) 4 1
     ++		num_commits: $NUM_SECOND_LAYER_COMMITS
     ++		chunks: oid_fanout oid_lookup commit_metadata
     ++		EOF
     ++		test_cmp expect output &&
     ++		git commit-graph verify &&
     ++		cat $graphdir/commit-graph-chain
     ++	)
      +'
      +
     -+test_expect_success 'does not write generation data chunk if not present on existing tip' '
     -+	cd "$TRASH_DIRECTORY/mixed" &&
     -+	git reset --hard commits/3 &&
     -+	git merge merge/1 &&
     -+	git merge commits/5 &&
     -+	git merge merge/2 &&
     -+	git branch merge/3 &&
     -+	git commit-graph write --reachable --split=no-merge &&
     -+	test-tool read-graph >output &&
     -+	cat >expect <<-EOF &&
     -+	header: 43475048 1 $(test_oid oid_version) 4 2
     -+	num_commits: 3
     -+	chunks: oid_fanout oid_lookup commit_metadata
     -+	EOF
     -+	test_cmp expect output &&
     -+	git commit-graph verify
     ++# The new layer will be added without generation data chunk as it was not
     ++# present on the layer underneath it.
     ++#
     ++#      7 commits (No GDAT)
     ++# ------------------------
     ++#     16 commits (No GDAT)
     ++# ------------------------
     ++#     64 commits (GDAT)
     ++#
     ++test_expect_success 'do not write generation data chunk if not present on existing tip' '
     ++	git clone mixed mixed-no-gdat &&
     ++	(
     ++		cd mixed-no-gdat &&
     ++		for i in $(test_seq $THIRD_LAYER_SEQUENCE_START $THIRD_LAYER_SEQUENCE_END)
     ++		do
     ++			test_commit $i &&
     ++			git branch commits/$i || return 1
     ++		done &&
     ++		git commit-graph write --reachable --split=no-merge &&
     ++		test_line_count = 3 $graphdir/commit-graph-chain &&
     ++		test-tool read-graph >output &&
     ++		cat >expect <<-EOF &&
     ++		header: 43475048 1 $(test_oid oid_version) 4 2
     ++		num_commits: $NUM_THIRD_LAYER_COMMITS
     ++		chunks: oid_fanout oid_lookup commit_metadata
     ++		EOF
     ++		test_cmp expect output &&
     ++		git commit-graph verify
     ++	)
     ++'
     ++
     ++# Number of commits in each layer of the split-commit graph before merge:
     ++#
     ++#      8 commits (No GDAT)
     ++# ------------------------
     ++#      7 commits (No GDAT)
     ++# ------------------------
     ++#     16 commits (No GDAT)
     ++# ------------------------
     ++#     64 commits (GDAT)
     ++#
     ++# The top two layers are merged and do not have generation data chunk as layer below them does
     ++# not have generation data chunk.
     ++#
     ++#     15 commits (No GDAT)
     ++# ------------------------
     ++#     16 commits (No GDAT)
     ++# ------------------------
     ++#     64 commits (GDAT)
     ++#
     ++test_expect_success 'do not write generation data chunk if the topmost remaining layer does not have generation data chunk' '
     ++	git clone mixed-no-gdat mixed-merge-no-gdat &&
     ++	(
     ++		cd mixed-merge-no-gdat &&
     ++		for i in $(test_seq $FOURTH_LAYER_SEQUENCE_START $FOURTH_LAYER_SEQUENCE_END)
     ++		do
     ++			test_commit $i &&
     ++			git branch commits/$i || return 1
     ++		done &&
     ++		git commit-graph write --reachable --split --size-multiple 1 &&
     ++		test_line_count = 3 $graphdir/commit-graph-chain &&
     ++		test-tool read-graph >output &&
     ++		cat >expect <<-EOF &&
     ++		header: 43475048 1 $(test_oid oid_version) 4 2
     ++		num_commits: $(($NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS))
     ++		chunks: oid_fanout oid_lookup commit_metadata
     ++		EOF
     ++		test_cmp expect output &&
     ++		git commit-graph verify
     ++	)
      +'
      +
     -+test_expect_success 'writes generation data chunk when commit-graph chain is replaced' '
     -+	cd "$TRASH_DIRECTORY/mixed" &&
     -+	git commit-graph write --reachable --split=replace &&
     -+	test_path_is_file $graphdir/commit-graph-chain &&
     -+	test_line_count = 1 $graphdir/commit-graph-chain &&
     -+	verify_chain_files_exist $graphdir &&
     -+	graph_read_expect 15 &&
     -+	git commit-graph verify
     ++# Number of commits in each layer of the split-commit graph before merge:
     ++#
     ++#     16 commits (No GDAT)
     ++# ------------------------
     ++#     15 commits (No GDAT)
     ++# ------------------------
     ++#     16 commits (No GDAT)
     ++# ------------------------
     ++#     64 commits (GDAT)
     ++#
     ++# The top three layers are merged and has generation data chunk as the topmost remaining layer
     ++# has generation data chunk.
     ++#
     ++#     47 commits (GDAT)
     ++# ------------------------
     ++#     64 commits (GDAT)
     ++#
     ++test_expect_success 'write generation data chunk if topmost remaining layer has generation data chunk' '
     ++	git clone mixed-merge-no-gdat mixed-merge-gdat &&
     ++	(
     ++		cd mixed-merge-gdat &&
     ++		for i in $(test_seq $FIFTH_LAYER_SEQUENCE_START $FIFTH_LAYER_SEQUENCE_END)
     ++		do
     ++			test_commit $i &&
     ++			git branch commits/$i || return 1
     ++		done &&
     ++		git commit-graph write --reachable --split --size-multiple 1 &&
     ++		test_line_count = 2 $graphdir/commit-graph-chain &&
     ++		test-tool read-graph >output &&
     ++		cat >expect <<-EOF &&
     ++		header: 43475048 1 $(test_oid oid_version) 5 1
     ++		num_commits: $(($NUM_SECOND_LAYER_COMMITS + $NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS + $NUM_FIFTH_LAYER_COMMITS))
     ++		chunks: oid_fanout oid_lookup commit_metadata generation_data
     ++		EOF
     ++		test_cmp expect output
     ++	)
      +'
      +
     -+test_expect_success 'add one commit, write a tip graph' '
     -+	cd "$TRASH_DIRECTORY/mixed" &&
     -+	test_commit 11 &&
     -+	git branch commits/11 &&
     -+	git commit-graph write --reachable --split &&
     -+	test_path_is_missing $infodir/commit-graph &&
     -+	test_path_is_file $graphdir/commit-graph-chain &&
     -+	ls $graphdir/graph-*.graph >graph-files &&
     -+	test_line_count = 2 graph-files &&
     -+	verify_chain_files_exist $graphdir
     ++test_expect_success 'write generation data chunk when commit-graph chain is replaced' '
     ++	git clone mixed mixed-replace &&
     ++	(
     ++		cd mixed-replace &&
     ++		git commit-graph write --reachable --split=replace &&
     ++		test_path_is_file $graphdir/commit-graph-chain &&
     ++		test_line_count = 1 $graphdir/commit-graph-chain &&
     ++		verify_chain_files_exist $graphdir &&
     ++		graph_read_expect $(($NUM_FIRST_LAYER_COMMITS + $NUM_SECOND_LAYER_COMMITS)) &&
     ++		git commit-graph verify
     ++	)
      +'
      +
       test_done
  9:  bb9b02af32d ! 10:  093101f908b commit-reach: use corrected commit dates in paint_down_to_common()
     @@ Metadata
       ## Commit message ##
          commit-reach: use corrected commit dates in paint_down_to_common()
      
     -    With corrected commit dates implemented, we no longer have to rely on
     -    commit date as a heuristic in paint_down_to_common().
     +    091f4cf (commit: don't use generation numbers if not needed,
     +    2018-08-30) changed paint_down_to_common() to use commit dates instead
     +    of generation numbers v1 (topological levels) as the performance
     +    regressed on certain topologies. With generation number v2 (corrected
     +    commit dates) implemented, we no longer have to rely on commit dates and
     +    can use generation numbers.
      
     -    While using corrected commit dates Git walks nearly the same number of
     +    For example, the command `git merge-base v4.8 v4.9` on the Linux
     +    repository walks 167468 commits, taking 0.135s for committer date and
     +    167496 commits, taking 0.157s for corrected committer date respectively.
     +
     +    While using corrected commit dates, Git walks nearly the same number of
          commits as commit date, the process is slower as for each comparision we
          have to access a commit-slab (for corrected committer date) instead of
          accessing struct member (for committer date).
      
     -    For example, the command `git merge-base v4.8 v4.9` on the linux
     -    repository walks 167468 commits, taking 0.135s for committer date and
     -    167496 commits, taking 0.157s for corrected committer date respectively.
     -
     -    t6404-recursive-merge setups a unique repository where all commits have
     -    the same committer date without well-defined merge-base.
     +    This change incidentally broke the fragile t6404-recursive-merge test.
     +    t6404-recursive-merge sets up a unique repository where all commits have
     +    the same committer date without a well-defined merge-base.
      
          While running tests with GIT_TEST_COMMIT_GRAPH unset, we use committer
          date as a heuristic in paint_down_to_common(). 6404.1 'combined merge
          conflicts' merges commits in the order:
     -    - Merge C with B to form a intermediate commit.
     +    - Merge C with B to form an intermediate commit.
          - Merge the intermediate commit with A.
      
          With GIT_TEST_COMMIT_GRAPH=1, we write a commit-graph and subsequently
          use the corrected committer date, which changes the order in which
          commits are merged:
     -    - Merge A with B to form a intermediate commit.
     +    - Merge A with B to form an intermediate commit.
          - Merge the intermediate commit with C.
      
          While resulting repositories are equivalent, 6404.4 'virtual trees were
     @@ commit-graph.c: int generation_numbers_enabled(struct repository *r)
       	struct commit_graph *g = r->objects->commit_graph;
      
       ## commit-graph.h ##
     -@@ commit-graph.h: struct commit_graph *read_commit_graph_one(struct repository *r,
     - struct commit_graph *parse_commit_graph(struct repository *r,
     - 					void *graph_map, size_t graph_size);
     - 
     -+struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
     -+
     - /*
     -  * Return 1 if and only if the repository has a commit-graph
     -  * file and generation numbers are computed in that file.
     +@@ commit-graph.h: struct commit_graph *parse_commit_graph(struct repository *r,
        */
       int generation_numbers_enabled(struct repository *r);
       
     --struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
      +/*
      + * Return 1 if and only if the repository has a commit-graph
      + * file and generation data chunk has been written for the file.
      + */
      +int corrected_commit_dates_enabled(struct repository *r);
     ++
     + struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
       
       enum commit_graph_write_flags {
     - 	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
      
       ## commit-reach.c ##
      @@ commit-reach.c: static struct commit_list *paint_down_to_common(struct repository *r,
 10:  9ada43967d2 ! 11:  20299e57457 doc: add corrected commit date info
     @@ Documentation/technical/commit-graph-format.txt: CHUNK DATA:
             2 bits of the lowest byte, storing the 33rd and 34th bit of the
             commit time.
       
     -+  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes)
     ++  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
      +    * This list of 4-byte values store corrected commit date offsets for the
      +      commits, arranged in the same order as commit data chunk.
      +    * If the corrected commit date offset cannot be stored within 31 bits,
      +      the value has its most-significant bit on and the other bits store
      +      the position of corrected commit date into the Generation Data Overflow
      +      chunk.
     ++    * Generation Data chunk is present only when commit-graph file is written
     ++      by compatible versions of Git and in case of split commit-graph chains,
     ++      the topmost layer also has Generation Data chunk.
      +
      +  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
     -+    * This list of 8-byte values stores the corrected commit dates for commits
     -+      with corrected commit date offsets that cannot be stored within 31 bits.
     ++    * This list of 8-byte values stores the corrected commit date offsets
     ++      for commits with corrected commit date offsets that cannot be
     ++      stored within 31 bits.
     ++    * Generation Data Overflow chunk is present only when Generation Data
     ++      chunk is present and atleast one corrected commit date offset cannot
     ++      be stored within 31 bits.
      +
         Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
             This list of 4-byte values store the second through nth parents for
     @@ Documentation/technical/commit-graph.txt: A consumer may load the following info
       
      - * A commit with at least one parent has generation number one more than
      -   the largest generation number among its parents.
     -+  * A commit with no parents (a root commit) has corrected committer date
     ++ * A commit with no parents (a root commit) has corrected committer date
      +    equal to its committer date.
       
      -Equivalently, the generation number of a commit A is one more than the
     -+  * A commit with at least one parent has corrected committer date equal to
     ++ * A commit with at least one parent has corrected committer date equal to
      +    the maximum of its commiter date and one more than the largest corrected
      +    committer date among its parents.
      +
     -+  * As a special case, a root commit with timestamp zero has corrected commit
     ++ * As a special case, a root commit with timestamp zero has corrected commit
      +    date of 1, to be able to distinguish it from GENERATION_NUMBER_ZERO
      +    (that is, an uncomputed corrected commit date).
      +
     @@ Documentation/technical/commit-graph.txt: is easier to use for computation and o
           generation numbers, then we always expand the boundary commit with highest
           generation number and can easily detect the stopping condition.
       
     -+The properties applies to both versions of generation number, that is both
     ++The property applies to both versions of generation number, that is both
      +corrected committer dates and topological levels.
      +
       This property can be used to significantly reduce the time it takes to
     @@ Documentation/technical/commit-graph.txt: fully-computed generation numbers. Usi
       with generation number *_INFINITY or *_ZERO is valuable.
       
      -We use the macro GENERATION_NUMBER_MAX = 0x3FFFFFFF to for commits whose
     -+We use the macro GENERATION_NUMBER_MAX for commits whose
     - generation numbers are computed to be at least this value. We limit at
     - this value since it is the largest value that can be stored in the
     - commit-graph file using the 30 bits available to generation numbers. This
     +-generation numbers are computed to be at least this value. We limit at
     +-this value since it is the largest value that can be stored in the
     +-commit-graph file using the 30 bits available to generation numbers. This
     +-presents another case where a commit can have generation number equal to
     +-that of a parent.
     ++We use the macro GENERATION_NUMBER_V1_MAX = 0x3FFFFFFF for commits whose
     ++topological levels (generation number v1) are computed to be at least
     ++this value. We limit at this value since it is the largest value that
     ++can be stored in the commit-graph file using the 30 bits available
     ++to topological levels. This presents another case where a commit can
     ++have generation number equal to that of a parent.
     + 
     + Design Details
     + --------------
      @@ Documentation/technical/commit-graph.txt: The merge strategy values (2 for the size multiple, 64,000 for the maximum
       number of commits) could be extracted into config settings for full
       flexibility.
     @@ Documentation/technical/commit-graph.txt: The merge strategy values (2 for the s
      +A naive approach of using the newest available generation number from
      +each layer would lead to violated expectations: the lower layer would
      +use corrected commit dates which are much larger than the topological
     -+levels of the higher layer. For this reason, Git inspects each layer to
     -+see if any layer is missing corrected commit dates. In such a case, Git
     -+only uses topological level
     ++levels of the higher layer. For this reason, Git inspects the topmost
     ++layer to see if the layer is missing corrected commit dates. In such a case
     ++Git only uses topological level for generation numbers.
      +
      +When writing a new layer in split commit-graph, we write corrected commit
      +dates if the topmost layer has corrected commit dates written. This
     @@ Documentation/technical/commit-graph.txt: The merge strategy values (2 for the s
      +must have corrected commit dates as well.
      +
      +When merging layers, we do not consider whether the merged layers had corrected
     -+commit dates. Instead, the new layer will have corrected commit dates if and
     -+only if all existing layers below the new layer have corrected commit dates.
     ++commit dates. Instead, the new layer will have corrected commit dates if the
     ++layer below the new layer has corrected commit dates.
     ++
     ++While writing or merging layers, if the new layer is the only layer, it will
     ++have corrected commit dates when written by compatible versions of Git. Thus,
     ++rewriting split commit-graph as a single file (`--split=replace`) creates a
     ++single layer with corrected commit dates.
      +
       ## Deleting graph-{hash} files
       

-- 
gitgitgadget
