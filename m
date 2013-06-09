From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/45] Move struct pathspec and related functions to pathspec.[ch]
Date: Sun,  9 Jun 2013 13:25:35 +0700
Message-ID: <1370759178-1709-3-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:25:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ3x-000831-TD
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab3FIGZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:25:07 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:34440 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3FIGZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:25:05 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so1414064pbc.17
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wdy4MQ0/0+KQ/2CLnjyD7a/AU6gL/2FArLgVlkI/lBA=;
        b=XXqawnb0CUwSmoh2LwM8uhp8cS5WvzLpjX8AOta7Y3xHK5e/nibbAJEoH+Wbe6pAgv
         CuONSYuN4RPoTju0InEfHLpk/pFbz3MHGbnLtExFhR9YRi62Q3dicMnJE21SwFIWQrt8
         emQMEuZy7Vn9iwL2CD94dIhm9dz1G7S9YY3TZqMRvVJjueUtUDpts1RZwXyvyleIblIG
         032z0mScctJdqX89cYwnLx3Cza6l0Z3RDVICxPFn/3Rwn7dyOt4t4YAnCPa0jeGdKgZc
         MtMcnZbXp6S6NcQXjNgzcVmQBbMrODqObNogcQARNjkxyZv1ZBPpaYEuiCblgEWxnjQ/
         U65A==
X-Received: by 10.68.224.104 with SMTP id rb8mr5009768pbc.206.1370759105358;
        Sat, 08 Jun 2013 23:25:05 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id fn9sm10267413pab.2.2013.06.08.23.25.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:25:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:26:36 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226894>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c              |   1 +
 builtin/grep.c         |   1 +
 builtin/ls-files.c     |   1 +
 builtin/ls-tree.c      |   1 +
 builtin/update-index.c |   1 +
 cache.h                |  22 +-------
 diff.h                 |   1 +
 dir.c                  |   1 +
 pathspec.c             | 150 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 pathspec.h             |  21 +++++++
 preload-index.c        |   1 +
 setup.c                | 149 -----------------------------------------=
-------
 tree-walk.c            |   1 +
 13 files changed, 182 insertions(+), 169 deletions(-)

diff --git a/archive.c b/archive.c
index d254fa5..c699a2d 100644
--- a/archive.c
+++ b/archive.c
@@ -5,6 +5,7 @@
 #include "archive.h"
 #include "parse-options.h"
 #include "unpack-trees.h"
+#include "pathspec.h"
=20
 static char const * const archive_usage[] =3D {
 	N_("git archive [options] <tree-ish> [<path>...]"),
diff --git a/builtin/grep.c b/builtin/grep.c
index 159e65d..4de49df 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -17,6 +17,7 @@
 #include "grep.h"
 #include "quote.h"
 #include "dir.h"
+#include "pathspec.h"
=20
 static char const * const grep_usage[] =3D {
 	N_("git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]"),
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2202072..a0b7e30 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -13,6 +13,7 @@
 #include "parse-options.h"
 #include "resolve-undo.h"
 #include "string-list.h"
+#include "pathspec.h"
=20
 static int abbrev;
 static int show_deleted;
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index fb76e38..93fc3a0 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "pathspec.h"
=20
 static int line_termination =3D '\n';
 #define LS_RECURSIVE 1
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5c7762e..b9c2bd0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -11,6 +11,7 @@
 #include "refs.h"
 #include "resolve-undo.h"
 #include "parse-options.h"
+#include "pathspec.h"
=20
 /*
  * Default to not allowing changes to the list of files. The
diff --git a/cache.h b/cache.h
index df532f8..5917375 100644
--- a/cache.h
+++ b/cache.h
@@ -185,6 +185,8 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
=20
+struct pathspec;
+
 /*
  * Copy the sha1 and stat state of a cache entry from one to
  * another. But we never change the name, or the hash state!
@@ -483,28 +485,8 @@ extern void *read_blob_data_from_index(struct inde=
x_state *, const char *, unsig
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
-#define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
-
-struct pathspec {
-	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
-	int nr;
-	unsigned int has_wildcard:1;
-	unsigned int recursive:1;
-	int max_depth;
-	struct pathspec_item {
-		const char *match;
-		int len;
-		int nowildcard_len;
-		int flags;
-	} *items;
-};
-
-extern int init_pathspec(struct pathspec *, const char **);
-extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
=20
-extern int limit_pathspec_to_literal(void);
-
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum=
 object_type type, const char *path, unsigned flags);
diff --git a/diff.h b/diff.h
index 78b4091..d1bc914 100644
--- a/diff.h
+++ b/diff.h
@@ -5,6 +5,7 @@
 #define DIFF_H
=20
 #include "tree-walk.h"
+#include "pathspec.h"
=20
 struct rev_info;
 struct diff_options;
diff --git a/dir.c b/dir.c
index 897c874..9291c9a 100644
--- a/dir.c
+++ b/dir.c
@@ -11,6 +11,7 @@
 #include "dir.h"
 #include "refs.h"
 #include "wildmatch.h"
+#include "pathspec.h"
=20
 struct path_simplify {
 	int len;
diff --git a/pathspec.c b/pathspec.c
index 284f397..133f8be 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -99,3 +99,153 @@ void die_if_path_beyond_symlink(const char *path, c=
onst char *prefix)
 		die(_("'%s' is beyond a symbolic link"), path + len);
 	}
 }
+
+/*
+ * Magic pathspec
+ *
+ * NEEDSWORK: These need to be moved to dir.h or even to a new
+ * pathspec.h when we restructure get_pathspec() users to use the
+ * "struct pathspec" interface.
+ *
+ * Possible future magic semantics include stuff like:
+ *
+ *	{ PATHSPEC_NOGLOB, '!', "noglob" },
+ *	{ PATHSPEC_ICASE, '\0', "icase" },
+ *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
+ *	{ PATHSPEC_REGEXP, '\0', "regexp" },
+ *
+ */
+#define PATHSPEC_FROMTOP    (1<<0)
+
+static struct pathspec_magic {
+	unsigned bit;
+	char mnemonic; /* this cannot be ':'! */
+	const char *name;
+} pathspec_magic[] =3D {
+	{ PATHSPEC_FROMTOP, '/', "top" },
+};
+
+/*
+ * Take an element of a pathspec and check for magic signatures.
+ * Append the result to the prefix.
+ *
+ * For now, we only parse the syntax and throw out anything other than
+ * "top" magic.
+ *
+ * NEEDSWORK: This needs to be rewritten when we start migrating
+ * get_pathspec() users to use the "struct pathspec" interface.  For
+ * example, a pathspec element may be marked as case-insensitive, but
+ * the prefix part must always match literally, and a single stupid
+ * string cannot express such a case.
+ */
+static const char *prefix_pathspec(const char *prefix, int prefixlen, =
const char *elt)
+{
+	unsigned magic =3D 0;
+	const char *copyfrom =3D elt;
+	int i;
+
+	if (elt[0] !=3D ':') {
+		; /* nothing to do */
+	} else if (elt[1] =3D=3D '(') {
+		/* longhand */
+		const char *nextat;
+		for (copyfrom =3D elt + 2;
+		     *copyfrom && *copyfrom !=3D ')';
+		     copyfrom =3D nextat) {
+			size_t len =3D strcspn(copyfrom, ",)");
+			if (copyfrom[len] =3D=3D ',')
+				nextat =3D copyfrom + len + 1;
+			else
+				/* handle ')' and '\0' */
+				nextat =3D copyfrom + len;
+			if (!len)
+				continue;
+			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
+				if (strlen(pathspec_magic[i].name) =3D=3D len &&
+				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
+					magic |=3D pathspec_magic[i].bit;
+					break;
+				}
+			if (ARRAY_SIZE(pathspec_magic) <=3D i)
+				die("Invalid pathspec magic '%.*s' in '%s'",
+				    (int) len, copyfrom, elt);
+		}
+		if (*copyfrom !=3D ')')
+			die("Missing ')' at the end of pathspec magic in '%s'", elt);
+		copyfrom++;
+	} else {
+		/* shorthand */
+		for (copyfrom =3D elt + 1;
+		     *copyfrom && *copyfrom !=3D ':';
+		     copyfrom++) {
+			char ch =3D *copyfrom;
+
+			if (!is_pathspec_magic(ch))
+				break;
+			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
+				if (pathspec_magic[i].mnemonic =3D=3D ch) {
+					magic |=3D pathspec_magic[i].bit;
+					break;
+				}
+			if (ARRAY_SIZE(pathspec_magic) <=3D i)
+				die("Unimplemented pathspec magic '%c' in '%s'",
+				    ch, elt);
+		}
+		if (*copyfrom =3D=3D ':')
+			copyfrom++;
+	}
+
+	if (magic & PATHSPEC_FROMTOP)
+		return xstrdup(copyfrom);
+	else
+		return prefix_path(prefix, prefixlen, copyfrom);
+}
+
+/*
+ * N.B. get_pathspec() is deprecated in favor of the "struct pathspec"
+ * based interface - see pathspec_magic above.
+ *
+ * Arguments:
+ *  - prefix - a path relative to the root of the working tree
+ *  - pathspec - a list of paths underneath the prefix path
+ *
+ * Iterates over pathspec, prepending each path with prefix,
+ * and return the resulting list.
+ *
+ * If pathspec is empty, return a singleton list containing prefix.
+ *
+ * If pathspec and prefix are both empty, return an empty list.
+ *
+ * This is typically used by built-in commands such as add.c, in order
+ * to normalize argv arguments provided to the built-in into a list of
+ * paths to process, all relative to the root of the working tree.
+ */
+const char **get_pathspec(const char *prefix, const char **pathspec)
+{
+	const char *entry =3D *pathspec;
+	const char **src, **dst;
+	int prefixlen;
+
+	if (!prefix && !entry)
+		return NULL;
+
+	if (!entry) {
+		static const char *spec[2];
+		spec[0] =3D prefix;
+		spec[1] =3D NULL;
+		return spec;
+	}
+
+	/* Otherwise we have to re-write the entries.. */
+	src =3D pathspec;
+	dst =3D pathspec;
+	prefixlen =3D prefix ? strlen(prefix) : 0;
+	while (*src) {
+		*(dst++) =3D prefix_pathspec(prefix, prefixlen, *src);
+		src++;
+	}
+	*dst =3D NULL;
+	if (!*pathspec)
+		return NULL;
+	return pathspec;
+}
diff --git a/pathspec.h b/pathspec.h
index db0184a..7884068 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -1,6 +1,27 @@
 #ifndef PATHSPEC_H
 #define PATHSPEC_H
=20
+#define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
+
+struct pathspec {
+	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
+	int nr;
+	unsigned int has_wildcard:1;
+	unsigned int recursive:1;
+	int max_depth;
+	struct pathspec_item {
+		const char *match;
+		int len;
+		int nowildcard_len;
+		int flags;
+	} *items;
+};
+
+extern int init_pathspec(struct pathspec *, const char **);
+extern void free_pathspec(struct pathspec *);
+
+extern int limit_pathspec_to_literal(void);
+
 extern char *find_pathspecs_matching_against_index(const char **pathsp=
ec);
 extern void add_pathspec_matches_against_index(const char **pathspec, =
char *seen, int specs);
 extern const char *check_path_for_gitlink(const char *path);
diff --git a/preload-index.c b/preload-index.c
index 49cb08d..cddfffa 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2008 Linus Torvalds
  */
 #include "cache.h"
+#include "pathspec.h"
=20
 #ifdef NO_PTHREADS
 static void preload_index(struct index_state *index, const char **path=
spec)
diff --git a/setup.c b/setup.c
index 94c1e61..d1ece5d 100644
--- a/setup.c
+++ b/setup.c
@@ -154,155 +154,6 @@ void verify_non_filename(const char *prefix, cons=
t char *arg)
 	    "'git <command> [<revision>...] -- [<file>...]'", arg);
 }
=20
-/*
- * Magic pathspec
- *
- * NEEDSWORK: These need to be moved to dir.h or even to a new
- * pathspec.h when we restructure get_pathspec() users to use the
- * "struct pathspec" interface.
- *
- * Possible future magic semantics include stuff like:
- *
- *	{ PATHSPEC_NOGLOB, '!', "noglob" },
- *	{ PATHSPEC_ICASE, '\0', "icase" },
- *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
- *	{ PATHSPEC_REGEXP, '\0', "regexp" },
- *
- */
-#define PATHSPEC_FROMTOP    (1<<0)
-
-static struct pathspec_magic {
-	unsigned bit;
-	char mnemonic; /* this cannot be ':'! */
-	const char *name;
-} pathspec_magic[] =3D {
-	{ PATHSPEC_FROMTOP, '/', "top" },
-};
-
-/*
- * Take an element of a pathspec and check for magic signatures.
- * Append the result to the prefix.
- *
- * For now, we only parse the syntax and throw out anything other than
- * "top" magic.
- *
- * NEEDSWORK: This needs to be rewritten when we start migrating
- * get_pathspec() users to use the "struct pathspec" interface.  For
- * example, a pathspec element may be marked as case-insensitive, but
- * the prefix part must always match literally, and a single stupid
- * string cannot express such a case.
- */
-static const char *prefix_pathspec(const char *prefix, int prefixlen, =
const char *elt)
-{
-	unsigned magic =3D 0;
-	const char *copyfrom =3D elt;
-	int i;
-
-	if (elt[0] !=3D ':') {
-		; /* nothing to do */
-	} else if (elt[1] =3D=3D '(') {
-		/* longhand */
-		const char *nextat;
-		for (copyfrom =3D elt + 2;
-		     *copyfrom && *copyfrom !=3D ')';
-		     copyfrom =3D nextat) {
-			size_t len =3D strcspn(copyfrom, ",)");
-			if (copyfrom[len] =3D=3D ',')
-				nextat =3D copyfrom + len + 1;
-			else
-				/* handle ')' and '\0' */
-				nextat =3D copyfrom + len;
-			if (!len)
-				continue;
-			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
-				if (strlen(pathspec_magic[i].name) =3D=3D len &&
-				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
-					magic |=3D pathspec_magic[i].bit;
-					break;
-				}
-			if (ARRAY_SIZE(pathspec_magic) <=3D i)
-				die("Invalid pathspec magic '%.*s' in '%s'",
-				    (int) len, copyfrom, elt);
-		}
-		if (*copyfrom !=3D ')')
-			die("Missing ')' at the end of pathspec magic in '%s'", elt);
-		copyfrom++;
-	} else {
-		/* shorthand */
-		for (copyfrom =3D elt + 1;
-		     *copyfrom && *copyfrom !=3D ':';
-		     copyfrom++) {
-			char ch =3D *copyfrom;
-
-			if (!is_pathspec_magic(ch))
-				break;
-			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
-				if (pathspec_magic[i].mnemonic =3D=3D ch) {
-					magic |=3D pathspec_magic[i].bit;
-					break;
-				}
-			if (ARRAY_SIZE(pathspec_magic) <=3D i)
-				die("Unimplemented pathspec magic '%c' in '%s'",
-				    ch, elt);
-		}
-		if (*copyfrom =3D=3D ':')
-			copyfrom++;
-	}
-
-	if (magic & PATHSPEC_FROMTOP)
-		return xstrdup(copyfrom);
-	else
-		return prefix_path(prefix, prefixlen, copyfrom);
-}
-
-/*
- * N.B. get_pathspec() is deprecated in favor of the "struct pathspec"
- * based interface - see pathspec_magic above.
- *
- * Arguments:
- *  - prefix - a path relative to the root of the working tree
- *  - pathspec - a list of paths underneath the prefix path
- *
- * Iterates over pathspec, prepending each path with prefix,
- * and return the resulting list.
- *
- * If pathspec is empty, return a singleton list containing prefix.
- *
- * If pathspec and prefix are both empty, return an empty list.
- *
- * This is typically used by built-in commands such as add.c, in order
- * to normalize argv arguments provided to the built-in into a list of
- * paths to process, all relative to the root of the working tree.
- */
-const char **get_pathspec(const char *prefix, const char **pathspec)
-{
-	const char *entry =3D *pathspec;
-	const char **src, **dst;
-	int prefixlen;
-
-	if (!prefix && !entry)
-		return NULL;
-
-	if (!entry) {
-		static const char *spec[2];
-		spec[0] =3D prefix;
-		spec[1] =3D NULL;
-		return spec;
-	}
-
-	/* Otherwise we have to re-write the entries.. */
-	src =3D pathspec;
-	dst =3D pathspec;
-	prefixlen =3D prefix ? strlen(prefix) : 0;
-	while (*src) {
-		*(dst++) =3D prefix_pathspec(prefix, prefixlen, *src);
-		src++;
-	}
-	*dst =3D NULL;
-	if (!*pathspec)
-		return NULL;
-	return pathspec;
-}
=20
 /*
  * Test if it looks like we're at a git directory.
diff --git a/tree-walk.c b/tree-walk.c
index 6e30ef9..72a9613 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -3,6 +3,7 @@
 #include "unpack-trees.h"
 #include "dir.h"
 #include "tree.h"
+#include "pathspec.h"
=20
 static const char *get_mode(const char *str, unsigned int *modep)
 {
--=20
1.8.2.83.gc99314b
