From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 30/31] tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
Date: Sun, 13 Jan 2013 19:35:38 +0700
Message-ID: <1358080539-17436-31-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:39:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMqf-0000JI-00
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab3AMMjQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:39:16 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40979 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab3AMMjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:39:16 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so1751916pad.38
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=708PPEgDbDsMp1pk5JGzEINNPWjs7q9QN2H8pwuKssU=;
        b=Uv6tBsCGWeutM5XtItP88W8enYATQTzuRP2yRWTpt4a11l9dXgCtO2Pzwnsoc8HTU5
         zSZo55YsotkUTNJMOpnwV+hT2XrtVj8TqpaKsZqpkaikp9XgdFH20KSqIGHqmsGdE7Uk
         mS0cmlGicpKvcCUSKX8bcEmAbE1M6Z5jJ2Ly/UtVhrkjR/A0/8WFwufFYJtlBnSlQHhK
         Vm9UG+GZEuOuTr6975pzhGkmSKWeZiYs2n2PBtkgH3vkh4nzr+tY4sGvbaIzVeU95iet
         GTIhs+A+BC0ssYMcP3TFFOHAUuaISqVjDkowp0n2rs2K1V8kT3iHwe24DuNw4DaQSdyd
         A2Yg==
X-Received: by 10.66.86.101 with SMTP id o5mr223391311paz.15.1358080755696;
        Sun, 13 Jan 2013 04:39:15 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id nw9sm6291182pbb.42.2013.01.13.04.39.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:39:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:39:30 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213369>

Put a checkpoint to guard unsupported pathspec features in future.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index aba6df7..718f938 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -225,7 +225,7 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
-	diff_opts.single_follow =3D opt->pathspec.raw[0];
+	diff_opts.single_follow =3D opt->pathspec.items[0].match;
 	diff_opts.break_opt =3D opt->break_opt;
 	diff_opts.rename_score =3D opt->rename_score;
 	diff_setup_done(&diff_opts);
@@ -244,7 +244,7 @@ static void try_to_follow_renames(struct tree_desc =
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
1.8.0.rc2.23.g1fb49df
