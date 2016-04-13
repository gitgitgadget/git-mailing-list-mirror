From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/25] copy.c: convert copy_file() to copy_dir_recursively()
Date: Wed, 13 Apr 2016 20:15:28 +0700
Message-ID: <1460553346-12985-8-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKel-00045M-NK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760632AbcDMNQ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:16:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33617 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760625AbcDMNQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so4119999pfe.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2COMIq5TvwD6BADfug+ji9TUuhdpDx73h7SgRyFe/Ug=;
        b=ydW4xruz88Exl+jKvSNndFTH74ZhXJAxVYmk6cDdF3WlCLCJAPiSVan8e6D4uEfZm2
         jizQj+th0ap51FeXdC7tOky1bMfWxHCTS9d4MxqFyGlvykkhASgUvcJc1G8mnleL0taA
         k9eH18kDuPczBVTl/ZcwTc5ixNVtM1Nfi3PvP84gJPGFaT7L8L+P4r8lnmao3ydbEb8C
         cNaO9rp+MslwgdsBZIg5kLehHNMmnX/hVFgpVIGcg01mO+kVmxVoB/fIcx/ZBMwNyOe6
         hA63k4G3sdE/wdUTV3ESsCXAQuZ30Nml5MDYbUnJ11Wmby7tv9ZLrHHBKKxel/XPGYsU
         LsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2COMIq5TvwD6BADfug+ji9TUuhdpDx73h7SgRyFe/Ug=;
        b=GIhfKMGCdkxzzsmi50UJ0iUxQ74id0vk1gDE93wZeOme1DvAnolZNylwAt4YjxpbQY
         niGWsyWrPCrtvF4s/ktGskd/3kwHj+JuK9YO+urbciaWzcMI1X8dQbKA8LInKjB76D6R
         sW8PQ3k+ifiZzsCCOur5pJz/OHydUD+9in8S/4DDQrEqKkG7+ptVepmVh0mgJ0yMQ5ZH
         uLzcwEsywXm5uTnukUQM544rPSfqoAdUw8qxwzqhozncOjdO2sZICRQgoFzX7OW0kmfq
         mTKKwHTcVo+P3JIEIFTJ/wSaXJWcTRw/cq8CkWX0A18XROgkNo/IlvsPBzF6WOTFt/Mt
         rXOg==
X-Gm-Message-State: AOPr4FUO7a3hXJ9lvDsCuLj7Bs+TFa8uhuDLNa/CuCKRS+SogN6fjnKR+WqH1FQSVvCPww==
X-Received: by 10.98.19.82 with SMTP id b79mr12869090pfj.17.1460553385267;
        Wed, 13 Apr 2016 06:16:25 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id ff2sm27475122pac.15.2016.04.13.06.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:31 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291427>

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
index 9f09540..213a8d3 100644
--- a/cache.h
+++ b/cache.h
@@ -1677,6 +1677,7 @@ extern void fprintf_or_die(FILE *, const char *fm=
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
2.8.0.rc0.210.gd302cd2
