Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37B21F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCNT2E (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:28:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34241 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNT16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:27:58 -0400
Received: by mail-qt0-f193.google.com with SMTP id l25so4741028qtj.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+YAwUrtt7xu7uAU4CgIwx6Bs24GJKbSg9JinMHEl0NQ=;
        b=psduXH71aerLBZoJI+RAUBsj4CNDpn3k7zSU1TPYk5PKx1zhjU0uHUgW+mscDtzD+l
         MxXP1Q6m3k+qzrYN58whLpC+0NFsyQsxukg2E8RRCPh5dGiZb0rnf7XCQy84n4FfnhIM
         br8TVijVtwW7tSLI5m9pVfdVXnhxXDgerVexTDQfNeiTkLAZxIrXbb1FJRn0J9VOrfhe
         GgXiWJzUKt2q/VMSGRv6rtWtPtlKYFiXZq2TfLIM7kv35++yFmQxbnXGj4V2me4bLR+c
         WO9WHBxcGbhKZ6pYftADL8FkI8fl2sYeIJoXjmWsq1u6OXqbDS2UpR23PSbBo3edhFOa
         0hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+YAwUrtt7xu7uAU4CgIwx6Bs24GJKbSg9JinMHEl0NQ=;
        b=nikhDvQGOQcFNx3+hThSitCVXHhlvUW+9jWXCp8OrQTs4bKOkYmNCVKrFu+k9hvm2j
         260R7N5MowuBmP0F/Meb9TnK9w+IiMFw6U/+k3XaxDxRvO7GOUaETY6TjKjXXqnseMPA
         Y3mJwP0eZa7ut1kHXIdSapTNCfUJHB1SQBiwinz37Vs0nV9p0YT7Jt02KlA0baDMGL0s
         pAw3qyE2y6J2P6Qjy3oTUbo+bCX2Pkz9Wb+H1oV4Pkv23ktpIWowSt05HTdNgvpQykcX
         URILUZcRx+JBO6trk6qNmPkIFkaEnlxtgePFnm0F6kP411EBVRCjAelxCn+sK/Wn23PO
         EnYw==
X-Gm-Message-State: AElRT7FnvHks6xqxZvDLxSQV/NJi5xTqqjA6pDI3eM6v1QqBd0UXUHc/
        NSKQKD/Vn346U2vNY141fbAcUprWm6A=
X-Google-Smtp-Source: AG47ELtQx7pjDwstGEBggQmPWP5eHdbrzhRfTbirzioJtvLKaiEVHMi1keXbU0y/VtTVRg6+Zaws5g==
X-Received: by 10.200.70.9 with SMTP id p9mr8793970qtn.5.1521055677073;
        Wed, 14 Mar 2018 12:27:57 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:27:56 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 04/14] graph: add commit graph design document
Date:   Wed, 14 Mar 2018 15:27:26 -0400
Message-Id: <20180314192736.70602-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add Documentation/technical/commit-graph.txt with details of the planned
commit graph feature, including future plans.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 164 +++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/technical/commit-graph.txt

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
new file mode 100644
index 0000000000..d11753ac6f
--- /dev/null
+++ b/Documentation/technical/commit-graph.txt
@@ -0,0 +1,164 @@
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
+
-- 
2.14.1

