From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 37/47] Add git_config_early()
Date: Fri, 26 Nov 2010 22:32:33 +0700
Message-ID: <1290785563-15339-38-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:48:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0X4-0008U3-C6
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391Ab0KZPr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:47:57 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:62216 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0KZPr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:47:56 -0500
Received: by mail-pz0-f66.google.com with SMTP id 26so457989pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=H6a8znNdkvXYNdgf1Bzn7XKUAKU03DBaXjyqMss6tVU=;
        b=jcxGC/WT++05piThbF3apCi7TtHTRAvAfAMGCy+/w9EOqZbg4xuu62sZVkTxQs8/zB
         2HfjKjZQ4x4JddcJI8HCFxn1fxlO4mp5dUmjTMIiDJA3sWq4Pxx3fV8R+dQQ7m7hAjR5
         npE8jYPk0vG6lc+X6s6ma68ayQBmCEj4aoCWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xZqJeZl8jTIjunmfR5tmyE0BLORkSNLiQkA617g/D+mKNrRYQxPp1ZZBiKenPTKtRm
         vG7IS0dlVeJO8BMzLc0L3JgHkGu/ehxr4ZEjceYve8ns7lXScDEU8/ESYjfbR3LCgcdS
         bYUi+VWdJdUs25T6Sf6gSr4kybdoGox/pi6rc=
Received: by 10.142.162.15 with SMTP id k15mr2502441wfe.354.1290786476071;
        Fri, 26 Nov 2010 07:47:56 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id f5sm2689399wfg.14.2010.11.26.07.47.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:47:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:46:44 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162250>

This version of git_config() will be used during repository setup.
As a repository is being set up, $GIT_DIR is not nailed down yet,
git_pathdup() should not be used to get $GIT_DIR/config.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h  |    1 +
 config.c |   19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index d1bee5d..123dd4b 100644
--- a/cache.h
+++ b/cache.h
@@ -986,6 +986,7 @@ extern int git_config_parse_parameter(const char *t=
ext);
 extern int git_config_parse_environment(void);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
+extern int git_config_early(config_fn_t fn, void *, const char *repo_c=
onfig);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
diff --git a/config.c b/config.c
index 4b0a820..c431f41 100644
--- a/config.c
+++ b/config.c
@@ -835,10 +835,9 @@ int git_config_from_parameters(config_fn_t fn, voi=
d *data)
 	return 0;
 }
=20
-int git_config(config_fn_t fn, void *data)
+int git_config_early(config_fn_t fn, void *data, const char *repo_conf=
ig)
 {
 	int ret =3D 0, found =3D 0;
-	char *repo_config =3D NULL;
 	const char *home =3D NULL;
=20
 	/* Setting $GIT_CONFIG makes git read _only_ the given config file. *=
/
@@ -860,12 +859,10 @@ int git_config(config_fn_t fn, void *data)
 		free(user_config);
 	}
=20
-	repo_config =3D git_pathdup("config");
-	if (!access(repo_config, R_OK)) {
+	if (repo_config && !access(repo_config, R_OK)) {
 		ret +=3D git_config_from_file(fn, repo_config, data);
 		found +=3D 1;
 	}
-	free(repo_config);
=20
 	ret +=3D git_config_from_parameters(fn, data);
 	if (config_parameters)
@@ -876,6 +873,18 @@ int git_config(config_fn_t fn, void *data)
 	return ret;
 }
=20
+int git_config(config_fn_t fn, void *data)
+{
+	char *repo_config =3D NULL;
+	int ret;
+
+	repo_config =3D git_pathdup("config");
+	ret =3D git_config_early(fn, data, repo_config);
+	if (repo_config)
+		free(repo_config);
+	return ret;
+}
+
 /*
  * Find all the stuff for git_config_set() below.
  */
--=20
1.7.3.2.316.gda8b3
