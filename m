From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/10] wildmatch: rename constants and update prototype
Date: Tue,  1 Jan 2013 09:44:05 +0700
Message-ID: <1357008251-10014-5-git-send-email-pclouds@gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 03:45:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TprqY-0000BW-2n
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab3AACof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:44:35 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41597 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab3AACoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:44:34 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so7425872pad.30
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=OQo3afw+No0XIP0dTu6eTEqTOhp3eXoFJ6SbGo6Qfx0=;
        b=hb9UoymiLk75Fv8mVTVzP1Btm/1eV1cMxAxxLevcWaMZkPgY4+eSHYq5AKmXDGAgNa
         YyeARXnEKW2Yh+DR4ka2GFx0vwUyokBtM8vyO++dF1VbVDr4fBnddKiKFCF6PO7I79Wj
         /O0zaz0STWGM5raoGTFYDQKFDms6MVmakO+p2mQgXcdkJLmycF3dz2hmWDXfk/fgugtP
         Oz0ixWrGyyZHpgcq4yOixgM/BPSODFEnOLnnTSzNx0oxGHDwXDv80uoWax/xCjvyuNcE
         3kGlvHzkfIN647krDOs3czOC3D13c27j/1NC0F0z/xgsSAEud0BbvEWwOWhNM6hRkAW7
         FuPA==
X-Received: by 10.68.239.232 with SMTP id vv8mr131599927pbc.53.1357008274101;
        Mon, 31 Dec 2012 18:44:34 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id o5sm26660681pay.5.2012.12.31.18.44.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:44:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:44:37 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212388>

- All exported constants now have a prefix WM_
- Do not rely on FNM_* constants, use the WM_ counterparts
- Remove TRUE and FALSE to follow Git's coding style
- While at it, turn flags type from int to unsigned int
- Add an (unused yet) argument to carry extra information
  so that we don't have to change the prototype again later
  when we need to pass other stuff to wildmatch

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c            |  3 +-
 test-wildmatch.c |  4 +--
 wildmatch.c      | 88 +++++++++++++++++++++++++++---------------------=
--------
 wildmatch.h      | 22 +++++++++-----
 4 files changed, 62 insertions(+), 55 deletions(-)

diff --git a/dir.c b/dir.c
index cb7328b..175a182 100644
--- a/dir.c
+++ b/dir.c
@@ -595,7 +595,8 @@ int match_pathname(const char *pathname, int pathle=
n,
 	}
=20
 	return wildmatch(pattern, name,
-			 ignore_case ? FNM_CASEFOLD : 0) =3D=3D 0;
+			 ignore_case ? WM_CASEFOLD : 0,
+			 NULL) =3D=3D 0;
 }
=20
 /* Scan the list and let the last match determine the fate.
diff --git a/test-wildmatch.c b/test-wildmatch.c
index e384c8e..4bb23b4 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -12,9 +12,9 @@ int main(int argc, char **argv)
 			argv[i] +=3D 3;
 	}
 	if (!strcmp(argv[1], "wildmatch"))
-		return !!wildmatch(argv[3], argv[2], 0);
+		return !!wildmatch(argv[3], argv[2], 0, NULL);
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return !!wildmatch(argv[3], argv[2], FNM_CASEFOLD);
+		return !!wildmatch(argv[3], argv[2], WM_CASEFOLD, NULL);
 	else if (!strcmp(argv[1], "fnmatch"))
 		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
diff --git a/wildmatch.c b/wildmatch.c
index 2d3ed84..2a655fa 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -18,9 +18,6 @@ typedef unsigned char uchar;
 #define NEGATE_CLASS	'!'
 #define NEGATE_CLASS2	'^'
=20
-#define FALSE 0
-#define TRUE 1
-
 #define CC_EQ(class, len, litmatch) ((len) =3D=3D sizeof (litmatch)-1 =
\
 				    && *(class) =3D=3D *(litmatch) \
 				    && strncmp((char*)class, litmatch, len) =3D=3D 0)
@@ -64,7 +61,7 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 		int matched, match_slash, negated;
 		uchar t_ch, prev_ch;
 		if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
-			return ABORT_ALL;
+			return WM_ABORT_ALL;
 		if (force_lower_case && ISUPPER(t_ch))
 			t_ch =3D tolower(t_ch);
 		if (force_lower_case && ISUPPER(p_ch))
@@ -77,12 +74,12 @@ static int dowild(const uchar *p, const uchar *text=
, int force_lower_case)
 			/* FALLTHROUGH */
 		default:
 			if (t_ch !=3D p_ch)
-				return NOMATCH;
+				return WM_NOMATCH;
 			continue;
 		case '?':
 			/* Match anything but '/'. */
 			if (t_ch =3D=3D '/')
-				return NOMATCH;
+				return WM_NOMATCH;
 			continue;
 		case '*':
 			if (*++p =3D=3D '*') {
@@ -101,135 +98,136 @@ static int dowild(const uchar *p, const uchar *t=
ext, int force_lower_case)
 					 * both foo/bar and foo/a/bar.
 					 */
 					if (p[0] =3D=3D '/' &&
-					    dowild(p + 1, text, force_lower_case) =3D=3D MATCH)
-						return MATCH;
-					match_slash =3D TRUE;
+					    dowild(p + 1, text, force_lower_case) =3D=3D WM_MATCH)
+						return WM_MATCH;
+					match_slash =3D 1;
 				} else
-					return ABORT_MALFORMED;
+					return WM_ABORT_MALFORMED;
 			} else
-				match_slash =3D FALSE;
+				match_slash =3D 0;
 			if (*p =3D=3D '\0') {
 				/* Trailing "**" matches everything.  Trailing "*" matches
 				 * only if there are no more slash characters. */
 				if (!match_slash) {
 					if (strchr((char*)text, '/') !=3D NULL)
-						return NOMATCH;
+						return WM_NOMATCH;
 				}
-				return MATCH;
+				return WM_MATCH;
 			}
 			while (1) {
 				if (t_ch =3D=3D '\0')
 					break;
-				if ((matched =3D dowild(p, text,  force_lower_case)) !=3D NOMATCH)=
 {
-					if (!match_slash || matched !=3D ABORT_TO_STARSTAR)
+				if ((matched =3D dowild(p, text,  force_lower_case)) !=3D WM_NOMAT=
CH) {
+					if (!match_slash || matched !=3D WM_ABORT_TO_STARSTAR)
 						return matched;
 				} else if (!match_slash && t_ch =3D=3D '/')
-					return ABORT_TO_STARSTAR;
+					return WM_ABORT_TO_STARSTAR;
 				t_ch =3D *++text;
 			}
-			return ABORT_ALL;
+			return WM_ABORT_ALL;
 		case '[':
 			p_ch =3D *++p;
 #ifdef NEGATE_CLASS2
 			if (p_ch =3D=3D NEGATE_CLASS2)
 				p_ch =3D NEGATE_CLASS;
 #endif
-			/* Assign literal TRUE/FALSE because of "matched" comparison. */
-			negated =3D p_ch =3D=3D NEGATE_CLASS? TRUE : FALSE;
+			/* Assign literal 1/0 because of "matched" comparison. */
+			negated =3D p_ch =3D=3D NEGATE_CLASS ? 1 : 0;
 			if (negated) {
 				/* Inverted character class. */
 				p_ch =3D *++p;
 			}
 			prev_ch =3D 0;
-			matched =3D FALSE;
+			matched =3D 0;
 			do {
 				if (!p_ch)
-					return ABORT_ALL;
+					return WM_ABORT_ALL;
 				if (p_ch =3D=3D '\\') {
 					p_ch =3D *++p;
 					if (!p_ch)
-						return ABORT_ALL;
+						return WM_ABORT_ALL;
 					if (t_ch =3D=3D p_ch)
-						matched =3D TRUE;
+						matched =3D 1;
 				} else if (p_ch =3D=3D '-' && prev_ch && p[1] && p[1] !=3D ']') {
 					p_ch =3D *++p;
 					if (p_ch =3D=3D '\\') {
 						p_ch =3D *++p;
 						if (!p_ch)
-							return ABORT_ALL;
+							return WM_ABORT_ALL;
 					}
 					if (t_ch <=3D p_ch && t_ch >=3D prev_ch)
-						matched =3D TRUE;
+						matched =3D 1;
 					p_ch =3D 0; /* This makes "prev_ch" get set to 0. */
 				} else if (p_ch =3D=3D '[' && p[1] =3D=3D ':') {
 					const uchar *s;
 					int i;
 					for (s =3D p +=3D 2; (p_ch =3D *p) && p_ch !=3D ']'; p++) {} /*SH=
ARED ITERATOR*/
 					if (!p_ch)
-						return ABORT_ALL;
+						return WM_ABORT_ALL;
 					i =3D p - s - 1;
 					if (i < 0 || p[-1] !=3D ':') {
 						/* Didn't find ":]", so treat like a normal set. */
 						p =3D s - 2;
 						p_ch =3D '[';
 						if (t_ch =3D=3D p_ch)
-							matched =3D TRUE;
+							matched =3D 1;
 						continue;
 					}
 					if (CC_EQ(s,i, "alnum")) {
 						if (ISALNUM(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "alpha")) {
 						if (ISALPHA(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "blank")) {
 						if (ISBLANK(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "cntrl")) {
 						if (ISCNTRL(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "digit")) {
 						if (ISDIGIT(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "graph")) {
 						if (ISGRAPH(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "lower")) {
 						if (ISLOWER(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "print")) {
 						if (ISPRINT(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "punct")) {
 						if (ISPUNCT(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "space")) {
 						if (ISSPACE(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "upper")) {
 						if (ISUPPER(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else if (CC_EQ(s,i, "xdigit")) {
 						if (ISXDIGIT(t_ch))
-							matched =3D TRUE;
+							matched =3D 1;
 					} else /* malformed [:class:] string */
-						return ABORT_ALL;
+						return WM_ABORT_ALL;
 					p_ch =3D 0; /* This makes "prev_ch" get set to 0. */
 				} else if (t_ch =3D=3D p_ch)
-					matched =3D TRUE;
+					matched =3D 1;
 			} while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
 			if (matched =3D=3D negated || t_ch =3D=3D '/')
-				return NOMATCH;
+				return WM_NOMATCH;
 			continue;
 		}
 	}
=20
-	return *text ? NOMATCH : MATCH;
+	return *text ? WM_NOMATCH : WM_MATCH;
 }
=20
 /* Match the "pattern" against the "text" string. */
-int wildmatch(const char *pattern, const char *text, int flags)
+int wildmatch(const char *pattern, const char *text,
+	      unsigned int flags, struct wildopts *wo)
 {
 	return dowild((const uchar*)pattern, (const uchar*)text,
-		      flags & FNM_CASEFOLD ? 1 :0);
+		      flags & WM_CASEFOLD ? 1 :0);
 }
diff --git a/wildmatch.h b/wildmatch.h
index 984a38c..1c814fd 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -1,9 +1,17 @@
-/* wildmatch.h */
+#ifndef WILDMATCH_H
+#define WILDMATCH_H
=20
-#define ABORT_MALFORMED 2
-#define NOMATCH 1
-#define MATCH 0
-#define ABORT_ALL -1
-#define ABORT_TO_STARSTAR -2
+#define WM_CASEFOLD 1
=20
-int wildmatch(const char *pattern, const char *text, int flags);
+#define WM_ABORT_MALFORMED 2
+#define WM_NOMATCH 1
+#define WM_MATCH 0
+#define WM_ABORT_ALL -1
+#define WM_ABORT_TO_STARSTAR -2
+
+struct wildopts;
+
+int wildmatch(const char *pattern, const char *text,
+	      unsigned int flags,
+	      struct wildopts *wo);
+#endif
--=20
1.8.0.rc2.23.g1fb49df
