From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 23/26] ls-remote: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:14 +0700
Message-ID: <1266336317-607-24-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:16:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ5w-0006At-26
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180Ab0BPQQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:16:11 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:58306 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab0BPQQK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:16:10 -0500
Received: by ywh35 with SMTP id 35so4825724ywh.21
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CcRRarax8W6IcSGXfulEsJs3lXV6WWZrguD2DgK1O4I=;
        b=hJCgtmtYLl4TV44is2RWpqJDbijUUEnAUfhLQMD0wBZZup1pXhAukIGA83pSD8ZFeq
         mz03GIw61acWPdunFjHYKfbdzajBXFi8tqYBhOnRTKqtmGe83bADuse8eDNU18UloMNr
         Y7bzdyawe3Qi4HNK+G/NpgDD34et59IrDs7rw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=My+8yNpqcQBLWq0J+BbDHr/iBPE6V4Qf2SCSPhOAZkJA9+GU1a+bw0K/vkvM89sMGd
         7QnsGMDp6JIRMeMCI/stwmwsLkKhUtG+cCFk6Rh6QxTqVAX/k7k5F1B06R74Cinjck+m
         BcywyM+CWBdazHoz2thEEMyna5WnuWVF/bHcQ=
Received: by 10.91.79.14 with SMTP id g14mr940659agl.37.1266336626537;
        Tue, 16 Feb 2010 08:10:26 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 7sm2848910ywc.51.2010.02.16.08.10.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:10:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:07:44 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140121>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-ls-remote.c |    3 ---
 git.c               |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 70f5622..998f2c8 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -31,7 +31,6 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 {
 	int i;
 	const char *dest =3D NULL;
-	int nongit;
 	unsigned flags =3D 0;
 	const char *uploadpack =3D NULL;
 	const char **pattern =3D NULL;
@@ -40,8 +39,6 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 	struct transport *transport;
 	const struct ref *ref;
=20
-	setup_git_directory_gently(&nongit);
-
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
=20
diff --git a/git.c b/git.c
index c922400..8d23f75 100644
--- a/git.c
+++ b/git.c
@@ -351,7 +351,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-		{ "ls-remote", cmd_ls_remote },
+		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
@@ -371,7 +371,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 		{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
 		{ "patch-id", cmd_patch_id },
-		{ "peek-remote", cmd_ls_remote },
+		{ "peek-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
--=20
1.7.0.195.g637a2
