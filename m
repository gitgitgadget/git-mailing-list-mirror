Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEF0A1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeA3VkW (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:22 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43037 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbeA3VkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:20 -0500
Received: by mail-qk0-f196.google.com with SMTP id a5so12131405qkg.10
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EIofRJmENjmcg/RuO3UUFR9U0H1x4iErGOkhCzEXsfw=;
        b=nwVCP1c4Trk7A7jNwZag8bLfbwg5ifKRi6POoTKTj4PBFby5prsUMB03O+ysKiVp/C
         qjq/66/eBIrshrEQ3fEmE2h7LgjHX72Gzt31OeZfxplImf81FT8C1IJkP0WhoYeAaZn7
         WaYpjtYKQIT55z2pKsWxFz5oUtPtee/eyXhb2peT2bLa0MC7mxQuXD/1NbacXvTcTH7M
         x3lQ1ndIyyEjje+M018nTT2kAmYLpm6MqCT9Ex8FOP1WbnL61cW263sIb4CpLQwkjTj5
         AkzQGa0FpLzx2szHdDky2owbEIv32TYQlCIXFLD9y3S5UlWmtsedexphJd7JH2Qh1zcQ
         Ez5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EIofRJmENjmcg/RuO3UUFR9U0H1x4iErGOkhCzEXsfw=;
        b=c2/q2Lffj4qvb1xG0TkJMmftODoSWE1S2qlQTUGH7RE8sqNft4uXdrMbYMsWszx7ZX
         VRN8sxych8/VXIWAH6n+8KqDmXYlJ1oWFOl+kPWl5RYVFGjygPILpEIq6Rw82P/2VEW9
         BX/AQV/OWlQT3mJ7xy6msYPV7l7io3kDVRlBr1SlYHZupWH+NEWqnNQemt9GfFNaDODx
         3nZCP94frNC/argfzSLDChoJtjKfbtUEWacE7wMqYkZ7dOa1fB0bIwK7FiYgIfQbaeX4
         GQ/pu4CjXYpvoYfI0lB+QPD9rf0vCrO5B2Ae/kE9dnHQQkCLgl2qMv0gvA4TwJhq6uR8
         o5eg==
X-Gm-Message-State: AKwxytccLNaZRmAsaJX+F37e4/9pf7Z0ukWBjA6l3HNna4QnW8Vd5VOU
        NYDV/dMXYHFyFxq4Gxb2H0p6mKWd
X-Google-Smtp-Source: AH8x226kIN31RR0A4fSF2sYXxf2qb6XC1ATWBs7oe65QMCHn+/07uLE4MtkzrBR4mdNYHn64qFfEjQ==
X-Received: by 10.55.72.17 with SMTP id v17mr44079958qka.235.1517348419940;
        Tue, 30 Jan 2018 13:40:19 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:19 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 09/14] commit-graph: teach git-commit-graph --delete-expired
Date:   Tue, 30 Jan 2018 16:39:38 -0500
Message-Id: <1517348383-112294-10-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to delete the graph previously referenced by 'graph_head'
when writing a new graph file and updating 'graph_head'. This prevents
data creep by storing a list of useless graphs. Be careful to not delete
the graph if the file did not change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  8 +++--
 builtin/commit-graph.c             | 16 ++++++++-
 t/t5318-commit-graph.sh            | 66 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 33d6567f11..7b376e9212 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -39,6 +39,10 @@ OPTIONS
 	When used with --write, update the graph-head file to point to
 	the written graph file.
 
+--delete-expired::
+	When used with --write and --update-head, delete the graph file
+	previously referenced by graph-head.
+
 EXAMPLES
 --------
 
@@ -55,10 +59,10 @@ $ git commit-graph --write
 ------------------------------------------------
 
 * Write a graph file for the packed commits in your local .git folder,
-* and update graph-head.
+* update graph-head, and delete the old graph-<oid>.graph file.
 +
 ------------------------------------------------
-$ git commit-graph --write --update-head
+$ git commit-graph --write --update-head --delete-expired
 ------------------------------------------------
 
 * Read basic information from a graph file.
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 4970dec133..766f09e6fc 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -12,7 +12,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
 	N_("git commit-graph --clear [--pack-dir <packdir>]"),
 	N_("git commit-graph --read [--graph-hash=<hash>]"),
-	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head]"),
+	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head] [--delete-expired]"),
 	NULL
 };
 
@@ -23,6 +23,7 @@ static struct opts_commit_graph {
 	const char *graph_hash;
 	int write;
 	int update_head;
+	int delete_expired;
 	int has_existing;
 	struct object_id old_graph_hash;
 } opts;
@@ -121,6 +122,17 @@ static int graph_write(void)
 	if (graph_hash)
 		printf("%s\n", oid_to_hex(graph_hash));
 
+
+	if (opts.delete_expired && opts.update_head && opts.has_existing &&
+	    oidcmp(graph_hash, &opts.old_graph_hash)) {
+		char *old_path = get_commit_graph_filename_hash(opts.pack_dir,
+								&opts.old_graph_hash);
+		if (remove_path(old_path))
+			die("failed to remove path %s", old_path);
+
+		free(old_path);
+	}
+
 	free(graph_hash);
 	return 0;
 }
@@ -139,6 +151,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			N_("write commit graph file")),
 		OPT_BOOL('u', "update-head", &opts.update_head,
 			N_("update graph-head to written graph file")),
+		OPT_BOOL('d', "delete-expired", &opts.delete_expired,
+			N_("delete expired head graph file")),
 		{ OPTION_STRING, 'H', "graph-hash", &opts.graph_hash,
 			N_("hash"),
 			N_("A hash for a specific graph file in the pack-dir."),
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6e3b62b754..b56a6d4217 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -101,9 +101,73 @@ test_expect_success 'write graph with merges' \
      _graph_read_expect "18" "${packdir}" &&
      cmp expect output'
 
+test_expect_success 'Add more commits' \
+    'for i in $(test_seq 16 20)
+     do
+        echo $i >$i.txt &&
+        git add $i.txt &&
+        git commit -m "commit $i" &&
+        git branch commits/$i
+     done &&
+     git repack'
+
+# Current graph structure:
+#
+#      20
+#       |
+#      19
+#       |
+#      18
+#       |
+#      17
+#       |
+#      16
+#       |
+#      M3
+#     / |\_____
+#    / 10      15
+#   /   |      |
+#  /    9 M2   14
+# |     |/  \  |
+# |     8 M1 | 13
+# |     |/ | \_|
+# 5     7  |   12
+# |     |   \__|
+# 4     6      11
+# |____/______/
+# 3
+# |
+# 2
+# |
+# 1
+
+test_expect_success 'write graph with merges' \
+    'graph3=$(git commit-graph --write --update-head --delete-expired) &&
+     test_path_is_file ${packdir}/graph-${graph3}.graph &&
+     test_path_is_missing ${packdir}/graph-${graph2}.graph &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     test_path_is_file ${packdir}/graph-head &&
+     echo ${graph3} >expect &&
+     cmp -n 40 expect ${packdir}/graph-head &&
+     git commit-graph --read --graph-hash=${graph3} >output &&
+     _graph_read_expect "23" "${packdir}" &&
+     cmp expect output'
+
+test_expect_success 'write graph with nothing new' \
+    'graph4=$(git commit-graph --write --update-head --delete-expired) &&
+     test_path_is_file ${packdir}/graph-${graph4}.graph &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     test_path_is_file ${packdir}/graph-head &&
+     echo ${graph4} >expect &&
+     cmp -n 40 expect ${packdir}/graph-head &&
+     git commit-graph --read --graph-hash=${graph4} >output &&
+     _graph_read_expect "23" "${packdir}" &&
+     cmp expect output'
+
 test_expect_success 'clear graph' \
     'git commit-graph --clear &&
      test_path_is_missing ${packdir}/graph-${graph2}.graph &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
      test_path_is_missing ${packdir}/graph-head'
 
 test_expect_success 'setup bare repo' \
@@ -121,7 +185,7 @@ test_expect_success 'write graph in bare repo' \
      echo ${graphbare} >expect &&
      cmp -n 40 expect ${baredir}/graph-head &&
      git commit-graph --read --graph-hash=${graphbare} >output &&
-     _graph_read_expect "18" "${baredir}" &&
+     _graph_read_expect "23" "${baredir}" &&
      cmp expect output'
 
 test_done
-- 
2.16.0.15.g9c3cf44.dirty

