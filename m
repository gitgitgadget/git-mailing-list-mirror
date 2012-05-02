From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/10] archive-tar: unindent write_tar_entry by one level
Date: Wed,  2 May 2012 20:25:15 +0700
Message-ID: <1335965122-17458-4-git-send-email-pclouds@gmail.com>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 15:29:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZca-0000ld-4Q
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab2EBN31 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:29:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64496 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab2EBN30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:29:26 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1097342pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Zc/vK7T93gxfNA61zMSNDsnzUM9TiIDeNv9bppl6cJ8=;
        b=kDeDnNAFiunMFX5wapo2xe7J2ojI7OLC5okR47EtsWMCZ93n8bDV8C5ZbjbZVFWQfY
         tv6pcZcgZM9RCoc1zABD6cDnsEeyIDDCkNw3Retzm/80goLCVA1QD5c8fREgI3vXskuv
         itsp5neT+zj6jOtJ4HHRQuycPTGl8fNphb06oBwzZOhSRa7A6hz4RMyS7I3R5ieBOewl
         pmXV20/EkWtQuFrXNzErInSkNMJMMTkw9pRg3zBBv0EteqXTOfxom6dDm7eZo5WxHkcW
         Bb8/HB3vQ5X8kZwsdllpvGqeu7tpcLGnUEojaWLXLKM14fH2CWsBhJmLUoAvGgqHrjJK
         1jBQ==
Received: by 10.68.194.1 with SMTP id hs1mr9330003pbc.6.1335965366728;
        Wed, 02 May 2012 06:29:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id g4sm1985492pbt.58.2012.05.02.06.29.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 06:29:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 20:25:52 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196806>

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
1.7.8.36.g69ee2
