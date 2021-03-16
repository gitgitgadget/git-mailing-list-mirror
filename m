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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75526C43333
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B5564F5D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbhCPP7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbhCPP6v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B0C0613DA
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso1740928wma.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UR9dRbLipQLRRxa2eAF1Ytu+dU0g7lVZukoQLJi4LKQ=;
        b=mkNRbFVZYxzuS98DRpqO8nKruS3EoUn4kkvRLBsCGsivny5ZsVBcexnTBdi4lyTqla
         865aKbPdU4ATwF1fZES6F/WQ+Ofa5YrUEiyipBBcFC9S/4bHZExnD6BE63TLyV3lCdBR
         acYUny6d6O19R8pW3UFNLnY1oJeu5D75FFdUULzpzrVeW36Afnue9Wh/PJMGU5Sg/xrc
         7gS1y1taTAzdCeYJLO8OAl6nkwsHIRvEOQPH98H09y7mXsu/jIO9oN0aGnJcD35ZeIFV
         SNtWYh2GmzZ1u39FAcIZmjJ8TiqrkjKiAdLce6Jvqxb6roriiTxBAT+SFbrGH8eIBvng
         Jj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UR9dRbLipQLRRxa2eAF1Ytu+dU0g7lVZukoQLJi4LKQ=;
        b=K069fIXBm6CPG65D9mBCHmoQXcdwhe/b+6k59OLIzFmYxuH5XUa7XQY1lgNj2b+WzI
         fjWokT41baimM4axHr6JejaXK5PYV5xk15IkQGHQ4fpowQWFOF26EUvxAWzIfWFgXVHl
         WtQUb9WBlu65Sl2akjDlpznZ1x2UvGbhHk+XqsvXCd7PHe770Qxbzjgje3ElEFgDW3VI
         SXis3VawcYZ2PQMo9khu5Fvy7NDIpWaZwa5uf2e9VN/ybbL5j7M4QHTk52PIWBUiRUkE
         BRK7HPENRQAWd/8qApPeD+0viBSrdf6UXpkmcx3mAICExAx6RG9lyUWMm5QgxcX3M3Ot
         VaXQ==
X-Gm-Message-State: AOAM532A8syMfgpKsETtEO/i+3AyCmbUR7fTVE1yg2z0q1O1CUnuIj4k
        VCNnV0w/cdgaz1vFMVJ30gjShFGDYOyncA==
X-Google-Smtp-Source: ABdhPJwaVBbxfVIfULI0clpCEUOQC1WSyOhI4r9r8WpkHCSEy9D8F8ufA+UymbxclrcT2Hcl9Wrpjg==
X-Received: by 2002:a1c:9a92:: with SMTP id c140mr265258wme.167.1615910326848;
        Tue, 16 Mar 2021 08:58:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:45 -0700 (PDT)
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
Subject: [PATCH v3 10/32] tree-walk.h users: switch object_type(...) to new .object_type
Date:   Tue, 16 Mar 2021 16:58:07 +0100
Message-Id: <20210316155829.31242-11-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change uses of object_type(entry.mode) to use the new
entry.object_type field.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c |  2 +-
 http-push.c            |  6 ++++--
 pack-bitmap-write.c    |  8 +++++---
 revision.c             | 12 ++++++++----
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d62aaf59a..d3ba1d4a4a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1534,7 +1534,7 @@ static void add_pbase_object(struct tree_desc *tree,
 			return;
 		if (name[cmplen] != '/') {
 			add_object_entry(&entry.oid,
-					 object_type(entry.mode),
+					 entry.object_type,
 					 fullname, 1);
 			return;
 		}
diff --git a/http-push.c b/http-push.c
index 6a4a43e07f..234b79a5db 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1314,7 +1314,7 @@ static struct object_list **process_tree(struct tree *tree,
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry))
-		switch (object_type(entry.mode)) {
+		switch (entry.object_type) {
 		case OBJ_TREE:
 			p = process_tree(lookup_tree(the_repository, &entry.oid),
 					 p);
@@ -1323,9 +1323,11 @@ static struct object_list **process_tree(struct tree *tree,
 			p = process_blob(lookup_blob(the_repository, &entry.oid),
 					 p);
 			break;
-		default:
+		case OBJ_COMMIT:
 			/* Subproject commit - not in this repository */
 			break;
+		default:
+			BUG("unreachable");
 		}
 
 	free_tree_buffer(tree);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 88d9e696a5..ac32bf2242 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -353,7 +353,7 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
-		switch (object_type(entry.mode)) {
+		switch (entry.object_type) {
 		case OBJ_TREE:
 			fill_bitmap_tree(bitmap,
 					 lookup_tree(the_repository, &entry.oid));
@@ -361,9 +361,11 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 		case OBJ_BLOB:
 			bitmap_set(bitmap, find_object_pos(&entry.oid));
 			break;
-		default:
-			/* Gitlink, etc; not reachable */
+		case OBJ_COMMIT:
+			/* submodule commit - not in this repository */
 			break;
+		default:
+			BUG("unreachable");
 		}
 	}
 
diff --git a/revision.c b/revision.c
index b78733f508..1db4e4e90a 100644
--- a/revision.c
+++ b/revision.c
@@ -72,16 +72,18 @@ static void mark_tree_contents_uninteresting(struct repository *r,
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
-		switch (object_type(entry.mode)) {
+		switch (entry.object_type) {
 		case OBJ_TREE:
 			mark_tree_uninteresting(r, lookup_tree(r, &entry.oid));
 			break;
 		case OBJ_BLOB:
 			mark_blob_uninteresting(lookup_blob(r, &entry.oid));
 			break;
-		default:
+		case OBJ_COMMIT:
 			/* Subproject commit - not in this repository */
 			break;
+		default:
+			BUG("unreachable");
 		}
 	}
 
@@ -179,7 +181,7 @@ static void add_children_by_path(struct repository *r,
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
-		switch (object_type(entry.mode)) {
+		switch (entry.object_type) {
 		case OBJ_TREE:
 			paths_and_oids_insert(map, entry.path, &entry.oid);
 
@@ -196,9 +198,11 @@ static void add_children_by_path(struct repository *r,
 					child->object.flags |= UNINTERESTING;
 			}
 			break;
-		default:
+		case OBJ_COMMIT:
 			/* Subproject commit - not in this repository */
 			break;
+		default:
+			BUG("unreachable");
 		}
 	}
 
-- 
2.31.0.256.gf0ddda3145

