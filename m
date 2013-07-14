From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 38/46] tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
Date: Sun, 14 Jul 2013 15:36:01 +0700
Message-ID: <1373790969-13000-39-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:40:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHqi-0003RM-Us
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab3GNIkC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:40:02 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:42087 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab3GNIkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:40:01 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so10257588pbc.11
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RUEjRqTXn8doFA/1F5xxuKIBn8nLmNgU+q8gGhZ61qA=;
        b=QsV9Vv9gfxivF/0Wz701bc+ACNuI2qXc3TwhStQsi8Rtfuu4LU3y/Gf1DnretC7KdX
         q+WUHqo1VXh0wDYCe/NqRCg0EkB+jIFXTErUk7dfQVud186R4FnDkHvTdpEqnvgt/xeX
         zmyOJmyOTxCALME68PS8j7YAa9D+C2+viY3e1qCPZpzUA1SDy71BnAS5SjiyePmx6x3O
         6xhW5nnFBmalzNQ0B8gJ2amE17goPPnnTC6ZJo4EqJeHLsVc9RKRmLe+1lM7D6DhU7+D
         ZLB0vioJxQ4PjCieYE2O4M0pX8MGyDcK6hIFDgvDdI4cIrGahnUG1T9JM4BURtc/ABqm
         l2Og==
X-Received: by 10.68.58.97 with SMTP id p1mr49469450pbq.144.1373791200364;
        Sun, 14 Jul 2013 01:40:00 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id re16sm57813138pac.16.2013.07.14.01.39.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:39:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:40:12 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230350>

Put a checkpoint to guard unsupported pathspec features in future.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index e1145c6..21a50d8 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -224,7 +224,7 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
-	diff_opts.single_follow =3D opt->pathspec.raw[0];
+	diff_opts.single_follow =3D opt->pathspec.items[0].match;
 	diff_opts.break_opt =3D opt->break_opt;
 	diff_opts.rename_score =3D opt->rename_score;
 	diff_setup_done(&diff_opts);
@@ -243,7 +243,7 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 		 * the future!
 		 */
 		if ((p->status =3D=3D 'R' || p->status =3D=3D 'C') &&
-		    !strcmp(p->two->path, opt->pathspec.raw[0])) {
+		    !strcmp(p->two->path, opt->pathspec.items[0].match)) {
 			const char *path[2];
=20
 			/* Switch the file-pairs around */
--=20
1.8.2.83.gc99314b
