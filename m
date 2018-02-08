Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F45E1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBHUic (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:32 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38252 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBHUhz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:37:55 -0500
Received: by mail-qk0-f196.google.com with SMTP id w128so7351698qkb.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X8eB6P0eGBCTHI3JMy+1MiOCVfS/GSCHtyNkpk7j3o4=;
        b=CpDKN6Ma+qwnPGy87H8YSlr2iUOSWLHbbm7cLtFedY2zliXxv+v0mg9mgRsuk9ViJ5
         6zZOQv5LLx8ot/pnDQBHHfQARQJzaaVvcuiaLK4HhjMIfNzbgpy0fTtYeHAMV6Pm5zbY
         6TCeCIr0FmkEiJ3wUuvNwlSiJMUK44Akp9SxqySskIqVJAOeKwNpepi8Ohmjt968iNu5
         VzuBkWnB5Apqv9my8jsi3TdvVgslA6oECqQm6ACfZFWoRwfLFcOF0bESqPNodNgF3Osd
         VJEJIboWFRJuqzIbk7G9G0uT31y6fjlbwCC7WVPpH43VffgwbwpHSSkZQv/Pp0nLkt+T
         d6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X8eB6P0eGBCTHI3JMy+1MiOCVfS/GSCHtyNkpk7j3o4=;
        b=TVcQAMZhP2ELTp97y8eT8bMNdesNL4KoWaXfE9GNc+YZRV+hkzwlKAKJ6zCayQCMUF
         nsga8MaXNXdwfHLrd4BLOo6ud66FuY4A5cdLb7b3mxfTPiGIxlaQ+scjf0DPnfVQCMAT
         aUX0wikk0tS4UINIM2hMmXlKokeY3O78xqCucE3pMlZ8aNz/5XE3yEHk7JYap7KKqplb
         as8nKE9+YsckuPCFJwdt5js6MMB9QbG9U5ipIGmDsJyVEek+dN9Mou1QuhdsWEYlQh7F
         l+41353p7mpwQvRgioXv1uz21Z0qISBgNjJ+SiwmpGxEtCKIfD+SjhmMBAB0U0mkD68a
         lu4w==
X-Gm-Message-State: APf1xPC63el7yNI8WRbjIr0eiJ6+zm4Vl5C9F/tG6Xk6KZxirC+oKMmm
        N5RL9nI068hHn6vrxF78aQr5c1D6Ofo=
X-Google-Smtp-Source: AH8x2262zaiAnEkZfYLzOyD2xKyhx5HiH5QJQGIdOgL4qGHkLf57uHYInQxwPuFzzPwW1IZiGeBITw==
X-Received: by 10.55.118.133 with SMTP id r127mr422345qkc.149.1518122273795;
        Thu, 08 Feb 2018 12:37:53 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:37:53 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 02/14] graph: add commit graph design document
Date:   Thu,  8 Feb 2018 15:37:26 -0500
Message-Id: <1518122258-157281-3-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add Documentation/technical/commit-graph.txt with details of the planned
commit graph feature, including future plans.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 189 +++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100644 Documentation/technical/commit-graph.txt

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
new file mode 100644
index 0000000000..fc86b06041
--- /dev/null
+++ b/Documentation/technical/commit-graph.txt
@@ -0,0 +1,189 @@
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
+2. Walking the entire graph to avoid topological order mistakes.
+
+The commit graph file is a supplemental data structure that accelerates
+commit graph walks. If a user downgrades or disables the 'core.commitGraph'
+config setting, then the existing ODB is sufficient. The file is stored
+next to packfiles either in the .git/objects/pack directory or in the pack
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
+This heuristic is currently used whenever the computation can make
+mistakes with topological orders (such as "git log" with default order),
+but is not used when the topological order is required (such as merge
+base calculations, "git log --graph").
+
+In practice, we expect some commits to be created recently and not stored
+in the commit graph. We can treat these commits as having "infinite"
+generation number and walk until reaching commits with known generation
+number.
+
+Design Details
+--------------
+
+- A graph file is stored in a file named 'graph-<hash>.graph' in the pack
+  directory. This could be stored in an alternate.
+
+- The most-recent graph file hash is stored in a 'graph-head' file for
+  immediate access and storing backup graphs. This could be stored in an
+  alternate, and refers to a 'graph-<hash>.graph' file in the same pack
+  directory.
+
+- The core.commitGraph config setting must be on to consume graph files.
+
+- The file format includes parameters for the object id length and hash
+  algorithm, so a future change of hash algorithm does not require a change
+  in format.
+
+Current Limitations
+-------------------
+
+- Only one graph file is used at one time. This allows the integer position
+  to seek into the single graph file. It is possible to extend the model
+  for multiple graph files, but that is currently not part of the design.
+
+- .graph files are managed only by the 'commit-graph' builtin. These are not
+  updated automatically during clone, fetch, repack, or creating new commits.
+
+- There is no '--verify' option for the 'commit-graph' builtin to verify the
+  contents of the graph file agree with the contents in the ODB.
+
+- When rewriting the graph, we do not check for a commit still existing
+  in the ODB, so garbage collection may remove commits.
+
+- Generation numbers are not computed in the current version. The file
+  format supports storing them, along with a mechanism to upgrade from
+  a file without generation numbers to one that uses them.
+
+Future Work
+-----------
+
+- The file format includes room for precomputed generation numbers. These
+  are not currently computed, so all generation numbers will be marked as
+  0 (or "uncomputed"). A later patch will include this calculation.
+
+- The commit graph is currently incompatible with commit grafts. This can be
+  remedied by duplicating or refactoring the current graft logic.
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
+- The graph currently only adds commits to a previously existing graph.
+  When writing a new graph, we could check that the ODB still contains
+  the commits and choose to remove the commits that are deleted from the
+  ODB. For performance reasons, this check should remain optional.
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
+- The current design uses the 'commit-graph' builtin to generate the graph.
+  When this feature stabilizes enough to recommend to most users, we should
+  add automatic graph writes to common operations that create many commits.
+  For example, one coulde compute a graph on 'clone', 'fetch', or 'repack'
+  commands.
+
+- A server could provide a commit graph file as part of the network protocol
+  to avoid extra calculations by clients.
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
+[3] https://public-inbox.org/git/20170907094718.b6kuzp2uhvkmwcso@sigill.intra.peff.net/t/#m7a2ea7b355aeda962e6b86404bcbadc648abfbba
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
2.15.1.45.g9b7079f

