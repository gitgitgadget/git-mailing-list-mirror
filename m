From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/13] wildmatch: make wildmatch's return value compatible with fnmatch
Date: Mon, 15 Oct 2012 13:25:57 +0700
Message-ID: <1350282362-4505-8-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:27:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe97-00081D-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab2JOG1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:27:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46603 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2JOG1N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:27:13 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4624959pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0UhpoMGpQccUQd1oQcbAxPVWJhsAkjcdwkHsKuN9kiw=;
        b=TJhfTUBRTK8/czeF4YxJoVo9zTqP488o6ltf5n3TmJzF9ooVb1rB7Ur9wa/z7a25ki
         XKyBYG4CU0uq0bJxXT3eRiZKXDI8mR6GPPgNj0rarcdDs+TuRb5yt7QSiR29xfsioqlb
         3U1QaCA79vkzwzewUgZ7Un0HcvBD1oPVlEWzE9B5tlvisSM0gwMh0dKaK8kGWFVastqd
         hsqsikq5Wzu29L/fHWoaAUOg4oXRbyL5u8nUsrB26lnTxOitwtaYO1v47FfCstF35QR/
         Et4mNKMWzt0n8J+MaCLRqf9vVZJx6UvmsMbALSr1QUNePK3p2EFIZbh7Uvbp5ojAw1Um
         Zk0g==
Received: by 10.68.131.35 with SMTP id oj3mr34125697pbb.128.1350282433280;
        Sun, 14 Oct 2012 23:27:13 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id uh7sm8577160pbc.35.2012.10.14.23.27.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:27:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:27:03 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207706>

wildmatch returns non-zero if matched, zero otherwise. This patch
makes it return zero if matches, non-zero otherwise, like fnmatch().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-wildmatch.c |  4 ++--
 wildmatch.c      | 21 ++++++++++++---------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/test-wildmatch.c b/test-wildmatch.c
index ac56420..77014e9 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -4,9 +4,9 @@
 int main(int argc, char **argv)
 {
 	if (!strcmp(argv[1], "wildmatch"))
-		return wildmatch(argv[3], argv[2]) ? 0 : 1;
+		return !!wildmatch(argv[3], argv[2]);
 	else if (!strcmp(argv[1], "iwildmatch"))
-		return iwildmatch(argv[3], argv[2]) ? 0 : 1;
+		return !!iwildmatch(argv[3], argv[2]);
 	else if (!strcmp(argv[1], "fnmatch"))
 		return !!fnmatch(argv[3], argv[2], FNM_PATHNAME);
 	else
diff --git a/wildmatch.c b/wildmatch.c
index ac29471..6d992d3 100644
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
@@ -78,12 +81,12 @@ static int dowild(const uchar *p, const uchar *text=
)
 			/* FALLTHROUGH */
 		default:
 			if (t_ch !=3D p_ch)
-				return FALSE;
+				return NOMATCH;
 			continue;
 		case '?':
 			/* Match anything but '/'. */
 			if (t_ch =3D=3D '/')
-				return FALSE;
+				return NOMATCH;
 			continue;
 		case '*':
 			if (*++p =3D=3D '*') {
@@ -96,14 +99,14 @@ static int dowild(const uchar *p, const uchar *text=
)
 				 * only if there are no more slash characters. */
 				if (!special) {
 					if (strchr((char*)text, '/') !=3D NULL)
-						return FALSE;
+						return NOMATCH;
 				}
-				return TRUE;
+				return MATCH;
 			}
 			while (1) {
 				if (t_ch =3D=3D '\0')
 					break;
-				if ((matched =3D dowild(p, text)) !=3D FALSE) {
+				if ((matched =3D dowild(p, text)) !=3D NOMATCH) {
 					if (!special || matched !=3D ABORT_TO_STARSTAR)
 						return matched;
 				} else if (!special && t_ch =3D=3D '/')
@@ -202,18 +205,18 @@ static int dowild(const uchar *p, const uchar *te=
xt)
 					matched =3D TRUE;
 			} while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
 			if (matched =3D=3D special || t_ch =3D=3D '/')
-				return FALSE;
+				return NOMATCH;
 			continue;
 		}
 	}
=20
-	return *text ? FALSE : TRUE;
+	return *text ? NOMATCH : MATCH;
 }
=20
 /* Match the "pattern" against the "text" string. */
 int wildmatch(const char *pattern, const char *text)
 {
-	return dowild((const uchar*)pattern, (const uchar*)text) =3D=3D TRUE;
+	return dowild((const uchar*)pattern, (const uchar*)text);
 }
=20
 /* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
@@ -221,7 +224,7 @@ int iwildmatch(const char *pattern, const char *tex=
t)
 {
 	int ret;
 	force_lower_case =3D 1;
-	ret =3D dowild((const uchar*)pattern, (const uchar*)text) =3D=3D TRUE=
;
+	ret =3D dowild((const uchar*)pattern, (const uchar*)text);
 	force_lower_case =3D 0;
 	return ret;
 }
--=20
1.8.0.rc0.29.g1fdd78f
