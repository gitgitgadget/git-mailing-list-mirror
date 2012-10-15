From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/13] wildmatch: remove unnecessary functions
Date: Mon, 15 Oct 2012 13:25:53 +0700
Message-ID: <1350282362-4505-4-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:26:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe8Y-0007S7-AH
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab2JOG0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:26:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46603 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2JOG0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:26:39 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4624959pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YUjCHeRx7WGh4k/d9JtVBgI3QfPUSJO1k3DrMnlMYkc=;
        b=g3cL1I90zb1aWK7ILsoJYFG07lccK8EA9ZyE0Ewms+MOAg7dtwqUJyQ01O5Dk33lJC
         qzZe1vzoGMxSghCMTy2R6dt0/9pqtsnidORd8z1EQ43seIyune8FZCecHPAWdovFsH9e
         M1R6dUY+aFAOTAgebmAqXw6+HAbAp6Wluu/r8IJn3ePB83Q2CSa5Qdgk7UiPMg+PsiX7
         gWqnRXL2yTz0b4eJcYdCwIUb8ar0Ukfsf4HhiENEWQ5IZHzm27HYvWorqe0lkGfEimFO
         6htckRabr4VTKZZ4X1sUb8nAzZ6z161fJLPU5fL/OSdHCsigqu+/uKXRquOztWszpx0g
         HZuw==
Received: by 10.66.75.233 with SMTP id f9mr30388068paw.21.1350282398858;
        Sun, 14 Oct 2012 23:26:38 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id sj5sm8577255pbc.30.2012.10.14.23.26.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:26:38 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:26:29 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207702>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 164 ++++------------------------------------------------=
--------
 wildmatch.h |   2 -
 2 files changed, 10 insertions(+), 156 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index f3a1731..fae7397 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -53,33 +53,18 @@
 #define ISUPPER(c) (ISASCII(c) && isupper(c))
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
=20
-#ifdef WILD_TEST_ITERATIONS
-int wildmatch_iteration_count;
-#endif
-
 static int force_lower_case =3D 0;
=20
-/* Match pattern "p" against the a virtually-joined string consisting
- * of "text" and any strings in array "a". */
-static int dowild(const uchar *p, const uchar *text, const uchar*const=
 *a)
+/* Match pattern "p" against "text" */
+static int dowild(const uchar *p, const uchar *text)
 {
     uchar p_ch;
=20
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count++;
-#endif
-
     for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
 	int matched, special;
 	uchar t_ch, prev_ch;
-	while ((t_ch =3D *text) =3D=3D '\0') {
-	    if (*a =3D=3D NULL) {
-		if (p_ch !=3D '*')
-		    return ABORT_ALL;
-		break;
-	    }
-	    text =3D *a++;
-	}
+	if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
+		return ABORT_ALL;
 	if (force_lower_case && ISUPPER(t_ch))
 	    t_ch =3D tolower(t_ch);
 	switch (p_ch) {
@@ -107,21 +92,15 @@ static int dowild(const uchar *p, const uchar *tex=
t, const uchar*const *a)
 		/* Trailing "**" matches everything.  Trailing "*" matches
 		 * only if there are no more slash characters. */
 		if (!special) {
-		    do {
 			if (strchr((char*)text, '/') !=3D NULL)
 			    return FALSE;
-		    } while ((text =3D *a++) !=3D NULL);
 		}
 		return TRUE;
 	    }
 	    while (1) {
-		if (t_ch =3D=3D '\0') {
-		    if ((text =3D *a++) =3D=3D NULL)
-			break;
-		    t_ch =3D *text;
-		    continue;
-		}
-		if ((matched =3D dowild(p, text, a)) !=3D FALSE) {
+		if (t_ch =3D=3D '\0')
+		    break;
+		if ((matched =3D dowild(p, text)) !=3D FALSE) {
 		    if (!special || matched !=3D ABORT_TO_STARSTAR)
 			return matched;
 		} else if (!special && t_ch =3D=3D '/')
@@ -225,144 +204,21 @@ static int dowild(const uchar *p, const uchar *t=
ext, const uchar*const *a)
 	}
     }
=20
-    do {
-	if (*text)
-	    return FALSE;
-    } while ((text =3D *a++) !=3D NULL);
-
-    return TRUE;
-}
-
-/* Match literal string "s" against the a virtually-joined string cons=
isting
- * of "text" and any strings in array "a". */
-static int doliteral(const uchar *s, const uchar *text, const uchar*co=
nst *a)
-{
-    for ( ; *s !=3D '\0'; text++, s++) {
-	while (*text =3D=3D '\0') {
-	    if ((text =3D *a++) =3D=3D NULL)
-		return FALSE;
-	}
-	if (*text !=3D *s)
-	    return FALSE;
-    }
-
-    do {
-	if (*text)
-	    return FALSE;
-    } while ((text =3D *a++) !=3D NULL);
-
-    return TRUE;
-}
-
-/* Return the last "count" path elements from the concatenated string.
- * We return a string pointer to the start of the string, and update t=
he
- * array pointer-pointer to point to any remaining string elements. */
-static const uchar *trailing_N_elements(const uchar*const **a_ptr, int=
 count)
-{
-    const uchar*const *a =3D *a_ptr;
-    const uchar*const *first_a =3D a;
-
-    while (*a)
-	    a++;
-
-    while (a !=3D first_a) {
-	const uchar *s =3D *--a;
-	s +=3D strlen((char*)s);
-	while (--s >=3D *a) {
-	    if (*s =3D=3D '/' && !--count) {
-		*a_ptr =3D a+1;
-		return s+1;
-	    }
-	}
-    }
-
-    if (count =3D=3D 1) {
-	*a_ptr =3D a+1;
-	return *a;
-    }
-
-    return NULL;
+    return *text ? FALSE : TRUE;
 }
=20
 /* Match the "pattern" against the "text" string. */
 int wildmatch(const char *pattern, const char *text)
 {
-    static const uchar *nomore[1]; /* A NULL pointer. */
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count =3D 0;
-#endif
-    return dowild((const uchar*)pattern, (const uchar*)text, nomore) =3D=
=3D TRUE;
+    return dowild((const uchar*)pattern, (const uchar*)text) =3D=3D TR=
UE;
 }
=20
 /* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
 int iwildmatch(const char *pattern, const char *text)
 {
-    static const uchar *nomore[1]; /* A NULL pointer. */
     int ret;
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count =3D 0;
-#endif
     force_lower_case =3D 1;
-    ret =3D dowild((const uchar*)pattern, (const uchar*)text, nomore) =
=3D=3D TRUE;
+    ret =3D dowild((const uchar*)pattern, (const uchar*)text) =3D=3D T=
RUE;
     force_lower_case =3D 0;
     return ret;
 }
-
-/* Match pattern "p" against the a virtually-joined string consisting
- * of all the pointers in array "texts" (which has a NULL pointer at t=
he
- * end).  The int "where" can be 0 (normal matching), > 0 (match only
- * the trailing N slash-separated filename components of "texts"), or =
< 0
- * (match the "pattern" at the start or after any slash in "texts"). *=
/
-int wildmatch_array(const char *pattern, const char*const *texts, int =
where)
-{
-    const uchar *p =3D (const uchar*)pattern;
-    const uchar*const *a =3D (const uchar*const*)texts;
-    const uchar *text;
-    int matched;
-
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count =3D 0;
-#endif
-
-    if (where > 0)
-	text =3D trailing_N_elements(&a, where);
-    else
-	text =3D *a++;
-    if (!text)
-	return FALSE;
-
-    if ((matched =3D dowild(p, text, a)) !=3D TRUE && where < 0
-     && matched !=3D ABORT_ALL) {
-	while (1) {
-	    if (*text =3D=3D '\0') {
-		if ((text =3D (uchar*)*a++) =3D=3D NULL)
-		    return FALSE;
-		continue;
-	    }
-	    if (*text++ =3D=3D '/' && (matched =3D dowild(p, text, a)) !=3D F=
ALSE
-	     && matched !=3D ABORT_TO_STARSTAR)
-		break;
-	}
-    }
-    return matched =3D=3D TRUE;
-}
-
-/* Match literal string "s" against the a virtually-joined string cons=
isting
- * of all the pointers in array "texts" (which has a NULL pointer at t=
he
- * end).  The int "where" can be 0 (normal matching), or > 0 (match
- * only the trailing N slash-separated filename components of "texts")=
=2E */
-int litmatch_array(const char *string, const char*const *texts, int wh=
ere)
-{
-    const uchar *s =3D (const uchar*)string;
-    const uchar*const *a =3D (const uchar* const*)texts;
-    const uchar *text;
-
-    if (where > 0)
-	text =3D trailing_N_elements(&a, where);
-    else
-	text =3D *a++;
-    if (!text)
-	return FALSE;
-
-    return doliteral(s, text, a) =3D=3D TRUE;
-}
diff --git a/wildmatch.h b/wildmatch.h
index e7f1a35..562faa3 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -2,5 +2,3 @@
=20
 int wildmatch(const char *pattern, const char *text);
 int iwildmatch(const char *pattern, const char *text);
-int wildmatch_array(const char *pattern, const char*const *texts, int =
where);
-int litmatch_array(const char *string, const char*const *texts, int wh=
ere);
--=20
1.8.0.rc0.29.g1fdd78f
