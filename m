Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72AC81F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbeA3Vke (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:34 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45963 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbeA3Vk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:26 -0500
Received: by mail-qk0-f195.google.com with SMTP id z12so12109107qkf.12
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GkclZDmoNDEiR7BsP4t51JNX+WD3oqaqri3P1SHUKRs=;
        b=jAkSWpXHs0OZA11mbiUFG65+qmEI3UvJUSy2X5p3doTaPllQGR06K14tzbnidmmyZJ
         kcAmV7xAhvvnDl4IevR/I8wcnmSGmoQvtHkYcYl82J+hPFegQJgv8VT5tk0+etFihcA4
         1HtMY6lUqfffrfxNXrQdftlPI9aLY3VLKK9ShNR1ugooQ0nUoYd4+UskIaue2t4DaJto
         lNG7Hz0TSnVVeAJ9tjguN15Is7cJh0oSdToV2j0Q1EaRyTK4HZOOGoyCipeN8rpogxLX
         v7kDLz7XDaYRkyQYEJPKqeiE5O4/goWsOk6KO+ix17TDevEM+UpMNbgUwddtgdQTKSq+
         ODqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GkclZDmoNDEiR7BsP4t51JNX+WD3oqaqri3P1SHUKRs=;
        b=G9uk2cNfLqZq9uKJNs7X719M8TL+DCOhPTJ9LTjwlJvK3z9xa699pBtk43m7vWKE5f
         Qdmw9ZPG+hkvOMA/SAnPBYPoZVc+dOh/o/fcXCSjjjOqwsIqvmWWMdlbLk6K8rMDbo9c
         kZRvMOPXkZuzzPdUGegh+EiJaz4kCo2wZi3HcpDOGgyMo2IcyyaEOnVksSrsr1++KbGQ
         f9xCQW0WAoAOFnib4pCzhi1VtOwAGSfHsW4cwmUgQg2z5CulPo58EzfEAmNaJ0Jcp1X+
         ITRW2PJNRkCwyOCutU9X3sRjXDyC0K2hFK1cp77J051A+5FNHkB7ECCTjASuFhw3Gvko
         Fq6A==
X-Gm-Message-State: AKwxyte6PyQ0qNGuQKyZIRgXejTUCH/o9y4tDKw23eUOKY4iWhhAeI+t
        QuNpxgI46vaYm4F7GxH7naYRjSMQ
X-Google-Smtp-Source: AH8x224o8JMZiWsejTxTLbV7jhd8wi1mJloIU8Br1OuXwWGkqwObH3dkVI25ptIwnvn5ntKO1LxpmQ==
X-Received: by 10.55.50.213 with SMTP id y204mr41146409qky.86.1517348425037;
        Tue, 30 Jan 2018 13:40:25 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:24 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 14/14] commit-graph: build graph from starting commits
Date:   Tue, 30 Jan 2018 16:39:43 -0500
Message-Id: <1517348383-112294-15-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to read commits from stdin when the
--stdin-commits flag is specified. Commits reachable from these
commits are added to the graph. This is a much faster way to construct
the graph than inspecting all packed objects, but is restricted to
known tips.

For the Linux repository, 700,000+ commits were added to the graph
file starting from 'master' in 7-9 seconds, depending on the number
of packfiles in the repo (1, 24, or 120).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  7 ++++++-
 builtin/commit-graph.c             | 34 +++++++++++++++++++++++++---------
 commit-graph.c                     | 26 +++++++++++++++++++++++---
 commit-graph.h                     |  4 +++-
 t/t5318-commit-graph.sh            | 18 ++++++++++++++++++
 5 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index d0571cd896..3357c0cf8f 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -46,7 +46,12 @@ OPTIONS
 --stdin-packs::
 	When used with --write, generate the new graph by walking objects
 	only in the specified packfiles and any commits in the
-	existing graph-head.
+	existing graph-head. (Cannot be combined with --stdin-commits.)
+
+--stdin-commits::
+	When used with --write, generate the new graph by walking commits
+	starting at the commits specified in stdin as a list of OIDs in
+	hex, one OID per line. (Cannot be combined with --stdin-packs.)
 
 EXAMPLES
 --------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 80a409e784..adc05f0582 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -12,7 +12,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
 	N_("git commit-graph --clear [--pack-dir <packdir>]"),
 	N_("git commit-graph --read [--graph-hash=<hash>]"),
-	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs]"),
+	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -25,6 +25,7 @@ static struct opts_commit_graph {
 	int update_head;
 	int delete_expired;
 	int stdin_packs;
+	int stdin_commits;
 	int has_existing;
 	struct object_id old_graph_hash;
 } opts;
@@ -117,23 +118,36 @@ static int graph_write(void)
 {
 	struct object_id *graph_hash;
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
-	}
 
-	graph_hash = construct_commit_graph(opts.pack_dir, pack_indexes, num_packs);
+		if (opts.stdin_packs) {
+			pack_indexes = lines;
+			num_packs = num_lines;
+		}
+		if (opts.stdin_commits) {
+			commits = lines;
+			num_commits = num_lines;
+		}
+	}
 
+	graph_hash = construct_commit_graph(opts.pack_dir, pack_indexes, num_packs,
+					    commits, num_commits);
 	if (opts.update_head)
 		update_head_file(opts.pack_dir, graph_hash);
 
@@ -172,6 +186,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			N_("delete expired head graph file")),
 		OPT_BOOL('s', "stdin-packs", &opts.stdin_packs,
 			N_("only scan packfiles listed by stdin")),
+		OPT_BOOL('C', "stdin-commits", &opts.stdin_commits,
+			N_("start walk at commits listed by stdin")),
 		{ OPTION_STRING, 'H', "graph-hash", &opts.graph_hash,
 			N_("hash"),
 			N_("A hash for a specific graph file in the pack-dir."),
diff --git a/commit-graph.c b/commit-graph.c
index cfa0415a21..7f31a6c795 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -664,7 +664,9 @@ static void close_reachable(struct packed_oid_list *oids)
 
 struct object_id *construct_commit_graph(const char *pack_dir,
 					 char **pack_indexes,
-					 int nr_packs)
+					 int nr_packs,
+					 char **commit_hex,
+					 int nr_commits)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -717,10 +719,28 @@ struct object_id *construct_commit_graph(const char *pack_dir,
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
+
+			oids.list[oids.num] = malloc(sizeof(struct object_id));
+
+			if (parse_oid_hex(commit_hex[i], oids.list[oids.num], &end)) {
+				free(oids.list[oids.num]);
+				continue;
+			}
+
+			if (lookup_commit(oids.list[oids.num]))
+				oids.num++;
+		}
+	}
+
+	if (!pack_indexes && !commit_hex)
+		for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+
 	close_reachable(&oids);
 	QSORT(oids.list, oids.num, commit_compare);
 
diff --git a/commit-graph.h b/commit-graph.h
index 3ae1eadce0..619b1f6def 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -62,6 +62,8 @@ extern struct object_id *get_nth_commit_oid(struct commit_graph *g,
 
 extern struct object_id *construct_commit_graph(const char *pack_dir,
 						char **pack_indexes,
-						int nr_packs);
+						int nr_packs,
+						char **commits,
+						int nr_commits);
 
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2001b0b5b5..0bf27a2e7c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -227,6 +227,24 @@ test_expect_success 'build graph from latest pack with closure' \
 _graph_git_behavior commits/20 merge/1
 _graph_git_behavior commits/20 merge/2
 
+test_expect_success 'build graph from commits with closure' \
+    'git rev-parse commits/20 >commits-in &&
+     git rev-parse merge/1 >>commits-in &&
+     git rev-parse merge/2 >>commits-in &&
+     graph6=$(cat commits-in | git commit-graph --write --update-head --delete-expired --stdin-commits) &&
+     test_path_is_file ${packdir}/graph-${graph6}.graph &&
+     test_path_is_missing ${packdir}/graph-${graph5}.graph &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     test_path_is_file ${packdir}/graph-head &&
+     echo ${graph6} >expect &&
+     cmp -n 40 expect ${packdir}/graph-head &&
+     git commit-graph --read --graph-hash=${graph6} >output &&
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
2.16.0.15.g9c3cf44.dirty

