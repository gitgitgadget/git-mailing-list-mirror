From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/18] grep: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:55:55 +0700
Message-ID: <1267937767-12504-7-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8b0-0000K9-NZ
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab0CGE7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 23:59:51 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab0CGE7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 23:59:50 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3156711pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 20:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uYXJfMntqgcM0W1lIuW0/Y5T9Qkb+OY2j9YjxfA0aV8=;
        b=OHm/UHZLR+10H4tNNvQhS/QG4UxmjoIc2bH1ESbJeatYhvBe/qGC9UKOXJHy6LmCGR
         dSsUTN8/Jr6oAezvNiL5Bvgvz3xL2iqfbyUfSLCO9PHhRWYpY9m2RKiFzCD3q4hyJK5Q
         mZepK++T6FpyZusgZYwfMwBhQqA9UoNrdST60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TvaH1uZpQeyqkIFhVwv9OQ91QxpCPPHuZ2nMxWCMVwshGXoP2DUZ2uxeWR/MymD/6D
         4uaqTNvEGhQFEV4T3tPVhswooYsJZGeiFEsEDLmimVEq5aEjwb3wtdHU5OUslrDvxeRR
         R1qv6W2gfNEvEDcOv9spZaNe44v3Zxay99QBE=
Received: by 10.141.14.8 with SMTP id r8mr1998068rvi.172.1267937989599;
        Sat, 06 Mar 2010 20:59:49 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 22sm3227971pzk.9.2010.03.06.20.59.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 20:59:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:34 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141651>

grep has USE_PAGER set. setup_pager() may read config even
setup_git_dir* is not run yet. This tries to find a repository before
config is read.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c |    9 +++------
 git.c          |    2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 40b9a93..fb82ff8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -765,7 +765,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	const char **paths =3D NULL;
 	int i;
 	int dummy;
-	int nongit =3D 0, use_index =3D 1;
+	int use_index =3D 1;
 	struct option options[] =3D {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
@@ -853,8 +853,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_END()
 	};
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-
 	/*
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
@@ -893,9 +891,8 @@ int cmd_grep(int argc, const char **argv, const cha=
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
1.7.0.195.g637a2
