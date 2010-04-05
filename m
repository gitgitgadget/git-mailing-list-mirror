From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/43] Add git_config_early()
Date: Mon,  5 Apr 2010 20:41:11 +0200
Message-ID: <1270492888-26589-27-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH7-0000ps-9K
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab0DESnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:09 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53625 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099Ab0DESnF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:05 -0400
Received: by pva18 with SMTP id 18so1902790pva.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8fUbQEaOMZsESIo+RsmYFeVq7Uv2NA8dX5SMdCmAerM=;
        b=Loyn6Tj0q+5DIs3hGvicdQ+180FYtqSlw1B0CpfnIGV1w8AT0teV3kLbjIu05Moi/8
         2OKb0Ndw/H/a1NDG07vx1QuKrhxpFQeRyiQthLO9UWAnLpyYsel31tmqnCIdlKYKbzij
         fd72nTnTm3cPbIZgHJHAYzFmIdZIJaNiGwcl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bmXAQKLnx4eEf+hmd9ny+1RbIL0cf4ulwg+o39g7CfYHDr3w1JxC2bLOLNichhuK04
         CS80tVsd9fS7d2tx1v8V2X6BgdjhPl1L162lHxGgcX6m1fxcVdS1ED8MYbuGLDl8/lFx
         axPtkDfnjk4qUYmRo2wNvS9XkJrJ6c6pIKVCo=
Received: by 10.141.89.13 with SMTP id r13mr4049586rvl.236.1270492984886;
        Mon, 05 Apr 2010 11:43:04 -0700 (PDT)
Received: from dektop ([72.14.241.34])
        by mx.google.com with ESMTPS id 5sm2998558yxg.28.2010.04.05.11.43.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:04 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:59 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144019>

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
index fa13bf7..f4935b8 100644
--- a/cache.h
+++ b/cache.h
@@ -937,6 +937,7 @@ typedef int (*config_fn_t)(const char *, const char=
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
1.7.0.rc1.541.g2da82.dirty
