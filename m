From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] init-db, rev-parse --git-dir: do not append redundant slash
Date: Thu, 11 Feb 2010 21:43:20 +0700
Message-ID: <1265899403-15904-3-git-send-email-pclouds@gmail.com>
References: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 15:46:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaJG-0005xV-9p
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab0BKOqV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:46:21 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:39879 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab0BKOqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:46:20 -0500
Received: by ywh27 with SMTP id 27so1085732ywh.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 06:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KKqwXyyIRMSnt3MRNDas3YqmMSnO7RfFVIUCjQqYAQg=;
        b=IS7o4xZ47Z6Z+jw567UHQYtZHuVIPezC2y2VfxGBFaNuRZH/8gE+83HlMBFeRCS02C
         3IJ3PCnU6dkExqRkLKBVL3ZG4Rj00g9vVNDiSrcmNMEGLFACdGDNN7Se5VKI/TP7X4pE
         ncSa4XEWtvd9sxz9+eKI3qMk390ayOFHqU+Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=d0ptDA5tEIBzT4Z4RUGsLMwUEW4viPtQadA8Hox89HfmvxAcjNuZvoOJ16LCabuXkh
         eq75jjkCezLnSKFpEwpHKmRBnGHimcVGTOS12YmoFeREl6KSkCJLXNXOrvKXDB/1FSgV
         gFmrYJNaCt0xXJsWgxmBb15P3K793yyFCiAX0=
Received: by 10.150.55.6 with SMTP id d6mr295136yba.226.1265899579782;
        Thu, 11 Feb 2010 06:46:19 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.243.56])
        by mx.google.com with ESMTPS id 20sm933740ywh.17.2010.02.11.06.46.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 06:46:18 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Feb 2010 21:43:39 +0700
X-Mailer: git-send-email 1.7.0.rc2.182.g3adef
In-Reply-To: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139594>

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
1.7.0.rc2.182.g3adef
