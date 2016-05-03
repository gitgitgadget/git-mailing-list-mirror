From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 36/41] sha1_file.c: use {error,die,warning}_errno()
Date: Tue,  3 May 2016 19:04:09 +0700
Message-ID: <1462277054-5943-37-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:10:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ9N-0001Lp-O5
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933189AbcECMJ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:09:58 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34129 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930AbcECMJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:09:57 -0400
Received: by mail-pf0-f176.google.com with SMTP id y69so9213681pfb.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LC7Ig0u87qj5ftv6cb0hWXsDMxA+6eaGqVFB0F/YE5M=;
        b=Q9nnGRrStgXs0fLwCF6NdIS/nqt3VTW0izyGjA4KOu8gFkbMVmbSjhj6/x+evq3wT6
         a9Nhny3Hgv50scqcl9RapPBokGwkE8bG+jNpKSoQsivsmCWWHLF2KWgSbD5WDlAG4JI+
         h1w1ONUw+HWBUrD0fom+O5P59dMqrSXjeUlPUQig25KzAUxKBC8uDC1JXCm+xwy7xGxD
         N6PRlxM/Ld6CGEST1dPgrR8HynDYPwGfqNs+gPDEZuI/A7YOh9V3SAUbsZrUzx0OgCIG
         QyNBF8gpzY48MpuL/dZ1bH6hngjyr5fn+eSjaxi/ANY8+nBEbz8YERkvwFERaDnT5a8y
         HR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LC7Ig0u87qj5ftv6cb0hWXsDMxA+6eaGqVFB0F/YE5M=;
        b=mlHp/XNBNKRVTHxvqgOQo6iOruwXAYilQj+Sy9MaEaBIccEjcOih1tGC5+x9cwjYDL
         xwM7Q+LFNdc3EMU6xHKxBXAwwpblp2Xabm1T9Ag2DV8RCabi0aXdulyXeFRmRoIBYMV7
         NqFhMl6gkXrfP+ZA1UFySmRB6VAg7xDdHNyV5TOFms2nYE5c0V5G6gT6yR5Zn9O27h25
         /T/yNFVZvhFu/UVpBcnoOGeiFtjCjX6BCQg390NeBhhAe8vVbxtCyxDHDi+zTZ8LS706
         9m9NeQWrk7kkJoM4ACOevWOyLvltVkNO41QT3KcfKOdZk9i6jEDpmSfF8Qwv+No4Xpld
         zA+A==
X-Gm-Message-State: AOPr4FVQYk2yaA/XtRgmjdxPLK6OgAiXCBvzT9RrL41MUA33t9hm2BoyqH6rCPWEx4MroA==
X-Received: by 10.98.54.193 with SMTP id d184mr2563467pfa.59.1462277396460;
        Tue, 03 May 2016 05:09:56 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id ut1sm5474675pac.46.2016.05.03.05.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:09:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:09:52 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293389>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..a7f45b3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1107,9 +1107,8 @@ unsigned char *use_pack(struct packed_git *p,
 				PROT_READ, MAP_PRIVATE,
 				p->pack_fd, win->offset);
 			if (win->base =3D=3D MAP_FAILED)
-				die("packfile %s cannot be mapped: %s",
-					p->pack_name,
-					strerror(errno));
+				die_errno("packfile %s cannot be mapped",
+					  p->pack_name);
 			if (!win->offset && win->len =3D=3D p->pack_size
 				&& !p->do_not_close)
 				close_pack_fd(p);
@@ -1279,8 +1278,8 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 	dir =3D opendir(path.buf);
 	if (!dir) {
 		if (errno !=3D ENOENT)
-			error("unable to open object pack directory: %s: %s",
-			      path.buf, strerror(errno));
+			error_errno("unable to open object pack directory: %s",
+				    path.buf);
 		strbuf_release(&path);
 		return;
 	}
@@ -2984,7 +2983,7 @@ int finalize_object_file(const char *tmpfile, con=
st char *filename)
 	unlink_or_warn(tmpfile);
 	if (ret) {
 		if (ret !=3D EEXIST) {
-			return error("unable to write sha1 filename %s: %s", filename, stre=
rror(ret));
+			return error_errno("unable to write sha1 filename %s", filename);
 		}
 		/* FIXME!!! Collision check here ? */
 	}
@@ -2998,7 +2997,7 @@ out:
 static int write_buffer(int fd, const void *buf, size_t len)
 {
 	if (write_in_full(fd, buf, len) < 0)
-		return error("file write error (%s)", strerror(errno));
+		return error_errno("file write error");
 	return 0;
 }
=20
@@ -3081,7 +3080,7 @@ static int write_loose_object(const unsigned char=
 *sha1, char *hdr, int hdrlen,
 		if (errno =3D=3D EACCES)
 			return error("insufficient permission for adding an object to repos=
itory database %s", get_object_directory());
 		else
-			return error("unable to create temporary file: %s", strerror(errno)=
);
+			return error_errno("unable to create temporary file");
 	}
=20
 	/* Set it up */
@@ -3126,8 +3125,7 @@ static int write_loose_object(const unsigned char=
 *sha1, char *hdr, int hdrlen,
 		utb.actime =3D mtime;
 		utb.modtime =3D mtime;
 		if (utime(tmp_file.buf, &utb) < 0)
-			warning("failed utime() on %s: %s",
-				tmp_file.buf, strerror(errno));
+			warning_errno("failed utime() on %s", tmp_file.buf);
 	}
=20
 	return finalize_object_file(tmp_file.buf, filename);
@@ -3360,7 +3358,7 @@ static int index_core(unsigned char *sha1, int fd=
, size_t size,
 		if (size =3D=3D read_in_full(fd, buf, size))
 			ret =3D index_mem(sha1, buf, size, type, path, flags);
 		else
-			ret =3D error("short read %s", strerror(errno));
+			ret =3D error_errno("short read");
 		free(buf);
 	} else {
 		void *buf =3D xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -3425,18 +3423,14 @@ int index_path(unsigned char *sha1, const char =
*path, struct stat *st, unsigned
 	case S_IFREG:
 		fd =3D open(path, O_RDONLY);
 		if (fd < 0)
-			return error("open(\"%s\"): %s", path,
-				     strerror(errno));
+			return error_errno("open(\"%s\")", path);
 		if (index_fd(sha1, fd, st, OBJ_BLOB, path, flags) < 0)
 			return error("%s: failed to insert into database",
 				     path);
 		break;
 	case S_IFLNK:
-		if (strbuf_readlink(&sb, path, st->st_size)) {
-			char *errstr =3D strerror(errno);
-			return error("readlink(\"%s\"): %s", path,
-			             errstr);
-		}
+		if (strbuf_readlink(&sb, path, st->st_size))
+			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_sha1_file(sb.buf, sb.len, blob_type, sha1);
 		else if (write_sha1_file(sb.buf, sb.len, blob_type, sha1))
@@ -3492,7 +3486,7 @@ static int for_each_file_in_obj_subdir(int subdir=
_nr,
 	if (!dir) {
 		if (errno =3D=3D ENOENT)
 			return 0;
-		return error("unable to open %s: %s", path->buf, strerror(errno));
+		return error_errno("unable to open %s", path->buf);
 	}
=20
 	while ((de =3D readdir(dir))) {
--=20
2.8.0.rc0.210.gd302cd2
