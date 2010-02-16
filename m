From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 09/26] hash-object: move gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:00 +0700
Message-ID: <1266336317-607-10-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:10:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPzr-0008Ll-DS
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025Ab0BPQJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:09:04 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933022Ab0BPQI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:08:58 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UjqLU74EdspW/z5hCSsmYntSuApNDBQ1j02mKI2zzRc=;
        b=N4hK0oyQWxXRsyuRqDA1FQOCRN2SuZ+CbVlX2yMUXAIuqZALaNyP44/yNig6M8j+cg
         MnsLQ0NeDNqWV9ATzo8xOW5rZPgcMtSXvVDKCEc03gh4YVFhYYKJvJXG5JLFpdQz05gt
         Esynsa3jTogfRl/84WmV+Zm65m823L1LmgIXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EfKLj7YDVS7Y7EPm93x38DAWn12MOBPs5HSF2dyA7aikofzwt/bwhGuLgl50f1f08T
         VgMhuuAKbI7j7OcbnE2zSluXpKx2OEOO+kyIQgMFSWbOuk8j0HMgHOvJy7QVItCHhuYM
         BTiTOZ+u7kEIL98n2Nstg4vi37GjSqDT13Kr0=
Received: by 10.101.117.19 with SMTP id u19mr4684008anm.27.1266336538366;
        Tue, 16 Feb 2010 08:08:58 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 7sm2849948ywc.6.2010.02.16.08.08.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:08:57 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:06:15 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140112>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-hash-object.c |    9 +++++----
 git.c                 |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin-hash-object.c b/builtin-hash-object.c
index 6a5f5b5..57330b8 100644
--- a/builtin-hash-object.c
+++ b/builtin-hash-object.c
@@ -76,7 +76,7 @@ static const struct option hash_object_options[] =3D =
{
 int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int prefix_length =3D -1;
+	int prefix_length;
 	const char *errstr =3D NULL;
=20
 	type =3D blob_type;
@@ -84,9 +84,10 @@ int cmd_hash_object(int argc, const char **argv, con=
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
index 0022f02..a165b43 100644
--- a/git.c
+++ b/git.c
@@ -340,7 +340,7 @@ static void handle_internal_command(int argc, const=
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
1.7.0.195.g637a2
