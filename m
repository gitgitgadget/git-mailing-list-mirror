From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 06/12] wildmatch: make wildmatch's return value compatible with fnmatch
Date: Wed, 10 Oct 2012 17:40:45 +0700
Message-ID: <1349865651-31889-7-git-send-email-pclouds@gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:41:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtjb-0002oF-09
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab2JJKlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:41:39 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49272 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab2JJKli (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:41:38 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so466174pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uogFR0LHeoDjAlkWe83WvCyI3KFo/yEdTL/9YbPUx0c=;
        b=sfzPmESa+ZzEKLTfmpEvBReNx5iXM/A0nAikmGzjI4V4Lm1aQGBl7prZVy671uaSVR
         zPLglRib6kX6kgGbgdi+aDFIrJxAcu00DEewZgEJ7K+tIjhkFrYv1zPYN69YJX+RzjmF
         fZIB0SyRIsUwPav5p33JxIm65wGQTy6Op2KazjR4LoMrrFYUX7UeCbP6gOqKj+TQCCce
         Hroj5Tp2bp3KDTHmm7B+q+ychdIJSprqfzjM804myu4THebgexjsOL8nj9PbLPDjm0Qp
         Lct9Im0YVWRU/nECw273Ao7JUew92Qht6yuT5tBpyhdnbkIIpDRkGlDl7yUKNVhDbdl4
         G9zw==
Received: by 10.68.212.71 with SMTP id ni7mr71721579pbc.81.1349865697857;
        Wed, 10 Oct 2012 03:41:37 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id qd6sm847210pbb.34.2012.10.10.03.41.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:41:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:41:29 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207391>

wildmatch returns non-zero if matched, zero otherwise. This patch
makes it return zero if matches, non-zero otherwise, like fnmatch().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-wildmatch.c |  4 ++--
 wildmatch.c      | 21 ++++++++++++---------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/test-wildmatch.c b/test-wildmatch.c
index 08962d5..596029c 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -4,9 +4,9 @@
 int main(int argc, char **argv)
 {
 	if (!strcmp(argv[1], "wildmatch"))
-		return wildmatch(argv[3], argv[2]) ? 0 : 1;
+		return wildmatch(argv[3], argv[2]);
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return iwildmatch(argv[3], argv[2]) ? 0 : 1;
+		return iwildmatch(argv[3], argv[2]);
 	else if (!strcmp(argv[1], "fnmatch"))
 		return fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
diff --git a/wildmatch.c b/wildmatch.c
index 6092bde..7c180e3 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -20,6 +20,9 @@ typedef unsigned char uchar;
=20
 #define FALSE 0
 #define TRUE 1
+
+#define NOMATCH 1
+#define MATCH 0
 #define ABORT_ALL -1
 #define ABORT_TO_STARSTAR -2
=20
@@ -79,12 +82,12 @@ static int dowild(const uchar *p, const uchar *text=
)
 	    /* FALLTHROUGH */
 	  default:
 	    if (t_ch !=3D p_ch)
-		return FALSE;
+		return NOMATCH;
 	    continue;
 	  case '?':
 	    /* Match anything but '/'. */
 	    if (t_ch =3D=3D '/')
-		return FALSE;
+		return NOMATCH;
 	    continue;
 	  case '*':
 	    if (*++p =3D=3D '*') {
@@ -97,14 +100,14 @@ static int dowild(const uchar *p, const uchar *tex=
t)
 		 * only if there are no more slash characters. */
 		if (!special) {
 			if (strchr((char*)text, '/') !=3D NULL)
-			    return FALSE;
+			    return NOMATCH;
 		}
-		return TRUE;
+		return MATCH;
 	    }
 	    while (1) {
 		if (t_ch =3D=3D '\0')
 		    break;
-		if ((matched =3D dowild(p, text)) !=3D FALSE) {
+		if ((matched =3D dowild(p, text)) !=3D NOMATCH) {
 		    if (!special || matched !=3D ABORT_TO_STARSTAR)
 			return matched;
 		} else if (!special && t_ch =3D=3D '/')
@@ -203,18 +206,18 @@ static int dowild(const uchar *p, const uchar *te=
xt)
 		    matched =3D TRUE;
 	    } while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
 	    if (matched =3D=3D special || t_ch =3D=3D '/')
-		return FALSE;
+		return NOMATCH;
 	    continue;
 	}
     }
=20
-    return *text ? FALSE : TRUE;
+    return *text ? NOMATCH : MATCH;
 }
=20
 /* Match the "pattern" against the "text" string. */
 int wildmatch(const char *pattern, const char *text)
 {
-    return dowild((const uchar*)pattern, (const uchar*)text) =3D=3D TR=
UE;
+    return dowild((const uchar*)pattern, (const uchar*)text);
 }
=20
 /* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
@@ -222,7 +225,7 @@ int iwildmatch(const char *pattern, const char *tex=
t)
 {
     int ret;
     force_lower_case =3D 1;
-    ret =3D dowild((const uchar*)pattern, (const uchar*)text) =3D=3D T=
RUE;
+    ret =3D dowild((const uchar*)pattern, (const uchar*)text);
     force_lower_case =3D 0;
     return ret;
 }
--=20
1.7.12.1.406.g6ab07c4
