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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71579C4345F
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FBF61936
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhCUACc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhCUABr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3BAC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso9264651wmi.3
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKBnmRdfhiCxD0XyIYKb5JmvAJTdMHqi7orx86MGYdE=;
        b=WApyb0GMxoWjyfok/pbQvei+ZS6EHMMyR6VhuwMYUsfc3oRRNNLGbck2zrHw+VASqw
         bRYUNCOmPeHAk0nhM5OT15ORVPNastlKMWcUnMEdHpJOsrKGw3f2ih5Ovqezkz/sMc5O
         WAKdWq8UMdTthnhk5O1WBDhY/svM5G3KM5QoR8zeCK6ZyECOoDcdcVPs3OEdLu2hNrpC
         bLhNwjUVCWW1xk7ocywaPawrbMmHvOz733Q/A5P8Yg9Kq79DryScbwUhfD1EP++VDzcI
         tG6Oe3ixXTHkXH8M2SZke6a0xatoNPGw/kn789ftr91LUae4Kd4mR7mlW0m30lAP4xMv
         UxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKBnmRdfhiCxD0XyIYKb5JmvAJTdMHqi7orx86MGYdE=;
        b=ITwxbeFyVppXZ/9UGxm+GTkAioQfVtc6WOzSEC7I7Hf5hS8RPD4DGy8fkgOoP/1EjV
         xXuPoIUm0NgIxDQuGzGiSDu3UeFDraHkan+YY8CPjMqxmFiIM058lyNwc7rrj850a2uW
         L18373sl9Dbn2sooL0Xl8F17Zrs5EkoN3/KuJJPJPCnr9Jbx++Z4KPNHeQ2zJg8QaiJf
         gzNoMDr+AO2xdXqJsrjvLFHuu4qLxSAvspWxue5RFw2I4wDpvKh8itRFIBZ0za3fEnXD
         +gatOrJRftx90fcMvEcOZRIirUqFpeyRFFAnyRa4QwDyNKENp2f8KMdR04R1Py7qjT3s
         avqA==
X-Gm-Message-State: AOAM533sNcvMzaj5HWY3x84oX6qa1TmoRtWptsLxD9Q9G+5YJSNIgdWk
        urGFNthfbRUYCj5zs7CD9JzOaMEzt1U/5Q==
X-Google-Smtp-Source: ABdhPJzqO8xe/j22ZFJZGF3pad+5SKwmH+Y8Z6CIpQ6PzG+c/8cfLS4y2hgWOOZr1kfJ6pFT/9Wj/w==
X-Received: by 2002:a1c:2683:: with SMTP id m125mr9624326wmm.178.1616284905875;
        Sat, 20 Mar 2021 17:01:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:45 -0700 (PDT)
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
Subject: [PATCH v4 25/29] tree-walk.h API: add a tree_entry_extract_all() function
Date:   Sun, 21 Mar 2021 01:00:58 +0100
Message-Id: <ce7c19ad39c882a6f883ea3acceb99e7771c9a87.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
2.31.0.286.gc175f2cb894

