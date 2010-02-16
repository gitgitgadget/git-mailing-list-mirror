From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 08/26] config: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:04:59 +0700
Message-ID: <1266336317-607-9-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:10:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPzq-0008Ll-77
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973Ab0BPQIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:08:53 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932954Ab0BPQIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:08:52 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Y2dNgDlZ2yi1e0tlU+lcBn7bVR1U2SrIjVVkL84daDA=;
        b=bYtTb4l+syQPHxSSaL9nMyfRWKCa6zZP9ZkX4fAZGvagiiBkpxbJKwnbQ1LH550Wec
         gqxu7pzhurJwA/iLoPBLQy1xBQFM+i1tIq05g7QtMv7NaQLzti33FR4yUO68XmLAoscK
         DtZ6cpyyVumR86AAhFmE0QTUrqVlSVWiFlX7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rI9F9OMK5T56XKTU6XF4eEnvZK2EzRD3IP2yH1gSoW3avmVkN1oKBAI7nPosaqhccL
         3+SRK15Yt9BsM8c4nyUff2ZtGerXJZKdMPw+A9Us10H90YB77xJ0YIf6Ra96mbPNzq8r
         54LPc568Y0uKXini3BM7n1XjHYmy1RnEJq9GM=
Received: by 10.150.160.20 with SMTP id i20mr5622621ybe.111.1266336531705;
        Tue, 16 Feb 2010 08:08:51 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 4sm2865038ywg.43.2010.02.16.08.08.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:08:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:06:08 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140110>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-config.c        |   12 ++++++------
 git.c                   |    4 ++--
 t/t1302-repo-version.sh |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 4bc46b1..944ec9d 100644
--- a/builtin-config.c
+++ b/builtin-config.c
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
@@ -326,11 +328,9 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
=20
-int cmd_config(int argc, const char **argv, const char *unused_prefix)
+int cmd_config(int argc, const char **argv, const char *prefix)
 {
-	int nongit;
 	char *value;
-	const char *prefix =3D setup_git_directory_gently(&nongit);
=20
 	config_exclusive_filename =3D getenv(CONFIG_ENVIRONMENT);
=20
@@ -409,7 +409,7 @@ int cmd_config(int argc, const char **argv, const c=
har *unused_prefix)
 	}
 	else if (actions =3D=3D ACTION_EDIT) {
 		check_argc(argc, 0, 0);
-		if (!config_exclusive_filename && nongit)
+		if (!config_exclusive_filename && !startup_info->have_repository)
 			die("not in a git directory");
 		git_config(git_default_config, NULL);
 		launch_editor(config_exclusive_filename ?
diff --git a/git.c b/git.c
index 5391292..0022f02 100644
--- a/git.c
+++ b/git.c
@@ -322,7 +322,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-		{ "config", cmd_config },
+		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
@@ -378,7 +378,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
 		{ "replace", cmd_replace, RUN_SETUP },
-		{ "repo-config", cmd_config },
+		{ "repo-config", cmd_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
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
1.7.0.195.g637a2
