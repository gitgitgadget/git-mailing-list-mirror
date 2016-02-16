From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/26] copy.c: convert copy_file() to copy_dir_recursively()
Date: Tue, 16 Feb 2016 20:29:08 +0700
Message-ID: <1455629367-26193-8-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhe-0002kL-Rf
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbcBPN37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:29:59 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35844 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbcBPN35 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:29:57 -0500
Received: by mail-pa0-f45.google.com with SMTP id yy13so103477374pab.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=frD1w+aIAGpWIT0UHWPekgZDyXp15xjkbjkkt6XDmQQ=;
        b=lOof4evwLhw3UTouGR4BHvTi2UMU9D+Ku0eptp/IdUzRfuctvfp/mnGQZcsJwiSDOt
         pYoa8HS3HNhFJKgqiBQM0teheDHAFPfVhI867MWfSvuDf9IhzTQvIYl96VW64bPEfEAp
         /Hc++Hc7UuI11uMF/tC4ri8WVc7oXi0IFMiE/XCNqsppgTaZrARrsK3mFmMKWZ6qnlX5
         1ZHQT1ypdYI8esQYOf43V06F81XyA/lVq/nHNkgwZAD/qaXHUjahPmgU7W8aRyHdoZVl
         uBzHUhJxnqfzx7eSkHRLej7GcvAvosWL/R6w/w7WKiBENmxQEmfwfnCisUYLBNg45UVJ
         EA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=frD1w+aIAGpWIT0UHWPekgZDyXp15xjkbjkkt6XDmQQ=;
        b=CG+mekfV0AWLcS46bg9smxlVpwnbAulrTnB8BrAtsy7EVoddRUK+gPMF87owgSzqCS
         jCfcWivYIM7vuPh7WBmj55i5RTeBimVCM+QqDa95jus7ulNDUE1IVHY0BE11DnOinuii
         qNlXlyrD/EGpl4Y7bSV1L7Mx6hdxe/hPgh9rwbEmxD7FKt3yc0QTtcECamdhS0Ru8QGY
         f6VLI+NWk4D45v9ljpSj2UxwX6iFGG20+sHD/s9AphYO34tgK7tR/e3PtCq4pG03u7Bg
         4AsGEQXhZcGMDKgNiJPcMpmcdcIESSxxrZmKLYoK/gMCxcsIzJUZhIB1JlXv9fYbcCkS
         8Pzw==
X-Gm-Message-State: AG10YOTGKrbzilA7GXl1UI1UbmVB8jku072CtBO1mDResZPU/85gMVfzv4pwHevcrfZT0Q==
X-Received: by 10.66.152.204 with SMTP id va12mr30915717pab.0.1455629396718;
        Tue, 16 Feb 2016 05:29:56 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id wt2sm46037999pac.48.2016.02.16.05.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:29:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:30:17 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286369>

This finally enables busybox's copy_file() code under a new name
(because "copy_file" is already taken in Git code base). Because this
comes from busybox, POSIXy (or even Linuxy) behavior is expected. More
changes may be needed for Windows support.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |   1 +
 copy.c  | 216 ++++++++++++++++++++++++++++++++++++++++++++++++++++----=
--------
 2 files changed, 179 insertions(+), 38 deletions(-)

diff --git a/cache.h b/cache.h
index 26640b4..30a2708 100644
--- a/cache.h
+++ b/cache.h
@@ -1659,6 +1659,7 @@ extern void fprintf_or_die(FILE *, const char *fm=
t, ...);
 extern int copy_fd(int ifd, int ofd);
 extern int copy_file(const char *dst, const char *src, int mode);
 extern int copy_file_with_time(const char *dst, const char *src, int m=
ode);
+extern int copy_dir_recursively(const char *source, const char *dest);
=20
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const=
 char *msg);
diff --git a/copy.c b/copy.c
index 00f8349..f04ac87 100644
--- a/copy.c
+++ b/copy.c
@@ -1,4 +1,6 @@
 #include "cache.h"
+#include "dir.h"
+#include "hashmap.h"
=20
 int copy_fd(int ifd, int ofd)
 {
@@ -66,21 +68,126 @@ int copy_file_with_time(const char *dst, const cha=
r *src, int mode)
 	return status;
 }
=20
-#if 0
-/* Return:
- * -1 error, copy not made
- *  0 copy is made or user answered "no" in interactive mode
- *    (failures to preserve mode/owner/times are not reported in exit =
code)
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
+	const struct inode_value *inode =3D entry;
+	const struct inode_key   *key   =3D entry_or_key;
+
+	return !(inode->key.ino   =3D=3D key->ino &&
+		 inode->key.dev   =3D=3D key->dev &&
+		 inode->key.isdir =3D=3D key->isdir);
+}
+
+static const char *is_in_ino_dev_hashtable(const struct hashmap *map,
+					   const struct stat *st)
+{
+	struct inode_key key;
+	struct inode_value *value;
+
+	key.entry.hash =3D hash_inode(st->st_ino);
+	key.ino	       =3D st->st_ino;
+	key.dev	       =3D st->st_dev;
+	key.isdir      =3D !!S_ISDIR(st->st_mode);
+	value	       =3D hashmap_get(map, &key, NULL);
+	return value ? value->name : NULL;
+}
+
+static void add_to_ino_dev_hashtable(struct hashmap *map,
+				     const struct stat *st,
+				     const char *path)
+{
+	struct inode_value *v;
+	int len =3D strlen(path);
+
+	v =3D xmalloc(offsetof(struct inode_value, name) + len + 1);
+	v->key.entry.hash =3D hash_inode(st->st_ino);
+	v->key.ino	  =3D st->st_ino;
+	v->key.dev	  =3D st->st_dev;
+	v->key.isdir      =3D !!S_ISDIR(st->st_mode);
+	memcpy(v->name, path, len + 1);
+	hashmap_add(map, v);
+}
+
+/*
+ * Find out if the last character of a string matches the one given.
+ * Don't underrun the buffer if the string length is 0.
  */
-int FAST_FUNC copy_file(const char *source, const char *dest, int flag=
s)
+static inline char *last_char_is(const char *s, int c)
+{
+	if (s && *s) {
+		size_t sz =3D strlen(s) - 1;
+		s +=3D sz;
+		if ( (unsigned char)*s =3D=3D c)
+			return (char*)s;
+	}
+	return NULL;
+}
+
+static inline char *concat_path_file(const char *path, const char *fil=
ename)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	char *lc;
+
+	if (!path)
+		path =3D "";
+	lc =3D last_char_is(path, '/');
+	while (*filename =3D=3D '/')
+		filename++;
+	strbuf_addf(&sb, "%s%s%s", path, (lc=3D=3DNULL ? "/" : ""), filename)=
;
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
+	int e =3D errno;
+
+	if (unlink(dest) < 0) {
+		errno =3D e; /* do not use errno from unlink */
+		return sys_error(_("can't create '%s'"), dest);
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
-	smallint retval =3D 0;
-	smallint dest_exists =3D 0;
-	smallint ovr;
+	int retval =3D 0;
+	int dest_exists =3D 0;
+	int ovr;
=20
 	if (lstat(source, &source_stat) < 0)
 		return sys_error(_("can't stat '%s'"), source);
@@ -102,7 +209,7 @@ int FAST_FUNC copy_file(const char *source, const c=
har *dest, int flags)
 		mode_t saved_umask =3D 0;
=20
 		/* Did we ever create source ourself before? */
-		tp =3D is_in_ino_dev_hashtable(&source_stat);
+		tp =3D is_in_ino_dev_hashtable(inode_map, &source_stat);
 		if (tp)
 			/* We did! it's a recursion! man the lifeboats... */
 			return error(_("recursion detected, omitting directory '%s'"),
@@ -132,11 +239,12 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 			if (lstat(dest, &dest_stat) < 0)
 				return sys_error(_("can't stat '%s'"), dest);
 		}
+
 		/*
 		 * remember (dev,inode) of each created dir. name is
 		 * not remembered
 		 */
-		add_to_ino_dev_hashtable(&dest_stat, NULL);
+		add_to_ino_dev_hashtable(inode_map, &dest_stat, "");
=20
 		/* Recursively copy files in SOURCE */
 		dp =3D opendir(source);
@@ -152,7 +260,7 @@ int FAST_FUNC copy_file(const char *source, const c=
har *dest, int flags)
 			if (!new_source)
 				continue;
 			new_dest =3D concat_path_file(dest, d->d_name);
-			if (copy_file(new_source, new_dest, flags & ~FILEUTILS_DEREFERENCE_=
L0) < 0)
+			if (copy_dir_1(inode_map, new_source, new_dest) < 0)
 				retval =3D -1;
 			free(new_source);
 			free(new_dest);
@@ -177,53 +285,57 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 			goto dont_cat;
 		}
=20
-		if (ENABLE_FEATURE_PRESERVE_HARDLINKS) {
+		if (1 /*ENABLE_FEATURE_PRESERVE_HARDLINKS*/) {
 			const char *link_target;
-			link_target =3D is_in_ino_dev_hashtable(&source_stat);
+			link_target =3D is_in_ino_dev_hashtable(inode_map, &source_stat);
 			if (link_target) {
 				if (link(link_target, dest) < 0) {
-					ovr =3D ask_and_unlink(dest, flags);
-					if (ovr <=3D 0)
+					ovr =3D do_unlink(dest);
+					if (ovr < 0)
 						return ovr;
 					if (link(link_target, dest) < 0)
 						return sys_error(_("can't create link '%s'"), dest);
 				}
 				return 0;
 			}
-			add_to_ino_dev_hashtable(&source_stat, dest);
+			add_to_ino_dev_hashtable(inode_map, &source_stat, dest);
 		}
=20
-		src_fd =3D open_or_warn(source, O_RDONLY);
+		src_fd =3D open(source, O_RDONLY);
 		if (src_fd < 0)
-			return -1;
+			return sys_error(_("can't open '%s'"), source);
=20
 		/* Do not try to open with weird mode fields */
 		new_mode =3D source_stat.st_mode;
 		if (!S_ISREG(source_stat.st_mode))
 			new_mode =3D 0666;
=20
-		/* POSIX way is a security problem versus (sym)link attacks */
-		if (!ENABLE_FEATURE_NON_POSIX_CP) {
-			dst_fd =3D open(dest, O_WRONLY|O_CREAT|O_TRUNC, new_mode);
-		} else { /* safe way: */
-			dst_fd =3D open(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
-		}
+		dst_fd =3D open(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
 		if (dst_fd =3D=3D -1) {
-			ovr =3D ask_and_unlink(dest, flags);
-			if (ovr <=3D 0) {
+			ovr =3D do_unlink(dest);
+			if (ovr < 0) {
 				close(src_fd);
 				return ovr;
 			}
 			/* It shouldn't exist. If it exists, do not open (symlink attack?) =
*/
-			dst_fd =3D open3_or_warn(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
+			dst_fd =3D open(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
 			if (dst_fd < 0) {
 				close(src_fd);
-				return -1;
+				return sys_error(_("can't open '%s'"), dest);
 			}
 		}
=20
-		if (bb_copyfd_eof(src_fd, dst_fd) =3D=3D -1)
+		switch (copy_fd(src_fd, dst_fd)) {
+		case COPY_READ_ERROR:
+			error(_("copy-fd: read returned %s"), strerror(errno));
 			retval =3D -1;
+			break;
+		case COPY_WRITE_ERROR:
+			error(_("copy-fd: write returned %s"), strerror(errno));
+			retval =3D -1;
+			break;
+		}
+
 		/* Careful with writing... */
 		if (close(dst_fd) < 0)
 			retval =3D sys_error(_("error writing to '%s'"), dest);
@@ -243,19 +355,28 @@ dont_cat:
 	/* We are lazy here, a bit lax with races... */
 	if (dest_exists) {
 		errno =3D EEXIST;
-		ovr =3D ask_and_unlink(dest, flags);
-		if (ovr <=3D 0)
+		ovr =3D do_unlink(dest);
+		if (ovr < 0)
 			return ovr;
 	}
 	if (S_ISLNK(source_stat.st_mode)) {
-		char *lpath =3D xmalloc_readlink_or_warn(source);
-		if (lpath) {
-			int r =3D symlink(lpath, dest);
-			free(lpath);
+		struct strbuf lpath =3D STRBUF_INIT;
+		if (!strbuf_readlink(&lpath, source, 0)) {
+			int r =3D symlink(lpath.buf, dest);
+			strbuf_release(&lpath);
 			if (r < 0)
 				return sys_error(_("can't create symlink '%s'"), dest);
 			if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
 				sys_error(_("can't preserve %s of '%s'"), "ownership", dest);
+		} else {
+			/* EINVAL =3D> "file: Invalid argument" =3D> puzzled user */
+			const char *errmsg =3D _("not a symlink");
+			int err =3D errno;
+
+			if (err !=3D EINVAL)
+				errmsg =3D strerror(err);
+			error(_("%s: cannot read link: %s"), source, errmsg);
+			strbuf_release(&lpath);
 		}
 		/*
 		 * _Not_ jumping to preserve_mode_ugid_time: symlinks
@@ -293,4 +414,23 @@ preserve_mode_ugid_time:
=20
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
+	ret =3D copy_dir_1(&inode_map, source, dest);
+	hashmap_free(&inode_map, 1);
+	return ret;
+}
--=20
2.7.0.377.g4cd97dd
