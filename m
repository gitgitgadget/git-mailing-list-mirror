From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] wildmatch: make dowild() take arbitrary flags
Date: Wed, 19 Dec 2012 20:08:06 +0700
Message-ID: <1355922488-20976-2-git-send-email-pclouds@gmail.com>
References: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 14:32:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlJlJ-0007PF-Nv
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 14:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab2LSNcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 08:32:24 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:54896 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2LSNcX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 08:32:23 -0500
X-Greylist: delayed 1140 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2012 08:32:23 EST
Received: by mail-pa0-f54.google.com with SMTP id bi5so1313737pad.13
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 05:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=YOVBD24/J7/bD7vViCTWLb9yw2iKE4MYqzz4MS5XxoI=;
        b=xvdo3LHi0EgC6/BCXLMk1DE0aZffLuM+OtrWvLcTzpXK3kfDD9ViYN95Hwj+VWvbqz
         UskzDeWhfTHZe9vVE8DNc1145Cz9HFcfQveb0HyzCyNG8wz63wFb1WZvVZQA5Skhzww+
         A7aWZvHPsGueS9GXz/LTSXG3EUgs2/i5IDjpsRT0hr8HpzoAHL1qoWUlV9wABgaTiNam
         Ghhtc+iCjyjAyVyfum3w3ejBiC27P5UZTU8XLs6EUtSBXkiBnvHiLWpz0HOuB0COYUsP
         TZ23xiX0xNb/IKdrj5mFy3NdJZiOPsGFC+tYEvTmOrw6stCObGZXTEOaNWn2N4bD5oQP
         4TVg==
X-Received: by 10.68.212.106 with SMTP id nj10mr18465420pbc.101.1355922469323;
        Wed, 19 Dec 2012 05:07:49 -0800 (PST)
Received: from lanh ([115.74.42.11])
        by mx.google.com with ESMTPS id uh9sm3106287pbc.5.2012.12.19.05.07.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2012 05:07:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Dec 2012 20:08:19 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211824>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 3972e26..9586ed9 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -55,7 +55,7 @@ typedef unsigned char uchar;
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
=20
 /* Match pattern "p" against "text" */
-static int dowild(const uchar *p, const uchar *text, int force_lower_c=
ase)
+static int dowild(const uchar *p, const uchar *text, int flags)
 {
 	uchar p_ch;
=20
@@ -64,9 +64,9 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 		uchar t_ch, prev_ch;
 		if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
 			return ABORT_ALL;
-		if (force_lower_case && ISUPPER(t_ch))
+		if (flags & FNM_CASEFOLD && ISUPPER(t_ch))
 			t_ch =3D tolower(t_ch);
-		if (force_lower_case && ISUPPER(p_ch))
+		if (flags & FNM_CASEFOLD && ISUPPER(p_ch))
 			p_ch =3D tolower(p_ch);
 		switch (p_ch) {
 		case '\\':
@@ -100,7 +100,7 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 					 * both foo/bar and foo/a/bar.
 					 */
 					if (p[0] =3D=3D '/' &&
-					    dowild(p + 1, text, force_lower_case) =3D=3D MATCH)
+					    dowild(p + 1, text, flags) =3D=3D MATCH)
 						return MATCH;
 					special =3D TRUE;
 				} else
@@ -119,7 +119,7 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 			while (1) {
 				if (t_ch =3D=3D '\0')
 					break;
-				if ((matched =3D dowild(p, text,  force_lower_case)) !=3D NOMATCH)=
 {
+				if ((matched =3D dowild(p, text,  flags)) !=3D NOMATCH) {
 					if (!special || matched !=3D ABORT_TO_STARSTAR)
 						return matched;
 				} else if (!special && t_ch =3D=3D '/')
@@ -229,6 +229,5 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 /* Match the "pattern" against the "text" string. */
 int wildmatch(const char *pattern, const char *text, int flags)
 {
-	return dowild((const uchar*)pattern, (const uchar*)text,
-		      flags & FNM_CASEFOLD ? 1 :0);
+	return dowild((const uchar*)pattern, (const uchar*)text, flags);
 }
--=20
1.8.0.rc2.23.g1fb49df
