Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73163C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3987620723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2/pxh16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgE2Iu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2Iu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:50:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D66C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:50:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so2306141wmb.4
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WuAwNqI1eWrevATa0+rS79Mm+BMtAhzIXymTTOw7d6w=;
        b=d2/pxh168i8wPwv2SasE62JFag5cUxowiHxaO8tKgRQXD2FYXX+MbGvMrKS0+SU4fx
         BSKQylBouBDp0UnPDRut1sNbcyYn7Lz7BmxokxkNrtTAvutX1w2YO7sCnOIy6NTKTfPC
         TxhVrr1mrdou9l6znwBIVFB2DCC+yPsuJBN2lhBJj7kdiUcOgCzHevraTuc2Biwd6GjE
         79AP73Q2Yuce5A++jDSsv61m+UUoEMAcm6NUeaG9vsXLAPn6zloD3iy3ldYFIJBRmlhh
         0pfUN1OMbeneqDwhoJkwl46KHzpafZck2w/Rxv+1z4COp1qgY74VbqYCZf0XDIaQZwoB
         ja8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WuAwNqI1eWrevATa0+rS79Mm+BMtAhzIXymTTOw7d6w=;
        b=O4GFGULeRCmpefLLvay9MFdFiFJL444x/LoaQcl08lH9/entzFMgz0VD9VH3kMwQRv
         6Eizhu58eZ2vy9evkxLuzJoli/1orpprvVXDEup188O69S/53zzd/wklrgkMCflyMcO0
         u05axos9XNocgFfNNP5iBZA/QnN7jSINiZkUPha7+VhF1m6xC+CwTdzgeXQrINrwmE13
         AdnZuMVDIrtm4+aRbhqerI3xnKLZSBDTWN5b2kJFdk1Dgxwovhueouqk+R9RigWrd0k+
         7cLOANnH6HBDfRfxsS9u/xbsykeGsvJsqBNqr5atVA+zhJ1cc3pT5JYSPlk8lAh7byNA
         jO7g==
X-Gm-Message-State: AOAM531biwtuyay7216l9kAOX8xRt86AbQ+Fni/d1CY/Ds7Ns0SfaPHG
        dKopHM2Q4t5I68UhOg2bXhzZTl9k
X-Google-Smtp-Source: ABdhPJx1U2IhfU6uT2YhXD7bLaj9h5L0QT7gqxsE82mVTAR7nJYfYy2z4EGy7K5d6Zuw83DI2iJKxw==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr7756590wmb.85.1590742256011;
        Fri, 29 May 2020 01:50:56 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.50.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:50:54 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PoC PATCH 00/34] An alternative modified path Bloom filters implementation
Date:   Fri, 29 May 2020 10:50:04 +0200
Message-Id: <20200529085038.26008-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sigh...  but better late than never, right?

I experimented quite a bit with modified path Bloom filters a year and
more ago, and got quite far...  but my disappointment in the
inadequacy of all double hashing schemes, the arrival of split
commit-graphs, and, well, life in general has put the whole thing on
the back burner, and I haven't touched it for a couple of releases.

Now I finally managed to take a closer look at the current changed
paths Bloom filters implementation, and saw that it has some of the
same issues that I had stumbled upon and that it missed some
optimization opportunities.  Unfortunately, fixing those issues and
performing those optimizations do require a thorough format change.

So here is my proof of concept version, in all its incompleteness,
with the following benefits:

  - Better understanding of the problem it tries to optimize.
  - Better understanding of the issues with many small Bloom filters.
  - Better hashing scheme (though it should be better still).
  - Orders of magnitude lower average false positive rate.
  - Consequently, faster pathspec-limited revision walks.
  - Faster processing of the tree-diff output and lower memory usage
    while computing Bloom filters (from scratch...).
  - Optional support for storing Bloom filters for all parents of
    merge commits.
  - Deduplicates Bloom filters.
  - Supports multiple pathspecs right from the start.
  - Supports some wildcards in pathspecs.
  - Handles as many commits as the commit-graph format can.
  - It has the right name :)  The diff machinery and all its frontends
    report "modified" paths with the letter 'M', not "changed".
  - More cleanups, more bugfixes.
  - Consistent output with and without modified path Bloom filters for
    over 80k random paths in 16 repositories, even with submodules in
    them.  Well, at least on my machine, if nowhere else...

Alas, the drawbacks are significant:

  - No tests whatsoever.
  - Computes all modified path Bloom filters from scratch when
    writing, no matter what.
  - Doesn't work with split commit-graphs.
  - Basically if anything works besides 'git commit-graph write
    --reachable' it's a miracle.
  - Not a single test.
  - Many BUG()s, which should rather be graceful errors...  though I
    have to admit that at this point they are indeed bugs.
  - Many TODOs, both in commit messages and code, some incomplete
    commit messages, crappy subject lines, even missing signoffs.
  - Some ridiculously long variable, function, macro and config
    variable names.
  - It's based on v2.25.0 (no technical reason, but that's the version
    I used to run the baseline benchmarks the last time, which takes
    days...)
  - I'm pretty sure that there are more...
  - Oh, did I mention that there are no tests?


The first 14 patches are preparatory fixes and cleanups:

  01/34 tree-walk.c: don't match submodule entries for 'submod/anything'

This fix or something similar is necessary to have consistent output
with and without modified path Bloom filters for paths crossing
submodule boundary.

  02/34 commit-graph: fix parsing the Chunk Lookup table

The minimal (though not the best) fix for a bug which, I think, is as
old as the commit-graph.  I don't know how to test this.

  03/34 commit-graph-format.txt: all multi-byte numbers are in network byte order
  04/34 commit-slab: add a function to deep free entries on the slab
  05/34 diff.h: drop diff_tree_oid() & friends' return value
  06/34 commit-graph: clean up #includes

A couple of minor cleanups.

  07/34 commit-graph: simplify parse_commit_graph() #1
  08/34 commit-graph: simplify parse_commit_graph() #2

These two would be the right, though not minimal fix for the parsing
bug above.

  09/34 commit-graph: simplify write_commit_graph_file() #1
  10/34 commit-graph: simplify write_commit_graph_file() #2
  11/34 commit-graph: allocate the 'struct chunk_info' array dinamically

I think these three cleanup patches are a better alternative of
3be7efcafc (commit-graph: define and use MAX_NUM_CHUNKS, 2020-03-30),
because...

  12/34 commit-graph: unify the signatures of all write_graph_chunk_*() functions
  13/34 commit-graph: simplify write_commit_graph_file() #3
  14/34 commit-graph: check chunk sizes after writing

... they laid the ground work for this patch.

  15/34 commit-graph-format.txt: document the modified path Bloom filter chunks

This is the most important one, specifying and _justifying_ the new
chunk formats.

Do grab a cup or pint of your favourite beverage and get comfy before
reading this one.  You have been warned.

  16/34 Add a generic and minimal Bloom filter implementation
  17/34 Import a streaming-capable Murmur3 hash function implementation
  18/34 commit-graph: write "empty" Modified Path Bloom Filter Index chunk
  19/34 commit-graph: add commit slab for modified path Bloom filters
  20/34 commit-graph: fill the Modified Path Bloom Filter Index chunk

This shows a more efficient approach to process the tree-diff output
into Bloom filters.

  21/34 commit-graph: load and use the Modified Path Bloom Filter Index chunk
  22/34 commit-graph: write the Modified Path Bloom Filters chunk
  23/34 commit-graph: load and use the Modified Path Bloom Filters chunk
  24/34 commit-graph: check all leading directories in modified path Bloom filters

This was a good lightbulb moment.  It is essential to try to maintain
reasonable performance in repositories where the vast majority of
changes are concentrated to a single directory.

  25/34 commit-graph: check embedded modified path Bloom filters with a mask
  26/34 commit-graph: deduplicate modified path Bloom filters
  27/34 commit-graph: load modified path Bloom filters for merge commits
  28/34 commit-graph: write Modified Path Bloom Filter Merge Index chunk
  29/34 commit-graph: extract init and free write_commit_graph_context
  30/34 commit-graph: move write_commit_graph_reachable below write_commit_graph
  31/34 t7007-show: make the first test compatible with the next patch
  32/34 PoC commit-graph: use revision walk machinery for '--reachable'

Once upon a time I thought this was the greatest idea ever, but as
time goes by I get more and more concerned that this is a really dumb
idea, though don't yet know why.

  33/34 commit-graph: write modified path Bloom filters in "history order"
  34/34 commit-graph: use modified path Bloom filters with wildcards, if possible

Finally a cherry on top.



SZEDER Gábor (34):
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
  commit-graph: allocate the 'struct chunk_info' array dinamically
  commit-graph: unify the signatures of all write_graph_chunk_*()
    functions
  commit-graph: simplify write_commit_graph_file() #3
  commit-graph: check chunk sizes after writing
  commit-graph-format.txt: document the modified path Bloom filter
    chunks
  Add a generic and minimal Bloom filter implementation
  Import a streaming-capable Murmur3 hash function implementation
  commit-graph: write "empty" Modified Path Bloom Filter Index chunk
  commit-graph: add commit slab for modified path Bloom filters
  commit-graph: fill the Modified Path Bloom Filter Index chunk
  commit-graph: load and use the Modified Path Bloom Filter Index chunk
  commit-graph: write the Modified Path Bloom Filters chunk
  commit-graph: load and use the Modified Path Bloom Filters chunk
  commit-graph: check all leading directories in modified path Bloom
    filters
  commit-graph: check embedded modified path Bloom filters with a mask
  commit-graph: deduplicate modified path Bloom filters
  commit-graph: load modified path Bloom filters for merge commits
  commit-graph: write Modified Path Bloom Filter Merge Index chunk
  commit-graph: extract init and free write_commit_graph_context
  commit-graph: move write_commit_graph_reachable below
    write_commit_graph
  t7007-show: make the first test compatible with the next patch
  PoC commit-graph: use revision walk machinery for '--reachable'
  commit-graph: write modified path Bloom filters in "history order"
  commit-graph: use modified path Bloom filters with wildcards, if
    possible

 Documentation/config/core.txt                 |   19 +
 .../technical/commit-graph-format.txt         |  127 +-
 Makefile                                      |    2 +
 bloom-filter.c                                |   91 ++
 bloom-filter.h                                |   47 +
 commit-graph.c                                | 1239 +++++++++++++++--
 commit-graph.h                                |   24 +-
 commit-slab-decl.h                            |    1 +
 commit-slab-impl.h                            |   13 +
 commit-slab.h                                 |   10 +
 compat/PMurHash.c                             |  291 ++++
 compat/PMurHash.h                             |   62 +
 diff.h                                        |   10 +-
 pathspec.c                                    |   10 +
 pathspec.h                                    |   13 +
 revision.c                                    |   27 +-
 shallow.c                                     |   14 +-
 t/t4010-diff-pathspec.sh                      |    4 +-
 t/t5318-commit-graph.sh                       |    3 +-
 t/t7007-show.sh                               |    7 +-
 tree-diff.c                                   |   21 +-
 tree-walk.c                                   |    9 +-
 22 files changed, 1872 insertions(+), 172 deletions(-)
 create mode 100644 bloom-filter.c
 create mode 100644 bloom-filter.h
 create mode 100644 compat/PMurHash.c
 create mode 100644 compat/PMurHash.h

-- 
2.27.0.rc1.431.g5c813f95dc

