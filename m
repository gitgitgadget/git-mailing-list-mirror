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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0269C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57ACD64E2B
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBAG7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 01:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBAG7c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 01:59:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D11DC061574
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:51 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c4so12608788wru.9
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SoNKA3B73w3/BXkmBVuE3GN52ocbv4RgYUIbtxFO8qI=;
        b=nymhvw7xMC2qHOSoXDmXuqBlSoXJHT73e8z9q2hLTHrrBbDklmPgFeCc8jhkmqtA87
         kX2OwTqPVDq0UTMlqj50WbIVsj2n5PkV3BrQKFrLtfxdHq91kVqV65RT3B2TERFQbUuR
         nsVE7aOh2gdchagow9wN8mk1Cnm5rZ3SyRvdX5KLorzNN2/2FiQWVi85ti+YryIOi+Fm
         pdiU/a0bQDgJB92PS7Yk+T8AApYjCh+p5mrtAJC6phNfn+IuyibqA0PkuB0LVjUhH01D
         tRyZTZXcm/8g5tqxjjLUD4Fq33cVkyegeG/DW4oSM2mPzgDGAYXiraIu/9eyL0DHkmVO
         tYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SoNKA3B73w3/BXkmBVuE3GN52ocbv4RgYUIbtxFO8qI=;
        b=Ak2u5mqPXrgfc7zovmsFo4VjUXmwo1pX2xcC3brLNpyH0tFtREv5Df55vFK1IWVYJS
         cUgLaLf9BVnsyRHF/j76LeFHlEpoQfIdJv4ixaK3e5csVnhwyKV9WRCcZRihPdENmzNL
         zI1TByI7wRMxMt6CyCQPt9SvRXEac6wxJzMHH1WQ5hGgCc7YrkUr/uqGj2QDXK9OMHdD
         64JPHweco7b0XfJy7b1FO9rc2eXvC2n3qKeX3VjnHuJbccr6aR+XfmIPKd2gbiQQzOaV
         O97l8soreN1vB2K5s9gk6V0Ga7ubVZFO4mkLWuT0XPXYnuY0V66Ghm7l7grzA5VOi4/9
         yOTQ==
X-Gm-Message-State: AOAM531gIVyewk4BZyf4KfneiojGpQ9+idbBzhn8vEIITXztytmnmcej
        nCPPaCTN3vXIJRhlDQfOLw/P7xOD00U=
X-Google-Smtp-Source: ABdhPJxoXFEuZPoDaLv3RcIXXjQw84pl9+I47kG8hPfekvi5ailO2XI0gLMeo7UaNK9O5zPQUEdWsA==
X-Received: by 2002:a5d:4b46:: with SMTP id w6mr16515746wrs.346.1612162728092;
        Sun, 31 Jan 2021 22:58:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm20347859wmc.10.2021.01.31.22.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 22:58:47 -0800 (PST)
Message-Id: <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
References: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 06:58:34 +0000
Subject: [PATCH v7 00/11] [GSoC] Implement Corrected Commit Date
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series implements the corrected commit date offsets as generation
number v2, along with other pre-requisites.

Git uses topological levels in the commit-graph file for commit-graph
traversal operations like 'git log --graph'. Unfortunately, topological
levels can perform worse than committer date when parents of a commit differ
greatly in generation numbers [1]. For example, 'git merge-base v4.8 v4.9'
on the Linux repository walks 635,579 commits using topological levels and
walks 167,468 using committer date. Since 091f4cf3 (commit: don't use
generation numbers if not needed, 2018-08-30), 'git merge-base' uses
committer date heuristic unless there is a cutoff because of the performance
hit.

[1]
https://lore.kernel.org/git/efa3720fb40638e5d61c6130b55e3348d8e4339e.1535633886.git.gitgitgadget@gmail.com/

Thus, the need for generation number v2 was born. As Git used to die when
graph version understood by it and in the commit-graph file are different
[2], we needed a way to distinguish between the old and new generation
number without incrementing the graph version.

[2] https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/

The following candidates were proposed
(https://github.com/derrickstolee/gen-test,
https://github.com/abhishekkumar2718/git/pull/1):

 * (Epoch, Date) Pairs.
 * Maximum Generation Numbers.
 * Corrected Commit Date.
 * FELINE Index.
 * Corrected Commit Date with Monotonically Increasing Offsets.

Based on performance, local computability, and immutability (along with the
introduction of an additional commit-graph chunk which relieved the
requirement of backwards-compatibility) Corrected Commit Date was chosen as
generation number v2 and is defined as follows:

For a commit C, let its corrected commit date be the maximum of the commit
date of C and the corrected commit dates of its parents plus 1. Then
corrected commit date offset is the difference between corrected commit date
of C and commit date of C. As a special case, a root commit with the
timestamp zero has corrected commit date of 1 to distinguish it from
GENERATION_NUMBER_ZERO (that is, an uncomputed generation number).

While it was proposed initially to store corrected commit date offsets
within Commit Data Chunk, storing the offsets in a new chunk did not affect
the performance measurably. The new chunk is "Generation DATa (GDAT) chunk"
and it stores corrected commit date offsets while CDAT chunk stores
topological level. The old versions of Git would ignore GDAT chunk, using
topological levels from CDAT chunk. In contrast, new versions of Git would
use corrected commit dates, falling back to topological level if the
generation data chunk is absent in the commit-graph file.

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

Thanks to Dr. Stolee, Dr. Narębski, Taylor Blau and SZEDER Gábor for their
reviews.

I look forward to everyone's reviews!

Thanks

 * Abhishek

----------------------------------------------------------------------------

Improvements left for a future series:

 * Save commits with generation data overflow and extra edge commits instead
   of looping over all commits. cf. 858sbel67n.fsf@gmail.com
 * Verify both topological levels and corrected commit dates when present.
   cf. 85pn4tnk8u.fsf@gmail.com

Changes in version 7:

 * Moved the documentation patch ahead of "commit-graph: implement corrected
   commit date" and elaborated on the introduction of generation number v2.

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

 * Reordered patches to implement corrected commit date before generation
   data chunk [3].
 * Split "implement corrected commit date" into two patches - one
   introducing the topo level slab and other implementing corrected commit
   dates.
 * Extended split-commit-graph tests to verify at the end of test.
 * Use topological levels as generation number if any of split commit-graph
   files do not have generation data chunk.

[3]
https://lore.kernel.org/git/aee0ae56-3395-6848-d573-27a318d72755@gmail.com/

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
  commit-graph: document generation number v2
  commit-graph: implement corrected commit date
  commit-graph: implement generation data chunk
  commit-graph: use generation v2 only if entire chain does
  commit-reach: use corrected commit dates in paint_down_to_common()

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


base-commit: e6362826a0409539642a5738db61827e5978e2e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-676%2Fabhishekkumar2718%2Fcorrected_commit_date-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-676/abhishekkumar2718/corrected_commit_date-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/676

Range-diff vs v6:

  1:  4d8eb415578 =  1:  9ac331b63ee commit-graph: fix regression when computing Bloom filters
  2:  05dcb862818 =  2:  90ca0a1fd69 revision: parse parent in indegree_walk_step()
  3:  dcb9891d819 =  3:  b3040696d43 commit-graph: consolidate fill_commit_graph_info
  4:  4fbdee7ac90 =  4:  085085a4330 t6600-test-reach: generalize *_three_modes
  5:  fbd8feb5d8c =  5:  3b1aae4106a commit-graph: add a slab to store topological levels
  6:  855ff662a44 =  6:  ea32cba16ef commit-graph: return 64-bit generation number
 11:  e571f03d8bd !  7:  8647b5d2e38 doc: add corrected commit date info
     @@ Metadata
      Author: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
       ## Commit message ##
     -    doc: add corrected commit date info
     +    commit-graph: document generation number v2
      
     -    With generation data chunk and corrected commit dates implemented, let's
     -    update the technical documentation for commit-graph.
     +    Git uses topological levels in the commit-graph file for commit-graph
     +    traversal operations like 'git log --graph'. Unfortunately, topological
     +    levels can perform worse than committer date when parents of a commit
     +    differ greatly in generation numbers [1]. For example, 'git merge-base
     +    v4.8 v4.9' on the Linux repository walks 635,579 commits using
     +    topological levels and walks 167,468 using committer date. Since
     +    091f4cf3 (commit: don't use generation numbers if not needed,
     +    2018-08-30), 'git merge-base' uses committer date heuristic unless there
     +    is a cutoff because of the performance hit.
     +
     +    [1] https://lore.kernel.org/git/efa3720fb40638e5d61c6130b55e3348d8e4339e.1535633886.git.gitgitgadget@gmail.com/
     +
     +    Thus, the need for generation number v2 was born. As Git used to die
     +    when graph version understood by it and in the commit-graph file are
     +    different [2], we needed a way to distinguish between the old and new
     +    generation number without incrementing the graph version.
     +
     +    [2] https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/
     +
     +    The following candidates were proposed (https://github.com/derrickstolee/gen-test,
     +    https://github.com/abhishekkumar2718/git/pull/1):
     +    - (Epoch, Date) Pairs.
     +    - Maximum Generation Numbers.
     +    - Corrected Commit Date.
     +    - FELINE Index.
     +    - Corrected Commit Date with Monotonically Increasing Offsets.
     +
     +    Based on performance, local computability, and immutability (along with
     +    the introduction of an additional commit-graph chunk which relieved the
     +    requirement of backwards-compatibility) Corrected Commit Date was chosen
     +    as generation number v2 and is defined as follows:
     +
     +    For a commit C, let its corrected commit date  be the maximum of the
     +    commit date of C and the corrected commit dates of its parents plus 1.
     +    Then corrected commit date offset is the difference between corrected
     +    commit date of C and commit date of C. As a special case, a root commit
     +    with the timestamp zero has corrected commit date of 1 to distinguish it
     +    from GENERATION_NUMBER_ZERO (that is, an uncomputed generation number).
     +
     +    While it was proposed initially to store corrected commit date offsets
     +    within Commit Data Chunk, storing the offsets in a new chunk did not
     +    affect the performance measurably. The new chunk is "Generation DATa
     +    (GDAT) chunk" and it stores corrected commit date offsets while CDAT
     +    chunk stores topological level. The old versions of Git would ignore
     +    GDAT chunk, using topological levels from CDAT chunk. In contrast, new
     +    versions of Git would use corrected commit dates, falling back to
     +    topological level if the generation data chunk is absent in the
     +    commit-graph file.
     +
     +    While storing corrected commit date offsets saves us 4 bytes per commit
     +    (as compared with storing corrected commit dates directly), it's however
     +    possible for the offset to overflow the space allocated. To handle such
     +    cases, we introduce a new chunk, _Generation Data Overflow_ (GDOV) that
     +    stores the corrected commit date. For overflowing offsets, we set MSB
     +    and store the position into the GDOV chunk, in a mechanism similar to
     +    the Extra Edges list chunk.
     +
     +    For mixed generation number environment (for example new Git on the
     +    command line, old Git used by GUI client), we can encounter a
     +    mixed-chain commit-graph (a commit-graph chain where some of split
     +    commit-graph files have GDAT chunk and others do not). As backward
     +    compatibility is one of the goals, we can define the following behavior:
     +
     +    While reading a mixed-chain commit-graph version, we fall back on
     +    topological levels as corrected commit dates and topological levels
     +    cannot be compared directly.
     +
     +    When adding new layer to the split commit-graph file, and when merging
     +    some or all layers (replacing them in the latter case), the new layer
     +    will have GDAT chunk if and only if in the final result there would be
     +    no layer without GDAT chunk just below it.
      
          Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
      
  7:  8fbe7486405 =  8:  ec598f1d500 commit-graph: implement corrected commit date
  8:  6d0696ae216 =  9:  71d81518857 commit-graph: implement generation data chunk
  9:  fba0d7f3dfe = 10:  07a88f1aae6 commit-graph: use generation v2 only if entire chain does
 10:  ba1f2c5555f = 11:  523e2d4a902 commit-reach: use corrected commit dates in paint_down_to_common()

-- 
gitgitgadget
