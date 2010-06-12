From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] grep: Add the option '--open-files-in-pager'
Date: Sat, 12 Jun 2010 11:36:51 -0500
Message-ID: <20100612163651.GC5657@burratino>
References: <20100605005116.GA8774@progeny.tock>
 <alpine.DEB.1.00.1006051810300.1732@bonsai2>
 <20100612075542.GB2918@burratino>
 <alpine.DEB.1.00.1006121139290.2689@bonsai2>
 <20100612162945.GB1406@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Paolo Bonzini <bonzini@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:37:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONThh-0007Jh-8X
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0FLQg7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 12:36:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63288 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0FLQg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 12:36:58 -0400
Received: by iwn9 with SMTP id 9so1594234iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7F/GzhfTj5bYMCyc2JAtssCVRQicJ6OMiEiXZPYhfFU=;
        b=xM/KI80Yi3P4eNuMqDZLcP9uMTsQD1p+RBuu7AN9HcWDewMDGcUc3CXeXFJRmmfOpk
         GG/ZByGQv8H6ror4I8/q4I8p3xu9PVz/j2rDfr8hl3wOy9tY3yv+G777PNanfOnIeqb5
         qOAmm+BgzrxsCM5WA2NwHAO33Ejs7vAJSYsGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tEtjwIOWeGxlmjMhdQXuVa8B+sIIXHTh7bg0FY4UQNZ3AhCqLToYwybL/J3xHZR3Qk
         kMVs6GrYv3UuYi47bzZ8klLqFbS5x1QtcefwDI6a7wuuGV90y0EYLRvems1LXK6eRE7Q
         jI6DxtCTmyKU1bq0+sB64gzuQh5nfD63wYm8w=
Received: by 10.231.82.145 with SMTP id b17mr3611743ibl.187.1276360617675;
        Sat, 12 Jun 2010 09:36:57 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm11111695ibg.21.2010.06.12.09.36.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 09:36:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100612162945.GB1406@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149019>

=46rom: Johannes Schindelin <johannes.schindelin@gmx.de>

This adds an option to open the matching files in the pager, and if the
pager happens to be "less" (or "vi") and there is only one grep pattern=
,
it also jumps to the first match right away.

The short option was chose as '-O' to avoid clashes with GNU grep's
options (as suggested by Junio).

So, 'git grep -O abc' is a short form for 'less +/abc $(grep -l abc)'
except that it works also with spaces in file names, and it does not
start the pager if there was no matching file.

[jn: rebased and added tests; with error handling fix from Junio
squashed in]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes from previous version:

 - fix leaked argv
 - die on chdir failure
 - chmod +x t/t7811-grep-open.sh

There was some discussion about changing the option=E2=80=99s name, but=
 it
might be better to instead split it into two options, along these
lines:

  -O | --view-files
  --viewer=3D

I have left it as is for now.

 Documentation/git-grep.txt         |    8 ++
 builtin/grep.c                     |   73 +++++++++++++++++
 git.c                              |    2 +-
 t/lib-pager.sh                     |   15 ++++
 t/t7006-pager.sh                   |   16 +---
 t/{t7002-grep.sh =3D> t7810-grep.sh} |    0
 t/t7811-grep-open.sh               |  154 ++++++++++++++++++++++++++++=
++++++++
 7 files changed, 255 insertions(+), 13 deletions(-)
 create mode 100644 t/lib-pager.sh
 rename t/{t7002-grep.sh =3D> t7810-grep.sh} (100%)
 create mode 100755 t/t7811-grep-open.sh

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4b32322..8fdd8e1 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-F | --fixed-strings] [-n]
 	   [-l | --files-with-matches] [-L | --files-without-match]
+	   [-O | --open-files-in-pager]
 	   [-z | --null]
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
@@ -104,6 +105,13 @@ OPTIONS
 	For better compatibility with 'git diff', `--name-only` is a
 	synonym for `--files-with-matches`.
=20
+-O::
+--open-files-in-pager::
+	Open the matching files in the pager (not the output of 'grep').
+	If the pager happens to be "less" or "vi", and the user
+	specified only one pattern, the first file is positioned at
+	the first match automatically.
+
 -z::
 --null::
 	Output \0 instead of the character that normally follows a
diff --git a/builtin/grep.c b/builtin/grep.c
index 2111212..1e8b946 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -11,6 +11,8 @@
 #include "tree-walk.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "string-list.h"
+#include "run-command.h"
 #include "userdiff.h"
 #include "grep.h"
 #include "quote.h"
@@ -556,6 +558,33 @@ static int grep_file(struct grep_opt *opt, const c=
har *filename)
 	}
 }
=20
+static void append_path(struct grep_opt *opt, const void *data, size_t=
 len)
+{
+	struct string_list *path_list =3D opt->output_priv;
+
+	if (len =3D=3D 1 && *(const char *)data =3D=3D '\0')
+		return;
+	string_list_append(xstrndup(data, len), path_list);
+}
+
+static void run_pager(struct grep_opt *opt, const char *prefix)
+{
+	struct string_list *path_list =3D opt->output_priv;
+	const char **argv =3D xmalloc(sizeof(const char *) * (path_list->nr +=
 1));
+	int i, status;
+
+	for (i =3D 0; i < path_list->nr; i++)
+		argv[i] =3D path_list->items[i].string;
+	argv[path_list->nr] =3D NULL;
+
+	if (prefix && chdir(prefix))
+		die("Failed to chdir: %s", prefix);
+	status =3D run_command_v_opt(argv, RUN_USING_SHELL);
+	if (status)
+		exit(status);
+	free(argv);
+}
+
 static int grep_cache(struct grep_opt *opt, const char **paths, int ca=
ched)
 {
 	int hit =3D 0;
@@ -799,9 +828,11 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 	int cached =3D 0;
 	int seen_dashdash =3D 0;
 	int external_grep_allowed__ignored;
+	int show_in_pager =3D 0;
 	struct grep_opt opt;
 	struct object_array list =3D { 0, 0, NULL };
 	const char **paths =3D NULL;
+	struct string_list path_list =3D { NULL, 0, 0, 0 };
 	int i;
 	int dummy;
 	int nongit =3D 0, use_index =3D 1;
@@ -885,6 +916,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
 		OPT_GROUP(""),
+		OPT_BOOLEAN('O', "open-files-in-pager", &show_in_pager,
+			"show matching files in the pager"),
 		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed__ignored,
 			    "allow calling of grep(1) (ignored by this build)"),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
@@ -960,6 +993,20 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 		argc--;
 	}
=20
+	if (show_in_pager) {
+		const char *pager =3D git_pager(1);
+		if (!pager) {
+			show_in_pager =3D 0;
+		} else {
+			opt.name_only =3D 1;
+			opt.null_following_name =3D 1;
+			opt.output_priv =3D &path_list;
+			opt.output =3D append_path;
+			string_list_append(pager, &path_list);
+			use_threads =3D 0;
+		}
+	}
+
 	if (!opt.pattern_list)
 		die("no pattern given.");
 	if (!opt.fixed && opt.ignore_case)
@@ -1016,6 +1063,30 @@ int cmd_grep(int argc, const char **argv, const =
char *prefix)
 		paths[1] =3D NULL;
 	}
=20
+	if (show_in_pager && (cached || list.nr))
+		die("--open-files-in-pager only works on the worktree");
+
+	if (show_in_pager && opt.pattern_list && !opt.pattern_list->next) {
+		const char *pager =3D path_list.items[0].string;
+		int len =3D strlen(pager);
+
+		if (len > 4 && is_dir_sep(pager[len - 5]))
+			pager +=3D len - 4;
+
+		if (!strcmp("less", pager) || !strcmp("vi", pager)) {
+			struct strbuf buf =3D STRBUF_INIT;
+			strbuf_addf(&buf, "+/%s%s",
+					strcmp("less", pager) ? "" : "*",
+					opt.pattern_list->pattern);
+			string_list_append(buf.buf, &path_list);
+			strbuf_detach(&buf, NULL);
+		}
+	}
+
+	if (!show_in_pager)
+		setup_pager();
+
+
 	if (!use_index) {
 		if (cached)
 			die("--cached cannot be used with --no-index.");
@@ -1035,6 +1106,8 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
=20
 	if (use_threads)
 		hit |=3D wait_all();
+	if (hit && show_in_pager)
+		run_pager(&opt, prefix);
 	free_grep_patterns(&opt);
 	return !hit;
 }
diff --git a/git.c b/git.c
index 99f0363..265fa09 100644
--- a/git.c
+++ b/git.c
@@ -329,7 +329,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, USE_PAGER },
+		{ "grep", cmd_grep },
 		{ "hash-object", cmd_hash_object },
 		{ "help", cmd_help },
 		{ "index-pack", cmd_index_pack },
diff --git a/t/lib-pager.sh b/t/lib-pager.sh
new file mode 100644
index 0000000..f8c6025
--- /dev/null
+++ b/t/lib-pager.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_expect_success 'determine default pager' '
+	test_might_fail git config --unset core.pager &&
+	less=3D$(
+		unset PAGER GIT_PAGER;
+		git var GIT_PAGER
+	) &&
+	test -n "$less"
+'
+
+if expr "$less" : '^[a-z][a-z]*$' >/dev/null
+then
+	test_set_prereq SIMPLEPAGER
+fi
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 3bc7a2a..fc993fc 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -3,6 +3,7 @@
 test_description=3D'Test automatic use of a pager.'
=20
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-pager.sh
=20
 cleanup_fail() {
 	echo >&2 cleanup failed
@@ -158,21 +159,12 @@ test_expect_success 'color when writing to a file=
 intended for a pager' '
 	colorful colorful.log
 '
=20
-test_expect_success 'determine default pager' '
-	unset PAGER GIT_PAGER &&
-	test_might_fail git config --unset core.pager ||
-	cleanup_fail &&
-
-	less=3D$(git var GIT_PAGER) &&
-	test -n "$less"
-'
-
-if expr "$less" : '^[a-z][a-z]*$' >/dev/null && test_have_prereq TTY
+if test_have_prereq SIMPLEPAGER && test_have_prereq TTY
 then
-	test_set_prereq SIMPLEPAGER
+	test_set_prereq SIMPLEPAGERTTY
 fi
=20
-test_expect_success SIMPLEPAGER 'default pager is used by default' '
+test_expect_success SIMPLEPAGERTTY 'default pager is used by default' =
'
 	unset PAGER GIT_PAGER &&
 	test_might_fail git config --unset core.pager &&
 	rm -f default_pager_used ||
diff --git a/t/t7002-grep.sh b/t/t7810-grep.sh
similarity index 100%
rename from t/t7002-grep.sh
rename to t/t7810-grep.sh
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
new file mode 100755
index 0000000..fcfc56e
--- /dev/null
+++ b/t/t7811-grep-open.sh
@@ -0,0 +1,154 @@
+#!/bin/sh
+
+test_description=3D'git grep --open-files-in-pager
+'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-pager.sh
+unset PAGER GIT_PAGER
+
+test_expect_success 'setup' '
+	test_commit initial grep.h "
+enum grep_pat_token {
+	GREP_PATTERN,
+	GREP_PATTERN_HEAD,
+	GREP_PATTERN_BODY,
+	GREP_AND,
+	GREP_OPEN_PAREN,
+	GREP_CLOSE_PAREN,
+	GREP_NOT,
+	GREP_OR,
+};" &&
+
+	test_commit add-user revision.c "
+	}
+	if (seen_dashdash)
+		read_pathspec_from_stdin(revs, &sb, prune);
+	strbuf_release(&sb);
+}
+
+static void add_grep(struct rev_info *revs, const char *ptn, enum grep=
_pat_token what)
+{
+	append_grep_pattern(&revs->grep_filter, ptn, \"command line\", 0, wha=
t);
+" &&
+
+	mkdir subdir &&
+	test_commit subdir subdir/grep.c "enum grep_pat_token" &&
+
+	test_commit uninteresting unrelated "hello, world" &&
+
+	echo GREP_PATTERN >untracked
+'
+
+test_expect_success SIMPLEPAGER 'git grep -O' '
+	cat >$less <<-\EOF &&
+	#!/bin/sh
+	printf "%s\n" "$@" >pager-args
+	EOF
+	chmod +x $less &&
+	cat >expect.less <<-\EOF &&
+	+/*GREP_PATTERN
+	grep.h
+	EOF
+	echo grep.h >expect.notless &&
+	>empty &&
+
+	PATH=3D.:$PATH git grep -O GREP_PATTERN >out &&
+	{
+		test_cmp expect.less pager-args ||
+		test_cmp expect.notless pager-args
+	} &&
+	test_cmp empty out
+'
+
+test_expect_success 'git grep -O --cached' '
+	test_must_fail git grep --cached -O GREP_PATTERN >out 2>msg &&
+	grep open-files-in-pager msg
+'
+
+test_expect_success 'git grep -O --no-index' '
+	rm -f expect.less pager-args out &&
+	cat >expect <<-\EOF &&
+	grep.h
+	untracked
+	EOF
+	>empty &&
+
+	(
+		GIT_PAGER=3D'\''printf "%s\n" >pager-args'\'' &&
+		export GIT_PAGER &&
+		git grep --no-index -O GREP_PATTERN >out
+	) &&
+	test_cmp expect pager-args &&
+	test_cmp empty out
+'
+
+test_expect_success 'setup: fake "less"' '
+	cat >less <<-\EOF
+	#!/bin/sh
+	printf "%s\n" "$@" >actual
+	EOF
+'
+
+test_expect_success 'git grep -O jumps to line in less' '
+	cat >expect <<-\EOF &&
+	+/*GREP_PATTERN
+	grep.h
+	EOF
+	>empty &&
+
+	GIT_PAGER=3D./less git grep -O GREP_PATTERN >out &&
+	test_cmp expect actual &&
+	test_cmp empty out
+'
+
+test_expect_success 'modified file' '
+	rm -f actual &&
+	cat >less <<-\EOF &&
+	#!/bin/sh
+	printf "%s\n" "$@" >actual
+	EOF
+	chmod +x $less &&
+	cat >expect <<-\EOF &&
+	+/*enum grep_pat_token
+	grep.h
+	revision.c
+	subdir/grep.c
+	unrelated
+	EOF
+	>empty &&
+
+	echo "enum grep_pat_token" >unrelated &&
+	test_when_finished "git checkout HEAD unrelated" &&
+	GIT_PAGER=3D./less git grep -F -O "enum grep_pat_token" >out &&
+	test_cmp expect actual &&
+	test_cmp empty out
+'
+
+test_expect_success 'run from subdir' '
+	rm -f actual &&
+	echo grep.c >expect &&
+	>empty &&
+
+	(
+		cd subdir &&
+		export GIT_PAGER &&
+		GIT_PAGER=3D'\''printf "%s\n" >../args'\'' &&
+		git grep -O "enum grep_pat_token" >../out &&
+		GIT_PAGER=3D"pwd >../dir; :" &&
+		git grep -O "enum grep_pat_token" >../out2
+	) &&
+	case $(cat dir) in
+	*subdir)
+		: good
+		;;
+	*)
+		false
+		;;
+	esac &&
+	test_cmp expect args &&
+	test_cmp empty out &&
+	test_cmp empty out2
+'
+
+test_done
--=20
1.7.1
