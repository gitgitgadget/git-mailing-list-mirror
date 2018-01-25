Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD7AF1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeAYODM (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:03:12 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42421 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeAYOC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:58 -0500
Received: by mail-qt0-f194.google.com with SMTP id c2so19341547qtn.9
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jwYEpIzz1mbWWBgL2IdtdgSTZN64LqZY7FPdZH4w8gA=;
        b=uikEaZywlSdhgN7X73NlEtYhXC4rBdAxqGr40EiOwzrUb56hhV7PzIYTi/mcW5hN3i
         Fk7o0LRbNj+2LP0jTI+4xGdlQgG6AzGVIrFhUX06w/uaPsU3RTEd9wZIzuXatnDa9KfD
         hYeXyFHaiPwoyenYvHQOQyUI+H4HEj7FZMQvMD3F79cLQxjP6I5lbNvNFOZJyym7hSRI
         yGRHVhR0b8Zlf8xTchgr8T97UCvKZ0teb/vSFuDZ+hnkvb/9XIfN8IpodepQSTJLXWxI
         bmL1p/W8bh9LOwxFlTb45unIWghSejuLGJWxjJsPLKilEzKfEmYrJEAzvW770hVdxnX6
         h/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jwYEpIzz1mbWWBgL2IdtdgSTZN64LqZY7FPdZH4w8gA=;
        b=KzN0bZugpZ2mTwbP5845oAw8ymAHeTof2XDKrehzdzpiZHnm1e5UqMvr+SkkYxFcTc
         TBknJf1JekQonarzrYWuzGkN3+TURSvHOOWGKEsnVzmeXCadTxrTBMBxqDl0+nk+krGM
         LBnir5pmvFiVBPmqbJ9yHrwOMP/xYXlN+K35lk4OFrgGSJn+yx/C26rEt21+Ix+q99mQ
         IrF/4cKyI/WNQ4eBF+C3j08OheMz7r1tSUnbbi0bc8u+20FGPnMq/zgNtlP+PcAYupmz
         iJrYYj8BTbITMWfbSuoHaplJ0FjSAxQxaWbwfzSwed0A2uur2Gqes4Q83LZtP0ypB28K
         ZW7w==
X-Gm-Message-State: AKwxyte8AQRqagluzGsVK+PCe5aa9Z5c3iPKssIErenOaZZCGlUnjo/c
        FP7JzeukHOwqvG7RufUgI8VuduYz
X-Google-Smtp-Source: AH8x2269a4tU+rMvsZG+h44WZlda+C6YfzAd4gmk8+XUOmHzF+BxpisuSQNHri1cMRdbMKwtBXZB0w==
X-Received: by 10.55.77.142 with SMTP id a136mr14386403qkb.249.1516888977851;
        Thu, 25 Jan 2018 06:02:57 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:57 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 14/14] packed-graph: teach git-graph to read commits
Date:   Thu, 25 Jan 2018 09:02:31 -0500
Message-Id: <20180125140231.65604-15-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-graph to read commits from stdin when the --stdin-commits
flag is specified. Commits reachable from these commits are added to
the graph. This is a much faster way to construct the graph than
inspecting all packed objects, but is restricted to known tips.

For the Linux repository, 700,000+ commits were added to the graph
file starting from 'master' in 7-9 seconds, depending on the number
of packfiles in the repo (1, 24, or 120).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/graph.c  | 33 +++++++++++++++++++++++++--------
 packed-graph.c   | 18 +++++++++++++++---
 packed-graph.h   |  3 ++-
 t/t5319-graph.sh | 18 ++++++++++++++++++
 4 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/builtin/graph.c b/builtin/graph.c
index 3cace3a18c..708889677b 100644
--- a/builtin/graph.c
+++ b/builtin/graph.c
@@ -12,7 +12,7 @@ static char const * const builtin_graph_usage[] ={
 	N_("git graph [--pack-dir <packdir>]"),
 	N_("git graph --clear [--pack-dir <packdir>]"),
 	N_("git graph --read [--graph-id=<oid>]"),
-	N_("git graph --write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs]"),
+	N_("git graph --write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -25,6 +25,7 @@ static struct opts_graph {
 	int update_head;
 	int delete_expired;
 	int stdin_packs;
+	int stdin_commits;
 	int has_existing;
 	struct object_id old_graph_oid;
 } opts;
@@ -116,22 +117,36 @@ static int graph_write(void)
 {
 	struct object_id *graph_id;
 	char **pack_indexes = NULL;
+	char **commits = NULL;
 	int num_packs = 0;
-	int size_packs = 0;
+	int num_commits = 0;
+	char **lines = NULL;
+	int num_lines = 0;
+	int size_lines = 0;
 
-	if (opts.stdin_packs) {
+	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf = STRBUF_INIT;
-		size_packs = 128;
-		ALLOC_ARRAY(pack_indexes, size_packs);
+		size_lines = 128;
+		ALLOC_ARRAY(lines, size_lines);
 
 		while (strbuf_getline(&buf, stdin) != EOF) {
-			ALLOC_GROW(pack_indexes, num_packs + 1, size_packs);
-			pack_indexes[num_packs++] = buf.buf;
+			ALLOC_GROW(lines, num_lines + 1, size_lines);
+			lines[num_lines++] = buf.buf;
 			strbuf_detach(&buf, NULL);
 		}
+
+		if (opts.stdin_packs) {
+			pack_indexes = lines;
+			num_packs = num_lines;
+		}
+		if (opts.stdin_commits) {
+			commits = lines;
+			num_commits = num_lines;
+		}
 	}
 
-	graph_id = construct_graph(opts.pack_dir, pack_indexes, num_packs);
+	graph_id = construct_graph(opts.pack_dir, pack_indexes, num_packs,
+				   commits, num_commits);
 
 	if (opts.update_head)
 		update_head_file(opts.pack_dir, graph_id);
@@ -170,6 +185,8 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 			N_("delete expired head graph file")),
 		OPT_BOOL('s', "stdin-packs", &opts.stdin_packs,
 			N_("only scan packfiles listed by stdin")),
+		OPT_BOOL('C', "stdin-commits", &opts.stdin_commits,
+			N_("start walk at commits listed by stdin")),
 		{ OPTION_STRING, 'G', "graph-id", &opts.graph_id,
 			N_("oid"),
 			N_("An OID for a specific graph file in the pack-dir."),
diff --git a/packed-graph.c b/packed-graph.c
index c93515f18e..94e1a97000 100644
--- a/packed-graph.c
+++ b/packed-graph.c
@@ -662,7 +662,8 @@ static void close_reachable(struct packed_oid_list *oids)
 	}
 }
 
-struct object_id *construct_graph(const char *pack_dir, char **pack_indexes, int nr_packs)
+struct object_id *construct_graph(const char *pack_dir, char **pack_indexes, int nr_packs,
+				  char **commit_hex, int nr_commits)
 {
 	// Find a list of oids, adding the pointer to a list.
 	struct packed_oid_list oids;
@@ -719,10 +720,21 @@ struct object_id *construct_graph(const char *pack_dir, char **pack_indexes, int
 			for_each_object_in_pack(p, if_packed_commit_add_to_list, &oids);
 			close_pack(p);
 		}
-	} else {
-		for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
 	}
 
+	if (commit_hex) {
+		for (i = 0; i < nr_commits; i++) {
+			const char *end;
+			ALLOC_GROW(oids.list, oids.num + 1, oids.size);
+			oids.list[oids.num] = malloc(sizeof(struct object_id));
+			parse_oid_hex(commit_hex[i], oids.list[oids.num], &end);
+			oids.num++;
+		}
+	}
+
+	if (!pack_indexes && !commit_hex)
+		for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+
 	close_reachable(&oids);
 	QSORT(oids.list, oids.num, commit_compare);
 
diff --git a/packed-graph.h b/packed-graph.h
index 97ce1e2652..9c766411be 100644
--- a/packed-graph.h
+++ b/packed-graph.h
@@ -58,7 +58,8 @@ extern struct object_id *get_nth_commit_oid(struct packed_graph *g,
 					    uint32_t n,
 					    struct object_id *oid);
 
-extern struct object_id *construct_graph(const char *pack_dir, char **pack_indexes, int nr_packs);
+extern struct object_id *construct_graph(const char *pack_dir, char **pack_indexes, int nr_packs,
+					 char **commits, int nr_commits);
 extern int close_graph(struct packed_graph *g);
 
 #endif
diff --git a/t/t5319-graph.sh b/t/t5319-graph.sh
index 8bf5a0c993..b12d2477ba 100755
--- a/t/t5319-graph.sh
+++ b/t/t5319-graph.sh
@@ -226,6 +226,24 @@ test_expect_success 'build graph from latest pack with closure' \
 _graph_git_behavior commits/20 merge/1
 _graph_git_behavior commits/20 merge/2
 
+test_expect_success 'build graph from commits with closure' \
+    'git rev-parse commits/20 >commits-in &&
+     git rev-parse merge/1 >>commits-in &&
+     git rev-parse merge/2 >>commits-in &&
+     graph6=$(cat commits-in | git graph --write --update-head --delete-expired --stdin-commits) &&
+     test_path_is_file ${packdir}/graph-${graph6}.graph &&
+     test_path_is_missing ${packdir}/graph-${graph5}.graph &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     test_path_is_file ${packdir}/graph-head &&
+     echo ${graph6} >expect &&
+     cmp -n 40 expect ${packdir}/graph-head &&
+     git graph --read --graph-id=${graph6} >output &&
+     _graph_read_expect "23" "${packdir}" &&
+     cmp expect output'
+
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'setup bare repo' \
     'cd .. &&
      git clone --bare full bare &&
-- 
2.16.0

