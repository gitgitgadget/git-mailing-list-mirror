From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 20/21] Convert more init_pathspec() to parse_pathspec()
Date: Fri, 11 Jan 2013 18:21:14 +0700
Message-ID: <1357903275-16804-21-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:23:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttchq-00089S-QD
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab3AKLXG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:23:06 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:63519 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab3AKLXE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:23:04 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so908073pbc.23
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=6MhQ5xNwglfipQyyOFqWCUAGrJuVdo0t1AQMeaObx/M=;
        b=xVCCVxUUJeHSJoT4GX7OArp/6W9XqrnUMDp/cVlMq5vqXNzRf2ae4UJke7QgKr7AMv
         EYWqfJjEvz8Ftlm5ZJvVf9zuqDDNgq9olJ39UOmmLsedNafsK2hYiOV9XTJsvSTFEYHU
         Q+4/KwqX/biCaAanVewMe91De5ObSK2SrkRjH4qqd47BePTEQszVoAmX86zF1/mOvlqE
         NyYK2t9IhlOEWFNsKmhw+bQhQqfLiQuB+G6OldVAGpg+TtHqhhfcubM8FOtZpp+PkFfc
         QvEtqKHiGEbRI4Ll4okDUmx9OJfYuOY8I0sZqMcK/JnL/YIhQSKHB5swWCSxjkbn4LzA
         glTg==
X-Received: by 10.68.229.169 with SMTP id sr9mr19246559pbc.120.1357903384453;
        Fri, 11 Jan 2013 03:23:04 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id rs7sm2644923pbc.2.2013.01.11.03.23.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:23:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:23:19 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213213>

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
