Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C295D20437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbdJaVS6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:18:58 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45391 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdJaVS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:18:57 -0400
Received: by mail-io0-f195.google.com with SMTP id i38so1918222iod.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rl/K++N7Zpy/sEvM3wUz3EsIz1oWyOSOVIJb1w/Nvps=;
        b=jivgwz31Zryoj2rBeiRw7PycULdVLVE37/+Y4ZT5mb7SaKBHYDnLWXZda8Mzkj5joz
         j+Ows2Af1LCoQeqIMl96GTrGs8vtr8QQPHo20egiRT6BDOFu+sVvyVpqdHWfkFKJO0Dp
         zkuzr+SkERhk8LPjJ8LS1K+MX79Mej89pLYAxth0mWyXaE14TmW0w/fiOPC24dVfcuHy
         m9YVjv47BMVvKnW0S35vGxJxE7+RInr+dDjxKl63BvvMLdzDaQ25DUVWl4Mh3LVBPg5Z
         GJJafrvpb2UDLt+hQ8HzAJ9Vx+zO5HXbnUMOwrs/FI/LURTxPYvNbidzjJX13NgbAgfL
         wyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rl/K++N7Zpy/sEvM3wUz3EsIz1oWyOSOVIJb1w/Nvps=;
        b=iaedfyyxo7X3ffdYkq4Ul98R+VqPbJ3vJt4J3L4hdXzkxOdFzeGvUVdTw7B5fI9yrk
         Gd2UpAcY3udRWoM2xmTEBKC98Sqp0whEbrw45/yBj9qg8kzYn7kMUW8t0MD8ebv59Ulj
         y2j6XWFFD/KC/nA21mdV+zfBjLKfyZ9s4VrNncEFmrs0cqH4i+UlH8MolUBr5RhDTWDm
         1vffu/qwVZ/mrJ7lG8ct1GKpfWQAG4iSofUZnBL9Sk7bq5PuQkCPm/9jiOVpYRhdT+FO
         NOYEIJ5IY/kRQFhzymahIoLTU54kT5+5cWHVqZFiriPYiwhMQoJPt3pMmVwi+fNPGwBn
         PQ3g==
X-Gm-Message-State: AMCzsaU5XLM3vaLNt4n/Wrr3JZd1lr+nZe8ypIbuAGCV9o8bGH5hlSrz
        blOHE0IrcpZ0HYbSKSbw//122A==
X-Google-Smtp-Source: ABhQp+QtR5KCGIh5+PggPTOF0VXd9cqpnT6S1ZRHRI1KcFDZl9tiF0v3tI2PflS4IFGIhGWuqa0Txw==
X-Received: by 10.36.203.194 with SMTP id u185mr4898988itg.120.1509484736018;
        Tue, 31 Oct 2017 14:18:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:55a5:57f1:5248:2d32])
        by smtp.gmail.com with ESMTPSA id e81sm1098344ioi.15.2017.10.31.14.18.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 14:18:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: [PATCHv2 1/7] list-objects.c: factor out traverse_trees_and_blobs
Date:   Tue, 31 Oct 2017 14:18:46 -0700
Message-Id: <20171031211852.13001-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031211852.13001-1-sbeller@google.com>
References: <20171031003351.22341-1-sbeller@google.com>
 <20171031211852.13001-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With traverse_trees_and_blobs factored out of the main traverse function,
the next patch can introduce an in-order revision walking with ease.

In the next patch we'll call `traverse_trees_and_blobs` from within the
loop walking the commits, such that we'll have one invocation of that
function per commit.  That is why we do not want to have memory allocations
in that function, such as we'd have if we were to use a strbuf locally.
Pass a strbuf from traverse_commit_list into the blob and tree traversing
function as a scratch pad that only needs to be allocated once.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 list-objects.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index b3931fa434..ef9dbe8f92 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -183,25 +183,15 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
 
-void traverse_commit_list(struct rev_info *revs,
-			  show_commit_fn show_commit,
-			  show_object_fn show_object,
-			  void *data)
+static void traverse_trees_and_blobs(struct rev_info *revs,
+				     struct strbuf *base_path,
+				     show_object_fn show_object,
+				     void *data)
 {
 	int i;
-	struct commit *commit;
-	struct strbuf base;
 
-	strbuf_init(&base, PATH_MAX);
-	while ((commit = get_revision(revs)) != NULL) {
-		/*
-		 * an uninteresting boundary commit may not have its tree
-		 * parsed yet, but we are not going to show them anyway
-		 */
-		if (commit->tree)
-			add_pending_tree(revs, commit->tree);
-		show_commit(commit, data);
-	}
+	assert(base_path->len == 0);
+
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
 		struct object *obj = pending->item;
@@ -218,17 +208,39 @@ void traverse_commit_list(struct rev_info *revs,
 			path = "";
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     &base, path, data);
+				     base_path, path, data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
-				     &base, path, data);
+				     base_path, path, data);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
 		    oid_to_hex(&obj->oid), name);
 	}
 	object_array_clear(&revs->pending);
-	strbuf_release(&base);
+}
+
+void traverse_commit_list(struct rev_info *revs,
+			  show_commit_fn show_commit,
+			  show_object_fn show_object,
+			  void *data)
+{
+	struct commit *commit;
+	struct strbuf csp; /* callee's scratch pad */
+	strbuf_init(&csp, PATH_MAX);
+
+	while ((commit = get_revision(revs)) != NULL) {
+		/*
+		 * an uninteresting boundary commit may not have its tree
+		 * parsed yet, but we are not going to show them anyway
+		 */
+		if (commit->tree)
+			add_pending_tree(revs, commit->tree);
+		show_commit(commit, data);
+	}
+	traverse_trees_and_blobs(revs, &csp, show_object, data);
+
+	strbuf_release(&csp);
 }
-- 
2.15.0.rc2.443.gfcc3b81c0a

