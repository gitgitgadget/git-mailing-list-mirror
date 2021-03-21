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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3235EC433EC
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7DE61937
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCUACR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCUABf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F9BC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so9288244wml.2
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxlIkdXK1NKQp5S4aUeDP0WOB56xEK9kKX4TCwOaLO8=;
        b=XDnpFjWfFCNGhSKXeWVwMKdhwmXSSL6cCE8sc7wAyt6QRkMx8ZTe85X2YWbX9ULFjT
         OPSJkQbBz6UQXf4dwtGyfWvX04ZKh/3QmnRw/gNJ14lTIi+DToqx+kx7qq0x1JAUr0Q3
         S+Ztcykyd9Bt009T5aogRNlMScOezded5AZpz4AzhjZMsWU7rjlJp/JyP/QuGh77KV4v
         y0aTguAuOI5jnPuzlu+eWi7RJCLMwinSqfWA32J35+spoiXY1nLi57Qd/WYZ063pmfye
         N5c5kiEL78zEH9WehSEWrca3Z/QN9fiu7nyNscpAPADMgWmIPFuibSBGQU1UReIQIlsw
         4IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxlIkdXK1NKQp5S4aUeDP0WOB56xEK9kKX4TCwOaLO8=;
        b=AMkJqU0HJ3C275NPleNr1UeRDqrK3bXIVwYNj/w0BS/+vYZDb9KMXmB7scr4u6s3jS
         IY2uJ9JOYxXSkuo1p3G/ZyRgnSMI2jDenDXeUvoHAgUuVMJzNYW35+DN1Spc4bchH1aU
         k4gFJQ1ieUfuoLFuCimwwnbzIl7qqnbTLjmGW52aBYs1Euk16cmmBozDl6x1DC0mSixu
         9fQDhSPNYQOL+q4UHBWI43rKQ8w+53wiV3oabF5uJ/JYOpPOHkvY81MWWxv91XAcc/Ol
         XjKqNSmU8gLy5D9nRNYjZOE+STesGEdYabJJWT72+cFiKOzG3yOdhbpuVmfn2JM9FGAX
         iSvg==
X-Gm-Message-State: AOAM533YyMxYI+FG0LsSa2MySJNW8usvMJucsDGLvzbcHoYcuTb1lXBt
        9VThpS8d1kgGVWG0br4G9qjnIZHJ4DxkOw==
X-Google-Smtp-Source: ABdhPJx89BuN4mjjlO/FLtsUJf2vjJVURfKqSuHPjCL6HqqRJsipMCjB0B1UrpU49j/YJqk42UE9hg==
X-Received: by 2002:a1c:32ca:: with SMTP id y193mr9433097wmy.56.1616284893278;
        Sat, 20 Mar 2021 17:01:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:32 -0700 (PDT)
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
Subject: [PATCH v4 09/29] tree-walk.h users: switch object_type(...) to new .object_type
Date:   Sun, 21 Mar 2021 01:00:42 +0100
Message-Id: <f8912a409b59cbcbacc164e78e05f8acc2649906.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
index 4bb602688c1..12fcbb3b8d4 100644
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
index b60d5fcc85d..aeb011de8d4 100644
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
index 99c859f7971..aba74cb65a2 100644
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
2.31.0.286.gc175f2cb894

