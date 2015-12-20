From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] git.c: make it clear save_env() is for alias handling only
Date: Sun, 20 Dec 2015 14:50:17 +0700
Message-ID: <1450597819-26278-2-git-send-email-pclouds@gmail.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	asottile@umich.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 08:50:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAYlV-000236-PJ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 08:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbbLTHun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2015 02:50:43 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34631 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbbLTHul (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 02:50:41 -0500
Received: by mail-pf0-f182.google.com with SMTP id u7so25243698pfb.1
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 23:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IXlsllF9DFsRFP1vSss5jOV8KC6RxqRRUFeBx8oR2sI=;
        b=UUHR8V1zHyF2CZgc34DThAouuRTelz/rbVlykihanc/LcGCZs2Q3HU5GR9oValVNh7
         xf80zf9O8CCNMwCPHqL5ptUNxfoN1jGedRowxq0dKzE4Ua4+5LDRYpwLep8NHwabn+Mv
         bsk1oGTWUT4d7gUKhd94aHceJYsqK9h0VhVu+eDSgxNYgufAKP3UmGmj1Ih/Fe0AVRbP
         eMvwvbFwn+MyMCBxQp1M+aWODVhDk4ebWcMrsTzMVrduaNhgGsJ9ayxhjirhKtNLuFAU
         qtj1zg9+t9om2tc0urKQyeRT6Wk8QOe5ODyE+I0b7ulVy+ey9zcSCKsrMZYLBvQK3utA
         5CKA==
X-Received: by 10.98.74.10 with SMTP id x10mr18118999pfa.163.1450597841297;
        Sat, 19 Dec 2015 23:50:41 -0800 (PST)
Received: from lanh ([171.233.236.127])
        by smtp.gmail.com with ESMTPSA id m1sm27349179pfi.27.2015.12.19.23.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Dec 2015 23:50:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 20 Dec 2015 14:50:40 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1450597819-26278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282764>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 6ed824c..6ce7043 100644
--- a/git.c
+++ b/git.c
@@ -25,14 +25,14 @@ static const char *env_names[] =3D {
 	GIT_PREFIX_ENVIRONMENT
 };
 static char *orig_env[4];
-static int saved_environment;
+static int saved_env_before_alias;
=20
-static void save_env(void)
+static void save_env_before_alias(void)
 {
 	int i;
-	if (saved_environment)
+	if (saved_env_before_alias)
 		return;
-	saved_environment =3D 1;
+	saved_env_before_alias =3D 1;
 	orig_cwd =3D xgetcwd();
 	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
 		orig_env[i] =3D getenv(env_names[i]);
@@ -233,6 +233,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 	char *alias_string;
 	int unused_nongit;
=20
+	save_env_before_alias();
 	subdir =3D setup_git_directory_gently(&unused_nongit);
=20
 	alias_command =3D (*argv)[0];
@@ -530,7 +531,7 @@ static void handle_builtin(int argc, const char **a=
rgv)
=20
 	builtin =3D get_builtin(cmd);
 	if (builtin) {
-		if (saved_environment && (builtin->option & NO_SETUP))
+		if (saved_env_before_alias && (builtin->option & NO_SETUP))
 			restore_env();
 		else
 			exit(run_builtin(builtin, argc, argv));
@@ -590,7 +591,6 @@ static int run_argv(int *argcp, const char ***argv)
 		 */
 		if (done_alias)
 			break;
-		save_env();
 		if (!handle_alias(argcp, argv))
 			break;
 		done_alias =3D 1;
--=20
2.3.0.rc1.137.g477eb31
