From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] log: decorate grafted commits with "grafted"
Date: Wed, 17 Aug 2011 22:02:06 +0700
Message-ID: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 17:07:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QthiI-0002bU-A9
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 17:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab1HQPHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Aug 2011 11:07:21 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62099 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab1HQPHT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 11:07:19 -0400
Received: by yie30 with SMTP id 30so817063yie.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=j8Q3F47UP6WO5j9eKZCk952zWZCnfycJi95r3GKIMQc=;
        b=h/Ye+RnUdJEHmQ9XgpxKx0mTsFRQ356brfdstMnqLITa8VnQ4x08OXyCGR5CMmx80g
         dqRvR9H0QjyKMjU6rY2/20JEZITNgqopq39/YYoArCK94reObl8l7t3DerP786uXtLy6
         wWxfUOpRhpLGM8rMUUtlG1CcCbW9Ia7wxEjV4=
Received: by 10.142.247.34 with SMTP id u34mr558742wfh.427.1313593637991;
        Wed, 17 Aug 2011 08:07:17 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id v1sm684715pbg.95.2011.08.17.08.07.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Aug 2011 08:07:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:02:07 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179517>

This would help decide whether to deepen some more on shallow
repositories, or the branch really has really ends there.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I briefly considered wrapping _() around "grafted" text, but
 decided that making it a keyword might help searching

 log-tree.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index e945701..c469341 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -18,6 +18,7 @@ enum decoration_type {
 	DECORATION_REF_TAG,
 	DECORATION_REF_STASH,
 	DECORATION_REF_HEAD,
+	DECORATION_GRAFTED
 };
=20
 static char decoration_colors[][COLOR_MAXLEN] =3D {
@@ -27,6 +28,7 @@ static char decoration_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_BOLD_YELLOW,	/* REF_TAG */
 	GIT_COLOR_BOLD_MAGENTA,	/* REF_STASH */
 	GIT_COLOR_BOLD_CYAN,	/* REF_HEAD */
+	GIT_COLOR_BOLD_BLUE,	/* GRAFTED */
 };
=20
 static const char *decorate_get_color(int decorate_use_color, enum dec=
oration_type ix)
@@ -638,6 +640,9 @@ int log_tree_commit(struct rev_info *opt, struct co=
mmit *commit)
 	log.parent =3D NULL;
 	opt->loginfo =3D &log;
=20
+	if (!commit->parents && lookup_commit_graft(commit->object.sha1))
+		add_name_decoration(DECORATION_GRAFTED, "grafted",
+				    &commit->object);
 	shown =3D log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent =3D NULL;
--=20
1.7.4.74.g639db
