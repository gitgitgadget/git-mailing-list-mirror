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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D18C43619
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DEA765237
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhCHPHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhCHPHV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBC9C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso3998431wma.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKOl172f0szZDOK4L874N/sT6mhDzVTQVWxMqG4032M=;
        b=rZyzwV+RBtoqwP+TQMfADVgijTK50Tq3Ad8nb2aMJ/V25mRqdUnhawTYBXsCwa4gBG
         zU+uhnZ7/OsNdugePzY8dBb6eC362QQqL/T3u+jFJhzWccwTQGhOz+tA73QKrTa1Gni1
         G30+kIqdr1tsbaetlk/k++yAffXImAMOTbQn7AN0p9eg1VVZ3s30ObEJauYRMGOLd739
         hSCbG4+X7pm9kO3hG/NKtaWuyp/venXyVceZLyi7/tmhvsSEHY/qqIy0CmafNSp5Bk9l
         8lupFkd0tItI9zlJDMwF318dq39mmhUysarHjyUvAKs72KIEkjLdvX2j4lwmKReqFtbs
         0eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKOl172f0szZDOK4L874N/sT6mhDzVTQVWxMqG4032M=;
        b=d/Kb97d2YWy8MZezAp9WKNYJ8eMsqRa1EqBH8ckXSSB3NdFidKZOJlkzRFq/+jammN
         b7hisYKK65bAYbG/4GrnSQMq8dZK6TgsymIpzItP1RExqkXNGaO6O4/0TptjFrJt99J+
         wdiTg3H+89PXwNJiIRNc/kBazkE9C/x8FsP0/qCrkeodakLVIN10wJtVU8H52zIyfV+R
         QuOzE5jsNdR0iBdx0z11YL4Rg2fEiyA4fFdeTiqVbjdG83Ar/tEBwbSgHbyc6Rg/sqQt
         hHRwzZl5g17Fbzw7kuDqqd7EUCWa0yKzE11YthcmK6L1J/KAJVSX7EeFNAKegZ8sqaJf
         ku7g==
X-Gm-Message-State: AOAM532SnXLEQMOCAtWZqcDL/iBrmoBMElOxn+fCyeNJvnzuWvlgRPKR
        FRt6vPbcgUTInzY3GaOR01tHLSFbcpZt7Q==
X-Google-Smtp-Source: ABdhPJwzCQpEs3FED2+SXPzDGg6UpurVsHk/l7rlgjG1CEYmw2MStGcDIa7KPi8d2ad0C/2Cdsalug==
X-Received: by 2002:a1c:195:: with SMTP id 143mr22003077wmb.81.1615216039149;
        Mon, 08 Mar 2021 07:07:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:18 -0800 (PST)
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
Subject: [PATCH 13/30] tree-walk.h users: refactor chained "mode" if/else into switch
Date:   Mon,  8 Mar 2021 16:06:33 +0100
Message-Id: <20210308150650.18626-14-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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
2.31.0.rc0.126.g04f22c5b82

