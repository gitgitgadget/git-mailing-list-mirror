From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 3/5] diff.c: allow to pass more flags to diff_populate_filespec
Date: Sat, 16 Aug 2014 10:08:04 +0700
Message-ID: <1408158486-7328-4-git-send-email-pclouds@gmail.com>
References: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
 <1408158486-7328-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 05:08:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIUM5-0000zL-IA
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 05:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbaHPDI2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 23:08:28 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:57653 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaHPDI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 23:08:28 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so4295730pdj.36
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 20:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VVWo+Qy+lyuKao+HWoXF/ClVLCpFybfwavVyEBkxXNQ=;
        b=0yXh4/V3WUnGhR8qSKjP5Knonf6BGDZT44BRELzhqm7xbHZu4e0EQbLE/jngWOVpf7
         GVX+/y3W46YXEtqzYcPydKuw30VmXxqdz3xQRuxyVpdTKb478FEhC7g0LF1vzndJOD0e
         5UkLhCyO9chHdwtcgdywjsfqV1tWJhicouk+LWu0yyxqbfOR8W1pNfwI7Q8SwbIsJfVH
         rtjoV10j2A5CD3a8WFziGCQIpCCurm2JAk39FYLkMOGVSBqJgGYTDuzXIPi7uaJAdCLf
         bK7SmNsvVaieQoDysnKAHWubB+i9zfOtyr6PVB6g73CGqt61QFAnWwjuJ1HC7QeEwo+l
         kWxA==
X-Received: by 10.70.22.163 with SMTP id e3mr15145727pdf.157.1408158507828;
        Fri, 15 Aug 2014 20:08:27 -0700 (PDT)
Received: from lanh ([115.73.215.192])
        by mx.google.com with ESMTPSA id ha4sm9318850pbb.78.2014.08.15.20.08.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2014 20:08:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Aug 2014 10:08:25 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1408158486-7328-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255316>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c            | 13 +++++++------
 diffcore-rename.c |  6 ++++--
 diffcore.h        |  3 ++-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 867f034..f4b7421 100644
--- a/diff.c
+++ b/diff.c
@@ -376,7 +376,7 @@ static unsigned long diff_filespec_size(struct diff=
_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return 0;
-	diff_populate_filespec(one, 1);
+	diff_populate_filespec(one, CHECK_SIZE_ONLY);
 	return one->size;
 }
=20
@@ -1910,11 +1910,11 @@ static void show_dirstat(struct diff_options *o=
ptions)
 			diff_free_filespec_data(p->one);
 			diff_free_filespec_data(p->two);
 		} else if (DIFF_FILE_VALID(p->one)) {
-			diff_populate_filespec(p->one, 1);
+			diff_populate_filespec(p->one, CHECK_SIZE_ONLY);
 			copied =3D added =3D 0;
 			diff_free_filespec_data(p->one);
 		} else if (DIFF_FILE_VALID(p->two)) {
-			diff_populate_filespec(p->two, 1);
+			diff_populate_filespec(p->two, CHECK_SIZE_ONLY);
 			copied =3D 0;
 			added =3D p->two->size;
 			diff_free_filespec_data(p->two);
@@ -2668,8 +2668,9 @@ static int diff_populate_gitlink(struct diff_file=
spec *s, int size_only)
  * grab the data for the blob (or file) for our own in-core comparison=
=2E
  * diff_filespec has data and size fields for this purpose.
  */
-int diff_populate_filespec(struct diff_filespec *s, int size_only)
+int diff_populate_filespec(struct diff_filespec *s, unsigned int flags=
)
 {
+	int size_only =3D flags & CHECK_SIZE_ONLY;
 	int err =3D 0;
 	/*
 	 * demote FAIL to WARN to allow inspecting the situation
@@ -4688,8 +4689,8 @@ static int diff_filespec_check_stat_unmatch(struc=
t diff_filepair *p)
 	    !DIFF_FILE_VALID(p->two) ||
 	    (p->one->sha1_valid && p->two->sha1_valid) ||
 	    (p->one->mode !=3D p->two->mode) ||
-	    diff_populate_filespec(p->one, 1) ||
-	    diff_populate_filespec(p->two, 1) ||
+	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
+	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
 	    (p->one->size !=3D p->two->size) ||
 	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
 		p->skip_stat_unmatch_result =3D 1;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 2e44a37..4e132f1 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -147,9 +147,11 @@ static int estimate_similarity(struct diff_filespe=
c *src,
 	 * is a possible size - we really should have a flag to
 	 * say whether the size is valid or not!)
 	 */
-	if (!src->cnt_data && diff_populate_filespec(src, 1))
+	if (!src->cnt_data &&
+	    diff_populate_filespec(src, CHECK_SIZE_ONLY))
 		return 0;
-	if (!dst->cnt_data && diff_populate_filespec(dst, 1))
+	if (!dst->cnt_data &&
+	    diff_populate_filespec(dst, CHECK_SIZE_ONLY))
 		return 0;
=20
 	max_size =3D ((src->size > dst->size) ? src->size : dst->size);
diff --git a/diffcore.h b/diffcore.h
index c876dac..c80df18 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -55,7 +55,8 @@ extern void free_filespec(struct diff_filespec *);
 extern void fill_filespec(struct diff_filespec *, const unsigned char =
*,
 			  int, unsigned short);
=20
-extern int diff_populate_filespec(struct diff_filespec *, int);
+#define CHECK_SIZE_ONLY 1
+extern int diff_populate_filespec(struct diff_filespec *, unsigned int=
);
 extern void diff_free_filespec_data(struct diff_filespec *);
 extern void diff_free_filespec_blob(struct diff_filespec *);
 extern int diff_filespec_is_binary(struct diff_filespec *);
--=20
2.1.0.rc0.78.gc0d8480
