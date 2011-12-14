From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] merge: abort if fails to commit
Date: Wed, 14 Dec 2011 21:08:18 +0700
Message-ID: <1323871699-8839-3-git-send-email-pclouds@gmail.com>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 15:08:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RapVq-0002DL-4N
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260Ab1LNOIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 09:08:46 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34174 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab1LNOIq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 09:08:46 -0500
Received: by mail-gy0-f174.google.com with SMTP id z12so638879ghb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Oiy5WJQbqSki7whmF6p6uLPZUKJWH5BwVZl8w1BFvEw=;
        b=g4JEvExgThV+YM5pbRzejZR1lV/QSInfaIfbmsV8/Wq2oOYJkENyxDj2cOrZkGGh3X
         tiXTeqdV5M3VdmeLwmPSdP8H9k1sm7eKgPMSFpH75NpHyZD0BAKK29mj2TPYIP1VSAdY
         DvwXLHYfr1M/l7dPyx0LRntSju0rVkDWfnKLA=
Received: by 10.50.190.195 with SMTP id gs3mr5315202igc.82.1323871725422;
        Wed, 14 Dec 2011 06:08:45 -0800 (PST)
Received: from tre ([115.74.57.162])
        by mx.google.com with ESMTPS id lu10sm4307289igc.0.2011.12.14.06.08.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 06:08:44 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 14 Dec 2011 21:08:41 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323871699-8839-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187117>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index df4548a..e57eefa 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -913,7 +913,9 @@ static int merge_trivial(struct commit *head)
 	parent->next->item =3D remoteheads->item;
 	parent->next->next =3D NULL;
 	prepare_to_commit();
-	commit_tree(merge_msg.buf, merge_msg.len, result_tree, parent, result=
_commit, NULL);
+	if (commit_tree(merge_msg.buf, merge_msg.len,
+			result_tree, parent, result_commit, NULL))
+		die(_("failed to write commit object"));
 	finish(head, result_commit, "In-index merge");
 	drop_save();
 	return 0;
@@ -944,7 +946,9 @@ static int finish_automerge(struct commit *head,
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit();
 	free_commit_list(remoteheads);
-	commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents, resul=
t_commit, NULL);
+	if (commit_tree(merge_msg.buf, merge_msg.len,
+			result_tree, parents, result_commit, NULL))
+		die(_("failed to write commit object"));
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, result_commit, buf.buf);
 	strbuf_release(&buf);
--=20
1.7.8.36.g69ee2
