From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/17] ls: add -t back
Date: Wed, 26 Mar 2014 20:48:14 +0700
Message-ID: <1395841697-11742-15-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:49:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoCh-0000f8-Pg
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbaCZNtK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:49:10 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:65203 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbaCZNtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:49:09 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so1903186pdi.2
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1JLBbw7ErVrHh0Dm73rZxG7lXmk4qZo+GOwZDIEVYio=;
        b=0ootQ92uTBt3Y6EfHPBnREpdr/PypIDKQZKWdyY90ua2H8pL633edEMAWSIX3BuuRn
         RUj56lof5ARuVpERFi0cE2AARTSWkf18kXKsWb5eFwW6uD6z8q4J+jTYrUFmr7Pqtz5k
         uUn1P4DckDjuHLo5iAXYRlpeTjrbJvbwfeB1uoW4KStNJ8UFcsqLsuEy3fhS45HEgp1s
         1rtwxnMfhrjRbjkoaNbka1cw7v1NmJKEPCfcnmr5w7ZAg4PH1i2yPUoQMzxD9zs3QIPT
         LzzMz823P2qcEAHB8IjROTKoagrB4PUPJ2QoSIuTbMwsYXjD7lWKTm0LFtLdNL5ce8eY
         j8qw==
X-Received: by 10.68.129.34 with SMTP id nt2mr12607344pbb.18.1395841749142;
        Wed, 26 Mar 2014 06:49:09 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id bc4sm58559459pbb.2.2014.03.26.06.49.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:49:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:50:02 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245193>

Tag "H" (cached) is not shown though because it's usually the majority
and becomes noise. Not showing it makes the other tags stand out. -t
is on by default if more than one file category is selected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls.txt |  6 ++++++
 builtin/ls-files.c       | 27 +++++++++++++++++----------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-ls.txt b/Documentation/git-ls.txt
index 0480c42..126d9db 100644
--- a/Documentation/git-ls.txt
+++ b/Documentation/git-ls.txt
@@ -47,6 +47,12 @@ OPTIONS
 --unmerged::
 	Show unmerged files in the output (forces --stage)
=20
+-t::
+--tag::
+	Show a tag to indicate file type, helpful when multiple file
+	selections are used. See linkgit::git-ls-files[1] option `-t`
+	for more information.
+
 -R::
 --recursive::
 	Equivalent of --max-depth=3D-1 (infinite recursion).
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 014de05..392d273 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -515,16 +515,6 @@ static int ls_files(const char **argv, const char =
*prefix)
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
@@ -578,6 +568,20 @@ static int ls_files(const char **argv, const char =
*prefix)
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
@@ -727,6 +731,8 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 			N_("show unmerged files in the output")),
 		OPT_SET_INT('R', "recursive", &max_depth,
 			    N_("shortcut for --max-depth=3D-1"), -1),
+		OPT_BOOL('t', "tag", &show_tag,
+			N_("identify the file status with tags")),
 		OPT__COLOR(&use_color, N_("show color")),
 		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
 		OPT_SET_INT('1', NULL, &colopts,
@@ -756,6 +762,7 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 	setup_standard_excludes(&dir);
 	use_color =3D -1;
 	max_depth =3D 0;
+	show_tag =3D -1;
=20
 	argc =3D parse_options(argc, argv, prefix, builtin_ls_options,
 			     ls_usage, 0);
--=20
1.9.1.345.ga1a145c
