From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/20] copy.c: add copy_dir_recursively()
Date: Wed,  3 Feb 2016 16:35:35 +0700
Message-ID: <1454492150-10628-6-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtrV-0005Oz-AW
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbcBCJg0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:26 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36444 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbcBCJgW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:36:22 -0500
Received: by mail-pa0-f45.google.com with SMTP id yy13so10727586pab.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RjbeqnBiJ7bKbwXjpcL6T18BsAcRFPmv/f4EJtceSRE=;
        b=YBrNQYpOR74ds8CAnLiyrBN6YThetD6JWu/8K4RtoBKEmPA5d5B0uQ2fVDux5C6xpL
         s+cymXSZsJuqv+nNHv8UyKGswaQDVmvXjGEDoGaEZnXNywHpQ0PeUPRjiaHh9XL/2sCD
         Nw6eWxAD/ARP5DH8XW3M/XEqjyK2EdMngI3SdWKIl6O+FaCSycXg2jYpivZQU4bk3Agg
         tB3hyzMgHe6oRiAPobkY9xlSNT+dEffLO2DK/KIksDbTN5h2WDdpCIZadtUqi94h9qH0
         jwEp6t5s/GklT1HrdqHs5uQQywxhg0RTLTa64MHbE6tyx0jE+X03ujJsJwMSZjmrR8rF
         LGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=RjbeqnBiJ7bKbwXjpcL6T18BsAcRFPmv/f4EJtceSRE=;
        b=ShKMhhxLNI2FLf1sNwBrp4OH6JpGlmF8WeuSRYMjSgeniSJ2AIUmBn/v2tsZG5ibvt
         v/e1l73zlpUQ072r2junWX3E9Vei6VKovlLy6U1aNbeOGkQk+3Id7IBQi7o6kHxG97Qy
         rKL/bRI406ou2e3pQFlEyBQXEZ2Ev2LhFP9f1ptHdDbK/4KGO9pAlPzSVEi+a2C0pyFD
         uSseOqabe5oZD79qZGKRT3O7lrmieB4DhYdWI8D8yiifnFTr9ILYQuS8Ve1Qg9//BDH6
         VSh1mxVwPPa+SUHf9k0GH8ZTESepkA5rkJRl7AEklr59BHru23/ppTWnvx77+9vCvDvp
         +DPQ==
X-Gm-Message-State: AG10YOSBA0voOEBDQQ01FlCV251AyRUzZALXxoy9izI+0LxToL173+rMToSNrRyqgXRz6w==
X-Received: by 10.66.101.36 with SMTP id fd4mr737183pab.76.1454492181431;
        Wed, 03 Feb 2016 01:36:21 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id c9sm8313561pfd.90.2016.02.03.01.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:20 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:36:33 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285349>

This is busybox's copy_file() [1] modified to fit in Git. Because this
is busybox, the code is likely POSIX-y (or even Linux-y). Windows
support may not be there yet.

[1] in libbb/copy_file.c from the GPL2+ commit
    f2c043acfcf9dad9fd3d65821b81f89986bbe54e (busybox: fix
    uninitialized memory when displaying IPv6 addresses - 2016-01-18)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |   1 +
 copy.c  | 371 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 372 insertions(+)

diff --git a/cache.h b/cache.h
index c75d13f..3fbb38d 100644
--- a/cache.h
+++ b/cache.h
@@ -1638,6 +1638,7 @@ extern void fprintf_or_die(FILE *, const char *fm=
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
index 574fa1f..c99d6e5 100644
--- a/copy.c
+++ b/copy.c
@@ -1,4 +1,6 @@
 #include "cache.h"
+#include "dir.h"
+#include "hashmap.h"
=20
 int copy_fd(int ifd, int ofd)
 {
@@ -65,3 +67,372 @@ int copy_file_with_time(const char *dst, const char=
 *src, int mode)
 		return copy_times(dst, src);
 	return status;
 }
+
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
+ */
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
+/* See busybox.git, libbb/copy_file.c for the original implementation =
*/
+static int copy_dir_1(struct hashmap *inode_map,
+		      const char *source,
+		      const char *dest)
+{
+	/* This is a recursive function, try to minimize stack usage */
+	struct stat source_stat;
+	struct stat dest_stat;
+	int retval =3D 0;
+	int dest_exists =3D 0;
+	int ovr;
+
+	if (stat(source, &source_stat) < 0)
+		return sys_error(_("can't stat '%s'"), source);
+
+	if (lstat(dest, &dest_stat) < 0) {
+		if (errno !=3D ENOENT)
+			return sys_error(_("can't stat '%s'"), dest);
+	} else {
+		if (source_stat.st_dev =3D=3D dest_stat.st_dev &&
+		    source_stat.st_ino =3D=3D dest_stat.st_ino)
+			return sys_error(_("'%s' and '%s' are the same file"), source, dest=
);
+		dest_exists =3D 1;
+	}
+
+	if (S_ISDIR(source_stat.st_mode)) {
+		DIR *dp;
+		const char *tp;
+		struct dirent *d;
+		mode_t saved_umask =3D 0;
+
+		/* Did we ever create source ourself before? */
+		tp =3D is_in_ino_dev_hashtable(inode_map, &source_stat);
+		if (tp)
+			/* We did! it's a recursion! man the lifeboats... */
+			return error(_("recursion detected, omitting directory '%s'"),
+				     source);
+
+		if (dest_exists) {
+			if (!S_ISDIR(dest_stat.st_mode))
+				return sys_error(_("target '%s' is not a directory"), dest);
+			/*
+			 * race here: user can substitute a symlink between
+			 * this check and actual creation of files inside dest
+			 */
+		} else {
+			/* Create DEST */
+			mode_t mode;
+			saved_umask =3D umask(0);
+
+			mode =3D source_stat.st_mode;
+			/* Allow owner to access new dir (at least for now) */
+			mode |=3D S_IRWXU;
+			if (mkdir(dest, mode) < 0) {
+				umask(saved_umask);
+				return sys_error(_("can't create directory '%s'"), dest);
+			}
+			umask(saved_umask);
+			/* need stat info for add_to_ino_dev_hashtable */
+			if (lstat(dest, &dest_stat) < 0)
+				return sys_error(_("can't stat '%s'"), dest);
+		}
+
+		/*
+		 * remember (dev,inode) of each created dir. name is
+		 * not remembered
+		 */
+		add_to_ino_dev_hashtable(inode_map, &dest_stat, "");
+
+		/* Recursively copy files in SOURCE */
+		dp =3D opendir(source);
+		if (!dp) {
+			retval =3D -1;
+			goto preserve_mode_ugid_time;
+		}
+
+		while ((d =3D readdir(dp))) {
+			char *new_source, *new_dest;
+
+			new_source =3D concat_subpath_file(source, d->d_name);
+			if (!new_source)
+				continue;
+			new_dest =3D concat_path_file(dest, d->d_name);
+			if (copy_dir_1(inode_map, new_source, new_dest) < 0)
+				retval =3D -1;
+			free(new_source);
+			free(new_dest);
+		}
+		closedir(dp);
+
+		if (!dest_exists &&
+		    chmod(dest, source_stat.st_mode & ~saved_umask) < 0) {
+			sys_error(_("can't preserve permissions of '%s'"), dest);
+			/* retval =3D -1; - WRONG! copy *WAS* made */
+		}
+		goto preserve_mode_ugid_time;
+	}
+
+	/* "cp [-opts] regular_file thing2" */
+	if (S_ISREG(source_stat.st_mode)) {
+		const char *link_target;
+		int src_fd;
+		int dst_fd;
+		mode_t new_mode;
+
+		if (S_ISLNK(source_stat.st_mode)) {
+			/* "cp -d symlink dst": create a link */
+			goto dont_cat;
+		}
+
+		link_target =3D is_in_ino_dev_hashtable(inode_map, &source_stat);
+		if (link_target) {
+			if (link(link_target, dest) < 0) {
+				ovr =3D do_unlink(dest);
+				if (ovr < 0)
+					return ovr;
+				if (link(link_target, dest) < 0) {
+					sys_error(_("can't create link '%s'"), dest);
+					return -1;
+				}
+			}
+			return 0;
+		}
+		add_to_ino_dev_hashtable(inode_map, &source_stat, dest);
+
+		src_fd =3D open(source, O_RDONLY);
+		if (src_fd < 0)
+			return sys_error(_("can't open '%s'"), source);
+
+		/* Do not try to open with weird mode fields */
+		new_mode =3D source_stat.st_mode;
+		if (!S_ISREG(source_stat.st_mode))
+			new_mode =3D 0666;
+
+		dst_fd =3D open(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
+		if (dst_fd =3D=3D -1) {
+			ovr =3D do_unlink(dest);
+			if (ovr < 0) {
+				close(src_fd);
+				return ovr;
+			}
+			/* It shouldn't exist. If it exists, do not open (symlink attack?) =
*/
+			dst_fd =3D open(dest, O_WRONLY|O_CREAT|O_EXCL, new_mode);
+			if (dst_fd < 0) {
+				close(src_fd);
+				return sys_error(_("can't open '%s'"), dest);
+			}
+		}
+
+		switch (copy_fd(src_fd, dst_fd)) {
+		case COPY_READ_ERROR:
+			error(_("copy-fd: read returned %s"), strerror(errno));
+			retval =3D -1;
+			break;
+		case COPY_WRITE_ERROR:
+			error(_("copy-fd: write returned %s"), strerror(errno));
+			retval =3D -1;
+			break;
+		}
+
+		/* Careful with writing... */
+		if (close(dst_fd) < 0)
+			retval =3D sys_error(_("error writing to '%s'"), dest);
+		/* ...but read size is already checked by bb_copyfd_eof */
+		close(src_fd);
+		/*
+		 * "cp /dev/something new_file" should not
+		 * copy mode of /dev/something
+		 */
+		if (!S_ISREG(source_stat.st_mode))
+			return retval;
+		goto preserve_mode_ugid_time;
+	}
+dont_cat:
+
+	/* Source is a symlink or a special file */
+	/* We are lazy here, a bit lax with races... */
+	if (dest_exists) {
+		errno =3D EEXIST;
+		ovr =3D do_unlink(dest);
+		if (ovr < 0)
+			return ovr;
+	}
+	if (S_ISLNK(source_stat.st_mode)) {
+		struct strbuf lpath =3D STRBUF_INIT;
+		if (!strbuf_readlink(&lpath, source, 0)) {
+			int r =3D symlink(lpath.buf, dest);
+			strbuf_release(&lpath);
+			if (r < 0)
+				return sys_error(_("can't create symlink '%s'"), dest);
+			if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
+				sys_error(_("can't preserve %s of '%s'"), "ownership", dest);
+		} else {
+			/* EINVAL =3D> "file: Invalid argument" =3D> puzzled user */
+			const char *errmsg =3D _("not a symlink");
+			int err =3D errno;
+
+			if (err !=3D EINVAL)
+				errmsg =3D strerror(err);
+			error(_("%s: cannot read link: %s"), source, errmsg);
+			strbuf_release(&lpath);
+		}
+		/*
+		 * _Not_ jumping to preserve_mode_ugid_time: symlinks
+		 * don't have those
+		 */
+		return 0;
+	}
+	if (S_ISBLK(source_stat.st_mode) ||
+	    S_ISCHR(source_stat.st_mode) ||
+	    S_ISSOCK(source_stat.st_mode) ||
+	    S_ISFIFO(source_stat.st_mode)) {
+		if (mknod(dest, source_stat.st_mode, source_stat.st_rdev) < 0)
+			return sys_error(_("can't create '%s'"), dest);
+	} else
+		return sys_error(_("unrecognized file '%s' with mode %x"),
+				 source, source_stat.st_mode);
+
+preserve_mode_ugid_time:
+
+	if (1 /*FILEUTILS_PRESERVE_STATUS*/) {
+		struct timeval times[2];
+
+		times[1].tv_sec =3D times[0].tv_sec =3D source_stat.st_mtime;
+		times[1].tv_usec =3D times[0].tv_usec =3D 0;
+		/* BTW, utimes sets usec-precision time - just FYI */
+		if (utimes(dest, times) < 0)
+			sys_error(_("can't preserve %s of '%s'"), "times", dest);
+		if (chown(dest, source_stat.st_uid, source_stat.st_gid) < 0) {
+			source_stat.st_mode &=3D ~(S_ISUID | S_ISGID);
+			sys_error(_("can't preserve %s of '%s'"), "ownership", dest);
+		}
+		if (chmod(dest, source_stat.st_mode) < 0)
+			sys_error(_("can't preserve %s of '%s'"), "permissions", dest);
+	}
+
+	return retval;
+}
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
