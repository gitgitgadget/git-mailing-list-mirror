From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/14] ls-files: support "sparse patterns", used to form sparse checkout areas
Date: Sat, 20 Sep 2008 17:01:49 +0700
Message-ID: <1221904913-25887-11-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <1221904913-25887-3-git-send-email-pclouds@gmail.com>
 <1221904913-25887-4-git-send-email-pclouds@gmail.com>
 <1221904913-25887-5-git-send-email-pclouds@gmail.com>
 <1221904913-25887-6-git-send-email-pclouds@gmail.com>
 <1221904913-25887-7-git-send-email-pclouds@gmail.com>
 <1221904913-25887-8-git-send-email-pclouds@gmail.com>
 <1221904913-25887-9-git-send-email-pclouds@gmail.com>
 <1221904913-25887-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzKP-0001Ll-3r
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbYITKD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbYITKD1
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:03:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:14530 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYITKDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:03:25 -0400
Received: by rv-out-0506.google.com with SMTP id k40so808445rvb.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MBqWkay9L84JSbB9fxFEg7Sd/t8PRDgbWRh/y03UcPI=;
        b=ODBiCwTEJKurAQJK92tl8TkS65f3Xg8kAe4nAMpDK3cG8eOiUdeAB/FRoUhdVG1n7c
         kimll9HWdYSD00ZBmKlqGMBiurjy/t/IJ3ssbK48olMo7H4hQAdvkwSVI52qsTK4qGlR
         gZEATnMtzFIkuEqi2iUtdpMK6/Y/u/Oov3N+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kQ/HrSqo5DiKf6L/0Xkej7g9ec056jqmc2Fye1SQ2uHu99Gi1Np4C54VLOYMO7F9WY
         0/ykk9/jmtA524g0or63+i53u414AGLi5A04FM9EOtMBSZOxcWOYDXSxDO0HUkbZ8mMh
         1XhPo3BQjIz15fjqmEFlfbNfzjPy3qH8yOWgM=
Received: by 10.141.37.8 with SMTP id p8mr614623rvj.256.1221905005288;
        Sat, 20 Sep 2008 03:03:25 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id k41sm2544930rvb.9.2008.09.20.03.03.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:03:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:03:13 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-10-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96348>

This implements sparse patterns and adds --narrow-match option in order
to test the patterns.

Sparse patterns are basically like .gitignore patterns, but they can be
combined in one line, separating by colons like $PATH.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt   |   45 +++++++++++++
 Documentation/git-ls-files.txt   |    8 ++-
 builtin-ls-files.c               |   21 +++++-
 t/t3003-ls-files-narrow-match.sh |   39 +++++++++++
 t/t3003/1                        |    3 +
 t/t3003/12                       |    6 ++
 t/t3003/clone-escape             |    4 +
 t/t3003/cur-12                   |    2 +
 t/t3003/root-sub-1               |    1 +
 t/t3003/slash-1                  |    1 +
 t/t3003/sub-1                    |    2 +
 t/t3003/sub-only                 |    3 +
 t/t3003/subsub-slash             |    3 +
 unpack-trees.c                   |  136 ++++++++++++++++++++++++++++++=
++++++++
 unpack-trees.h                   |   18 +++++
 15 files changed, 288 insertions(+), 4 deletions(-)
 create mode 100755 t/t3003-ls-files-narrow-match.sh
 create mode 100644 t/t3003/1
 create mode 100644 t/t3003/12
 create mode 100644 t/t3003/clone-escape
 create mode 100644 t/t3003/cur-12
 create mode 100644 t/t3003/root-sub-1
 create mode 100644 t/t3003/slash-1
 create mode 100644 t/t3003/sub
 create mode 100644 t/t3003/sub-1
 create mode 100644 t/t3003/sub-only
 create mode 100644 t/t3003/subsub-slash

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 2b344e1..d6f94a6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -205,6 +205,51 @@ is "assume unchanged" bit just ignores correspondi=
ng files in working
 directory while sparse checkout goes a bit farther, remove those files
 when it is safe to do so.
=20
+Sparse patterns
+---------------
+
+Sparse patterns specify how do you want to form your checkout area.
+Many patterns can be specified on one line, separated by colons.
+The patterns specify what files should or should not be checked out
+on working directory (depends on the option used with the patterns).
+Patterns have the following format:
+
+ - An optional prefix '!' which negates the pattern; any
+   matching file by a previous pattern will become
+   unmatched again.  If a negated pattern matches, this will
+   override lower precedence patterns sources.
+
+ - If the pattern ends with a slash, it is removed for the
+   purpose of the following description, but it would only find
+   a match with a directory.  In other words, `foo/` will match a
+   directory `foo` and paths underneath it, but will not match a
+   regular file or a symbolic link `foo` (this is consistent
+   with the way how pathspec works in general in git).
+
+ - If the pattern does not contain a slash '/', git treats it as
+   a shell glob pattern and checks for a match against the
+   pathname without leading directories.
+
+ - Otherwise, git treats the pattern as a shell glob suitable
+   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
+   wildcards in the pattern will not match a / in the pathname.
+   For example, "Documentation/\*.html" matches
+   "Documentation/git.html" but not
+   "Documentation/ppc/ppc.html".  A leading slash matches the
+   beginning of the pathname; for example, "/*.c" matches
+   "cat-file.c" but not "mozilla-sha1/sha1.c".
+
+ - Patterns begin with a slash will match against full pathname,
+   as opposed to normal case when it only matches pathnames relative
+   to current working directory.
+
+ - Patterns begin with "./" are treated like normal patterns. That is
+   it will follow above rules. But since it has a slash inside,
+   "fnmatch rule" will apply. This is a work-around when you do not
+   want to apply "no slash" rule.
+
+ - Because colons are used to separate patterns, you cannot put them
+   in patterns directly. You must quote them using backslash.
=20
 EXAMPLES
 --------
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index 1de68e2..fbed73b 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git ls-files' [-z] [-t] [-v]
 		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified|orp=
haned|no-checkout])\*
 		(-[c|d|o|i|s|u|k|m])\*
-		[--sparse]
+		[--sparse] [--narrow-match=3D<sparse patterns>]
 		[-x <pattern>|--exclude=3D<pattern>]
 		[-X <file>|--exclude-from=3D<file>]
 		[--exclude-per-directory=3D<file>]
@@ -90,6 +90,12 @@ OPTIONS
 	No-checkout entries can be shown using --orphaned or
 	--no-checkout (or both).
=20
+--narrow-match=3D<sparse patterns>::
+	This option can be used to test sparse patterns. The given sparse pat=
terns will
+	be used to filter ls-files output. Entries not matching the spec will=
 be
+	ignored. This option can only be used with --cached or --stage.
+	See linkgit:git-checkout[1] for more information about sparse pattern=
s.
+
 -z::
 	\0 line termination on output.
=20
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 873de15..1c81022 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -10,6 +10,8 @@
 #include "dir.h"
 #include "builtin.h"
 #include "tree.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -31,6 +33,7 @@ static const char **pathspec;
 static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
+static struct narrow_spec *narrow_spec;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -187,7 +190,7 @@ static void show_ce_entry(const char *tag, struct c=
ache_entry *ce)
 	int len =3D prefix_len;
 	int offset =3D prefix_offset;
=20
-	if (len >=3D ce_namelen(ce))
+	if (len >=3D ce_namelen(ce) && !narrow_spec)
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
 	if (pathspec && !pathspec_match(pathspec, ps_matched, ce->name, len))
@@ -260,6 +263,8 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 			}
 			if (!(show_cached | show_stage))
 				continue;
+			if (narrow_spec && !match_narrow_spec(narrow_spec, ce->name))
+				continue;
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
@@ -439,7 +444,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, int prefix_
=20
 static const char ls_files_usage[] =3D
 	"git ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged=
|killed|modified|orphaned|no-checkout])* "
-	"[ --sparse ] "
+	"[ --sparse ] [--narrow-match=3D<narrow_spec>] "
 	"[ --ignored ] [--exclude=3D<pattern>] [--exclude-from=3D<file>] "
 	"[ --exclude-per-directory=3D<filename> ] [--exclude-standard] "
 	"[--full-name] [--abbrev] [--] [<file>]*";
@@ -498,6 +503,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 			sparse_checkout =3D 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--narrow-match=3D")) {
+			narrow_spec =3D parse_narrow_spec(arg+15, prefix);
+			continue;
+		}
 		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
 			show_deleted =3D 1;
 			continue;
@@ -629,8 +638,14 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 	      show_killed | show_modified | show_orphaned | show_no_checkout)=
)
 		show_cached =3D 1;
=20
+	if (narrow_spec && !show_cached && !show_stage)
+		die("ls-files: --narrow-match can only be used with either --cached =
or --stage");
+
+	if (narrow_spec && narrow_spec->has_root && prefix_offset !=3D 0)
+		die("ls-files: --narrow-match with root matching patterns requires -=
-full-name");
+
 	read_cache();
-	if (prefix)
+	if (prefix && (!narrow_spec || !narrow_spec->has_root))
 		prune_cache(prefix);
 	if (with_tree) {
 		/*
diff --git a/t/t3003-ls-files-narrow-match.sh b/t/t3003-ls-files-narrow=
-match.sh
new file mode 100755
index 0000000..5611cab
--- /dev/null
+++ b/t/t3003-ls-files-narrow-match.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description=3D'This test is for narrow spec matching'
+
+. test-lib.sh
+
+D=3D"$(cd ..;pwd)"/t3003
+
+test_pattern() {
+	test_expect_success "pattern $1" '
+		(
+		if [ -n "'$3'" ]; then cd '$3'; fi
+		git ls-files --full-name --narrow-match=3D"'"$2"'" > result &&
+		diff -u result "'"$D/$1"'"
+		)
+	'
+}
+
+test_expect_success 'setup' '
+	touch 1 2 3 "1:2" &&
+	mkdir -p sub/subsub &&
+	touch sub/1 sub/2 sub/3 &&
+	touch sub/subsub/1 sub/subsub/2 sub/subsub/3 &&
+	git add .
+'
+
+test_pattern 1 1
+test_pattern sub sub
+test_pattern sub-1 1 sub
+test_pattern root-sub-1 /1 sub
+test_pattern subsub-slash subsub/ sub
+test_pattern sub-only 'sub/:!sub/subsub/'
+test_pattern 12 1:2
+test_pattern cur-12 ./1:./2
+test_pattern slash-1 'sub/*1'
+test_pattern clone-escape '1\:2:1'
+
+test_done
+
diff --git a/t/t3003/1 b/t/t3003/1
new file mode 100644
index 0000000..9b73321
--- /dev/null
+++ b/t/t3003/1
@@ -0,0 +1,3 @@
+1
+sub/1
+sub/subsub/1
diff --git a/t/t3003/12 b/t/t3003/12
new file mode 100644
index 0000000..5d71811
--- /dev/null
+++ b/t/t3003/12
@@ -0,0 +1,6 @@
+1
+2
+sub/1
+sub/2
+sub/subsub/1
+sub/subsub/2
diff --git a/t/t3003/clone-escape b/t/t3003/clone-escape
new file mode 100644
index 0000000..11cdf68
--- /dev/null
+++ b/t/t3003/clone-escape
@@ -0,0 +1,4 @@
+1
+1:2
+sub/1
+sub/subsub/1
diff --git a/t/t3003/cur-12 b/t/t3003/cur-12
new file mode 100644
index 0000000..1191247
--- /dev/null
+++ b/t/t3003/cur-12
@@ -0,0 +1,2 @@
+1
+2
diff --git a/t/t3003/root-sub-1 b/t/t3003/root-sub-1
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/t/t3003/root-sub-1
@@ -0,0 +1 @@
+1
diff --git a/t/t3003/slash-1 b/t/t3003/slash-1
new file mode 100644
index 0000000..5798e42
--- /dev/null
+++ b/t/t3003/slash-1
@@ -0,0 +1 @@
+sub/1
diff --git a/t/t3003/sub b/t/t3003/sub
new file mode 100644
index 0000000..e69de29
diff --git a/t/t3003/sub-1 b/t/t3003/sub-1
new file mode 100644
index 0000000..3ef951a
--- /dev/null
+++ b/t/t3003/sub-1
@@ -0,0 +1,2 @@
+sub/1
+sub/subsub/1
diff --git a/t/t3003/sub-only b/t/t3003/sub-only
new file mode 100644
index 0000000..3115212
--- /dev/null
+++ b/t/t3003/sub-only
@@ -0,0 +1,3 @@
+sub/1
+sub/2
+sub/3
diff --git a/t/t3003/subsub-slash b/t/t3003/subsub-slash
new file mode 100644
index 0000000..bc585b0
--- /dev/null
+++ b/t/t3003/subsub-slash
@@ -0,0 +1,3 @@
+sub/subsub/1
+sub/subsub/2
+sub/subsub/3
diff --git a/unpack-trees.c b/unpack-trees.c
index e59d144..ce4c826 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -726,6 +726,142 @@ static void show_stage_entry(FILE *o,
 }
 #endif
=20
+struct narrow_spec *parse_narrow_spec(const char *spec, const char *pr=
efix)
+{
+	struct narrow_spec *ns;
+	struct narrow_pattern *p;
+	const char *start =3D spec, *end;
+	int has_wildcards, has_slashes;
+
+	ns =3D xmalloc(sizeof(*ns));
+	memset(ns, 0, sizeof(*ns));
+	if (prefix)
+		ns->prefix =3D xstrdup(prefix);
+
+	while (*start) {
+		end =3D start;
+		has_slashes =3D has_wildcards =3D 0;
+		while (*end && *end !=3D ':') {
+			if (*end =3D=3D '*' || *end =3D=3D '[' || *end =3D=3D '?')
+				has_wildcards =3D 1;
+			if (*end =3D=3D '/')
+				has_slashes =3D 1;
+			if (*end =3D=3D '\\') {
+				end++;
+				has_wildcards =3D 1;
+				if (*end =3D=3D '\0') /* trailing backslash */
+					break;
+			}
+			end++;
+		}
+		if (start =3D=3D end)
+			continue;
+
+		p =3D xmalloc(offsetof(struct narrow_pattern, pattern)+(end-start)+1=
);
+		p->negative =3D *start =3D=3D '!';
+		if (p->negative)
+			start++;
+		p->has_slashes =3D has_slashes;
+		p->has_wildcards =3D has_wildcards;
+		p->has_trailing_slash =3D end[-1] =3D=3D '/';
+		p->has_root =3D *start =3D=3D '/';
+		if (p->has_root)
+			start++;
+		else if (*start =3D=3D '.' && start[1] =3D=3D '/')
+			start +=3D 2;
+		p->len =3D end-start;
+		memcpy(p->pattern, start, p->len);
+		p->pattern[p->len] =3D '\0';
+
+		ALLOC_GROW(ns->patterns, ns->nr + 1, ns->alloc);
+		ns->patterns[ns->nr++] =3D p;
+		ns->has_root |=3D p->has_root;
+
+		if (*end !=3D ':')
+			break;
+		start =3D end + 1;
+	}
+	return ns;
+}
+
+int match_narrow_spec(struct narrow_spec *spec, const char *path)
+{
+	int i, prefix_len =3D 0;
+
+	if (!spec || !spec->nr)
+		return 1; /* always match if spec is NULL */
+
+	if (spec->prefix) {
+		/*
+		 * optimization:
+		 * if there is no pattern with leading slash
+		 * then it is safe to only match inside prefix
+		 */
+		if (!spec->has_root && prefixcmp(path, spec->prefix))
+			return 0;
+		prefix_len =3D strlen(spec->prefix);
+	}
+
+	for (i =3D spec->nr - 1;i >=3D 0; i--) {
+		struct narrow_pattern *p =3D spec->patterns[i];
+		const char *new_path =3D path + prefix_len;
+		int match;
+
+		if (p->has_root)
+			new_path =3D path; /* match full path */
+		else if (spec->has_root) {
+			if (prefixcmp(path, spec->prefix))
+				continue;
+		}
+		/* !spec->has_root case has been handled above */
+
+		if (p->has_trailing_slash) {
+			/* the only "wildcard" here is backslash escape */
+			if (p->has_wildcards) {
+				char *unescaped_pattern =3D xstrdup(p->pattern);
+				char *src, *dst;
+
+				src =3D dst =3D unescaped_pattern;
+				while (*src) {
+					if (*src =3D=3D '\\')
+						src++;
+					if (src !=3D dst)
+						*dst =3D *src;
+					src++;
+					dst++;
+				}
+				*dst =3D '\0';
+				match =3D prefixcmp(new_path, unescaped_pattern) =3D=3D 0;
+				free(unescaped_pattern);
+			}
+			else
+				match =3D prefixcmp(new_path, p->pattern) =3D=3D 0;
+		}
+		else if (p->has_slashes) {
+			if (p->has_wildcards)
+				match =3D fnmatch(p->pattern, new_path, FNM_PATHNAME) =3D=3D 0;
+			else
+				match =3D strcmp(p->pattern, new_path) =3D=3D 0;
+		}
+		else {
+			const char *basename =3D strrchr(path + prefix_len, '/');
+			if (basename)
+				basename++;
+			else
+				basename =3D path + prefix_len;
+			if (p->has_wildcards)
+				match =3D fnmatch(p->pattern, basename, 0) =3D=3D 0;
+			else
+				match =3D strcmp(p->pattern, basename) =3D=3D 0;
+		}
+		if (match)
+			return p->negative ? 0 : 1;
+	}
+
+	/* no pattern is matched */
+	return 0;
+}
+
 int threeway_merge(struct cache_entry **stages, struct unpack_trees_op=
tions *o)
 {
 	struct cache_entry *index;
diff --git a/unpack-trees.h b/unpack-trees.h
index 0d26f3d..6b1971f 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -16,6 +16,22 @@ struct unpack_trees_error_msgs {
 	const char *bind_overlap;
 };
=20
+struct narrow_spec {
+	int nr;
+	int alloc;
+	int has_root:1;
+	const char *prefix;
+	struct narrow_pattern {
+		int len;
+		int has_root:1;
+		int has_slashes:1;
+		int has_wildcards:1;
+		int has_trailing_slash:1;
+		int negative:1;
+		char pattern[FLEX_ARRAY];
+	} **patterns;
+};
+
 struct unpack_trees_options {
 	unsigned int reset:1,
 		     merge:1,
@@ -48,6 +64,8 @@ struct unpack_trees_options {
 extern int unpack_trees(unsigned n, struct tree_desc *t,
 		struct unpack_trees_options *options);
=20
+struct narrow_spec *parse_narrow_spec(const char *spec, const char *pr=
efix);
+int match_narrow_spec(struct narrow_spec *spec, const char *path);
 int threeway_merge(struct cache_entry **stages, struct unpack_trees_op=
tions *o);
 int twoway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o);
 int bind_merge(struct cache_entry **src, struct unpack_trees_options *=
o);
--=20
1.6.0.96.g2fad1.dirty
