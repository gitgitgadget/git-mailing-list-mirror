Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5BE1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCNT2U (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:28:20 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37431 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNT2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:28:09 -0400
Received: by mail-qk0-f196.google.com with SMTP id y137so4759185qka.4
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vWnlX+1SPBBXcrxwtaWaZSXGeX+91gO3/8wuD6XBGe0=;
        b=IstvW8cLQvmDqbVadY5GcPyUIdPyva9OsOhD3mZNy2sD6RDpIyLbfBJzU6OAZcOdZO
         vEd7S+DZ5r6kx8VXgwi5B3leTUk9Lap9OTnRH+SIbsYh53JJwUMUnU1YIdVMPZk6kBB1
         l3UgMlFP2nNAkgCJuFKE5sP/uXOV4tb58jyR1/jG61tGiGVYg0S6PzWAB/xU1+upIRGV
         EcG0RDtjzmqSd8NVfRcbzvzMMtZNycutYLhr/Bj18qdZSv3Drcx/8c9+jvdhgAE/qLoi
         f/bQGBcsAePbbqKWfqhpkq2yfeP4yuZMYoQDdcBDUFH9Aol70MRKUdRfqswRhFabHHeP
         HI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vWnlX+1SPBBXcrxwtaWaZSXGeX+91gO3/8wuD6XBGe0=;
        b=qtEECovubLnsurIKZDYEhEDdHzNhYPUNd8decIQjN+ZmN1AIMfmoZE0/5qOIOq/YQQ
         EKGNkKaGNXp90Pw9q3EFo9ctOinZHjz08wKVHSj1zbAZm01n8JXyGonJSAMCVi7nFmQf
         w9HBtLDafAOkKFH45DHE9JC3PT1EFkDwV7XrMbHoCnYlsGKDyhRERrvN/4NbO/CzKi7e
         pSftrju1uTEOlIKeIjO+RWDAKIXTbetQma2jzDtVbX8eD3tvnJAQEgqjpRNIOyS7GULF
         iJNCP1HQnHA68eQ0gCVfHEia6XmX2oPJzcj/FqOdyvQlbA9cgijPleHvnpkijB/wPGMY
         96tg==
X-Gm-Message-State: AElRT7FQ3qt0ES8v94N07fiGd8MSWMncUpQTPMiCI6MjuVUQ4DY7SsUJ
        zmR5CGM6XfbPElS/UQUoL3OAZyCc2FU=
X-Google-Smtp-Source: AG47ELu1HsdqSqAvX/sCH++WcIl6JqJFCB9ebwyWn91CugLqG25xdoMOW+2c/kA6Q5OijpCpI//XqA==
X-Received: by 10.55.192.20 with SMTP id o20mr8229192qki.257.1521055688035;
        Wed, 14 Mar 2018 12:28:08 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:28:07 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 12/14] commit-graph: read only from specific pack-indexes
Date:   Wed, 14 Mar 2018 15:27:34 -0400
Message-Id: <20180314192736.70602-13-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
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
 Documentation/git-commit-graph.txt | 11 ++++++++++-
 builtin/commit-graph.c             | 33 ++++++++++++++++++++++++++++++---
 commit-graph.c                     | 26 ++++++++++++++++++++++++--
 commit-graph.h                     |  4 +++-
 packfile.c                         |  4 ++--
 packfile.h                         |  2 ++
 t/t5318-commit-graph.sh            | 10 ++++++++++
 7 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 51cb038f3d..b945510f0f 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -32,7 +32,9 @@ COMMANDS
 'write'::
 
 Write a commit graph file based on the commits found in packfiles.
-Includes all commits from the existing commit graph file.
++
+With the `--stdin-packs` option, generate the new commit graph by
+walking objects only in the specified packfiles.
 
 'read'::
 
@@ -49,6 +51,13 @@ EXAMPLES
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
index 0e164becff..eebca57e6f 100644
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
+			N_("scan packfiles listed by stdin for commits")),
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
index 98e2b89b94..f0d7585ddb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -529,7 +529,9 @@ static void close_reachable(struct packed_oid_list *oids)
 	}
 }
 
-void write_commit_graph(const char *obj_dir)
+void write_commit_graph(const char *obj_dir,
+			const char **pack_indexes,
+			int nr_packs)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -551,7 +553,27 @@ void write_commit_graph(const char *obj_dir)
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
index b223b9b078..65fe77075c 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -36,7 +36,9 @@ struct commit_graph {
 
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
index 7bcc1b2874..5ab8b6975e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -167,6 +167,16 @@ test_expect_success 'write graph with nothing new' '
 graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'cleared graph, commit 8 vs merge 2' full commits/8 merge/2
 
+test_expect_success 'build graph from latest pack with closure' '
+        cd "$TRASH_DIRECTORY/full" &&
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
2.14.1

