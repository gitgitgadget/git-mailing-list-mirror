Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA951F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeB0Cdc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:32 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38719 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbeB0Cd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:29 -0500
Received: by mail-qk0-f194.google.com with SMTP id s198so21725308qke.5
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZrHjBZrRU3YHjoVTpAVgbriVPhMZGdNZnIQ88RgoNao=;
        b=uUnZfoGV4/krslYNEaSDQV8o0LoneKZgOFjBU1FNTyJwbpgGBqPXJujpTOoh3O0z/N
         8XsRcZcuRpXN5kT+BxTJggpt1Rgu/rZmNk1+tt6iFMfNqiGJ8a8qio1KBSV03wAbzM/d
         XIfhv52nn0AcgJ3e21F+KCN2UzZHW15I/h0c6Kmp+sAnYJTKhb86q01UWrKriUzu7LXi
         TqkwZMx5P/UbkaXhLoYn0pnLCjC3F5AaJRoqrIsxyQKUHOBdtc+QFYhOH2oc7xA6bXkr
         bmhzPZSNTTVD10f28iZ+JwFLLq0ETi6BaneotBc2WfT7P/IP37DkpnXmQq3k7Ai3E9jQ
         qY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZrHjBZrRU3YHjoVTpAVgbriVPhMZGdNZnIQ88RgoNao=;
        b=Nwt/JbQorBjDXyemP8HvnJ8yhOYzrPD8t858cpa/vmCxg0Gz5972IHfJJiEY/6bDfr
         YC8eFzrp7JV1hnOIeIEeRAqMivsLdJkeLIeZYa8HFIb1eB3q2rnLHitri4Fr6MwDVnYp
         gXsBxVEhnfUoliG6INoBzneu0pmEBLduZ0Z2NxLO6ju712AbGb24lUoLP6XMu4etkgNB
         dyn8k1CwwGrvDC8kJZC3iW2Jl5LMwmc0wsQuDQIhDjuiy6WmlTnzWR+EdiD1XALjKDlY
         gy2pmdt7R+3W46mGBbvD/5QQlayDs/FTHsqpDv2qaTqkZyMNFqZAe8J80R3zDi1iyQ9K
         TTnA==
X-Gm-Message-State: APf1xPCqxHdkkGiADEGxa8H3qKd8jGR2UGpQhhupTACLwEYtp4W+ZE3m
        /1cOYzRFjqDDeGPyPe3QzjfVKsUxxis=
X-Google-Smtp-Source: AG47ELsmc13LNloaAqMulLucgdlbKuIEB6EuV66J8/e5SyoG102A/ri/gGNmpkpLHY78LGerw39Ocg==
X-Received: by 10.55.191.1 with SMTP id p1mr20549377qkf.97.1519698808662;
        Mon, 26 Feb 2018 18:33:28 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:28 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 13/13] commit-graph: implement "--additive" option
Date:   Mon, 26 Feb 2018 21:33:07 -0500
Message-Id: <1519698787-190494-14-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 0710a68..ccf5e20 100644
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
index 1c7b7e7..d26a6d6 100644
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
index dbb9801..c111717 100644
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
@@ -552,10 +553,24 @@ void write_commit_graph(const char *obj_dir,
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
index 4c70281..c10e436 100644
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
index 9589238..518eb92 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -190,6 +190,16 @@ test_expect_success 'build graph from commits with closure' '
 graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'graph from commits, commit 8 vs merge 2' full commits/8 merge/2
 
+test_expect_success 'build graph from commits additively' '
+	cd "$TRASH_DIRECTORY/full" &&
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
2.7.4

