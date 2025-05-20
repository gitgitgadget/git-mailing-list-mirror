Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9A0248166
	for <git@vger.kernel.org>; Tue, 20 May 2025 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747699299; cv=none; b=SUW4Ce1oVG307p3Iih+wSHi9mMNrmAVhEhlSbqZ6k+C4nAsHjY2McVgq/CRpL4sMp92T22TvjBe3y/rvGRf3SmMSYTEdsEe1bH7ybPF0pEXi07ZWq1fIP0oa3GZc+wsiG4I4hNgBWlyiueSEPILA90wh45pYlOykK0l+moGEVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747699299; c=relaxed/simple;
	bh=nr6KSdYImL/2P1LL5N3NDonYOk+1yfkTmnbcBY2RAcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inUFVCHtuPwIsnU4PznPn81bLU81hKxnM0CUnQ17psfM/NI7MNx26JIAt2TjP00WH0UIzVIH3JzMjupuzwVsbhoEbKrgrNhfqrTw8UwyFxocB8GOa1mgoyRZrseLD8e6UWVNJK9fgZUU6n49mRHnoC/dxvFPrD4nNa/OUVjeEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpXAcMvY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpXAcMvY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747699298; x=1779235298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nr6KSdYImL/2P1LL5N3NDonYOk+1yfkTmnbcBY2RAcY=;
  b=IpXAcMvYv6+h+2xtwBEpoBl022GYkd+TaaIZa3D4D+LY3iWN5NKcFbHg
   MLK6s0juLuQK08TKTyp3EvluaaP8OHAYiXWaTDPPgZyL2NV48z0JjN2wW
   SDBtkB6W0oQMWmJ1ETzuNvgWDy4Zu6K0Ab5zD+8XRb+aIPnMn7vuIsftZ
   IkZNnus39YyjTh/tEdkarHduPMMfQxckoocdKREl6hfYTaB3BR9cDZSkr
   kBP9C/p2AVkl8ummx7DdQSsbV3odmZvxydeWTt2bqWGSl8/QaIACDKVJ8
   WD1DQpy6DPO1ej3K1s2NZN3pzelPgXagl89L9gGYK+WyNQ+c40unOAYXI
   Q==;
X-CSE-ConnectionGUID: oFOUjW6+TZuwL9Bd0Fk1fw==
X-CSE-MsgGUID: stC7ToEFSo+zs4dEzreu5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="72125829"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72125829"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:01:33 -0700
X-CSE-ConnectionGUID: vJBUrlecSR2Jm64ixI9qSA==
X-CSE-MsgGUID: Yh3Y4NFsSKyDCSrST3p8MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139559142"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:01:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 4/4] diff --no-index: support limiting by pathspec
Date: Mon, 19 May 2025 17:01:25 -0700
Message-ID: <20250520000125.2162144-5-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.48.1.397.gec9d649cc640
In-Reply-To: <20250520000125.2162144-1-jacob.e.keller@intel.com>
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

The --no-index option of git-diff enables using the diff machinery from
git while operating outside of a repository. This mode of git diff is
able to compare directories and produce a diff of their contents.

When operating git diff in a repository, git has the notion of
"pathspecs" which can specify which files to compare. In particular,
when using git to diff two trees, you might invoke:

  $ git diff-tree -r <treeish1> <treeish2>.

where the treeish could point to a subdirectory of the repository.

When invoked this way, users can limit the selected paths of the tree by
using a pathspec. Either by providing some list of paths to accept, or
by removing paths via a negative refspec.

The git diff --no-index mode does not support pathspecs, and cannot
limit the diff output in this way. Other diff programs such as GNU
difftools have options for excluding paths based on a pattern match.
However, using git diff as a diff replacement has several advantages
over many popular diff tools, including coloring moved lines, rename
detections, and similar.

Teach git diff --no-index how to handle pathspecs to limit the
comparisons. This will only be supported if both provided paths are
directories.

For comparisons where one path isn't a directory, the --no-index mode
already has some DWIM shortcuts implemented in the fixup_paths()
function.

Modify the fixup_paths function to return 1 if both paths are
directories. If this is the case, interpret any extra arguments to git
diff as pathspecs via parse_pathspec. Add a new PATHSPEC_NO_REPOSITORY
flag to indicate to the parser that we do not have repository. Use this
to aid in error message reporting in the event that the user happens to
invoke git diff --no-index from a repository.

Use parse_pathspec to load the remaining arguments (if any) to git diff
--no-index as pathspec items. Disable PATHSPEC_ATTR support since we do
not have a repository to do attribute lookup. Disable PATHSPEC_FROMTOP
since we do not have a repository root. All pathspecs are treated as
rooted at the provided comparison paths.

Load the pathspecs twice, once prefixed with paths[0] and once prefixed
with paths[1]. I considered trying to avoid this, but don't yet have a
workable solution that reuses the same pathspec objects. We need the
directory paths as prefixes otherwise the match_pathspec won't compare
properly.

Pass the pathspec object for both paths into queue_diff, who in-turn
passes these along to read_directory_contents.

Modify read_directory_contents to check against the pathspecs when
scanning the directory. In order to properly recurse, we need to ensure
that directories match, and that we continue iterating down the nested
directory structure:

  $ git diff --no-index a b c/d

This should include all paths in a and b which match the c/d pathspec.
In particular, if there was 'a/c/d' we need to match it. But to check
'a/c/d', we need to first get to that part, which requires comparing
'a/c' first. With the match_pathspec() function, 'a/c' won't match the
'a/c/d' pathspec string.

However, if we always passed DO_MATCH_LEADING_PATHSPEC, then we will
incorrectly match in certain cases such as matching 'a/c' against
':(glob)**/d'. The match logic will see that a matches the leading part
of the **/ and accept this even tho c doesn't match. The trick seems to
be setting both DO_MATCH_LEADING_PATHSPEC and DO_MATCH_DIRECTORY when
checking directories, but set neither of them when checking files.

Some other gotchas and open questions:

 1) pathspecs must all come after the first two path arguments, you
    can't re-arrange them to come first. I'm treating them sort of like
    the treeish arguments to git diff-tree.

 2) The pathspecs are interpreted relative to the provided paths, and
    thus will always need to be specified as relative paths, and will be
    interpreted as relative to the root of the search for each path
    separately.

 3) negative pathspecs have to be fully qualified from the root, i.e.
    ':(exclude)file' will only exclude 'a/file' and not 'a/b/file'
    unless you also use '(glob)' or similar. I think this matches the
    other pathspec support, but I an not 100% sure.

  4) I'm not certain about exposing match_pathspec_with_flags as-is,
     since DO_MATCH_EXCLUDE shouldn't be passed. I got the behavior I
     expected with DO_MATCH_LEADING_PATHSPEC, but it feels a bit of a
     weird API. Perhaps match_pathspec could set both flags when is_dir
     is true? But would that break other callers?

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/diff.c              |   2 +-
 diff-no-index.c             |  91 ++++++++++++++++++++++++------
 Documentation/git-diff.adoc |  10 +++-
 t/t4053-diff-no-index.sh    | 107 ++++++++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+), 20 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index fa963808c318..c6231edce4e8 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -35,7 +35,7 @@ static const char builtin_diff_usage[] =
 "   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
 "   or: git diff [<options>] <blob> <blob>\n"
-"   or: git diff [<options>] --no-index [--] <path> <path>"
+"   or: git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]"
 "\n"
 COMMON_DIFF_OPTIONS_HELP;
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 9739b2b268b9..e9e8006487c4 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -15,20 +15,47 @@
 #include "gettext.h"
 #include "revision.h"
 #include "parse-options.h"
+#include "pathspec.h"
 #include "string-list.h"
 #include "dir.h"
 
-static int read_directory_contents(const char *path, struct string_list *list)
+static int read_directory_contents(const char *path, struct string_list *list,
+				   const struct pathspec *pathspec)
 {
+	struct strbuf match = STRBUF_INIT;
+	int len;
 	DIR *dir;
 	struct dirent *e;
 
 	if (!(dir = opendir(path)))
 		return error("Could not open directory %s", path);
 
-	while ((e = readdir_skip_dot_and_dotdot(dir)))
-		string_list_insert(list, e->d_name);
+	if (pathspec) {
+		strbuf_addstr(&match, path);
+		strbuf_complete(&match, '/');
+		len = match.len;
+	}
 
+	while ((e = readdir_skip_dot_and_dotdot(dir))) {
+		if (pathspec) {
+			int flags = 0;
+
+			strbuf_setlen(&match, len);
+			strbuf_addstr(&match, e->d_name);
+
+			if (e->d_type == DT_DIR)
+				flags = DO_MATCH_LEADING_PATHSPEC | DO_MATCH_DIRECTORY;
+
+			if (!match_pathspec_with_flags(NULL, pathspec,
+						       match.buf, match.len,
+						       0, NULL, flags))
+				continue;
+		}
+
+		string_list_insert(list, e->d_name);
+	}
+
+	strbuf_release(&match);
 	closedir(dir);
 	return 0;
 }
@@ -131,7 +158,8 @@ static struct diff_filespec *noindex_filespec(const struct git_hash_algo *algop,
 }
 
 static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
-		      const char *name1, const char *name2, int recursing)
+		      const char *name1, const char *name2, int recursing,
+		      const struct pathspec *ps1, const struct pathspec *ps2)
 {
 	int mode1 = 0, mode2 = 0;
 	enum special special1 = SPECIAL_NONE, special2 = SPECIAL_NONE;
@@ -171,9 +199,9 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory_contents(name1, &p1))
+		if (name1 && read_directory_contents(name1, &p1, ps1))
 			return -1;
-		if (name2 && read_directory_contents(name2, &p2)) {
+		if (name2 && read_directory_contents(name2, &p2, ps2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
@@ -218,7 +246,7 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 				n2 = buffer2.buf;
 			}
 
-			ret = queue_diff(o, algop, n1, n2, 1);
+			ret = queue_diff(o, algop, n1, n2, 1, ps1, ps2);
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
@@ -258,8 +286,10 @@ static void append_basename(struct strbuf *path, const char *dir, const char *fi
  * DWIM "diff D F" into "diff D/F F" and "diff F D" into "diff F D/F"
  * Note that we append the basename of F to D/, so "diff a/b/file D"
  * becomes "diff a/b/file D/file", not "diff a/b/file D/a/b/file".
+ *
+ * Return 1 if both paths are directories, 0 otherwise.
  */
-static void fixup_paths(const char **path, struct strbuf *replacement)
+static int fixup_paths(const char **path, struct strbuf *replacement)
 {
 	struct stat st;
 	unsigned int isdir0 = 0, isdir1 = 0;
@@ -282,25 +312,30 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 	if ((isdir0 && ispipe1) || (ispipe0 && isdir1))
 		die(_("cannot compare a named pipe to a directory"));
 
-	if (isdir0 == isdir1)
-		return;
+	/* if both paths are directories, we will enable pathspecs */
+	if (isdir0 && isdir1)
+		return 1;
+
 	if (isdir0) {
 		append_basename(replacement, path[0], path[1]);
 		path[0] = replacement->buf;
-	} else {
+	} else if (isdir1) {
 		append_basename(replacement, path[1], path[0]);
 		path[1] = replacement->buf;
 	}
+
+	return 0;
 }
 
 static const char * const diff_no_index_usage[] = {
-	N_("git diff --no-index [<options>] <path> <path>"),
+	N_("git diff --no-index [<options>] <path> <path> [<pathspec>...]"),
 	NULL
 };
 
 int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 		  int implicit_no_index, int argc, const char **argv)
 {
+	struct pathspec pathspec1, pathspec2, *ps1 = NULL, *ps2 = NULL;
 	int i, no_index;
 	int ret = 1;
 	const char *paths[2];
@@ -317,13 +352,12 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	options = add_diff_options(no_index_options, &revs->diffopt);
 	argc = parse_options(argc, argv, revs->prefix, options,
 			     diff_no_index_usage, 0);
-	if (argc != 2) {
+	if (argc < 2) {
 		if (implicit_no_index)
 			warning(_("Not a git repository. Use --no-index to "
 				  "compare two paths outside a working tree"));
 		usage_with_options(diff_no_index_usage, options);
 	}
-	FREE_AND_NULL(options);
 	for (i = 0; i < 2; i++) {
 		const char *p = argv[i];
 		if (!strcmp(p, "-"))
@@ -337,7 +371,28 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 		paths[i] = p;
 	}
 
-	fixup_paths(paths, &replacement);
+	/* TODO: should we try to catch pathspec-like paths first and warn or
+	 * error? We accepted those as valid 'paths' before so it seems
+	 * unlikely we can change that behavior.
+	 */
+	if (fixup_paths(paths, &replacement)) {
+		parse_pathspec(&pathspec1, PATHSPEC_FROMTOP | PATHSPEC_ATTR,
+			       PATHSPEC_PREFER_FULL | PATHSPEC_NO_REPOSITORY,
+			       paths[0], &argv[2]);
+		if (pathspec1.nr)
+			ps1 = &pathspec1;
+
+		parse_pathspec(&pathspec2, PATHSPEC_FROMTOP | PATHSPEC_ATTR,
+			       PATHSPEC_PREFER_FULL | PATHSPEC_NO_REPOSITORY,
+			       paths[1], &argv[2]);
+		if (pathspec2.nr)
+			ps2 = &pathspec2;
+	} else if (argc > 2) {
+		warning(_("Limiting comparison with pathspecs is only "
+			  "supported if both paths are directories."));
+		usage_with_options(diff_no_index_usage, options);
+	}
+	FREE_AND_NULL(options);
 
 	revs->diffopt.skip_stat_unmatch = 1;
 	if (!revs->diffopt.output_format)
@@ -354,7 +409,7 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	setup_diff_pager(&revs->diffopt);
 	revs->diffopt.flags.exit_with_status = 1;
 
-	if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0))
+	if (queue_diff(&revs->diffopt, algop, paths[0], paths[1], 0, ps1, ps2))
 		goto out;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
@@ -370,5 +425,9 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
 	for (i = 0; i < ARRAY_SIZE(to_free); i++)
 		free(to_free[i]);
 	strbuf_release(&replacement);
+	if (ps1)
+		clear_pathspec(ps1);
+	if (ps2)
+		clear_pathspec(ps2);
 	return ret;
 }
diff --git a/Documentation/git-diff.adoc b/Documentation/git-diff.adoc
index dec173a34517..272331afbaec 100644
--- a/Documentation/git-diff.adoc
+++ b/Documentation/git-diff.adoc
@@ -14,7 +14,7 @@ git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
 git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
 git diff [<options>] <commit>...<commit> [--] [<path>...]
 git diff [<options>] <blob> <blob>
-git diff [<options>] --no-index [--] <path> <path>
+git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -31,14 +31,18 @@ files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-`git diff [<options>] --no-index [--] <path> <path>`::
+`git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]`::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
 	running the command in a working tree controlled by Git and
 	at least one of the paths points outside the working tree,
 	or when running the command outside a working tree
-	controlled by Git. This form implies `--exit-code`.
+	controlled by Git. This form implies `--exit-code`. If both
+	paths point to directories, additional pathspecs may be
+	provided. These will limit the files included in the
+	difference. All such pathspecs must be relative as they
+	apply to both sides of the diff.
 
 `git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]`::
 
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 5e5bad61ca1e..60437accfd98 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -295,4 +295,111 @@ test_expect_success PIPE,SYMLINKS 'diff --no-index reads from pipes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff --no-index F F rejects pathspecs' '
+	test_must_fail git diff --no-index -- a/1 a/2 a 2>actual.err &&
+	test_grep "usage: git diff --no-index" actual.err
+'
+
+test_expect_success 'diff --no-index D F rejects pathspecs' '
+	test_must_fail git diff --no-index -- a a/2 a 2>actual.err &&
+	test_grep "usage: git diff --no-index" actual.err
+'
+
+test_expect_success 'diff --no-index F D rejects pathspecs' '
+	test_must_fail git diff --no-index -- a/1 b b 2>actual.err &&
+	test_grep "usage: git diff --no-index" actual.err
+'
+
+test_expect_success 'diff --no-index with pathspec' '
+	test_expect_code 1 git diff --no-index a b 1 >actual &&
+	cat >expect <<-EOF &&
+	diff --git a/a/1 b/a/1
+	deleted file mode 100644
+	index d00491f..0000000
+	--- a/a/1
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --no-index with pathspec no matches' '
+	test_expect_code 0 git diff --no-index a b missing
+'
+
+test_expect_success 'diff --no-index with negative pathspec' '
+	test_expect_code 1 git diff --no-index a b ":!2" >actual &&
+	cat >expect <<-EOF &&
+	diff --git a/a/1 b/a/1
+	deleted file mode 100644
+	index d00491f..0000000
+	--- a/a/1
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup nested' '
+	mkdir -p c/1/2 &&
+	mkdir -p d/1/2 &&
+	echo 1 >c/1/2/a &&
+	echo 2 >c/1/2/b
+'
+
+test_expect_success 'diff --no-index with pathspec nested negative pathspec' '
+	test_expect_code 0 git diff --no-index c d ":!1"
+'
+
+test_expect_success 'diff --no-index with pathspec nested pathspec' '
+	test_expect_code 1 git diff --no-index c d 1/2 >actual &&
+	cat >expect <<-EOF &&
+	diff --git a/c/1/2/a b/c/1/2/a
+	deleted file mode 100644
+	index d00491f..0000000
+	--- a/c/1/2/a
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-1
+	diff --git a/c/1/2/b b/c/1/2/b
+	deleted file mode 100644
+	index 0cfbf08..0000000
+	--- a/c/1/2/b
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --no-index with pathspec glob' '
+	test_expect_code 1 git diff --no-index c d ":(glob)**/a" >actual &&
+	cat >expect <<-EOF &&
+	diff --git a/c/1/2/a b/c/1/2/a
+	deleted file mode 100644
+	index d00491f..0000000
+	--- a/c/1/2/a
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff --no-index with pathspec glob and exclude' '
+	test_expect_code 1 git diff --no-index c d ":(glob,exclude)**/a" >actual &&
+	cat >expect <<-EOF &&
+	diff --git a/c/1/2/b b/c/1/2/b
+	deleted file mode 100644
+	index 0cfbf08..0000000
+	--- a/c/1/2/b
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-2
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.48.1.397.gec9d649cc640

