From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 36/41] sha1_file.c: use {error,die,warning}_errno()
Date: Sun,  8 May 2016 16:47:56 +0700
Message-ID: <1462700881-25108-37-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:53:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLNr-0003CE-FI
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbcEHJwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:52:16 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32914 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbcEHJwO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:52:14 -0400
Received: by mail-pa0-f68.google.com with SMTP id gh9so13697688pac.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LC7Ig0u87qj5ftv6cb0hWXsDMxA+6eaGqVFB0F/YE5M=;
        b=oK8GyfdGVhdHxDSKybGReUGu5C+3nfIhTPe2hAeqXsuiA2yv/EGbXd8C0O4JGPTvHU
         ThVZd8bOLCW3XWaqVUbZDy/hc/rXZBd4S//EFU8ZRm5pHtB42qrU/a38oRU2lz57U8cj
         AFIpcc3YtCRUouHRrKMCF4Y/xV2e2gvcRc5KBG0EPtQWTaVsxYtqmrjkTuqcqk/OJjhD
         jOAu4FKHIB9o+u1Iv4G3unFG87tYo5z3Hg/kQmwqyzzNgDQPIVN3gvaT8uxEBP2VRxS9
         RZvIfMP4bMYZ3AbFX2K3YkU7aD9JfDXDytPc6tUkP9oiJkOVoNFPk3qzULiTSIstL33v
         dO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LC7Ig0u87qj5ftv6cb0hWXsDMxA+6eaGqVFB0F/YE5M=;
        b=eaOQAQgFG24Im4gx6r/hegQJo5rzccEPtGCCxnaiekDzfwICwrGqBdl8AihJHL5Z05
         Ya0pIRmoveWbVGggI7q0mtAZfXiCzerQxGpBTWeEWPtPeGi81kCqK4fn+DtTPg79w0ts
         O40e5ktUTesjhEYdo7YvzvTbctKOa7Sb3hhzRLJ0imCqHglN+R21wSphVoRcHB8QlZFj
         bSda2lRJrsEKGusJ/DGvx9A2odbe+wNl32uxDfOiSeK9wKbMH/GNMzzYyzOKt+Q0ncn1
         zyMczhble6McDT10y0k423RqplU5vMOyXQWBGfDlEL8iPJasrZddGpp3c/4oMofXcAqe
         Jtdg==
X-Gm-Message-State: AOPr4FVGAFOLadq9iRaaPZHhqDL3gg4wgWOXNEXre3FJh2+1vFY0gPR0KfFvRQHHy8BJFw==
X-Received: by 10.66.218.161 with SMTP id ph1mr41258125pac.83.1462701133844;
        Sun, 08 May 2016 02:52:13 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id n66sm28472075pfb.17.2016.05.08.02.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:52:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:52:13 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293949>

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
