Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F771F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeBSSyC (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:54:02 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42799 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbeBSSxk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:53:40 -0500
Received: by mail-qt0-f195.google.com with SMTP id k25so13438704qtj.9
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ukyX5KlKzCtIEi1wrUAQ5PXUKY5z4eDNImiHLjJGEkE=;
        b=AqgqXhr8ZI1cjg2EeQrVzfJENuZ7Rn1m7/xX298qJVMHCclPiNVLtkY/pZqfjxjRR5
         sgCTsx3uYEbdyW3WYiDfpWvpT12Jkol3XDc3lWHHL+kfDzpM39TuHCaJAVvuB2LDmNId
         vyWanVHCZiJoLsHHctlzDkqLEqnfVu2ahAufMZTRJdoQ/9cRdaHv6guRlpZc5gLl5N09
         7SeDPsX15ZEHTorCCiJ+NnzKNdJvBFDglngmJT6p9nh1aCq7aGayiAFe2aXK7x6RifgN
         S6wRnwiZdny19kObM/ZPDTcK3E7EO/0/PuISZva0GdzpIwk3Te14o9P7PAnKICV8+5FH
         7EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ukyX5KlKzCtIEi1wrUAQ5PXUKY5z4eDNImiHLjJGEkE=;
        b=W12ILIjYJ/ecHYUefSmKrb8pD02oqBQqGh4RtX4e7OaJ/WRIdtjM0ArtNMX7ll54i5
         OC8vvHg69y52cvhloMX1WN9vDrGc5+jBonUkFzBkIDt3UCoWyzlYrb/eOUsHuRR+krze
         5XFZbIFWNNfOXTvfwv+iDVGh5IDNMSV6IOgZCRfo+g+I9G2XqYAkP3bzmhn65D0l8A9m
         IV8z8DRXWdoHCNjWxRGiwtl48Toqak1Zyt1XaGAx6NFfz/1o9Z13baj1IIFwJK8uoW+S
         9ZkdVDh6SJrFlExALIEXwEthXCo2LNocMs9eZYp5tAMu0mrjpnQekr/RUPttrf1JqC6N
         xpNw==
X-Gm-Message-State: APf1xPD4EWUpYhOQ+gMNG5HGlqyJOT+t0SEa5Mv3RKj6xO4j9lszMO8f
        YL5TNIXxEJYMtJ1Ltf1VsHXP30EPI5s=
X-Google-Smtp-Source: AH8x225D+N36HEJhSogHi8ziz2yBzHmo+I6LZxWdBkrsrQvG22LOjwVyl9Pbv/Stjs1J/Kp2mfUDqw==
X-Received: by 10.200.28.84 with SMTP id j20mr25317876qtk.188.1519066419855;
        Mon, 19 Feb 2018 10:53:39 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id o12sm1672631qke.81.2018.02.19.10.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Feb 2018 10:53:39 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     peff@peff.net, jonathantanmy@google.com, szeder.dev@gmail.com,
        sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 07/13] commit-graph: implement --set-latest
Date:   Mon, 19 Feb 2018 13:53:20 -0500
Message-Id: <1519066406-81663-8-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to have multiple commit graph files in a directory, but
only one is important at a time.

Use a 'graph-latest' file to point to the important file. Teach
git-commit-graph to write 'graph-latest' when given the "--set-latest"
option. Using this 'graph-latest' file is more robust than relying on
directory scanning and modified times.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 10 ++++++++++
 builtin/commit-graph.c             | 26 ++++++++++++++++++++++++--
 commit-graph.c                     |  7 +++++++
 commit-graph.h                     |  2 ++
 t/t5318-commit-graph.sh            | 24 +++++++++++++++++++-----
 5 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 6d26e56..dc948c5 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -34,6 +34,9 @@ COMMANDS
 Write a commit graph file based on the commits found in packfiles.
 Includes all commits from the existing commit graph file. Outputs the
 resulting filename.
++
+With `--set-latest` option, update the graph-latest file to point
+to the written graph file.
 
 'read'::
 
@@ -53,6 +56,13 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
+* Write a graph file for the packed commits in your local .git folder
+* and update graph-latest.
++
+------------------------------------------------
+$ git commit-graph write --set-latest
+------------------------------------------------
+
 * Read basic information from a graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 28cd097..bf86172 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>] [--file=<hash>]"),
-	N_("git commit-graph write [--object-dir <objdir>]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--set-latest]"),
 	NULL
 };
 
@@ -18,13 +18,14 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--set-latest]"),
 	NULL
 };
 
 static struct opts_commit_graph {
 	const char *obj_dir;
 	const char *graph_file;
+	int set_latest;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -81,6 +82,22 @@ static int graph_read(int argc, const char **argv)
 	return 0;
 }
 
+static void set_latest_file(const char *obj_dir, const char *graph_file)
+{
+	int fd;
+	struct lock_file lk = LOCK_INIT;
+	char *latest_fname = get_graph_latest_filename(obj_dir);
+
+	fd = hold_lock_file_for_update(&lk, latest_fname, LOCK_DIE_ON_ERROR);
+	FREE_AND_NULL(latest_fname);
+
+	if (fd < 0)
+		die_errno("unable to open graph-head");
+
+	write_in_full(fd, graph_file, strlen(graph_file));
+	commit_lock_file(&lk);
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	char *graph_name;
@@ -89,6 +106,8 @@ static int graph_write(int argc, const char **argv)
 		{ OPTION_STRING, 'o', "object-dir", &opts.obj_dir,
 			N_("dir"),
 			N_("The object directory to store the graph") },
+		OPT_BOOL('u', "set-latest", &opts.set_latest,
+			N_("update graph-head to written graph file")),
 		OPT_END(),
 	};
 
@@ -102,6 +121,9 @@ static int graph_write(int argc, const char **argv)
 	graph_name = write_commit_graph(opts.obj_dir);
 
 	if (graph_name) {
+		if (opts.set_latest)
+			set_latest_file(opts.obj_dir, graph_name);
+
 		printf("%s\n", graph_name);
 		FREE_AND_NULL(graph_name);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index 2a8594f..5ee0805 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -38,6 +38,13 @@
 #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + 8)
 
+char *get_graph_latest_filename(const char *obj_dir)
+{
+	struct strbuf fname = STRBUF_INIT;
+	strbuf_addf(&fname, "%s/info/graph-latest", obj_dir);
+	return strbuf_detach(&fname, 0);
+}
+
 static struct commit_graph *alloc_commit_graph(void)
 {
 	struct commit_graph *g = xmalloc(sizeof(*g));
diff --git a/commit-graph.h b/commit-graph.h
index 9093b97..ae24b3a 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -3,6 +3,8 @@
 
 #include "git-compat-util.h"
 
+extern char *get_graph_latest_filename(const char *obj_dir);
+
 struct commit_graph {
 	int graph_fd;
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 893fa24..cad9d90 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -12,7 +12,8 @@ test_expect_success 'setup full repo' '
 '
 
 test_expect_success 'write graph with no packs' '
-	git commit-graph write --object-dir .
+	git commit-graph write --object-dir . &&
+	test_path_is_missing info/graph-latest
 '
 
 test_expect_success 'create commits and repack' '
@@ -42,6 +43,7 @@ graph_read_expect() {
 test_expect_success 'write graph' '
 	graph1=$(git commit-graph write) &&
 	test_path_is_file $objdir/info/$graph1 &&
+	test_path_is_missing $objdir/info/graph-latest &&
 	git commit-graph read --file=$graph1 >output &&
 	graph_read_expect "3" &&
 	test_cmp expect output
@@ -84,8 +86,11 @@ test_expect_success 'Add more commits' '
 
 
 test_expect_success 'write graph with merges' '
-	graph2=$(git commit-graph write)&&
+	graph2=$(git commit-graph write --set-latest)&&
 	test_path_is_file $objdir/info/$graph2 &&
+	test_path_is_file $objdir/info/graph-latest &&
+	printf $graph2 >expect &&
+	test_cmp expect $objdir/info/graph-latest &&
 	git commit-graph read --file=$graph2 >output &&
 	graph_read_expect "10" "large_edges" &&
 	test_cmp expect output
@@ -112,19 +117,25 @@ test_expect_success 'Add one more commit' '
 # 1
 
 test_expect_success 'write graph with new commit' '
-	graph3=$(git commit-graph write) &&
+	graph3=$(git commit-graph write --set-latest) &&
 	test_path_is_file $objdir/info/$graph3 &&
+	test_path_is_file $objdir/info/graph-latest &&
+	printf $graph3 >expect &&
+	test_cmp expect $objdir/info/graph-latest &&
 	git commit-graph read --file=$graph3 >output &&
 	graph_read_expect "11" "large_edges" &&
 	test_cmp expect output
 '
 
 test_expect_success 'write graph with nothing new' '
-	graph4=$(git commit-graph write) &&
+	graph4=$(git commit-graph write --set-latest) &&
 	test_path_is_file $objdir/info/$graph4 &&
 	printf $graph3 >expect &&
 	printf $graph4 >output &&
 	test_cmp expect output &&
+	test_path_is_file $objdir/info/graph-latest &&
+	printf $graph4 >expect &&
+	test_cmp expect $objdir/info/graph-latest &&
 	git commit-graph read --file=$graph4 >output &&
 	graph_read_expect "11" "large_edges" &&
 	test_cmp expect output
@@ -138,8 +149,11 @@ test_expect_success 'setup bare repo' '
 '
 
 test_expect_success 'write graph in bare repo' '
-	graphbare=$(git commit-graph write) &&
+	graphbare=$(git commit-graph write --set-latest) &&
 	test_path_is_file $baredir/info/$graphbare &&
+	test_path_is_file $baredir/info/graph-latest &&
+	printf $graphbare >expect &&
+	test_cmp expect $baredir/info/graph-latest &&
 	git commit-graph read --file=$graphbare >output &&
 	graph_read_expect "11" "large_edges" &&
 	test_cmp expect output
-- 
2.7.4

