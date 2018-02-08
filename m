Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E99B1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeBHUiP (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:38:15 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37117 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbeBHUiI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:38:08 -0500
Received: by mail-qt0-f194.google.com with SMTP id s27so7912823qts.4
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WXpwmeZ+vBkT29sOrO+Qogf3Fi5nlt8QT/eoTHcFtL8=;
        b=LwQzJTu7k2MzeaRMOvKx7Zi7Um6Dn9UabwRa4e8cI2uExbUDD3ZaGw4tqK47KhPZvX
         nvqYEE8huy8Fuuxy3pnGOgLSyiuufs1ds3rDx4HJXUEWOaReDlaljj8bhrmawZTBpIyj
         +Wt6wV/2DZKSefc5BzSlHHbID5jYLyDQw+M782cC0S6HmMZJGG+lF+LNDk3kf48PcV4c
         Ez/zxhijfbzYtarNVNeL0JwbG+ms2OmuJFGTG8LmETjMG02n4mqKpE8PmMmwlU4KXGIm
         boMSgrlxu88PYu/tqvAazXHNwHqE8EIkfS//CcoHtDFst0kJGDibWDD8Unxv5hBhLNB1
         YNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WXpwmeZ+vBkT29sOrO+Qogf3Fi5nlt8QT/eoTHcFtL8=;
        b=je4r2nmE3GBpLrOk03rCHSNE+DLcOzdnEFmpp4OG71vMmmY0JU/UWMEuBXN251Ti+K
         MeNovP6/nsMUwYRBTXE63riDIDJY9V1gQuujV8JGz5zTFrZb26ZtmFCEoNzP1suqOMJZ
         MIPdyew3UiinuoaqPgQSiLrdnLfLHldGBvOW6y4TMJKWwSBxMKio/SM7ozgJ+xC7A4SB
         Jd1by9ECCc8yizsG5jNiloyc7fSduhINiUztPRcIJV8qAZA3VcfS+vASJAztUW/QzjZu
         po8tnzRL+xOjb2Gu5N2vbq8jmmjEDXc1M8qZ9dm+O7qTIG701whNyLj1cAcPmsLzrBAH
         zk7A==
X-Gm-Message-State: APf1xPAuWlA5EkvvaBg1YoHemgwkdxDhXXfRbaWBBDG+bGAGkpwJdL3T
        1QtGhWSuVTxidMBLS4FBSZ1r0bJIloo=
X-Google-Smtp-Source: AH8x226zEmqsiKBpRlkFMgv/ywAxfxJW3PGRSBqw91+36yENkaeXt09KYkrrTn4L8LVDs2jHaQdB2g==
X-Received: by 10.200.15.91 with SMTP id l27mr772671qtk.45.1518122287102;
        Thu, 08 Feb 2018 12:38:07 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 58sm636735qtm.51.2018.02.08.12.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 12:38:06 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 14/14] commit-graph: build graph from starting commits
Date:   Thu,  8 Feb 2018 15:37:38 -0500
Message-Id: <1518122258-157281-15-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
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
 Documentation/git-commit-graph.txt | 15 ++++++++++++++-
 builtin/commit-graph.c             | 26 +++++++++++++++++++++-----
 commit-graph.c                     | 26 ++++++++++++++++++++++++--
 commit-graph.h                     |  4 +++-
 t/t5318-commit-graph.sh            | 19 +++++++++++++++++++
 5 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 727d5d70bb..bd1c54025a 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -45,7 +45,12 @@ graph-head file if it is updated by the `--update-head` option.
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
 
@@ -83,6 +88,14 @@ $ git commit-graph write --update-head --delete-expired
 $ echo <pack-index> | git commit-graph write --update-head --delete-expired --stdin-packs
 ------------------------------------------------
 
+* Write a graph file, extending the current graph file using all
+* commits reachable from refs/heads/*, update graph-head, and delete
+* stale graph files.
++
+------------------------------------------------
+$ git show-ref --heads -s | git commit-graph write --update-head --delete-expired --stdin-commits
+------------------------------------------------
+
 * Read basic information from a graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index fe5f00551c..28d043b5a8 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,7 +9,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--pack-dir <packdir>]"),
 	N_("git commit-graph clear [--pack-dir <packdir>]"),
 	N_("git commit-graph read [--graph-hash=<hash>]"),
-	N_("git commit-graph write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs]"),
+	N_("git commit-graph write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -24,7 +24,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs]"),
+	N_("git commit-graph write [--pack-dir <packdir>] [--update-head] [--delete-expired] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -34,6 +34,7 @@ static struct opts_commit_graph {
 	int update_head;
 	int delete_expired;
 	int stdin_packs;
+	int stdin_commits;
 } opts;
 
 static int graph_clear(int argc, const char **argv)
@@ -219,6 +220,8 @@ static int graph_write(int argc, const char **argv)
 	int has_existing;
 	const char **pack_indexes = NULL;
 	int nr_packs = 0;
+	const char **commit_hex = NULL;
+	int nr_commits = 0;
 	const char **lines = NULL;
 	int nr_lines = 0;
 	int alloc_lines = 0;
@@ -233,6 +236,8 @@ static int graph_write(int argc, const char **argv)
 			N_("delete expired head graph file")),
 		OPT_BOOL('s', "stdin-packs", &opts.stdin_packs,
 			N_("only scan packfiles listed by stdin")),
+		OPT_BOOL('C', "stdin-commits", &opts.stdin_commits,
+			N_("start walk at commits listed by stdin")),
 		OPT_END(),
 	};
 
@@ -240,6 +245,9 @@ static int graph_write(int argc, const char **argv)
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
 
+	if (opts.stdin_packs && opts.stdin_commits)
+		die(_("cannot use both --stdin-commits and --stdin-packs"));
+
 	if (!opts.pack_dir) {
 		struct strbuf path = STRBUF_INIT;
 		strbuf_addstr(&path, get_object_directory());
@@ -261,13 +269,21 @@ static int graph_write(int argc, const char **argv)
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
 
 	graph_hash = write_commit_graph(opts.pack_dir,
 					pack_indexes,
-					nr_packs);
+					nr_packs,
+					commit_hex,
+					nr_commits);
 
 	if (opts.update_head)
 		update_head_file(opts.pack_dir, graph_hash);
diff --git a/commit-graph.c b/commit-graph.c
index 27a34f5eda..3ff3ab03ca 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -657,7 +657,9 @@ static void close_reachable(struct packed_oid_list *oids)
 
 struct object_id *write_commit_graph(const char *pack_dir,
 				     const char **pack_indexes,
-				     int nr_packs)
+				     int nr_packs,
+				     const char **commit_hex,
+				     int nr_commits)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -710,7 +712,27 @@ struct object_id *write_commit_graph(const char *pack_dir,
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
+				oids.list[oids.nr] = &(result->object.oid);
+				oids.nr++;
+			}
+		}
+	}
+
+	if (!pack_indexes && !commit_hex)
 		for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
 
 	close_reachable(&oids);
diff --git a/commit-graph.h b/commit-graph.h
index 918b34dd2b..c412f76707 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -52,7 +52,9 @@ extern struct object_id *get_nth_commit_oid(struct commit_graph *g,
 
 extern struct object_id *write_commit_graph(const char *pack_dir,
 					    const char **pack_indexes,
-					    int nr_packs);
+					    int nr_packs,
+					    const char **commit_hex,
+					    int nr_commits);
 
 #endif
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e3546e6844..d803c12afd 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -182,6 +182,25 @@ test_expect_success 'build graph from latest pack with closure' '
 graph_git_behavior 'graph from pack, commit 8 vs merge 1' commits/8 merge/1
 graph_git_behavior 'graph from pack, commit 8 vs merge 2' commits/8 merge/2
 
+test_expect_success 'build graph from commits with closure' '
+	git tag -a -m "merge" tag/merge merge/3 &&
+	git rev-parse tag/merge >commits-in &&
+	git rev-parse commits/8 >>commits-in &&
+	git rev-parse merge/1 >>commits-in &&
+	git rev-parse merge/2 >>commits-in &&
+	graph6=$(cat commits-in | git commit-graph write --update-head --delete-expired --stdin-commits) &&
+	test_path_is_file $packdir/graph-$graph6.graph &&
+	test_path_is_file $packdir/graph-$graph5.graph &&
+	test_path_is_file $packdir/graph-head &&
+	printf $graph6 >expect &&
+	test_cmp expect $packdir/graph-head &&
+	git commit-graph read --graph-hash=$graph6 >output &&
+	graph_read_expect "11" "$packdir" &&
+	test_cmp expect output'
+
+graph_git_behavior 'graph from commits, commit 8 vs merge 1' commits/8 merge/1
+graph_git_behavior 'graph from commits, commit 8 vs merge 2' commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd .. &&
 	git clone --bare --no-local full bare &&
-- 
2.15.1.45.g9b7079f

