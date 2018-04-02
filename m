Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531FB1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbeDBUfW (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:35:22 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41275 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932464AbeDBUfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:35:18 -0400
Received: by mail-qk0-f195.google.com with SMTP id s78so16378395qkl.8
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PFOmOb9lE28ch79Al2ARGLxkOrELlyy4ulVfs6h1MeQ=;
        b=l8ywBIi5atb9ypMmQhGCeSyCwh+nYsBJBUxZH2HjVRlJi/AauhkI5seyF8Cby/ebsC
         zEcZACFWe15Q6G5zoGzfpoz4L+qRYCZ2QAL+8pSKHrYsHNK3bRmprdpINuVm9afT7qfD
         Jtb0jyJH+svORY6y8IyAzr13zKZq/sXSCAca3fdpIOeMo2qfTVVc5VhbGzO2DEDyCVi7
         A52SQCu7YeN/rC1nVhOcXFKT0Mus470GoSUvX9wTQoI63KX2Nq26KHynyvJ+mZ+Mqoxw
         ZNFOH0lNgedcIICwokJY+w4djScrT5g8c192rlgqEFl2OpgOghjrfFArZrCcfjsWLVKD
         1gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PFOmOb9lE28ch79Al2ARGLxkOrELlyy4ulVfs6h1MeQ=;
        b=gW1tfcc7vC+qhUq+Fw94XUxc6YIUqWTHaG+zO/5cXWjgsEqEG6HaIo+104vk94NAIT
         nZWKGYBN7VUr0OPh0U6Lc5CFe7dhxhhKdV1apgyrQ+a3VOYx6GWddSSxceQuyWM3URZ/
         Dhx1hRJzZIdUjGIZlI0ZLt54cXHwd5kGDHBttSdIRtlDzUjs+QkKAtY+YCzqfytyTEIl
         lVwZNxI4D43nGUk2XHFu4+0d6/1VYmBNGX9Ya8gydYxZuFWAtYRhnvC5tMFseRGu3FdJ
         NB0hqEHtKo8BPgcmQNiE9WS5fTDtR1a7ek42GBlh06cMY+8XhB9Iw37Yjkw2NBFyRBu7
         0NWw==
X-Gm-Message-State: ALQs6tDDvLkxxNs5YB0u0IJhGI+AhqStDwwTfCxkzeKo3cwGE070pcfl
        kKsadFkpapxOTmHIkZwoisMsPH+hBe8=
X-Google-Smtp-Source: AIpwx48IKGCFEr71uiHWsSYCf5Ivml/7HXLqP+ytr7ev42TZooUhaXQRATfGb2r2AzQhbp1sphrYpg==
X-Received: by 10.55.196.1 with SMTP id d1mr15088002qki.247.1522701317705;
        Mon, 02 Apr 2018 13:35:17 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id n30sm998611qtb.93.2018.04.02.13.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 13:35:17 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 14/14] commit-graph: implement "--additive" option
Date:   Mon,  2 Apr 2018 16:34:27 -0400
Message-Id: <20180402203427.170177-15-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180402203427.170177-1-dstolee@microsoft.com>
References: <20180314192736.70602-1-dstolee@microsoft.com>
 <20180402203427.170177-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Teach git-commit-graph to add all commits from the existing
commit-graph file to the file about to be written. This should be
used when adding new commits without performing garbage collection.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 10 ++++++++++
 builtin/commit-graph.c             | 10 +++++++---
 commit-graph.c                     | 17 ++++++++++++++++-
 commit-graph.h                     |  3 ++-
 t/t5318-commit-graph.sh            | 10 ++++++++++
 5 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 442ac243e6..4c97b555cc 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -43,6 +43,9 @@ With the `--stdin-commits` option, generate the new commit graph by
 walking commits starting at the commits specified in stdin as a list
 of OIDs in hex, one OID per line. (Cannot be combined with
 --stdin-packs.)
++
+With the `--append` option, include all commits that are present in the
+existing commit-graph file.
 
 'read'::
 
@@ -72,6 +75,13 @@ $ echo <pack-index> | git commit-graph write --stdin-packs
 $ git show-ref -s | git commit-graph write --stdin-commits
 ------------------------------------------------
 
+* Write a graph file containing all commits in the current
+* commit-graph file along with those reachable from HEAD.
++
+------------------------------------------------
+$ git rev-parse HEAD | git commit-graph write --stdin-commits --append
+------------------------------------------------
+
 * Read basic information from the commit-graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f5fc717b8f..41c4f76caf 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -18,7 +18,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -26,6 +26,7 @@ static struct opts_commit_graph {
 	const char *obj_dir;
 	int stdin_packs;
 	int stdin_commits;
+	int append;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -94,6 +95,8 @@ static int graph_write(int argc, const char **argv)
 			N_("scan pack-indexes listed by stdin for commits")),
 		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
 			N_("start walk at commits listed by stdin")),
+		OPT_BOOL(0, "append", &opts.append,
+			N_("include all commits already in the commit-graph file")),
 		OPT_END(),
 	};
 
@@ -131,7 +134,8 @@ static int graph_write(int argc, const char **argv)
 			   pack_indexes,
 			   packs_nr,
 			   commit_hex,
-			   commits_nr);
+			   commits_nr,
+			   opts.append);
 
 	return 0;
 }
diff --git a/commit-graph.c b/commit-graph.c
index 253bc2213a..1fc63d541b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -553,7 +553,8 @@ void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
 			const char **commit_hex,
-			int nr_commits)
+			int nr_commits,
+			int append)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -571,10 +572,24 @@ void write_commit_graph(const char *obj_dir,
 	oids.nr = 0;
 	oids.alloc = approximate_object_count() / 4;
 
+	if (append) {
+		prepare_commit_graph_one(obj_dir);
+		if (commit_graph)
+			oids.alloc += commit_graph->num_commits;
+	}
+
 	if (oids.alloc < 1024)
 		oids.alloc = 1024;
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
+	if (append && commit_graph) {
+		for (i = 0; i < commit_graph->num_commits; i++) {
+			const unsigned char *hash = commit_graph->chunk_oid_lookup +
+				commit_graph->hash_len * i;
+			hashcpy(oids.list[oids.nr++].hash, hash);
+		}
+	}
+
 	if (pack_indexes) {
 		struct strbuf packname = STRBUF_INIT;
 		int dirlen;
diff --git a/commit-graph.h b/commit-graph.h
index fd035101b2..e1d8580c98 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -40,6 +40,7 @@ void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
 			const char **commit_hex,
-			int nr_commits);
+			int nr_commits,
+			int append);
 
 #endif
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index c28cfb5d7f..a380419b65 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -190,6 +190,16 @@ test_expect_success 'build graph from commits with closure' '
 graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'graph from commits, commit 8 vs merge 2' full commits/8 merge/2
 
+test_expect_success 'build graph from commits with append' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git rev-parse merge/3 | git commit-graph write --stdin-commits --append &&
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "10" "large_edges"
+'
+
+graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone --bare --no-local full bare &&
-- 
2.17.0.14.gba1221a8ce

