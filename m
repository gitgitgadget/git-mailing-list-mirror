Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0141F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeDBUfZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:35:25 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35404 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932487AbeDBUfO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:35:14 -0400
Received: by mail-qk0-f194.google.com with SMTP id c188so16405462qkg.2
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1WhQOov6a0f/mKXKyZ8yQq5P0a11YYAMvhnQ5ca0rRg=;
        b=JiFb3MUaLDZrNq3B984UJWhFw7m7i71IFbllAHNT+cM0/pPKkUk0BNo06ZQG8ypS5M
         6Ojpzb99cksGen7y57OTFd5EujxGh3CG9mWpSQw6pMucoQF6WI26hJEGOpHvXgWx1eGl
         bvOjXx9YOAVUaq8wKAZsWavRzDvLXv0t2+bbQCbZEghqDMikoQDV9PD6PL33IHj+jhmg
         DfIYNPINBK7WHP8ZoVgr8kSSqP6aIBMnAnnZoyFjPl07wy/59cQGWnu6rH8HUjzjQF1F
         TZ1fX83Wf5yN322X/LAFceZ2ygQdx9+X8tSNtiGV1y2jOjQ0Ia9tDCE5hBAOrLHBGShm
         MS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1WhQOov6a0f/mKXKyZ8yQq5P0a11YYAMvhnQ5ca0rRg=;
        b=Y6DhKg2MbO9oDns3RSLL280qM8uotj63ByOcsQ4tbOcxS/tY0erT2rUZKZDHZTYdHO
         NsGv8l6dJep7VtUscy3ZCdR7civm+klxBpU/LijKaEnRRkuGbnI1kWgcesBjHPf1+n1z
         D/JFY9G3GyBnV05IAMjZKeiaMd2uWh4E72cEb3oh36evOefNNhDBNGtQMYPQ3EBjQuXt
         BTH37EE8H2mv04X+fLHa4SBntY7Tx3HfUfY1/a+uJhqzdiYsjjsLexKH81a3exG9mDzm
         4nPrelLc5nvKA8B6bEuzrx7DWLsojrAo4FbckNAG4+8wGb5KN3/mc0MrtrvVobdAOkKR
         BehA==
X-Gm-Message-State: ALQs6tD605OHg09W/uGwN8fduo1phj4MgCiiUHNHMuOo/Nk+RvCCJhQ+
        H/kLGdJ20nfPNgTk5AZX8aiPWQObFN0=
X-Google-Smtp-Source: AIpwx4+hFk7rCCrZI3UBPCw0mLylz+wyQ3E7GsKsHQbLpyQ1SG18rEDMMpJTRJskpisNH/MbHOsctA==
X-Received: by 10.55.187.3 with SMTP id l3mr15004390qkf.32.1522701313041;
        Mon, 02 Apr 2018 13:35:13 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:35:12 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 12/14] commit-graph: read only from specific pack-indexes
Date:   Mon,  2 Apr 2018 16:34:25 -0400
Message-Id: <20180402203427.170177-13-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach git-commit-graph to inspect the objects only in a certain list
of pack-indexes within the given pack directory. This allows updating
the commit graph iteratively.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 11 +++++++++-
 builtin/commit-graph.c             | 33 +++++++++++++++++++++++++++---
 commit-graph.c                     | 26 +++++++++++++++++++++--
 commit-graph.h                     |  4 +++-
 packfile.c                         |  4 ++--
 packfile.h                         |  2 ++
 t/t5318-commit-graph.sh            | 10 +++++++++
 7 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 8aad8303f5..8143cc3f07 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -34,7 +34,9 @@ COMMANDS
 'write'::
 
 Write a commit graph file based on the commits found in packfiles.
-Includes all commits from the existing commit graph file.
++
+With the `--stdin-packs` option, generate the new commit graph by
+walking objects only in the specified pack-indexes.
 
 'read'::
 
@@ -51,6 +53,13 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
+* Write a graph file, extending the current graph file using commits
+* in <pack-index>.
++
+------------------------------------------------
+$ echo <pack-index> | git commit-graph write --stdin-packs
+------------------------------------------------
+
 * Read basic information from the commit-graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index e3f67401fb..9f83c872e9 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs]"),
 	NULL
 };
 
@@ -18,12 +18,13 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs]"),
 	NULL
 };
 
 static struct opts_commit_graph {
 	const char *obj_dir;
+	int stdin_packs;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -76,10 +77,18 @@ static int graph_read(int argc, const char **argv)
 
 static int graph_write(int argc, const char **argv)
 {
+	const char **pack_indexes = NULL;
+	int packs_nr = 0;
+	const char **lines = NULL;
+	int lines_nr = 0;
+	int lines_alloc = 0;
+
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
 			N_("The object directory to store the graph")),
+		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
+			N_("scan pack-indexes listed by stdin for commits")),
 		OPT_END(),
 	};
 
@@ -90,7 +99,25 @@ static int graph_write(int argc, const char **argv)
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
 
-	write_commit_graph(opts.obj_dir);
+	if (opts.stdin_packs) {
+		struct strbuf buf = STRBUF_INIT;
+		lines_nr = 0;
+		lines_alloc = 128;
+		ALLOC_ARRAY(lines, lines_alloc);
+
+		while (strbuf_getline(&buf, stdin) != EOF) {
+			ALLOC_GROW(lines, lines_nr + 1, lines_alloc);
+			lines[lines_nr++] = strbuf_detach(&buf, NULL);
+		}
+
+		pack_indexes = lines;
+		packs_nr = lines_nr;
+	}
+
+	write_commit_graph(opts.obj_dir,
+			   pack_indexes,
+			   packs_nr);
+
 	return 0;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index 983454785e..fa19b83a8e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -549,7 +549,9 @@ static void close_reachable(struct packed_oid_list *oids)
 	}
 }
 
-void write_commit_graph(const char *obj_dir)
+void write_commit_graph(const char *obj_dir,
+			const char **pack_indexes,
+			int nr_packs)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -571,7 +573,27 @@ void write_commit_graph(const char *obj_dir)
 		oids.alloc = 1024;
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
-	for_each_packed_object(add_packed_commits, &oids, 0);
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
+			for_each_object_in_pack(p, add_packed_commits, &oids);
+			close_pack(p);
+		}
+		strbuf_release(&packname);
+	} else
+		for_each_packed_object(add_packed_commits, &oids, 0);
+
 	close_reachable(&oids);
 
 	QSORT(oids.list, oids.nr, commit_compare);
diff --git a/commit-graph.h b/commit-graph.h
index 73b28beed1..f065f0866f 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -36,6 +36,8 @@ struct commit_graph {
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
 
-void write_commit_graph(const char *obj_dir);
+void write_commit_graph(const char *obj_dir,
+			const char **pack_indexes,
+			int nr_packs);
 
 #endif
diff --git a/packfile.c b/packfile.c
index 7c1a2519fc..b1d33b646a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -304,7 +304,7 @@ void close_pack_index(struct packed_git *p)
 	}
 }
 
-static void close_pack(struct packed_git *p)
+void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
 	close_pack_fd(p);
@@ -1850,7 +1850,7 @@ int has_pack_index(const unsigned char *sha1)
 	return 1;
 }
 
-static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
+int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
 {
 	uint32_t i;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index a7fca598d6..b341f2bf5e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,6 +63,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
+extern void close_pack(struct packed_git *);
 extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
@@ -140,6 +141,7 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
+extern int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn, void *data);
 extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
 /*
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 51de9cc455..3bb44d0c09 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -167,6 +167,16 @@ test_expect_success 'write graph with nothing new' '
 graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'cleared graph, commit 8 vs merge 2' full commits/8 merge/2
 
+test_expect_success 'build graph from latest pack with closure' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cat new-idx | git commit-graph write --stdin-packs &&
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "9" "large_edges"
+'
+
+graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'graph from pack, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone --bare --no-local full bare &&
-- 
2.17.0.14.gba1221a8ce

