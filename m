From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/5] init-db, rev-parse --git-dir: do not append redundant slash
Date: Sun, 14 Feb 2010 22:44:42 +0700
Message-ID: <1266162285-10955-2-git-send-email-pclouds@gmail.com>
References: <1266162285-10955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 16:47:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgghD-0000Ms-2K
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 16:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611Ab0BNPre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 10:47:34 -0500
Received: from mail-px0-f191.google.com ([209.85.216.191]:51327 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab0BNPrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 10:47:33 -0500
Received: by pxi29 with SMTP id 29so537275pxi.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 07:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YoXH87an0L6rzrbNs5B5/Hf/oWmyFewxpexG+9acI+U=;
        b=BOt0T7g50WXA/CaNPmPKW7g5szcHFKDSpfsvjueGOJ8dzY5g5bSALWyla9hlrPijaC
         b62DVvX2cL1oh8378ZCDzyow7bkcOgDYM9oeqkmAa7pqxX6T90XR9dLy97spM1yHO4zC
         0yHRs0TWKEXxcwQyjMButWLtZH1ARqYyOv4ZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=My/2tsW+FtsfMl+Vh2IoeAhBOMYWjJvmAERAMlCfC2QD+aO5nTn4J0lPqsIiwzCHxF
         kKIr+FPHgBz2ox3YgRBHC6t3sp+nUdbckby4cKir/yeLU8G2tM7UXxWi7YM2rmbUi0bg
         v3hDiAl0Z2L5S9DdeHinu1o1vjAbWSCQ/jAoM=
Received: by 10.141.88.15 with SMTP id q15mr2663106rvl.276.1266162452775;
        Sun, 14 Feb 2010 07:47:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.243.56])
        by mx.google.com with ESMTPS id 21sm262050pzk.11.2010.02.14.07.47.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 07:47:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Feb 2010 22:44:51 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266162285-10955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139912>

If git_dir already has the trailing slash, don't put another one
before .git. This only happens when git_dir is '/' or 'C:/'

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-init-db.c   |    9 ++++++---
 builtin-rev-parse.c |    4 +++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index dd84cae..aae7a4d 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -331,11 +331,14 @@ int init_db(const char *template_dir, unsigned in=
t flags)
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
=20
-	if (!(flags & INIT_DB_QUIET))
-		printf("%s%s Git repository in %s/\n",
+	if (!(flags & INIT_DB_QUIET)) {
+		const char *git_dir =3D get_git_dir();
+		int len =3D strlen(git_dir);
+		printf("%s%s Git repository in %s%s\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
 		       shared_repository ? " shared" : "",
-		       get_git_dir());
+		       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
+	}
=20
 	return 0;
 }
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a8c5043..88bad9a 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -637,6 +637,7 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 			if (!strcmp(arg, "--git-dir")) {
 				const char *gitdir =3D getenv(GIT_DIR_ENVIRONMENT);
 				static char cwd[PATH_MAX];
+				int len;
 				if (gitdir) {
 					puts(gitdir);
 					continue;
@@ -647,7 +648,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 				}
 				if (!getcwd(cwd, PATH_MAX))
 					die_errno("unable to get current working directory");
-				printf("%s/.git\n", cwd);
+				len =3D strlen(cwd);
+				printf("%s%s.git\n", cwd, len && cwd[len-1] !=3D '/' ? "/" : "");
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
--=20
1.7.0.195.g637a2
