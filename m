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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EA9C4332D
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888FC65232
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhCHPHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbhCHPHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27FC06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:16 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h98so11772431wrh.11
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DiUgvF5gaDU/CnclRudjbSlYBEppYZeQvpzv3YQOLj4=;
        b=DqisSue5aQTKSBPkyAoNvOvgQ4jU9WjyTvMtYFB/ilFPganw/qWpMB++wJyvR3aVT9
         Yk1bEaykUDMjyBht8su9iGyoPiFdxdT+jWaOdGeqQjOIo0HqiyvGpTPpifALMpnXUCEA
         J9qijLHhopBMrbgab5vyDWS5C8AZ2YgEYCUKs6ax6XsEAcY4x/Ken/Ugt1k+SkI1dfbD
         XRbotOp0FXmZoXt6iDyWeo2uFmJeTDCUpvp97NB69l10edJ3j5BcDzNM86PL2DO8U7LA
         UL3GJ2AIBtupXBe9hZAGx/ORsCWd8jUoWGWXrQ4vgi+gKqpa+ynBF6AHfZYPYfDGCXBJ
         ppvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiUgvF5gaDU/CnclRudjbSlYBEppYZeQvpzv3YQOLj4=;
        b=VsP2+V9FFptvpcvKBIjBGeE+RbxP8lOEbvyJBBPagN5/4UTEHwVexW0Up7Vl8XUNK5
         WvlNgQqFecDuUeXXgbXMUzVXEmSxasF5lopj82iwLVIrCV0AOZrGC5NbGuieJemf28XR
         eCk4+4293VBw3PUqPO8jphR2wUyzIeE7s8AUv7wezR4+ThHcfrO5fa88zXweDUvpF18f
         /HrYB3ovFdYLZKHubZZgO8C7LEdpjipO/MSMk7aNFpSZXhXCe8ZSo4flCjqA4wcc9BxG
         Gzbx4+0iY7EEu4Y+wx9vR2RtdlZ5H3cVvRPyOz+DMVCmn2kqCUiTVp5/jW0RRqElRQrr
         ZeZA==
X-Gm-Message-State: AOAM5324auKgK/S5RHd6rcl68BVljvUHgqfkvy7zvKAHl9BQ8YUQL4Ds
        Vrbn1K3IGsKlZD7TOYg5NVoBWpwP1T+Cig==
X-Google-Smtp-Source: ABdhPJzAbZUBwkgmieUy0kUf4zGq+/ShhRqgbzVAhfkg2kU/hgq51Aoqoa5IQijbSdBeIQ7pX2D/DA==
X-Received: by 2002:adf:ba87:: with SMTP id p7mr24004607wrg.298.1615216034822;
        Mon, 08 Mar 2021 07:07:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:14 -0800 (PST)
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
Subject: [PATCH 07/30] tree-walk.h users: switch object_type(...) to new .object_type
Date:   Mon,  8 Mar 2021 16:06:27 +0100
Message-Id: <20210308150650.18626-8-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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
index 6d62aaf59a0..d3ba1d4a4a6 100644
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
index 6a4a43e07f2..234b79a5dba 100644
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
index 88d9e696a54..ac32bf2242c 100644
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
index b78733f5089..1db4e4e90a2 100644
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
2.31.0.rc0.126.g04f22c5b82

