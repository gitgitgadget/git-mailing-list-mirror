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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E49C41620
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96106523C
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhCHPHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhCHPHc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E685C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso3998831wma.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1fiENbx5A1ZdSUENVW/qmNIfg0o5M0pzIzvtxMQYsSk=;
        b=Rj5cNHnObfFUqVI5f2aWKamHFQHsSTMmHWPPMNxJ3l28wHSq/IJJ2g3Yks32mIw5Od
         1TYq42vTu6cxWJuhQ267trqHc8NwPyxKyEECs7089EH/oDrYRKta3ZwAEjnkvTbKe412
         AZUK266AvBmXk0+3qIVKmRprrwCwE4uSEVBE4QRQnsbUtDgVCh7BThhb+IwuvCiQez6L
         qWvfdr8Z+I3rSAHXC3JQOZHODmYWMQo6rQzPZKivRUpHcJ7orwoKuQvDfOVdN+klJrkN
         7E7JJUnjYzjvtXeI2EmInwK5uDNRsA2u5R+yG1Sh+DE57QVasA4YFPB9pljT4U1iO8Gr
         4lWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1fiENbx5A1ZdSUENVW/qmNIfg0o5M0pzIzvtxMQYsSk=;
        b=addT496qecNBoNxbcNW7UfVYBDrXTJneqgsDPcCyElEoKmdHsNz/NY8TtDU0zHbDqz
         BKh708Rrgdg8CT/rNCLV+QtkJXaE2i/qoaCdvEKLlqTKmINYf4O/ErrLIT9ypOb4MGIk
         cPoSUDaoEVYqqzN8YqLZB/FZBJgQrAoZMfS2o0pbhoSOduA116wuOS5rogOPvzeviQT9
         4AX5NR4f0AjTDp9tBPrVwBXu2s6V18jkZUtJ2894jcTnADEg4Diai/i64G4Gh/cFeWVZ
         isEGFu7BPPVN8Yy3hicNc0gKeoggj1WWrqxnXkMku3wrxiveC4InHc0wi6kJYkw0tkGW
         5QrQ==
X-Gm-Message-State: AOAM532UwJKZWytdWi9FFvNIQJveHEMlJmV1gQLZUfgamJa+4RRjZiNN
        J24cYe9qmgB0p0OAp851K8ttMZptfVmwKg==
X-Google-Smtp-Source: ABdhPJzm/s/vNfpFr3P4YTviIq3dq5pnUO39ExAGAKFH7TDdFaMMUxTpvJ4xmA4OswxEubt258+gAA==
X-Received: by 2002:a05:600c:49aa:: with SMTP id h42mr23260791wmp.49.1615216050785;
        Mon, 08 Mar 2021 07:07:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:30 -0800 (PST)
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
Subject: [PATCH 25/30] tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
Date:   Mon,  8 Mar 2021 16:06:45 +0100
Message-Id: <20210308150650.18626-26-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the recent split of the get_tree_entry() function, rename the
tree_entry_extract() function to *_mode() in preparation for adding
other variants of it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c        | 2 +-
 match-trees.c | 4 ++--
 tree-diff.c   | 4 ++--
 tree-walk.c   | 2 +-
 tree-walk.h   | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fsck.c b/fsck.c
index 7c74c49d329..11678ba5826 100644
--- a/fsck.c
+++ b/fsck.c
@@ -670,7 +670,7 @@ static int fsck_tree(const struct object_id *oid,
 		const char *name, *backslash;
 		const struct object_id *oid;
 
-		oid = tree_entry_extract(&desc, &name, &mode);
+		oid = tree_entry_extract_mode(&desc, &name, &mode);
 
 		has_null_sha1 |= is_null_oid(oid);
 		has_full_path |= !!strchr(name, '/');
diff --git a/match-trees.c b/match-trees.c
index 60a17b92d70..3d2c74a44ac 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -146,7 +146,7 @@ static void match_trees(const struct object_id *hash1,
 		unsigned short mode;
 		int score;
 
-		elem = tree_entry_extract(&one, &path, &mode);
+		elem = tree_entry_extract_mode(&one, &path, &mode);
 		if (!S_ISDIR(mode))
 			goto next;
 		score = score_trees(elem, hash2);
@@ -202,7 +202,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 		unsigned short mode;
 		int len = tree_entry_len(&desc.entry);
 
-		tree_entry_extract(&desc, &name, &mode);
+		tree_entry_extract_mode(&desc, &name, &mode);
 		if (len == toplen &&
 		    !memcmp(name, prefix, toplen)) {
 			if (!S_ISDIR(mode))
diff --git a/tree-diff.c b/tree-diff.c
index f145ff84c68..b37348b7908 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -196,7 +196,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 
 	if (t) {
 		/* path present in resulting tree */
-		oid = tree_entry_extract(t, &path, &mode);
+		oid = tree_entry_extract_mode(t, &path, &mode);
 		pathlen = tree_entry_len(&t->entry);
 		isdir = S_ISDIR(mode);
 	} else {
@@ -207,7 +207,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		 * 1) all modes for tp[i]=tp[imin] should be the same wrt
 		 *    S_ISDIR, thanks to base_name_compare().
 		 */
-		tree_entry_extract(&tp[imin], &path, &mode);
+		tree_entry_extract_mode(&tp[imin], &path, &mode);
 		pathlen = tree_entry_len(&tp[imin].entry);
 
 		isdir = S_ISDIR(mode);
diff --git a/tree-walk.c b/tree-walk.c
index 83737634770..e613f273767 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -570,7 +570,7 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
 		struct object_id oid;
 		int entrylen, cmp;
 
-		oidcpy(&oid, tree_entry_extract(t, &entry, mode));
+		oidcpy(&oid, tree_entry_extract_mode(t, &entry, mode));
 		entrylen = tree_entry_len(&t->entry);
 		update_tree_entry(t);
 		if (entrylen > namelen)
diff --git a/tree-walk.h b/tree-walk.h
index 61fdcb166d2..892e77eda23 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -48,9 +48,9 @@ struct tree_desc {
  *
  * tree_entry_extract_mode(): const char *path, unsigned int mode
  */
-static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
-							 const char **pathp,
-							 unsigned short *modep)
+static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *desc,
+							      const char **pathp,
+							      unsigned short *modep)
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
-- 
2.31.0.rc0.126.g04f22c5b82

