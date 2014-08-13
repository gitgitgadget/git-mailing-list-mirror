From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/6] diff.c: allow to pass more flags to diff_populate_filespec
Date: Wed, 13 Aug 2014 17:57:32 +0700
Message-ID: <1407927454-9268-5-git-send-email-pclouds@gmail.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
 <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 12:58:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHWFw-0000Up-AD
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 12:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaHMK6H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2014 06:58:07 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:46069 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbaHMK6D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 06:58:03 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so14263079pdj.16
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=M0s67zHfYRtGpQycdPz0MKeGDE/s+EOriK2XolxN4c8=;
        b=aCCLgvgSgOxvt8v34MEKPhvVvWWxCkRtummnjAcJcjj/UhQhzNnGqFLXmA+rgiPXQK
         A8eG9pod5uGBkcfNc6IucyZ5PO7qglAOz6EiJHQ+BHni/az0AVS0XIdq1h46kec8n6n9
         lfMf2iPyvDRvk+xE7hK32puy3DS/GCv4ytw7KavTJfQaFKFU9Rn/P3u2oVXAN05jge/Z
         /6OOyy449DKV9Ay4zsanCKxLnIVXPyVKfiyWy18NmedmZk9qSnbkbFGoat/m8PPkB3Pa
         x5IwzBQzVtXi1JrWw1ofRb4reC1ywMTgFgVONCBa2imi2jd+19mOYo9z0068yZNr1djZ
         O5BQ==
X-Received: by 10.68.245.135 with SMTP id xo7mr529888pbc.161.1407927483552;
        Wed, 13 Aug 2014 03:58:03 -0700 (PDT)
Received: from lanh ([115.73.196.146])
        by mx.google.com with ESMTPSA id cv2sm1738738pbc.34.2014.08.13.03.58.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2014 03:58:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Aug 2014 17:57:59 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255196>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
