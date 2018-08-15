Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B557A1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 00:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeHODMs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 23:12:48 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:41048 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeHODMr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 23:12:47 -0400
Received: by mail-qk0-f202.google.com with SMTP id w8-v6so21742034qkf.8
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P/XVYMYGcUwy2zeTUhBFcI0p6ZEcn9k1dB9nuLK2AC0=;
        b=bNnkGrnXBAnqI2UVfstIAa0u3aOaIm720J2pV5ta8LEZBdMZyMBNupkRbXXaRVAmhd
         87wWso+VQaHJNR6fp4Wj5ksEaxHZ4lbPn6k76J0xAoShWwCQ9fU1/mGOTxNvOkojLGr0
         eyzB4CsulJE7iE817SejRG4MvhzKq3EuSvZvFIByh2v2crZQiDHmW8XnExPOnAPGX6Q2
         HIaxQd/iLJclzcZGmEtNjSigBdWewNyjdztxHfwqoCVfDS9saayuH8Yu7yl9cbJL2YC6
         qI5fKYxFIBn1vRNXaSDzTaW30e+9OQj7JVPzdepmXZjj+WTlg3+Lsrgx5gEjbuTiG7ri
         Y2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P/XVYMYGcUwy2zeTUhBFcI0p6ZEcn9k1dB9nuLK2AC0=;
        b=Jy+T37v7AyIIcz8ugchamF1N1QbCMHeiQkR3prc6cJAuwyauMQnRf3oexzSPM/TiD2
         ai1LF5DYaDxu37lLz/Lhx+WqpxenztaJDuqkX+Myysrc3ud2b517PhT6Q1Cel1DoE+nL
         3rOHRqIrVFpz2Vzx3IrC6fVWIF+1f0TQJVwmGpT07teN0nbJxZyp9KLCG7kvlZYtcdIH
         XP1oj/GwZ677T99CjT0GZh2Nnf8VQKb4iQGTxzroQZExQre7pl81pOE/OrvAX1GNqTJL
         sD15aztuFrHaQqAFDY0ZSMN0tdkMjyswq7B2w8oBKHY12e1MZD8W2hfR6JYZ0jCGyKzH
         x5dA==
X-Gm-Message-State: AOUpUlFVUiVlGLajRhR+FslUIUKKGM4cjBFKs4XGdYCSyjC9IjO3hpiC
        fpk44k8o/MnlRufm1dpclj2qgTViutYYWqyKbxQ38BSUfJOxLFPimkpljV+zzPEm1AFBu7gG+MZ
        LVsLOPEl+7P3X7D6RFj8PxtE1CxSyQnzfqW+jrZKn7a+11rj4JBM8oHWEQQk=
X-Google-Smtp-Source: AA+uWPwUoVaXbMErL2HRylwkj1iwrwGIbTWx7emPh4Be5YjG9oefiXfqa/z04JBWbpmW0m2q71ql0IelP34e
X-Received: by 2002:a0c:c711:: with SMTP id w17-v6mr13004301qvi.9.1534292587163;
 Tue, 14 Aug 2018 17:23:07 -0700 (PDT)
Date:   Tue, 14 Aug 2018 17:22:51 -0700
In-Reply-To: <cover.1534291033.git.matvore@google.com>
Message-Id: <feb7ea58228df4bb777ee96651389000e804f9fa.1534291033.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534291033.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v5 2/6] list-objects: refactor to process_tree_contents
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be used in a follow-up patch to reduce indentation needed when
invoking the logic conditionally. i.e. rather than:

if (foo) {
	while (...) {
		/* this is very indented */
	}
}

we will have:

if (foo)
	process_tree_contents(...);

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c | 68 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 584518a3f..ccc529e5e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -94,6 +94,46 @@ static void process_gitlink(struct traversal_context *ctx,
 	/* Nothing to do */
 }
 
+static void process_tree(struct traversal_context *ctx,
+			 struct tree *tree,
+			 struct strbuf *base,
+			 const char *name);
+
+static void process_tree_contents(struct traversal_context *ctx,
+				  struct tree *tree,
+				  struct strbuf *base)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	enum interesting match = ctx->revs->diffopt.pathspec.nr == 0 ?
+		all_entries_interesting : entry_not_interesting;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+
+	while (tree_entry(&desc, &entry)) {
+		if (match != all_entries_interesting) {
+			match = tree_entry_interesting(&entry, base, 0,
+						       &ctx->revs->diffopt.pathspec);
+			if (match == all_entries_not_interesting)
+				break;
+			if (match == entry_not_interesting)
+				continue;
+		}
+
+		if (S_ISDIR(entry.mode))
+			process_tree(ctx,
+				     lookup_tree(the_repository, entry.oid),
+				     base, entry.path);
+		else if (S_ISGITLINK(entry.mode))
+			process_gitlink(ctx, entry.oid->hash,
+					base, entry.path);
+		else
+			process_blob(ctx,
+				     lookup_blob(the_repository, entry.oid),
+				     base, entry.path);
+	}
+}
+
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
@@ -101,10 +141,6 @@ static void process_tree(struct traversal_context *ctx,
 {
 	struct object *obj = &tree->object;
 	struct rev_info *revs = ctx->revs;
-	struct tree_desc desc;
-	struct name_entry entry;
-	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
-		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
 	int gently = revs->ignore_missing_links ||
@@ -144,29 +180,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (base->len)
 		strbuf_addch(base, '/');
 
-	init_tree_desc(&desc, tree->buffer, tree->size);
-
-	while (tree_entry(&desc, &entry)) {
-		if (match != all_entries_interesting) {
-			match = tree_entry_interesting(&entry, base, 0,
-						       &revs->diffopt.pathspec);
-			if (match == all_entries_not_interesting)
-				break;
-			if (match == entry_not_interesting)
-				continue;
-		}
-
-		if (S_ISDIR(entry.mode))
-			process_tree(ctx,
-				     lookup_tree(the_repository, entry.oid),
-				     base, entry.path);
-		else if (S_ISGITLINK(entry.mode))
-			process_gitlink(ctx, entry.oid->hash, base, entry.path);
-		else
-			process_blob(ctx,
-				     lookup_blob(the_repository, entry.oid),
-				     base, entry.path);
-	}
+	process_tree_contents(ctx, tree, base);
 
 	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
-- 
2.18.0.865.gffc8e1a3cd6-goog

