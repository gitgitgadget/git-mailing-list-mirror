From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/9] archive-tar: unindent write_tar_entry by one level
Date: Thu,  3 May 2012 08:51:02 +0700
Message-ID: <1336009868-7411-4-git-send-email-pclouds@gmail.com>
References: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 03:53:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPlEB-0007Ha-Tm
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 03:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577Ab2ECBwz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 21:52:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55696 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab2ECBwj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 21:52:39 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1813971pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 18:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Od9MMiABN2S+hE9cxhKVI1PE3V9gnYt4nkFVWq5wvhw=;
        b=NmbOVgg9SExTLj6WN7ttyOQog67DdU5yNN5FRG0QjRR14WQGv16lTaqOJO1PGJ7yEw
         CpkFQdBpjxQ1DMxgsrj5rFOLJ+mkEHbixSbeGkI4DXx1T6kcBhIHBB2KZQjH0fdtAADl
         sSCr+T92/ICbX3KlFKFyjBUOwSroBPiVFZozo3xa8gyTDXPZdhiP5wfa/qzlvlqOLTVh
         31CiX5BtGd0Gi96/RdbQ8/Tp3pwW4jxXV6lhXMBv/b0wMsBTjjSyG/tiUmzsKLf+13SH
         W8L95h2U7O/ewh/D1BwZjOdhnC2baHbreFP+FsHnsiMGb7xByHTt1BZsNAPsjzYEDnBe
         AqgA==
Received: by 10.68.221.74 with SMTP id qc10mr2500504pbc.80.1336009959528;
        Wed, 02 May 2012 18:52:39 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id h10sm3614233pbh.69.2012.05.02.18.52.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 18:52:38 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 May 2012 08:51:43 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196876>

It's used to be

if (!sha1) {
  ...
} else if (!path) {
  ...
} else {
  ...
}

Now that the first two blocks are no-op. We can remove the if/else
skeleton and put the else block back by one indent level.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-tar.c |   56 +++++++++++++++++++++++++------------------------=
-------
 1 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 1727ab9..6c8a0bd 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -170,40 +170,34 @@ static int write_tar_entry(struct archiver_args *=
args,
=20
 	memset(&header, 0, sizeof(header));
=20
-	if (!sha1) {
-		die("BUG: sha1 =3D=3D NULL is not supported");
-	} else if (!path) {
-		die("BUG: path =3D=3D NULL is not supported");
+	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
+		*header.typeflag =3D TYPEFLAG_DIR;
+		mode =3D (mode | 0777) & ~tar_umask;
+	} else if (S_ISLNK(mode)) {
+		*header.typeflag =3D TYPEFLAG_LNK;
+		mode |=3D 0777;
+	} else if (S_ISREG(mode)) {
+		*header.typeflag =3D TYPEFLAG_REG;
+		mode =3D (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
 	} else {
-		if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-			*header.typeflag =3D TYPEFLAG_DIR;
-			mode =3D (mode | 0777) & ~tar_umask;
-		} else if (S_ISLNK(mode)) {
-			*header.typeflag =3D TYPEFLAG_LNK;
-			mode |=3D 0777;
-		} else if (S_ISREG(mode)) {
-			*header.typeflag =3D TYPEFLAG_REG;
-			mode =3D (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
+		return error("unsupported file mode: 0%o (SHA1: %s)",
+			     mode, sha1_to_hex(sha1));
+	}
+	if (pathlen > sizeof(header.name)) {
+		size_t plen =3D get_path_prefix(path, pathlen,
+					      sizeof(header.prefix));
+		size_t rest =3D pathlen - plen - 1;
+		if (plen > 0 && rest <=3D sizeof(header.name)) {
+			memcpy(header.prefix, path, plen);
+				memcpy(header.name, path + plen + 1, rest);
 		} else {
-			return error("unsupported file mode: 0%o (SHA1: %s)",
-					mode, sha1_to_hex(sha1));
+			sprintf(header.name, "%s.data",
+				sha1_to_hex(sha1));
+			strbuf_append_ext_header(&ext_header, "path",
+						 path, pathlen);
 		}
-		if (pathlen > sizeof(header.name)) {
-			size_t plen =3D get_path_prefix(path, pathlen,
-					sizeof(header.prefix));
-			size_t rest =3D pathlen - plen - 1;
-			if (plen > 0 && rest <=3D sizeof(header.name)) {
-				memcpy(header.prefix, path, plen);
-				memcpy(header.name, path + plen + 1, rest);
-			} else {
-				sprintf(header.name, "%s.data",
-				        sha1_to_hex(sha1));
-				strbuf_append_ext_header(&ext_header, "path",
-						path, pathlen);
-			}
-		} else
-			memcpy(header.name, path, pathlen);
-	}
+	} else
+		memcpy(header.name, path, pathlen);
=20
 	if (S_ISLNK(mode) && buffer) {
 		if (size > sizeof(header.linkname)) {
--=20
1.7.3.1.256.g2539c.dirty
