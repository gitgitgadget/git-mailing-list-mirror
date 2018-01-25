Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0650F1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeAYOC4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:02:56 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34327 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeAYOCx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:53 -0500
Received: by mail-qt0-f193.google.com with SMTP id a27so19432636qtd.1
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TwIixHcfGxgbYjM2KEpz75CoMTeBdWafOnFfqp/BkK0=;
        b=tvzmhRfV1WGohctLQtgyq/Z0s2/VaBH1M00zs5GEiII/n+rZem0HX8+oLO5cGXsHKT
         1P434Q1UKt/sy1roQyx8Pk/ukLucSM2gTSWNu8BC3Hy32A9dURNLFuyRcas67wMb74iF
         Wf/RvA0h4mCw1lef+2wwvOciNm3gBBCQDhky/v/zKux3wt7IHSBWH3laavBuCRZtCuKq
         0olVvfOXPTmtVUZAei7EbQqsK61OkJiUDg2TZ1MwwP1M9s+EFQTqaf41e/2TjUpQpwKs
         RpqLGNPbszCzdDoJ2C2i2i8ibTnV7fOxwFxqNsrpxK9jpEwy9D+KvnQpjJuBBH9aroJd
         +pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TwIixHcfGxgbYjM2KEpz75CoMTeBdWafOnFfqp/BkK0=;
        b=ZZ4Smg2xqN9KurRuEMwwEPonn0C2gWoREBfwr8RtxYOTuXkqLyDJEYcV4wkjkQ8JCq
         4Lvn8oGZdDUC9SvtYFxPwhgBsFRFq+VMq0/xPgAaE78zb0o4yiCtmWFHMoJQBp2nYRln
         OW1Eb+UDDqTDJeqx0sbXG7wYS0ElQa/h+l/gOgAPZUnnPjhF/3vGK0qtJNbg/wkUSGut
         ecsnwKV320s77lDQUtaIdnCJzf9Layp85vxE2+femRD0W6K5BFF9GejLkbzJeV/R6Gfy
         S+fccN0QpRw6f7H/L2tMJjZYKK7/3/4de4HQaY7LeJHorCs0QFHu3aSpU/xtV+VXH6a5
         sdcw==
X-Gm-Message-State: AKwxytdA149jA+nUz8p/isWPHAB4N6LJ+tV3L8JFRHSRCVO8j01/vKma
        B1aybvU/bzfc73FknroDRyl4IFly
X-Google-Smtp-Source: AH8x225YOvJMXGWDY9xJYgdD7HKWHqJ1W3XSDjoy5z0xbsoEnQkCzSFpKT+TxwlO48Bx5oIQirbEvw==
X-Received: by 10.200.46.139 with SMTP id h11mr16113298qta.111.1516888972890;
        Thu, 25 Jan 2018 06:02:52 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:52 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 10/14] packed-graph: teach git-graph --delete-expired
Date:   Thu, 25 Jan 2018 09:02:27 -0500
Message-Id: <20180125140231.65604-11-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-graph to delete the graph previously referenced by 'graph_head'
when writing a new graph file and updating 'graph_head'. This prevents
data creep by storing a list of useless graphs. Be careful to not delete
the graph if the file did not change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-graph.txt |  8 ++++++--
 builtin/graph.c             | 14 +++++++++++++-
 t/t5319-graph.sh            | 37 +++++++++++++++++++++++++++++++++++--
 3 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-graph.txt b/Documentation/git-graph.txt
index f690699570..f4f1048d28 100644
--- a/Documentation/git-graph.txt
+++ b/Documentation/git-graph.txt
@@ -39,6 +39,10 @@ OPTIONS
 	When used with --write, update the graph-head file to point to
 	the written graph file.
 
+--delete-expired::
+	When used with --write and --update-head, delete the graph file
+	previously referenced by graph-head.
+
 EXAMPLES
 --------
 
@@ -55,10 +59,10 @@ $ git graph --write
 ------------------------------------------------
 
 * Write a graph file for the packed commits in your local .git folder,
-* and update graph-head.
+* update graph-head, and delete the old graph-<oid>.graph file.
 +
 ------------------------------------------------
-$ git graph --write --update-head
+$ git graph --write --update-head --delete-expired
 ------------------------------------------------
 
 * Read basic information from a graph file.
diff --git a/builtin/graph.c b/builtin/graph.c
index ac15febc46..adf779b601 100644
--- a/builtin/graph.c
+++ b/builtin/graph.c
@@ -12,7 +12,7 @@ static char const * const builtin_graph_usage[] ={
 	N_("git graph [--pack-dir <packdir>]"),
 	N_("git graph --clear [--pack-dir <packdir>]"),
 	N_("git graph --read [--graph-id=<oid>]"),
-	N_("git graph --write [--pack-dir <packdir>] [--update-head]"),
+	N_("git graph --write [--pack-dir <packdir>] [--update-head] [--delete-expired]"),
 	NULL
 };
 
@@ -23,6 +23,7 @@ static struct opts_graph {
 	const char *graph_id;
 	int write;
 	int update_head;
+	int delete_expired;
 	int has_existing;
 	struct object_id old_graph_oid;
 } opts;
@@ -120,6 +121,15 @@ static int graph_write(void)
 	if (graph_id)
 		printf("%s\n", oid_to_hex(graph_id));
 
+	if (opts.delete_expired && opts.update_head && opts.has_existing &&
+	    oidcmp(graph_id, &opts.old_graph_oid)) {
+		char *old_path = get_graph_filename_oid(opts.pack_dir, &opts.old_graph_oid);
+		if (remove_path(old_path))
+			die("failed to remove path %s", old_path);
+
+		free(old_path);
+	}
+
 	free(graph_id);
 	return 0;
 }
@@ -138,6 +148,8 @@ int cmd_graph(int argc, const char **argv, const char *prefix)
 			N_("write graph file")),
 		OPT_BOOL('u', "update-head", &opts.update_head,
 			N_("update graph-head to written graph file")),
+		OPT_BOOL('d', "delete-expired", &opts.delete_expired,
+			N_("delete expired head graph file")),
 		{ OPTION_STRING, 'M', "graph-id", &opts.graph_id,
 			N_("oid"),
 			N_("An OID for a specific graph file in the pack-dir."),
diff --git a/t/t5319-graph.sh b/t/t5319-graph.sh
index 311fb9dd67..a70c7bbb02 100755
--- a/t/t5319-graph.sh
+++ b/t/t5319-graph.sh
@@ -80,9 +80,42 @@ test_expect_success 'write graph with merges' \
      _graph_read_expect "18" "${packdir}" &&
      cmp expect output'
 
+test_expect_success 'Add more commits' \
+    'git reset --hard commits/3 &&
+     for i in $(test_seq 16 20)
+     do
+        git commit --allow-empty -m "commit $i" &&
+        git branch commits/$i
+     done &&
+     git repack'
+
+test_expect_success 'write graph with merges' \
+    'graph3=$(git graph --write --update-head --delete-expired) &&
+     test_path_is_file ${packdir}/graph-${graph3}.graph &&
+     test_path_is_missing ${packdir}/graph-${graph2}.graph &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     test_path_is_file ${packdir}/graph-head &&
+     echo ${graph3} >expect &&
+     cmp -n 40 expect ${packdir}/graph-head &&
+     git graph --read --graph-id=${graph3} >output &&
+     _graph_read_expect "23" "${packdir}" &&
+     cmp expect output'
+
+test_expect_success 'write graph with nothing new' \
+    'graph4=$(git graph --write --update-head --delete-expired) &&
+     test_path_is_file ${packdir}/graph-${graph4}.graph &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     test_path_is_file ${packdir}/graph-head &&
+     echo ${graph4} >expect &&
+     cmp -n 40 expect ${packdir}/graph-head &&
+     git graph --read --graph-id=${graph4} >output &&
+     _graph_read_expect "23" "${packdir}" &&
+     cmp expect output'
+
 test_expect_success 'clear graph' \
     'git graph --clear &&
-     test_path_is_missing ${packdir}/graph-${graph2}.graph &&
+     test_path_is_missing ${packdir}/graph-${graph3}.graph &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
      test_path_is_missing ${packdir}/graph-head'
 
 test_expect_success 'setup bare repo' \
@@ -100,7 +133,7 @@ test_expect_success 'write graph in bare repo' \
      echo ${graphbare} >expect &&
      cmp -n 40 expect ${baredir}/graph-head &&
      git graph --read --graph-id=${graphbare} >output &&
-     _graph_read_expect "18" "${baredir}" &&
+     _graph_read_expect "23" "${baredir}" &&
      cmp expect output'
 
 test_done
-- 
2.16.0

