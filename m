Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF5C1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeA3Vk2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:40:28 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39565 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeA3VkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:40:25 -0500
Received: by mail-qk0-f193.google.com with SMTP id n129so1375480qke.6
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AzU+p3OEA2j6gcNmhNeCupq+wdie++WeBTULNfPj3ng=;
        b=AUy3h1tpIoxNG0cu1/5kKzmNy2M9ZcMTuTBD+hwIX1kElWmzfVHM0W/GimlQ50qvze
         xC5jiKGUslZSp1RqTvfiUTHaa5jA5Etzil8kzMi11FXM5eGo8XtWOPTpnqXKVEfzgoaM
         2BpPWZGCGA/eBnG04/oPA7LzG1Jv4eu+ShInKDN+LShm1EjRpXeC0vDwOd8IltbW/l7m
         qsckWahaOk/UmS+9e3M2RRY7CqFIo8U8rrdm/Aj7Kr2ARZt8FnwywCsnn2ZqTdS3Hx3A
         K46Gg6L2a47FEfN3dwmOsIVlIikbrY7pcc3TcfsptvTJLKtIv+Dv7V9GJiLxOPlPdgUG
         iJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AzU+p3OEA2j6gcNmhNeCupq+wdie++WeBTULNfPj3ng=;
        b=lS/Xwhy3+b5p2LObfOWFXMHxoOjAhhwFofJFAC4+qZJQ4ZDUt3OIVR7m4IesPhison
         NTfv4NrfjdVFmBr6QKmLYfpPZSgsjE9Ghqf9aTRgb5t+oo0I3blJOpN/DmxoBteciqkv
         6Qo36Axm1u1OOIlGyW+byaGFZBWjT0HMt8mXj1ldci7ri2EoXsl6Y1daBQmpjz2mBGGY
         EItjJaGRFFqAXVMpm+8Cr303ybtwl8vMrg0TWhSIzcQI4qcPbo3ETTPmfWGcy2a0twts
         lVuj6HKGQUGnXr++a0ntfoXQc9m/xczJbFQp7cplTLYcWdWcpV8wuZlKXnTUWVa13VfS
         w0QA==
X-Gm-Message-State: AKwxytecPT6EY8CbsZgwORvs4gL4OdR7JjFi/DdIwjKPtegHpZdqlHIB
        ASfJtsDEJQBExwyIlE6DAufN+wbI
X-Google-Smtp-Source: AH8x226bwrVzX9p7R+uynPSqEeXo2pH/aj0jf6IWMoLtaog7okkEwZro8sfNZ5J4YKmJJpDtCUIPKQ==
X-Received: by 10.55.166.206 with SMTP id p197mr44383724qke.128.1517348424077;
        Tue, 30 Jan 2018 13:40:24 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id x79sm11725193qkg.38.2018.01.30.13.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 13:40:23 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH v2 13/14] commit-graph: close under reachability
Date:   Tue, 30 Jan 2018 16:39:42 -0500
Message-Id: <1517348383-112294-14-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach construct_commit_graph() to walk all parents from the commits
discovered in packfiles. This prevents gaps given by loose objects or
previously-missed packfiles.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 26 ++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 14 ++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index e5a1d9ee8b..cfa0415a21 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -5,6 +5,7 @@
 #include "packfile.h"
 #include "commit.h"
 #include "object.h"
+#include "revision.h"
 #include "commit-graph.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
@@ -638,6 +639,29 @@ static int if_packed_commit_add_to_list(const struct object_id *oid,
 	return 0;
 }
 
+static void close_reachable(struct packed_oid_list *oids)
+{
+	int i;
+	struct rev_info revs;
+	struct commit *commit;
+	init_revisions(&revs, NULL);
+
+	for (i = 0; i < oids->num; i++) {
+		commit = lookup_commit(oids->list[i]);
+		if (commit && !parse_commit(commit))
+			revs.commits = commit_list_insert(commit, &revs.commits);
+	}
+
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+
+	while ((commit = get_revision(&revs)) != NULL) {
+		ALLOC_GROW(oids->list, oids->num + 1, oids->size);
+		oids->list[oids->num] = &(commit->object.oid);
+		(oids->num)++;
+	}
+}
+
 struct object_id *construct_commit_graph(const char *pack_dir,
 					 char **pack_indexes,
 					 int nr_packs)
@@ -696,6 +720,8 @@ struct object_id *construct_commit_graph(const char *pack_dir,
 	} else {
 		for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
 	}
+
+	close_reachable(&oids);
 	QSORT(oids.list, oids.num, commit_compare);
 
 	count_distinct = 1;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index b9a73f398c..2001b0b5b5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -213,6 +213,20 @@ test_expect_success 'clear graph' \
 _graph_git_behavior commits/20 merge/1
 _graph_git_behavior commits/20 merge/2
 
+test_expect_success 'build graph from latest pack with closure' \
+    'graph5=$(cat new-idx | git commit-graph --write --update-head --stdin-packs) &&
+     test_path_is_file ${packdir}/graph-${graph5}.graph &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     test_path_is_file ${packdir}/graph-head &&
+     echo ${graph5} >expect &&
+     cmp -n 40 expect ${packdir}/graph-head &&
+     git commit-graph --read --graph-hash=${graph5} >output &&
+     _graph_read_expect "21" "${packdir}" &&
+     cmp expect output'
+
+_graph_git_behavior commits/20 merge/1
+_graph_git_behavior commits/20 merge/2
+
 test_expect_success 'setup bare repo' \
     'cd .. &&
      git clone --bare full bare &&
-- 
2.16.0.15.g9c3cf44.dirty

