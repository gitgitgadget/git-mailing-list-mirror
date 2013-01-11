From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 18/21] Convert {read,fill}_directory to take struct pathspec
Date: Fri, 11 Jan 2013 18:21:12 +0700
Message-ID: <1357903275-16804-19-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttchd-0007wc-Pp
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239Ab3AKLWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:22:54 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47071 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab3AKLWx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:22:53 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so971297pac.29
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=OZDnqMrOrV/vWPeBTomua240GGdKxMX6z5RnpMwt+1s=;
        b=O+IbSwmHWrDcS91vNHuGxtNm0Hr13HJQWIdj12bbHpqZXSLVhGDbQ6TsxRFcuw7Wty
         2+RHbubvsRVffVNjrQOV/T0zGF1uoYH+tLmCVakyV1xZY1OvRAfOSO1x+LKWak8+tuim
         gMr5VT+XhM2oqOuuci73exMBi19aET/tiVDct9S1Bkm6lxXMNXIZtVYE/p+Z+nqL9vc4
         uDer+h4jXmtLpjsAC9PFOvckVePgSDiDBogj5xrqYvPZkgvDhT4BT3vI9wfzc3+egHLW
         I4ZV/LjRElw8jduoELSzcYep6NMgkafVcHG9eVZ2W0ZIO2n/Aoy4gIg0u3L09bQilWzH
         YcQQ==
X-Received: by 10.66.83.136 with SMTP id q8mr206267749pay.83.1357903372937;
        Fri, 11 Jan 2013 03:22:52 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id j9sm2955797paw.2.2013.01.11.03.22.50
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:22:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:23:07 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213211>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c      |  2 +-
 builtin/clean.c    |  2 +-
 builtin/grep.c     |  2 +-
 builtin/ls-files.c |  2 +-
 dir.c              | 10 +++++-----
 dir.h              |  4 ++--
 wt-status.c        |  4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 4e2b603..0295cef 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -402,7 +402,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		}
=20
 		/* This picks up the paths that are not tracked */
-		baselen =3D fill_directory(&dir, pathspec.raw);
+		baselen =3D fill_directory(&dir, &pathspec);
 		if (pathspec.nr)
 			seen =3D prune_directory(&dir, pathspec.raw, baselen);
 	}
diff --git a/builtin/clean.c b/builtin/clean.c
index 788ad8c..41c8cad 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -103,7 +103,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
=20
 	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
=20
-	fill_directory(&dir, pathspec.raw);
+	fill_directory(&dir, &pathspec);
=20
 	if (pathspec.nr)
 		seen =3D xmalloc(pathspec.nr);
diff --git a/builtin/grep.c b/builtin/grep.c
index 705f9ff..f370bad 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -522,7 +522,7 @@ static int grep_directory(struct grep_opt *opt, con=
st struct pathspec *pathspec,
 	if (exc_std)
 		setup_standard_excludes(&dir);
=20
-	fill_directory(&dir, pathspec->raw);
+	fill_directory(&dir, pathspec);
 	for (i =3D 0; i < dir.nr; i++) {
 		const char *name =3D dir.entries[i]->name;
 		int namelen =3D strlen(name);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index be6e05d..7bb637b 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -216,7 +216,7 @@ static void show_files(struct dir_struct *dir)
=20
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
-		fill_directory(dir, pathspec.raw);
+		fill_directory(dir, &pathspec);
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
diff --git a/dir.c b/dir.c
index 4d1f71c..eb52913 100644
--- a/dir.c
+++ b/dir.c
@@ -72,7 +72,7 @@ char *common_prefix(const char **pathspec)
 	return len ? xmemdupz(*pathspec, len) : NULL;
 }
=20
-int fill_directory(struct dir_struct *dir, const char **pathspec)
+int fill_directory(struct dir_struct *dir, const struct pathspec *path=
spec)
 {
 	size_t len;
=20
@@ -80,10 +80,10 @@ int fill_directory(struct dir_struct *dir, const ch=
ar **pathspec)
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	len =3D common_prefix_len(pathspec);
+	len =3D common_prefix_len(pathspec->raw);
=20
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec ? *pathspec : "", len, pathspec);
+	read_directory(dir, pathspec->nr ? pathspec->raw[0] : "", len, pathsp=
ec);
 	return len;
 }
=20
@@ -1211,14 +1211,14 @@ static int treat_leading_path(struct dir_struct=
 *dir,
 	return rc;
 }
=20
-int read_directory(struct dir_struct *dir, const char *path, int len, =
const char **pathspec)
+int read_directory(struct dir_struct *dir, const char *path, int len, =
const struct pathspec *pathspec)
 {
 	struct path_simplify *simplify;
=20
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
=20
-	simplify =3D create_simplify(pathspec);
+	simplify =3D create_simplify(pathspec ? pathspec->raw : NULL);
 	if (!len || treat_leading_path(dir, path, len, simplify))
 		read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
diff --git a/dir.h b/dir.h
index 1d4888b..b51d2e9 100644
--- a/dir.h
+++ b/dir.h
@@ -74,8 +74,8 @@ extern int match_pathspec_depth(const struct pathspec=
 *pathspec,
 				int prefix, char *seen);
 extern int within_depth(const char *name, int namelen, int depth, int =
max_depth);
=20
-extern int fill_directory(struct dir_struct *dir, const char **pathspe=
c);
-extern int read_directory(struct dir_struct *, const char *path, int l=
en, const char **pathspec);
+extern int fill_directory(struct dir_struct *dir, const struct pathspe=
c *pathspec);
+extern int read_directory(struct dir_struct *, const char *path, int l=
en, const struct pathspec *pathspec);
=20
 extern int excluded_from_list(const char *pathname, int pathlen, const=
 char *basename,
 			      int *dtype, struct exclude_list *el);
diff --git a/wt-status.c b/wt-status.c
index 13e6aba..2e1a62b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -502,7 +502,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	setup_standard_excludes(&dir);
=20
-	fill_directory(&dir, s->pathspec.raw);
+	fill_directory(&dir, &s->pathspec);
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
@@ -514,7 +514,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 	if (s->show_ignored_files) {
 		dir.nr =3D 0;
 		dir.flags =3D DIR_SHOW_IGNORED | DIR_SHOW_OTHER_DIRECTORIES;
-		fill_directory(&dir, s->pathspec.raw);
+		fill_directory(&dir, &s->pathspec);
 		for (i =3D 0; i < dir.nr; i++) {
 			struct dir_entry *ent =3D dir.entries[i];
 			if (cache_name_is_other(ent->name, ent->len) &&
--=20
1.8.0.rc2.23.g1fb49df
