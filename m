From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/21] checkout: convert read_tree_some to take struct pathspec
Date: Sun,  6 Jan 2013 13:21:03 +0700
Message-ID: <1357453268-12543-17-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:23:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrjdO-0000Rl-2l
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab3AFGWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:22:42 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:42993 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab3AFGWl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:22:41 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so8109670dad.13
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=blHDIW+qZ6nN4HBiblp28fftz/0aIs2RAaZZ0HrbtsA=;
        b=CiFnaky6a7SfULiJegk0P4v7I3UyWK1vAuaOvZzTPJtM+efl78t0EkneyO52y/Fb48
         6v5OPj/V0wF0GnIaBjlz8AAf+Y7KXtsvq6IZWdjJfdcI3osZq950bEwSzOX2B0JvzcI2
         Pr1rzLoVX+V0gKC7mugPvIJXCxsBpXOKedWom7XYa4BaGSfUf3wNy1U3OrHbgFWzOpag
         Z1CLMHNw3y9GmJZ7fBi27AvJ+BHJ/E+aXlyJRaCYJq9S7zsJnE1h7F+nP7uTmjwJQpfr
         3TM0BU8NiP2IozUDdrZd6Udzu/dG2fBoCTdZKZiznlB20Gh1ePZrVQdw/E9Qt7j0eh8o
         xzsw==
X-Received: by 10.68.235.71 with SMTP id uk7mr177163438pbc.10.1357453361064;
        Sat, 05 Jan 2013 22:22:41 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id rq7sm35284898pbc.69.2013.01.05.22.22.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:22:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:22:50 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212770>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 9 +++------
 tree.c             | 4 ++--
 tree.h             | 2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index aa399d6..a7ddb35 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -82,12 +82,9 @@ static int update_some(const unsigned char *sha1, co=
nst char *base, int baselen,
 	return 0;
 }
=20
-static int read_tree_some(struct tree *tree, const char **pathspec)
+static int read_tree_some(struct tree *tree, const struct pathspec *pa=
thspec)
 {
-	struct pathspec ps;
-	init_pathspec(&ps, pathspec);
-	read_tree_recursive(tree, "", 0, 0, &ps, update_some, NULL);
-	free_pathspec(&ps);
+	read_tree_recursive(tree, "", 0, 0, pathspec, update_some, NULL);
=20
 	/* update the index with the given tree's info
 	 * for all args, expanding wildcards, and exit
@@ -265,7 +262,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		return error(_("corrupt index file"));
=20
 	if (opts->source_tree)
-		read_tree_some(opts->source_tree, opts->pathspec.raw);
+		read_tree_some(opts->source_tree, &opts->pathspec);
=20
 	ps_matched =3D xcalloc(1, opts->pathspec.nr);
=20
diff --git a/tree.c b/tree.c
index 62fed63..ff72f67 100644
--- a/tree.c
+++ b/tree.c
@@ -47,7 +47,7 @@ static int read_one_entry_quick(const unsigned char *=
sha1, const char *base, int
 }
=20
 static int read_tree_1(struct tree *tree, struct strbuf *base,
-		       int stage, struct pathspec *pathspec,
+		       int stage, const struct pathspec *pathspec,
 		       read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
@@ -116,7 +116,7 @@ static int read_tree_1(struct tree *tree, struct st=
rbuf *base,
=20
 int read_tree_recursive(struct tree *tree,
 			const char *base, int baselen,
-			int stage, struct pathspec *pathspec,
+			int stage, const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context)
 {
 	struct strbuf sb =3D STRBUF_INIT;
diff --git a/tree.h b/tree.h
index 69bcb5e..9dc90ba 100644
--- a/tree.h
+++ b/tree.h
@@ -25,7 +25,7 @@ typedef int (*read_tree_fn_t)(const unsigned char *, =
const char *, int, const ch
=20
 extern int read_tree_recursive(struct tree *tree,
 			       const char *base, int baselen,
-			       int stage, struct pathspec *pathspec,
+			       int stage, const struct pathspec *pathspec,
 			       read_tree_fn_t fn, void *context);
=20
 extern int read_tree(struct tree *tree, int stage, struct pathspec *pa=
thspec);
--=20
1.8.0.rc2.23.g1fb49df
