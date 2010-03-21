From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/19] config: do not read .git/config if there is no repository
Date: Sun, 21 Mar 2010 17:30:40 +0700
Message-ID: <1269167446-7799-14-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIVa-0003b1-O1
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab0CUKfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:35:47 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:59165 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab0CUKfq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:35:46 -0400
Received: by mail-yx0-f182.google.com with SMTP id 12so1312096yxe.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UtPgfTDBm+bx5J9suqjPnAsNdDG/j/pDqOlEC9cMk+8=;
        b=eEYCHzZh1kazrr6CjbBu3d8uHoyA0Z4PiPdMba0vGvId/cAIU5+mweGsUBiI6L3njZ
         6lmUxrG5kCv4UbgFwb8VQI/4DFt8AYHd9Fw0nGG+tk8Wmw1zFofeP947wevk7xgSlDzz
         ZG9XJnL9ibVts7UNJCbcTrhJgwD3QEL77zq8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=St+rcz/q2OaOvmL3nYKfO7tOjXcEYfVLOE4qIGyt5yWlkdknN5SXABq7rCV1cDpqAF
         nPS4GolPaeUk0kdOQBbiuf5Rx5tVSR1f+AKpaIFezfK1d4WH6+3TayIXe0c1MSMqTL69
         NA4LmoLUDrmvFQEfbmP++N1YAT4Z29J9xopI4=
Received: by 10.150.55.16 with SMTP id d16mr5409654yba.55.1269167746146;
        Sun, 21 Mar 2010 03:35:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 20sm1550445iwn.9.2010.03.21.03.35.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:35:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:32:05 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142808>


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
1.7.0.2.425.gb99f1
