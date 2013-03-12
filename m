From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/13] dir: pass pathname length to last_exclude_matching
Date: Tue, 12 Mar 2013 20:04:53 +0700
Message-ID: <1363093500-16796-7-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:06:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOuP-0007Yu-L2
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab3CLNF7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:05:59 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:51420 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab3CLNF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:05:57 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so4926798pbc.40
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=36rBYwaRjBDzwAfCxc/43lUc/ydhtf+Llai87Z95A64=;
        b=eM7pkW4RGDB6DHM3cDEzKeu9eKbd4GWeafjIzBvkhWCI/FMVSDFB0s+Z5RwLO6q+5f
         hkMm7b5fGLEvzFbkgAeAPJdJhCZXl8m0UwIiwdvG76kXgA06F+PufMK22dpITvZtHHgt
         JWXACLmtZ+d2ByUH8SB/mU0LgeGQovnYUMtAt45PVROvxdak2qqw4uZE1X8f7JW669Ke
         izpfiV/bq6XguUbe2ds6uIy+fERwy3ldUv2FJLJyOmBXXFHAmcLs28HVhW1mfnSUAuDN
         M8BhZmEmh/9vw5YZbmxVB004PcvrZI1fYEWKP0PPmgCPS3W5H2b3oEAUJsNBwgp67mbC
         inSQ==
X-Received: by 10.68.37.6 with SMTP id u6mr1588084pbj.78.1363093557383;
        Tue, 12 Mar 2013 06:05:57 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id tm1sm25001122pbc.11.2013.03.12.06.05.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:05:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:05:51 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217954>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 26c3b3a..58739f3 100644
--- a/dir.c
+++ b/dir.c
@@ -794,9 +794,9 @@ int is_excluded_from_list(const char *pathname,
  */
 static struct exclude *last_exclude_matching(struct dir_struct *dir,
 					     const char *pathname,
+					     int pathlen,
 					     int *dtype_p)
 {
-	int pathlen =3D strlen(pathname);
 	int i, j;
 	struct exclude_list_group *group;
 	struct exclude *exclude;
@@ -827,10 +827,12 @@ static struct exclude *last_exclude_matching(stru=
ct dir_struct *dir,
  * scans all exclude lists to determine whether pathname is excluded.
  * Returns 1 if true, otherwise 0.
  */
-static int is_excluded(struct dir_struct *dir, const char *pathname, i=
nt *dtype_p)
+static int is_excluded(struct dir_struct *dir,
+		       const char *pathname, int pathlen,
+		       int *dtype_p)
 {
 	struct exclude *exclude =3D
-		last_exclude_matching(dir, pathname, dtype_p);
+		last_exclude_matching(dir, pathname, pathlen, dtype_p);
 	if (exclude)
 		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
@@ -893,7 +895,8 @@ struct exclude *last_exclude_matching_path(struct p=
ath_exclude_check *check,
 		if (ch =3D=3D '/') {
 			int dt =3D DT_DIR;
 			exclude =3D last_exclude_matching(check->dir,
-							path->buf, &dt);
+							path->buf, path->len,
+							&dt);
 			if (exclude) {
 				check->exclude =3D exclude;
 				return exclude;
@@ -905,7 +908,7 @@ struct exclude *last_exclude_matching_path(struct p=
ath_exclude_check *check,
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
=20
-	return last_exclude_matching(check->dir, name, dtype);
+	return last_exclude_matching(check->dir, name, namelen, dtype);
 }
=20
 /*
@@ -1297,7 +1300,7 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 	int exclude;
=20
 	START_CLOCK();
-	exclude =3D is_excluded(dir, path->buf,  &dtype);
+	exclude =3D is_excluded(dir, path->buf, path->len, &dtype);
 	STOP_CLOCK(tv_is_excluded);
=20
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
--=20
1.8.1.2.536.gf441e6d
