From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/9] Add git_config_early()
Date: Mon,  1 Nov 2010 13:26:28 +0700
Message-ID: <1288592794-24221-3-git-send-email-pclouds@gmail.com>
References: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 07:27:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCnrP-0001mP-QN
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 07:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab0KAG04 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 02:26:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55500 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab0KAG0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 02:26:54 -0400
Received: by gyg4 with SMTP id 4so2940773gyg.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 23:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=V79nleXwHoR9vcEePmBPwzFZsP43xacwRU8SWQ9s2xc=;
        b=nhpfHp9znrEu5O6oVsETbKyBovS1Jfkaq+yyCiLprmvnSmL94lgDQ2+LtHn+VGCEUs
         aZ8P7Q29AuaUcikY90Jrzse6edYANJreYobzLasj68kn2SCoaxGc0fSZl0VBg5jaSiyE
         YZlghhR/gQP3HqMFz8bFv0gKEMkIhqYEE77d8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TTTE8oOBq+twyzh3makWZLS1yc2tO0iNGPaDC8HkuPmNpChkSe80sjREChD6ZdmFw7
         gLaVk0r24ALedyTBmb2g6AwZq2ap7wo+2yRPon3jBExiKatt9Wab52wQVsMEK+RoWG72
         +eb5v1SaJxafvnyhghEpq3yDS2eOSxaPSWYkM=
Received: by 10.150.143.17 with SMTP id q17mr24259977ybd.141.1288592814021;
        Sun, 31 Oct 2010 23:26:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id h1sm7078414yba.14.2010.10.31.23.26.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 23:26:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 01 Nov 2010 13:26:54 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160462>

This version of git_config() will be used during repository setup.
As a repository is being set up, $GIT_DIR is not nailed down yet,
git_pathdup() should not be used to get $GIT_DIR/config.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Unchanged.

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
1.7.3.2.210.g045198
