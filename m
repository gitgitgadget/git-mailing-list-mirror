Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2713D1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDJM4W (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:56:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36450 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbeDJM4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:56:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id 91-v6so7472348pld.3
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uUxts309jnu4mXzDwtAzOutpmWXk//ksLwRpq+tjug0=;
        b=thtnyB3/9A/U3+R5jCyldGgy18KzLGEtAAUxK0aB/Yba0POHyzwX+Gdfzl8hDGiDHN
         tXxRw2U74+Ajq2ZjWcMbFEepBc/kJyP4S0YHv8W8JPvXpR8lWeNIFtdPLaIztdEvibKN
         gG70+tpoZzGfws44kwyRG4BaF2J/0EkFS3uD9I/hBLTc2OB2Eu9dCw0UzryTFyHyHcLE
         g//GZfJ1GvRweLx1+PM4ETA35ht7NXxmMwq6jWYi7Fv1+mgPuDtkdn9s2Td9Z/eW9+ks
         44hrb+NM1tUxVwFSyfk68uF/mLmh2POJpbWw+mOWrgx/l69Q36Ys23rlt+vDoLDIVtle
         DOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uUxts309jnu4mXzDwtAzOutpmWXk//ksLwRpq+tjug0=;
        b=N9aHq75R58wFSv/BzcedoVU9os7l12CdPwXR67OM2HfMrmhpxrwcYOobfdmrKzwW2S
         JH0saULrKBUkpyIKhnYvCblT3m64Vlly5JLIKvrWAu8u/BXbkGh3KSoOiOvNf74pT/j4
         4xp/1jeTSVjG3EyC0AfYjwT9sx+hk6phUhA9Rh6QNEu4f2iyBsxFoY57w1fNKgYu1vaW
         mhQtqsN1p4LR1g2V0EtLAZlneCwX28NyaH658jsBP+kLwqjZJR/7cH9KhxTAqVPMTi39
         6rTfiDiDX+LAWZGR033n9dVs1dsXiA5MyNbzZrcEddV2KyKirmAXgY4Ox38v1vXUT+Pk
         GbsA==
X-Gm-Message-State: ALQs6tD7wFTx3APFVYm7j1FDGXBSUp1fe7C/+n4Yc96VlmXTkL7IqDTs
        efXA6VYDtcrydTLyDRHc+lNYa/h4DA8=
X-Google-Smtp-Source: AIpwx48gb6QlVxPdLNpm7Srm2P1qCW6WPJt7kicPGn31kIFu3/wc7XOty9tC+0Weq6h+Qwcal6Cyiw==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3-v6mr280118plt.363.1523364980313;
        Tue, 10 Apr 2018 05:56:20 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:56:18 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 00/14] Serialized Git Commit Graph
Date:   Tue, 10 Apr 2018 08:55:54 -0400
Message-Id: <20180410125608.39443-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version covers the review that I missed when rerolling v7. The
file diff is below from previous version, and also PATCH 14/14 was
reworded to use "--append" properly.

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 41c4f76caf..37420ae0fd 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -31,7 +31,7 @@ static struct opts_commit_graph {

 static int graph_read(int argc, const char **argv)
 {
-       struct commit_graph *graph = 0;
+       struct commit_graph *graph = NULL;
        char *graph_name;

        static struct option builtin_commit_graph_read_options[] = {
diff --git a/commit-graph.c b/commit-graph.c
index 1fc63d541b..3ff8c84c0e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -179,7 +179,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 }

 /* global storage */
-struct commit_graph *commit_graph = NULL;
+static struct commit_graph *commit_graph = NULL;

 static void prepare_commit_graph_one(const char *obj_dir)
 {

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

By loading commits from the graph instead of parsing commit buffers, we
save a lot of time on long commit walks. Here are some performance
results for a copy of the Linux repository where 'master' has 678,653
reachable commits and is behind 'origin/master' by 59,929 commits.

| Command                          | Before | After  | Rel % |
|----------------------------------|--------|--------|-------|
| log --oneline --topo-order -1000 |  8.31s |  0.94s | -88%  |
| branch -vv                       |  1.02s |  0.14s | -86%  |
| rev-list --all                   |  5.89s |  1.07s | -81%  |
| rev-list --all --objects         | 66.15s | 58.45s | -11%  |

To test this yourself, run the following on your repo:

  git config core.commitGraph true
  git show-ref -s | git commit-graph write --stdin-commits

The second command writes a commit graph file containing every commit
reachable from your refs. Now, all git commands that walk commits will
check your graph first before consulting the ODB. You can run your own
performance comparisons by toggling the 'core.commitGraph' setting.

[1] https://github.com/derrickstolee/git/pull/2
    A GitHub pull request containing the latest version of this patch.

Derrick Stolee (14):
  csum-file: rename hashclose() to finalize_hashfile()
  csum-file: refactor finalize_hashfile() method
  commit-graph: add format document
  graph: add commit graph design document
  commit-graph: create git-commit-graph builtin
  commit-graph: implement write_commit_graph()
  commit-graph: implement git-commit-graph write
  commit-graph: implement git commit-graph read
  commit-graph: add core.commitGraph setting
  commit-graph: close under reachability
  commit: integrate commit graph with commit parsing
  commit-graph: read only from specific pack-indexes
  commit-graph: build graph from starting commits
  commit-graph: implement "--append" option

 .gitignore                                    |   1 +
 Documentation/config.txt                      |   4 +
 Documentation/git-commit-graph.txt            |  94 +++
 .../technical/commit-graph-format.txt         |  97 +++
 Documentation/technical/commit-graph.txt      | 163 ++++
 Makefile                                      |   2 +
 alloc.c                                       |   1 +
 builtin.h                                     |   1 +
 builtin/commit-graph.c                        | 171 ++++
 builtin/index-pack.c                          |   2 +-
 builtin/pack-objects.c                        |   6 +-
 bulk-checkin.c                                |   4 +-
 cache.h                                       |   1 +
 command-list.txt                              |   1 +
 commit-graph.c                                | 738 ++++++++++++++++++
 commit-graph.h                                |  46 ++
 commit.c                                      |   3 +
 commit.h                                      |   3 +
 config.c                                      |   5 +
 contrib/completion/git-completion.bash        |   2 +
 csum-file.c                                   |  10 +-
 csum-file.h                                   |   9 +-
 environment.c                                 |   1 +
 fast-import.c                                 |   2 +-
 git.c                                         |   1 +
 pack-bitmap-write.c                           |   2 +-
 pack-write.c                                  |   5 +-
 packfile.c                                    |   4 +-
 packfile.h                                    |   2 +
 t/t5318-commit-graph.sh                       | 224 ++++++
 30 files changed, 1584 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-commit-graph.txt
 create mode 100644 Documentation/technical/commit-graph-format.txt
 create mode 100644 Documentation/technical/commit-graph.txt
 create mode 100644 builtin/commit-graph.c
 create mode 100644 commit-graph.c
 create mode 100644 commit-graph.h
 create mode 100755 t/t5318-commit-graph.sh


base-commit: 468165c1d8a442994a825f3684528361727cd8c0
-- 
2.17.0

