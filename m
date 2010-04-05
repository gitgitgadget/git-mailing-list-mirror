From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/43] hash-object: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:40:49 +0200
Message-ID: <1270492888-26589-5-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:42:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrFd-0005ZJ-7B
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab0DESlv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:41:51 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab0DESlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:41:47 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SGsBaFB3ub+XUrc4vKhZLX4v4dIK0lmsxV8GSgtYMIg=;
        b=Vh9JZWtN4OTEI6zbMUCcQxdE+XdZaJEjIwK+z+hIG/8aXsGkvopxfKe2SfoeC/csP1
         WA5l3irusaMv9yH7YaLCx7JghMuJpTot3+GNQrsQWxTvndH/pErEZSFDYu2Qd5UUYJjU
         PO4yXCDureQA1y+dGWdlwKCuGANIzD1cyWQSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TtgZESTvxEzjw8J0m8vWQ6R10nobKD79Rv60jM8RIJpF2bSoq71wWAKy82VJ01KGq9
         uIkPtioV6gtLsy/8mfuWUyIZeBv0yRBbFfG2UtykPXs5lGXK7egaj8zIotHXEXQVIMgJ
         w5rviG0R9Nh03kiyAmQnfzfZ6KCxmtHM0LIuc=
Received: by 10.223.143.20 with SMTP id s20mr6135903fau.38.1270492906194;
        Mon, 05 Apr 2010 11:41:46 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id k29sm26904258fkk.45.2010.04.05.11.41.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:41:45 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:41:44 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144007>

hash-object needs to inspect repository's config, so it must try to
find a repository regardless the object will be written in object
store.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c |    9 +++++----
 git.c                 |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 080af1a..1f7fd6a 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -78,7 +78,7 @@ static const struct option hash_object_options[] =3D =
{
 int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int prefix_length =3D -1;
+	int prefix_length;
 	const char *errstr =3D NULL;
=20
 	type =3D blob_type;
@@ -86,9 +86,10 @@ int cmd_hash_object(int argc, const char **argv, con=
st char *prefix)
 	argc =3D parse_options(argc, argv, NULL, hash_object_options,
 			     hash_object_usage, 0);
=20
+	prefix_length =3D prefix ? strlen(prefix) : 0;
 	if (write_object) {
-		prefix =3D setup_git_directory();
-		prefix_length =3D prefix ? strlen(prefix) : 0;
+		if (!startup_info->have_repository)
+			die("No repository found");
 		if (vpath && prefix)
 			vpath =3D prefix_filename(prefix, prefix_length, vpath);
 	}
@@ -121,7 +122,7 @@ int cmd_hash_object(int argc, const char **argv, co=
nst char *prefix)
 	for (i =3D 0 ; i < argc; i++) {
 		const char *arg =3D argv[i];
=20
-		if (0 <=3D prefix_length)
+		if (prefix_length)
 			arg =3D prefix_filename(prefix, prefix_length, arg);
 		hash_object(arg, type, write_object,
 			    no_filters ? NULL : vpath ? vpath : arg);
diff --git a/git.c b/git.c
index 4c99319..2069ef3 100644
--- a/git.c
+++ b/git.c
@@ -327,7 +327,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, USE_PAGER },
-		{ "hash-object", cmd_hash_object },
+		{ "hash-object", cmd_hash_object, RUN_SETUP_GENTLY },
 		{ "help", cmd_help },
 		{ "index-pack", cmd_index_pack },
 		{ "init", cmd_init_db },
--=20
1.7.0.rc1.541.g2da82.dirty
