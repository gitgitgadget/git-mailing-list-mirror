Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C531F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeA1ANd (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:13:33 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34407 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeA1AN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:13:29 -0500
Received: by mail-lf0-f67.google.com with SMTP id k19so5061911lfj.1
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=TUFN2zhPoe2D4Ox+/gbbRhKv0LPtspsfR3iGN2e6iZE=;
        b=JhmF3F0goFAdW4GGPzbX7Nj/09Y5dk3/iMVJSbT1WbbxZ1ZoQYmYW2gFEEgihBmPle
         +RA1yDdcHS7rvv4icVpOZPoX8YLY+rSKNV2W5duzPk/P9R36Zs6rGNCsGzn8vzoCf5x8
         T+CRbnaMbWja6/8nhIOPaqF72sLHC/K0Iy477m2nNmScXZYhxE3OQAzJH0orNYZawwj6
         05dqO5WWhuOUjqXZFiDS7ISrc8V/cCjQQW1Q8BLPaMkyBi9wapGWpZTSpNjSj5z/7Ve/
         YRxHlMaBeLY6i9CYzwr8DVihI82StGdfRaGQylNbn89Qw76ZqhJCKSHlxGqUXSRRIT8U
         IGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TUFN2zhPoe2D4Ox+/gbbRhKv0LPtspsfR3iGN2e6iZE=;
        b=Ec/Q6FneQYeLtVyUDwlStiwYLTPr2Xzwj5LeFULmpefJfqAhKHNeOPuZslUtFHVqBO
         mmrMSRsBFF6e8NAzxqR2I/joKi1qkHGhGpUvGqO0FCh0S0LP+fsKRREvwGT59X39fwHO
         b9BU618+yD1MxeEl22QQ9rtBRpWh5fJeo2CmfTFpFYXv2+5awg4QFBRGW3p90DiX0KYg
         AlyznTLyust9HMw9epeRrI8QgKVdPrBEMwhiJ+s+geyAUR8sBM/gbwCy6zr1kR27MnX0
         yNrC1bxGAsKG4J6sbfch8i/UVW4aRqzCpb9EGJQSQtIqbLanhpOeX3pnOrFMS7N3Yso0
         A0aQ==
X-Gm-Message-State: AKwxytc//TsbrPsVWucaygAk8bzayuXMwqoM2XRmKIGaK80tH0r8YRS+
        i/1Bkrlw38hojs5exoErigjoUjLp
X-Google-Smtp-Source: AH8x2243u4ZrNvMnsURikuAmF9ZlJnvjYd3RabW1BBIqYFkLCLEMbv6609Kgy6xFi9loiopOG9WEAg==
X-Received: by 10.46.21.68 with SMTP id 4mr11378670ljv.122.1517098407174;
        Sat, 27 Jan 2018 16:13:27 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id y26sm2144695lfk.30.2018.01.27.16.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:13:26 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 02/12] dir: convert struct sha1_stat to use object_id
Date:   Sun, 28 Jan 2018 01:13:12 +0100
Message-Id: <f5f66d8ac64eccbd3741a6163cdc23629a6208c4.1517097306.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
 <cover.1517097306.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1517097306.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the declaration of struct sha1_stat. Adjust all usages of this
struct and replace hash{clr,cmp,cpy} with oid{clr,cmp,cpy} wherever
possible.  Rename it to struct oid_stat.

Rename static function load_sha1_stat to load_oid_stat.

Remove macro EMPTY_BLOB_SHA1_BIN, as it's no longer used.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 cache.h                              |   2 -
 dir.c                                | 104 +++++++++++++++++------------------
 dir.h                                |  12 ++--
 t/helper/test-dump-untracked-cache.c |   4 +-
 4 files changed, 58 insertions(+), 64 deletions(-)

diff --git a/cache.h b/cache.h
index e4e03ac51d..ed72933ba7 100644
--- a/cache.h
+++ b/cache.h
@@ -1047,8 +1047,6 @@ extern const struct object_id empty_tree_oid;
 	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
 	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
 extern const struct object_id empty_blob_oid;
-#define EMPTY_BLOB_SHA1_BIN (empty_blob_oid.hash)
-
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
 {
diff --git a/dir.c b/dir.c
index 7c4b45e30e..22cadbda9d 100644
--- a/dir.c
+++ b/dir.c
@@ -231,12 +231,10 @@ int within_depth(const char *name, int namelen,
  *     1 along with { data, size } of the (possibly augmented) buffer
  *       when successful.
  *
- * Optionally updates the given sha1_stat with the given OID (when valid).
+ * Optionally updates the given oid_stat with the given OID (when valid).
  */
-static int do_read_blob(const struct object_id *oid,
-			struct sha1_stat *sha1_stat,
-			size_t *size_out,
-			char **data_out)
+static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
+			size_t *size_out, char **data_out)
 {
 	enum object_type type;
 	unsigned long sz;
@@ -251,9 +249,9 @@ static int do_read_blob(const struct object_id *oid,
 		return -1;
 	}
 
-	if (sha1_stat) {
-		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
-		hashcpy(sha1_stat->sha1, oid->hash);
+	if (oid_stat) {
+		memset(&oid_stat->stat, 0, sizeof(oid_stat->stat));
+		oidcpy(&oid_stat->oid, oid);
 	}
 
 	if (sz == 0) {
@@ -654,9 +652,8 @@ void add_exclude(const char *string, const char *base,
 
 static int read_skip_worktree_file_from_index(const struct index_state *istate,
 					      const char *path,
-					      size_t *size_out,
-					      char **data_out,
-					      struct sha1_stat *sha1_stat)
+					      size_t *size_out, char **data_out,
+					      struct oid_stat *oid_stat)
 {
 	int pos, len;
 
@@ -667,7 +664,7 @@ static int read_skip_worktree_file_from_index(const struct index_state *istate,
 	if (!ce_skip_worktree(istate->cache[pos]))
 		return -1;
 
-	return do_read_blob(&istate->cache[pos]->oid, sha1_stat, size_out, data_out);
+	return do_read_blob(&istate->cache[pos]->oid, oid_stat, size_out, data_out);
 }
 
 /*
@@ -795,9 +792,8 @@ static int add_excludes_from_buffer(char *buf, size_t size,
  * ss_valid is non-zero, "ss" must contain good value as input.
  */
 static int add_excludes(const char *fname, const char *base, int baselen,
-			struct exclude_list *el,
-			struct index_state *istate,
-			struct sha1_stat *sha1_stat)
+			struct exclude_list *el, struct index_state *istate,
+			struct oid_stat *oid_stat)
 {
 	struct stat st;
 	int r;
@@ -815,16 +811,16 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 			return -1;
 		r = read_skip_worktree_file_from_index(istate, fname,
 						       &size, &buf,
-						       sha1_stat);
+						       oid_stat);
 		if (r != 1)
 			return r;
 	} else {
 		size = xsize_t(st.st_size);
 		if (size == 0) {
-			if (sha1_stat) {
-				fill_stat_data(&sha1_stat->stat, &st);
-				hashcpy(sha1_stat->sha1, EMPTY_BLOB_SHA1_BIN);
-				sha1_stat->valid = 1;
+			if (oid_stat) {
+				fill_stat_data(&oid_stat->stat, &st);
+				oidcpy(&oid_stat->oid, &empty_blob_oid);
+				oid_stat->valid = 1;
 			}
 			close(fd);
 			return 0;
@@ -837,22 +833,23 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		}
 		buf[size++] = '\n';
 		close(fd);
-		if (sha1_stat) {
+		if (oid_stat) {
 			int pos;
-			if (sha1_stat->valid &&
-			    !match_stat_data_racy(istate, &sha1_stat->stat, &st))
+			if (oid_stat->valid &&
+			    !match_stat_data_racy(istate, &oid_stat->stat, &st))
 				; /* no content change, ss->sha1 still good */
 			else if (istate &&
 				 (pos = index_name_pos(istate, fname, strlen(fname))) >= 0 &&
 				 !ce_stage(istate->cache[pos]) &&
 				 ce_uptodate(istate->cache[pos]) &&
 				 !would_convert_to_git(istate, fname))
-				hashcpy(sha1_stat->sha1,
-					istate->cache[pos]->oid.hash);
+				oidcpy(&oid_stat->oid,
+				       &istate->cache[pos]->oid);
 			else
-				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
-			fill_stat_data(&sha1_stat->stat, &st);
-			sha1_stat->valid = 1;
+				hash_sha1_file(buf, size, "blob",
+					       oid_stat->oid.hash);
+			fill_stat_data(&oid_stat->stat, &st);
+			oid_stat->valid = 1;
 		}
 	}
 
@@ -930,7 +927,7 @@ struct exclude_list *add_exclude_list(struct dir_struct *dir,
  * Used to set up core.excludesfile and .git/info/exclude lists.
  */
 static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
-				     struct sha1_stat *sha1_stat)
+				     struct oid_stat *oid_stat)
 {
 	struct exclude_list *el;
 	/*
@@ -941,7 +938,7 @@ static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
 	if (!dir->untracked)
 		dir->unmanaged_exclude_files++;
 	el = add_exclude_list(dir, EXC_FILE, fname);
-	if (add_excludes(fname, "", 0, el, NULL, sha1_stat) < 0)
+	if (add_excludes(fname, "", 0, el, NULL, oid_stat) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
 
@@ -1180,7 +1177,7 @@ static void prep_exclude(struct dir_struct *dir,
 
 	while (current < baselen) {
 		const char *cp;
-		struct sha1_stat sha1_stat;
+		struct oid_stat oid_stat;
 
 		stk = xcalloc(1, sizeof(*stk));
 		if (current < 0) {
@@ -1223,8 +1220,8 @@ static void prep_exclude(struct dir_struct *dir,
 		}
 
 		/* Try to read per-directory file */
-		hashclr(sha1_stat.sha1);
-		sha1_stat.valid = 0;
+		oidclr(&oid_stat.oid);
+		oid_stat.valid = 0;
 		if (dir->exclude_per_dir &&
 		    /*
 		     * If we know that no files have been added in
@@ -1252,7 +1249,7 @@ static void prep_exclude(struct dir_struct *dir,
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			el->src = strbuf_detach(&sb, NULL);
 			add_excludes(el->src, el->src, stk->baselen, el, istate,
-				     untracked ? &sha1_stat : NULL);
+				     untracked ? &oid_stat : NULL);
 		}
 		/*
 		 * NEEDSWORK: when untracked cache is enabled, prep_exclude()
@@ -1269,9 +1266,9 @@ static void prep_exclude(struct dir_struct *dir,
 		 * order, though, if you do that.
 		 */
 		if (untracked &&
-		    hashcmp(sha1_stat.sha1, untracked->exclude_sha1)) {
+		    hashcmp(oid_stat.oid.hash, untracked->exclude_sha1)) {
 			invalidate_gitignore(dir->untracked, untracked);
-			hashcpy(untracked->exclude_sha1, sha1_stat.sha1);
+			hashcpy(untracked->exclude_sha1, oid_stat.oid.hash);
 		}
 		dir->exclude_stack = stk;
 		current = stk->baselen;
@@ -2228,13 +2225,13 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 
 	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
 	root = dir->untracked->root;
-	if (hashcmp(dir->ss_info_exclude.sha1,
-		    dir->untracked->ss_info_exclude.sha1)) {
+	if (oidcmp(&dir->ss_info_exclude.oid,
+		   &dir->untracked->ss_info_exclude.oid)) {
 		invalidate_gitignore(dir->untracked, root);
 		dir->untracked->ss_info_exclude = dir->ss_info_exclude;
 	}
-	if (hashcmp(dir->ss_excludes_file.sha1,
-		    dir->untracked->ss_excludes_file.sha1)) {
+	if (oidcmp(&dir->ss_excludes_file.oid,
+		   &dir->untracked->ss_excludes_file.oid)) {
 		invalidate_gitignore(dir->untracked, root);
 		dir->untracked->ss_excludes_file = dir->ss_excludes_file;
 	}
@@ -2638,8 +2635,8 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	FLEX_ALLOC_MEM(ouc, exclude_per_dir, untracked->exclude_per_dir, len);
 	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_info_exclude.stat);
 	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_excludes_file.stat);
-	hashcpy(ouc->info_exclude_sha1, untracked->ss_info_exclude.sha1);
-	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.sha1);
+	hashcpy(ouc->info_exclude_sha1, untracked->ss_info_exclude.oid.hash);
+	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.oid.hash);
 	ouc->dir_flags = htonl(untracked->dir_flags);
 
 	varint_len = encode_varint(untracked->ident.len, varbuf);
@@ -2816,13 +2813,12 @@ static void read_sha1(size_t pos, void *cb)
 	rd->data += 20;
 }
 
-static void load_sha1_stat(struct sha1_stat *sha1_stat,
-			   const unsigned char *data,
-			   const unsigned char *sha1)
+static void load_oid_stat(struct oid_stat *oid_stat, const unsigned char *data,
+			  const unsigned char *sha1)
 {
-	stat_data_from_disk(&sha1_stat->stat, data);
-	hashcpy(sha1_stat->sha1, sha1);
-	sha1_stat->valid = 1;
+	stat_data_from_disk(&oid_stat->stat, data);
+	hashcpy(oid_stat->oid.hash, sha1);
+	oid_stat->valid = 1;
 }
 
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
@@ -2850,12 +2846,12 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	uc = xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, ident_len);
 	strbuf_add(&uc->ident, ident, ident_len);
-	load_sha1_stat(&uc->ss_info_exclude,
-		       next + ouc_offset(info_exclude_stat),
-		       next + ouc_offset(info_exclude_sha1));
-	load_sha1_stat(&uc->ss_excludes_file,
-		       next + ouc_offset(excludes_file_stat),
-		       next + ouc_offset(excludes_file_sha1));
+	load_oid_stat(&uc->ss_info_exclude,
+		      next + ouc_offset(info_exclude_stat),
+		      next + ouc_offset(info_exclude_sha1));
+	load_oid_stat(&uc->ss_excludes_file,
+		      next + ouc_offset(excludes_file_stat),
+		      next + ouc_offset(excludes_file_sha1));
 	uc->dir_flags = get_be32(next + ouc_offset(dir_flags));
 	exclude_per_dir = (const char *)next + ouc_offset(exclude_per_dir);
 	uc->exclude_per_dir = xstrdup(exclude_per_dir);
diff --git a/dir.h b/dir.h
index 11a047ba48..e7bb786a33 100644
--- a/dir.h
+++ b/dir.h
@@ -74,9 +74,9 @@ struct exclude_list_group {
 	struct exclude_list *el;
 };
 
-struct sha1_stat {
+struct oid_stat {
 	struct stat_data stat;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int valid;
 };
 
@@ -124,8 +124,8 @@ struct untracked_cache_dir {
 };
 
 struct untracked_cache {
-	struct sha1_stat ss_info_exclude;
-	struct sha1_stat ss_excludes_file;
+	struct oid_stat ss_info_exclude;
+	struct oid_stat ss_excludes_file;
 	const char *exclude_per_dir;
 	struct strbuf ident;
 	/*
@@ -195,8 +195,8 @@ struct dir_struct {
 
 	/* Enable untracked file cache if set */
 	struct untracked_cache *untracked;
-	struct sha1_stat ss_info_exclude;
-	struct sha1_stat ss_excludes_file;
+	struct oid_stat ss_info_exclude;
+	struct oid_stat ss_excludes_file;
 	unsigned unmanaged_exclude_files;
 };
 
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index f752532ffb..d7c55c2355 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -54,8 +54,8 @@ int cmd_main(int ac, const char **av)
 		printf("no untracked cache\n");
 		return 0;
 	}
-	printf("info/exclude %s\n", sha1_to_hex(uc->ss_info_exclude.sha1));
-	printf("core.excludesfile %s\n", sha1_to_hex(uc->ss_excludes_file.sha1));
+	printf("info/exclude %s\n", oid_to_hex(&uc->ss_info_exclude.oid));
+	printf("core.excludesfile %s\n", oid_to_hex(&uc->ss_excludes_file.oid));
 	printf("exclude_per_dir %s\n", uc->exclude_per_dir);
 	printf("flags %08x\n", uc->dir_flags);
 	if (uc->root)
-- 
2.14.3

