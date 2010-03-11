From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/16] Add git_config_early()
Date: Thu, 11 Mar 2010 20:22:23 +0700
Message-ID: <1268313754-28179-6-git-send-email-pclouds@gmail.com>
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
	id 1NpiMf-0001K7-EF
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427Ab0CKNXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:11 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57809 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0CKNXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:07 -0500
Received: by mail-pv0-f174.google.com with SMTP id 32so5497pvb.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=j4lUD8ANGdpzClvMb2HYJUUIpFSgqSNJ7KGQLpDDJA4=;
        b=denVzydj88v/RJfZ2cCZ/9j6qrUe1F+XTNGyXRUZoAf6fZ1lfAxnH7bpLP9PFcooD1
         JsXNS6gT8L0Q4SkOH4Mw+0ghrhJwIvwts+aOdmpT9TR+Axv/U64UP0PeG9KC4UvE+0yD
         2QCIgYP64gtsR+urPAWSJM9wuE+jB+iG5hf24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dIOdXrrhaJviTce5f13cEGTiLCFfkJglXOYUIPRF7yJdapwxLmWpfvzfA27rJJwdQz
         PjFJEIPYgwe6+NL/7HaA5EN7sD0+M7aTQcTzlAHATXZRxh8f6AaX8vTdpSNiwJco3RIv
         HeOUZ9pxYDMfQDGUy3OnRAQisTs7jz7I4Yhnk=
Received: by 10.142.118.2 with SMTP id q2mr1353892wfc.292.1268313787393;
        Thu, 11 Mar 2010 05:23:07 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 21sm8779204pzk.8.2010.03.11.05.23.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:02 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141966>

This version of git_config() will be used during repository setup.
As a repository is being set up, $GIT_DIR is not nailed down yet,
git_pathdup() should not be used to get $GIT_DIR/config.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h  |    1 +
 config.c |   19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 68412c0..3bd219c 100644
--- a/cache.h
+++ b/cache.h
@@ -933,6 +933,7 @@ typedef int (*config_fn_t)(const char *, const char=
 *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config(config_fn_t fn, void *);
+extern int git_config_early(config_fn_t fn, void *, const char *repo_c=
onfig);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
diff --git a/config.c b/config.c
index 6963fbe..2d38096 100644
--- a/config.c
+++ b/config.c
@@ -699,10 +699,9 @@ int git_config_global(void)
 	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
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
@@ -724,17 +723,27 @@ int git_config(config_fn_t fn, void *data)
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
 	if (found =3D=3D 0)
 		return -1;
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
1.7.0.1.384.g6abcaa
