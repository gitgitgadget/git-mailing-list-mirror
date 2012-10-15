From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/12] pathspec.c: move reusable code from builtin/add.c
Date: Mon, 15 Oct 2012 13:28:04 +0700
Message-ID: <1350282486-4646-10-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:29:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeBT-0001cv-4G
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab2JOG3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:29:40 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55849 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab2JOG3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:29:39 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4544170pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AkwBozbNZMxnfSvPPOt68dWnzoOpeLaRpFAPsTRCRzs=;
        b=Ugdvy38ZKsNoy7iIUBXUDzJPuIqu01+Vu6flf9XzLMbwj/vbxCjn2NB+0k4pktu5k0
         JsVi2/gSaVAV/0ybFnyCS0NUpL5NohMFrY8kFa88fIq3sKGEEL0hH+wZ4qwBLCI31FSj
         z9zvvp6kjv7EKlEkbFtgWjcS881ue+jPHyRz1cUnD6M1EN6fEUZhHwjVqHnjzMkFFxhb
         6pzKQnOBsw6acYASOod+JXVRSCEXFfyl5FntkYZhfhAgpwOA7atIyyy9gF8Ed/avJ4XK
         XQKia+SnVCBWzLPFUcZ2cpM9lp0yqngrjm5UPrKFy/i7cI3LXwk38JOm0BY85g7Z9AZP
         OjRA==
Received: by 10.66.79.69 with SMTP id h5mr30591182pax.12.1350282579595;
        Sun, 14 Oct 2012 23:29:39 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id py9sm8582885pbb.20.2012.10.14.23.29.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:29:38 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:29:29 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207721>

=46rom: Adam Spiers <git@adamspiers.org>

This is in preparation for reuse by a new git check-ignore command.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile      |  2 ++
 builtin/add.c | 95 ++-------------------------------------------------=
------
 pathspec.c    | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 pathspec.h    |  6 ++++
 4 files changed, 109 insertions(+), 92 deletions(-)
 create mode 100644 pathspec.c
 create mode 100644 pathspec.h

diff --git a/Makefile b/Makefile
index 13293d3..48facad 100644
--- a/Makefile
+++ b/Makefile
@@ -645,6 +645,7 @@ LIB_H +=3D pack-refs.h
 LIB_H +=3D pack-revindex.h
 LIB_H +=3D parse-options.h
 LIB_H +=3D patch-ids.h
+LIB_H +=3D pathspec.h
 LIB_H +=3D pkt-line.h
 LIB_H +=3D progress.h
 LIB_H +=3D prompt.h
@@ -758,6 +759,7 @@ LIB_OBJS +=3D parse-options-cb.o
 LIB_OBJS +=3D patch-delta.o
 LIB_OBJS +=3D patch-ids.o
 LIB_OBJS +=3D path.o
+LIB_OBJS +=3D pathspec.o
 LIB_OBJS +=3D pkt-line.o
 LIB_OBJS +=3D preload-index.o
 LIB_OBJS +=3D pretty.o
diff --git a/builtin/add.c b/builtin/add.c
index 6d2fb0c..927b0f2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "dir.h"
+#include "pathspec.h"
 #include "exec_cmd.h"
 #include "cache-tree.h"
 #include "run-command.h"
@@ -97,39 +98,6 @@ int add_files_to_cache(const char *prefix, const cha=
r **pathspec, int flags)
 	return !!data.add_errors;
 }
=20
-static void fill_pathspec_matches(const char **pathspec, char *seen, i=
nt specs)
-{
-	int num_unmatched =3D 0, i;
-
-	/*
-	 * Since we are walking the index as if we were walking the directory=
,
-	 * we have to mark the matched pathspec as seen; otherwise we will
-	 * mistakenly think that the user gave a pathspec that did not match
-	 * anything.
-	 */
-	for (i =3D 0; i < specs; i++)
-		if (!seen[i])
-			num_unmatched++;
-	if (!num_unmatched)
-		return;
-	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
-		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
-	}
-}
-
-static char *find_used_pathspec(const char **pathspec)
-{
-	char *seen;
-	int i;
-
-	for (i =3D 0; pathspec[i];  i++)
-		; /* just counting */
-	seen =3D xcalloc(i, 1);
-	fill_pathspec_matches(pathspec, seen, i);
-	return seen;
-}
-
 static char *prune_directory(struct dir_struct *dir, const char **path=
spec, int prefix)
 {
 	char *seen;
@@ -153,46 +121,6 @@ static char *prune_directory(struct dir_struct *di=
r, const char **pathspec, int
 	return seen;
 }
=20
-/*
- * Check whether path refers to a submodule, or something inside a
- * submodule.  If the former, returns the path with any trailing slash
- * stripped.  If the latter, dies with an error message.
- */
-const char *treat_gitlink(const char *path)
-{
-	int i, path_len =3D strlen(path);
-	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
-		if (S_ISGITLINK(ce->ce_mode)) {
-			int ce_len =3D ce_namelen(ce);
-			if (path_len <=3D ce_len || path[ce_len] !=3D '/' ||
-			    memcmp(ce->name, path, ce_len))
-				/* path does not refer to this
-				 * submodule or anything inside it */
-				continue;
-			if (path_len =3D=3D ce_len + 1) {
-				/* path refers to submodule;
-				 * strip trailing slash */
-				return xstrndup(ce->name, ce_len);
-			} else {
-				die (_("Path '%s' is in submodule '%.*s'"),
-				     path, ce_len, ce->name);
-			}
-		}
-	}
-	return path;
-}
-
-void treat_gitlinks(const char **pathspec)
-{
-	if (!pathspec || !*pathspec)
-		return;
-
-	int i;
-	for (i =3D 0; pathspec[i]; i++)
-		pathspec[i] =3D treat_gitlink(pathspec[i]);
-}
-
 static void refresh(int verbose, const char **pathspec)
 {
 	char *seen;
@@ -210,23 +138,6 @@ static void refresh(int verbose, const char **path=
spec)
         free(seen);
 }
=20
-static const char **validate_pathspec(int argc, const char **argv, con=
st char *prefix)
-{
-	const char **pathspec =3D get_pathspec(prefix, argv);
-
-	if (pathspec) {
-		const char **p;
-		for (p =3D pathspec; *p; p++) {
-			if (has_symlink_leading_path(*p, strlen(*p))) {
-				int len =3D prefix ? strlen(prefix) : 0;
-				die(_("'%s' is beyond a symbolic link"), *p + len);
-			}
-		}
-	}
-
-	return pathspec;
-}
-
 int run_add_interactive(const char *revision, const char *patch_mode,
 			const char **pathspec)
 {
@@ -261,7 +172,7 @@ int interactive_add(int argc, const char **argv, co=
nst char *prefix, int patch)
 	const char **pathspec =3D NULL;
=20
 	if (argc) {
-		pathspec =3D validate_pathspec(argc, argv, prefix);
+		pathspec =3D validate_pathspec(prefix, argv);
 		if (!pathspec)
 			return -1;
 	}
@@ -427,7 +338,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
-	pathspec =3D validate_pathspec(argc, argv, prefix);
+	pathspec =3D validate_pathspec(prefix, argv);
=20
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
diff --git a/pathspec.c b/pathspec.c
new file mode 100644
index 0000000..a9c5b5b
--- /dev/null
+++ b/pathspec.c
@@ -0,0 +1,98 @@
+#include "cache.h"
+#include "dir.h"
+
+void validate_path(const char *prefix, const char *path)
+{
+	if (has_symlink_leading_path(path, strlen(path))) {
+		int len =3D prefix ? strlen(prefix) : 0;
+		die(_("'%s' is beyond a symbolic link"), path + len);
+	}
+}
+
+const char **validate_pathspec(const char *prefix, const char **files)
+{
+	const char **pathspec =3D get_pathspec(prefix, files);
+
+	if (pathspec) {
+		const char **p;
+		for (p =3D pathspec; *p; p++) {
+			validate_path(prefix, *p);
+		}
+	}
+
+	return pathspec;
+}
+
+void fill_pathspec_matches(const char **pathspec, char *seen, int spec=
s)
+{
+	int num_unmatched =3D 0, i;
+
+	/*
+	 * Since we are walking the index as if we were walking the directory=
,
+	 * we have to mark the matched pathspec as seen; otherwise we will
+	 * mistakenly think that the user gave a pathspec that did not match
+	 * anything.
+	 */
+	for (i =3D 0; i < specs; i++)
+		if (!seen[i])
+			num_unmatched++;
+	if (!num_unmatched)
+		return;
+	for (i =3D 0; i < active_nr; i++) {
+		struct cache_entry *ce =3D active_cache[i];
+		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
+	}
+}
+
+char *find_used_pathspec(const char **pathspec)
+{
+	char *seen;
+	int i;
+
+	for (i =3D 0; pathspec[i];  i++)
+		; /* just counting */
+	seen =3D xcalloc(i, 1);
+	fill_pathspec_matches(pathspec, seen, i);
+	return seen;
+}
+
+/*
+ * Check whether path refers to a submodule, or something inside a
+ * submodule.  If the former, returns the path with any trailing slash
+ * stripped.  If the latter, dies with an error message.
+ */
+const char *treat_gitlink(const char *path)
+{
+	int i, path_len =3D strlen(path);
+	for (i =3D 0; i < active_nr; i++) {
+		struct cache_entry *ce =3D active_cache[i];
+		if (S_ISGITLINK(ce->ce_mode)) {
+			int ce_len =3D ce_namelen(ce);
+			if (path_len <=3D ce_len || path[ce_len] !=3D '/' ||
+			    memcmp(ce->name, path, ce_len))
+				/* path does not refer to this
+				 * submodule or anything inside it */
+				continue;
+			if (path_len =3D=3D ce_len + 1) {
+				/* path refers to submodule;
+				 * strip trailing slash */
+				return xstrndup(ce->name, ce_len);
+			} else {
+				die (_("Path '%s' is in submodule '%.*s'"),
+				     path, ce_len, ce->name);
+			}
+		}
+	}
+	return path;
+}
+
+void treat_gitlinks(const char **pathspec)
+{
+	int i;
+
+	if (!pathspec || !*pathspec)
+		return;
+
+	for (i =3D 0; pathspec[i]; i++)
+		pathspec[i] =3D treat_gitlink(pathspec[i]);
+}
diff --git a/pathspec.h b/pathspec.h
new file mode 100644
index 0000000..b7c053a
--- /dev/null
+++ b/pathspec.h
@@ -0,0 +1,6 @@
+extern void validate_path(const char *prefix, const char *path);
+extern const char **validate_pathspec(const char *prefix, const char *=
*files);
+extern char *find_used_pathspec(const char **pathspec);
+extern void fill_pathspec_matches(const char **pathspec, char *seen, i=
nt specs);
+extern const char *treat_gitlink(const char *path);
+extern void treat_gitlinks(const char **pathspec);
--=20
1.8.0.rc0.29.g1fdd78f
