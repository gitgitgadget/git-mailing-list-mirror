From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 24/26] var: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:15 +0700
Message-ID: <1266336317-607-25-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:10:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ0Z-00015h-9F
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0BPQKg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:10:36 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:35786 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab0BPQKf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:10:35 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4319427yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WoOiYqbJHGtjEU3xcbKTqZXy24R9j8ODqQbWWJHvCoU=;
        b=CtPcJDR1xINJ8lijK0dopUbf1lnicUTmzpglq4dq9/YwmCQyK8IfFscFGMZDATWaJu
         NTrBQlf4IWYXdEH82zQS6OMJAWnD/8pMzosZU8B9ybLN0ANxLETARljf7d1SKMVhyJus
         UCPT1M28ae3FCdL/oiSKAd9vZ93P3HvZXOXaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rO0DeKrg6L2nIN8zBTAKyfcqIHARXQwoPnUex+4FnS1QT8uP9L3LUHaZZBXJi5BrrG
         t27YdECZd4xhtMWtJkKLAMXNxlB8YqFTnXNS84oOjTwQP6uYHXfLwQQ0XarYwEHHxFsI
         u024dsZG+MqWGLMPtTctzsQHhuy8B3FR2Dgz0=
Received: by 10.150.119.35 with SMTP id r35mr9361487ybc.49.1266336632753;
        Tue, 16 Feb 2010 08:10:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 4sm2857612ywd.59.2010.02.16.08.10.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:10:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:07:50 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140114>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-var.c |    2 --
 git.c         |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-var.c b/builtin-var.c
index 2280518..f1e1fe3 100644
--- a/builtin-var.c
+++ b/builtin-var.c
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
index 8d23f75..7f715ba 100644
--- a/git.c
+++ b/git.c
@@ -403,7 +403,7 @@ static void handle_internal_command(int argc, const=
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
