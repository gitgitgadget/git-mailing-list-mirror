From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Wed,  5 Mar 2008 20:18:04 +0100
Message-ID: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 20:19:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWz93-0007Lf-FR
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 20:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbYCETSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 14:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755201AbYCETSh
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 14:18:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:14764 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356AbYCETSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 14:18:35 -0500
Received: by nf-out-0910.google.com with SMTP id g13so987306nfb.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 11:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=QDgNZH1uLsTxj0ZBwqyBEZsmwy+sIZL8t5JaHWj20/s=;
        b=ItElXZu0e4ubAL8wuJA8Vamb2L69RAJI4Fb6ml7B7/lyJn0uoNH9u3dHB//3ahwwNSNTsTsFlVKwxBbWY0ms2MThFI1mis8OkniwZPkT7jMtMUBm2+sXg5K1Rp+iR5FbH/2qVn2WK9YlIJGgVQadLkC7BptGhB7R5RDTA3c5N/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=xiV5UDA+8nhdGbKTqxK+w+GfpWRQh552JxMJMDxqxV4JazjmihfqOzrlS+i88gUCB+4TlMUf9jdFmViTQVETy7T8+ket8UDcsniV1pMBVLlUAa/P4+0lPb1pxqoEngrpaDBQZazA58H+vY+4NuNFkOW2QHhSWgu3+Udfz/7gJn8=
Received: by 10.82.149.8 with SMTP id w8mr9310760bud.29.1204744713365;
        Wed, 05 Mar 2008 11:18:33 -0800 (PST)
Received: from localhost ( [91.13.114.24])
        by mx.google.com with ESMTPS id j12sm2225260fkf.6.2008.03.05.11.18.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 11:18:32 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.447.gc95b3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76252>

Useful when you want a different email/name for each repository

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt |    5 +++++
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 ident.c                  |    6 +++---
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4027726..d7e5b6d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -914,6 +914,11 @@ url.<base>.insteadOf::
 	never-before-seen repository on the site.  When more than one
 	insteadOf strings match a given URL, the longest match is used.
=20
+user.default::
+	If false the defaults values for user.email and user.name are not
+	used. Useful when you want a different email/name for each
+	repository, normally set in the global config file.
+
 user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the 'GIT_AUTHOR_EMAIL', 'GIT_COMMITTER_EMAIL', a=
nd
diff --git a/cache.h b/cache.h
index e230302..70f08d0 100644
--- a/cache.h
+++ b/cache.h
@@ -703,6 +703,7 @@ extern int config_error_nonbool(const char *);
 #define MAX_GITNAME (1000)
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
+extern int default_ident;
=20
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
diff --git a/config.c b/config.c
index 0624494..ea1fa71 100644
--- a/config.c
+++ b/config.c
@@ -445,6 +445,11 @@ int git_default_config(const char *var, const char=
 *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "user.default")) {
+		default_ident =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "i18n.commitencoding"))
 		return git_config_string(&git_commit_encoding, var, value);
=20
diff --git a/environment.c b/environment.c
index 6739a3f..8e252e2 100644
--- a/environment.c
+++ b/environment.c
@@ -11,6 +11,7 @@
=20
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
+int default_ident =3D 1;
 int trust_executable_bit =3D 1;
 int quote_path_fully =3D 1;
 int has_symlinks =3D 1;
diff --git a/ident.c b/ident.c
index b839dcf..0f62a94 100644
--- a/ident.c
+++ b/ident.c
@@ -75,7 +75,7 @@ static void setup_ident(void)
 	struct passwd *pw =3D NULL;
=20
 	/* Get the name ("gecos") */
-	if (!git_default_name[0]) {
+	if (!git_default_name[0] && default_ident) {
 		pw =3D getpwuid(getuid());
 		if (!pw)
 			die("You don't exist. Go away!");
@@ -88,7 +88,7 @@ static void setup_ident(void)
 		if (email && email[0])
 			strlcpy(git_default_email, email,
 				sizeof(git_default_email));
-		else {
+		else if (default_ident) {
 			if (!pw)
 				pw =3D getpwuid(getuid());
 			if (!pw)
@@ -171,7 +171,7 @@ static const char au_env[] =3D "GIT_AUTHOR_NAME";
 static const char co_env[] =3D "GIT_COMMITTER_NAME";
 static const char *env_hint =3D
 "\n"
-"*** Your name cannot be determined from your system services (gecos).=
\n"
+"*** Your name cannot be determined.\n"
 "\n"
 "Run\n"
 "\n"
--=20
1.5.4.3.447.gc95b3.dirty

