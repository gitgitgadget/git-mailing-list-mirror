From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 02/12] ctype: support iscntrl, ispunct, isxdigit and isprint
Date: Sun, 14 Oct 2012 09:35:00 +0700
Message-ID: <1350182110-25936-3-git-send-email-pclouds@gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 04:36:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNE3Y-0005Fq-7v
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634Ab2JNCfp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2012 22:35:45 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42911 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2JNCfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:35:45 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3876368pad.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L3V4p4DFWJkjncutLc6TYkoM9jsx8PDHQ6i6GoqtH6Q=;
        b=dy5abwt2c1f59djMNjdKQA7I225xpHz9UgrgB8hIapzUbqXTd4n8lfl6+fd0GaNrlv
         n9isddOYIt2j558PyCneSORNDkTqc4XEifGAmVzWf41KiPyL+SRNilwLu6qv+5v0r24J
         mncD92CzuIMlYZ9PrV1zqloQ83LkdITLZMhHRzhVJ4acg94QYC3BcIWn73Dc4ErmDMog
         /sFduLEt9M/GTElayFCQqtKnv2MCvr3EMSFD+Mzwk9vzoxE/OrXbB7ZJI52whnr52Ru9
         NGAtNh4C0eURPiH1TQOgB2udR0S09h6dwCOjqh/RMmjEgnZYBDbVxWhZXHTtc6Dw6Sn0
         57WA==
Received: by 10.68.232.71 with SMTP id tm7mr26080019pbc.118.1350182144795;
        Sat, 13 Oct 2012 19:35:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id ni8sm576172pbc.70.2012.10.13.19.35.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 19:35:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 09:35:30 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207593>


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
1.8.0.rc2.11.g2b79d01
