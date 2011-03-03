From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] init: remove unnecessary check
Date: Thu,  3 Mar 2011 19:34:51 +0700
Message-ID: <1299155691-11850-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 13:36:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv7ln-0003Mj-5z
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 13:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757104Ab1CCMge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 07:36:34 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45527 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab1CCMgd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 07:36:33 -0500
Received: by ywj3 with SMTP id 3so344543ywj.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 04:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=bgmKO1vc1eshLUE2mTubaZmI1kufsyEvFtTfzgS/hbo=;
        b=akGitN1q9IiFP8BGNmAFZnthKRE1/wlM46bxFjbMGpvkcwwCw1vgQZxZVvHKueU1iw
         ncqwoog87IbO4CSRT2V3P4QS+wdEfrLvdfs7Raeo9mw67vy+8oyNsQJilIvF3CvyEUtk
         sqo3/+6bTYOsSODUFjqO+yjjIEp/AFR92/qzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Vb9gO5gqZ3kbyPYOr1sWFFHTtqbCgRuniIc4pbXrqNyKbuherItcGg4KYeDvMPtYMo
         NwUg/7JBAjl889c3q7DAUzlDTQWydl6RXr/Agd1NKtkTZtZqTFE62q4geQUZ5I0Ey1j2
         vmnXD95OMhzcVCIw+4AzlH0ni1mNXKh4xWzjM=
Received: by 10.147.170.14 with SMTP id x14mr1432409yao.36.1299155792381;
        Thu, 03 Mar 2011 04:36:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.241.141])
        by mx.google.com with ESMTPS id i60sm757907yhj.17.2011.03.03.04.36.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 04:36:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 Mar 2011 19:34:52 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168390>

git_dir must always be non-NULL so "if (git_dir)" is unnecessary.
Before this code, if git_dir =3D=3D NULL, it will default to
DEFAULT_GIT_DIR_ENVIRONMENT.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/init-db.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 4f5348e..fbeb380 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -498,13 +498,11 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 		is_bare_repository_cfg =3D guess_repository_type(git_dir);
=20
 	if (!is_bare_repository_cfg) {
-		if (git_dir) {
-			const char *git_dir_parent =3D strrchr(git_dir, '/');
-			if (git_dir_parent) {
-				char *rel =3D xstrndup(git_dir, git_dir_parent - git_dir);
-				git_work_tree_cfg =3D xstrdup(make_absolute_path(rel));
-				free(rel);
-			}
+		const char *git_dir_parent =3D strrchr(git_dir, '/');
+		if (git_dir_parent) {
+			char *rel =3D xstrndup(git_dir, git_dir_parent - git_dir);
+			git_work_tree_cfg =3D xstrdup(make_absolute_path(rel));
+			free(rel);
 		}
 		if (!git_work_tree_cfg) {
 			git_work_tree_cfg =3D xcalloc(PATH_MAX, 1);
--=20
1.7.4.74.g639db
