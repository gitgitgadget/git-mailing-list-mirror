Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA0B1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbeBSSxu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:53:50 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42816 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753552AbeBSSxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:48 -0500
Received: by mail-qt0-f196.google.com with SMTP id k25so13439118qtj.9
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ITuVG50uhimgQJ9OdqU9bThikXFHSo0JxvYlQTW4FUM=;
        b=k8JXUwLp8241De7zCg6c2WdzK19cnlGdtBvNxjJ6hAY01dmUbBnmhYJoYFG8PVD8md
         cy5X04OwZqLBeYGGHKSJmXKwLyh+SQXnWlVHyR969YQjUQ8dqLhb4VcOIW/fs7bLHEU+
         mSCewoddLaZJ1QjVHmK/BKiTmWkYpCNH/r/FO7M6jp0rYV5w4BK5xWlQFi5h5z4EmJ2p
         XjD5UlBW8ymz5XqYy9/ltfShUCMypUIrvmNoPXtFHGqhV6kQ6YyACfKp1jnohESd3E5D
         AvHRFlouxgc8IDDrHKEzMkQKfgtJIttY354E9SxD/g47GrFrNbZf7rbcXh8CST6wDggA
         F/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ITuVG50uhimgQJ9OdqU9bThikXFHSo0JxvYlQTW4FUM=;
        b=mEqC3XhcbTf6YgUTk8syHrR45ojOK9PV0dSdcJahjsqx6Kxx8My9YC4j/2GeiF2MDS
         1vZCbfMyVFTS4u/ElemS9GFP5CtgSvmY3oZYRLa3qNFiu6WxsaDLp7YIlmPR6Ua0o4jr
         BDMcnIUACBJ20wdJ3xaXN9cvFVQlHPnflXVg8oLvz+HQk1yYAEToqIWWoLv9ql5HJpws
         Anrl8ogWz2gi1I3IOqz6+eqJEZHhpJZ0kzCmEUfJ+DqtTNmqnF37rfr2KosHHRYUsmor
         BZgCjg1fEAiOoF28YvZby/jGtL5aSo4HCn+fYdfnoTFZhn+WOFG4z0Uh6GBq7AWh+SwS
         h3ig==
X-Gm-Message-State: APf1xPDZDhdejS+eVNt9iJU7W8yaTwuU/OyKHFQ4/yaOld9se1G5NtoR
        yV0pWDDO9q4scc++2YnylEOvR6Ph1Ss=
X-Google-Smtp-Source: AH8x224BPIA9hab1nv5aXu3/6NB/1OBIoJ5MOqZrRWSAWkkPLp64ITDwt6n390L9mF1XMMzXcbG/Rg==
X-Received: by 10.237.36.170 with SMTP id t39mr26632761qtc.136.1519066427108;
        Mon, 19 Feb 2018 10:53:47 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:46 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 12/13] commit-graph: read only from specific pack-indexes
Date:   Mon, 19 Feb 2018 13:53:25 -0500
Message-Id: <1519066406-81663-13-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to inspect the objects only in a certain list
of pack-indexes within the given pack directory. This allows updating
the commit graph iteratively, since we add all commits stored in a
previous commit graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 11 +++++++++++
 builtin/commit-graph.c             | 32 +++++++++++++++++++++++++++++---
 commit-graph.c                     | 26 ++++++++++++++++++++++++--
 commit-graph.h                     |  4 +++-
 packfile.c                         |  4 ++--
 packfile.h                         |  2 ++
 t/t5318-commit-graph.sh            | 16 ++++++++++++++++
 7 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index b9b4031..93d50d1 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -42,6 +42,10 @@ With the `--delete-expired` option, delete the graph files in the pack
 directory that are not referred to by the graph-latest file. To avoid race
 conditions, do not delete the file previously referred to by the
 graph-latest file if it is updated by the `--set-latest` option.
++
+With the `--stdin-packs` option, generate the new commit graph by
+walking objects only in the specified packfiles and any commits in
+the existing graph-head.
 
 'read'::
 
@@ -68,6 +72,13 @@ $ git commit-graph write
 $ git commit-graph write --set-latest --delete-expired
 ------------------------------------------------
 
+* Write a graph file, extending the current graph file using commits
+* in <pack-index>, update graph-latest, and delete stale graph files.
++
+------------------------------------------------
+$ echo <pack-index> | git commit-graph write --set-latest --delete-expired --stdin-packs
+------------------------------------------------
+
 * Read basic information from a graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index fd99169..5f08c40 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>] [--file=<hash>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--set-latest] [--delete-expired]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--set-latest] [--delete-expired] [--stdin-packs]"),
 	NULL
 };
 
@@ -18,7 +18,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--set-latest] [--delete-expired]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--set-latest] [--delete-expired] [--stdin-packs]"),
 	NULL
 };
 
@@ -27,6 +27,7 @@ static struct opts_commit_graph {
 	const char *graph_file;
 	int set_latest;
 	int delete_expired;
+	int stdin_packs;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -149,6 +150,11 @@ static int graph_write(int argc, const char **argv)
 {
 	char *graph_name;
 	char *old_graph_name;
+	const char **pack_indexes = NULL;
+	int nr_packs = 0;
+	const char **lines = NULL;
+	int nr_lines = 0;
+	int alloc_lines = 0;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		{ OPTION_STRING, 'o', "object-dir", &opts.obj_dir,
@@ -158,6 +164,8 @@ static int graph_write(int argc, const char **argv)
 			N_("update graph-head to written graph file")),
 		OPT_BOOL('d', "delete-expired", &opts.delete_expired,
 			N_("delete expired head graph file")),
+		OPT_BOOL('s', "stdin-packs", &opts.stdin_packs,
+			N_("only scan packfiles listed by stdin")),
 		OPT_END(),
 	};
 
@@ -170,7 +178,25 @@ static int graph_write(int argc, const char **argv)
 
 	old_graph_name = get_graph_latest_contents(opts.obj_dir);
 
-	graph_name = write_commit_graph(opts.obj_dir);
+	if (opts.stdin_packs) {
+		struct strbuf buf = STRBUF_INIT;
+		nr_lines = 0;
+		alloc_lines = 128;
+		ALLOC_ARRAY(lines, alloc_lines);
+
+		while (strbuf_getline(&buf, stdin) != EOF) {
+			ALLOC_GROW(lines, nr_lines + 1, alloc_lines);
+			lines[nr_lines++] = buf.buf;
+			strbuf_detach(&buf, NULL);
+		}
+
+		pack_indexes = lines;
+		nr_packs = nr_lines;
+	}
+
+	graph_name = write_commit_graph(opts.obj_dir,
+					pack_indexes,
+					nr_packs);
 
 	if (graph_name) {
 		if (opts.set_latest)
diff --git a/commit-graph.c b/commit-graph.c
index ea07b47..943192c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -554,7 +554,9 @@ static void close_reachable(struct packed_oid_list *oids)
 	}
 }
 
-char *write_commit_graph(const char *obj_dir)
+char *write_commit_graph(const char *obj_dir,
+			 const char **pack_indexes,
+			 int nr_packs)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -579,7 +581,27 @@ char *write_commit_graph(const char *obj_dir)
 		oids.alloc = 1024;
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
-	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+	if (pack_indexes) {
+		struct strbuf packname = STRBUF_INIT;
+		int dirlen;
+		strbuf_addf(&packname, "%s/pack/", obj_dir);
+		dirlen = packname.len;
+		for (i = 0; i < nr_packs; i++) {
+			struct packed_git *p;
+			strbuf_setlen(&packname, dirlen);
+			strbuf_addstr(&packname, pack_indexes[i]);
+			p = add_packed_git(packname.buf, packname.len, 1);
+			if (!p)
+				die("error adding pack %s", packname.buf);
+			if (open_pack_index(p))
+				die("error opening index for %s", packname.buf);
+			for_each_object_in_pack(p, if_packed_commit_add_to_list, &oids);
+			close_pack(p);
+		}
+	}
+	else
+		for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+
 	close_reachable(&oids);
 
 	QSORT(oids.list, oids.nr, commit_compare);
diff --git a/commit-graph.h b/commit-graph.h
index 4818838..5617842 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -39,7 +39,9 @@ extern struct commit_graph *load_commit_graph_one(const char *graph_file);
 
 extern void prepare_commit_graph(void);
 
-extern char *write_commit_graph(const char *obj_dir);
+extern char *write_commit_graph(const char *obj_dir,
+				const char **pack_indexes,
+				int nr_packs);
 
 #endif
 
diff --git a/packfile.c b/packfile.c
index 59648a1..b9ad7b1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -299,7 +299,7 @@ void close_pack_index(struct packed_git *p)
 	}
 }
 
-static void close_pack(struct packed_git *p)
+void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
 	close_pack_fd(p);
@@ -1839,7 +1839,7 @@ int has_pack_index(const unsigned char *sha1)
 	return 1;
 }
 
-static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
+int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
 {
 	uint32_t i;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index 0cdeb54..9281e90 100644
--- a/packfile.h
+++ b/packfile.h
@@ -61,6 +61,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
+extern void close_pack(struct packed_git *);
 extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
@@ -133,6 +134,7 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
+extern int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn, void *data);
 extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 8c6b510..5bd1f77 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -180,6 +180,22 @@ test_expect_success 'write graph with nothing new' '
 graph_git_behavior 'cleared graph, commit 8 vs merge 1' commits/8 merge/1
 graph_git_behavior 'cleared graph, commit 8 vs merge 2' commits/8 merge/2
 
+test_expect_success 'build graph from latest pack with closure' '
+	rm $objdir/info/graph-latest &&
+	graph5=$(cat new-idx | git commit-graph write --set-latest --delete-expired --stdin-packs) &&
+	test_path_is_file $objdir/info/$graph5 &&
+	test_path_is_missing $objdir/info/$graph4 &&
+	test_path_is_file $objdir/info/graph-latest &&
+	printf $graph5 >expect &&
+	test_cmp expect $objdir/info/graph-latest &&
+	git commit-graph read --file=$graph5 >output &&
+	graph_read_expect "9" "large_edges" &&
+	test_cmp expect output
+'
+
+graph_git_behavior 'graph from pack, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'graph from pack, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd .. &&
 	git clone --bare --no-local full bare &&
-- 
2.7.4

