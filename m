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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F329C4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE65765011
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhCPCNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhCPCNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DC4C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t9so6649884wrn.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsTLM4dEWc+SVLRmC6+XrIVizPNiARELPTHr2aK+NRA=;
        b=XgUpi6ZlhEiwgRhgdqL8zN3tJPvUZfnffgxqIzMY64Au4W+6XUzgEiMVZ5IPB6Od0o
         +DuqrM/812zWW/ormTz4/S8fFQITfkjXC66WLG6fGB6tlYAZ8t2Y7740BK+/M/rTGn2Y
         AkRNwOXTcN8VnGCAlymj4e/YJENy1wbD0SvAR/3uKF37pkE43/bBo3a26B36l44Y8Egz
         tEcmbFc1N70i8vihkVF5h9GcRjnqVIq9J4xVMNtwRpJoUYUcXDjI9wosIxUQ+OsKpQE6
         Exu+4jmGgFAUAgL7GawmaShFOlkZ+aPMD5RGw5Z60VKZcCOKaMZcvfBxyzJPSldyFNui
         Fu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsTLM4dEWc+SVLRmC6+XrIVizPNiARELPTHr2aK+NRA=;
        b=BF9xy+XoM2pe7b4zDgkGKLOboLV8hGkfIMwK2Bc9yx+RuZ4upUwQwm5+QWwYl+qyJh
         7wVUBb8acCqNfeVGBvqrvPN2tRh4VcQ7rKUS6MlIKs7p67u7LDH/HhgztAFCiBPik91a
         0htmptixTtWA9ErvT+2RJ1/UrW2pSja0vEk7sW72oQwG/7KKF77jR8mZTCGK6+CxVZ2a
         yGvv/sw6R2f6LCymSwY5lCyRoEXfrHAp/OnnnfU25X8K4dBom7Y6CG1IaSVXFsLJHRQn
         E3mOJXwbLDdB9xc+Zhcq9R/DbiMQrFy2Q1dR2tYqoYvnYXBovB/vrGrDhdQXAYZv+zgQ
         X0Tw==
X-Gm-Message-State: AOAM532gW9ApoyIr9xoq696Vitg8t/cjlyywZjfo3WD3vGzFbE9NEDqS
        a69JQ8SRgrdEnVz3U0Z/iqFlCm7qAhcLbA==
X-Google-Smtp-Source: ABdhPJy2HexLs3Wk3CFZ+Yrcwx4JPIsRCo26bvJ93N4kKO0klr8dSqKQHKULNu8OW4KZKuQU7A8y7g==
X-Received: by 2002:a5d:6a4c:: with SMTP id t12mr2188004wrw.289.1615860817215;
        Mon, 15 Mar 2021 19:13:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:36 -0700 (PDT)
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
Subject: [PATCH v2 07/29] tree-walk.h users: switch object_type(...) to new .object_type
Date:   Tue, 16 Mar 2021 03:12:50 +0100
Message-Id: <20210316021312.13927-8-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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
2.31.0.rc2.211.g1d0b8788b3

