From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] diff.c: refactor fn_out_diff_words_write_helper()
Date: Thu, 31 Dec 2015 19:37:34 +0700
Message-ID: <1451565457-18756-5-git-send-email-pclouds@gmail.com>
References: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 13:38:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEcUh-0001V1-Cg
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 13:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbbLaMiK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 07:38:10 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35706 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbbLaMiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 07:38:09 -0500
Received: by mail-pf0-f175.google.com with SMTP id 78so156155445pfw.2
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 04:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yPnDEtPmpWlWZpoBoEBt4Ts4A78+33H2Xp3DYNArUxg=;
        b=o/DXT1+fsKHMbguYiYxrnotqQQDNBGKKcSyR9DJgYMpk0QghrUj/pJ5aTTX+aVX4l1
         aIlYNWO2KRwOL4P0fmyYjSM0BcHjpG8mfl2AtqGtP2H3vS2FmC0J7wNSNrV+9WbpCZtK
         kDtjVEP2RdaQS6QnjEgYZBnBUMuZXhLXWIMwU5xfAfzYN4f7Vpj35AimrZFqdwBhulRU
         BYtZbJWClCKI+SwsZTDMOTOhcVKQaL7pWElpIF3MiLVyK+iGTK4j5fNSxjPXiO43G1pG
         R1z4YxFn4ks4MhrACCvE3RJJVx4KutK8d3FvnKPDBHQ5VYaH8EIJtchz0tM02fW8ZrE6
         HY6Q==
X-Received: by 10.98.71.91 with SMTP id u88mr90888596pfa.30.1451565488989;
        Thu, 31 Dec 2015 04:38:08 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id ud10sm101632772pab.27.2015.12.31.04.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 04:38:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Dec 2015 19:38:06 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283240>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 1354368..8a9e42f 100644
--- a/diff.c
+++ b/diff.c
@@ -807,12 +807,13 @@ static void diff_words_append(struct diff_words_d=
ata *diff_words,
 	buffer->text.ptr[buffer->text.size] =3D '\0';
 }
=20
-static int fn_out_diff_words_write_helper(FILE *fp,
+static int fn_out_diff_words_write_helper(struct diff_words_data *dw,
 					  struct diff_words_style_elem *st_el,
 					  const char *newline,
 					  size_t count, const char *buf,
 					  const char *line_prefix)
 {
+	FILE *fp =3D dw->opt->file;
 	int print =3D 0;
=20
 	while (count) {
@@ -919,7 +920,7 @@ static void fn_out_diff_words_aux(void *priv, char =
*line, unsigned long len)
 		fputs(line_prefix, diff_words->opt->file);
 	}
 	if (diff_words->current_plus !=3D plus_begin) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words,
 				&style->ctx, style->newline,
 				plus_begin - diff_words->current_plus,
 				diff_words->current_plus, line_prefix);
@@ -927,13 +928,13 @@ static void fn_out_diff_words_aux(void *priv, cha=
r *line, unsigned long len)
 			fputs(line_prefix, diff_words->opt->file);
 	}
 	if (minus_begin !=3D minus_end) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words,
 				&style->old, style->newline,
 				minus_end - minus_begin, minus_begin,
 				line_prefix);
 	}
 	if (plus_begin !=3D plus_end) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words,
 				&style->new, style->newline,
 				plus_end - plus_begin, plus_begin,
 				line_prefix);
@@ -1030,7 +1031,7 @@ static void diff_words_show(struct diff_words_dat=
a *diff_words)
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
 		fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words,
 			&style->old, style->newline,
 			diff_words->minus.text.size,
 			diff_words->minus.text.ptr, line_prefix);
@@ -1040,7 +1041,7 @@ static void diff_words_show(struct diff_words_dat=
a *diff_words)
 	/* special case: only addition */
 	if (!diff_words->minus.text.size) {
 		fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words,
 			&style->new, style->newline,
 			diff_words->plus.text.size,
 			diff_words->plus.text.ptr, line_prefix);
@@ -1067,7 +1068,7 @@ static void diff_words_show(struct diff_words_dat=
a *diff_words)
 			diff_words->plus.text.size) {
 		if (color_words_output_graph_prefix(diff_words))
 			fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words,
 			&style->ctx, style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
 			- diff_words->current_plus, diff_words->current_plus,
--=20
2.3.0.rc1.137.g477eb31
