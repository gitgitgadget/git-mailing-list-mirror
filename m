From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 02/12] ctype: support iscntrl, ispunct, isxdigit and isprint
Date: Wed, 10 Oct 2012 17:40:41 +0700
Message-ID: <1349865651-31889-3-git-send-email-pclouds@gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:41:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtjB-0002Z3-91
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab2JJKlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:41:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34755 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab2JJKlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:41:13 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so575878pbb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P5vPSmzlOEn0sSlX6BzNCK1nWjGgcFqrdhvUykDRlBM=;
        b=CelzgS2l06oG+sqf64Kjbe+2e5vY2t8zj8qwZ3jdKYfLakISAhidPOfDrWWmubzvej
         4LD1cvcKpfnLusSqxYV1+q7houJGSU9aM42DFKwpiUomjjVWYRSzfCFeGwGHg5JFA+6N
         DSiK/OARU98hUh3ev5Hmdj6KEFzy449Ze+jY56N5DqUlc0NkJJq9e/Wwl6QSSR5Idkko
         jN254lo5zY97hixJqBSwoNvqLfuuW3Q82wyQ2a2I37/VA6D7CP/Cu+pDoqxrLonwbztb
         d1Mxuoz80819bc2nyacrdhLlkpJFDJMZWKzUJXN/DdrDTNwNlrU7qIul+JYaQ/9q+944
         aYYg==
Received: by 10.68.190.197 with SMTP id gs5mr73605162pbc.124.1349865672844;
        Wed, 10 Oct 2012 03:41:12 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id d9sm666815paw.35.2012.10.10.03.41.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:41:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:41:04 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207387>

A new table sane_ctype2[] is added, otherwise we'll need to OR with
current bits in sane_ctype[] and that looks ugly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ctype.c           | 18 ++++++++++++++++++
 git-compat-util.h | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/ctype.c b/ctype.c
index faeaf34..b4bf48a 100644
--- a/ctype.c
+++ b/ctype.c
@@ -26,6 +26,24 @@ const unsigned char sane_ctype[256] =3D {
 	/* Nothing in the 128.. range */
 };
=20
+enum {
+	CN =3D GIT_CNTRL,
+	PU =3D GIT_PUNCT,
+	XD =3D GIT_XDIGIT,
+};
+
+const unsigned char sane_ctype2[256] =3D {
+	CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, /*   =
 0..15 */
+	CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, CN, /*   =
16..31 */
+	0,  PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, PU, /*   =
32..47 */
+	XD, XD, XD, XD, XD, XD, XD, XD, XD, XD, PU, PU, PU, PU, PU, PU, /*   =
48..63 */
+	PU, 0,	XD, 0,	XD, 0,	XD, 0,	0,  0,	0,  0,	0,  0,	0,  0,	/*   64..79 *=
/
+	0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  PU, PU, PU, PU, PU, /*   =
80..95 */
+	PU, 0,	XD, 0,	XD, 0,	XD, 0,	0,  0,	0,  0,	0,  0,	0,  0,	/*  96..111 *=
/
+	0,  0,	0,  0,	0,  0,	0,  0,	0,  0,	0,  PU, PU, PU, PU, CN, /* 112..12=
7 */
+	/* Nothing in the 128.. range */
+};
+
 /* For case-insensitive kwset */
 const char tolower_trans_tbl[256] =3D {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
diff --git a/git-compat-util.h b/git-compat-util.h
index f8b859c..ea11694 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -510,14 +510,23 @@ extern const char tolower_trans_tbl[256];
 #undef isupper
 #undef tolower
 #undef toupper
+#undef iscntrl
+#undef ispunct
+#undef isxdigit
+#undef isprint
 extern const unsigned char sane_ctype[256];
+extern const unsigned char sane_ctype2[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
 #define GIT_GLOB_SPECIAL 0x08
 #define GIT_REGEX_SPECIAL 0x10
 #define GIT_PATHSPEC_MAGIC 0x20
+#define GIT_CNTRL 0x01
+#define GIT_PUNCT 0x02
+#define GIT_XDIGIT 0x04
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask))=
 !=3D 0)
+#define sane_istest2(x,mask) ((sane_ctype2[(unsigned char)(x)] & (mask=
)) !=3D 0)
 #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
@@ -527,6 +536,10 @@ extern const unsigned char sane_ctype[256];
 #define isupper(x) sane_iscase(x, 0)
 #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
 #define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX=
_SPECIAL)
+#define iscntrl(x) sane_istest2(x, GIT_CNTRL)
+#define ispunct(x) sane_istest2(x, GIT_PUNCT)
+#define isxdigit(x) sane_istest2(x, GIT_XDIGIT)
+#define isprint(x) (isalnum(x) || isspace(x) || ispunct(x))
 #define tolower(x) sane_case((unsigned char)(x), 0x20)
 #define toupper(x) sane_case((unsigned char)(x), 0)
 #define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
--=20
1.7.12.1.406.g6ab07c4
