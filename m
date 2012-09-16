From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/5] compat/wildmatch: remove static variable force_lower_case
Date: Sun, 16 Sep 2012 22:27:42 +0700
Message-ID: <1347809265-2457-3-git-send-email-pclouds@gmail.com>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 17:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDGlm-0004Aq-0L
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 17:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214Ab2IPP14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2012 11:27:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61205 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab2IPP1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 11:27:55 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so7881072pbb.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=syBSvKAko8so2du2/nn2P7jO0YfTeBNqDURv3IFHgjc=;
        b=BRPqSxelM7TR5e2YcfiWs1japW/n/NGLxmo1a4ihkA75k852aitPQsHWAN0fa68A7G
         nO3i0VAZRHchklsjxRrpA3nAMUzof2AXFprJMI/kEc3358tGxv7qNG+0Zp8RS+YlyAk0
         bTDsqqKcBDSwCh5p644lAcMQe4lxArqTdTX/AlhdPLs8iVz3o2M1z7zs9qo0lBKoUJjs
         LbhS48203pOOzPbApJSVV4kC82i/o3CAWoy/Xq5y/LfejHEJqVKJktJ+q/MZ+DbGl8NW
         J+jkI07R5iiLMYKaVqaFO/U04LlcI044HIHeP5DfIwrzxr94U4w/NfekD1tPJD+pTp7Q
         EIOA==
Received: by 10.66.79.195 with SMTP id l3mr14826773pax.33.1347809274765;
        Sun, 16 Sep 2012 08:27:54 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id te6sm173530pbc.29.2012.09.16.08.27.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 08:27:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Sep 2012 22:27:58 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
In-Reply-To: <1347809265-2457-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205621>

One place less to worry about thread safety

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index f3a1731..e824eb2 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -57,11 +57,10 @@
 int wildmatch_iteration_count;
 #endif
=20
-static int force_lower_case =3D 0;
-
 /* Match pattern "p" against the a virtually-joined string consisting
  * of "text" and any strings in array "a". */
-static int dowild(const uchar *p, const uchar *text, const uchar*const=
 *a)
+static int dowild(const uchar *p, const uchar *text,
+		  const uchar*const *a, int force_lower_case)
 {
     uchar p_ch;
=20
@@ -121,7 +120,7 @@ static int dowild(const uchar *p, const uchar *text=
, const uchar*const *a)
 		    t_ch =3D *text;
 		    continue;
 		}
-		if ((matched =3D dowild(p, text, a)) !=3D FALSE) {
+		if ((matched =3D dowild(p, text, a, force_lower_case)) !=3D FALSE) {
 		    if (!special || matched !=3D ABORT_TO_STARSTAR)
 			return matched;
 		} else if (!special && t_ch =3D=3D '/')
@@ -291,7 +290,7 @@ int wildmatch(const char *pattern, const char *text=
)
 #ifdef WILD_TEST_ITERATIONS
     wildmatch_iteration_count =3D 0;
 #endif
-    return dowild((const uchar*)pattern, (const uchar*)text, nomore) =3D=
=3D TRUE;
+    return dowild((const uchar*)pattern, (const uchar*)text, nomore, 0=
) =3D=3D TRUE;
 }
=20
 /* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
@@ -302,9 +301,7 @@ int iwildmatch(const char *pattern, const char *tex=
t)
 #ifdef WILD_TEST_ITERATIONS
     wildmatch_iteration_count =3D 0;
 #endif
-    force_lower_case =3D 1;
-    ret =3D dowild((const uchar*)pattern, (const uchar*)text, nomore) =
=3D=3D TRUE;
-    force_lower_case =3D 0;
+    ret =3D dowild((const uchar*)pattern, (const uchar*)text, nomore, =
1) =3D=3D TRUE;
     return ret;
 }
=20
@@ -331,7 +328,7 @@ int wildmatch_array(const char *pattern, const char=
*const *texts, int where)
     if (!text)
 	return FALSE;
=20
-    if ((matched =3D dowild(p, text, a)) !=3D TRUE && where < 0
+    if ((matched =3D dowild(p, text, a, 0)) !=3D TRUE && where < 0
      && matched !=3D ABORT_ALL) {
 	while (1) {
 	    if (*text =3D=3D '\0') {
@@ -339,7 +336,7 @@ int wildmatch_array(const char *pattern, const char=
*const *texts, int where)
 		    return FALSE;
 		continue;
 	    }
-	    if (*text++ =3D=3D '/' && (matched =3D dowild(p, text, a)) !=3D F=
ALSE
+	    if (*text++ =3D=3D '/' && (matched =3D dowild(p, text, a, 0)) !=3D=
 FALSE
 	     && matched !=3D ABORT_TO_STARSTAR)
 		break;
 	}
--=20
1.7.12.403.gce5cf6f.dirty
