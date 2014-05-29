From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] diff.c: allow to pass more flags to diff_populate_filespec
Date: Thu, 29 May 2014 19:57:06 +0700
Message-ID: <1401368227-14469-3-git-send-email-pclouds@gmail.com>
References: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
 <1401368227-14469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worley@alum.mit.edu, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 14:50:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpzmT-0004JK-UL
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 14:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358AbaE2Mt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 May 2014 08:49:58 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42464 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321AbaE2Mt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 08:49:57 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so5570686wib.5
        for <git@vger.kernel.org>; Thu, 29 May 2014 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qBGaTUyZKY5MiLoiCsKMHzDIRc1jQYazpzURPRwuU+0=;
        b=Sprcr7FXTyLoLhjQNVpEfo8FmyUyw0g3WzyRVNylIfVBSCBCNisZjiN3c8y2fk3UH7
         QlqaT1bvNMWtZLurLC2i/Y0NPfo2ab97B+CsrWSWbuFvDyTjwI5bvafVnfgSarTcvPJ4
         STg6Pb9Os7gVvfjM5K6tC0ey2NwqBdC3ymF5BWaHC7YjnFNmcPg23Zv1VcdF8lfVr/Ok
         Hi2qLCe2iBI/Iyo23qN30g5cJ859+h5MC5nxeJ+8WUkdbC2HR+GF033QiIYM0wy/Agd1
         fovnQGyI42jyLjweo8wDA3sxrmGf/ojLfIbW7Fj+yVTclue9lkdUtcZ4cO2xaIERoAmq
         JPXw==
X-Received: by 10.180.13.239 with SMTP id k15mr11631559wic.4.1401367794120;
        Thu, 29 May 2014 05:49:54 -0700 (PDT)
Received: from lanh ([115.73.231.189])
        by mx.google.com with ESMTPSA id gp15sm1558306wjc.10.2014.05.29.05.49.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 May 2014 05:49:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 29 May 2014 19:57:34 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250368>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c            | 13 +++++++------
 diffcore-rename.c |  6 ++++--
 diffcore.h        |  3 ++-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index f72769a..54281cb 100644
--- a/diff.c
+++ b/diff.c
@@ -373,7 +373,7 @@ static unsigned long diff_filespec_size(struct diff=
_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return 0;
-	diff_populate_filespec(one, 1);
+	diff_populate_filespec(one, DIFF_POPULATE_SIZE_ONLY);
 	return one->size;
 }
=20
@@ -1907,11 +1907,11 @@ static void show_dirstat(struct diff_options *o=
ptions)
 			diff_free_filespec_data(p->one);
 			diff_free_filespec_data(p->two);
 		} else if (DIFF_FILE_VALID(p->one)) {
-			diff_populate_filespec(p->one, 1);
+			diff_populate_filespec(p->one, DIFF_POPULATE_SIZE_ONLY);
 			copied =3D added =3D 0;
 			diff_free_filespec_data(p->one);
 		} else if (DIFF_FILE_VALID(p->two)) {
-			diff_populate_filespec(p->two, 1);
+			diff_populate_filespec(p->two, DIFF_POPULATE_SIZE_ONLY);
 			copied =3D 0;
 			added =3D p->two->size;
 			diff_free_filespec_data(p->two);
@@ -2664,8 +2664,9 @@ static int diff_populate_gitlink(struct diff_file=
spec *s, int size_only)
  * grab the data for the blob (or file) for our own in-core comparison=
=2E
  * diff_filespec has data and size fields for this purpose.
  */
-int diff_populate_filespec(struct diff_filespec *s, int size_only)
+int diff_populate_filespec(struct diff_filespec *s, unsigned int flags=
)
 {
+	int size_only =3D flags & DIFF_POPULATE_SIZE_ONLY;
 	int err =3D 0;
 	/*
 	 * demote FAIL to WARN to allow inspecting the situation
@@ -4695,8 +4696,8 @@ static int diff_filespec_check_stat_unmatch(struc=
t diff_filepair *p)
 	    !DIFF_FILE_VALID(p->two) ||
 	    (p->one->sha1_valid && p->two->sha1_valid) ||
 	    (p->one->mode !=3D p->two->mode) ||
-	    diff_populate_filespec(p->one, 1) ||
-	    diff_populate_filespec(p->two, 1) ||
+	    diff_populate_filespec(p->one, DIFF_POPULATE_SIZE_ONLY) ||
+	    diff_populate_filespec(p->two, DIFF_POPULATE_SIZE_ONLY) ||
 	    (p->one->size !=3D p->two->size) ||
 	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
 		p->skip_stat_unmatch_result =3D 1;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 749a35d..8437917 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -147,9 +147,11 @@ static int estimate_similarity(struct diff_filespe=
c *src,
 	 * is a possible size - we really should have a flag to
 	 * say whether the size is valid or not!)
 	 */
-	if (!src->cnt_data && diff_populate_filespec(src, 1))
+	if (!src->cnt_data &&
+	    diff_populate_filespec(src, DIFF_POPULATE_SIZE_ONLY))
 		return 0;
-	if (!dst->cnt_data && diff_populate_filespec(dst, 1))
+	if (!dst->cnt_data &&
+	    diff_populate_filespec(dst, DIFF_POPULATE_SIZE_ONLY))
 		return 0;
=20
 	max_size =3D ((src->size > dst->size) ? src->size : dst->size);
diff --git a/diffcore.h b/diffcore.h
index c876dac..a186d7c 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -55,7 +55,8 @@ extern void free_filespec(struct diff_filespec *);
 extern void fill_filespec(struct diff_filespec *, const unsigned char =
*,
 			  int, unsigned short);
=20
-extern int diff_populate_filespec(struct diff_filespec *, int);
+#define DIFF_POPULATE_SIZE_ONLY 1
+extern int diff_populate_filespec(struct diff_filespec *, unsigned int=
);
 extern void diff_free_filespec_data(struct diff_filespec *);
 extern void diff_free_filespec_blob(struct diff_filespec *);
 extern int diff_filespec_is_binary(struct diff_filespec *);
--=20
1.9.1.346.ga2b5940
