From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 36/42] Add git_config_early()
Date: Fri, 29 Oct 2010 13:48:48 +0700
Message-ID: <1288334934-17216-37-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:53:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiqb-0007Y0-1o
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933503Ab0J2Gxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:53:51 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab0J2Gxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:53:49 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JZYJJGKGhm+MtYD0TMvwPUQMVBdaggLKNlmpqVKIaCo=;
        b=sQSDYRqooa2QFp54xp+Y7nCHrtqwkjZUKcEuKP3pBxRmjjdjh86qhlGeKKfQwvDNJJ
         zXsrddoLPhpbjJViKae/O9RnjwxjPE/LJLN/IqCzeWSdS7Vgko1jG3TIWjq7eJP//C8g
         KN3JQODom18G+l9aoknDFucxeTSPPg54Yv0UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ftz5urFLVOZmG/YFmBAobiAM/ngSKTm9CUSs/4Xr9L7Yh/2wM/5QlDf3yCFtw1megq
         xd7dJ93K7f2ejHcuYXEqW1VmAg9KR9l+c7xC60Czv2P+ssz8QOeTo0ili3wVtXte6Yxp
         /DIpnBnwpOoyqnPwcl21K65DHctpeJlILSxXE=
Received: by 10.142.136.2 with SMTP id j2mr250571wfd.103.1288335229275;
        Thu, 28 Oct 2010 23:53:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e14sm1028089wfg.20.2010.10.28.23.53.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:53:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:53:47 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160304>

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
1.7.0.2.445.gcbdb3
