From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/21] Convert more init_pathspec() to parse_pathspec()
Date: Sun,  6 Jan 2013 13:21:08 +0700
Message-ID: <1357453268-12543-22-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:23:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjdu-0000zb-57
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab3AFGXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:23:11 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:61678 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab3AFGXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:23:09 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so10102236pad.21
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=6MhQ5xNwglfipQyyOFqWCUAGrJuVdo0t1AQMeaObx/M=;
        b=QesOwA4e2Ho1GbSEDhWDHdtQMTsZQTSG8t2dZmZteidimUhBo5o7RlqmiNW5FXZjpX
         eRrYaZ3zO9Gi5dc+1Rne7FeJNd/LkmEjgD4/mebZ05vm2G9KLlkKxZjIr3I4/dsP/1SW
         1z6OWOjnmb5XldAQwylEDtWJxaVRO6ItA9qse6I1O9vzDeRlj11138BeCoDvc2nbFb3S
         bN2WHa3GI75vTbO2yMTXRIPyClZihE3V4H2DpiOSDQnAc2PLDUuSr8hZTyMiIvRf2Biz
         TceUSsOUkBeVn2WYkW0Fvj3MORLNHoCHVJDhkSxzexe/I9kFrVmHUoFjWC8OTL+WmEKR
         qpCQ==
X-Received: by 10.68.217.200 with SMTP id pa8mr6014486pbc.42.1357453388942;
        Sat, 05 Jan 2013 22:23:08 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id rs7sm35300862pbc.2.2013.01.05.22.23.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:23:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:23:18 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212775>

init_pathspec() was introduced to work with the result from
get_pathspec(). init_pathspec() will be removed eventually after
parse_pathspec() takes over, so that there is only place that
initializes struct pathspec.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c          |  2 +-
 builtin/log.c      |  2 +-
 builtin/ls-files.c | 10 ++++------
 diff-lib.c         |  2 +-
 merge-recursive.c  |  2 +-
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/archive.c b/archive.c
index 530badb..3caa31f 100644
--- a/archive.c
+++ b/archive.c
@@ -218,7 +218,7 @@ static int path_exists(struct tree *tree, const cha=
r *path)
 	struct pathspec pathspec;
 	int ret;
=20
-	init_pathspec(&pathspec, paths);
+	parse_pathspec(&pathspec, 0, 0, "", paths);
 	ret =3D read_tree_recursive(tree, "", 0, 0, &pathspec, reject_entry, =
NULL);
 	free_pathspec(&pathspec);
 	return ret !=3D 0;
diff --git a/builtin/log.c b/builtin/log.c
index e7b7db1..495ae77 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -455,7 +455,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 	init_grep_defaults();
 	git_config(git_log_config, NULL);
=20
-	init_pathspec(&match_all, NULL);
+	memset(&match_all, 0, sizeof(match_all));
 	init_revisions(&rev, prefix);
 	rev.diff =3D 1;
 	rev.always_show_header =3D 1;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7bb637b..79949de 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -318,13 +318,11 @@ void overlay_tree_on_cache(const char *tree_name,=
 const char *prefix)
 	}
=20
 	if (prefix) {
-		static const char *(matchbuf[2]);
-		matchbuf[0] =3D prefix;
-		matchbuf[1] =3D NULL;
-		init_pathspec(&pathspec, matchbuf);
-		pathspec.items[0].nowildcard_len =3D pathspec.items[0].len;
+		static const char *(matchbuf[1]);
+		matchbuf[0] =3D NULL;
+		parse_pathspec(&pathspec, 0, 0, prefix, matchbuf);
 	} else
-		init_pathspec(&pathspec, NULL);
+		memset(&pathspec, 0, sizeof(pathspec));
 	if (read_tree(tree, 1, &pathspec))
 		die("unable to read tree entries %s", tree_name);
=20
diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..9c07f6a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -500,7 +500,7 @@ int do_diff_cache(const unsigned char *tree_sha1, s=
truct diff_options *opt)
 	struct rev_info revs;
=20
 	init_revisions(&revs, NULL);
-	init_pathspec(&revs.prune_data, opt->pathspec.raw);
+	revs.prune_data =3D opt->pathspec;
 	revs.diffopt =3D *opt;
=20
 	if (diff_cache(&revs, tree_sha1, NULL, 1))
diff --git a/merge-recursive.c b/merge-recursive.c
index d882060..cd95bdb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -297,7 +297,7 @@ static int get_files_dirs(struct merge_options *o, =
struct tree *tree)
 {
 	int n;
 	struct pathspec match_all;
-	init_pathspec(&match_all, NULL);
+	memset(&match_all, 0, sizeof(match_all));
 	if (read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, =
o))
 		return 0;
 	n =3D o->current_file_set.nr + o->current_directory_set.nr;
--=20
1.8.0.rc2.23.g1fb49df
