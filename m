Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D851F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeBSSx6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:53:58 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42819 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbeBSSxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:49 -0500
Received: by mail-qt0-f196.google.com with SMTP id k25so13439191qtj.9
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qlerZB6HgKdhlLEQ5T4PPM//WbHmmG9PyR7ZOLBmyYU=;
        b=p7Dv2GtCBupacIJ14dHNSoUH2ChXLC9smSX2ELwJJaCP14gwGCZcwWWmc3n1oYWRtp
         8JPNQGSxWWamXlaYvJJEFRyhxLhuPdxz6VDxn4WABMjxp2U8IzORjkC1iBYnzSHGwb/m
         Z3vdCQOEUFCL8vsj95/saOX0KOIo32zISVbm4jsKBZr3poI966dTt34iRro3oLM5M3W5
         9SvJZk8FS3wtv4QPwImjyAE4326fec+tvEYXBDc8Ox9va3WGQbNlSY9qxaq8Sa0rb2Js
         kMxRBOXVj3lntScVZJGojd4BPDAkiE4oeZtye4teP9pSBn0IRmGWCVrNteUm39n/DdaR
         MtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qlerZB6HgKdhlLEQ5T4PPM//WbHmmG9PyR7ZOLBmyYU=;
        b=Um+dlWdhd0+MVuZokJoo3h+MQeE8SqGOW+cLmUCXi64lUxKklnn2t2/SEhEKIg+Sii
         I4C1rX/aZ66ZLb1qpU793NeN+Ozn+P+tlzfnQO7ybMfR2U84Z8g6/mKwPgHmginIS6XS
         L8312jKa9DTv+2xRs5Gk3pZNhwGfG+09oJLyeMJR0u+EW5opiSAcM2YlBCCbt1OW/eo4
         PI4ARPTGZxmYgxjbAvMG20SyKR3Z2rTT3DnV4tY3KbX/M6yZxGWmH2oBWN8/ZkObEH2H
         P4U1zbEa3Xe5VUH3R+kR5D7TNGejQ7GMGmjgFcQYEQGS4vSoaWpTn7ahZ1iTvT+R6QqT
         gJbw==
X-Gm-Message-State: APf1xPDEzmkxxKq8UHck3w8N8CHnl209COtJYgwOTw7Hh9lUB+K0lAZP
        Tsv3fovoyvCH29CQTma0C8W1hUzM3YE=
X-Google-Smtp-Source: AH8x226YOz2PQ8dPzf5PtPg1CZX+o1ry/dbvoVCGrhwkfktvJL0VYnBYMWm8ZKfcZjsNyul5LdHZYQ==
X-Received: by 10.200.22.81 with SMTP id x17mr26512176qtk.326.1519066428579;
        Mon, 19 Feb 2018 10:53:48 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:47 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 13/13] commit-graph: build graph from starting commits
Date:   Mon, 19 Feb 2018 13:53:26 -0500
Message-Id: <1519066406-81663-14-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
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
of packfiles in the repo (1, 24, or 120). If a commit graph file
already exists (and core.commitGraph=true), then this operation takes
only 1.8 seconds due to less time spent parsing commits.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 15 ++++++++++++++-
 builtin/commit-graph.c             | 27 +++++++++++++++++++++------
 commit-graph.c                     | 26 ++++++++++++++++++++++++--
 commit-graph.h                     |  4 +++-
 t/t5318-commit-graph.sh            | 19 +++++++++++++++++++
 5 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 93d50d1..43ac74b 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -45,7 +45,12 @@ graph-latest file if it is updated by the `--set-latest` option.
 +
 With the `--stdin-packs` option, generate the new commit graph by
 walking objects only in the specified packfiles and any commits in
-the existing graph-head.
+the existing graph-head. (Cannot be combined with --stdin-commits.)
++
+With the `--stdin-commits` option, generate the new commit graph by
+walking commits starting at the commits specified in stdin as a list
+of OIDs in hex, one OID per line. (Cannot be combined with
+--stdin-packs.)
 
 'read'::
 
@@ -79,6 +84,14 @@ $ git commit-graph write --set-latest --delete-expired
 $ echo <pack-index> | git commit-graph write --set-latest --delete-expired --stdin-packs
 ------------------------------------------------
 
+* Write a graph file, extending the current graph file using all
+* commits reachable from refs/heads/*, update graph-latest, and delete
+* stale graph files.
++
+------------------------------------------------
+$ git show-ref -s | git commit-graph write --set-latest --delete-expired --stdin-commits
+------------------------------------------------
+
 * Read basic information from a graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 5f08c40..9b92549 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>] [--file=<hash>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--set-latest] [--delete-expired] [--stdin-packs]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--set-latest] [--delete-expired] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -18,7 +18,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--set-latest] [--delete-expired] [--stdin-packs]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--set-latest] [--delete-expired] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -28,6 +28,7 @@ static struct opts_commit_graph {
 	int set_latest;
 	int delete_expired;
 	int stdin_packs;
+	int stdin_commits;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -152,6 +153,8 @@ static int graph_write(int argc, const char **argv)
 	char *old_graph_name;
 	const char **pack_indexes = NULL;
 	int nr_packs = 0;
+	const char **commit_hex = NULL;
+	int nr_commits = 0;
 	const char **lines = NULL;
 	int nr_lines = 0;
 	int alloc_lines = 0;
@@ -166,6 +169,8 @@ static int graph_write(int argc, const char **argv)
 			N_("delete expired head graph file")),
 		OPT_BOOL('s', "stdin-packs", &opts.stdin_packs,
 			N_("only scan packfiles listed by stdin")),
+		OPT_BOOL('C', "stdin-commits", &opts.stdin_commits,
+			N_("start walk at commits listed by stdin")),
 		OPT_END(),
 	};
 
@@ -173,12 +178,14 @@ static int graph_write(int argc, const char **argv)
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
 
+	if (opts.stdin_packs && opts.stdin_commits)
+		die(_("cannot use both --stdin-commits and --stdin-packs"));
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
 
 	old_graph_name = get_graph_latest_contents(opts.obj_dir);
 
-	if (opts.stdin_packs) {
+	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf = STRBUF_INIT;
 		nr_lines = 0;
 		alloc_lines = 128;
@@ -190,13 +197,21 @@ static int graph_write(int argc, const char **argv)
 			strbuf_detach(&buf, NULL);
 		}
 
-		pack_indexes = lines;
-		nr_packs = nr_lines;
+		if (opts.stdin_packs) {
+			pack_indexes = lines;
+			nr_packs = nr_lines;
+		}
+		if (opts.stdin_commits) {
+			commit_hex = lines;
+			nr_commits = nr_lines;
+		}
 	}
 
 	graph_name = write_commit_graph(opts.obj_dir,
 					pack_indexes,
-					nr_packs);
+					nr_packs,
+					commit_hex,
+					nr_commits);
 
 	if (graph_name) {
 		if (opts.set_latest)
diff --git a/commit-graph.c b/commit-graph.c
index 943192c..b9e938c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -556,7 +556,9 @@ static void close_reachable(struct packed_oid_list *oids)
 
 char *write_commit_graph(const char *obj_dir,
 			 const char **pack_indexes,
-			 int nr_packs)
+			 int nr_packs,
+			 const char **commit_hex,
+			 int nr_commits)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -599,7 +601,27 @@ char *write_commit_graph(const char *obj_dir,
 			close_pack(p);
 		}
 	}
-	else
+
+	if (commit_hex) {
+		for (i = 0; i < nr_commits; i++) {
+			const char *end;
+			struct object_id oid;
+			struct commit *result;
+
+			if (commit_hex[i] && parse_oid_hex(commit_hex[i], &oid, &end))
+				continue;
+
+			result = lookup_commit_reference_gently(&oid, 1);
+
+			if (result) {
+				ALLOC_GROW(oids.list, oids.nr + 1, oids.alloc);
+				oidcpy(&oids.list[oids.nr], &(result->object.oid));
+				oids.nr++;
+			}
+		}
+	}
+
+	if (!pack_indexes && !commit_hex)
 		for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
 
 	close_reachable(&oids);
diff --git a/commit-graph.h b/commit-graph.h
index 5617842..2582a3c 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -41,7 +41,9 @@ extern void prepare_commit_graph(void);
 
 extern char *write_commit_graph(const char *obj_dir,
 				const char **pack_indexes,
-				int nr_packs);
+				int nr_packs,
+				const char **commit_hex,
+				int nr_commits);
 
 #endif
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 5bd1f77..2ed6b19 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -196,6 +196,25 @@ test_expect_success 'build graph from latest pack with closure' '
 graph_git_behavior 'graph from pack, commit 8 vs merge 1' commits/8 merge/1
 graph_git_behavior 'graph from pack, commit 8 vs merge 2' commits/8 merge/2
 
+test_expect_success 'build graph from commits with closure' '
+	git tag -a -m "merge" tag/merge merge/2 &&
+	git rev-parse tag/merge >commits-in &&
+	git rev-parse merge/1 >>commits-in &&
+	rm $objdir/info/graph-latest &&
+	graph6=$(cat commits-in | git commit-graph write --set-latest --delete-expired --stdin-commits) &&
+	test_path_is_file $objdir/info/$graph6 &&
+	test_path_is_missing $objdir/info/$graph5 &&
+	test_path_is_file $objdir/info/graph-latest &&
+	printf $graph6 >expect &&
+	test_cmp expect $objdir/info/graph-latest &&
+	git commit-graph read --file=$graph6 >output &&
+	graph_read_expect "6" &&
+	test_cmp expect output
+'
+
+graph_git_behavior 'graph from commits, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'graph from commits, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd .. &&
 	git clone --bare --no-local full bare &&
-- 
2.7.4

