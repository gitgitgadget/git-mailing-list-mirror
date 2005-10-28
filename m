From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: [PATCH] Documentation changes to recursive option for git-diff-tree
Date: Fri, 28 Oct 2005 13:04:49 -0400
Message-ID: <20051028170449.GA1446@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Oct 28 19:06:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVXew-0002dA-4m
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 19:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVJ1REv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 13:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbVJ1REv
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 13:04:51 -0400
Received: from eastrmmtao01.cox.net ([68.230.240.38]:7876 "EHLO
	eastrmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030256AbVJ1REv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 13:04:51 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051028170419.IFPT13165.eastrmmtao01.cox.net@localhost>;
          Fri, 28 Oct 2005 13:04:19 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVXer-0000NW-Rh; Fri, 28 Oct 2005 13:04:49 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10769>

Subject: [PATCH] Documentation changes to recursive option for git-diff-tree

    Update docs and usages regarding '-r' recursive option for git-diff-tree.
    Remove '-r' from common diff options, mention it only for git-diff-tree.
    Remove one extraneous use of '-r' with git-diff-files in get-merge.sh.
    Sync the synopsis and usage string for git-diff-tree.

Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>

---
My first real patch with git.  Did I do it right?

-chris 

 Documentation/git-diff-tree.txt |    5 ++++-
 diff-tree.c                     |    6 ++++--
 diff.h                          |    1 -
 git-merge.sh                    |    2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

4b20f7c39762c54c414eb92d17180064c7ccbde9
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -8,7 +8,7 @@ git-diff-tree - Compares the content and
 
 SYNOPSIS
 --------
-'git-diff-tree' [--stdin] [-m] [-s] [-v] [--pretty] [-t] [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
+'git-diff-tree' [--stdin] [-m] [-s] [-v] [--pretty] [-t] [-r] [--root] [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
 
 DESCRIPTION
 -----------
@@ -33,6 +33,9 @@ include::diff-options.txt[]
 	Note that this parameter does not provide any wildcard or regexp
 	features.
 
+-r::
+        recurse into sub-trees
+
 -t::
 	show tree entry itself as well as subtrees.  Implies -r.
 
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -149,8 +149,10 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git-diff-tree [--stdin] [-m] [-s] [-v] [--pretty] [-t] "
-"[<common diff options>] <tree-ish> <tree-ish>"
+"git-diff-tree [--stdin] [-m] [-s] [-v] [--pretty] [-t] [-r] [--root] "
+"[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"  -r            diff recursively\n"
+"  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
 
 int main(int argc, const char **argv)
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -91,7 +91,6 @@ extern void diffcore_std_no_resolve(stru
 
 #define COMMON_DIFF_OPTIONS_HELP \
 "\ncommon diff options:\n" \
-"  -r            diff recursively (only meaningful in diff-tree)\n" \
 "  -z            output diff-raw with lines terminated with NUL.\n" \
 "  -p            output patch format.\n" \
 "  -u            synonym for -p.\n" \
diff --git a/git-merge.sh b/git-merge.sh
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -25,7 +25,7 @@ dropsave() {
 
 savestate() {
 	# Stash away any local modifications.
-	git-diff-index -r -z --name-only $head |
+	git-diff-index -z --name-only $head |
 	cpio -0 -o >"$GIT_DIR/MERGE_SAVE"
 }
 
