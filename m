From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/6] dir.c: pass pathname length to last_exclude_matching
Date: Sun, 10 Mar 2013 13:14:29 +0700
Message-ID: <1362896070-17456-6-git-send-email-pclouds@gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 07:15:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEZXp-0001Qi-E0
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 07:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab3CJGPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 01:15:13 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:63086 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3CJGPK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 01:15:10 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so2599134pbc.23
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 22:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=/erFj1McBf6ehjZFnjKMkQNyFaDdQRo6ZBgLC3kO4jE=;
        b=CAhWvPuIsd/i0rQWoPDBe+vvvhh4vOO7uRrbZ3jPXhsiXWhnN28YTsbMhDzLP97p2G
         NnyVI+HROcU7ak36N+0EeZT5p2Y80ROXY6Hd4zb7/StrrTMIBgcsSHEcmVJ06ErWMdLs
         MZjk1Bs80B4eMcO/+184g4VOI/xJmV/wPoEeBblLUmQnNIVRLWUxXaXXqxT1+DCQn7+W
         44HISmg8B2y4hZdYNzkWVYoaBHW8eZr2P+Vt7i0AWOJV2HHC9lyvToC16hvVXuChXDV3
         FDGYz/+L8N5x2349UCFNO0KOtPcaRJcEwkSdjE7YfpyCfKn6Gun/O+WoAYatvEXhUNi1
         z5yg==
X-Received: by 10.68.136.97 with SMTP id pz1mr16972037pbb.205.1362896109881;
        Sat, 09 Mar 2013 22:15:09 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id mz8sm13860877pbc.9.2013.03.09.22.15.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 22:15:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Mar 2013 13:15:04 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217785>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 7b6a625..880b5e6 100644
--- a/dir.c
+++ b/dir.c
@@ -764,9 +764,9 @@ int is_excluded_from_list(const char *pathname,
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
@@ -793,10 +793,12 @@ static struct exclude *last_exclude_matching(stru=
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
@@ -859,7 +861,8 @@ struct exclude *last_exclude_matching_path(struct p=
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
@@ -871,7 +874,7 @@ struct exclude *last_exclude_matching_path(struct p=
ath_exclude_check *check,
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
=20
-	return last_exclude_matching(check->dir, name, dtype);
+	return last_exclude_matching(check->dir, name, namelen, dtype);
 }
=20
 /*
@@ -1249,7 +1252,7 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude =3D is_excluded(dir, path->buf, &dtype);
+	int exclude =3D is_excluded(dir, path->buf, path->len, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
--=20
1.8.1.2.536.gf441e6d
