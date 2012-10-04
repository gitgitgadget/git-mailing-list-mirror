From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] attr: remove the union in struct match_attr
Date: Thu,  4 Oct 2012 14:39:47 +0700
Message-ID: <1349336392-1772-2-git-send-email-pclouds@gmail.com>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org>
 <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:32:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUI-0001w8-P5
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244Ab2JDHkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 03:40:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55961 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab2JDHkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:40:13 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so235863pad.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 00:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=brNN8wcJwc6fPbg6KBzgn3cbTLo4Bih0LCIXFWWaito=;
        b=D6SrqgJY/VCi8Jgltjc8TLcRK/D06+fpmUcTkQuSg1Elbs9iP2vkFl8OkCzf2rzkpH
         iGGW3IZeHCyTcu0FizkmdTwrBz8Sbu32pTLTlAx2Ftn8ThiDGOHXdp/UDuWvx1raElLO
         9M4oG25e7HeuI3bhAv64bixTq4Ypbd0a/0uqgTvnJu73ePEUImd/Wj37/MzdalzXRhql
         x+7xEjKmrEHYJgeIlt7p0/rzResEusROjaLh/iciJPfGIcv4vEl1UFqdIsG6KKUpD24y
         CGtbVc5hFIOoYch5yhpyab3PX2Zl0nF+qo5uJUUJg1SFN5hRW+kdcR4/5HHdGtKjVUq2
         x2+g==
Received: by 10.66.73.226 with SMTP id o2mr11085824pav.83.1349336413236;
        Thu, 04 Oct 2012 00:40:13 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id bs6sm3833299pab.30.2012.10.04.00.40.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 00:40:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 04 Oct 2012 14:40:01 +0700
X-Mailer: git-send-email 1.7.12.1.405.gb727dc9
In-Reply-To: <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207008>

We're going to add more attributes to u.pattern so it'll become bigger
in size than a pointer. There's no point in sharing the same room with
u.attr.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/attr.c b/attr.c
index 15ebaa1..48df800 100644
--- a/attr.c
+++ b/attr.c
@@ -119,10 +119,10 @@ struct attr_state {
 /*
  * One rule, as from a .gitattributes file.
  *
- * If is_macro is true, then u.attr is a pointer to the git_attr being
+ * If is_macro is true, then attr is a pointer to the git_attr being
  * defined.
  *
- * If is_macro is false, then u.pattern points at the filename pattern
+ * If is_macro is false, then pattern points at the filename pattern
  * to which the rule applies.  (The memory pointed to is part of the
  * memory block allocated for the match_attr instance.)
  *
@@ -131,10 +131,8 @@ struct attr_state {
  * listed as they appear in the file (macros unexpanded).
  */
 struct match_attr {
-	union {
-		char *pattern;
-		struct git_attr *attr;
-	} u;
+	const char *pattern;
+	struct git_attr *attr;
 	char is_macro;
 	unsigned num_attr;
 	struct attr_state state[FLEX_ARRAY];
@@ -240,11 +238,12 @@ static struct match_attr *parse_attr_line(const c=
har *line, const char *src,
 		      sizeof(struct attr_state) * num_attr +
 		      (is_macro ? 0 : namelen + 1));
 	if (is_macro)
-		res->u.attr =3D git_attr_internal(name, namelen);
+		res->attr =3D git_attr_internal(name, namelen);
 	else {
-		res->u.pattern =3D (char *)&(res->state[num_attr]);
-		memcpy(res->u.pattern, name, namelen);
-		res->u.pattern[namelen] =3D 0;
+		char *p =3D (char *)&(res->state[num_attr]);
+		memcpy(p, name, namelen);
+		p[namelen] =3D 0;
+		res->pattern =3D p;
 	}
 	res->is_macro =3D is_macro;
 	res->num_attr =3D num_attr;
@@ -682,7 +681,7 @@ static int fill_one(const char *what, struct match_=
attr *a, int rem)
=20
 		if (*n =3D=3D ATTR__UNKNOWN) {
 			debug_set(what,
-				  a->is_macro ? a->u.attr->name : a->u.pattern,
+				  a->is_macro ? a->attr->name : a->pattern,
 				  attr, v);
 			*n =3D v;
 			rem--;
@@ -702,7 +701,7 @@ static int fill(const char *path, int pathlen, stru=
ct attr_stack *stk, int rem)
 		if (a->is_macro)
 			continue;
 		if (path_matches(path, pathlen,
-				 a->u.pattern, base, strlen(base)))
+				 a->pattern, base, strlen(base)))
 			rem =3D fill_one("fill", a, rem);
 	}
 	return rem;
@@ -722,7 +721,7 @@ static int macroexpand_one(int attr_nr, int rem)
 			struct match_attr *ma =3D stk->attrs[i];
 			if (!ma->is_macro)
 				continue;
-			if (ma->u.attr->attr_nr =3D=3D attr_nr)
+			if (ma->attr->attr_nr =3D=3D attr_nr)
 				a =3D ma;
 		}
=20
--=20
1.7.12.1.405.gb727dc9
