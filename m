From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/16] config: do not read .git/config if there is no repository
Date: Thu, 11 Mar 2010 20:22:31 +0700
Message-ID: <1268313754-28179-14-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiNe-0001wN-U2
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909Ab0CKNXz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:55 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60688 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab0CKNXv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:51 -0500
Received: by mail-pw0-f46.google.com with SMTP id 1so9492pwi.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BBDoRkfn4rR9pf+YABhawAZ+kaKLJIgCX1D3nP7ZOEU=;
        b=Y7PKAk/v6OWuJoLM/2n+sqaRYB2B6ZTrvHF+HeusHFxrFG4SSaW/bgFTPf3swVdtDT
         69oMV9DAFF0ZFHmgEuPCh653lGHRoYZ0xbOFN51PVOyvVj6ZdmQMqYd+M/xHT9ZnZ/l9
         b4A8WW9+1iIL/yBZOnT5bNiDrF70UG6INCEPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=B0d/9YRzDU2JUoFuWPPeCLOrmtKThI5CDtfRY96K+Q+ah9vFHx+uHdvd8yl/mbWVG3
         lqmcDguI9TkMH9yQu3QCelAFuhUEsrRUbK/ZM6zzfZxBm+nY4G+Yq623nHcCIEoxQ7wI
         ZdJshq7d8t3yEYvkS+Hl858KuLXLhpdISm2JI=
Received: by 10.141.15.5 with SMTP id s5mr66086rvi.79.1268313831046;
        Thu, 11 Mar 2010 05:23:51 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 23sm8799318pzk.6.2010.03.11.05.23.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:46 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141975>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/config.c        |    9 ++++++---
 t/t1300-repo-config.sh  |    3 ++-
 t/t1302-repo-version.sh |    2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ecc8f87..3fca3b4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -159,7 +159,8 @@ static int get_value(const char *key_, const char *=
regex_)
 	local =3D config_exclusive_filename;
 	if (!local) {
 		const char *home =3D getenv("HOME");
-		local =3D repo_config =3D git_pathdup("config");
+		if (startup_info->have_repository)
+			local =3D repo_config =3D git_pathdup("config");
 		if (git_config_global() && home)
 			global =3D xstrdup(mkpath("%s/.gitconfig", home));
 		if (git_config_system())
@@ -197,7 +198,8 @@ static int get_value(const char *key_, const char *=
regex_)
 		git_config_from_file(show_config, system_wide, NULL);
 	if (do_all && global)
 		git_config_from_file(show_config, global, NULL);
-	git_config_from_file(show_config, local, NULL);
+	if (local)
+		git_config_from_file(show_config, local, NULL);
 	if (!do_all && !seen && global)
 		git_config_from_file(show_config, global, NULL);
 	if (!do_all && !seen && system_wide)
@@ -215,7 +217,8 @@ static int get_value(const char *key_, const char *=
regex_)
 		ret =3D (seen =3D=3D 1) ? 0 : seen > 1 ? 2 : 1;
=20
 free_strings:
-	free(repo_config);
+	if (repo_config)
+		free(repo_config);
 	free(global);
 	return ret;
 }
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index cfb70e2..b040f72 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -833,7 +833,8 @@ test_expect_success 'skip .git/config if there is n=
o repository' '
 		cd b &&
 		echo "[core]" > .git/config &&
 		echo "wrong =3D true" >> .git/config &&
-		test -z "$(git var -l | grep core.wrong)"
+		test -z "$(git var -l | grep core.wrong)" &&
+		test -z "$(git config --bool core.wrong)"
 	)
 '
=20
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 8d305b4..74bf51f 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -29,7 +29,7 @@ test_expect_success 'gitdir selection on normal repos=
' '
 # Make sure it would stop at test2, not trash
 test_expect_success 'gitdir selection on unsupported repo' '
 	(cd test2 &&
-	test "$(git config core.repositoryformatversion)" =3D 99)'
+	test "$(git config --file=3D.git/config core.repositoryformatversion)=
" =3D 99)'
=20
 test_expect_success 'gitdir not required mode' '
 	(git apply --stat test.patch &&
--=20
1.7.0.1.384.g6abcaa
