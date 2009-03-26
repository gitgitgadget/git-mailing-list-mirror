From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] init: support --import to add all files and commit right after init
Date: Thu, 26 Mar 2009 20:49:03 +1100
Message-ID: <1238060943-4694-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:51:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmmFQ-00016S-K1
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbZCZJtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 05:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754095AbZCZJtf
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:49:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:49428 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbZCZJte (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:49:34 -0400
Received: by rv-out-0506.google.com with SMTP id f9so549943rvb.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 02:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=IRKbJJj8pH0mRs/QexYiLHvzrAyM+KbDjQcdJ/2PrQ4=;
        b=ZwaPMhRBbLGX5zwn8wguAFnZnHAfkfQjwAXQpqchURFMeCYRt4ZXB4cUXkQtrkg6XB
         YzFLA+q68VtMUoaY3LJ/nWLIj17ArbiBcNsN/rq10r1/TTz5Ejo73QdA3qK00meNde2f
         8GyV9p8YkgL/oy92WvC5pqN2eHUTQlUYB+sIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Ki/T2GQPJIasfl9EkwetzfMhaEhwA1HaeoyyDwDsiV1Qw6W+PMPANDOXjD2G1E+4YQ
         tNH6FDRNXgPSFtjsSvA5jG91axvkISXaN4uO+zxB33WY69aRqaKjYOEAN6eyiARGHKYt
         2uZda9r1r1fnyfnwE4qLL0cJnIq5egtMhvm9Y=
Received: by 10.141.177.2 with SMTP id e2mr354863rvp.266.1238060972996;
        Thu, 26 Mar 2009 02:49:32 -0700 (PDT)
Received: from dektop ([121.91.164.111])
        by mx.google.com with ESMTPS id c20sm19629935rvf.40.2009.03.26.02.49.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Mar 2009 02:49:32 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 26 Mar 2009 20:49:03 +1100
X-Mailer: git-send-email 1.6.1.446.gc7851
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114763>

This is equivalent to "git init;git add .;git commit -q -m blah".
I find myself doing that too many times, hence this shortcut.

In future, --fast-import support would also be nice if the import
directory has a lot of files.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Hopefully I don't make any mistake this time. -m will not take any arg=
ument
 for two reasons:

  - optional argument for short options does not appear anywhere in git=
 AFAIK.
    let's not make parse-opt migration more difficult with -mfoo or -m=3D=
foo
  - you want it short, so make it short :) if you want your own message=
, you
    probably won't mind typing a few more: --import=3Dblah

 Documentation/git-init.txt |   17 ++++++++++++++++-
 builtin-init-db.c          |   44 ++++++++++++++++++++++++++++++++++++=
++++----
 t/t0001-init.sh            |   44 ++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 71749c0..52bc34a 100644
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
+           [--shared[=3D<permissions>]] [-m | --import[=3D<message>]]
=20
=20
 OPTIONS
@@ -68,6 +69,20 @@ By default, the configuration flag receive.denyNonFa=
stForwards is enabled
 in shared repositories, so that you cannot force a non fast-forwarding=
 push
 into it.
=20
+-m::
+--import[=3D<message>]::
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
+If `-m` is used or no message is given to `--import`, "Initial commit"=
 will be used.
+This option does not work with `--bare` nor already initialized reposi=
tory.
+
 --
=20
=20
diff --git a/builtin-init-db.c b/builtin-init-db.c
index ee3911f..c787909 100644
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
[--shared[=3D<permissions>]] [-m|--import[=3D<message>]]";
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
@@ -392,12 +416,19 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 			init_shared_repository =3D PERM_GROUP;
 		else if (!prefixcmp(arg, "--shared=3D"))
 			init_shared_repository =3D git_config_perm("arg", arg+9);
+		else if (!strcmp(arg, "--import") || !strcmp(arg, "-m"))
+			import_message =3D "Initial commit";
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
@@ -440,5 +471,10 @@ int cmd_init_db(int argc, const char **argv, const=
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
index 5ac0a27..b8e8bfc 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -199,4 +199,48 @@ test_expect_success 'init honors global core.share=
dRepository' '
 	x`git config -f shared-honor-global/.git/config core.sharedRepository=
`
 '
=20
+test_expect_success 'init --import does not work with --bare' '
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		mkdir init-import-bare.git &&
+		cd init-import-bare.git &&
+		! git init --bare --import
+	)
+
+'
+
+test_expect_success 'init --import no message' '
+	(
+		test_tick
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		mkdir init-import-nomsg &&
+		cd init-import-nomsg &&
+		touch foo bar &&
+		git init --import &&
+		test "$(git rev-parse HEAD)" =3D 4ff955458fd61a7b5d798b81e28c9249e8e=
bb5df
+	)
+'
+
+test_expect_success 'init --import=3Dmsg' '
+	(
+		test_tick
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		mkdir init-import &&
+		cd init-import &&
+		touch foo bar &&
+		git init --import=3Dtest &&
+		test "$(git rev-parse HEAD)" =3D 758aa5a579e42200a6fd4e4964c7e1dc187=
5d67d
+	)
+'
+
+test_expect_success 'init --import on already init(ed) should fail' '
+	(
+		test_tick
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		cd init-import &&
+		! git init --import=3Dtestagain &&
+		test "$(git rev-parse HEAD)" =3D 758aa5a579e42200a6fd4e4964c7e1dc187=
5d67d
+	)
+'
+
 test_done
--=20
1.6.1.446.gc7851
