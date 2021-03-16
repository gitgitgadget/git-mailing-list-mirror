Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FAAC432C3
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E15065028
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhCPCNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhCPCNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA246C06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo549395wmq.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2amckh+dhS2K/852fVHZlKdBSe9NgrV6DohX2B/OcfU=;
        b=VcBaCP8EIeg0nQtkRFLRC5CsZguGyPsI890kaACdTbfWWAEXn/kCxXtA/QuMqahXMH
         NLo9UaZa5DprcQh/s0ZP316PLQ52DuYfTS+qPsGvREDEXEyz8/UsgdL1rWb/KwiWrUOj
         1uA3ZuRQXi/qHHn3E6z20+dzinhdhfZUtANrqigMx6zQ4+LQ21IONT47lp+uRjLI5HB8
         4eaA4F55QxrNK/27F6b9vm0uP+G1iw6r4kCZpYUCw3Fv4vOeNy5DcgZCjD8Z035ISo0l
         oL0/7oJy3HlYqMrOqFYTOYb0P38mfsAGw5YhMztDHwBjAAQz23CVUSzhT6324tc2HqqK
         c9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2amckh+dhS2K/852fVHZlKdBSe9NgrV6DohX2B/OcfU=;
        b=pFnKrDcevcRr+/u9rYImmK1HbgvyVec0hAeQpS9J3Bly1HObp2PCb3bg9/9fndDN9I
         VgXKBJlRkG5O7LNjCzgLhj7fTPxlvQHsXLt7atb2mD0oy6K1VCd07V+uxi9rkc0Z+fRb
         6iWPRMHB878MyfkkmpTr7HnnF5cXJLo95g6XN26KHKrtGX3sMDCjMSCNWtjcAeQLiE+C
         8AC7/tSurwfwjeclFZc1N3W180Npz+laxSNcHf0f/6/sZ6pjEnGbrPGmY0ABT09ockKc
         ypZT4aBOT1W8eCIKyRNG4TwtozoWQ4QLWLo3Oenz6T/MCPNYAr5oIoxSbFeDtGu4Lc3Y
         T5zQ==
X-Gm-Message-State: AOAM530+kdXdvrniJoIg59j08J0ckTkFZsm983O4bF2/NlujxHJj7hKS
        LFVGPftsKka3Mp9Jfp4pqTAm1IJBlu9n+w==
X-Google-Smtp-Source: ABdhPJytB5+3zHhPbsal7ZVf7bPH9/bLFWggFC/pmEkf+6AiyUztMD40zfz5/8vdbyDmFYQf3TJt1g==
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr2293880wmq.45.1615860822464;
        Mon, 15 Mar 2021 19:13:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/29] tree-walk.h users: refactor chained "mode" if/else into switch
Date:   Tue, 16 Mar 2021 03:12:56 +0100
Message-Id: <20210316021312.13927-14-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a couple of "switch" statements that previously relied on
"entry.mode" to switch on "entry.object_type" instead.

This is more obvious, and allows us to explicitly handle all the OBJ_*
cases, not just have a wildcard "else". That doesn't matter for the
behavior of this code, but for its readability and maintainability.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 list-objects.c | 20 ++++++++++++++------
 walker.c       | 22 +++++++++++++---------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index e19589baa04..37434ba89d3 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -111,6 +111,9 @@ static void process_tree_contents(struct traversal_context *ctx,
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
+		struct tree *t;
+		struct blob *b;
+
 		if (match != all_entries_interesting) {
 			match = tree_entry_interesting(ctx->revs->repo->index,
 						       &entry, base, 0,
@@ -121,8 +124,9 @@ static void process_tree_contents(struct traversal_context *ctx,
 				continue;
 		}
 
-		if (S_ISDIR(entry.mode)) {
-			struct tree *t = lookup_tree(ctx->revs->repo, &entry.oid);
+		switch (entry.object_type) {
+		case OBJ_TREE:
+			t = lookup_tree(ctx->revs->repo, &entry.oid);
 			if (!t) {
 				die(_("entry '%s' in tree %s has tree mode, "
 				      "but is not a tree"),
@@ -130,12 +134,13 @@ static void process_tree_contents(struct traversal_context *ctx,
 			}
 			t->object.flags |= NOT_USER_GIVEN;
 			process_tree(ctx, t, base, entry.path);
-		}
-		else if (S_ISGITLINK(entry.mode))
+			break;
+		case OBJ_COMMIT:
 			process_gitlink(ctx, entry.oid.hash,
 					base, entry.path);
-		else {
-			struct blob *b = lookup_blob(ctx->revs->repo, &entry.oid);
+			break;
+		case OBJ_BLOB:
+			b = lookup_blob(ctx->revs->repo, &entry.oid);
 			if (!b) {
 				die(_("entry '%s' in tree %s has blob mode, "
 				      "but is not a blob"),
@@ -143,6 +148,9 @@ static void process_tree_contents(struct traversal_context *ctx,
 			}
 			b->object.flags |= NOT_USER_GIVEN;
 			process_blob(ctx, b, base, entry.path);
+			break;
+		default:
+			BUG("unreachable");
 		}
 	}
 }
diff --git a/walker.c b/walker.c
index 4984bf8b3d6..7ba757244e6 100644
--- a/walker.c
+++ b/walker.c
@@ -45,21 +45,25 @@ static int process_tree(struct walker *walker, struct tree *tree)
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
 		struct object *obj = NULL;
+		struct tree *tree;
+		struct blob *blob;
 
-		/* submodule commits are not stored in the superproject */
-		if (S_ISGITLINK(entry.mode))
+		switch (entry.object_type) {
+		case OBJ_COMMIT:
+			/* submodule commits are not stored in the superproject */
 			continue;
-		if (S_ISDIR(entry.mode)) {
-			struct tree *tree = lookup_tree(the_repository,
-							&entry.oid);
+		case OBJ_TREE:
+			tree = lookup_tree(the_repository, &entry.oid);
 			if (tree)
 				obj = &tree->object;
-		}
-		else {
-			struct blob *blob = lookup_blob(the_repository,
-							&entry.oid);
+			break;
+		case OBJ_BLOB:
+			blob = lookup_blob(the_repository, &entry.oid);
 			if (blob)
 				obj = &blob->object;
+			break;
+		default:
+			BUG("unreachable");
 		}
 		if (!obj || process(walker, obj))
 			return -1;
-- 
2.31.0.rc2.211.g1d0b8788b3

