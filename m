Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E8E1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbeHMU6Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:58:16 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:55501 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbeHMU6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:58:16 -0400
Received: by mail-ua1-f73.google.com with SMTP id h11-v6so7855708uao.22
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S7p6+GoJgXllh4ukuBLdZjMShxPWyRclPkpOBx2EvIM=;
        b=ABgTyRCVE8IR/3XXdCJ2ecur8+w5WkRdxsyvZzJ/ue5yZ8vdYoLJu9BBxMIRosJGlY
         Q89URx+h/qqTXHGwVq3NhW4Tfy/W0Vge1y0V6RdwAlnv/ajob6PX+MOAwxWfqyyBZe+S
         yDC6ZfQhXo2LgDPZOSLD1IkdkRcQnxfWInZWAcne/aFVfguXgUTLhFGoZT1laMaVcI33
         OeMOYSw8qh2UxHM7jYZnambetg4p1sCVOT4Q1I2+glDi5sfuBZt31C9ZRwgp6FIEHXW5
         C8w9Qfjavbq3hu9yaOXq2YYodT06mRm6sMMB7b2NTfhhCBEAbsg6C2ZBLL/6D4kuUs7c
         9kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S7p6+GoJgXllh4ukuBLdZjMShxPWyRclPkpOBx2EvIM=;
        b=id1XoIwXVIltNa6y5Dyhwf1x1odYMjK9fI60an/SrREAoM5XH26t+cbpg9nVFsQMI7
         iN58xfkIzqSCNmK33FgIXAq9FcNv1bs1AMVEqH9GF7uw7INVpD9+IaWuxrJOccGKwnrS
         35qaxDS/4AO1at9gp0q+DU482JQvhrRWoDiJ2SlsxdDoj/CONsDt/kRqcXycjH/qfZGB
         pWIAKOIeK4WbDLE9We72jS7EscrPJCExgAQPwQ8Tafh+f1ZGUTccu4ARQc3AcGDFDoC/
         RxYbNOb4MzhmOSmpWHvD/0LjMp2z0RHApsOxSfIrXpZHeppeDA99bpCu1T6eIukm6fZC
         DapQ==
X-Gm-Message-State: AOUpUlGF0G7VNicNcyrVud6Mi1/mjzBsniKfc7dHrkWVSpLderWnL0Vs
        bwyTFdLqwyTCgZHRrSLK8F6WZdpC2p16bqS1sxxPR4q1I1EHjMLWJgf5eCKzSxJkgnmJyt+iflS
        DkHuBU3dJDUioO4PI3KTTO7s9D6qkkejb7/NWAY8SzAHNA4pCItGLpGP9CLQ=
X-Google-Smtp-Source: AA+uWPwlff8AlbCTQv1iG0tz6WEHZed5tjxbW4ns1L6MFTmq0LZLSms7TB1wqYtepBjn0i2an28DfFRFs5VP
X-Received: by 2002:a1f:7c8:: with SMTP id 191-v6mr9613333vkh.41.1534184096212;
 Mon, 13 Aug 2018 11:14:56 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:14:29 -0700
In-Reply-To: <cover.1534183648.git.matvore@google.com>
Message-Id: <feb7ea58228df4bb777ee96651389000e804f9fa.1534183648.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534183648.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v3 2/5] list-objects: refactor to process_tree_contents
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com
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
2.18.0.597.ga71716f1ad-goog

