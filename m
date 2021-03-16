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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06457C432C3
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E233365027
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhCPCO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhCPCNy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7451CC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y124-20020a1c32820000b029010c93864955so511106wmy.5
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQZX8/LBHtjEz3Qp0uwl02tSEW8LM0mVtrOGaDN6Ucc=;
        b=JJNV/FcjZJp6iK4s0751o7eAKqZg/PwMHoKX/A2G62KWRE2LnK+p3aQoNQJlWLwTbx
         qMt43u+IjVgqWKNf5OpgshtlDiRBiIp/f3gyjkeQwzq31dtbrmN4ZA+JJ18pey25vgmS
         ro8iF5mlBrmBmjqOQ2g5HO4utD60osKLEFxvtYuE6Br/dyEy+cKGsV1IT2O1rpcsDfDV
         wgJHLkqJqfVWkjA+SrnWf4XeuDugrKbHs3FS/Te75hUvnsDPtZF1FUBDUtTXN9r2qbM+
         yugV/FcWgBbu8fULj4Nl80leirjqIJoNvaAWIrmf/k9w7o+N7nePZg6Q4/emOoW9uucq
         4Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQZX8/LBHtjEz3Qp0uwl02tSEW8LM0mVtrOGaDN6Ucc=;
        b=K97OsOLVjgiz7rDg1E9BPSkJ3mg6gI410KOGStC2PpDA+tjZOL2+kbEucYovOyls48
         NJnLAvBUR/CTr0s14B5xHwDlopJzHHZozrR9i7MemLmYQoON8aksfmwxMbxQ1l9n8M75
         +xn262AlMPy7PlQ/09bdQTRkGmvnHUmhLdtS30j7Eik0dFswK51B2TlD+4q1Dj47MblY
         RBaUgxDVC3DN1nVvqg8Ssi3dL/3INnhJF8y2Ro7AwT2GQoROOwWmfDwEAtpkvanr/X1x
         rllvbp1NXkDdcdtf7s9lM3C3D7Z4Gzuhh+84lGZz4bYLqgL8wtNDfW8s1cFxujTOOc0P
         S3GQ==
X-Gm-Message-State: AOAM533/yM6fl3oOuJrOkj4dfTfMilmd1tCQW3NwIjL1Dp5NfYoOx/Pt
        yWFIcx5bpLzZjbI+NFc2tIjpzMvEeJjt8A==
X-Google-Smtp-Source: ABdhPJw/GX6NnZIpvPO9fN6pXxARjk3kVXpoyDuZAGsNrJf1L4/+06n/Ne8Zc84U3fEFFInkyVii6Q==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr2237664wmi.132.1615860833008;
        Mon, 15 Mar 2021 19:13:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:52 -0700 (PDT)
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
Subject: [PATCH v2 25/29] tree-walk.h API: add a tree_entry_extract_all() function
Date:   Tue, 16 Mar 2021 03:13:08 +0100
Message-Id: <20210316021312.13927-26-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a tree_entry_extract_all() sibling function to the existing
tree_entry_extract_mode().

Having the OBJ_{BLOB,TREE,COMMIT} when you have the "mode" is strictly
speaking redundant, but hopefully makes it easier to read the
code. We'll now see which parts of the code are checking the types,
v.s. those that care about the mode specifically.

Only the first use of tree_entry_extract_mode() in emit_path() is
converted here, the other branch will use a new
get_tree_entry_mode_type() introduced in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-diff.c |  5 +++--
 tree-walk.c |  2 +-
 tree-walk.h | 12 ++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 65c7e4dbc8b..918ad95fa61 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -195,10 +195,11 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 	assert(t || tp);
 
 	if (t) {
+		enum object_type object_type;
 		/* path present in resulting tree */
-		oid = tree_entry_extract_mode(t, &path, &mode);
+		oid = tree_entry_extract_all(t, &path, &mode, &object_type);
 		pathlen = tree_entry_len(&t->entry);
-		isdir = S_ISDIR(mode);
+		isdir = (object_type == OBJ_TREE);
 	} else {
 		/*
 		 * a path was removed - take path from imin parent. Also take
diff --git a/tree-walk.c b/tree-walk.c
index 46ce1ba8069..f4473276c9f 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -577,7 +577,7 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
 		struct object_id oid;
 		int entrylen, cmp;
 
-		oidcpy(&oid, tree_entry_extract(t, &entry, mode));
+		oidcpy(&oid, tree_entry_extract_all(t, &entry, mode, object_type));
 		entrylen = tree_entry_len(&t->entry);
 		update_tree_entry(t);
 		if (entrylen > namelen)
diff --git a/tree-walk.h b/tree-walk.h
index 805cda649ee..a4c54871747 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -47,6 +47,7 @@ struct tree_desc {
  * appropriate variable to fill in (NULL won't do!):
  *
  * tree_entry_extract_mode(): const char *path, unsigned int mode
+ * tree_entry_extract_all(): const char *path, unsigned int mode, enum object_type
  */
 static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *desc,
 							      const char **pathp,
@@ -57,6 +58,17 @@ static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *
 	return &desc->entry.oid;
 }
 
+static inline const struct object_id *tree_entry_extract_all(struct tree_desc *desc,
+							     const char **pathp,
+							     unsigned short *modep,
+							     enum object_type *object_typep)
+{
+	*pathp = desc->entry.path;
+	*modep = desc->entry.mode;
+	*object_typep = desc->entry.object_type;
+	return &desc->entry.oid;
+}
+
 /**
  * Calculate the length of a tree entry's pathname. This utilizes the
  * memory structure of a tree entry to avoid the overhead of using a
-- 
2.31.0.rc2.211.g1d0b8788b3

