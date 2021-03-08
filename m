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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDDCC1550D
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9276523C
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhCHPHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhCHPHa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:30 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188EBC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so2889581wmq.1
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtqTatYVCXnVJXxjymt/1n44U2yhdYmydkzTPyVBlaQ=;
        b=dzGzh+99qEH8Qe412R6JAD0x7sfAbHrsmuOGuFAqvj/9uHhai6CBSuMmeAfCXm1Be+
         lISoAaRw/LJX4xF1XyQdk+KePEPAjnKEDQyJZELX3uyuPvDdHDcKVjMfzMwKFFYYl04q
         MmyvOG1ACh39sAcWDHYivgx+rBnu91qIcFx80RcEwXQ05XGD3In5vRRAGOlqheqpVNQ7
         m1XUtHOSFhnP/jRc9mBHbCmg5gBX3hUriPHrg3E8R2yZTw7M/au/gs5g1P0T05/C4nqT
         w3G68D1dwfMtfse8QIGCI5aRkx8q87iiAhxlTGbK+UOYHPVBvoMI/+f4NYVCFoFPjhRJ
         0xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtqTatYVCXnVJXxjymt/1n44U2yhdYmydkzTPyVBlaQ=;
        b=pgQBOS04+0pTPeMfsBi4JhzIsYoP7CKhVxB76Sf/QlFo4rwNT1zhPs595fZ7gneJAw
         LuMiEeIaW/+4gGAm49xAhCTuAB+ZdT03KJ5wSlHWSfdZdhkHGQDt6cDdyJ0SaJnddfmj
         k4Qi4t3upFAyoIgqMMFv+3KDwfAqDzAuvHd3cRY3mFPC6nP5YyTMnVAfdezNKvSfnZj/
         2mi/FCtWXI8HPEvt+qSnImlcVchuoQ5ShfilurYdRKgK0iFR9EVlgQi+nkXgTNZof1ZQ
         cWSOJ7CkFXiwMef9s/KrclyfttYJoX3tfVYhVbQOZ6U/GLMG587LfhFzQRS+xQiKJg2G
         CPkw==
X-Gm-Message-State: AOAM5307hjlJnxZSAU2RpS3+K0TnNZP7TFr49mh/LfiM4DLRcyzIVohh
        ceoJMVLuZ62k4Xk1eUI+XdTiT9Qmuqy/8w==
X-Google-Smtp-Source: ABdhPJzffId8v97ez3kT7lIk72imsEi+0JttBZNjZVy9O2ShDt54ABnRoNl1eZuCN+iciRHsrlVZjw==
X-Received: by 2002:a05:600c:204f:: with SMTP id p15mr22797261wmg.165.1615216048562;
        Mon, 08 Mar 2021 07:07:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:27 -0800 (PST)
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
Subject: [PATCH 23/30] tree-walk.h API: add a get_tree_entry_path() function
Date:   Mon,  8 Mar 2021 16:06:43 +0100
Message-Id: <20210308150650.18626-24-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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

There's callers here which doesn't need the "struct object_id" filled
either, and provides a throwaway variable for us.

See the following commits for the introduction of such code that's
being modified here:

 - shift_tree(): 68faf68938e (A new merge stragety 'subtree'.,
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
index ce3f811ec04..60a17b92d70 100644
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
index 0e891360e7e..b26d9d418f9 100644
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
index ef138606146..aa46cb2b09e 100644
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
index 0ad3d80593e..83737634770 100644
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
index 5db38fcb575..1bfa839b275 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -175,10 +175,13 @@ struct traverse_info {
  * "struct name_entry" you'd like. You always need to pointer to an
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
2.31.0.rc0.126.g04f22c5b82

