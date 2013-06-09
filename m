From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 38/45] tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
Date: Sun,  9 Jun 2013 13:26:11 +0700
Message-ID: <1370759178-1709-39-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:29:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ7Z-0001kj-TU
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941Ab3FIG2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:28:54 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:44026 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab3FIG2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:28:53 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so2414223pde.32
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RUEjRqTXn8doFA/1F5xxuKIBn8nLmNgU+q8gGhZ61qA=;
        b=CqwMZFK7jfmFcQo6Cks6heePZcYf71YgWlmEwNBo98Yq/ijIyCcWjWl8tH82SX1rnW
         ayvr3uURjBoQkKi9Zgwh55L0SwgmbJqZgq7YRfTg/ZHyDd6d52jzIpwV6DlYAb/yfHW8
         0ZQ3P7mvGL4+OPyUGtNFB+l/wdzSN+0BHVgdLTjqNhsiHwTsgym+zfaY/vDCtC+gcsFD
         DGYbFm7DqfSZbDuB43OEgzw521+hK6oOsx9dhQENWkPA7nqMnhNkaqI9CMdeQk65a3iq
         J4bXYUm/UiBdQK6DSpWy47qPP69aGaRqKUJAGU2qJMcz/N5yPPshHJc9Mfd3wdbjz2+J
         frdw==
X-Received: by 10.68.201.163 with SMTP id kb3mr4970850pbc.191.1370759332939;
        Sat, 08 Jun 2013 23:28:52 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id xd2sm10231487pac.15.2013.06.08.23.28.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:28:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:30:24 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226930>

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
