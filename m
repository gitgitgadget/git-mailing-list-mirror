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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35946C4360C
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247BB65032
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhCPCOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbhCPCN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B1C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g20so9230868wmk.3
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ryoV5IbSkKJau7LUOtTZnxmmT3fEioGNnFuVrerEymA=;
        b=XrtDm6I2QWn7vq1729DZGqQ9t++fQauhytiyJijlircUegRbGlULSIcdMuUsDWutro
         6stPZ3rqM+V75z6TH9cL9HEebN2Fm5RatA0dmjm/vBRIKevnhCZuHS+RGvnLvw9T6LM6
         nft6yQZHwhNpS74wJqJBb17no167RXTfptsTcBXpCxuZu45i25A4HWngE8Nhug/FZmgE
         0hVg4kgca/OO8TeCFFt9F5sYfXjCNv7NwBQKjya3runf1tIyygN8QcRu7fobwS1qkaML
         NJm8aT22uyifda3jIC2w4YRBzEI6hNtEQaxFsRGqsjNebRczPWNQfKBcTi4DMsqRn6Zv
         FGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ryoV5IbSkKJau7LUOtTZnxmmT3fEioGNnFuVrerEymA=;
        b=RgvpZC5U9DaT2XiL7PxujHYASeUrkgZhgXUten89bJ7Y1AYf417qrqMVqWw9lZqKVS
         Fr3lS/Ni8gLi39zipjCoU/R5rlLgethu71P9OJiBgL0Hb7bLvHm3gXS8RTr6KXH8PBRA
         5iU4RCKyBlYst1KOSfspi12l1nAxhc1Qf6o8105O5S7b/UFp7DeCWHOd3T8jgbJQ2zu0
         eVGTsyStriO5m+KL9Mix8IPxAsjz1xdgxT+pS+/4qzhpf0dvVi2Z1tC713VPmpGMIFZS
         0RDCASh/FAuyBPyUCMAOuf2FkfvYmDuwiAuoYsKxA8dcnualVstEozBYEZRHd2/4fOgR
         Vcpw==
X-Gm-Message-State: AOAM530gaF5nSvD/rdkzHByod8ROMnl9W7rOVlXP564N71Qrwym51LHo
        1OAyrumBPn9zxaHn3/IWfwO5DqK9UQhAeQ==
X-Google-Smtp-Source: ABdhPJw0UHvNa6MOMNqUfvWUn3xYe3d7N9icB/tHpR7E9+aCuz3pqpFFYKCEc57iDXwjmEDru54F0w==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr2264700wmq.60.1615860834623;
        Mon, 15 Mar 2021 19:13:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:54 -0700 (PDT)
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
Subject: [PATCH v2 27/29] tree-walk.h API: add a get_tree_entry_path() function
Date:   Tue, 16 Mar 2021 03:13:10 +0100
Message-Id: <20210316021312.13927-28-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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
index bbbb68e15bc..83d2b8b8440 100644
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
2.31.0.rc2.211.g1d0b8788b3

