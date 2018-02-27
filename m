Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FCC41F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeB0CdT (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:19 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42138 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeB0CdR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:17 -0500
Received: by mail-qt0-f195.google.com with SMTP id t6so11926063qtn.9
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gnn3Kurmshb9jz1GwzBRQy49/ZSvbRObJfz1lYO3RTk=;
        b=chi97lMgYYA0neDfnVWfj4Qn8fPfWrg0vckXyd0tdyrTTxlZFH7dzsGgaGcmaq9gNE
         ECg+lZzT86bLpWS69r3avFZlQE/MLTYXnl214Bfyf1H16O11VjJRFsQmqr240M53LGsm
         Qs27W2LrKSuawgQkpi7VzBcO2LdR8TGyRxqOMq6iKnDzAVWkHqzjyVvI4eYVfoQzHIsk
         A658aXquBROzrurCNeXhGA/I8sqND8/kjyBX3FiN3JQKO7KNEpLU2KRcQTrN4MkjY0Ss
         hHfMWVArUH7eYiJuPQOdvfjKFzfedwoFzhj/BUwvFGmXpj5uMz6hPEG32TMS4Hxn/FNM
         hpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gnn3Kurmshb9jz1GwzBRQy49/ZSvbRObJfz1lYO3RTk=;
        b=HG3UbkTwj2NlgENH+qJNFpzHxskBlge1pc1WfGBE47FgQ7rgX4F5HUbNMweWUZY6mo
         dXKTUxBOhGbauwM6gKHNyRBgm4QFROzPhkPvE+2cgc7GDJ+oUFSbaQnso0QvlyIdCtA5
         dh12ZEMo9eUtFYLL93p1J6NSsrH1oj0tMz8PM3QK9cHFiG2xy8wH+liQhGqiFHs7T0cg
         BApibdiWVZYgM5I6RL4SArrdlDF/IMuweiVqy8d3PGNkRQ3PWsrukxGlD0sJGgVsYPFV
         mqkiA7u8+1fb/h9vJuh8XOcM21U3CSpUN5EX6W8S172KBvcqNVHKGK4Otxi0h1xaixR6
         1HDA==
X-Gm-Message-State: APf1xPACe0Ngh61RpLpv9y9cup8Td8acHVBO9E3xoMDPWNOLhsbkJmHS
        5PdRFi9ezqUdBO1JTICTs02TP/Xq0PQ=
X-Google-Smtp-Source: AG47ELvbaczQR7qoCLwCsxEUuvw0s53Z644Eo4fTpf+IK7ZrTU+lC8MsBZF43rcvA2mpIeA8ewA+EQ==
X-Received: by 10.237.34.46 with SMTP id n43mr17118575qtc.105.1519698795784;
        Mon, 26 Feb 2018 18:33:15 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:15 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 02/13] graph: add commit graph design document
Date:   Mon, 26 Feb 2018 21:32:56 -0500
Message-Id: <1519698787-190494-3-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add Documentation/technical/commit-graph.txt with details of the planned
commit graph feature, including future plans.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 164 +++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/technical/commit-graph.txt

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
new file mode 100644
index 0000000..d11753a
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
2.7.4

