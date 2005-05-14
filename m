From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Rename git-diff-tree-helper to git-diff-helper (part
 2).
Date: Fri, 13 May 2005 18:41:36 -0700
Message-ID: <7vbr7e60tr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 03:43:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWlgQ-0000wG-Ag
	for gcvg-git@gmane.org; Sat, 14 May 2005 03:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVENBnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 21:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVENBnL
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 21:43:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41933 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262673AbVENBlk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 21:41:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514014138.KNEW550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 May 2005 21:41:38 -0400
To: pasky@ucw.cz, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It used to be that diff-tree needed helper support to parse its
raw output to generate diffs, but these days git-diff-* family
produces the same output and the helper is not tied to diff-tree
anymore.  Drop "tree" from its name.

This follows the "rename only" commit to adjust the contents of
the files involved.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/diff-format.txt     |    2 +-
Documentation/git-diff-helper.txt |   10 +++++-----
Documentation/git.txt             |    2 +-
Makefile                          |    4 ++--
diff-helper.c                     |   12 ++++++------
diff.h                            |    2 +-
6 files changed, 16 insertions(+), 16 deletions(-)

--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -45,7 +45,7 @@
 instead they produce a patch file.
 
 The patch generation can be customized at two levels.  This
-customization also applies to "git-diff-tree-helper".
+customization also applies to "git-diff-helper".
 
 1. When the environment variable 'GIT_EXTERNAL_DIFF' is not set,
    these commands internally invoke "diff" like this:
--- a/Documentation/git-diff-helper.txt
+++ b/Documentation/git-diff-helper.txt
@@ -1,15 +1,15 @@
-git-diff-tree-helper(1)
+git-diff-helper(1)
 =======================
 v0.1, May 2005
 
 NAME
 ----
-git-diff-tree-helper - Generates patch format output for git-diff-*
+git-diff-helper - Generates patch format output for git-diff-*
 
 
 SYNOPSIS
 --------
-'git-diff-tree-helper' [-z] [-R]
+'git-diff-helper' [-z] [-R]
 
 DESCRIPTION
 -----------
@@ -26,8 +26,8 @@
 	"git-diff-cache" which always compares tree with cache or working
 	file.  E.g.
 
-		git-diff-cache <tree> | git-diff-tree-helper -R file.c
-+
+		git-diff-cache <tree> | git-diff-helper -R file.c
+
 would show a diff to bring the working file back to what is in the <tree>.
 
 See Also
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -149,7 +149,7 @@
 
 Interogators:
 
-link:git-diff-tree-helper.html[git-diff-tree-helper]::
+link:git-diff-helper.html[git-diff-helper]::
 	Generates patch format output for git-diff-*
 
 link:git-rpush.html[git-rpush]::
--- a/Makefile
+++ b/Makefile
@@ -27,7 +27,7 @@
 	git-check-files git-ls-tree git-merge-base git-merge-cache \
 	git-unpack-file git-export git-diff-cache git-convert-cache \
 	git-http-pull git-rpush git-rpull git-rev-list git-mktag \
-	git-diff-tree-helper git-tar-tree git-local-pull git-write-blob \
+	git-diff-helper git-tar-tree git-local-pull git-write-blob \
 	git-get-tar-commit-id
 
 all: $(PROG)
@@ -101,7 +101,7 @@
 git-rpull: rsh.c pull.c
 git-rev-list: rev-list.c
 git-mktag: mktag.c
-git-diff-tree-helper: diff-tree-helper.c
+git-diff-helper: diff-helper.c
 git-tar-tree: tar-tree.c
 git-write-blob: write-blob.c
 
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -45,8 +45,8 @@
 	return 0;
 }
 
-static int parse_diff_tree_output(const char *buf,
-				  const char **spec, int cnt, int reverse)
+static int parse_diff_raw_output(const char *buf,
+				 const char **spec, int cnt, int reverse)
 {
 	struct diff_spec old, new;
 	char path[PATH_MAX];
@@ -109,8 +109,8 @@
 	return 0;
 }
 
-static const char *diff_tree_helper_usage =
-"diff-tree-helper [-R] [-z] paths...";
+static const char *diff_helper_usage =
+"git-diff-helper [-R] [-z] paths...";
 
 int main(int ac, const char **av) {
 	struct strbuf sb;
@@ -125,7 +125,7 @@
 		else if (av[1][1] == 'z')
 			line_termination = 0;
 		else
-			usage(diff_tree_helper_usage);
+			usage(diff_helper_usage);
 		ac--; av++;
 	}
 	/* the remaining parameters are paths patterns */
@@ -135,7 +135,7 @@
 		read_line(&sb, stdin, line_termination);
 		if (sb.eof)
 			break;
-		status = parse_diff_tree_output(sb.buf, av+1, ac-1, reverse);
+		status = parse_diff_raw_output(sb.buf, av+1, ac-1, reverse);
 		if (status)
 			fprintf(stderr, "cannot parse %s\n", sb.buf);
 	}
--- a/diff.h
+++ b/diff.h
@@ -17,7 +17,7 @@
 
 extern void diff_unmerge(const char *path);
 
-/* These are for diff-tree-helper */
+/* These are for diff-helper */
 
 struct diff_spec {
 	unsigned char blob_sha1[20];
------------------------------------------------

