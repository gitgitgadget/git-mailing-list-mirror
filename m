From: c.shoemaker@cox.net
Subject: [PATCH] Minor clarifications in diffcore documentation
Date: Sat, 29 Oct 2005 00:15:49 -0400
Message-ID: <E1EVi8D-0002TT-Ik@localhost>
X-From: git-owner@vger.kernel.org Sat Oct 29 06:20:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVi8b-0003wp-78
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVJ2EPv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbVJ2EPv
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:15:51 -0400
Received: from eastrmmtao05.cox.net ([68.230.240.34]:50632 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750845AbVJ2EPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 00:15:51 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029041547.THNE28234.eastrmmtao05.cox.net@localhost>
          for <git@vger.kernel.org>; Sat, 29 Oct 2005 00:15:47 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVi8D-0002TT-Ik
	for git@vger.kernel.org; Sat, 29 Oct 2005 00:15:49 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10786>

Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>

---

 Documentation/diffcore.txt |   65 ++++++++++++++++++++++++++------------------
 1 files changed, 38 insertions(+), 27 deletions(-)

805e13719e93be23d3e24e182d45056fab192a25
diff --git a/Documentation/diffcore.txt b/Documentation/diffcore.txt
--- a/Documentation/diffcore.txt
+++ b/Documentation/diffcore.txt
@@ -6,13 +6,12 @@ June 2005
 Introduction
 ------------
 
-The diff commands git-diff-index, git-diff-files, and
-git-diff-tree can be told to manipulate differences they find
-in unconventional ways before showing diff(1) output.  The
-manipulation is collectively called "diffcore transformation".
-This short note describes what they are and how to use them to
-produce diff outputs that are easier to understand than the
-conventional kind.
+The diff commands git-diff-index, git-diff-files, git-diff-tree, and
+git-diff-stages can be told to manipulate differences they find in
+unconventional ways before showing diff(1) output.  The manipulation
+is collectively called "diffcore transformation".  This short note
+describes what they are and how to use them to produce diff outputs
+that are easier to understand than the conventional kind.
 
 
 The chain of operation
@@ -29,7 +28,10 @@ files:
  - git-diff-files compares contents of the index file and the
    working directory;
 
- - git-diff-tree compares contents of two "tree" objects.
+ - git-diff-tree compares contents of two "tree" objects;
+
+ - git-diff-stages compares contents of blobs at two stages in an
+   unmerged index file.
 
 In all of these cases, the commands themselves compare
 corresponding paths in the two sets of files.  The result of
@@ -65,14 +67,23 @@ format sections of the manual for git-di
 diff-patch format.
 
 
-diffcore-pathspec
+diffcore-pathspec: For Ignoring Files Outside Our Consideration
 -----------------
 
 The first transformation in the chain is diffcore-pathspec, and
 is controlled by giving the pathname parameters to the
 git-diff-* commands on the command line.  The pathspec is used
 to limit the world diff operates in.  It removes the filepairs
-outside the specified set of pathnames.
+outside the specified set of pathnames.  E.g. If the input set 
+of filepairs included:
+
+------------------------------------------------
+:100644 100644 bcd1234... 0123456... M junkfile
+------------------------------------------------
+
+but the command invocation was "git-diff-files myfile", then the
+junkfile entry would be removed from the list because only "myfile"
+is under consideration.
 
 Implementation note.  For performance reasons, git-diff-tree
 uses the pathname parameters on the command line to cull set of
@@ -80,7 +91,7 @@ filepairs it feeds the diffcore mechanis
 use diffcore-pathspec, but the end result is the same.
 
 
-diffcore-break
+diffcore-break: For Splitting Up "Complete Rewrites"
 --------------
 
 The second transformation in the chain is diffcore-break, and is
@@ -115,7 +126,7 @@ the original is used), and can be custom
 after "-B" option (e.g. "-B75" to tell it to use 75%).
 
 
-diffcore-rename
+diffcore-rename: For Detection Renames and Copies
 ---------------
 
 This transformation is used to detect renames and copies, and is
@@ -136,16 +147,16 @@ merges these filepairs and creates:
 :100644 100644 0123456... 0123456... R100 fileX file0
 ------------------------------------------------
 
-When the "-C" option is used, the original contents of modified
-files and contents of unchanged files are considered as
-candidates of the source files in rename/copy operation, in
-addition to the deleted files.  If the input were like these
-filepairs, that talk about a modified file fileY and a newly
+When the "-C" option is used, the original contents of modified files,
+and deleted files (and also unmodified files, if the
+"\--find-copies-harder" option is used) are considered as candidates
+of the source files in rename/copy operation.  If the input were like
+these filepairs, that talk about a modified file fileY and a newly
 created file file0:
 
 ------------------------------------------------
 :100644 100644 0123456... 1234567... M fileY
-:000000 100644 0000000... 0123456... A file0
+:000000 100644 0000000... bcd3456... A file0
 ------------------------------------------------
 
 the original contents of fileY and the resulting contents of
@@ -154,14 +165,14 @@ changed to:
 
 ------------------------------------------------
 :100644 100644 0123456... 1234567... M fileY
-:100644 100644 0123456... 0123456... C100 fileY file0
+:100644 100644 0123456... bcd3456... C100 fileY file0
 ------------------------------------------------
 
 In both rename and copy detection, the same "extent of changes"
 algorithm used in diffcore-break is used to determine if two
 files are "similar enough", and can be customized to use
-similarity score different from the default 50% by giving a
-number after "-M" or "-C" option (e.g. "-M8" to tell it to use
+a similarity score different from the default of 50% by giving a
+number after the "-M" or "-C" option (e.g. "-M8" to tell it to use
 8/10 = 80%).
 
 Note.  When the "-C" option is used with `\--find-copies-harder`
@@ -173,7 +184,7 @@ git-diff-\* commands can detect copies o
 copied happened to have been modified in the same changeset.
 
 
-diffcore-merge-broken
+diffcore-merge-broken: For Putting "Complete Rewrites" Back Together
 ---------------------
 
 This transformation is used to merge filepairs broken by
@@ -215,7 +226,7 @@ prefixed with '-', followed by the entir
 version prefixed with '+'.
 
 
-diffcore-pickaxe
+diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 ----------------
 
 This transformation is used to find filepairs that represent
@@ -230,7 +241,7 @@ string appeared in this changeset".  It 
 opposite case that loses the specified string.
 
 When `\--pickaxe-all` is not in effect, diffcore-pickaxe leaves
-only such filepairs that touches the specified string in its
+only such filepairs that touch the specified string in its
 output.  When `\--pickaxe-all` is used, diffcore-pickaxe leaves all
 filepairs intact if there is such a filepair, or makes the
 output empty otherwise.  The latter behaviour is designed to
@@ -238,19 +249,19 @@ make reviewing of the changes in the con
 changeset easier.
 
 
-diffcore-order
+diffcore-order: For Sorting the Output Based on Filenames
 --------------
 
 This is used to reorder the filepairs according to the user's
 (or project's) taste, and is controlled by the -O option to the
 git-diff-* commands.
 
-This takes a text file each of whose line is a shell glob
+This takes a text file each of whose lines is a shell glob
 pattern.  Filepairs that match a glob pattern on an earlier line
 in the file are output before ones that match a later line, and
 filepairs that do not match any glob pattern are output last.
 
-As an example, typical orderfile for the core git probably
+As an example, a typical orderfile for the core git probably
 would look like this:
 
 ------------------------------------------------
