Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5FD20281
	for <e@80x24.org>; Thu,  2 Nov 2017 19:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934376AbdKBTmC (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 15:42:02 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:51787 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934365AbdKBTmA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 15:42:00 -0400
Received: by mail-io0-f196.google.com with SMTP id b186so1466874iof.8
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 12:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/Fk6BnUQrnIF+1wvcn2d9XY7RxyKpW07hVGH3hWLM4=;
        b=faApPJ/qner74Yt9mMyIl9sKm1DM0IUbwBeK0fxGCNPhxQMvkv6YZhgeIDHitUQs41
         7+0mJYR7P7HAgGgrecGgKmxlpjAU9ShafY3avtFYf6cxmYWfSIIx3q8Cl7zvgMJnu6AX
         6eHLbK5Nxy3t9wkOJnlDBnq86n1Yhwk0hsx+S/KM+a5kls9v9JZhIyiSKLm74wotKFvv
         l8V1HBXNTnx8gY0L9HLzSuDSyx1mjykwa73S86fm5F11Gl5bnJ6/vGsxBTsgXk1umgBe
         KNHYW3DR3ZbeZ0CPDQjjXJuuXtmL1zhrYTs3qbih8zzga3mJzzxMd+jcPho6YUgu9ivy
         J/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/Fk6BnUQrnIF+1wvcn2d9XY7RxyKpW07hVGH3hWLM4=;
        b=X0pEkhMbQ9mcvHJr9kWaBb9drHMkT4k/pyaNwZHYTvW7/zPwhRA3bONpSl/c5CWVqT
         rg91Ri6KHXIIDi5cn6Ej0ZHELk6VRObfOznyBhwdHr637WwX5bM15BbLjfABHyPD6kSw
         aOdYOkiSAMFgWZ/Hs2Ibt4aVaMMgL+UG3dAkAKvsU1y4um811w0ciqVsIfnlttk9Povk
         S8QrBvIfkWkoiFvqvPkpBaa9zkFd8Gj6lvcT+UnqVYrQ2DfsxuxaE6X6k3qvLrMlYeuw
         cDCxiZItBqp3PdMfVk/Rmd00uVXrv891TQRIDPiHYQq78IIrOPjaywoQUR5sOJhHEKfA
         snEg==
X-Gm-Message-State: AJaThX7+s24PrTZkLy5Y7Si2zUp0U+Z3jQGZTDI9uAxTOy3odAeeBPn9
        5JXoWwEbClQWMx2JniGrIvGo+Q==
X-Google-Smtp-Source: ABhQp+S/87eHWWMyHLzD3+gHu3BdaeYIvBPkUxp9O6nMaDCeKk7b4g7jMSIQy3dyuXpZEc3uyT28jw==
X-Received: by 10.107.142.131 with SMTP id q125mr6073720iod.71.1509651719169;
        Thu, 02 Nov 2017 12:41:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1093:e9fc:3ec5:201d])
        by smtp.gmail.com with ESMTPSA id e34sm1865550ioj.83.2017.11.02.12.41.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Nov 2017 12:41:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, schwab@linux-m68k.org
Subject: [PATCHv3 2/7] list-objects.c: factor out traverse_trees_and_blobs
Date:   Thu,  2 Nov 2017 12:41:43 -0700
Message-Id: <20171102194148.2124-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.7.g980e40477f
In-Reply-To: <20171102194148.2124-1-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com>
 <20171102194148.2124-1-sbeller@google.com>
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
2.15.0.7.g980e40477f

