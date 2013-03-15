From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 03/45] Move struct pathspec and related functions to pathspec.[ch]
Date: Fri, 15 Mar 2013 13:06:18 +0700
Message-ID: <1363327620-29017-4-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:24:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO4S-0003hE-9p
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab3COGYZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:24:25 -0400
Received: from mail-ia0-f181.google.com ([209.85.210.181]:45515 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab3COGYY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:24:24 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so606641iad.40
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+WntS/eSioGV8zIsv/HfgH8Hzc9sH98qL6thIO1Gfeo=;
        b=Y44NH3mj69JqMELJlnBRMmkvsnPgzsWx1jmIHD+b4usAqqmcxhRjapjtF5tTKvajt5
         XCfKLO99zV6GI1HapayM2+LSN6/Pg/4Mf1sXsyyORyt6wyGu3tuD2DJ2WcDy8GYU3jCF
         Bcu8zWBq5q549oN1Y9IbdfneoGZmED3KLSzlISZWvFmVY7MJrCp7ZqCsfNtL11y2YK8G
         mTw+XrVgp13utUKb/wgsE4KIyvRSmiWKbE9IcqtM9Kapc6PPog7MvmkH2m4yX6EfF21S
         gCXeeN2f1k5tn5UheZXv2FxZ8f1RYayU6f5S3bG7s61ubt2Hl5DVQ6V2VoRb1G67LGn6
         uzGg==
X-Received: by 10.50.155.134 with SMTP id vw6mr341015igb.34.1363328664208;
        Thu, 14 Mar 2013 23:24:24 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id a3sm745152igq.5.2013.03.14.23.24.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:24:23 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:07:21 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218190>


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
 pathspec.c             | 149 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 pathspec.h             |  21 +++++++
 preload-index.c        |   1 +
 setup.c                | 149 -----------------------------------------=
--------
 tree-walk.c            |   1 +
 13 files changed, 181 insertions(+), 169 deletions(-)

diff --git a/archive.c b/archive.c
index 93e00bb..72c6b0f 100644
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
index 8025964..3701c2e 100644
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
index 175e6e3..752570b 100644
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
index ada1dff..ffae585 100644
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
index e493563..5115c1b 100644
--- a/cache.h
+++ b/cache.h
@@ -182,6 +182,8 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
=20
+struct pathspec;
+
 /*
  * Copy the sha1 and stat state of a cache entry from one to
  * another. But we never change the name, or the hash state!
@@ -474,28 +476,8 @@ extern int index_name_is_other(const struct index_=
state *, const char *, int);
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
index 57394e4..97ad45b 100644
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
index 284f397..aa3e4d0 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -99,3 +99,152 @@ void die_if_path_beyond_symlink(const char *path, c=
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
+			if (copyfrom[len] =3D=3D ')')
+				nextat =3D copyfrom + len;
+			else
+				nextat =3D copyfrom + len + 1;
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
index d0cd784..acdc634 100644
--- a/setup.c
+++ b/setup.c
@@ -155,155 +155,6 @@ void verify_non_filename(const char *prefix, cons=
t char *arg)
 }
=20
 /*
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
-			if (copyfrom[len] =3D=3D ')')
-				nextat =3D copyfrom + len;
-			else
-				nextat =3D copyfrom + len + 1;
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
-
-/*
  * Test if it looks like we're at a git directory.
  * We want to see:
  *
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
1.8.0.rc0.19.g7bbb31d
