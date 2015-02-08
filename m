From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/21] list-files: add -t back
Date: Sun,  8 Feb 2015 16:01:32 +0700
Message-ID: <1423386099-19994-15-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:03:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNmM-0006HF-Rz
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810AbbBHJDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:03:39 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36366 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708AbbBHJDg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:03:36 -0500
Received: by pdjp10 with SMTP id p10so14336068pdj.3
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gUfjeuTM1lgWyM6ABtmfG/8M7ey12nitIOFr/YRW+8o=;
        b=zAiXcegBG3SylhR40d5J2mbLgb1dPdBqWUYygQODqTP8bETVecWs3+LH/yzOyv8eBN
         YdV9vf4lwCqmiFEvYMsF5LCE4r3lbv/MB6/vb57WapzhwR6vYr9q1FZHSGDM2aNUZN8t
         KE0+zGlsKgpoUYpEL8wZIeoc5V4hP/2hkXjwQyf3NMg6o7a9r2Kpm3WmW2MkF8rbmJVw
         j11nG4hnqCU4dr92QkTSDkoBDyRNYWAsVGrjabStjkpxcCxmY/9tzMEU6pJ70s//Fkoh
         cPjmNXDvxfa/s8yxY8HMfVjA9prpCSW1VaEYjehO81FNinosEAM+KCmOKFeamDlwfdEl
         rrZg==
X-Received: by 10.70.91.106 with SMTP id cd10mr19598397pdb.48.1423386216253;
        Sun, 08 Feb 2015 01:03:36 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id hd4sm12899823pbc.86.2015.02.08.01.03.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:03:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:03:43 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263501>

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
index 62aa64f..0e7cbb9 100644
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
2.3.0.rc1.137.g477eb31
