From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 17/32] setup.c: convert check_repository_format_gently to use strbuf
Date: Thu, 11 Sep 2014 05:41:53 +0700
Message-ID: <1410388928-32265-18-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:43:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqby-0001sf-I1
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbaIJWne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:43:34 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:50389 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbaIJWne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:43:34 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so11169521pad.7
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vk4tL2/Ss1Tuu+gm0lnXJIegn3JE0Sa1twXhJJk545E=;
        b=ZkcXiXZWMDip0fn9h2gUSoHcE018UlZBvr82MeSTWrAyvUWDkkJKO0qiJzWx0satAV
         SFSWAiymJGm6SYmjnxWYGB/H2IoF7XtubqNHZKJaS99qykiU3NsQFlftVsMUZlJFEMoh
         cujL2acdzMoyuOENQhwf0gaFE1uWcsqrgAUUoAEZQt4K1YmQqoAgUF8ZJMNngVUXSojV
         wLFE3hu91GLnNxJawsNCuFk0h+J6XFVoqvrLE3/+S9zKKhVcFTu32m6g1Sn8XguStH4H
         S+IFngw+zEyEiC8B7O2Qb+qyXsfiNKim8IWCOt6oIMcq/lpKCKnNg5QtKPzaPa7RBRF2
         6wYQ==
X-Received: by 10.68.69.109 with SMTP id d13mr26631263pbu.40.1410389013610;
        Wed, 10 Sep 2014 15:43:33 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id z4sm15615247pda.23.2014.09.10.15.43.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:43:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:43:53 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256794>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 176d505..a17389f 100644
--- a/setup.c
+++ b/setup.c
@@ -342,7 +342,9 @@ void setup_work_tree(void)
=20
 static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
 {
-	char repo_config[PATH_MAX+1];
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *repo_config;
+	int ret =3D 0;
=20
 	/*
 	 * git_config() can't be used here because it calls git_pathdup()
@@ -353,7 +355,8 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	snprintf(repo_config, PATH_MAX, "%s/config", gitdir);
+	strbuf_addf(&sb, "%s/config", gitdir);
+	repo_config =3D sb.buf;
 	git_config_early(check_repository_format_version, NULL, repo_config);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
@@ -363,9 +366,10 @@ static int check_repository_format_gently(const ch=
ar *gitdir, int *nongit_ok)
 			GIT_REPO_VERSION, repository_format_version);
 		warning("Please upgrade Git");
 		*nongit_ok =3D -1;
-		return -1;
+		ret =3D -1;
 	}
-	return 0;
+	strbuf_release(&sb);
+	return ret;
 }
=20
 /*
--=20
2.1.0.rc0.78.gc0d8480
