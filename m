Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9BE2079D
	for <e@80x24.org>; Sat, 12 Nov 2016 02:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966335AbcKLCYk (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:24:40 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35296 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938522AbcKLCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:24:36 -0500
Received: by mail-pg0-f65.google.com with SMTP id p66so3167934pga.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xl126Ubw7j95xeRurf/OTfOhZaT+eONulQ4qx9EI+gQ=;
        b=iKM5Fnu3xnr9989LPvzUMK+UkZ9De58TlVdJgQGph/7P5BaCPE8aZnvO+VzCpQthGI
         15bEpqM4VaOHpP+WwPkzEIfcbAYlsOcBUWKdJtmuq6i8zAVjSYXTEGXZUZ1znwReZN6K
         Su2pHizuWhoaSSKIwZbF0Cbb9m4M+Y6uTOeiOn1cPT7p/BUz+R8eI8wkXJwSs2pgYksq
         A1FYM21sTTGla7HqhdnWm2vnGMLq8/iQHaDhe1ZYWP0NimnsRyYcoAmqqUDqeZSoMqde
         VZlxyb/weDmk739WX9CVYRY+w+syf46sT2rJq2tHI2d4QDsBIu24Tk49qA5ugIr3EKBo
         BS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xl126Ubw7j95xeRurf/OTfOhZaT+eONulQ4qx9EI+gQ=;
        b=h6V12L9Xwzs/LIDMh97gJZYLriQkmlKwvwARi4NFDfA/owvbvY1H/ob0BlqA1u714J
         srWlp32Kag8IrQOEzYkvnmsawDtLrzAXFZwRICOf2QU8LuGkwzWf3rFZhchV0CVKaB+K
         k5UdufLw0qrG5t11fxuDavhl8r42pMjYWRor+fuOqaS0ZDPsWx/QBaYPVTqP0cLxNf11
         gj7ismLDoEs90TgCNRS78RRv8CAf1Gynh33ECRKKr1zcbSCbUJNW30JrUZ3A0OUubRc1
         vu6nC6d6gAjryNrMNRmwnPamjR5vdK696IyPZtXxKhdIyM1vquWLSdw/pvY5I8LIKY3U
         BS2g==
X-Gm-Message-State: ABUngve6MkjYt75SHMbL8kGrkYP66Hz57NZF5UuYKQvwL1JqVxiATcH45NVji1t5YMbbAQ==
X-Received: by 10.98.133.207 with SMTP id m76mr5477927pfk.102.1478917447251;
        Fri, 11 Nov 2016 18:24:07 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id r77sm17966013pfa.85.2016.11.11.18.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:24:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:24:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/11] copy.c: convert copy_file() to copy_dir_recursively()
Date:   Sat, 12 Nov 2016 09:23:31 +0700
Message-Id: <20161112022337.13317-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161112022337.13317-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This finally enables busybox's copy_file() code under a new name
(because "copy_file" is already taken in Git code base). Because this
comes from busybox, POSIXy (or even Linuxy) behavior is expected. More
changes may be needed for Windows support.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h |   1 +
 copy.c  | 216 ++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 179 insertions(+), 38 deletions(-)

diff --git a/cache.h b/cache.h
index a50a61a..a9a72f8 100644
--- a/cache.h
+++ b/cache.h
@@ -1857,6 +1857,7 @@ extern void fprintf_or_die(FILE *, const char *fmt, ...);
 extern int copy_fd(int ifd, int ofd);
 extern int copy_file(const char *dst, const char *src, int mode);
 extern int copy_file_with_time(const char *dst, const char *src, int mode);
+extern int copy_dir_recursively(const char *source, const char *dest);
 
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern void fsync_or_die(int fd, const char *);
diff --git a/copy.c b/copy.c
index 60c7d8a..8471f7f 100644
--- a/copy.c
+++ b/copy.c
@@ -1,4 +1,6 @@
 #include "cache.h"
+#include "dir.h"
+#include "hashmap.h"
 
 int copy_fd(int ifd, int ofd)
 {
@@ -66,21 +68,126 @@ int copy_file_with_time(const char *dst, const char *src, int mode)
 	return status;
 }
 
-#if 0
-/* Return:
- * -1 error, copy not made
- *  0 copy is made or user answered "no" in interactive mode
- *    (failures to preserve mode/owner/times are not reported in exit code)
+struct inode_key {
+	struct hashmap_entry entry;
+	ino_t ino;
+	dev_t dev;
+	/*
+	 * Reportedly, on cramfs a file and a dir can have same ino.
+	 * Need to also remember "file/dir" bit:
+	 */
+	char isdir; /* bool */
+};
+
+struct inode_value {
+	struct inode_key key;
+	char name[FLEX_ARRAY];
+};
+
+#define HASH_SIZE      311u   /* Should be prime */
+static inline unsigned hash_inode(ino_t i)
+{
+	return i % HASH_SIZE;
+}
+
+static int inode_cmp(const void *entry, const void *entry_or_key,
+		     const void *keydata)
+{
+	const struct inode_value *inode = entry;
+	const struct inode_key   *key   = entry_or_key;
+
+	return !(inode->key.ino   == key->ino &&
+		 inode->key.dev   == key->dev &&
+		 inode->key.isdir == key->isdir);
+}
+
+static const char *is_in_ino_dev_hashtable(const struct hashmap *map,
+					   const struct stat *st)
+{
+	struct inode_key key;
+	struct inode_value *value;
+
+	key.entry.hash = hash_inode(st->st_ino);
+	key.ino	       = st->st_ino;
+	key.dev	       = st->st_dev;
+	key.isdir      = !!S_ISDIR(st->st_mode);
+	value	       = hashmap_get(map, &key, NULL);
+	return value ? value->name : NULL;
+}
+
+static void add_to_ino_dev_hashtable(struct hashmap *map,
+				     const struct stat *st,
+				     const char *path)
+{
+	struct inode_value *v;
+	int len = strlen(path);
+
+	v = xmalloc(offsetof(struct inode_value, name) + len + 1);
+	v->key.entry.hash = hash_inode(st->st_ino);
+	v->key.ino	  = st->st_ino;
+	v->key.dev	  = st->st_dev;
+	v->key.isdir      = !!S_ISDIR(st->st_mode);
+	memcpy(v->name, path, len + 1);
+	hashmap_add(map, v);
+}
+
+/*
+ * Find out if the last character of a string matches the one given.
+ * Don't underrun the buffer if the string length is 0.
  */
-int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
+static inline char *last_char_is(const char *s, int c)
+{
+	if (s && *s) {
+		size_t sz = strlen(s) - 1;
+		s += sz;
+		if ( (unsigned char)*s == c)
+			return (char*)s;
+	}
+	return NULL;
+}
+
+static inline char *concat_path_file(const char *path, const char *filename)
+{
+	struct strbuf sb = STRBUF_INIT;
+	char *lc;
+
+	if (!path)
+		path = "";
+	lc = last_char_is(path, '/');
+	while (*filename == '/')
+		filename++;
+	strbuf_addf(&sb, "%s%s%s", path, (lc==NULL ? "/" : ""), filename);
+	return strbuf_detach(&sb, NULL);
+}
+
+static char *concat_subpath_file(const char *path, const char *f)
+{
+	if (f && is_dot_or_dotdot(f))
+		return NULL;
+	return concat_path_file(path, f);
+}
+
+static int do_unlink(const char *dest)
+{
+	int e = errno;
+
+	if (unlink(dest) < 0) {
+		errno = e; /* do not use errno from unlink */
+		return error_errno(_("can't create '%s'"), dest);
+	}
+	return 0;
+}
+
+static int copy_dir_1(struct hashmap *inode_map,
+		      const char *source,
+		      const char *dest)
 {
 	/* This is a recursive function, try to minimize stack usage */
-	/* NB: each struct stat is ~100 bytes */
 	struct stat source_stat;
 	struct stat dest_stat;
-	smallint retval = 0;
-	smallint dest_exists = 0;
-	smallint ovr;
+	int retval = 0;
+	int dest_exists = 0;
+	int ovr;
 
 	if (lstat(source, &source_stat) < 0)
 		return error_errno(_("can't stat '%s'"), source);
@@ -102,7 +209,7 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 		mode_t saved_umask = 0;
 
 		/* Did we ever create source ourself before? */
-		tp = is_in_ino_dev_hashtable(&source_stat);
+		tp = is_in_ino_dev_hashtable(inode_map, &source_stat);
 		if (tp)
 			/* We did! it's a recursion! man the lifeboats... */
 			return error(_("recursion detected, omitting directory '%s'"),
@@ -132,11 +239,12 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 			if (lstat(dest, &dest_stat) < 0)
 				return error_errno(_("can't stat '%s'"), dest);
 		}
+
 		/*
 		 * remember (dev,inode) of each created dir. name is
 		 * not remembered
 		 */
-		add_to_ino_dev_hashtable(&dest_stat, NULL);
+		add_to_ino_dev_hashtable(inode_map, &dest_stat, "");
 
 		/* Recursively copy files in SOURCE */
 		dp = opendir(source);
@@ -152,7 +260,7 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 			if (!new_source)
 				continue;
 			new_dest = concat_path_file(dest, d->d_name);
-			if (copy_file(new_source, new_dest, flags & ~FILEUTILS_DEREFERENCE_L0) < 0)
+			if (copy_dir_1(inode_map, new_source, new_dest) < 0)
 				retval = -1;
 			free(new_source);
 			free(new_dest);
@@ -177,53 +285,57 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 			goto dont_cat;
 		}
 
-		if (ENABLE_FEATURE_PRESERVE_HARDLINKS) {
+		if (1 /*ENABLE_FEATURE_PRESERVE_HARDLINKS*/) {
 			const char *link_target;
-			link_target = is_in_ino_dev_hashtable(&source_stat);
+			link_target = is_in_ino_dev_hashtable(inode_map, &source_stat);
 			if (link_target) {
 				if (link(link_target, dest) < 0) {
-					ovr = ask_and_unlink(dest, flags);
-					if (ovr <= 0)
+					ovr = do_unlink(dest);
+					if (ovr < 0)
 						return ovr;
 					if (link(link_target, dest) < 0)
 						return error_errno(_("can't create link '%s'"), dest);
 				}
 				return 0;
 			}
-			add_to_ino_dev_hashtable(&source_stat, dest);
+			add_to_ino_dev_hashtable(inode_map, &source_stat, dest);
 		}
 
-		src_fd = open_or_warn(source, O_RDONLY);
+		src_fd = open(source, O_RDONLY);
 		if (src_fd < 0)
-			return -1;
+			return error_errno(_("can't open '%s'"), source);
 
 		/* Do not try to open with weird mode fields */
 		new_mode = source_stat.st_mode;
 		if (!S_ISREG(source_stat.st_mode))
 			new_mode = 0666;
 
-		/* POSIX way is a security problem versus (sym)link attacks */
-		if (!ENABLE_FEATURE_NON_POSIX_CP) {
-			dst_fd = open(dest, O_WRONLY|O_CREAT|O_TRUNC, new_mode);
-		} else { /* safe way: */
-			dst_fd = open(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
-		}
+		dst_fd = open(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
 		if (dst_fd == -1) {
-			ovr = ask_and_unlink(dest, flags);
-			if (ovr <= 0) {
+			ovr = do_unlink(dest);
+			if (ovr < 0) {
 				close(src_fd);
 				return ovr;
 			}
 			/* It shouldn't exist. If it exists, do not open (symlink attack?) */
-			dst_fd = open3_or_warn(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
+			dst_fd = open(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
 			if (dst_fd < 0) {
 				close(src_fd);
-				return -1;
+				return error_errno(_("can't open '%s'"), dest);
 			}
 		}
 
-		if (bb_copyfd_eof(src_fd, dst_fd) == -1)
+		switch (copy_fd(src_fd, dst_fd)) {
+		case COPY_READ_ERROR:
+			error(_("copy-fd: read returned %s"), strerror(errno));
 			retval = -1;
+			break;
+		case COPY_WRITE_ERROR:
+			error(_("copy-fd: write returned %s"), strerror(errno));
+			retval = -1;
+			break;
+		}
+
 		/* Careful with writing... */
 		if (close(dst_fd) < 0)
 			retval = error_errno(_("error writing to '%s'"), dest);
@@ -243,19 +355,28 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 	/* We are lazy here, a bit lax with races... */
 	if (dest_exists) {
 		errno = EEXIST;
-		ovr = ask_and_unlink(dest, flags);
-		if (ovr <= 0)
+		ovr = do_unlink(dest);
+		if (ovr < 0)
 			return ovr;
 	}
 	if (S_ISLNK(source_stat.st_mode)) {
-		char *lpath = xmalloc_readlink_or_warn(source);
-		if (lpath) {
-			int r = symlink(lpath, dest);
-			free(lpath);
+		struct strbuf lpath = STRBUF_INIT;
+		if (!strbuf_readlink(&lpath, source, 0)) {
+			int r = symlink(lpath.buf, dest);
+			strbuf_release(&lpath);
 			if (r < 0)
 				return error_errno(_("can't create symlink '%s'"), dest);
 			if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
 				error_errno(_("can't preserve %s of '%s'"), "ownership", dest);
+		} else {
+			/* EINVAL => "file: Invalid argument" => puzzled user */
+			const char *errmsg = _("not a symlink");
+			int err = errno;
+
+			if (err != EINVAL)
+				errmsg = strerror(err);
+			error(_("%s: cannot read link: %s"), source, errmsg);
+			strbuf_release(&lpath);
 		}
 		/*
 		 * _Not_ jumping to preserve_mode_ugid_time: symlinks
@@ -293,4 +414,23 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 
 	return retval;
 }
-#endif
+
+/*
+ * Return:
+ * -1 error, copy not made
+ *  0 copy is made
+ *
+ * Failures to preserve mode/owner/times are not reported in exit
+ * code. No support for preserving SELinux security context. Symlinks
+ * and hardlinks are preserved.
+ */
+int copy_dir_recursively(const char *source, const char *dest)
+{
+	int ret;
+	struct hashmap inode_map;
+
+	hashmap_init(&inode_map, inode_cmp, 1024);
+	ret = copy_dir_1(&inode_map, source, dest);
+	hashmap_free(&inode_map, 1);
+	return ret;
+}
-- 
2.8.2.524.g6ff3d78

