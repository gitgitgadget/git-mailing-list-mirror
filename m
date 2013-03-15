From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 38/45] tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
Date: Fri, 15 Mar 2013 13:06:53 +0700
Message-ID: <1363327620-29017-39-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:28:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO8K-0007yp-NF
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab3COG20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:28:26 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:56867 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab3COG2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:28:25 -0400
Received: by mail-ia0-f176.google.com with SMTP id i18so2871143iac.35
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=HZYIjEctRdWperJ01L4wPjFWgZG+gw/WdAxSdfLuGBg=;
        b=Q5SYZAEVsu7PwPBLf/ID2CxB/QlkNtiPcoXxpBZAC+nmpqgnZy3MHJAXMd+762I5wD
         12yfcq/2rDJH13YA8h4O+0kwBVUYBQOqQmaV1nn/A93MdmDM3R68PcxEl8IcWWh+GVMW
         ePt/ybJHDVmE/d+L+zaQexWw2MdGeXelP7jMGPdO1W+lQmTDi8wP8pG+iPpRpSgtGq+g
         LI4oBXEr0VK5vK6fvoiHULPvM0BhefFN0o4GFucMQlFObUrcccYZiK982w0kOuCcVRre
         qgJdxW6zXV2pGG+G+vSzMqGtFv90QGBBwoj1eXYjhHbJ8veWJjGRRAkZViRzlFzdREok
         eG+A==
X-Received: by 10.43.9.137 with SMTP id ow9mr3888961icb.32.1363328905184;
        Thu, 14 Mar 2013 23:28:25 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id g6sm624154ign.4.2013.03.14.23.28.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:28:24 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:11:27 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218225>

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
1.8.0.rc0.19.g7bbb31d
