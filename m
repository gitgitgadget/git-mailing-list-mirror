Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31821F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbdHPURo (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:17:44 -0400
Received: from vie01a-dmta-pe04-1.mx.upcmail.net ([62.179.121.163]:64658 "EHLO
        vie01a-dmta-pe04-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752533AbdHPUQp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:45 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4k8-0005Qt-19
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:44 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGi1v0245BuuEg01wGjLw; Wed, 16 Aug 2017 22:16:43 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id CC1DE45D4621; Wed, 16 Aug 2017 22:16:42 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 09/19] Convert cache functions to size_t
Date:   Wed, 16 Aug 2017 22:16:21 +0200
Message-Id: <1502914591-26215-10-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 cache-tree.c  |  6 +++---
 cache-tree.h  |  2 +-
 cache.h       |  6 +++---
 convert.c     | 18 +++++++++---------
 environment.c |  4 ++--
 read-cache.c  | 18 +++++++++---------
 6 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 2440d1d..77b3253 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -485,10 +485,10 @@ void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
 	write_one(sb, root, "", 0);
 }
 
-static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
+static struct cache_tree *read_one(const char **buffer, size_t *size_p)
 {
 	const char *buf = *buffer;
-	unsigned long size = *size_p;
+	size_t size = *size_p;
 	const char *cp;
 	char *ep;
 	struct cache_tree *it;
@@ -568,7 +568,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	return NULL;
 }
 
-struct cache_tree *cache_tree_read(const char *buffer, unsigned long size)
+struct cache_tree *cache_tree_read(const char *buffer, size_t size)
 {
 	if (buffer[0])
 		return NULL; /* not the whole tree */
diff --git a/cache-tree.h b/cache-tree.h
index f7b9cab..df59e6e 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -28,7 +28,7 @@ void cache_tree_invalidate_path(struct index_state *, const char *);
 struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
-struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
+struct cache_tree *cache_tree_read(const char *buffer, size_t size);
 
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct index_state *, int);
diff --git a/cache.h b/cache.h
index 681dcb6..1ec53e0 100644
--- a/cache.h
+++ b/cache.h
@@ -667,7 +667,7 @@ extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
 extern int index_name_is_other(const struct index_state *, const char *, int);
-extern void *read_blob_data_from_index(const struct index_state *, const char *, unsigned long *);
+extern void *read_blob_data_from_index(const struct index_state *, const char *, size_t *);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
@@ -743,8 +743,8 @@ extern int pack_compression_level;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
-extern unsigned long big_file_threshold;
-extern unsigned long pack_size_limit_cfg;
+extern size_t big_file_threshold;
+extern size_t pack_size_limit_cfg;
 
 /*
  * Accessors for the core.sharedrepository config which lazy-load the value
diff --git a/convert.c b/convert.c
index 1012462..445599b 100644
--- a/convert.c
+++ b/convert.c
@@ -41,9 +41,9 @@ struct text_stat {
 	unsigned printable, nonprintable;
 };
 
-static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
+static void gather_stats(const char *buf, size_t size, struct text_stat *stats)
 {
-	unsigned long i;
+	size_t i;
 
 	memset(stats, 0, sizeof(*stats));
 
@@ -90,7 +90,7 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
  * The same heuristics as diff.c::mmfile_is_binary()
  * We treat files with bare CR as binary
  */
-static int convert_is_binary(unsigned long size, const struct text_stat *stats)
+static int convert_is_binary(size_t size, const struct text_stat *stats)
 {
 	if (stats->lonecr)
 		return 1;
@@ -101,7 +101,7 @@ static int convert_is_binary(unsigned long size, const struct text_stat *stats)
 	return 0;
 }
 
-static unsigned int gather_convert_stats(const char *data, unsigned long size)
+static unsigned int gather_convert_stats(const char *data, size_t size)
 {
 	struct text_stat stats;
 	int ret = 0;
@@ -118,7 +118,7 @@ static unsigned int gather_convert_stats(const char *data, unsigned long size)
 	return ret;
 }
 
-static const char *gather_convert_stats_ascii(const char *data, unsigned long size)
+static const char *gather_convert_stats_ascii(const char *data, size_t size)
 {
 	unsigned int convert_stats = gather_convert_stats(data, size);
 
@@ -140,7 +140,7 @@ const char *get_cached_convert_stats_ascii(const struct index_state *istate,
 					   const char *path)
 {
 	const char *ret;
-	unsigned long sz;
+	size_t sz;
 	void *data = read_blob_data_from_index(istate, path, &sz);
 	ret = gather_convert_stats_ascii(data, sz);
 	free(data);
@@ -222,7 +222,7 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 
 static int has_cr_in_index(const struct index_state *istate, const char *path)
 {
-	unsigned long sz;
+	size_t sz;
 	void *data;
 	int has_cr;
 
@@ -384,7 +384,7 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 
 struct filter_params {
 	const char *src;
-	unsigned long size;
+	size_t size;
 	int fd;
 	const char *cmd;
 	const char *path;
@@ -798,7 +798,7 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int count_ident(const char *cp, unsigned long size)
+static int count_ident(const char *cp, size_t size)
 {
 	/*
 	 * "$Id: 0000000000000000000000000000000000000000 $" <=> "$Id$"
diff --git a/environment.c b/environment.c
index 3fd4b10..7cf201f 100644
--- a/environment.c
+++ b/environment.c
@@ -40,7 +40,7 @@ int fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
-unsigned long big_file_threshold = 512 * 1024 * 1024;
+size_t big_file_threshold = 512 * 1024 * 1024;
 int pager_use_color = 1;
 const char *editor_program;
 const char *askpass_program;
@@ -63,7 +63,7 @@ int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
-unsigned long pack_size_limit_cfg;
+size_t pack_size_limit_cfg;
 enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
 
diff --git a/read-cache.c b/read-cache.c
index 854a5d6..8a32619 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1509,7 +1509,7 @@ struct ondisk_cache_entry_extended {
 /* Allow fsck to force verification of the index checksum. */
 int verify_index_checksum;
 
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(struct cache_header *hdr, size_t size)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
@@ -1533,7 +1533,7 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 }
 
 static int read_index_extension(struct index_state *istate,
-				const char *ext, void *data, unsigned long sz)
+				const char *ext, void *data, size_t sz)
 {
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
@@ -1602,7 +1602,7 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
  * number of bytes to be stripped from the end of the previous name,
  * and the bytes to append to the result, to come up with its name.
  */
-static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
+static size_t expand_name_field(struct strbuf *name, const char *cp_)
 {
 	const unsigned char *ep, *cp = (const unsigned char *)cp_;
 	size_t len = decode_varint(&cp);
@@ -1617,7 +1617,7 @@ static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
 }
 
 static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
-					    unsigned long *ent_size,
+					    size_t *ent_size,
 					    struct strbuf *previous_name)
 {
 	struct cache_entry *ce;
@@ -1651,7 +1651,7 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 
 		*ent_size = ondisk_ce_size(ce);
 	} else {
-		unsigned long consumed;
+		size_t consumed;
 		consumed = expand_name_field(previous_name, name);
 		ce = cache_entry_from_ondisk(ondisk, flags,
 					     previous_name->buf,
@@ -1728,7 +1728,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
 	int fd, i;
 	struct stat st;
-	unsigned long src_offset;
+	size_t src_offset;
 	struct cache_header *hdr;
 	void *mmap;
 	size_t mmap_size;
@@ -1778,7 +1778,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
-		unsigned long consumed;
+		size_t consumed;
 
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
 		ce = create_from_disk(disk_ce, &consumed, previous_name);
@@ -1914,7 +1914,7 @@ int unmerged_index(const struct index_state *istate)
 
 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
-static unsigned long write_buffer_len;
+static size_t write_buffer_len;
 
 static int ce_write_flush(git_SHA_CTX *context, int fd)
 {
@@ -2580,7 +2580,7 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 }
 
 void *read_blob_data_from_index(const struct index_state *istate,
-				const char *path, unsigned long *size)
+				const char *path, size_t *size)
 {
 	int pos, len;
 	size_t sz;
-- 
2.1.4

