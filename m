Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A7C1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeBHUiP (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:15 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33432 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeBHUiG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:38:06 -0500
Received: by mail-qt0-f194.google.com with SMTP id d8so7934003qtm.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e4P4DRlqI0wxOhi1sBgcl/zi37/1jd3v8PRlak6BT34=;
        b=tcaQNyb22bNbRJTUC3JKKpBiP95PW6VlrhZm7hElOooZiLShuVsaqXUtoAJcnDiQUQ
         7WwBqxTqhCSVhOTNgENu/MAn0wUFEWtHXBndhu36Aat5NgvDo9VX/kyjzS7XCsS7IZQ3
         rceDbh4ljmLxX9jk7forz6glUOemwLQ8emgnMH1bIERqHIU2ctGw9IQ72LyVxskrGfVh
         oLMUzwt7A6w58keSN2SgdrWNW4N0va6Vt1DaNTYvqLmM7sTGKLNlMFbKmDAE/pJrKs7S
         jAnbc+k2Sk/xC9y/nSwLv3/5Df4RlknhRHcOMlhdtdo9M6kgFqLBTXFIj0cNfVNSotZX
         0c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e4P4DRlqI0wxOhi1sBgcl/zi37/1jd3v8PRlak6BT34=;
        b=YwEHfPNuB/mIrtaUzCrj69Qrx8ZD/Mx1MyKUsLWzMbFvhDBEhmX5GzaH5fKHJrsxTR
         T6iMOMfnwLCUcMu6RQHBJEoFD1f87XJehaDtw2OLfZ45LVZZBdtN8zbgElMs1JT9lbaw
         dv5B39OP+b9ACsr8ek4YyeNc9DbrShNpMcdGlGe+VdA/dWrp4ulXUx6LbJs435vX/tn4
         aFaMmFwbB7DLjbGXXrF0zoVMEngw4R8ZVmRqMLbvMgUfQrp5ycCLN3fiZe2Dvu/Z0lxo
         ZdvVw08+1UwIA4FoKh0KVc8S1km9XkpqCbZExfdLL/vtxJVGRgdXc82BiCOZ7egXbSME
         dYWw==
X-Gm-Message-State: APf1xPC+Jvjc2SZwGmxI5p725vkCzgeb0+60LsRloGxLsijEiYOnagmp
        hDek+tB0LscThIR2kvOMqhdVvsZkP3M=
X-Google-Smtp-Source: AH8x22660HQW4kcQRsYbUVgsH12HcpXzw1CuwW59dOjBfrnkF5l1Uf4wnak2fbNPT+sEaOEZUcYc1A==
X-Received: by 10.237.54.41 with SMTP id e38mr780448qtb.49.1518122285794;
        Thu, 08 Feb 2018 12:38:05 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:38:05 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 13/14] commit-graph: read only from specific pack-indexes
Date:   Thu,  8 Feb 2018 15:37:37 -0500
Message-Id: <1518122258-157281-14-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
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
 commit-graph.c                     | 25 +++++++++++++++++++++++--
 commit-graph.h                     |  4 +++-
 packfile.c                         |  4 ++--
 packfile.h                         |  2 ++
 t/t5318-commit-graph.sh            | 13 +++++++++++++
 7 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 7ae8f7484d..727d5d70bb 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -42,6 +42,10 @@ With the `--delete-expired` option, delete the graph files in the pack
 directory that are not referred to by the graph-head file. To avoid race
 conditions, do not delete the file previously referred to by the
 graph-head file if it is updated by the `--update-head` option.
++
+With the `--stdin-packs` option, generate the new commit graph by
+walking objects only in the specified packfiles and any commits in
+the existing graph-head.
 
 'read'::
 
@@ -72,6 +76,13 @@ $ git commit-graph write
 $ git commit-graph write --update-head --delete-expired
 ------------------------------------------------
 
+* Write a graph file, extending the current graph file using commits
+* in <pack-index>, update graph-head, and delete stale graph files.
++
+------------------------------------------------
+$ echo <pack-index> | git commit-graph write --update-head --delete-expired --stdin-packs
+------------------------------------------------
+
 * Read basic information from a graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 15f647fd81..fe5f00551c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,7 +9,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
 	N_("git commit-graph clear [--pack-dir <packdir>]"),
 	N_("git commit-graph read [--graph-hash=<hash>]"),
-	N_("git commit-graph write [--pack-dir <packdir>] [--update-head] [--delete-expired]"),
+	N_("git commit-graph write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs]"),
 	NULL
 };
 
@@ -24,7 +24,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--pack-dir <packdir>] [--update-head] [--delete-expired]"),
+	N_("git commit-graph write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs]"),
 	NULL
 };
 
@@ -33,6 +33,7 @@ static struct opts_commit_graph {
 	const char *graph_hash;
 	int update_head;
 	int delete_expired;
+	int stdin_packs;
 } opts;
 
 static int graph_clear(int argc, const char **argv)
@@ -216,6 +217,11 @@ static int graph_write(int argc, const char **argv)
 	struct object_id *graph_hash;
 	struct object_id old_graph_hash;
 	int has_existing;
+	const char **pack_indexes = NULL;
+	int nr_packs = 0;
+	const char **lines = NULL;
+	int nr_lines = 0;
+	int alloc_lines = 0;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		{ OPTION_STRING, 'p', "pack-dir", &opts.pack_dir,
@@ -225,6 +231,8 @@ static int graph_write(int argc, const char **argv)
 			N_("update graph-head to written graph file")),
 		OPT_BOOL('d', "delete-expired", &opts.delete_expired,
 			N_("delete expired head graph file")),
+		OPT_BOOL('s', "stdin-packs", &opts.stdin_packs,
+			N_("only scan packfiles listed by stdin")),
 		OPT_END(),
 	};
 
@@ -241,7 +249,25 @@ static int graph_write(int argc, const char **argv)
 
 	has_existing = !!get_graph_head_hash(opts.pack_dir, &old_graph_hash);
 
-	graph_hash = write_commit_graph(opts.pack_dir);
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
+	graph_hash = write_commit_graph(opts.pack_dir,
+					pack_indexes,
+					nr_packs);
 
 	if (opts.update_head)
 		update_head_file(opts.pack_dir, graph_hash);
diff --git a/commit-graph.c b/commit-graph.c
index d711a2cd81..27a34f5eda 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -655,7 +655,9 @@ static void close_reachable(struct packed_oid_list *oids)
 	}
 }
 
-struct object_id *write_commit_graph(const char *pack_dir)
+struct object_id *write_commit_graph(const char *pack_dir,
+				     const char **pack_indexes,
+				     int nr_packs)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -690,7 +692,26 @@ struct object_id *write_commit_graph(const char *pack_dir)
 		oids.nr = commit_graph->num_commits;
 	}
 
-	for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
+	if (pack_indexes) {
+		int pack_dir_len = strlen(pack_dir) + 1;
+		struct strbuf packname = STRBUF_INIT;
+		strbuf_add(&packname, pack_dir, pack_dir_len - 1);
+		strbuf_addch(&packname, '/');
+		for (i = 0; i < nr_packs; i++) {
+			struct packed_git *p;
+			strbuf_setlen(&packname, pack_dir_len);
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
 
 	close_reachable(&oids);
 	QSORT(oids.list, oids.nr, commit_compare);
diff --git a/commit-graph.h b/commit-graph.h
index 7c4c9c38ab..918b34dd2b 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -50,7 +50,9 @@ extern struct object_id *get_nth_commit_oid(struct commit_graph *g,
 					    uint32_t n,
 					    struct object_id *oid);
 
-extern struct object_id *write_commit_graph(const char *pack_dir);
+extern struct object_id *write_commit_graph(const char *pack_dir,
+					    const char **pack_indexes,
+					    int nr_packs);
 
 #endif
 
diff --git a/packfile.c b/packfile.c
index 29f5dc2398..e4b1dc02bc 100644
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
@@ -1840,7 +1840,7 @@ int has_pack_index(const unsigned char *sha1)
 	return 1;
 }
 
-static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
+int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
 {
 	uint32_t i;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index 0cdeb54dcd..9281e909d5 100644
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
index 1e3fe59d70..e3546e6844 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -169,6 +169,19 @@ test_expect_success 'clear graph' '
 graph_git_behavior 'cleared graph, commit 8 vs merge 1' commits/8 merge/1
 graph_git_behavior 'cleared graph, commit 8 vs merge 2' commits/8 merge/2
 
+test_expect_success 'build graph from latest pack with closure' '
+	graph5=$(cat new-idx | git commit-graph write --update-head --delete-expired --stdin-packs) &&
+	test_path_is_file $packdir/graph-$graph5.graph &&
+	test_path_is_file $packdir/graph-head &&
+	printf $graph5 >expect &&
+	test_cmp expect $packdir/graph-head &&
+	git commit-graph read --graph-hash=$graph5 >output &&
+	graph_read_expect "9" "$packdir" &&
+	test_cmp expect output'
+
+graph_git_behavior 'graph from pack, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'graph from pack, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd .. &&
 	git clone --bare --no-local full bare &&
-- 
2.15.1.45.g9b7079f

