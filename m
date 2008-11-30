From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/8] Introduce "sparse patterns"
Date: Sun, 30 Nov 2008 17:54:32 +0700
Message-ID: <1228042478-1886-3-git-send-email-pclouds@gmail.com>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
 <1228042478-1886-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:56:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jyf-0005a3-BG
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbYK3KzR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2008 05:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYK3KzR
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:55:17 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:31243 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYK3KzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:55:12 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2162618wfd.4
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 02:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=7+I6ihFJ5pKwSX8hP1xHy3Fb0KnJYLCMEzHJjteEABE=;
        b=P1LuSgw0LgTLDA4BA/vSx4dR4sDGW9eRc80P3sxAz1IjR5A/vxXUQmeh8F4j//Nzkl
         JkAwQ6ALdnG0gcy8mwIbX698XiAzHFtQINHtG/eWP+e8jqK0NLtcOYDe0R5xmsnNgi1U
         5cvfmElnsV77xiTMd6McQ8g8lxQqDCoDGbnMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Yh4XxL7SIZWR57wJ8WVXUB1HflhH3FmIqvZaSelnyKR/YsiZNZFefUJEh9v6GH92vU
         EBceIqfMW7pRIve9ZDnn5n6wUs/lv4DkWIRrQg45R2croF2r5DTPSCsD15QNDb+eMZAE
         mNPWNuCD0SP/LU+VoR+JPcKQFGY/Ttkchflro=
Received: by 10.142.141.21 with SMTP id o21mr4040465wfd.270.1228042512156;
        Sun, 30 Nov 2008 02:55:12 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.32])
        by mx.google.com with ESMTPS id 24sm5187013wff.57.2008.11.30.02.55.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 02:55:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 30 Nov 2008 17:54:54 +0700
X-Mailer: git-send-email 1.6.0.3.890.g95457
In-Reply-To: <1228042478-1886-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101963>

Sparse patterns are basically .gitignore patterns, with the following
exceptions:

 - a leading slash means toplevel working directory
 - ./ will be used if you want to apply "slash in pattern" rule,
   similar to leading slash case in .gitignore
 - prefix can be specified in form prefix//pattern
 - patterns are separated by colons

"git ls-files --narrow-match" is added to test sparse patterns.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt   |   57 +++++++++++++
 Documentation/git-ls-files.txt   |    8 ++-
 builtin-ls-files.c               |   23 +++++-
 t/t3003-ls-files-narrow-match.sh |   41 +++++++++
 t/t3003/1                        |    4 +
 t/t3003/12                       |    8 ++
 t/t3003/clone-escape             |    5 +
 t/t3003/cur-12                   |    2 +
 t/t3003/prefix-sub2              |    3 +
 t/t3003/root-sub-1               |    1 +
 t/t3003/slash-1                  |    1 +
 t/t3003/sub-1                    |    2 +
 t/t3003/sub-only                 |    3 +
 t/t3003/subsub-slash             |    3 +
 unpack-trees.c                   |  170 ++++++++++++++++++++++++++++++=
++++++++
 unpack-trees.h                   |   20 +++++
 16 files changed, 347 insertions(+), 4 deletions(-)
 create mode 100755 t/t3003-ls-files-narrow-match.sh
 create mode 100644 t/t3003/1
 create mode 100644 t/t3003/12
 create mode 100644 t/t3003/clone-escape
 create mode 100644 t/t3003/cur-12
 create mode 100644 t/t3003/prefix-sub2
 create mode 100644 t/t3003/root-sub-1
 create mode 100644 t/t3003/slash-1
 create mode 100644 t/t3003/sub
 create mode 100644 t/t3003/sub-1
 create mode 100644 t/t3003/sub-only
 create mode 100644 t/t3003/subsub-slash

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index ea05a7a..0813d9f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -205,6 +205,63 @@ is "assume unchanged" bit just ignores correspondi=
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
+ - If the pattern contains two consecutive slashes '//', git uses
+   the first part of the pattern before '//' as prefix to apply
+   the pattern on, and the rest as "true" sparse pattern. The
+   pattern will be only applied if pathname has the same prefix. It
+   is the same as you apply the pattern with the current directory
+   being the extracted prefix. Prefix will always be relative to
+   top-level working directory. This could be used to if you want to
+   apply the above rule only in a specific subdirectory.
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
+ - Patterns with a leading slash will match against full pathname,
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
+
+ - Sparse patterns do not apply to .gitignore and .gitattributes
+   files. They are always checked out.
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
index 7606ce1..1b67ae2 100644
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
@@ -158,7 +161,8 @@ static void show_ce_entry(const char *tag, struct c=
ache_entry *ce)
 	int len =3D prefix_len;
 	int offset =3D prefix_offset;
=20
-	if (len >=3D ce_namelen(ce))
+	/* when narrow_spec->full_index is true, the_index is not pruned */
+	if (len >=3D ce_namelen(ce) && (!narrow_spec || !narrow_spec->full_in=
dex))
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
 	if (pathspec && !pathspec_match(pathspec, ps_matched, ce->name, len))
@@ -231,6 +235,8 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 			}
 			if (!(show_cached | show_stage))
 				continue;
+			if (narrow_spec && !match_narrow_spec(narrow_spec, ce->name))
+				continue;
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
@@ -412,7 +418,7 @@ int report_path_error(const char *ps_matched, const=
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
@@ -471,6 +477,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
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
@@ -602,8 +612,14 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 	      show_killed | show_modified | show_orphaned | show_no_checkout)=
)
 		show_cached =3D 1;
=20
+	if (narrow_spec && !show_cached && !show_stage)
+		die("ls-files: --narrow-match can only be used with either --cached =
or --stage");
+
+	if (narrow_spec && narrow_spec->full_index && prefix_offset !=3D 0)
+		die("ls-files: --narrow-match with root matching patterns requires -=
-full-name");
+
 	read_cache();
-	if (prefix)
+	if (prefix && (!narrow_spec || !narrow_spec->full_index))
 		prune_cache(prefix);
 	if (with_tree) {
 		/*
@@ -625,5 +641,6 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		return bad ? 1 : 0;
 	}
=20
+	free_narrow_spec(narrow_spec);
 	return 0;
 }
diff --git a/t/t3003-ls-files-narrow-match.sh b/t/t3003-ls-files-narrow=
-match.sh
new file mode 100755
index 0000000..9879525
--- /dev/null
+++ b/t/t3003-ls-files-narrow-match.sh
@@ -0,0 +1,41 @@
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
+	touch ./1 ./2 ./3 ./"1:2" &&
+	mkdir -p sub/subsub sub2 &&
+	touch sub/1 sub/2 sub/3 &&
+	touch sub2/1 sub2/2 sub2/3 &&
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
+test_pattern prefix-sub2 1:sub2//2 sub
+
+test_done
+
diff --git a/t/t3003/1 b/t/t3003/1
new file mode 100644
index 0000000..4c7381e
--- /dev/null
+++ b/t/t3003/1
@@ -0,0 +1,4 @@
+1
+sub/1
+sub/subsub/1
+sub2/1
diff --git a/t/t3003/12 b/t/t3003/12
new file mode 100644
index 0000000..0eeb4b8
--- /dev/null
+++ b/t/t3003/12
@@ -0,0 +1,8 @@
+1
+2
+sub/1
+sub/2
+sub/subsub/1
+sub/subsub/2
+sub2/1
+sub2/2
diff --git a/t/t3003/clone-escape b/t/t3003/clone-escape
new file mode 100644
index 0000000..31f866e
--- /dev/null
+++ b/t/t3003/clone-escape
@@ -0,0 +1,5 @@
+1
+1:2
+sub/1
+sub/subsub/1
+sub2/1
diff --git a/t/t3003/cur-12 b/t/t3003/cur-12
new file mode 100644
index 0000000..1191247
--- /dev/null
+++ b/t/t3003/cur-12
@@ -0,0 +1,2 @@
+1
+2
diff --git a/t/t3003/prefix-sub2 b/t/t3003/prefix-sub2
new file mode 100644
index 0000000..27c415c
--- /dev/null
+++ b/t/t3003/prefix-sub2
@@ -0,0 +1,3 @@
+sub/1
+sub/subsub/1
+sub2/2
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
index 54f301d..83888ae 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -726,6 +726,176 @@ static void show_stage_entry(FILE *o,
 }
 #endif
=20
+struct narrow_spec *parse_narrow_spec(const char *spec, const char *pr=
efix)
+{
+	struct narrow_spec *ns;
+	struct narrow_pattern *p;
+	const char *start, *end, *prefix_end;
+	int has_wildcards, has_slashes;
+
+	ns =3D xmalloc(sizeof(*ns));
+	memset(ns, 0, sizeof(*ns));
+	if (prefix)
+		ns->prefix =3D xstrdup(prefix);
+
+	start =3D spec;
+	while (*start) {
+		end =3D start;
+		prefix_end =3D NULL;
+		has_slashes =3D has_wildcards =3D 0;
+		while (*end && *end !=3D ':') {
+			if (*end =3D=3D '*' || *end =3D=3D '[' || *end =3D=3D '?')
+				has_wildcards =3D 1;
+			if (*end =3D=3D '/') {
+				has_slashes =3D 1;
+
+				/* A prefix is terminated by double slashes */
+				if (end[1] =3D=3D '/' && !prefix_end) {
+					prefix_end =3D end+2;
+					/* start over again */
+					has_slashes =3D has_wildcards =3D 0;
+				}
+			}
+			if (*end =3D=3D '\\') {
+				end++;
+				has_wildcards =3D 1;
+				if (*end =3D=3D '\0') /* trailing backslash */
+					break;
+			}
+			end++;
+		}
+		/* empty pattern or pattern with prefix only */
+		if (start =3D=3D end || prefix_end =3D=3D end)
+			goto cont;
+
+		p =3D xmalloc(sizeof(*p));
+		memset(p, 0, sizeof(*p));
+		if (prefix_end) {
+			int len =3D prefix_end - start - 1; /* only take one slash */
+			p->prefix =3D xmalloc(len + 1);
+			memcpy(p->prefix, start, len);
+			p->prefix[len] =3D '\0';
+			start =3D prefix_end;
+		}
+		if (*start =3D=3D '!') {
+			p->negative =3D 1;
+			start++;
+		}
+		p->has_slashes =3D has_slashes;
+		p->has_wildcards =3D has_wildcards;
+		p->has_trailing_slash =3D end[-1] =3D=3D '/';
+		if (*start =3D=3D '/') {
+			p->has_root =3D 1;
+			start++;
+		}
+		else if (*start =3D=3D '.' && start[1] =3D=3D '/')
+			start +=3D 2;
+		p->len =3D end-start;
+		p->pattern =3D xmalloc(p->len+1);
+		memcpy(p->pattern, start, p->len);
+		p->pattern[p->len] =3D '\0';
+
+		ALLOC_GROW(ns->patterns, ns->nr + 1, ns->alloc);
+		ns->patterns[ns->nr++] =3D p;
+
+		/*
+		 * ls-files needs to know whether it can prune the index
+		 * in these cases, index cannot be pruned
+		 */
+		if (p->has_root || p->prefix)
+			ns->full_index =3D 1;
+
+cont:
+		if (*end !=3D ':')
+			break;
+		start =3D end + 1;
+	}
+	return ns;
+}
+
+void free_narrow_spec(struct narrow_spec *spec)
+{
+	int i;
+	if (!spec)
+		return;
+	for (i =3D 0; i < spec->nr; i++) {
+		struct narrow_pattern *p =3D spec->patterns[i];
+		if (p->prefix)
+			free(p->prefix);
+		if (p->pattern)
+			free(p->pattern);
+		free(p);
+	}
+	if (spec->patterns)
+		free(spec->patterns);
+	if (spec->prefix)
+		free(spec->prefix);
+	free(spec);
+}
+
+int match_narrow_spec(struct narrow_spec *spec, const char *path)
+{
+	int i, match;
+
+	if (!spec)
+		return 1; /* always match if spec is NULL */
+
+	for (i =3D spec->nr - 1;i >=3D 0; i--) {
+		struct narrow_pattern	*p	    =3D spec->patterns[i];
+		const char		*prefix	    =3D p->prefix   ? p->prefix      : spec->pre=
fix;
+		int			 prefix_len =3D prefix      ? strlen(prefix) : 0;
+		const char		*new_path   =3D p->has_root ? path           : path + pr=
efix_len;
+
+		if (!p->has_root && prefix && prefixcmp(path, prefix))
+			continue;
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
index 0d26f3d..93ec3c6 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -16,6 +16,23 @@ struct unpack_trees_error_msgs {
 	const char *bind_overlap;
 };
=20
+struct narrow_spec {
+	int nr;
+	int alloc;
+	int full_index;
+	char *prefix;
+	struct narrow_pattern {
+		int len;
+		int has_root:1;
+		int has_slashes:1;
+		int has_wildcards:1;
+		int has_trailing_slash:1;
+		int negative:1;
+		char *pattern;
+		char *prefix;
+	} **patterns;
+};
+
 struct unpack_trees_options {
 	unsigned int reset:1,
 		     merge:1,
@@ -48,6 +65,9 @@ struct unpack_trees_options {
 extern int unpack_trees(unsigned n, struct tree_desc *t,
 		struct unpack_trees_options *options);
=20
+struct narrow_spec *parse_narrow_spec(const char *spec, const char *pr=
efix);
+void free_narrow_spec(struct narrow_spec *spec);
+int match_narrow_spec(struct narrow_spec *spec, const char *path);
 int threeway_merge(struct cache_entry **stages, struct unpack_trees_op=
tions *o);
 int twoway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o);
 int bind_merge(struct cache_entry **src, struct unpack_trees_options *=
o);
--=20
1.6.0.3.890.g95457
