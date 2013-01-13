From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 06/10] Enable :(glob)path syntax for a lot of commands
Date: Sun, 13 Jan 2013 19:49:35 +0700
Message-ID: <1358081379-17752-7-git-send-email-pclouds@gmail.com>
References: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:50:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN1H-0001Bq-3f
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab3AMMuN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:50:13 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:46754 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793Ab3AMMuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:50:11 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so1767719pad.16
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=38lKw37QqRJWSNl35lh9dk33ulINyXj2QYDuH/mUkjQ=;
        b=cOk44xUKqiSQBE4Jn2g9bkTRSOPnmPxo6246nhMvOvtUE+mQPJ5BkrtLfoxbuv2+/Q
         +b7LAEFtHjWZnrnAlCyKFZNPWr/5D2ryLRqSh8t9F9U8HknKmLX37lWR80ejn00dXs8q
         Am1g2T+w3nwvT1Ys8T6504ojksCFU9xlGktodNkCzm2vfb8wJHKk1C5aGy7w37s54CrY
         qzMjOL6ScwV3N4zjo+2tAUlz14uFPBYDKCGiWrTiP66Puf7AMNHtu/ra8W8TVk74nEPf
         nbfkASQf/P2SItsqaXUoGCIWGnjT2lZ/2yZZmIfF0gDPzkCwFbUm7KMGXQEVyY3KiPMt
         GZbg==
X-Received: by 10.68.212.200 with SMTP id nm8mr249453285pbc.4.1358081411368;
        Sun, 13 Jan 2013 04:50:11 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id rs7sm6310795pbc.2.2013.01.13.04.50.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:50:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:50:26 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213378>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c          | 4 +++-
 builtin/checkout.c     | 4 +++-
 builtin/clean.c        | 4 +++-
 builtin/commit.c       | 8 ++++++--
 builtin/grep.c         | 4 +++-
 builtin/ls-files.c     | 4 +++-
 builtin/ls-tree.c      | 4 +++-
 builtin/rerere.c       | 4 +++-
 builtin/reset.c        | 4 +++-
 builtin/rm.c           | 4 +++-
 builtin/update-index.c | 4 +++-
 revision.c             | 4 +++-
 12 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 1b99e2b..a3ffa9d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -379,7 +379,9 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	 * below before enabling new magic.
 	 */
 	parse_pathspec(&pathspec,
-		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB,
 		       PATHSPEC_SYMLINK_LEADING_PATH |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE,
 		       prefix, argv);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 90f4a01..cb5d548 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1113,7 +1113,9 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 		 * lifted for new magic when opts.patch_mode =3D=3D 0.
 		 */
 		parse_pathspec(&opts.pathspec,
-			       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+			       PATHSPEC_FROMTOP |
+			       PATHSPEC_LITERAL |
+			       (opts.patch_mode ? PATHSPEC_GLOB : 0),
 			       0, prefix, argv);
=20
 		if (!opts.pathspec.nr)
diff --git a/builtin/clean.c b/builtin/clean.c
index b4ffa2b..f675d5a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -101,7 +101,9 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 			    &dir.exclude_list[EXC_CMDL]);
=20
 	parse_pathspec(&pathspec,
-		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB,
 		       0, prefix, argv);
=20
 	fill_directory(&dir, &pathspec);
diff --git a/builtin/commit.c b/builtin/commit.c
index 433fdb9..743a3ea 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -282,7 +282,9 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 	if (is_status)
 		refresh_flags |=3D REFRESH_UNMERGED;
 	parse_pathspec(&pathspec,
-		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB,
 		       PATHSPEC_EMPTY_MATCH_ALL,
 		       prefix, argv);
=20
@@ -1205,7 +1207,9 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	if (show_ignored_in_status)
 		s.show_ignored_files =3D 1;
 	parse_pathspec(&s.pathspec,
-		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB,
 		       PATHSPEC_EMPTY_MATCH_ALL,
 		       prefix, argv);
=20
diff --git a/builtin/grep.c b/builtin/grep.c
index 4d8e82c..9f1b029 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -857,7 +857,9 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	}
=20
 	parse_pathspec(&pathspec,
-		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB,
 		       0, prefix, argv + i);
 	pathspec.max_depth =3D opt.max_depth;
 	pathspec.recursive =3D 1;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1cbd211..feb4220 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -536,7 +536,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		setup_work_tree();
=20
 	parse_pathspec(&pathspec,
-		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB,
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       prefix, argv);
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 4764683..25d0590 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,7 +173,9 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	 * match_pathspec_depth() or tree_entry_interesting()
 	 */
 	parse_pathspec(&pathspec,
-		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB,
 		       0, prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len =3D pathspec.items[i].len;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 779fc77..d64d010 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -72,7 +72,9 @@ int cmd_rerere(int argc, const char **argv, const cha=
r *prefix)
 		if (argc < 2)
 			warning("'git rerere forget' without paths is deprecated");
 		parse_pathspec(&pathspec,
-			       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+			       PATHSPEC_FROMTOP |
+			       PATHSPEC_LITERAL |
+			       PATHSPEC_GLOB,
 			       0, prefix, argv + 1);
 		return rerere_forget(&pathspec);
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index 69ce164..f71af9c 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -184,7 +184,9 @@ static int read_from_tree(const char *prefix, const=
 char **argv,
=20
 	memset(&opt, 0, sizeof(opt));
 	parse_pathspec(&opt.pathspec,
-		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB,
 		       0, prefix, argv);
 	opt.output_format =3D DIFF_FORMAT_CALLBACK;
 	opt.format_callback =3D update_index_from_diff;
diff --git a/builtin/rm.c b/builtin/rm.c
index d46f1aa..ff0fd5b 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -250,7 +250,9 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 	}
=20
 	parse_pathspec(&pathspec,
-		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB,
 		       0, prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
=20
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1dd6178..c456e1b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -549,7 +549,9 @@ static int do_reupdate(int ac, const char **av,
 	struct pathspec pathspec;
=20
 	parse_pathspec(&pathspec,
-		       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB,
 		       0, prefix, av + 1);
=20
 	if (read_ref("HEAD", head_sha1))
diff --git a/revision.c b/revision.c
index 079955f..5ac480b 100644
--- a/revision.c
+++ b/revision.c
@@ -1852,7 +1852,9 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 		ALLOC_GROW(prune_data.path, prune_data.nr+1, prune_data.alloc);
 		prune_data.path[prune_data.nr++] =3D NULL;
 		parse_pathspec(&revs->prune_data,
-			       PATHSPEC_FROMTOP | PATHSPEC_LITERAL,
+			       PATHSPEC_FROMTOP |
+			       PATHSPEC_LITERAL |
+			       PATHSPEC_GLOB,
 			       0, revs->prefix, prune_data.path);
 	}
=20
--=20
1.8.0.rc2.23.g1fb49df
