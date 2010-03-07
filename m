From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/18] var: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:56:06 +0700
Message-ID: <1267937767-12504-18-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8bf-0003VZ-M0
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab0CGFAl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:00:41 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab0CGFAh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:00:37 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3156711pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=IFbiCfOpWQYLhiX9B3wl3Etz4WWCJ4sVZW6V+7v1VMA=;
        b=cqaQaJt7Pn5nq6NcL8iORtARAVLrFQ1ZAqfoLHIYUXvi4E8Vy0h+UZZCYxyR3xbVOM
         02D1HT6/CeKZThWn94dtKidu9PDIgEgxowTv5JqqEPTb05NSWPYf5I0V1AbOXH9fchcw
         acHf4/n/0wtyThhGjdC1KnEYrRqtVXgJ338m4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mD19gfQ/KMwEEOdkeAJWSIvCqP/g3b4XZuTT5anVRa4DIRZb49tSxEnB7XgkZP/2IB
         Psrh2Kum0fRl4dByNie5ymW4xcwiHGjSo+xWdTDhGQqR4ZThCs9vEAaCjHuRAEna7Ft2
         0qhrtxrNuXE5JVEiFNWvoE/hwilEXrGftkXak=
Received: by 10.141.100.21 with SMTP id c21mr2022955rvm.41.1267938037069;
        Sat, 06 Mar 2010 21:00:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 23sm3231515pzk.6.2010.03.06.21.00.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 21:00:36 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:57:21 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141660>

"git var" needs to read repository config, so setup gitdir first.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/var.c |    2 --
 git.c         |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index 70fdb4d..26324ef 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -75,12 +75,10 @@ static int show_config(const char *var, const char =
*value, void *cb)
 int cmd_var(int argc, const char **argv, const char *prefix)
 {
 	const char *val;
-	int nongit;
 	if (argc !=3D 2) {
 		usage(var_usage);
 	}
=20
-	setup_git_directory_gently(&nongit);
 	val =3D NULL;
=20
 	if (strcmp(argv[1], "-l") =3D=3D 0) {
diff --git a/git.c b/git.c
index e0c8904..3292627 100644
--- a/git.c
+++ b/git.c
@@ -391,7 +391,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
-		{ "var", cmd_var },
+		{ "var", cmd_var, RUN_SETUP_GENTLY },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
--=20
1.7.0.195.g637a2
