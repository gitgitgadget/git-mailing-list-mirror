From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 25/26] merge-file: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:16 +0700
Message-ID: <1266336317-607-26-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:17:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ6p-0006sl-Iy
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194Ab0BPQRF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:17:05 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:38433 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888Ab0BPQRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:17:01 -0500
Received: by ywh35 with SMTP id 35so4826857ywh.21
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8flORJSlKyptdh8KzkYlo0JizczoGBfNhis1Y0LlONA=;
        b=eiX1yXh2jgMr54R9CfQRhUXssfO8oFUThml07x1y6lXtJsvTlQwgsCVztXoTf80AP1
         kUyiAnnMqmQ7KU2TcHoEAo/Q7lPIOIn+L3eGYsESJsU0lZceYcYQ/PRWE8SZ2hvdtfSR
         7rlZCog6y0PH/muaFwQsGT51/mrwVb8VfenOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cWJyC1WIEbCI9bdbeIqMtXEHU9KJZAyicfjNjVhoypmESotiGUQiGzPG9uYs1022zb
         jVj5r7Iebq72eSJk1xKt4jBU6n1o8KZB+3jxOCeBU8YSpSQDuprdmxqUkpcqwZ349LdH
         Tag0xzkCY7M1TGWBSl8ovV2xZ9eZw7qFfUsog=
Received: by 10.151.87.1 with SMTP id p1mr3706039ybl.94.1266336639095;
        Tue, 16 Feb 2010 08:10:39 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 20sm869063ywh.17.2010.02.16.08.10.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:10:37 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:07:56 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140124>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-merge-file.c |    4 +---
 git.c                |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 1e70073..474c6c2 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -30,7 +30,6 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 	int level =3D XDL_MERGE_ZEALOUS_ALNUM;
 	int style =3D 0, quiet =3D 0;
 	int favor =3D 0;
-	int nongit;
=20
 	struct option options[] =3D {
 		OPT_BOOLEAN('p', "stdout", &to_stdout, "send results to standard out=
put"),
@@ -45,8 +44,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 		OPT_END(),
 	};
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-	if (!nongit) {
+	if (startup_info->have_repository) {
 		/* Read the configuration file */
 		git_config(git_xmerge_config, NULL);
 		if (0 <=3D git_xmerge_style)
diff --git a/git.c b/git.c
index 7f715ba..3bbcca2 100644
--- a/git.c
+++ b/git.c
@@ -356,7 +356,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
-		{ "merge-file", cmd_merge_file },
+		{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 		{ "merge-index", cmd_merge_index, RUN_SETUP },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE=
 },
--=20
1.7.0.195.g637a2
