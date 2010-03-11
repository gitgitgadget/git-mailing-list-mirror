From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/16] worktree setup: call set_git_dir explicitly
Date: Thu, 11 Mar 2010 20:22:22 +0700
Message-ID: <1268313754-28179-5-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:23:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMe-0001K7-T7
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421Ab0CKNXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:07 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:40589 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0CKNXC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:02 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so11276pzk.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6f87x1eJIerkcZLJ1G1gGGQwkwCZxwI6GPhNXqNJzFE=;
        b=DBFZO3ZFVesT6PabFndelY14oKdqFub4JojgxK+f/+sD2v5CMpq1++Y0vGMUxelJLw
         9ZwBWQFan7Cf9lKnM3r2NKyLNMDH7A6FE1PqqTX38MD21XCncekKNbP1ipHpgFO+ZFaw
         SnwGCuS0noDt5jPa0LOSjQJ0ysq9kH5XOSktI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cPLDsL7xzaawNT3lTxA+CECrnRjVL5pJ0aheJv4CHYP92cTzuKMxAPW7wsQwMCrdaS
         WnXYWGAXEUAw6MUWuvgN1ml/890TGV1K1dXBTFjTVsrzNxDmPabl9qF1QoeEWSmQXVHF
         xJ4v2Q0sbEsH4cYM8liG+Vk4X1TFcfK748vCI=
Received: by 10.142.55.14 with SMTP id d14mr1368454wfa.123.1268313782333;
        Thu, 11 Mar 2010 05:23:02 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 23sm8893701pzk.2.2010.03.11.05.22.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:00 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:22:56 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141964>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index e067292..43a8609 100644
--- a/setup.c
+++ b/setup.c
@@ -350,14 +350,17 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
 				/* config may override worktree */
 				if (check_repository_format_gently(nongit_ok))
 					return NULL;
+				set_git_dir(gitdirenv);
 				return retval;
 			}
 			if (check_repository_format_gently(nongit_ok))
 				return NULL;
 			retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
 					get_git_work_tree());
-			if (!retval || !*retval)
+			if (!retval || !*retval) {
+				set_git_dir(gitdirenv);
 				return NULL;
+			}
 			set_git_dir(make_absolute_path(gitdirenv));
 			if (chdir(work_tree_env) < 0)
 				die_errno ("Could not chdir to '%s'", work_tree_env);
@@ -392,8 +395,10 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 	offset =3D len =3D strlen(cwd);
 	for (;;) {
 		gitfile_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
-		if (gitfile_dir || is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT)) {
-			if (gitfile_dir && set_git_dir(gitfile_dir))
+		if (!gitfile_dir && is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
+			gitfile_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
+		if (gitfile_dir) {
+			if (set_git_dir(gitfile_dir))
 				die("Repository setup failed");
 			inside_git_dir =3D 0;
 			if (!work_tree_env)
--=20
1.7.0.1.384.g6abcaa
