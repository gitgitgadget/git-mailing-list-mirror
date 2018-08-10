Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEA31F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeHKBit (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:38:49 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:41025 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeHKBit (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:38:49 -0400
Received: by mail-oi0-f74.google.com with SMTP id j17-v6so10654522oii.8
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 16:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S7p6+GoJgXllh4ukuBLdZjMShxPWyRclPkpOBx2EvIM=;
        b=Ebn6artVPbgdov/myDHiWetE8Inr2i6IKxXDj85TPtT97xWINHpOnnfUdF03m8LxfM
         d7REOtTFZdkRBhxUdMg3vQGxVIXbNkllSXyXD9NxDcxN0twL0DfoVWxQ26hhdMun20+J
         1gnh+u7wYoHoP5SG2d/EKyoNSIpUC0tt8r4hJQ3Zo2RR9D3nd+WXVMavgbesX125nk7S
         HchixnN+at4ShdEfxDN6D7ZIXq3XfgoOQGyOfu/wYjPwdSsFznYLJEz5hQDg3c+0WEpt
         RYaADbpa4OYVXattyXrmn6f7atAnG02+S0WvqM3x8wLjujOQBlSjM4Swd5yjpjyBWQTK
         el/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S7p6+GoJgXllh4ukuBLdZjMShxPWyRclPkpOBx2EvIM=;
        b=RmDw6R/m+s4Eewd6zECAdPfyKBzkKkI8s2URWQzunMQjsNtIb+RTwe5zRU55wHUuft
         Ww7QeXnZWhLU2Pezq3ND0WQT7DIcLvop5xzqbw7LtOMf7lRLT7rDc3mWZqfa8zzQhNCk
         uzxV14bwStmjTB8Wypiw/EAzzldirXHLvmbTS5KtIzoG3vcgJvG+qvKNvxRglYZiJctc
         U2xHmUwEog5tKGYHOtCNR+4koO0mB6wHaRWut3YTBoL2e0TUplYM/s38ag55/8b/VcxA
         I9EySawHSWRYN8iuF7oIHp5IqfstW+Ety3AdtAhile2v0B8uBz0CN79DNRX4FUIjXwQl
         CILQ==
X-Gm-Message-State: AOUpUlFKFjOfJUVqF+1+lwuXlYjleoPcuCWgYGWdu90lg3tQbBYpXVuX
        pbDSuOriAaEA+ZG2Ex2DVMlVXGkxXW33F33pAMIDK9tQ7cr5X9OG7OL+uEOTqe3pwWsTk4173BN
        +D7Esp1Xy4QbhXQIMnn/vWApNxijkQNo1n6nOXrpKuZIwTaC6iTHar5AwDuc=
X-Google-Smtp-Source: AA+uWPw0gYzLv2XGxOyqFyi/eMxGVfknhVj+GB25EdEz/AyDZU5rgvZX2awzs+YY0HXZkTD9gRwxh86+Fv6H
X-Received: by 2002:aca:d642:: with SMTP id n63-v6mr5074198oig.64.1533942413227;
 Fri, 10 Aug 2018 16:06:53 -0700 (PDT)
Date:   Fri, 10 Aug 2018 16:06:26 -0700
In-Reply-To: <cover.1533941986.git.matvore@google.com>
Message-Id: <feb7ea58228df4bb777ee96651389000e804f9fa.1533941986.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533941986.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v2 2/5] list-objects: refactor to process_tree_contents
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, jonathantanmy@google.com
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

