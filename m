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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3FC43462
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3737601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhCUACg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhCUABt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664EC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so9750061wmq.1
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQh010G/6h9UOavYeSWV84b7N0iIjpj9pOcV/h2q6JU=;
        b=hupfLxF4e43TAib6FgbOUAJ8x1ra92rij9HNt+9qYVo5/Wg10FhgAjfRN7zUqOkYNR
         IuP0zC070oSXZbfz+BiYH32gij18N/VmpX1y/i/z2XftfnwJKrPe+5dNx+mR3DXY1DmK
         sr+uRZm59OtRIhQpKbmb5ZUWrFo0JThHZ/tq4+cMRXvKQK7Ie35u3img+cdEitHEuGak
         BahhRFxC9+HHfJTzhZeotHAX92cOmHTNz2uV92fRu5U/9tlLdFcKkFjkMdh5+/jDdJzF
         OOJiQ0gZ4Q4ujQR8eWV+LJHXjHVIe0PO8klYly6/PjbNKXbcrjdZux8s3LGskI3RLX9d
         +72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQh010G/6h9UOavYeSWV84b7N0iIjpj9pOcV/h2q6JU=;
        b=kSabS85h+cbl5ynYhv5xnX5soPNKZCaBsTrJWbbrzzmnx/00KjDuDluGiFeM2isfH5
         86Mmo6uUJiGkkIKInwrmO/aW8bWrKlfpa6SXZTHCih6oMFjv/OEr4+M/B0gdUSWqsB3H
         k7nIX2JqKq7IIrxxFOn1pbRdAVgZ7upM+w3F3A1qDV65zXO3pFyC8Gb0ih60AygWLLi+
         29gtbWa1nFnpvjVpNWTFipPuPf3DnjvB9UEgoe44yZsxQEpQh/rB2LU2Wtwr0YSXT9v6
         AWWWD+5SLmoKdiT1Tft2b5TSkyud7DHQsiNvj8ufSbSsEJ4iMArsRsht1Pcr0aURcfqc
         gv3A==
X-Gm-Message-State: AOAM533xGXz8nwGkTilPeGnldDjQnuuPj09VHFPVe11qUd/Ooz1v4J1U
        H25q85qMdpP1qE2u4sSZwnKKsaYN4ByI+A==
X-Google-Smtp-Source: ABdhPJx4tpOq3zawNDCWKHHT5dR4bBil2UxWhAf8nZ0w+lH2I8/Do2M2GZTvXyVdlWQqzO5iVq4Dmw==
X-Received: by 2002:a05:600c:3643:: with SMTP id y3mr6428883wmq.159.1616284907272;
        Sat, 20 Mar 2021 17:01:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:46 -0700 (PDT)
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
Subject: [PATCH v4 27/29] tree-walk.h API: add a get_tree_entry_path() function
Date:   Sun, 21 Mar 2021 01:01:00 +0100
Message-Id: <a2a34fd3e2de7ecd2c85cbfd13a2defd435e9c7b.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a get_tree_entry_path() variant in addition to
get_tree_entry_path_{mode,type,all}(). This is for those callers that
need neither the mode nor "enum object_type" parameters filled for
them.

There are callers here which don't need the "struct object_id" filled;
forcing callers to pass one just requires they create a throwaway
variable.

See the following commits for the introduction of such code that's
being modified here:

 - shift_tree(): 68faf68938e (A new merge stragety[sic] 'subtree'.,
    2007-02-15) for the shift_tree()

 - tree_has_path(): 96e7ffbdc31 (merge-recursive: check for directory
   level conflicts, 2018-04-19)

 - init_notes(): fd53c9eb445 (Speed up git notes lookup, 2009-10-09)

 - diagnose_invalid_oid_path(): 009fee4774d (Detailed diagnosis when
   parsing an object name fails., 2009-12-07)

Those could potentially be refactored too, but I've got to stop at
some point, and right now I'm focusing downstream code that depends on
"mode" (or "enum object_type").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 match-trees.c     |  4 +---
 merge-recursive.c |  6 ++----
 notes.c           |  3 +--
 object-name.c     |  3 +--
 tree-walk.c       | 11 +++++++++++
 tree-walk.h       |  3 +++
 6 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 2afa4968109..25bfb46fb02 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -288,12 +288,10 @@ void shift_tree(struct repository *r,
 
 	if (add_score < del_score) {
 		/* We need to pick a subtree of two */
-		unsigned short mode;
-
 		if (!*del_prefix)
 			return;
 
-		if (get_tree_entry_mode(r, hash2, del_prefix, shifted, &mode))
+		if (get_tree_entry_path(r, hash2, del_prefix, shifted))
 			die("cannot find path %s in tree %s",
 			    del_prefix, oid_to_hex(hash2));
 		return;
diff --git a/merge-recursive.c b/merge-recursive.c
index f5cccb8deab..e46eea9688e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1884,11 +1884,9 @@ static int tree_has_path(struct repository *r, struct tree *tree,
 			 const char *path)
 {
 	struct object_id hashy;
-	unsigned short mode_o;
-
-	return !get_tree_entry_mode(r,
+	return !get_tree_entry_path(r,
 				    &tree->object.oid, path,
-				    &hashy, &mode_o);
+				    &hashy);
 }
 
 /*
diff --git a/notes.c b/notes.c
index b7a5ddce3ae..7ffae3a0f62 100644
--- a/notes.c
+++ b/notes.c
@@ -994,7 +994,6 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		combine_notes_fn combine_notes, int flags)
 {
 	struct object_id oid, object_oid;
-	unsigned short mode;
 	struct leaf_node root_tree;
 
 	if (!t)
@@ -1021,7 +1020,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
-	if (get_tree_entry_mode(the_repository, &object_oid, "", &oid, &mode))
+	if (get_tree_entry_path(the_repository, &object_oid, "", &oid))
 		die("Failed to read notes tree referenced by %s (%s)",
 		    notes_ref, oid_to_hex(&object_oid));
 
diff --git a/object-name.c b/object-name.c
index 7e3b2d6d739..9ff5f83c1ff 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1693,7 +1693,6 @@ static void diagnose_invalid_oid_path(struct repository *r,
 				      int object_name_len)
 {
 	struct object_id oid;
-	unsigned short mode;
 
 	if (!prefix)
 		prefix = "";
@@ -1704,7 +1703,7 @@ static void diagnose_invalid_oid_path(struct repository *r,
 	if (is_missing_file_error(errno)) {
 		char *fullname = xstrfmt("%s%s", prefix, filename);
 
-		if (!get_tree_entry_mode(r, tree_oid, fullname, &oid, &mode)) {
+		if (!get_tree_entry_path(r, tree_oid, fullname, &oid)) {
 			die(_("path '%s' exists, but not '%s'\n"
 			    "hint: Did you mean '%.*s:%s' aka '%.*s:./%s'?"),
 			    fullname,
diff --git a/tree-walk.c b/tree-walk.c
index a90dbf87af4..fa846535dfb 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -632,6 +632,17 @@ int get_tree_entry_all(struct repository *r,
 	return retval;
 }
 
+int get_tree_entry_path(struct repository *r,
+			const struct object_id *tree_oid,
+			const char *name,
+			struct object_id *oid)
+{
+	unsigned short mode;
+	enum object_type object_type;
+	return get_tree_entry_all(r, tree_oid, name, oid,
+				  &mode, &object_type);
+}
+
 int get_tree_entry_mode(struct repository *r,
 			const struct object_id *tree_oid,
 			const char *name,
diff --git a/tree-walk.h b/tree-walk.h
index 55ef88ef2e5..efcd7ccd10e 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -193,10 +193,13 @@ struct traverse_info {
  * "struct name_entry" you'd like. You always need a pointer to an
  * appropriate variable to fill in (NULL won't do!):
  *
+ * get_tree_entry_path(): <no extra argument, just get the common 'path'>
  * get_tree_entry_mode(): unsigned int mode
  * get_tree_entry_type(): enum object_type
  * get_tree_entry_all(): unsigned int mode, enum object_type
  */
+int get_tree_entry_path(struct repository *, const struct object_id *, const char *,
+			struct object_id *);
 int get_tree_entry_mode(struct repository *, const struct object_id *, const char *,
 			struct object_id *,
 			unsigned short *);
-- 
2.31.0.286.gc175f2cb894

