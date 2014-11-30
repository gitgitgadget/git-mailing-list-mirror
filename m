From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/19] list-files: add -t back
Date: Sun, 30 Nov 2014 15:56:01 +0700
Message-ID: <1417337767-4505-14-git-send-email-pclouds@gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:58:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0KX-0003Ar-Kh
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbaK3I6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:58:05 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34395 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaK3I6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:58:04 -0500
Received: by mail-pd0-f180.google.com with SMTP id p10so8928697pdj.25
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cViTHZWaheLZJpiD9CIIj2WGHiTPXJjvaXG08SI/zTA=;
        b=UzCr9hNhdqHDZ6TqXKjQulVGRi6NADGwoBWcA5CFjRoyFd8jY23XpK1veL+lBjrY3d
         piul2zZYaFpVQZqVWQHEvcDlzFW7ZJIJWq5nlCrvWGtnxxCqfNoCCsxYA2iqS+ZLZ3kn
         LqG3do5sQpYkuuZMQAynEwNJw/gKaCtJYJp8sCQHSLGnoIYyoWaE5ly1rXp0B5BQAZnj
         VzznjU/7/sqofV7Yo5OIyuyDpz4/TY2EXYqjwj9Lq92+EJKlZVN6Ghx86MHyzvDvlpVy
         K750htvMCPgTH+q9VKc/BPapEp2N7bXhgYatuofCWKVaPjQwWwvX2NS5LvCyXQBQTtMZ
         ZUfg==
X-Received: by 10.70.102.17 with SMTP id fk17mr7127956pdb.61.1417337883150;
        Sun, 30 Nov 2014 00:58:03 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id gz10sm14452260pac.23.2014.11.30.00.57.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:58:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:58:01 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260436>

Tag "H" (cached) is not shown though because it's usually the majority
and becomes noise. Not showing it makes the other tags stand out. -t
is on by default if more than one file category is selected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-list-files.txt |  6 ++++++
 builtin/ls-files.c               | 27 +++++++++++++++++----------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 725a236..0ef616b 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -45,6 +45,12 @@ OPTIONS
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
index be9a39c..c7aaade 100644
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
2.2.0.60.gb7b3c64
