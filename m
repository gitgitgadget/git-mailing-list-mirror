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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E64C433F2
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8F5601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCUACQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCUABg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D78C061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t4so2419633wrn.11
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQsDIqhsnFgfM2pTtgpyw209k/GK4YVOBLdHWTnw31A=;
        b=enGwJkYCmoUc5ow62Wp8WJkUQMf87aa+SltMu6htQr6m00OXpKRHA6Gqs75yJp2MN0
         TMIqoBUl+TxFb9Ql1tM9j9dizoY5NK/TWYDyV6hUGMNwJaLiMI4y/Al9g7OpUbrlyjxo
         9XqfloxMFE7S2GRtSIsJCGSL3CDXFjM15DGAXESjqDqSHCmOeRr7v2vwlvvh2dMruj+3
         YvGXd2/lI9jTxoJp7RomxaMHbfzUx3XCp27ryNc0L6mQzTE0JdhaphfSnoCY7Hk3e3ve
         d4196vpS3skX+AcRhDrnEBlSWkSebKvSn5px7JTx+0P1ffHnEmEgxkG/iZ/mf82HAHw1
         MMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQsDIqhsnFgfM2pTtgpyw209k/GK4YVOBLdHWTnw31A=;
        b=jpgpcIpeM5Ay+Uv4OU4rTNUWVSwlGk7EqG5Q6d4yr5S87cDDoIcUH80zduEKQqduux
         4MSEVXuyqFTYyxG057n/zfIT/Bi1t8ZUxFqtSoF9+VPR11+h0ymM+kaQbkVFVSiZI4wQ
         8rsMDkwAIKjPITWksLmwItkA1R3h/sMb6gEzVBWi28lyzgx85gvZtrY8xQEtWt6LH8b0
         QUcIYlfmm118xe1fTQZEz6sN9KquSbeGuzQkJyLEdpxVCiEU7rPzoIZFi18Cw6ldcFs2
         dTezQ4qJOHSzLPkpo3McYzsDaVoq1W8Mt1PI6TiakpzpyOBiGITQyVJFmBDJje3rzYq9
         OcBQ==
X-Gm-Message-State: AOAM533MXdxu8oZAH4X8uMlq5LYPklavlUQcjl+gafwQl0QqJweOoRz3
        o5jOIs2JbsKHE/vmapIBVCmMbARLYbZDeg==
X-Google-Smtp-Source: ABdhPJwi5hRISQV/Johi8Mflvclj4eJlXdiJyhllbrPq0SlheiSXu5cRyGb0nxIg4L52yCzqUsD8UA==
X-Received: by 2002:adf:fbcc:: with SMTP id d12mr11077072wrs.151.1616284894589;
        Sat, 20 Mar 2021 17:01:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:34 -0700 (PDT)
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
Subject: [PATCH v4 11/29] tree.h API: make read_tree_fn_t take an "enum object_type"
Date:   Sun, 21 Mar 2021 01:00:44 +0100
Message-Id: <152c6d88542cbf88367f5a67b677c9ad293d28c0.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the users of the read_tree_fn_t callback do not care about the
"mode" per-se, they just care what type it resolves to.

Amend this callback mechanism added in 3c5e8468a93 (ls-tree: major
rewrite to do pathspec, 2005-11-26) to pass the object_type, and use
it whenever possible.

In the archive.c code we could go much deeper with this refactoring,
after getting the "mode" that code will pass it around itself and into
archive-{tar,zip}.c. As far as I can tell we could drop the mode
early, and just pass "enum_object_type type, int is_executable". That
would be slightly redundant space-wise, but would assure us that we're
not writing out raw modes found in trees, but are normalizing them.

But that particular refactoring would be larger than what I'm trying
to accomplish here, so let's leave it for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c          |  8 ++++----
 builtin/checkout.c |  4 ++--
 builtin/log.c      |  4 ++--
 builtin/ls-files.c |  6 ++++--
 builtin/ls-tree.c  | 12 +++++-------
 merge-recursive.c  |  6 ++++--
 tree.c             | 19 ++++++++++++-------
 tree.h             |  2 +-
 8 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/archive.c b/archive.c
index feed5c02fb2..ca28d6ca3b8 100644
--- a/archive.c
+++ b/archive.c
@@ -230,7 +230,7 @@ static int write_directory(struct archiver_context *c)
 
 static int queue_or_write_archive_entry(const struct object_id *oid,
 					struct strbuf *base, const char *filename,
-					unsigned mode,
+					enum object_type object_type, unsigned mode,
 					void *context)
 {
 	struct archiver_context *c = context;
@@ -243,7 +243,7 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 		c->bottom = next;
 	}
 
-	if (S_ISDIR(mode)) {
+	if (object_type == OBJ_TREE) {
 		size_t baselen = base->len;
 		const struct attr_check *check;
 
@@ -378,13 +378,13 @@ struct path_exists_context {
 
 static int reject_entry(const struct object_id *oid, struct strbuf *base,
 			const char *filename,
-			unsigned mode,
+			enum object_type object_type, unsigned mode,
 			void *context)
 {
 	int ret = -1;
 	struct path_exists_context *ctx = context;
 
-	if (S_ISDIR(mode)) {
+	if (object_type == OBJ_TREE) {
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addbuf(&sb, base);
 		strbuf_addstr(&sb, filename);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0887352db2a..95b2b0edf22 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -115,14 +115,14 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
 		       const char *pathname,
-		       unsigned mode,
+		       enum object_type object_type, unsigned mode,
 		       void *context)
 {
 	int len;
 	struct cache_entry *ce;
 	int pos;
 
-	if (S_ISDIR(mode))
+	if (object_type == OBJ_TREE)
 		return READ_TREE_RECURSIVE;
 
 	len = base->len + strlen(pathname);
diff --git a/builtin/log.c b/builtin/log.c
index b7b76856a9f..c25f75472ff 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -599,11 +599,11 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 
 static int show_tree_object(const struct object_id *oid,
 			    struct strbuf *base, const char *pathname,
-			    unsigned mode,
+			    enum object_type object_type, unsigned mode,
 			    void *context)
 {
 	FILE *file = context;
-	fprintf(file, "%s%s\n", pathname, S_ISDIR(mode) ? "/" : "");
+	fprintf(file, "%s%s\n", pathname, object_type == OBJ_TREE ? "/" : "");
 	return 0;
 }
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 60a2913a01e..cb217870cbd 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -446,7 +446,8 @@ static int read_one_entry_opt(struct index_state *istate,
 }
 
 static int read_one_entry(const struct object_id *oid, struct strbuf *base,
-			  const char *pathname, unsigned mode,
+			  const char *pathname,
+			  enum object_type object_type, unsigned mode,
 			  void *context)
 {
 	struct index_state *istate = context;
@@ -460,7 +461,8 @@ static int read_one_entry(const struct object_id *oid, struct strbuf *base,
  * the stage that will conflict with the entry being added.
  */
 static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
-				const char *pathname, unsigned mode,
+				const char *pathname,
+				enum object_type object_type, unsigned mode,
 				void *context)
 {
 	struct index_state *istate = context;
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8d5c3fd0582..7176d2ae065 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -63,14 +63,13 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		     const char *pathname,
-		     unsigned mode,
+		     enum object_type object_type, unsigned mode,
 		     void *context)
 {
 	int retval = 0;
 	int baselen;
-	const char *type = blob_type;
 
-	if (S_ISGITLINK(mode)) {
+	if (object_type == OBJ_COMMIT) {
 		/*
 		 * Maybe we want to have some recursive version here?
 		 *
@@ -80,22 +79,21 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			retval = READ_TREE_RECURSIVE;
 		 *
 		 */
-		type = commit_type;
-	} else if (S_ISDIR(mode)) {
+	} else if (object_type == OBJ_TREE) {
 		if (show_recursive(base->buf, base->len, pathname)) {
 			retval = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
 				return retval;
 		}
-		type = tree_type;
 	}
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
 
 	if (!(ls_options & LS_NAME_ONLY)) {
+		const char *type = type_name(object_type);
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
-			if (!strcmp(type, blob_type)) {
+			if (object_type == OBJ_BLOB) {
 				unsigned long size;
 				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
diff --git a/merge-recursive.c b/merge-recursive.c
index 57198b29fe7..6bc1e659a7b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -453,7 +453,7 @@ static void unpack_trees_finish(struct merge_options *opt)
 
 static int save_files_dirs(const struct object_id *oid,
 			   struct strbuf *base, const char *path,
-			   unsigned int mode,
+			   enum object_type object_type, unsigned int mode,
 			   void *context)
 {
 	struct path_hashmap_entry *entry;
@@ -467,7 +467,9 @@ static int save_files_dirs(const struct object_id *oid,
 	hashmap_add(&opt->priv->current_file_dir_set, &entry->e);
 
 	strbuf_setlen(base, baselen);
-	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
+	if (object_type != OBJ_TREE)
+		return 0;
+	return READ_TREE_RECURSIVE;
 }
 
 static void get_files_dirs(struct merge_options *opt, struct tree *tree)
diff --git a/tree.c b/tree.c
index 410e3b477e5..f48b170090f 100644
--- a/tree.c
+++ b/tree.c
@@ -28,6 +28,8 @@ int read_tree_at(struct repository *r,
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
+		struct commit *commit;
+
 		if (retval != all_entries_interesting) {
 			retval = tree_entry_interesting(r->index, &entry,
 							base, 0, pathspec);
@@ -38,7 +40,7 @@ int read_tree_at(struct repository *r,
 		}
 
 		switch (fn(&entry.oid, base,
-			   entry.path, entry.mode, context)) {
+			   entry.path, entry.object_type, entry.mode, context)) {
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
@@ -47,11 +49,11 @@ int read_tree_at(struct repository *r,
 			return -1;
 		}
 
-		if (S_ISDIR(entry.mode))
+		switch (entry.object_type) {
+		case OBJ_TREE:
 			oidcpy(&oid, &entry.oid);
-		else if (S_ISGITLINK(entry.mode)) {
-			struct commit *commit;
-
+			break;
+		case OBJ_COMMIT:
 			commit = lookup_commit(r, &entry.oid);
 			if (!commit)
 				die("Commit %s in submodule path %s%s not found",
@@ -64,9 +66,12 @@ int read_tree_at(struct repository *r,
 				    base->buf, entry.path);
 
 			oidcpy(&oid, get_commit_tree_oid(commit));
-		}
-		else
+			break;
+		case OBJ_BLOB:
 			continue;
+		default:
+			BUG("unreachable");
+		}
 
 		len = tree_entry_len(&entry);
 		strbuf_add(base, entry.path, len);
diff --git a/tree.h b/tree.h
index 10c8637ab3e..1675da7e85c 100644
--- a/tree.h
+++ b/tree.h
@@ -33,7 +33,7 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *,
 			      const char *,
-			      unsigned int,
+			      enum object_type, unsigned int,
 			      void *);
 
 int read_tree_at(struct repository *r,
-- 
2.31.0.286.gc175f2cb894

