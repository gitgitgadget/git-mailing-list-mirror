From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 21/26] diff: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:12 +0700
Message-ID: <1266336317-607-22-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:16:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ6D-0006OQ-H2
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184Ab0BPQQ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:16:26 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:52307 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab0BPQQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:16:25 -0500
Received: by yxe38 with SMTP id 38so4325805yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=VSJsIin4C6xLd/jQ+m9mEAr9rZGHg4nRfg4NXdxmh0Q=;
        b=Qz1INpN3izd5yks4q3dB6/Am0IZiDYwWuuWOKtFY2htnb8Bh1s0OZlMh/Pxeq/t2P3
         fZGDBXzIBnQN/3Pf6TjULFYxS+OEOuAqKnka8YoFvgdU7FMKBtcRiQ8vfNIAF21wQLAO
         ZjdNJWFXB6d8lqNLt3y+5RXrTWxpa35bwDXrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Rlz9ZT8MFR1zmLtQF45/g/CGfktQsEk6xlE0c84lyEmdpNcM8QzAqkWnzrTjwuqrHD
         1lqCFPLwNOpSxdIXImq+AkdWMLcbn+WJ/aJjgC4x5aXgfB/a/P7msdypcUZeuiOo/jes
         xWfcyg+ojRkZ428nmxcUnOwjwAYMKUpJluoFw=
Received: by 10.150.214.4 with SMTP id m4mr8734385ybg.271.1266336613873;
        Tue, 16 Feb 2010 08:10:13 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 6sm2835320ywc.23.2010.02.16.08.10.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:10:13 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:07:31 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140123>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-diff.c |    6 ++----
 git.c          |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index ffcdd05..e4bd855 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -252,7 +252,6 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	int ents =3D 0, blobs =3D 0, paths =3D 0;
 	const char *path =3D NULL;
 	struct blobinfo blob[2];
-	int nongit;
 	int result =3D 0;
=20
 	/*
@@ -278,7 +277,6 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	 * Other cases are errors.
 	 */
=20
-	prefix =3D setup_git_directory_gently(&nongit);
 	git_config(git_diff_ui_config, NULL);
=20
 	if (diff_use_color_default =3D=3D -1)
@@ -287,7 +285,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	init_revisions(&rev, prefix);
=20
 	/* If this is a no-index diff, just run it and exit there. */
-	diff_no_index(&rev, argc, argv, nongit, prefix);
+	diff_no_index(&rev, argc, argv, !startup_info->have_repository, prefi=
x);
=20
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
@@ -296,7 +294,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
=20
-	if (nongit)
+	if (!startup_info->have_repository)
 		die("Not a git repository");
 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
diff --git a/git.c b/git.c
index 9a85619..0a0588b 100644
--- a/git.c
+++ b/git.c
@@ -328,7 +328,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
-		{ "diff", cmd_diff },
+		{ "diff", cmd_diff, RUN_SETUP_GENTLY },
 		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
--=20
1.7.0.195.g637a2
