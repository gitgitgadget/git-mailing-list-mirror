From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fetch-pack.c: show correct command name that fails
Date: Wed, 18 Sep 2013 20:41:18 +0700
Message-ID: <1379511678-11611-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 15:38:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMHxJ-0004H4-EA
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 15:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab3IRNiD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Sep 2013 09:38:03 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:52793 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab3IRNiB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 09:38:01 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so6954912pbc.23
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=bpI6xQr/jamW4s5V5AkgsJqIOohFCqqXS+4+J+B5CHM=;
        b=neoKEgsDxt/bKVA4RXJEwUkjXPo9pdEZBRusBshxyeuyoYxd/7DFz/yArsVpKXPJJl
         rMWt0Fg+Ziz34Sm7mca2rVvj4a9lFQQgl0evHjDCfnRgcHgS0uNSfr4SDsyx+ZTzWkHU
         HQ/APvimMiO2UoOzRqvm1pZfVcMQVtl2ExWTwcCqWQC/gGn0rxMwVFMqI33BJBcg1HAp
         6OW6MO316U48QJXaPXCooqPdaf913vqqRc0Jst8dLTg2JXrP71Wu/EzhVmeViATcKd2d
         BWwoP7NO5ffVhAMjGrPlh8/DHyIJcG0ZanWmjWg/invEOL3h91FjgCzJsFpP45lUkq1t
         +k9w==
X-Received: by 10.68.254.132 with SMTP id ai4mr21326718pbd.51.1379511481000;
        Wed, 18 Sep 2013 06:38:01 -0700 (PDT)
Received: from lanh ([115.73.221.161])
        by mx.google.com with ESMTPSA id zi1sm2541255pbb.28.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 06:38:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Sep 2013 20:41:20 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234965>

When --shallow-file is added to the command line, it has to be
before the subcommand name, the first argument won't be the command
name any more. Stop assuming that and keep track of the command name
explicitly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fetch-pack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6684348..b259c51 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -688,7 +688,7 @@ static int get_pack(struct fetch_pack_args *args,
 	const char *argv[22];
 	char keep_arg[256];
 	char hdr_arg[256];
-	const char **av;
+	const char **av, *cmd_name;
 	int do_keep =3D args->keep_pack;
 	struct child_process cmd;
 	int ret;
@@ -735,7 +735,7 @@ static int get_pack(struct fetch_pack_args *args,
 	if (do_keep) {
 		if (pack_lockfile)
 			cmd.out =3D -1;
-		*av++ =3D "index-pack";
+		*av++ =3D cmd_name =3D "index-pack";
 		*av++ =3D "--stdin";
 		if (!args->quiet && !args->no_progress)
 			*av++ =3D "-v";
@@ -752,7 +752,7 @@ static int get_pack(struct fetch_pack_args *args,
 			*av++ =3D "--check-self-contained-and-connected";
 	}
 	else {
-		*av++ =3D "unpack-objects";
+		*av++ =3D cmd_name =3D "unpack-objects";
 		if (args->quiet || args->no_progress)
 			*av++ =3D "-q";
 		args->check_self_contained_and_connected =3D 0;
@@ -770,7 +770,7 @@ static int get_pack(struct fetch_pack_args *args,
 	cmd.in =3D demux.out;
 	cmd.git_cmd =3D 1;
 	if (start_command(&cmd))
-		die("fetch-pack: unable to fork off %s", argv[0]);
+		die("fetch-pack: unable to fork off %s", cmd_name);
 	if (do_keep && pack_lockfile) {
 		*pack_lockfile =3D index_pack_lockfile(cmd.out);
 		close(cmd.out);
@@ -782,7 +782,7 @@ static int get_pack(struct fetch_pack_args *args,
 			args->check_self_contained_and_connected &&
 			ret =3D=3D 0;
 	else
-		die("%s failed", argv[0]);
+		die("%s failed", cmd_name);
 	if (use_sideband && finish_async(&demux))
 		die("error in sideband demultiplexer");
 	return 0;
--=20
1.8.2.83.gc99314b
