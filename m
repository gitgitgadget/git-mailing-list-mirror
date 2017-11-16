Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F2E201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 02:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933657AbdKPCA4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 21:00:56 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:45984 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758335AbdKPCAv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 21:00:51 -0500
Received: by mail-io0-f195.google.com with SMTP id z74so3646506iof.12
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 18:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wjI3kFMWbYeQQrGXrF36hWGueequSV2uO6AVl4hAWjI=;
        b=NikSwNvFN+UF+QYsS9mjZyUnkflozUZvJu0+YcWf0pkMDvh/Hew/ZKu7ediewDib+6
         BH6Ozdk2qixIZme37xwZ+tPkJWYGOqIhPBR1jihZ6vtiSrEZOKquobH3ZwsH5eT1ShE8
         laUqeDj3Z9dTCISkCCms8CZ5LCp9m6WGJuLThfE2bbz2D5j9InwsZKwxkhILEdQlu6Hj
         Pk3CTGVP4uBTZPSIgZq5euvCXtwF1DlzUwCYU04A+OKkM+PibDCY940OYAYaRpkv2DDY
         WXC1N8Qd7BWm9bm9KrW8/5dluntw8Wo66m0Wf9Ef3PmRj0ATTVMT4UXKZC5ROy3N0iTB
         Kkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wjI3kFMWbYeQQrGXrF36hWGueequSV2uO6AVl4hAWjI=;
        b=rOV0BOxDtpkfU3eWv9qZUOc8Vgnp0U37xqcnAJyoMj6ZNDi/b3q4hicrHkZsIWANlm
         txpORZWwmnjyVq3kMETnqTD0zbxco3/3OTPDSU19o+z0Ul3kBsEioeTN4KLdyDKLjfBO
         Isy/R/qMgkGAdXJKSoKMutZHPQGP2dpurKWxB7X/HA7GIbRNqtNJlAJZ4tTcSqdo7f5S
         bUDglxLeAI0YsP/jccAAN8TpNELFGBNbvX6+rkkztUo15hmsTKgqH6Q7fFIsxt9CQ1e9
         JlCchcPchNDozsousts3MLj+BrZXZ+/o8e/M2QIw+ovdauBwyU+NOMQcn9lueOeR2YQj
         PdGg==
X-Gm-Message-State: AJaThX7nANDs25B0r0RFdRjKCgvekL+w50DMgQz3aqcc88k8c5WtmUsM
        68nqL2stswV50yt3erPQhxbZfeHCk8Q=
X-Google-Smtp-Source: AGs4zMZfQpDEnIs+4C1M/tRBZzcJtEAK6cYm8+rmLpfq0LZwNJABt8hsFoZzVyZxVnbliUOpyFGfZw==
X-Received: by 10.107.201.17 with SMTP id z17mr56419iof.209.1510797650610;
        Wed, 15 Nov 2017 18:00:50 -0800 (PST)
Received: from localhost ([2620:0:100e:422:34c9:3de6:9af7:a340])
        by smtp.gmail.com with ESMTPSA id i63sm1572ioi.68.2017.11.15.18.00.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 18:00:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 2/7] list-objects.c: factor out traverse_trees_and_blobs
Date:   Wed, 15 Nov 2017 18:00:34 -0800
Message-Id: <20171116020039.17810-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171116020039.17810-1-sbeller@google.com>
References: <20171116020039.17810-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 list-objects.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index b3931fa434..7c2ce9c4bd 100644
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
+				     struct strbuf *base,
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
+	assert(base->len == 0);
+
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
 		struct object *obj = pending->item;
@@ -218,17 +208,39 @@ void traverse_commit_list(struct rev_info *revs,
 			path = "";
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     &base, path, data);
+				     base, path, data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
-				     &base, path, data);
+				     base, path, data);
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
2.15.0.128.gcadd42da22

