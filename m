From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Clean up diff option descriptions.
Date: Wed, 13 Jul 2005 12:52:35 -0700
Message-ID: <7vvf3exz3w.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050712055218.GA18192@buici.com>
	<7v7jfwbfvj.fsf@assigned-by-dhcp.cox.net>
	<20050712155316.GA5841@buici.com>
	<pan.2005.07.12.16.16.45.990714@smurf.noris.de>
	<loom.20050712T224801-163@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 22:02:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsnQk-0000zK-UB
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVGMUBT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 16:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVGMTyd
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 15:54:33 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:57032 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262721AbVGMTwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 15:52:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050713195235.JPSD17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 15:52:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <loom.20050712T224801-163@post.gmane.org> (Junio C. Hamano's message of "Tue, 12 Jul 2005 20:51:17 +0000 (UTC)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I got tired of maintaining almost duplicated descriptions in
diff-* brothers, both in usage string and documentation.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This comes after the "diff-stages -u" and "--name-only" patches.
*** I am in the process of a full sweep over Documentation/ and
*** program usage strings right now so you will see more patches
*** to Documentation/ area from me.

 Documentation/Makefile            |    2 +
 Documentation/diff-options.txt    |   53 +++++++++++++++++++++++++++++++++++++
 Documentation/git-diff-cache.txt  |   48 ++--------------------------------
 Documentation/git-diff-files.txt  |   44 +------------------------------
 Documentation/git-diff-stages.txt |   48 ++--------------------------------
 Documentation/git-diff-tree.txt   |   46 ++------------------------------
 diff-cache.c                      |    4 ++-
 diff-files.c                      |    4 ++-
 diff-stages.c                     |    3 +-
 diff-tree.c                       |    4 ++-
 diff.h                            |   20 ++++++++++++++
 11 files changed, 96 insertions(+), 180 deletions(-)
 create mode 100644 Documentation/diff-options.txt

6a3a580f9f9da9d5e821c2ffbe9d0dd1fe54cb63
diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -25,7 +25,7 @@ man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
 # 'include' dependencies
-git-diff-%.txt: diff-format.txt
+git-diff-%.txt: diff-format.txt diff-options.txt
 	touch $@
 
 clean:
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/diff-options.txt
@@ -0,0 +1,53 @@
+-p::
+	Generate patch (see section on generating patches)
+
+-u::
+	Synonym for "-p".
+
+-r::
+	Look recursivelly in subdirectories; this flag does not
+	mean anything to commands other than "git-diff-tree";
+	other commands always looks at all the subdirectories.
+
+-z::
+	\0 line termination on output
+
+--name-only::
+	Show only names of changed files.
+
+--name-only-z::
+	Same as --name-only, but terminate lines with NUL.
+
+-B::
+	Break complete rewrite changes into pairs of delete and create.
+
+-M::
+	Detect renames.
+
+-C::
+	Detect copies as well as renames.
+
+--find-copies-harder::
+	By default, -C option finds copies only if the original
+	file of the copy was modified in the same changeset for
+	performance reasons.  This flag makes the command
+	inspect unmodified files as candidates for the source of
+	copy.  This is a very expensive operation for large
+	projects, so use it with caution.
+
+-S<string>::
+	Look for differences that contains the change in <string>.
+
+--pickaxe-all::
+	When -S finds a change, show all the changes in that
+	changeset, not just the files that contains the change
+	in <string>.
+
+-O<orderfile>::
+	Output the patch in the order specified in the
+	<orderfile>, which has one shell glob pattern per line.
+
+-R::
+	Swap two inputs; that is, show differences from cache or
+	on-disk file to tree contents.
+
diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,7 +9,7 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [--cached] [-R] [-B] [-M] [-C] [--find-copies-harder] [-O<orderfile>] [-S<string>] [--pickaxe-all] <tree-ish> [<path>...]
+'git-diff-cache' [-m] [--cached] [<common diff options>] <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -21,53 +21,11 @@ entries in the cache are compared.
 
 OPTIONS
 -------
+include::diff-options.txt[]
+
 <tree-ish>::
 	The id of a tree object to diff against.
 
--p::
-	Generate patch (see section on generating patches)
-
--r::
-	This flag does not mean anything.  It is there only to match
-	"git-diff-tree".  Unlike "git-diff-tree", "git-diff-cache"
-	always looks at all the subdirectories.
-
--z::
-	\0 line termination on output
-
--B::
-	Break complete rewrite changes into pairs of delete and create.
-
--M::
-	Detect renames.
-
--C::
-	Detect copies as well as renames.
-
---find-copies-harder::
-	By default, -C option finds copies only if the original
-	file of the copy was modified in the same changeset for
-	performance reasons.  This flag makes the command
-	inspect unmodified files as candidates for the source of
-	copy.  This is a very expensive operation for large
-	projects, so use it with caution.
-
--S<string>::
-	Look for differences that contains the change in <string>.
-
---pickaxe-all::
-	When -S finds a change, show all the changes in that
-	changeset, not just the files that contains the change
-	in <string>.
-
--O<orderfile>::
-	Output the patch in the order specified in the
-	<orderfile>, which has one shell glob pattern per line.
-
--R::
-	Swap two inputs; that is, show differences from cache or
-	on-disk file to tree contents.
-
 --cached::
 	do not consider the on-disk file at all
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the w
 
 SYNOPSIS
 --------
-'git-diff-files' [-p] [-q] [-r] [-z] [-R] [-B] [-M] [-C] [--find-copies-harder] [-O<orderfile>] [-S<string>] [--pickaxe-all] [<path>...]
+'git-diff-files' [-q] [<common diff options>] [<path>...]
 
 DESCRIPTION
 -----------
@@ -20,51 +20,11 @@ same as "git-diff-cache" and "git-diff-t
 
 OPTIONS
 -------
--p::
-	generate patch (see section on generating patches).
+include::diff-options.txt[]
 
 -q::
 	Remain silent even on nonexisting files
 
--R::
-	Swap two inputs; that is, show differences from on-disk files
-	to cache contents.
-
--B::
-	Break complete rewrite changes into pairs of delete and create.
-
--M::
-	Detect renames.
-
--C::
-	Detect copies as well as renames.
-
---find-copies-harder::
-	By default, -C option finds copies only if the original
-	file of the copy was modified in the same changeset for
-	performance reasons.  This flag makes the command
-	inspect unmodified files as candidates for the source of
-	copy.  This is a very expensive operation for large
-	projects, so use it with caution.
-
--S<string>::
-	Look for differences that contains the change in <string>.
-
---pickaxe-all::
-	When -S finds a change, show all the changes in that
-	changeset, not just the files that contains the change
-	in <string>.
-
--O<orderfile>::
-	Output the patch in the order specified in the
-	<orderfile>, which has one shell glob pattern per line.
-
--r::
-	This flag does not mean anything.  It is there only to match
-	git-diff-tree.  Unlike git-diff-tree, git-diff-files always looks
-	at all the subdirectories.
-
-
 Output format
 -------------
 include::diff-format.txt[]
diff --git a/Documentation/git-diff-stages.txt b/Documentation/git-diff-stages.txt
--- a/Documentation/git-diff-stages.txt
+++ b/Documentation/git-diff-stages.txt
@@ -9,7 +9,7 @@ git-diff-stages - Compares content and m
 
 SYNOPSIS
 --------
-'git-diff-stages' [-p] [-r] [-z] [-R] [-B] [-M] [-C] [--find-copies-harder] [-O<orderfile>] [-S<string>] [--pickaxe-all] <stage1> <stage2> [<path>...]
+'git-diff-stages' [<common diff options>] <stage1> <stage2> [<path>...]
 
 DESCRIPTION
 -----------
@@ -18,53 +18,11 @@ unmerged index file.
 
 OPTIONS
 -------
+include::diff-options.txt[]
+
 <stage1>,<stage2>::
 	The stage number to be compared.
 
--p::
-	Generate patch (see section on generating patches)
-
--r::
-	This flag does not mean anything.  It is there only to match
-	"git-diff-tree".  Unlike "git-diff-tree", "git-diff-stages"
-	always looks at all the subdirectories.
-
--z::
-	\0 line termination on output
-
--B::
-	Break complete rewrite changes into pairs of delete and create.
-
--M::
-	Detect renames.
-
--C::
-	Detect copies as well as renames.
-
---find-copies-harder::
-	By default, -C option finds copies only if the original
-	file of the copy was modified in the same changeset for
-	performance reasons.  This flag makes the command
-	inspect unmodified files as candidates for the source of
-	copy.  This is a very expensive operation for large
-	projects, so use it with caution.
-
--S<string>::
-	Look for differences that contains the change in <string>.
-
---pickaxe-all::
-	When -S finds a change, show all the changes in that
-	changeset, not just the files that contains the change
-	in <string>.
-
--O<orderfile>::
-	Output the patch in the order specified in the
-	<orderfile>, which has one shell glob pattern per line.
-
--R::
-	Swap two inputs; that is, show differences from <stage2> to
-	<stage1>.
-
 Output format
 -------------
 include::diff-format.txt[]
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,7 +9,7 @@ git-diff-tree - Compares the content and
 
 SYNOPSIS
 --------
-'git-diff-tree' [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] [-t] [-R] [-B] [-M] [-C] [--find-copies-harder] [-O<orderfile>] [-S<string>] [--pickaxe-all] <tree-ish> <tree-ish> [<path>...]
+'git-diff-tree' [--stdin] [-m] [-s] [-v] [--pretty] [-t] [<common diff options>] <tree-ish> <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -19,6 +19,8 @@ Note that "git-diff-tree" can use the tr
 
 OPTIONS
 -------
+include::diff-options.txt[]
+
 <tree-ish>::
 	The id of a tree object.
 
@@ -29,51 +31,9 @@ OPTIONS
 	Note that this parameter does not provide any wildcard or regexp
 	features.
 
--p::
-	generate patch (see section on generating patches).  For
-	git-diff-tree, this flag implies '-r' as well.
-
--B::
-	Break complete rewrite changes into pairs of delete and create.
-
--M::
-	Detect renames.
-
--C::
-	Detect copies as well as renames.
-
---find-copies-harder::
-	By default, -C option finds copies only if the original
-	file of the copy was modified in the same changeset for
-	performance reasons.  This flag makes the command
-	inspect unmodified files as candidates for the source of
-	copy.  This is a very expensive operation for large
-	projects, so use it with caution.
-
--R::
-	Swap two input trees.
-
--S<string>::
-	Look for differences that contains the change in <string>.
-
---pickaxe-all::
-	When -S finds a change, show all the changes in that
-	changeset, not just the files that contains the change
-	in <string>.
-
--O<orderfile>::
-	Output the patch in the order specified in the
-	<orderfile>, which has one shell glob pattern per line.
-
--r::
-	recurse
-
 -t::
 	show tree entry itself as well as subtrees.  Implies -r.
 
--z::
-	\0 line termination on output
-
 --root::
 	When '--root' is specified the initial commit will be showed as a big
 	creation event. This is equivalent to a diff against the NULL tree.
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -159,7 +159,9 @@ static void mark_merge_entries(void)
 }
 
 static char *diff_cache_usage =
-"git-diff-cache [-p] [-r] [-z] [-m] [--cached] [-R] [-B] [-M] [-C] [--find-copies-harder] [-O<orderfile>] [-S<string>] [--pickaxe-all] <tree-ish> [<path>...]";
+"git-diff-cache [-m] [--cached] "
+"[<common diff options>] <tree-ish> [<path>...]"
+COMMON_DIFF_OPTIONS_HELP;
 
 int main(int argc, const char **argv)
 {
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -7,7 +7,9 @@
 #include "diff.h"
 
 static const char *diff_files_usage =
-"git-diff-files [-p] [-q] [-r] [-z] [-R] [-B] [-M] [-C] [--find-copies-harder] [-O<orderfile>] [-S<string>] [--pickaxe-all] [<path>...]";
+"git-diff-files [-q] "
+"[<common diff options>] [<path>...]"
+COMMON_DIFF_OPTIONS_HELP;
 
 static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int detect_rename = 0;
diff --git a/diff-stages.c b/diff-stages.c
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -17,7 +17,8 @@ static const char *orderfile = NULL;
 static const char *diff_filter = NULL;
 
 static char *diff_stages_usage =
-"git-diff-stages [-p] [-r] [-z] [-R] [-B] [-M] [-C] [--find-copies-harder] [-O<orderfile>] [-S<string>] [--pickaxe-all] <stage1> <stage2> [<path>...]";
+"git-diff-stages [<common diff options>] <stage1> <stage2> [<path>...]"
+COMMON_DIFF_OPTIONS_HELP;
 
 static void diff_stages(int stage1, int stage2)
 {
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -395,7 +395,9 @@ static int diff_tree_stdin(char *line)
 }
 
 static char *diff_tree_usage =
-"git-diff-tree [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] [--pretty] [-t] [-R] [-B] [-M] [-C] [--find-copies-header] [-O<orderfile>] [-S<string>] [--pickaxe-all] <tree-ish> <tree-ish>";
+"git-diff-tree [--stdin] [-m] [-s] [-v] [--pretty] [-t] "
+"[<common diff options>] <tree-ish> <tree-ish>"
+COMMON_DIFF_OPTIONS_HELP;
 
 int main(int argc, const char **argv)
 {
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -53,6 +53,26 @@ extern void diffcore_std_no_resolve(cons
 				    const char *pickaxe, int pickaxe_opts,
 				    const char *orderfile, const char *filter);
 
+#define COMMON_DIFF_OPTIONS_HELP \
+"\ncommon diff options:\n" \
+"  -r		diff recursively (only meaningful in diff-tree)\n" \
+"  -z		output diff-raw with lines terminated with NUL.\n" \
+"  -p		output patch format.\n" \
+"  -u		synonym for -p.\n" \
+"  --name-only	show only names of changed files.\n" \
+"  --name-only-z\n" \
+"		same as --name-only but terminate lines with NUL.\n" \
+"  -R		swap input file pairs.\n" \
+"  -B		detect complete rewrites.\n" \
+"  -M		detect renames.\n" \
+"  -C		detect copies.\n" \
+"  --find-copies-harder\n" \
+"		try unchanged files as candidate for copy detection.\n" \
+"  -O<file>	reorder diffs according to the <file>.\n" \
+"  -S<string>	find filepair whose only one side contains the string.\n" \
+"  --pickaxe-all\n" \
+"		show all files diff when -S is used and hit is found.\n"
+
 extern int diff_queue_is_empty(void);
 
 #define DIFF_FORMAT_HUMAN	0
