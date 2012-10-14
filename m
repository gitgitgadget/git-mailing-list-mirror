From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 04/12] wildmatch: remove unnecessary functions
Date: Sun, 14 Oct 2012 09:35:02 +0700
Message-ID: <1350182110-25936-5-git-send-email-pclouds@gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 04:36:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNE3o-0005XF-6x
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab2JNCf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2012 22:35:59 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42911 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2JNCf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:35:58 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3876368pad.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mt95GQcVuMoOzfi0g0dSaKP+t1tSUoCz6V/RxhPEpyc=;
        b=Qufre4zm9bH8grnomlR0d3EejaXgnOCIStkc3PjlR5UAQwWEt6XwAsMlfEjNof32kg
         KpW4BEv0UJ8Ofvoy7tYTDSa679x3qTYod3MCPQO9dnUjA7rINNYBU05lAIFkus+u21uL
         s6eV98ZJ0ox/SBK6W9w7QDM8OXE/XjUEZfRTi7oZP5RkBedQoKRmcPLDhRRiO+oQtFL+
         u4SViAAElMO/mFsbUTwQ/xOnf0bjVG5NBQ9n18D3UJ5vb5EgwsccZzZCbhKRTihuHlVI
         ahLfhYZ88P59WY540I30WyXZ2uVtxmVa0l+0SI3cpWWvKBSkQAqk9H/53hhFJvgBP3iH
         yPPQ==
Received: by 10.68.229.138 with SMTP id sq10mr26199135pbc.126.1350182158506;
        Sat, 13 Oct 2012 19:35:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id kn8sm4037558pbc.24.2012.10.13.19.35.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 19:35:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 09:35:43 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207595>


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
1.8.0.rc2.11.g2b79d01
