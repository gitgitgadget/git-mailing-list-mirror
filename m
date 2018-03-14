Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2521F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeCNT2S (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:28:18 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41763 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeCNT2M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 15:28:12 -0400
Received: by mail-qk0-f195.google.com with SMTP id s78so4738478qkl.8
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1WINyiScewAtA3edgrFSwkm3erxSa+PYZtZLy6p/26A=;
        b=G3k+wBBEnM8TR0xjbd/0gs7NTAtaj9dpSefYlQwy/BY0lxtrcdrws3KRvVTMLREjtP
         VsRoFOFjfe62TIYfTntg7nklIwHC2n8GJjBjGVHIsc+ubFrPkKv6e3b3DYmKBIVqCD4V
         nRvduU3UmV+fDRnb4svMGemYXIcZaaMxUiL/7mefptxiLz5by9kePr69qqqOTzMntx7J
         Gr4XdKzzZYevTSrkS3r1oVDZm/PNAgaFoEMySdLta2q6cD+PTI7iY8+aYym1Z4SF+wow
         n1P7NP7fg2hFkIKELSG8X84M+pQnVLs/0bDgtKreY1lJH13pDTge61SF12O1PQaHuTYq
         wRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1WINyiScewAtA3edgrFSwkm3erxSa+PYZtZLy6p/26A=;
        b=PctUNcSyafAsIGmVvoixQ88pubXt5VIH5PNUV9ZrXP+D0isC4KSuJL0WnflLdowtVq
         TP0AQ45DVRP+BTOjy6Dj1XKhUy9Tg/kxGtCu0wo3B73p+qylj7EyNec9caOXRbEZiX6p
         C48lFuoUAFODnKrIycgfIVkEQ6jRyPv6NlFBmB1qc0j6uvlj79viFTLoqi7035+1Tf17
         X7B4+CgBIUhxoeKaSExH2XBEPsxkbJ2M+sEVyKptzbM2lxv7RPSlo0m1t2Ffgrl4nrz/
         RYRMncKxptwnzkDdYH5Ge9KkKhO93P6vTtQzTfe9/2reqyY/2cf2rOeWDbWUt2Kb60B1
         o+uQ==
X-Gm-Message-State: AElRT7GLk6dGtkIYyKMatbKWBaWQEQgZ4+gOTr037P3oBvqIByJ2dRhI
        uwWqRGZahEUNaGJjgzVu74XAh9XDJds=
X-Google-Smtp-Source: AG47ELt8X5IHLCqYYa1DxKk1TD56raW6dFN/fUah6TTeeDI8ye1fCm9cQhC0GnCPHBasMj5jVeBnbg==
X-Received: by 10.55.217.70 with SMTP id u67mr8149342qki.294.1521055690931;
        Wed, 14 Mar 2018 12:28:10 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id q30sm2847395qte.10.2018.03.14.12.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 12:28:10 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 14/14] commit-graph: implement "--additive" option
Date:   Wed, 14 Mar 2018 15:27:36 -0400
Message-Id: <20180314192736.70602-15-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
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
index 0710a68f2d..ccf5e203ce 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -41,6 +41,9 @@ With the `--stdin-commits` option, generate the new commit graph by
 walking commits starting at the commits specified in stdin as a list
 of OIDs in hex, one OID per line. (Cannot be combined with
 --stdin-packs.)
++
+With the `--additive` option, include all commits that are present
+in the existing commit-graph file.
 
 'read'::
 
@@ -70,6 +73,13 @@ $ echo <pack-index> | git commit-graph write --stdin-packs
 $ git show-ref -s | git commit-graph write --stdin-commits
 ------------------------------------------------
 
+* Write a graph file containing all commits in the current
+* commit-graph file along with those reachable from HEAD.
++
+------------------------------------------------
+$ git rev-parse HEAD | git commit-graph write --stdin-commits --additive
+------------------------------------------------
+
 * Read basic information from the commit-graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 1c7b7e72b0..d26a6d6de3 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--additive] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -18,7 +18,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--additive] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -26,6 +26,7 @@ static struct opts_commit_graph {
 	const char *obj_dir;
 	int stdin_packs;
 	int stdin_commits;
+	int additive;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -94,6 +95,8 @@ static int graph_write(int argc, const char **argv)
 			N_("scan packfiles listed by stdin for commits")),
 		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
 			N_("start walk at commits listed by stdin")),
+		OPT_BOOL(0, "additive", &opts.additive,
+			N_("include all commits already in the commit-graph file")),
 		OPT_END(),
 	};
 
@@ -131,7 +134,8 @@ static int graph_write(int argc, const char **argv)
 			   pack_indexes,
 			   packs_nr,
 			   commit_hex,
-			   commits_nr);
+			   commits_nr,
+			   opts.additive);
 
 	return 0;
 }
diff --git a/commit-graph.c b/commit-graph.c
index 9f1ba9bff6..6348bab82b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -533,7 +533,8 @@ void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
 			const char **commit_hex,
-			int nr_commits)
+			int nr_commits,
+			int additive)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -551,10 +552,24 @@ void write_commit_graph(const char *obj_dir,
 	oids.nr = 0;
 	oids.alloc = approximate_object_count() / 4;
 
+	if (additive) {
+		prepare_commit_graph_one(obj_dir);
+		if (commit_graph)
+			oids.alloc += commit_graph->num_commits;
+	}
+
 	if (oids.alloc < 1024)
 		oids.alloc = 1024;
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
+	if (additive && commit_graph) {
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
index 4c70281e70..c10e436413 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -40,7 +40,8 @@ void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
 			const char **commit_hex,
-			int nr_commits);
+			int nr_commits,
+			int additive);
 
 #endif
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 15b50b6282..e3f1351e39 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -190,6 +190,16 @@ test_expect_success 'build graph from commits with closure' '
 graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'graph from commits, commit 8 vs merge 2' full commits/8 merge/2
 
+test_expect_success 'build graph from commits additively' '
+        cd "$TRASH_DIRECTORY/full" &&
+	git rev-parse merge/3 | git commit-graph write --stdin-commits --additive &&
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "10" "large_edges"
+'
+
+graph_git_behavior 'additive graph, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'additive graph, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
         cd "$TRASH_DIRECTORY" &&
 	git clone --bare --no-local full bare &&
-- 
2.14.1

