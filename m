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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F2EC433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E2164F5D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbhCPQAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbhCPP7E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:59:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6105CC061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e18so7705750wrt.6
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nzekj2+svQp9OGjkX39xX5xq4K1LSlKg4BAO9ZN3Rq8=;
        b=Z5yY2foNBERbxTKKKFZnvJENUdh6ACAkLaO8xo99vcgaqBIUfiKs+poJ5TfUUtqLOx
         VG1tfoIYVpEpNf+/ZJG58MLYMgWWq6Ll2AMhbBigb+dTZGCTO4oUP6y6MaXMX5DzTjnu
         r5wSvDAPNCc1+3Mxbc0QHD31cHICxx5IqOZGD6SPaIKPsplus5pRYXkrxazgrIYrSvYl
         bamJwJ26NyYTixtCky9FOcMHfmUdqXtqa+hjlEQJxJ/mJsDpPLpOrMVwjc/KVzhxL2em
         E+zKfjsGFwBtXVwpuXDmSQpwTk8hOkOb6ihltCYC2dpz/yiFTF4zEC2s5cbT4DJD9KOg
         lp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nzekj2+svQp9OGjkX39xX5xq4K1LSlKg4BAO9ZN3Rq8=;
        b=Acmgxexd3MYoFt/woGT65DBzA5T5IzJ+1jT2xKakJn11PXsEBpqF2TOptzsJhE3Saa
         l5b3cV6Dy44YKVTERN1aDZu8e4kgi8wE9DAQPLJhIwv8PotXvK/3skwqxaRnPYsbOxQT
         rQZ5xtE5QH70RhKG65FE5Puxtqc/fJgOw+kkwZd3LNBYcYS+4x7271hBhpvRWmDAQuZh
         spZZBefV9oFVIFGAWOox8ko6Mmd2NrzuKAVYhVT25j8BZ6zTlNgD9J3l1nLEphX/Yhji
         rhweOHukzYRvCElyUjWnNblfX3vk3Fz3585mgcQozammuyd6A/zlk0HZr0nJcDOZE8+e
         r0Gg==
X-Gm-Message-State: AOAM530poqPjeEpPSiP94evVOoffbx+vW+oHlrJMQu5uwkxYI8EBOYqB
        J5rBpp3Fh2xZkQv3sTthbLabXxzXL77iBg==
X-Google-Smtp-Source: ABdhPJw1Y2YdIJR3jGFcNGlF9hCyhtuIs98/PKj57paQV2RQOEFT9mMjNPJaRBM7xyaEb6Yo3ZfQ4A==
X-Received: by 2002:adf:f150:: with SMTP id y16mr5686655wro.414.1615910342898;
        Tue, 16 Mar 2021 08:59:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:59:02 -0700 (PDT)
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
Subject: [PATCH v3 28/32] tree-walk.h API: add a tree_entry_extract_all() function
Date:   Tue, 16 Mar 2021 16:58:25 +0100
Message-Id: <20210316155829.31242-29-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
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
index 65c7e4dbc8..918ad95fa6 100644
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
index 46ce1ba806..f4473276c9 100644
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
index 805cda649e..a4c5487174 100644
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
2.31.0.256.gf0ddda3145

