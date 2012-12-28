From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/9] wildmatch: make dowild() take arbitrary flags
Date: Fri, 28 Dec 2012 11:10:49 +0700
Message-ID: <1356667854-8686-5-git-send-email-pclouds@gmail.com>
References: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 05:11:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToRIX-0000rR-CX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 05:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab2L1ELf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Dec 2012 23:11:35 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:52734 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab2L1ELe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 23:11:34 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so5693600pbb.15
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 20:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=sIiynozA7YHhEtGccVPeXhZzAJEEGEfJlkhxlgEbykU=;
        b=KbGXOlhvI/rCNyoWuydtfY4eN3bzqHqODUb2Mf5WH+W6/9KZdR9tA7Tp3NyoU510ny
         w4DSwG6sZiLJaxSxHvigENoVGATeFEvWSBvIRzOOMGditgTidEEmYUsbEh/ANrzO8k82
         7g/5G07fTzvb4N3usdZzCNQJbgNcG7+TvqICrJZWhiXgiS4ur6YvM2dqXeANU6JkV8q/
         KDvb9UIyXIgKx4WbRNqsMdZoat+4qxIVMczxR4Q8IMT0sHF4Ucm/0tiDcGyHYlwJqoEj
         Vd6FECMCL5jnfO105xnknri5J/tcusKWLTLzwuqRQ1w2lyOgIcFbKee+3m1OZUkYYOty
         arJw==
X-Received: by 10.68.216.134 with SMTP id oq6mr100565679pbc.162.1356667893182;
        Thu, 27 Dec 2012 20:11:33 -0800 (PST)
Received: from lanh ([115.74.54.149])
        by mx.google.com with ESMTPS id kl5sm18914030pbc.74.2012.12.27.20.11.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2012 20:11:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 28 Dec 2012 11:11:32 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212227>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index f9b6451..68e4213 100644
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
 					match_slash =3D 1;
 				} else
@@ -116,7 +116,7 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 			while (1) {
 				if (t_ch =3D=3D '\0')
 					break;
-				if ((matched =3D dowild(p, text,  force_lower_case)) !=3D WM_NOMAT=
CH) {
+				if ((matched =3D dowild(p, text, flags)) !=3D WM_NOMATCH) {
 					if (!match_slash || matched !=3D WM_ABORT_TO_STARSTAR)
 						return matched;
 				} else if (!match_slash && t_ch =3D=3D '/')
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
