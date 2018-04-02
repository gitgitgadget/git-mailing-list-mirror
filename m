Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7101F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932455AbeDBUfB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:35:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34774 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932424AbeDBUe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:34:57 -0400
Received: by mail-qt0-f193.google.com with SMTP id l18so16933169qtj.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pVUyCjmdfhPWPajtp1p3VnQvI/92kuHeYGfjKMJIQhA=;
        b=khW3A47W/UENojRmvIDAtINeWBkyTvtsMtcMi0GAkXzZL4NNTygmnnQQ2Vq6i/SAfY
         xqMYZ0w2vxpNHb3XS5VLUK6+wWQhsFV9ZgBtmhT6Fk97crReGp3sOzQ6N6h1rmLe9gDg
         xt8ZLhechwg2AUROGhAUDHRxrwUyOK0t0n1YOf20ajYYXzlnQR3DTKJ+WEeWe+wqJZNB
         PxfWWNnYiA25UWj+ace4bBvfdmu2R3+IlFKExMkdhbJ/PgW0flLC3VX5afxZCyQ42w61
         V3xV54rhw081Y1jf74tvE5oZgW2VFbm5EaSVgYREbQHZOYMiFdB++avpkjmAhui7y7Rr
         2R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pVUyCjmdfhPWPajtp1p3VnQvI/92kuHeYGfjKMJIQhA=;
        b=Zh4QV9Z9fu4/6WxmKTSefDoWOx/QEOzdpc9ZO6/NC9rR6tP1LAAjYmcvs0BPi7nEM8
         m2hvzg71mf/r274CFP2GJp0obt/k5v8iCGthUKifl0ZG+Xec3Qdre9a3vwo7/Heqvaw4
         vJcPvsumBHxL1ww4nHK66naQA9oDNzhmohCvLbkcJ05Vxg14tvPBv0YeZQ7iwNXebQiu
         A7GLg5U+rshfIiMCEakQLtu5jxLTgqhyusy42q2x6Ah5zkVAs+0T4LiAcp4Ulqo6aKdC
         Q8EAbFopmbZzbTrp7tkm5MD0SCgNX0L3q3vqEWsQyfZLqU+e6uNcuHZDxGo0pkJMkXY9
         hbMw==
X-Gm-Message-State: ALQs6tDf5O1P1BttFZ9R9ozwCO2OOxpfcDz/ZKbRL9rLjqwKQqlBQNeY
        /uOJWH7IPVJXmMlQgXoF9v+3HQ3rC3g=
X-Google-Smtp-Source: AIpwx4+xaOWpMY+abQ+HEiBENmS3b0om+05YbMkZ6/ghduj49G+7hIfQc2D3tNdXdZZvcyA2QapCqw==
X-Received: by 10.200.38.152 with SMTP id 24mr16232318qto.249.1522701296784;
        Mon, 02 Apr 2018 13:34:56 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:34:56 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 04/14] graph: add commit graph design document
Date:   Mon,  2 Apr 2018 16:34:17 -0400
Message-Id: <20180402203427.170177-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add Documentation/technical/commit-graph.txt with details of the planned
commit graph feature, including future plans.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 163 +++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/technical/commit-graph.txt

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
new file mode 100644
index 0000000000..0550c6d0dc
--- /dev/null
+++ b/Documentation/technical/commit-graph.txt
@@ -0,0 +1,163 @@
+Git Commit Graph Design Notes
+=============================
+
+Git walks the commit graph for many reasons, including:
+
+1. Listing and filtering commit history.
+2. Computing merge bases.
+
+These operations can become slow as the commit count grows. The merge
+base calculation shows up in many user-facing commands, such as 'merge-base'
+or 'status' and can take minutes to compute depending on history shape.
+
+There are two main costs here:
+
+1. Decompressing and parsing commits.
+2. Walking the entire graph to satisfy topological order constraints.
+
+The commit graph file is a supplemental data structure that accelerates
+commit graph walks. If a user downgrades or disables the 'core.commitGraph'
+config setting, then the existing ODB is sufficient. The file is stored
+as "commit-graph" either in the .git/objects/info directory or in the info
+directory of an alternate.
+
+The commit graph file stores the commit graph structure along with some
+extra metadata to speed up graph walks. By listing commit OIDs in lexi-
+cographic order, we can identify an integer position for each commit and
+refer to the parents of a commit using those integer positions. We use
+binary search to find initial commits and then use the integer positions
+for fast lookups during the walk.
+
+A consumer may load the following info for a commit from the graph:
+
+1. The commit OID.
+2. The list of parents, along with their integer position.
+3. The commit date.
+4. The root tree OID.
+5. The generation number (see definition below).
+
+Values 1-4 satisfy the requirements of parse_commit_gently().
+
+Define the "generation number" of a commit recursively as follows:
+
+ * A commit with no parents (a root commit) has generation number one.
+
+ * A commit with at least one parent has generation number one more than
+   the largest generation number among its parents.
+
+Equivalently, the generation number of a commit A is one more than the
+length of a longest path from A to a root commit. The recursive definition
+is easier to use for computation and observing the following property:
+
+    If A and B are commits with generation numbers N and M, respectively,
+    and N <= M, then A cannot reach B. That is, we know without searching
+    that B is not an ancestor of A because it is further from a root commit
+    than A.
+
+    Conversely, when checking if A is an ancestor of B, then we only need
+    to walk commits until all commits on the walk boundary have generation
+    number at most N. If we walk commits using a priority queue seeded by
+    generation numbers, then we always expand the boundary commit with highest
+    generation number and can easily detect the stopping condition.
+
+This property can be used to significantly reduce the time it takes to
+walk commits and determine topological relationships. Without generation
+numbers, the general heuristic is the following:
+
+    If A and B are commits with commit time X and Y, respectively, and
+    X < Y, then A _probably_ cannot reach B.
+
+This heuristic is currently used whenever the computation is allowed to
+violate topological relationships due to clock skew (such as "git log"
+with default order), but is not used when the topological order is
+required (such as merge base calculations, "git log --graph").
+
+In practice, we expect some commits to be created recently and not stored
+in the commit graph. We can treat these commits as having "infinite"
+generation number and walk until reaching commits with known generation
+number.
+
+Design Details
+--------------
+
+- The commit graph file is stored in a file named 'commit-graph' in the
+  .git/objects/info directory. This could be stored in the info directory
+  of an alternate.
+
+- The core.commitGraph config setting must be on to consume graph files.
+
+- The file format includes parameters for the object ID hash function,
+  so a future change of hash algorithm does not require a change in format.
+
+Future Work
+-----------
+
+- The commit graph feature currently does not honor commit grafts. This can
+  be remedied by duplicating or refactoring the current graft logic.
+
+- The 'commit-graph' subcommand does not have a "verify" mode that is
+  necessary for integration with fsck.
+
+- The file format includes room for precomputed generation numbers. These
+  are not currently computed, so all generation numbers will be marked as
+  0 (or "uncomputed"). A later patch will include this calculation.
+
+- After computing and storing generation numbers, we must make graph
+  walks aware of generation numbers to gain the performance benefits they
+  enable. This will mostly be accomplished by swapping a commit-date-ordered
+  priority queue with one ordered by generation number. The following
+  operations are important candidates:
+
+    - paint_down_to_common()
+    - 'log --topo-order'
+
+- Currently, parse_commit_gently() requires filling in the root tree
+  object for a commit. This passes through lookup_tree() and consequently
+  lookup_object(). Also, it calls lookup_commit() when loading the parents.
+  These method calls check the ODB for object existence, even if the
+  consumer does not need the content. For example, we do not need the
+  tree contents when computing merge bases. Now that commit parsing is
+  removed from the computation time, these lookup operations are the
+  slowest operations keeping graph walks from being fast. Consider
+  loading these objects without verifying their existence in the ODB and
+  only loading them fully when consumers need them. Consider a method
+  such as "ensure_tree_loaded(commit)" that fully loads a tree before
+  using commit->tree.
+
+- The current design uses the 'commit-graph' subcommand to generate the graph.
+  When this feature stabilizes enough to recommend to most users, we should
+  add automatic graph writes to common operations that create many commits.
+  For example, one could compute a graph on 'clone', 'fetch', or 'repack'
+  commands.
+
+- A server could provide a commit graph file as part of the network protocol
+  to avoid extra calculations by clients. This feature is only of benefit if
+  the user is willing to trust the file, because verifying the file is correct
+  is as hard as computing it from scratch.
+
+Related Links
+-------------
+[0] https://bugs.chromium.org/p/git/issues/detail?id=8
+    Chromium work item for: Serialized Commit Graph
+
+[1] https://public-inbox.org/git/20110713070517.GC18566@sigill.intra.peff.net/
+    An abandoned patch that introduced generation numbers.
+
+[2] https://public-inbox.org/git/20170908033403.q7e6dj7benasrjes@sigill.intra.peff.net/
+    Discussion about generation numbers on commits and how they interact
+    with fsck.
+
+[3] https://public-inbox.org/git/20170908034739.4op3w4f2ma5s65ku@sigill.intra.peff.net/
+    More discussion about generation numbers and not storing them inside
+    commit objects. A valuable quote:
+
+    "I think we should be moving more in the direction of keeping
+     repo-local caches for optimizations. Reachability bitmaps have been
+     a big performance win. I think we should be doing the same with our
+     properties of commits. Not just generation numbers, but making it
+     cheap to access the graph structure without zlib-inflating whole
+     commit objects (i.e., packv4 or something like the "metapacks" I
+     proposed a few years ago)."
+
+[4] https://public-inbox.org/git/20180108154822.54829-1-git@jeffhostetler.com/T/#u
+    A patch to remove the ahead-behind calculation from 'status'.
-- 
2.17.0.14.gba1221a8ce

