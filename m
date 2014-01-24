From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/9] dir.c: prepare match_pathspec_item for taking more flags
Date: Fri, 24 Jan 2014 20:40:31 +0700
Message-ID: <1390570836-20394-5-git-send-email-pclouds@gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pawel.sikora@agmk.net,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 14:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6gv8-00058p-Pb
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 14:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbaAXNfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 08:35:33 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:64038 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaAXNfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 08:35:30 -0500
Received: by mail-pb0-f50.google.com with SMTP id rq2so3242748pbb.23
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zCoVQI9iIH4b9Wyhmk0Nd1YpDferDX1e9NeHoEqmYak=;
        b=AyEb1AirYiLpD8bzW4ZzBlX1bLq0F33OesdL05jMBCP3wsb6UnP4nVnO+DK/HR0XzX
         fOl+PXlbxRKmfXQWNUAeWW2WbkA/yV2oc8uqEdOkaa11Tjrjvl69Nq2XCgdI+Nx0aKUb
         pA8jxgoJn/eRBYiPo29UcXrakacY1XXc+0XKKBjVhdiyZqto38d5vM798smYG3gDKIF0
         3tx1sSkU8f8+F+Vsskl+oi/MVpMlCtUU64AxBfPlUJbDgZ9OMgxRyJZQ4cLIwLUcW+pz
         b8A24TdvnP40bG03QgfDKyTmBjqBijnFSQZkphKoRyT35KpXQKHajbqOAc48mZizuFkk
         fc7w==
X-Received: by 10.67.22.38 with SMTP id hp6mr14429155pad.53.1390570530238;
        Fri, 24 Jan 2014 05:35:30 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id x5sm3319923pbw.26.2014.01.24.05.35.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 05:35:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:41:04 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241005>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 8960ea1..35e09bd 100644
--- a/dir.c
+++ b/dir.c
@@ -195,6 +195,8 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
=20
+#define DO_MATCH_EXCLUDE   1
+
 /*
  * Does 'match' match the given name?
  * A match is found if
@@ -208,7 +210,7 @@ int within_depth(const char *name, int namelen,
  * It returns 0 when there is no match.
  */
 static int match_pathspec_item(const struct pathspec_item *item, int p=
refix,
-			       const char *name, int namelen)
+			       const char *name, int namelen, unsigned flags)
 {
 	/* name/namelen has prefix cut off by caller */
 	const char *match =3D item->match + prefix;
@@ -285,9 +287,9 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 static int do_match_pathspec(const struct pathspec *ps,
 			     const char *name, int namelen,
 			     int prefix, char *seen,
-			     int exclude)
+			     unsigned flags)
 {
-	int i, retval =3D 0;
+	int i, retval =3D 0, exclude =3D flags & DO_MATCH_EXCLUDE;
=20
 	GUARD_PATHSPEC(ps,
 		       PATHSPEC_FROMTOP |
@@ -327,7 +329,8 @@ static int do_match_pathspec(const struct pathspec =
*ps,
 		 */
 		if (seen && ps->items[i].magic & PATHSPEC_EXCLUDE)
 			seen[i] =3D MATCHED_FNMATCH;
-		how =3D match_pathspec_item(ps->items+i, prefix, name, namelen);
+		how =3D match_pathspec_item(ps->items+i, prefix, name,
+					  namelen, flags);
 		if (ps->recursive &&
 		    (ps->magic & PATHSPEC_MAXDEPTH) &&
 		    ps->max_depth !=3D -1 &&
@@ -355,10 +358,14 @@ int match_pathspec(const struct pathspec *ps,
 		   int prefix, char *seen)
 {
 	int positive, negative;
-	positive =3D do_match_pathspec(ps, name, namelen, prefix, seen, 0);
+	unsigned flags =3D 0;
+	positive =3D do_match_pathspec(ps, name, namelen,
+				     prefix, seen, flags);
 	if (!(ps->magic & PATHSPEC_EXCLUDE) || !positive)
 		return positive;
-	negative =3D do_match_pathspec(ps, name, namelen, prefix, seen, 1);
+	negative =3D do_match_pathspec(ps, name, namelen,
+				     prefix, seen,
+				     flags | DO_MATCH_EXCLUDE);
 	return negative ? 0 : positive;
 }
=20
--=20
1.8.5.2.240.g8478abd
