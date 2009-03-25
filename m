From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] init-db: support --import to add all files and commit right after init
Date: Wed, 25 Mar 2009 13:09:56 +1100
Message-ID: <1237946996-5287-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 03:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmIbU-0003Gx-Nn
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 03:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947AbZCYCKR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 22:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756887AbZCYCKQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 22:10:16 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:57256 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947AbZCYCKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 22:10:14 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3757197wff.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 19:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=M/O1litfe07zf0pZzytYnYt9jZgrHUHFo1Fdx6xccJU=;
        b=gTMOpn9MRHs6nP0XiNGiKYIm0ADz3uHjn8Dsye/xhPIWcx3cmg8ocAPbxVJy+WSC9D
         JjqCv5EcMmvK6Wle5wA4DV5s4axlRQ7U7oKH12tytv/CKn3ngEfYCWgDXlRA/AD23moc
         O4/dN/LQzgsO0eYF5Jiij2W9SgrGRXYLSuRk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=eLXb/yf6u+AGjW0pZlOUOnd98GawHA2jeYzdQ5lG1seXDyWgd+9yr9uv3QugV+X1m7
         iUG2M+VXUCX+YW+Z5+Iy0EsT7Qh4eBtPJIomxgUtbL/7Dc4GsRSjl7Qoy3HbYSAPvWpr
         J1zLAIhfwNZQrpyBcXDF2sEBwKCUGcOgJC0W0=
Received: by 10.142.84.11 with SMTP id h11mr3660174wfb.337.1237947012068;
        Tue, 24 Mar 2009 19:10:12 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id 22sm14586729wfd.46.2009.03.24.19.10.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 19:10:11 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Mar 2009 13:09:56 +1100
X-Mailer: git-send-email 1.6.1.446.gc7851
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114538>

This is equivalent to "git init;git add .;git commit -q -m blah".
I find myself doing that too many times, hence this shortcut.

In future, --fast-import support would also be nice if the import
directory has a lot of files.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I'm not really sure about document format as I failed to install
 xmlto on my machine. Html output looked fine though.

 Documentation/git-init.txt |   16 +++++++++++++-
 builtin-init-db.c          |   49 ++++++++++++++++++++++++++++++++++++=
++++---
 t/t0001-init.sh            |   32 ++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 71749c0..52af645 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -8,7 +8,8 @@ git-init - Create an empty git repository or reinitiali=
ze an existing one
=20
 SYNOPSIS
 --------
-'git init' [-q | --quiet] [--bare] [--template=3D<template_directory>]=
 [--shared[=3D<permissions>]]
+'git init' [-q | --quiet] [--bare] [--template=3D<template_directory>]
+           [--shared[=3D<permissions>]] [-m <message> | --import=3D<me=
ssage>]
=20
=20
 OPTIONS
@@ -68,6 +69,19 @@ By default, the configuration flag receive.denyNonFa=
stForwards is enabled
 in shared repositories, so that you cannot force a non fast-forwarding=
 push
 into it.
=20
+-m <message>::
+--import=3D<message>::
+
+Commit everything to the newly initialized repository. This is equival=
ent to:
+
+----------------
+$ git init
+$ git add .
+$ git commit -q -m <message>
+----------------
+
+This option does not work with `--bare` nor already initialized reposi=
tory.
+
 --
=20
=20
diff --git a/builtin-init-db.c b/builtin-init-db.c
index ee3911f..5bf563a 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "run-command.h"
=20
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -19,6 +20,7 @@
=20
 static int init_is_bare_repository =3D 0;
 static int init_shared_repository =3D -1;
+static int reinit;
=20
 static void safe_create_dir(const char *dir, int share)
 {
@@ -279,7 +281,7 @@ int init_db(const char *template_dir, unsigned int =
flags)
 {
 	const char *sha1_dir;
 	char *path;
-	int len, reinit;
+	int len;
=20
 	safe_create_dir(get_git_dir(), 0);
=20
@@ -363,8 +365,29 @@ static int guess_repository_type(const char *git_d=
ir)
 	return 1;
 }
=20
+static int import_files(const char *import_message)
+{
+	const char *args[6];
+	int i =3D 0;
+	int ret;
+
+	args[i++] =3D "add";
+	args[i++] =3D ".";
+	args[i] =3D NULL;
+	ret =3D run_command_v_opt(args, RUN_GIT_CMD);
+	if (ret)
+		return ret;
+	i =3D 0;
+	args[i++] =3D "commit";
+	args[i++] =3D "-q";
+	args[i++] =3D "-m";
+	args[i++] =3D import_message;
+	args[i] =3D NULL;
+	return run_command_v_opt(args, RUN_GIT_CMD);
+}
+
 static const char init_db_usage[] =3D
-"git init [-q | --quiet] [--bare] [--template=3D<template-directory>] =
[--shared[=3D<permissions>]]";
+"git init [-q | --quiet] [--bare] [--template=3D<template-directory>] =
[--shared[=3D<permissions>]] [-m <message> | --import=3D<message>]";
=20
 /*
  * If you want to, you can share the DB area with any number of branch=
es.
@@ -377,7 +400,8 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	const char *git_dir;
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
-	int i;
+	const char *import_message =3D NULL;
+	int ret, i;
=20
 	for (i =3D 1; i < argc; i++, argv++) {
 		const char *arg =3D argv[1];
@@ -392,12 +416,24 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 			init_shared_repository =3D PERM_GROUP;
 		else if (!prefixcmp(arg, "--shared=3D"))
 			init_shared_repository =3D git_config_perm("arg", arg+9);
+		else if (!strcmp(arg, "--import") || !strcmp(arg, "-m")) {
+			if (i+1 >=3D argc)
+				die("--import requires an import message");
+			import_message =3D argv[2];
+			i++;
+			argv++;
+		}
+		else if (!prefixcmp(arg, "--import=3D"))
+			import_message =3D arg+9;
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
 			flags |=3D INIT_DB_QUIET;
 		else
 			usage(init_db_usage);
 	}
=20
+	if (import_message && is_bare_repository_cfg =3D=3D 1)
+		die("--import does not work with --bare");
+
 	/*
 	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
 	 * without --bare.  Catch the error early.
@@ -440,5 +476,10 @@ int cmd_init_db(int argc, const char **argv, const=
 char *prefix)
=20
 	set_git_dir(make_absolute_path(git_dir));
=20
-	return init_db(template_dir, flags);
+	ret =3D init_db(template_dir, flags);
+	if (ret || !import_message)
+		return ret;
+	if (reinit)
+		die("--import does not work with already initialized repository");
+	return import_files(import_message);
 }
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5ac0a27..86414f0 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -199,4 +199,36 @@ test_expect_success 'init honors global core.share=
dRepository' '
 	x`git config -f shared-honor-global/.git/config core.sharedRepository=
`
 '
=20
+test_expect_success 'init --import with --bare' '
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		mkdir init-import-bare.git &&
+		cd init-import-bare.git &&
+		! git init --bare --import test
+	)
+
+'
+
+test_expect_success 'init --import' '
+	(
+		test_tick
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		mkdir init-import &&
+		cd init-import &&
+		touch foo bar &&
+		git init --import test &&
+		test "$(git rev-parse HEAD)" =3D 758aa5a579e42200a6fd4e4964c7e1dc187=
5d67d
+	)
+'
+
+test_expect_success 'reinit --import' '
+	(
+		test_tick
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		cd init-import &&
+		! git init --import testagain &&
+		test "$(git rev-parse HEAD)" =3D 758aa5a579e42200a6fd4e4964c7e1dc187=
5d67d
+	)
+'
+
 test_done
--=20
1.6.1.446.gc7851
