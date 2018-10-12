Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBDA31F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 20:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJMDg1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 23:36:27 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36428 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJMDg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 23:36:27 -0400
Received: by mail-qk1-f202.google.com with SMTP id r77-v6so12931577qke.3
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 13:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xGB3iaG24ENYmribhvhEyA7K13f6XdqGs4LVyw71YAg=;
        b=OIpwEkk7kwtZNy9R/0iKeb5avz5qQ4M15KWui5vtz8pdB/H7RH4rDMI3khbjqav7y6
         DTvCXjKaKU2UZyCdFNF7pg2tSllhPJpsv+Af0VM8Iw/TqcpcDArliHgLdN0JSn7b07zJ
         sJCMtY0FQ5IyTsYoAYFLhCoW0DAjzKbmLfqY5MO1TZ+3AvM08P8pMD6gYpWwguTyfbSO
         Fo6zKbScLrtNs2ZxOZiBP2AFWQ9Ex+mlhdzP5rlZAPs/C46kMeHl1HobjRRQSFjriYeU
         CdkXdWYOVtQa4l1krMskP/49iezFegKW/IrEHzNejyjOP8sXy79vBodXOXGC0tTaggx7
         nuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xGB3iaG24ENYmribhvhEyA7K13f6XdqGs4LVyw71YAg=;
        b=NMP1tH5+9/Q6uF9CcXEJbnJoBrcWSndOXNRzMdA/ipBqHIHejzdV7Be8U/ZPRHOoaw
         5/ZYVifrKTsIE5Hh2LQ4+K7KlofQ4NPcLevoB0p9a6CtAmnOr+Z+ZfeUXXLv4Ne2uiq/
         no2aTmqQ1eOcr8JQ8qD06xhjbYtAz9FtJMmmqZTLrzHmrdWRm+kZLdMfdCDY98cWqHNo
         2BPR6RRXCSCItKUAOlnKkNtvXq9eFEvrb4I7+D38v7n04DJDAQFfWgLWD3O9JtPjY5EG
         A7cNbyK5GHBUrvJmBLXb7zTj/Pr95bJgC/5rkjqkOD1tqp9xWmpDiPY7F4NLM+OBsMF1
         vyYg==
X-Gm-Message-State: ABuFfoimpaOc4awMnfK5hdXjUpfUN3P+DeSSKXxsHyqjKI8FLYKobQDg
        b+VcMOQUVHEat7LKoI92dwmwlwiZuJXgY2eGJvmY5DsIqLb+J+f/f8yLL1rbu+5Q0qV4VBQsJTD
        T5L0b8FyGIbEvT0CkgG48BIhDMvvMWLIcdXTQGDcKprQn6uwvxFaowj2hJvU=
X-Google-Smtp-Source: ACcGV63y6N/W/ApdWgxR1lTEIXsPVpd3J2wuD/i/H9q5yPI4fvRcWg0obFe1zyu0hut5JaWfNWcSf3Tn9Jz6
X-Received: by 2002:ac8:7108:: with SMTP id z8-v6mr6285562qto.56.1539374539256;
 Fri, 12 Oct 2018 13:02:19 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:01:43 -0700
In-Reply-To: <cover.1539373969.git.matvore@google.com>
Message-Id: <42ad5623bab52b8207831eab4a4f27e47a318e36.1539373969.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1539373969.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH v12 2/8] list-objects: refactor to process_tree_contents
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
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
2.19.1.331.ge82ca0e54c-goog

