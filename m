Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349C81F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbeAYODQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:03:16 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42416 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeAYOC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:57 -0500
Received: by mail-qt0-f195.google.com with SMTP id c2so19341379qtn.9
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Yr3R3Rli4fXld6LdgtDPD+HD/rliu6YiVUwoKhxRmk=;
        b=l6k28N8AU607rb9/zzgvSlsBFOJGBpcpWdZCqzm6SHO5y0uu0+wMJGonUzmojRI1hf
         ixskVZTl22P2/YjhBso4OhENWFlWw2EVGYqdHzRltRLQhBw8PVXnQ9dRtdIToAPhyMF4
         0vyvG5neXfdr748pf+vqHakVykeKHjJ9fO1o67GLDPFKLV7U51CcEoO2CcS9GaK8t76d
         vNM9FAKZW/kCWuJxJjAeHlnMpU7JAwlDf1WV2udp8hVUJdC2paC3h60CCSRSq9/ohB5F
         hdEtAT2livNzYyV5kshpCSXYpNDnyDyfu8aSoWxUud0JV1fIhmyfvvsUhnll7lfblqtD
         ggIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Yr3R3Rli4fXld6LdgtDPD+HD/rliu6YiVUwoKhxRmk=;
        b=JCManJ+tKdcd9s9lJipwSvAQbx8fsPQeXzB6iy+jKIGPbWAzh75y4oxGJ8SE+JbxCZ
         zVAUjvuG6EaxR4QveUoXgsU4SwLnddfKgICzQhHe1Sx7jOduvpzbBCb008KirN6tS9lE
         sBeNM80/KclVJk2OWtIHWq7RHqZGnO+bkHE8h+O5d9wg4e8v9cynIE6VKU5v0jUjDNFy
         KYcTEq/jXb+zOGZWwK97azEUcaUQmG2lJXumpOqre3a1RBDvqY1A9QLc/boiXXDHX6WF
         bHJUtoyrNjWXYN+gZvmMOgg1XC1UiAmFIJf/74p7sWQ0GY4lhBl8gmI9d9tUXqSgasHT
         5Jjg==
X-Gm-Message-State: AKwxytd+qRbO3bqmd7hpsn5kK0OpwID/+mpB38ZFSaznfk1GSEfIroAF
        i3zf0APEMbqBs4dSk6bfGx1qsenb
X-Google-Smtp-Source: AH8x2267NLDkEtRuHglx4T0qNopo0oAtgMHFwVDLraUCa5H547NNg0iPvjOeCMTCPinYCVoUOfjS1g==
X-Received: by 10.55.138.68 with SMTP id m65mr13843655qkd.166.1516888976735;
        Thu, 25 Jan 2018 06:02:56 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:56 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 13/14] packed-graph: close under reachability
Date:   Thu, 25 Jan 2018 09:02:30 -0500
Message-Id: <20180125140231.65604-14-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach construct_graph() to walk all parents from the commits discovered in
packfiles. This prevents gaps given by loose objects or previously-missed
packfiles.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packed-graph.c   | 26 ++++++++++++++++++++++++++
 t/t5319-graph.sh | 14 ++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/packed-graph.c b/packed-graph.c
index 0dc68a077e..c93515f18e 100644
--- a/packed-graph.c
+++ b/packed-graph.c
@@ -5,6 +5,7 @@
 #include "packfile.h"
 #include "commit.h"
 #include "object.h"
+#include "revision.h"
 #include "packed-graph.h"
 
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
 struct object_id *construct_graph(const char *pack_dir, char **pack_indexes, int nr_packs)
 {
 	// Find a list of oids, adding the pointer to a list.
@@ -698,6 +722,8 @@ struct object_id *construct_graph(const char *pack_dir, char **pack_indexes, int
 	} else {
 		for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
 	}
+
+	close_reachable(&oids);
 	QSORT(oids.list, oids.num, commit_compare);
 
 	count_distinct = 1;
diff --git a/t/t5319-graph.sh b/t/t5319-graph.sh
index 969150cd21..8bf5a0c993 100755
--- a/t/t5319-graph.sh
+++ b/t/t5319-graph.sh
@@ -212,6 +212,20 @@ test_expect_success 'clear graph' \
 _graph_git_behavior commits/20 merge/1
 _graph_git_behavior commits/20 merge/2
 
+test_expect_success 'build graph from latest pack with closure' \
+    'graph5=$(cat new-idx | git graph --write --update-head --stdin-packs) &&
+     test_path_is_file ${packdir}/graph-${graph5}.graph &&
+     test_path_is_file ${packdir}/graph-${graph1}.graph &&
+     test_path_is_file ${packdir}/graph-head &&
+     echo ${graph5} >expect &&
+     cmp -n 40 expect ${packdir}/graph-head &&
+     git graph --read --graph-id=${graph5} >output &&
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
2.16.0

