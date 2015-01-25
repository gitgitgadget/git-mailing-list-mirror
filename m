From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/21] list-files: add -t back
Date: Sun, 25 Jan 2015 19:37:49 +0700
Message-ID: <1422189476-7518-15-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:28:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMIv-0003Iq-EX
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbbAYM2e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:28:34 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:42661 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbAYM2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:28:32 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so6868359pdj.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YNkFY+fAhilUvZyRuh25EhiRfiU6UoYxeoPqEhoJJjQ=;
        b=VtiIVI2cN9Jy9jMakknNXxsb7kw63DaR3Wt2TOqXhdHqpmjey2h5qTJyklrvuTEi/I
         j5SSGVltg1gv3dO1NNbPq9VUTgvhqJxUXVRtCuMSjBjH+tFAyGpg2pUnttejs3qrM4Wv
         mqBXyvp3jKmFuQZFZB6gwxnmtck9FDICoZpWDX/VHm5zQ8bnNk72aGg9zYTssL0anMgC
         UKwWIpdb4k3+SAzOOfwNG7PbegeR5TBkHXrsISRWk79GuYKJnuit+x86t9ejaSTbxIlx
         2ONnYF6QdteLDhcJpK8THkkYAQyErcEnN5Y7ZhnJby/MONRIVjhN/rqXfycgkXnPIG3y
         s4WQ==
X-Received: by 10.70.40.166 with SMTP id y6mr26290248pdk.60.1422188912368;
        Sun, 25 Jan 2015 04:28:32 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id z2sm7088792pdc.95.2015.01.25.04.28.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:28:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:39:56 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263011>

Tag "H" (cached) is not shown though because it's usually the majority
and becomes noise. Not showing it makes the other tags stand out. -t
is on by default if more than one file category is selected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-list-files.txt |  6 ++++++
 builtin/ls-files.c               | 27 +++++++++++++++++----------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 1c0c877..9d4c127 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -46,6 +46,12 @@ OPTIONS
 --unmerged::
 	Show unmerged files
=20
+-t::
+--[no-]tag::
+	Show a tag to indicate file type. Automatically turned on with
+	multiple file selections. See linkgit::git-ls-files[1] option
+	`-t` for more information.
+
 -R::
 --recursive::
 	Equivalent of `--max-depth=3D-1` (infinite recursion).
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a80ac6a..b4b24ef 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -596,6 +596,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 			N_("show untracked files")),
 		OPT_SET_INT('R', "recursive", &max_depth,
 			    N_("shortcut for --max-depth=3D-1"), -1),
+		OPT_BOOL('t', "tag", &show_tag,
+			N_("identify the file status with tags")),
 		OPT_BIT('i', "ignored", &dir.flags,
 			N_("show ignored files"),
 			DIR_SHOW_IGNORED),
@@ -636,6 +638,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		setup_standard_excludes(&dir);
 		use_color =3D -1;
 		max_depth =3D 0;
+		show_tag =3D -1;
 		git_config(git_ls_config, NULL);
 	} else
 		git_config(git_default_config, NULL);
@@ -648,16 +651,6 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 	for (i =3D 0; i < exclude_list.nr; i++) {
 		add_exclude(exclude_list.items[i].string, "", 0, el, --exclude_args)=
;
 	}
-	if (show_tag || show_valid_bit) {
-		tag_cached =3D "H ";
-		tag_unmerged =3D "M ";
-		tag_removed =3D "R ";
-		tag_modified =3D "C ";
-		tag_other =3D "? ";
-		tag_killed =3D "K ";
-		tag_skip_worktree =3D "S ";
-		tag_resolve_undo =3D "U ";
-	}
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_=
SHOW_IGNORED) || show_killed)
 		require_work_tree =3D 1;
 	if (show_unmerged && !porcelain)
@@ -711,6 +704,20 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 	      show_killed || show_modified || show_resolve_undo))
 		show_cached =3D 1;
=20
+	if (show_tag =3D=3D -1)
+		show_tag =3D (show_cached + show_deleted + show_others +
+			    show_unmerged + show_killed + show_modified) > 1;
+	if (show_tag || show_valid_bit) {
+		tag_cached =3D porcelain ? "  " : "H ";
+		tag_unmerged =3D "M ";
+		tag_removed =3D "R ";
+		tag_modified =3D "C ";
+		tag_other =3D "? ";
+		tag_killed =3D "K ";
+		tag_skip_worktree =3D "S ";
+		tag_resolve_undo =3D "U ";
+	}
+
 	if (max_prefix)
 		prune_cache(max_prefix);
 	if (with_tree) {
--=20
2.2.0.84.ge9c7a8a
