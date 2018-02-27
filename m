Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041CB1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeB0CdO (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:14 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:41275 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbeB0CdN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:13 -0500
Received: by mail-qt0-f176.google.com with SMTP id j4so6425264qth.8
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5Nc+S7qKW3twlSWzeAca/LcuLNejqQ4nPr2iSvFFOMw=;
        b=gn4LiqvQrlN+zHmaIYkozZRlgapet5N1T0tfUZW2gKuOG3Zmij9PFfX/1b92OGiYJf
         3d3ImAarIhWYeUTZCkYOHTshmeQQ6VExQdRXIm/CzefW2xZuS85PRyItzbLPmBT4mWEm
         ZIBLe4PpyXIlZMtzMcn/7h9lHrhVwoOwy6yEGIKTf1hfez2j0maRfntNk4ifVCNr8JU3
         F3qg+luiOI1J05GrpBaLoJ1K5GTgvF//PILiNUtf/7122icuYoR+XbiZNp1M47UwO5aG
         5su6uNe/Tb9KoxpW/UjyQEcJ4t+3R7J4/4chD0CiYMSPLb9RtrOminuKAlyjxrE5YQjK
         UaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Nc+S7qKW3twlSWzeAca/LcuLNejqQ4nPr2iSvFFOMw=;
        b=fkEvlP4o1bxGtCQ1jWV5Wp3A+PZgQiA2wX7jeQIfLfC/qt9cy+ds9w8/trmgSIIAxi
         Vpfi4n2ZPvrbhcWknrs4QpPmB81vXvkMuMq9DTyfkzFV5LR+DCrSFzZSBIP1zRGJnwaC
         0SgAxx21ZSAxIiVdC7b1FQQyQ9X7L6RTve7nSuuRsec3NkbQ7r131Ps7WeICSzD44csL
         LlVAN945UepJ8HYjd2EkquVCziRZHo5sFnYBDC5Kbfl1+tCV/Xt7J6EzCE51Dy2kUn0F
         vGtBeH2uLwUxBht2f8quNCnyVDDUEh4QXiMdkD8n2Ob9K+KUZnlFb8uj24c7EdqZZCab
         79sg==
X-Gm-Message-State: APf1xPDUYIWJmSdxL5H9NZBmVbGuBYe6C2vXdZeD+NkkbiKCswUo+fpb
        VKtbsVntoZ6dfS3H8KlLMAlCncqmDXg=
X-Google-Smtp-Source: AG47ELsjsfq1LPAT4eFXNuTVIn0gUzhQZ5ZJZ5G7QBCdwi4ya45CDfGweicWyeyLyrr/rlRAYh4Q/w==
X-Received: by 10.237.61.45 with SMTP id g42mr21177975qtf.88.1519698792630;
        Mon, 26 Feb 2018 18:33:12 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:10 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 00/13] Serialized Git Commit Graph
Date:   Mon, 26 Feb 2018 21:32:54 -0500
Message-Id: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is another big difference from version 4, but I do 
think we are converging on a stable design.

This series depends on a few things in flight:

* jt/binsearch-with-fanout for bsearch_graph()

* 'master' includes the sha1file -> hashfile rename in (98a3beab).

* [PATCH] commit: drop uses of get_cached_commit_buffer(). [1] I
  couldn't find a ds/* branch for this one, but it is necessary or
  else the commit graph test script should fail.

Here are some of the inter-patch changes:

* The single commit graph file is stored in the fixed filename
  .git/objects/info/commit-graph

* Because of this change, I struggled with the right way to pair the
  lockfile API with the hashfile API. Perhaps they were not meant to
  interact like this. I include a new patch step that adds a flag for
  hashclose() to keep the file descriptor open so commit_lock_file()
  can succeed. Please let me know if this is the wrong approach.

* A side-benefit of this change is that the "--set-latest" and
  "--delete-expired" arguments are no longer useful.

* I re-ran the performance tests since I rebased onto master. I had
  moved my "master" branch on my copy of Linux from another perf test,
  which changed the data shape a bit.

* There was some confusion between v3 and v4 about whether commits in
  an existing commit-graph file are automatically added to the new
  file during a write. I think I cleared up all of the documentation
  that referenced this to the new behavior: we only include commits
  reachable from the starting commits (depending on --stdin-commits,
  --stdin-packs, or neither) unless the new "--additive" argument
  is specified.

Thanks,
-Stolee

[1] https://public-inbox.org/git/1519240631-221761-1-git-send-email-dstolee@microsoft.com/

-- >8 --

This patch contains a way to serialize the commit graph.

The current implementation defines a new file format to store the graph
structure (parent relationships) and basic commit metadata (commit date,
root tree OID) in order to prevent parsing raw commits while performing
basic graph walks. For example, we do not need to parse the full commit
when performing these walks:

* 'git log --topo-order -1000' walks all reachable commits to avoid
  incorrect topological orders, but only needs the commit message for
  the top 1000 commits.

* 'git merge-base <A> <B>' may walk many commits to find the correct
  boundary between the commits reachable from A and those reachable
  from B. No commit messages are needed.

* 'git branch -vv' checks ahead/behind status for all local branches
  compared to their upstream remote branches. This is essentially as
  hard as computing merge bases for each.

The current patch speeds up these calculations by injecting a check in
parse_commit_gently() to check if there is a graph file and using that
to provide the required metadata to the struct commit.

The file format has room to store generation numbers, which will be
provided as a patch after this framework is merged. Generation numbers
are referenced by the design document but not implemented in order to
make the current patch focus on the graph construction process. Once
that is stable, it will be easier to add generation numbers and make
graph walks aware of generation numbers one-by-one.

Here are some performance results for a copy of the Linux repository
where 'master' has 664,185 reachable commits and is behind 'origin/master'
by 60,191 commits.

| Command                          | Before | After  | Rel % |
|----------------------------------|--------|--------|-------|
| log --oneline --topo-order -1000 |  6.56s |  0.66s | -89%  |
| branch -vv                       |  1.35s |  0.32s | -76%  |
| rev-list --all                   |  6.7s  |  0.83s | -87%  |
| rev-list --all --objects         | 33.0s  | 27.5s  | -16%  |

To test this yourself, run the following on your repo:

  git config core.commitGraph true
  git show-ref -s | git commit-graph write --stdin-commits

The second command writes a commit graph file containing every commit
reachable from your refs. Now, all git commands that walk commits will
check your graph first before consulting the ODB. You can run your own
performance comparisons by toggling the 'core.commitGraph' setting.

[1] https://github.com/derrickstolee/git/pull/2
    A GitHub pull request containing the latest version of this patch.

Derrick Stolee (13):
  commit-graph: add format document
  graph: add commit graph design document
  commit-graph: create git-commit-graph builtin
  csum-file: add CSUM_KEEP_OPEN flag
  commit-graph: implement write_commit_graph()
  commit-graph: implement 'git-commit-graph write'
  commit-graph: implement git commit-graph read
  commit-graph: add core.commitGraph setting
  commit-graph: close under reachability
  commit: integrate commit graph with commit parsing
  commit-graph: read only from specific pack-indexes
  commit-graph: build graph from starting commits
  commit-graph: implement "--additive" option

 .gitignore                                    |   1 +
 Documentation/config.txt                      |   3 +
 Documentation/git-commit-graph.txt            |  93 +++
 .../technical/commit-graph-format.txt         |  98 +++
 Documentation/technical/commit-graph.txt      | 164 ++++
 Makefile                                      |   2 +
 alloc.c                                       |   1 +
 builtin.h                                     |   1 +
 builtin/commit-graph.c                        | 172 +++++
 cache.h                                       |   1 +
 command-list.txt                              |   1 +
 commit-graph.c                                | 720 ++++++++++++++++++
 commit-graph.h                                |  47 ++
 commit.c                                      |   3 +
 commit.h                                      |   3 +
 config.c                                      |   5 +
 contrib/completion/git-completion.bash        |   2 +
 csum-file.c                                   |  10 +-
 csum-file.h                                   |   1 +
 environment.c                                 |   1 +
 git.c                                         |   1 +
 packfile.c                                    |   4 +-
 packfile.h                                    |   2 +
 t/t5318-commit-graph.sh                       | 225 ++++++
 24 files changed, 1556 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/git-commit-graph.txt
 create mode 100644 Documentation/technical/commit-graph-format.txt
 create mode 100644 Documentation/technical/commit-graph.txt
 create mode 100644 builtin/commit-graph.c
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h
 create mode 100755 t/t5318-commit-graph.sh

-- 
2.16.2.282.g5029fe8.dirty

