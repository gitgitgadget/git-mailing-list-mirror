Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E0E1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbeDJM5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:57:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46098 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbeDJM5h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:57:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id h69so8232017pfe.13
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OGsV381hmKh5fH21NP8y9ipY3S1JPayoBgtJnUmRe4w=;
        b=j8BbuozI5EDGb6wQmt+TwHPWS+zRnmhYCIJRKGer0XKlqqXloVB7g6kwPg8noDb0CS
         aAopEfo8ztL5qeYhCsXRRk7TENAWDCe9oaqIXGCv+BdY+rVDZpwv6/tkgRuk2dic6R59
         PwiEgADwbakhfzDGemAWI9RMTgymdn7KWTe0en90oa/1loYhA6QlSaoWWFLmTvVrYLrW
         MqZzCvC5fymBRbIh9sqZqVJk/L0rv4LdFOnKrMSDTEzmulpiuqBQF7OtUfKGez5kf/ip
         FIyhKG3NVwPUQgis5/QwK+XwVIYzoiRHcBNW4UpKzheuZKnwm2T3HUTWC0ZC/v5vpKBq
         5d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OGsV381hmKh5fH21NP8y9ipY3S1JPayoBgtJnUmRe4w=;
        b=GD23HeD4s/QFmSXfod/o5YKg7wOwrcclABIN36G/M7ASTxoV+BF2rUZfSCTOQaZZKr
         nKv7BHhXLfb2fJywPeXKxpaSRERQ49R+GFqyqRP2cZ7JTzABhr1VYn+4anRt8dVzTD/R
         I+eRU2Z/gPw9zyu4Tnx81b81QSpfUsp1rBHBRGa+GodON1RpxnAXckNDcg92EXpiV3V+
         4F09U4bdCEYOjC6UOHmnuk9/AnkAmlo2EJOgAYVR39GH2KdOa+4xE++e/biKQ3Ne2xiw
         dpFA7CKdQgcincivHoM7lrnKe6HlTi2xOral2qE4Yl/q8WcN0PhLRdvlqgm5GPqKmOfG
         Mu4A==
X-Gm-Message-State: ALQs6tD4i1R345fsmm3QE1rdzGUZpZo0+125eIjZITGgtOa1RkC/Fln8
        dPFjqbU16nXUkjco8Fl9Ske76lTkc5g=
X-Google-Smtp-Source: AIpwx48uXnz5W5lS8t3G5sj8Myfs8Yi7FXsKKGc6n+jG5yONP4pLhC1Dc2Gy8prm63v1z8M2hpkv/A==
X-Received: by 10.98.68.135 with SMTP id m7mr260728pfi.57.1523365056554;
        Tue, 10 Apr 2018 05:57:36 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id l10sm4421666pgp.35.2018.04.10.05.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 05:57:35 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v8 14/14] commit-graph: implement "--append" option
Date:   Tue, 10 Apr 2018 08:56:08 -0400
Message-Id: <20180410125608.39443-15-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410125608.39443-1-dstolee@microsoft.com>
References: <20180402203427.170177-1-dstolee@microsoft.com>
 <20180410125608.39443-1-dstolee@microsoft.com>
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
index b5c0b08905..37420ae0fd 100644
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
index a59d1e387b..3ff8c84c0e 100644
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
2.17.0

