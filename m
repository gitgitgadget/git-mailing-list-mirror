From: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] init-db: migrate to parse-options
Date: Sun, 12 Jul 2009 00:53:13 +0200
Message-ID: <1247352793-25675-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 12 00:53:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPlRl-0003Mz-2g
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 00:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbZGKWx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jul 2009 18:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbZGKWx0
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 18:53:26 -0400
Received: from ey-out-1920.google.com ([74.125.78.150]:11211 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZGKWxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 18:53:25 -0400
Received: by ey-out-1920.google.com with SMTP id 3so308077eyh.36
        for <git@vger.kernel.org>; Sat, 11 Jul 2009 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=OofvvKO1plxyga/Z1u/3EVG18Y30eoxqYwtHxtV7S2U=;
        b=jhc1CBxvOKZCXUXtOhxN/d54Y+fbLBqkHXXfmD6QhjM0giPMNy615SXiWy5HrtASBI
         jvKaqQ+6wSaR26VwWFZF3qLEbCKQInhZlgJhma0B4/07GuAxDHWMzZ7pH7Rk7875Nyny
         QU26Szs6HYmgD76OG2sqozzWd86COSKrDLH9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=JuO1lKdu9AK+qdjG/D44iqT5R/vE73BsyPHu34/vecE+YG7oFMMsXW5Il5hIYWkB1z
         FMFd//RPGWM1mIn15ESl58CopptLNJQCUAmcNMDAi8dFB3JQ5dPqFM5WXVjtcmXgxfKs
         /dSv3FP/pw15+2wDgnaa0sqJ9AAqGTXwltf1M=
Received: by 10.211.168.4 with SMTP id v4mr4247301ebo.29.1247352803928;
        Sat, 11 Jul 2009 15:53:23 -0700 (PDT)
Received: from localhost (87-205-62-248.adsl.inetia.pl [87.205.62.248])
        by mx.google.com with ESMTPS id 10sm2419929eyd.37.2009.07.11.15.53.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Jul 2009 15:53:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123133>

Also add missing --bare to init-db synopsis.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 Documentation/git-init-db.txt |    2 +-
 builtin-init-db.c             |   51 ++++++++++++++++++++++++---------=
--------
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.=
txt
index 1fd0ff2..eba3cb4 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -8,7 +8,7 @@ git-init-db - Creates an empty git repository
=20
 SYNOPSIS
 --------
-'git init-db' [-q | --quiet] [--template=3D<template_directory>] [--sh=
ared[=3D<permissions>]]
+'git init-db' [-q | --quiet] [--bare] [--template=3D<template_director=
y>] [--shared[=3D<permissions>]]
=20
=20
 DESCRIPTION
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4a56006..9b1ce45 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "parse-options.h"
=20
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -370,8 +371,16 @@ static int guess_repository_type(const char *git_d=
ir)
 	return 1;
 }
=20
-static const char init_db_usage[] =3D
-"git init [-q | --quiet] [--bare] [--template=3D<template-directory>] =
[--shared[=3D<permissions>]]";
+static int shared_callback(const struct option *opt, const char *arg, =
int unset)
+{
+	*((int *) opt->value) =3D (arg) ? git_config_perm("arg", arg) : PERM_=
GROUP;
+	return 0;
+}
+
+static const char *const init_db_usage[] =3D {
+	"git init [-q | --quiet] [--bare] [--template=3D<template-directory>]=
 [--shared[=3D<permissions>]]",
+	NULL
+};
=20
 /*
  * If you want to, you can share the DB area with any number of branch=
es.
@@ -384,25 +393,25 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 	const char *git_dir;
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
-	int i;
-
-	for (i =3D 1; i < argc; i++, argv++) {
-		const char *arg =3D argv[1];
-		if (!prefixcmp(arg, "--template=3D"))
-			template_dir =3D arg+11;
-		else if (!strcmp(arg, "--bare")) {
-			static char git_dir[PATH_MAX+1];
-			is_bare_repository_cfg =3D 1;
-			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
-						sizeof(git_dir)), 0);
-		} else if (!strcmp(arg, "--shared"))
-			init_shared_repository =3D PERM_GROUP;
-		else if (!prefixcmp(arg, "--shared=3D"))
-			init_shared_repository =3D git_config_perm("arg", arg+9);
-		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
-			flags |=3D INIT_DB_QUIET;
-		else
-			usage(init_db_usage);
+	const struct option init_db_options[] =3D {
+		OPT_STRING(0, "template", &template_dir, "template-directory",
+				"provide the directory from which templates will be used"),
+		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
+				"create a bare repository", 1),
+		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
+			"permissions",
+			"specify that the git repository is to be shared amongst several us=
ers",
+			PARSE_OPT_OPTARG, shared_callback, 0},
+		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
+		OPT_END()
+	};
+
+	parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
+
+	if(is_bare_repository_cfg =3D=3D 1) {
+		static char git_dir[PATH_MAX+1];
+		setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
+					sizeof(git_dir)), 0);
 	}
=20
 	if (init_shared_repository !=3D -1)
--=20
1.6.3.3
