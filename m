Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDA01F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbeAXLNA (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:13:00 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38198 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933137AbeAXLMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:16 -0500
Received: by mail-lf0-f65.google.com with SMTP id g72so4716732lfg.5
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=xkUSt3o/zE896A/7jt51Jj6+GAy6ID6bl3aLeAfAlHo=;
        b=Wq9bIqFG+3Bdnjzan1/lNWWD0xqpKOzAFhiqIL9Pacl9iu0CVXfB/ZuEwlgNEpvV01
         jTJA7CIG0SfEYDvbHLvtbeIAqtZrPrZbY0Jc1z//UTkmkwxNL4eFTG0ushOMpQFooVQ8
         Nbnhxzo/v4cbYQh/Q4UYIW2bzrKPkIySBpGkZO40A5PTA90XJsVlORDcDIHcLLUc5hOZ
         izIMvApLpNy6HPIJjpVexmaUG3PcpfwZmdR1x7lWnZOHJ42xj5lTZbxu+lae1WXKpxL2
         fpv8oin1Jr2zp9hHTRfEl/LK70zhBudUIFriXKqa/3jSKkrpmNzsbgU6uRfiLrOKR519
         AOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xkUSt3o/zE896A/7jt51Jj6+GAy6ID6bl3aLeAfAlHo=;
        b=ssPsPfZReRJ69DKF39Qdy2Us6Q2h/pi8m3VIICPlNd4MFy1RikGCiFiYRN0iGLs43g
         tIHtHvy9+AuQEw/fZSEbFtGxNifYFrrUDE5DMQfrv0qV+R2crRVFNfSNIGeq1lA5v3ou
         iyQ19PiFsAacAD+i5VessgEL+MtkLd/JBxYTp92frT4nTI+hBeWMJ4xF26rCfKa2Hibz
         Alu6yTZc0rVU2PzudazQRFxXTlhChRq+Rqqn82F9i8OvoZ5Q+H03PkTqJAfB0Yo2nnJQ
         yZ4DviwEwiONRwEFmmgtRD3QKj/FuXbJrNNrVk7CFMkBFHAuzWXhITs2foGZIPIxUM26
         +OFA==
X-Gm-Message-State: AKwxytdEvKlm1JmBITlPIbbifXRA0oAZyMy7QVmmFhnUB/Y8ATLTvQhj
        sVkQncfTaz+i96/3Wtzwh+HMBEMN
X-Google-Smtp-Source: AH8x224ln2HHnGXCwBdFm6Ob1pXl7RtHDr+sIONxOnDyoO8IHoHchWqvNhiUUbJpQW3HyEME14lwwQ==
X-Received: by 10.46.60.10 with SMTP id j10mr3521943lja.111.1516792333499;
        Wed, 24 Jan 2018 03:12:13 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:12 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 04/14] dir: convert struct sha1_stat to use object_id
Date:   Wed, 24 Jan 2018 12:11:56 +0100
Message-Id: <d7d2ff4d0d18ff381d023d0d2451d161d74a191c.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the declaration of struct sha1_stat. Adjust all usages of this
struct and replace hash{clr,cmp,cpy} with oid{clr,cmp,cpy} wherever
possible.  Rename it to struct oid_stat.

Remove macro EMPTY_BLOB_SHA1_BIN, as it's no longer used.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 cache.h                              |  2 --
 dir.c                                | 56 +++++++++++++++++-------------------
 dir.h                                | 12 ++++----
 t/helper/test-dump-untracked-cache.c |  4 +--
 4 files changed, 34 insertions(+), 40 deletions(-)

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
index 7c4b45e30e..ef977b8657 100644
--- a/dir.c
+++ b/dir.c
@@ -233,10 +233,8 @@ int within_depth(const char *name, int namelen,
  *
  * Optionally updates the given sha1_stat with the given OID (when valid).
  */
-static int do_read_blob(const struct object_id *oid,
-			struct sha1_stat *sha1_stat,
-			size_t *size_out,
-			char **data_out)
+static int do_read_blob(const struct object_id *oid, struct oid_stat *sha1_stat,
+			size_t *size_out, char **data_out)
 {
 	enum object_type type;
 	unsigned long sz;
@@ -253,7 +251,7 @@ static int do_read_blob(const struct object_id *oid,
 
 	if (sha1_stat) {
 		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
-		hashcpy(sha1_stat->sha1, oid->hash);
+		oidcpy(&sha1_stat->oid, oid);
 	}
 
 	if (sz == 0) {
@@ -654,9 +652,8 @@ void add_exclude(const char *string, const char *base,
 
 static int read_skip_worktree_file_from_index(const struct index_state *istate,
 					      const char *path,
-					      size_t *size_out,
-					      char **data_out,
-					      struct sha1_stat *sha1_stat)
+					      size_t *size_out, char **data_out,
+					      struct oid_stat *sha1_stat)
 {
 	int pos, len;
 
@@ -795,9 +792,8 @@ static int add_excludes_from_buffer(char *buf, size_t size,
  * ss_valid is non-zero, "ss" must contain good value as input.
  */
 static int add_excludes(const char *fname, const char *base, int baselen,
-			struct exclude_list *el,
-			struct index_state *istate,
-			struct sha1_stat *sha1_stat)
+			struct exclude_list *el, struct index_state *istate,
+			struct oid_stat *sha1_stat)
 {
 	struct stat st;
 	int r;
@@ -823,7 +819,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		if (size == 0) {
 			if (sha1_stat) {
 				fill_stat_data(&sha1_stat->stat, &st);
-				hashcpy(sha1_stat->sha1, EMPTY_BLOB_SHA1_BIN);
+				oidcpy(&sha1_stat->oid, &empty_blob_oid);
 				sha1_stat->valid = 1;
 			}
 			close(fd);
@@ -847,10 +843,11 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 				 !ce_stage(istate->cache[pos]) &&
 				 ce_uptodate(istate->cache[pos]) &&
 				 !would_convert_to_git(istate, fname))
-				hashcpy(sha1_stat->sha1,
-					istate->cache[pos]->oid.hash);
+				oidcpy(&sha1_stat->oid,
+				       &istate->cache[pos]->oid);
 			else
-				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
+				hash_sha1_file(buf, size, "blob",
+					       sha1_stat->oid.hash);
 			fill_stat_data(&sha1_stat->stat, &st);
 			sha1_stat->valid = 1;
 		}
@@ -930,7 +927,7 @@ struct exclude_list *add_exclude_list(struct dir_struct *dir,
  * Used to set up core.excludesfile and .git/info/exclude lists.
  */
 static void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
-				     struct sha1_stat *sha1_stat)
+				     struct oid_stat *sha1_stat)
 {
 	struct exclude_list *el;
 	/*
@@ -1180,7 +1177,7 @@ static void prep_exclude(struct dir_struct *dir,
 
 	while (current < baselen) {
 		const char *cp;
-		struct sha1_stat sha1_stat;
+		struct oid_stat sha1_stat;
 
 		stk = xcalloc(1, sizeof(*stk));
 		if (current < 0) {
@@ -1223,7 +1220,7 @@ static void prep_exclude(struct dir_struct *dir,
 		}
 
 		/* Try to read per-directory file */
-		hashclr(sha1_stat.sha1);
+		oidclr(&sha1_stat.oid);
 		sha1_stat.valid = 0;
 		if (dir->exclude_per_dir &&
 		    /*
@@ -1269,9 +1266,9 @@ static void prep_exclude(struct dir_struct *dir,
 		 * order, though, if you do that.
 		 */
 		if (untracked &&
-		    hashcmp(sha1_stat.sha1, untracked->exclude_sha1)) {
+		    hashcmp(sha1_stat.oid.hash, untracked->exclude_sha1)) {
 			invalidate_gitignore(dir->untracked, untracked);
-			hashcpy(untracked->exclude_sha1, sha1_stat.sha1);
+			hashcpy(untracked->exclude_sha1, sha1_stat.oid.hash);
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
@@ -2816,12 +2813,11 @@ static void read_sha1(size_t pos, void *cb)
 	rd->data += 20;
 }
 
-static void load_sha1_stat(struct sha1_stat *sha1_stat,
-			   const unsigned char *data,
-			   const unsigned char *sha1)
+static void load_sha1_stat(struct oid_stat *sha1_stat,
+			   const unsigned char *data, const unsigned char *sha1)
 {
 	stat_data_from_disk(&sha1_stat->stat, data);
-	hashcpy(sha1_stat->sha1, sha1);
+	hashcpy(sha1_stat->oid.hash, sha1);
 	sha1_stat->valid = 1;
 }
 
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

