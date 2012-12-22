From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/8] wildmatch: make dowild() take arbitrary flags
Date: Sat, 22 Dec 2012 14:57:03 +0700
Message-ID: <1356163028-29967-4-git-send-email-pclouds@gmail.com>
References: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 08:58:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmJyA-0008UB-MM
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 08:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab2LVH5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2012 02:57:41 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38629 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab2LVH5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 02:57:38 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so3282659pad.23
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 23:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Gq3GLndNZU4cnyvpaM6d+MFnvERBMDVrf/Knx6i5bWI=;
        b=dSA9Ybez0CuaW+Gf9YQni/WcLFulh+fsZmmImhfVQFjVtW4XXC2QyLmYOkcw5uZQtF
         4a8dEGnzFaq1sE+SyqR6WT2VjRuL201e796N+yMoy7mvSY4Vb+5fLLjMmv6uozjvPlme
         uf/LRRma0hhqX5aaaGruAP87fNc+yztMhaEj3JaTy5XeeR07z258u82on8NJaAXyOImA
         lkmRCrzafV3vEvP9tkOANpdzA2WVE8n8S0IrMZr7ii6Vd3EZ+T+D9pmE18+agSCtvl9t
         WbieUlI0cmq8JDLfdsz0C0BRodtP9KaR/BaQCXnxnDP/RTw7/R5tuUnFUg//au7G9s8A
         mW1w==
X-Received: by 10.68.137.41 with SMTP id qf9mr46787091pbb.103.1356163055219;
        Fri, 21 Dec 2012 23:57:35 -0800 (PST)
Received: from lanh ([115.74.46.73])
        by mx.google.com with ESMTPS id gj1sm8432516pbc.11.2012.12.21.23.57.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 23:57:34 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Dec 2012 14:57:30 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212031>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 6ee1b09..a79f97e 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -52,7 +52,7 @@ typedef unsigned char uchar;
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
=20
 /* Match pattern "p" against "text" */
-static int dowild(const uchar *p, const uchar *text, int force_lower_c=
ase)
+static int dowild(const uchar *p, const uchar *text, unsigned int flag=
s)
 {
 	uchar p_ch;
=20
@@ -61,9 +61,9 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 		uchar t_ch, prev_ch;
 		if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
 			return WM_ABORT_ALL;
-		if (force_lower_case && ISUPPER(t_ch))
+		if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
 			t_ch =3D tolower(t_ch);
-		if (force_lower_case && ISUPPER(p_ch))
+		if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
 			p_ch =3D tolower(p_ch);
 		switch (p_ch) {
 		case '\\':
@@ -97,7 +97,7 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 					 * both foo/bar and foo/a/bar.
 					 */
 					if (p[0] =3D=3D '/' &&
-					    dowild(p + 1, text, force_lower_case) =3D=3D WM_MATCH)
+					    dowild(p + 1, text, flags) =3D=3D WM_MATCH)
 						return WM_MATCH;
 					special =3D 1;
 				} else
@@ -116,7 +116,7 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 			while (1) {
 				if (t_ch =3D=3D '\0')
 					break;
-				if ((matched =3D dowild(p, text,  force_lower_case)) !=3D WM_NOMAT=
CH) {
+				if ((matched =3D dowild(p, text,  flags)) !=3D WM_NOMATCH) {
 					if (!special || matched !=3D WM_ABORT_TO_STARSTAR)
 						return matched;
 				} else if (!special && t_ch =3D=3D '/')
@@ -227,6 +227,5 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 int wildmatch(const char *pattern, const char *text,
 	      unsigned int flags, struct wildopts *wo)
 {
-	return dowild((const uchar*)pattern, (const uchar*)text,
-		      flags & WM_CASEFOLD ? 1 :0);
+	return dowild((const uchar*)pattern, (const uchar*)text, flags);
 }
--=20
1.8.0.rc2.23.g1fb49df
