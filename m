From: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v2] init-db: migrate to parse-options
Date: Sun, 12 Jul 2009 12:24:32 +0200
Message-ID: <1247394272-6944-1-git-send-email-michal.kiedrowicz@gmail.com>
References: <4A598E03.10204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 12 12:25:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPwFT-0001IV-Mq
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 12:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbZGLKY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2009 06:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbZGLKY4
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 06:24:56 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:60929 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbZGLKYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 06:24:55 -0400
Received: by ewy26 with SMTP id 26so1983127ewy.37
        for <git@vger.kernel.org>; Sun, 12 Jul 2009 03:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=baFbvafI4PYEbGe6itfuJ25TMpHDSQjfAAn2zKIe8UM=;
        b=evGp7tcwHmaCMIIyRAx0v4jo6Hik7SuWuUI6kA2qMGwshaCaxrrMXB/Z3+dta8HfQi
         Vw4t556EyHNU79f155lfqUzdLpXX2zXILMw+J5CUFbmR6jiaezwK5E9EnIOVej7X82uS
         dWRiH8mCJROJsyIvit1OHogl6huFPm4+M3Mrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=B4WjHAacvKo/b9hJcggBfuB0A04IrTRSR9aF42M6nnm0ActTw+cdBntOnNn98RNMWv
         AaiIpSm6Xa/s13Z426aCvAQTsErE+QbrwKnYR3s2a+g/Hw9ZTbpfzbDK0Ng/xMasW1Iy
         m7ww2412QJTg0yx01e+sdGVFny99bBYRAEm6E=
Received: by 10.210.115.17 with SMTP id n17mr133696ebc.70.1247394294093;
        Sun, 12 Jul 2009 03:24:54 -0700 (PDT)
Received: from localhost (77-253-195-139.adsl.inetia.pl [77.253.195.139])
        by mx.google.com with ESMTPS id 7sm6967275eyb.35.2009.07.12.03.24.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Jul 2009 03:24:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <4A598E03.10204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123139>

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
index 4a56006..d68f61b 100644
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
+			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
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
