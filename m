From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 46/46] parse_pathspec: accept :(icase)path syntax
Date: Sun, 14 Jul 2013 15:36:09 +0700
Message-ID: <1373790969-13000-47-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:40:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHrR-0003xj-6O
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab3GNIkt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:40:49 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63913 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab3GNIks (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:40:48 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so9944496pdj.28
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=z784eLjYaWaB20Gl08ZZbIvESCvqCAZOd3G7mCU9o1E=;
        b=h6CKisRxu/f4eKxygOja9HkAPJufHR7ro5udi3CHiZSxtBrW+i/kQotebeB8nJ+jKQ
         ZyAs90HuVuqtdB3eIBqYO3vJENrpM24wZg0i5IR9m3VQCrF+y0oJkUKn/1CP9GJdyNQk
         KFoLRsvq0vd7oTZl9sbzV5XemQ7aD3iC6EAc3UU04oOo3dBK176phq+mdbZDx1jr88p1
         rfob/8+0TWCEKxm+QjcVCVRFWX3YSV+jAYBeI3V/bfAROnes2FJes2W2yK/lkJ3MzqfU
         mBeksnSN95rapO0jI3HxEBX+bO+7++8AxdT9EM+Zt694KJ+e7uS24SipPC/cM7hC4PhK
         Wa1w==
X-Received: by 10.68.252.194 with SMTP id zu2mr48757350pbc.58.1373791247630;
        Sun, 14 Jul 2013 01:40:47 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id td4sm57803214pac.20.2013.07.14.01.40.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:40:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:40:59 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230358>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt              |  8 ++++
 Documentation/glossary-content.txt |  3 ++
 builtin/add.c                      |  6 ++-
 builtin/ls-tree.c                  |  2 +-
 cache.h                            |  1 +
 dir.c                              | 74 ++++++++++++++++++++++++-----
 git.c                              |  4 ++
 pathspec.c                         |  9 +++-
 pathspec.h                         | 22 ++++++++-
 t/t6131-pathspec-icase.sh (new +x) | 97 ++++++++++++++++++++++++++++++=
++++++++
 tree-walk.c                        | 59 ++++++++++++++++++-----
 11 files changed, 257 insertions(+), 28 deletions(-)
 create mode 100755 t/t6131-pathspec-icase.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3571a1b..546eea4 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -466,6 +466,10 @@ help ...`.
 	globbing on individual pathspecs can be done using pathspec
 	magic ":(glob)"
=20
+--icase-pathspecs:
+	Add "icase" magic to all pathspec. This is equivalent to setting
+	the `GIT_ICASE_PATHSPECS` environment variable to `1`.
+
 GIT COMMANDS
 ------------
=20
@@ -879,6 +883,10 @@ GIT_NOGLOB_PATHSPECS::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs as literal (aka "literal" magic).
=20
+GIT_ICASE_PATHSPECS::
+	Setting this variable to `1` will cause Git to treat all
+	pathspeccs as case-insensitive.
+
=20
 Discussion[[Discussion]]
 ------------------------
diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index a3d9029..13a64d3 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -334,6 +334,9 @@ literal;;
 	Wildcards in the pattern such as `*` or `?` are treated
 	as literal characters.
=20
+icase;;
+	Case insensitive match.
+
 glob;;
 	Git treats the pattern as a shell glob suitable for
 	consumption by fnmatch(3) with the FNM_PATHNAME flag:
diff --git a/builtin/add.c b/builtin/add.c
index 1dab246..9d52fc7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -544,12 +544,14 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		GUARD_PATHSPEC(&pathspec,
 			       PATHSPEC_FROMTOP |
 			       PATHSPEC_LITERAL |
-			       PATHSPEC_GLOB);
+			       PATHSPEC_GLOB |
+			       PATHSPEC_ICASE);
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
 			if (!seen[i] &&
-			    ((pathspec.items[i].magic & PATHSPEC_GLOB) ||
+			    ((pathspec.items[i].magic &
+			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
 			     !file_exists(path))) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7882352..f6d8215 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,7 +173,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec_depth() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_GLOB,
+	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
diff --git a/cache.h b/cache.h
index dc4d2ee..3cff825 100644
--- a/cache.h
+++ b/cache.h
@@ -369,6 +369,7 @@ static inline enum object_type object_type(unsigned=
 int mode)
 #define GIT_LITERAL_PATHSPECS_ENVIRONMENT "GIT_LITERAL_PATHSPECS"
 #define GIT_GLOB_PATHSPECS_ENVIRONMENT "GIT_GLOB_PATHSPECS"
 #define GIT_NOGLOB_PATHSPECS_ENVIRONMENT "GIT_NOGLOB_PATHSPECS"
+#define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
=20
 /*
  * This environment variable is expected to contain a boolean indicati=
ng
diff --git a/dir.c b/dir.c
index 076bd46..8543736 100644
--- a/dir.c
+++ b/dir.c
@@ -57,7 +57,7 @@ inline int git_fnmatch(const struct pathspec_item *it=
em,
 		       int prefix)
 {
 	if (prefix > 0) {
-		if (strncmp(pattern, string, prefix))
+		if (ps_strncmp(item, pattern, string, prefix))
 			return FNM_NOMATCH;
 		pattern +=3D prefix;
 		string +=3D prefix;
@@ -66,14 +66,18 @@ inline int git_fnmatch(const struct pathspec_item *=
item,
 		int pattern_len =3D strlen(++pattern);
 		int string_len =3D strlen(string);
 		return string_len < pattern_len ||
-		       strcmp(pattern,
-			      string + string_len - pattern_len);
+			ps_strcmp(item, pattern,
+				  string + string_len - pattern_len);
 	}
 	if (item->magic & PATHSPEC_GLOB)
-		return wildmatch(pattern, string, WM_PATHNAME, NULL);
+		return wildmatch(pattern, string,
+				 WM_PATHNAME |
+				 (item->magic & PATHSPEC_ICASE ? WM_CASEFOLD : 0),
+				 NULL);
 	else
 		/* wildmatch has not learned no FNM_PATHNAME mode yet */
-		return fnmatch(pattern, string, 0);
+		return fnmatch(pattern, string,
+			       item->magic & PATHSPEC_ICASE ? FNM_CASEFOLD : 0);
 }
=20
 static int fnmatch_icase_mem(const char *pattern, int patternlen,
@@ -110,16 +114,27 @@ static size_t common_prefix_len(const struct path=
spec *pathspec)
 	int n;
 	size_t max =3D 0;
=20
+	/*
+	 * ":(icase)path" is treated as a pathspec full of
+	 * wildcard. In other words, only prefix is considered common
+	 * prefix. If the pathspec is abc/foo abc/bar, running in
+	 * subdir xyz, the common prefix is still xyz, not xuz/abc as
+	 * in non-:(icase).
+	 */
 	GUARD_PATHSPEC(pathspec,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_MAXDEPTH |
 		       PATHSPEC_LITERAL |
-		       PATHSPEC_GLOB);
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE);
=20
 	for (n =3D 0; n < pathspec->nr; n++) {
-		size_t i =3D 0, len =3D 0;
-		while (i < pathspec->items[n].nowildcard_len &&
-		       (n =3D=3D 0 || i < max)) {
+		size_t i =3D 0, len =3D 0, item_len;
+		if (pathspec->items[n].magic & PATHSPEC_ICASE)
+			item_len =3D pathspec->items[n].prefix;
+		else
+			item_len =3D pathspec->items[n].nowildcard_len;
+		while (i < item_len && (n =3D=3D 0 || i < max)) {
 			char c =3D pathspec->items[n].match[i];
 			if (c !=3D pathspec->items[0].match[i])
 				break;
@@ -196,11 +211,44 @@ static int match_pathspec_item(const struct paths=
pec_item *item, int prefix,
 	const char *match =3D item->match + prefix;
 	int matchlen =3D item->len - prefix;
=20
+	/*
+	 * The normal call pattern is:
+	 * 1. prefix =3D common_prefix_len(ps);
+	 * 2. prune something, or fill_directory
+	 * 3. match_pathspec_depth()
+	 *
+	 * 'prefix' at #1 may be shorter than the command's prefix and
+	 * it's ok for #2 to match extra files. Those extras will be
+	 * trimmed at #3.
+	 *
+	 * Suppose the pathspec is 'foo' and '../bar' running from
+	 * subdir 'xyz'. The common prefix at #1 will be empty, thanks
+	 * to "../". We may have xyz/foo _and_ XYZ/foo after #2. The
+	 * user does not want XYZ/foo, only the "foo" part should be
+	 * case-insensitive. We need to filter out XYZ/foo here. In
+	 * other words, we do not trust the caller on comparing the
+	 * prefix part when :(icase) is involved. We do exact
+	 * comparison ourselves.
+	 *
+	 * Normally the caller (common_prefix_len() in fact) does
+	 * _exact_ matching on name[-prefix+1..-1] and we do not need
+	 * to check that part. Be defensive and check it anyway, in
+	 * case common_prefix_len is changed, or a new caller is
+	 * introduced that does not use common_prefix_len.
+	 *
+	 * If the penalty turns out too high when prefix is really
+	 * long, maybe change it to
+	 * strncmp(match, name, item->prefix - prefix)
+	 */
+	if (item->prefix && (item->magic & PATHSPEC_ICASE) &&
+	    strncmp(item->match, name - prefix, item->prefix))
+		return 0;
+
 	/* If the match was just the prefix, we matched */
 	if (!*match)
 		return MATCHED_RECURSIVELY;
=20
-	if (matchlen <=3D namelen && !strncmp(match, name, matchlen)) {
+	if (matchlen <=3D namelen && !ps_strncmp(item, match, name, matchlen)=
) {
 		if (matchlen =3D=3D namelen)
 			return MATCHED_EXACTLY;
=20
@@ -241,7 +289,8 @@ int match_pathspec_depth(const struct pathspec *ps,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_MAXDEPTH |
 		       PATHSPEC_LITERAL |
-		       PATHSPEC_GLOB);
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE);
=20
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -1301,7 +1350,8 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 			       PATHSPEC_FROMTOP |
 			       PATHSPEC_MAXDEPTH |
 			       PATHSPEC_LITERAL |
-			       PATHSPEC_GLOB);
+			       PATHSPEC_GLOB |
+			       PATHSPEC_ICASE);
=20
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
diff --git a/git.c b/git.c
index 2509675..cebf882 100644
--- a/git.c
+++ b/git.c
@@ -155,6 +155,10 @@ static int handle_options(const char ***argv, int =
*argc, int *envchanged)
 			setenv(GIT_NOGLOB_PATHSPECS_ENVIRONMENT, "1", 1);
 			if (envchanged)
 				*envchanged =3D 1;
+		} else if (!strcmp(cmd, "--icase-pathspecs")) {
+			setenv(GIT_ICASE_PATHSPECS_ENVIRONMENT, "1", 1);
+			if (envchanged)
+				*envchanged =3D 1;
 		} else if (!strcmp(cmd, "--shallow-file")) {
 			(*argv)++;
 			(*argc)--;
diff --git a/pathspec.c b/pathspec.c
index c1e6917..d9f4143 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -57,7 +57,6 @@ char *find_pathspecs_matching_against_index(const str=
uct pathspec *pathspec)
  *
  * Possible future magic semantics include stuff like:
  *
- *	{ PATHSPEC_ICASE, '\0', "icase" },
  *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
  *	{ PATHSPEC_REGEXP, '\0', "regexp" },
  *
@@ -71,6 +70,7 @@ static struct pathspec_magic {
 	{ PATHSPEC_FROMTOP, '/', "top" },
 	{ PATHSPEC_LITERAL,   0, "literal" },
 	{ PATHSPEC_GLOB,   '\0', "glob" },
+	{ PATHSPEC_ICASE,  '\0', "icase" },
 };
=20
 /*
@@ -95,6 +95,7 @@ static unsigned prefix_pathspec(struct pathspec_item =
*item,
 	static int literal_global =3D -1;
 	static int glob_global =3D -1;
 	static int noglob_global =3D -1;
+	static int icase_global =3D -1;
 	unsigned magic =3D 0, short_magic =3D 0, global_magic =3D 0;
 	const char *copyfrom =3D elt, *long_magic_end =3D NULL;
 	char *match;
@@ -116,6 +117,12 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 	if (glob_global && noglob_global)
 		die(_("global 'glob' and 'noglob' pathspec settings are incompatible=
"));
=20
+
+	if (icase_global < 0)
+		icase_global =3D git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT, 0);
+	if (icase_global)
+		global_magic |=3D PATHSPEC_ICASE;
+
 	if ((global_magic & PATHSPEC_LITERAL) &&
 	    (global_magic & ~PATHSPEC_LITERAL))
 		die(_("global 'literal' pathspec setting is incompatible "
diff --git a/pathspec.h b/pathspec.h
index cdf2fa3..04b632f 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -6,11 +6,13 @@
 #define PATHSPEC_MAXDEPTH	(1<<1)
 #define PATHSPEC_LITERAL	(1<<2)
 #define PATHSPEC_GLOB		(1<<3)
+#define PATHSPEC_ICASE		(1<<4)
 #define PATHSPEC_ALL_MAGIC	  \
 	(PATHSPEC_FROMTOP	| \
 	 PATHSPEC_MAXDEPTH	| \
 	 PATHSPEC_LITERAL	| \
-	 PATHSPEC_GLOB)
+	 PATHSPEC_GLOB		| \
+	 PATHSPEC_ICASE)
=20
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
@@ -65,6 +67,24 @@ extern void parse_pathspec(struct pathspec *pathspec=
,
 extern void copy_pathspec(struct pathspec *dst, const struct pathspec =
*src);
 extern void free_pathspec(struct pathspec *);
=20
+static inline int ps_strncmp(const struct pathspec_item *item,
+			     const char *s1, const char *s2, size_t n)
+{
+	if (item->magic & PATHSPEC_ICASE)
+		return strncasecmp(s1, s2, n);
+	else
+		return strncmp(s1, s2, n);
+}
+
+static inline int ps_strcmp(const struct pathspec_item *item,
+			    const char *s1, const char *s2)
+{
+	if (item->magic & PATHSPEC_ICASE)
+		return strcasecmp(s1, s2);
+	else
+		return strcmp(s1, s2);
+}
+
 extern char *find_pathspecs_matching_against_index(const struct pathsp=
ec *pathspec);
 extern void add_pathspec_matches_against_index(const struct pathspec *=
pathspec, char *seen);
 extern const char *check_path_for_gitlink(const char *path);
diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
new file mode 100755
index 0000000..3215eef
--- /dev/null
+++ b/t/t6131-pathspec-icase.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+
+test_description=3D'test case insensitive pathspec limiting'
+. ./test-lib.sh
+
+test_expect_success 'create commits with glob characters' '
+	test_commit bar bar &&
+	test_commit bAr bAr &&
+	test_commit BAR BAR &&
+	mkdir foo &&
+	test_commit foo/bar foo/bar &&
+	test_commit foo/bAr foo/bAr &&
+	test_commit foo/BAR foo/BAR &&
+	mkdir fOo &&
+	test_commit fOo/bar fOo/bar &&
+	test_commit fOo/bAr fOo/bAr &&
+	test_commit fOo/BAR fOo/BAR &&
+	mkdir FOO &&
+	test_commit FOO/bar FOO/bar &&
+	test_commit FOO/bAr FOO/bAr &&
+	test_commit FOO/BAR FOO/BAR
+'
+
+test_expect_success 'tree_entry_interesting matches bar' '
+	echo bar >expect &&
+	git log --format=3D%s -- "bar" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'tree_entry_interesting matches :(icase)bar' '
+	cat <<-EOF >expect &&
+	BAR
+	bAr
+	bar
+	EOF
+	git log --format=3D%s -- ":(icase)bar" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'tree_entry_interesting matches :(icase)bar with p=
refix' '
+	cat <<-EOF >expect &&
+	fOo/BAR
+	fOo/bAr
+	fOo/bar
+	EOF
+	( cd fOo && git log --format=3D%s -- ":(icase)bar" ) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'tree_entry_interesting matches :(icase)bar with e=
mpty prefix' '
+	cat <<-EOF >expect &&
+	FOO/BAR
+	FOO/bAr
+	FOO/bar
+	fOo/BAR
+	fOo/bAr
+	fOo/bar
+	foo/BAR
+	foo/bAr
+	foo/bar
+	EOF
+	( cd fOo && git log --format=3D%s -- ":(icase)../foo/bar" ) >actual &=
&
+	test_cmp expect actual
+'
+
+test_expect_success 'match_pathspec_depth matches :(icase)bar' '
+	cat <<-EOF >expect &&
+	BAR
+	bAr
+	bar
+	EOF
+	git ls-files ":(icase)bar" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'match_pathspec_depth matches :(icase)bar with pre=
fix' '
+	cat <<-EOF >expect &&
+	fOo/BAR
+	fOo/bAr
+	fOo/bar
+	EOF
+	( cd fOo && git ls-files --full-name ":(icase)bar" ) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'match_pathspec_depth matches :(icase)bar with emp=
ty prefix' '
+	cat <<-EOF >expect &&
+	bar
+	fOo/BAR
+	fOo/bAr
+	fOo/bar
+	EOF
+	( cd fOo && git ls-files --full-name ":(icase)bar" ../bar ) >actual &=
&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/tree-walk.c b/tree-walk.c
index a44f528..c366852 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -489,13 +489,25 @@ int get_tree_entry(const unsigned char *tree_sha1=
, const char *name, unsigned ch
 	return retval;
 }
=20
-static int match_entry(const struct name_entry *entry, int pathlen,
+static int match_entry(const struct pathspec_item *item,
+		       const struct name_entry *entry, int pathlen,
 		       const char *match, int matchlen,
 		       enum interesting *never_interesting)
 {
 	int m =3D -1; /* signals that we haven't called strncmp() */
=20
-	if (*never_interesting !=3D entry_not_interesting) {
+	if (item->magic & PATHSPEC_ICASE)
+		/*
+		 * "Never interesting" trick requires exact
+		 * matching. We could do something clever with inexact
+		 * matching, but it's trickier (and not to forget that
+		 * strcasecmp is locale-dependent, at least in
+		 * glibc). Just disable it for now. It can't be worse
+		 * than the wildcard's codepath of '[Tt][Hi][Is][Ss]'
+		 * pattern.
+		 */
+		*never_interesting =3D entry_not_interesting;
+	else if (*never_interesting !=3D entry_not_interesting) {
 		/*
 		 * We have not seen any match that sorts later
 		 * than the current path.
@@ -541,7 +553,7 @@ static int match_entry(const struct name_entry *ent=
ry, int pathlen,
 		 * we cheated and did not do strncmp(), so we do
 		 * that here.
 		 */
-		m =3D strncmp(match, entry->path, pathlen);
+		m =3D ps_strncmp(item, match, entry->path, pathlen);
=20
 	/*
 	 * If common part matched earlier then it is a hit,
@@ -549,15 +561,39 @@ static int match_entry(const struct name_entry *e=
ntry, int pathlen,
 	 * leading directory and is shorter than match.
 	 */
 	if (!m)
+		/*
+		 * match_entry does not check if the prefix part is
+		 * matched case-sensitively. If the entry is a
+		 * directory and part of prefix, it'll be rematched
+		 * eventually by basecmp with special treatment for
+		 * the prefix.
+		 */
 		return 1;
=20
 	return 0;
 }
=20
-static int match_dir_prefix(const char *base,
+/* :(icase)-aware string compare */
+static int basecmp(const struct pathspec_item *item,
+		   const char *base, const char *match, int len)
+{
+	if (item->magic & PATHSPEC_ICASE) {
+		int ret, n =3D len > item->prefix ? item->prefix : len;
+		ret =3D strncmp(base, match, n);
+		if (ret)
+			return ret;
+		base +=3D n;
+		match +=3D n;
+		len -=3D n;
+	}
+	return ps_strncmp(item, base, match, len);
+}
+
+static int match_dir_prefix(const struct pathspec_item *item,
+			    const char *base,
 			    const char *match, int matchlen)
 {
-	if (strncmp(base, match, matchlen))
+	if (basecmp(item, base, match, matchlen))
 		return 0;
=20
 	/*
@@ -594,7 +630,7 @@ static int match_wildcard_base(const struct pathspe=
c_item *item,
 		 */
 		if (baselen >=3D matchlen) {
 			*matched =3D matchlen;
-			return !strncmp(base, match, matchlen);
+			return !basecmp(item, base, match, matchlen);
 		}
=20
 		dirlen =3D matchlen;
@@ -607,7 +643,7 @@ static int match_wildcard_base(const struct pathspe=
c_item *item,
 		 * base ends with '/' so we are sure it really matches
 		 * directory
 		 */
-		if (strncmp(base, match, baselen))
+		if (basecmp(item, base, match, baselen))
 			return 0;
 		*matched =3D baselen;
 	} else
@@ -640,7 +676,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_MAXDEPTH |
 		       PATHSPEC_LITERAL |
-		       PATHSPEC_GLOB);
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE);
=20
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -663,7 +700,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
=20
 		if (baselen >=3D matchlen) {
 			/* If it doesn't match, move along... */
-			if (!match_dir_prefix(base_str, match, matchlen))
+			if (!match_dir_prefix(item, base_str, match, matchlen))
 				goto match_wildcards;
=20
 			if (!ps->recursive ||
@@ -679,8 +716,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		}
=20
 		/* Either there must be no base, or the base must match. */
-		if (baselen =3D=3D 0 || !strncmp(base_str, match, baselen)) {
-			if (match_entry(entry, pathlen,
+		if (baselen =3D=3D 0 || !basecmp(item, base_str, match, baselen)) {
+			if (match_entry(item, entry, pathlen,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
 				return entry_interesting;
--=20
1.8.2.83.gc99314b
