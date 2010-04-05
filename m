From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/43] grep: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:40:51 +0200
Message-ID: <1270492888-26589-7-git-send-email-pclouds@gmail.com>
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
	id 1NyrFe-0005ZJ-92
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab0DESl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:41:57 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab0DESly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:41:54 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=B8Jk+hjGjRXazTgSCJ/qAVd/R8fBAlBoIeysPjKwJts=;
        b=IqpPvGcGxU4+39r38t72/gVbuesRSfwntCWRihzw+IlWy60XPge3dO8iWliKH72T9q
         FOk1B3LNGRTn8VM8r+oLeIGfp/V6Kjp8sPu5jo6oj7tK2MJU/aQv8bmN+2sChAkE9+Vk
         DKZ003aBwWbDVeTs+2M4pYFJIWymHg44ShHxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZEPBxBJcESLZNpb2DPEp+gCR/UthHBGsTY3C+T/BxDbV8Yfz479umu3iP7EwqtFcbL
         0Pc0asL2C7eR6ygRYEpdm8uCsm92gheW11JZFfkeOhwlVRV8oODi4mpaw+1tDX9FSsPD
         H78ACbZhoN5UcyRL7rj6Eup78vW4U+Glrs3Lk=
Received: by 10.223.143.88 with SMTP id t24mr5972233fau.77.1270492913233;
        Mon, 05 Apr 2010 11:41:53 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id f31sm635851fkf.18.2010.04.05.11.41.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:41:52 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:41:51 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144001>

grep has USE_PAGER set. setup_pager() may read config even
setup_git_dir* is not run yet. This tries to find a repository before
config is read.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c |    9 +++------
 git.c          |    2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9d30ddb..a4ea0c9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -779,7 +779,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	const char **paths =3D NULL;
 	int i;
 	int dummy;
-	int nongit =3D 0, use_index =3D 1;
+	int use_index =3D 1;
 	struct option options[] =3D {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
@@ -867,8 +867,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_END()
 	};
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-
 	/*
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
@@ -913,9 +911,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
=20
-	if (use_index && nongit)
-		/* die the same way as if we did it at the beginning */
-		setup_git_directory();
+	if (use_index && !startup_info->have_repository)
+		die("No git repository found");
=20
 	/*
 	 * skip a -- separator; we know it cannot be
diff --git a/git.c b/git.c
index 29489e6..3904fe2 100644
--- a/git.c
+++ b/git.c
@@ -326,7 +326,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, USE_PAGER },
+		{ "grep", cmd_grep, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "hash-object", cmd_hash_object, RUN_SETUP_GENTLY },
 		{ "help", cmd_help },
 		{ "index-pack", cmd_index_pack },
--=20
1.7.0.rc1.541.g2da82.dirty
