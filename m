From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Clarify and fix English in git-rm documentation.
Date: Sun, 13 Apr 2008 15:42:23 -0500
Message-ID: <E1Jl91r-0000yT-8T@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 22:43:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl92k-00050M-B2
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 22:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYDMUmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 16:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbYDMUmd
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 16:42:33 -0400
Received: from jdl.com ([208.123.74.7]:51667 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbYDMUmc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 16:42:32 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>)
	id 1Jl91r-0000yT-8T
	for git@vger.kernel.org; Sun, 13 Apr 2008 15:42:31 -0500
X-Spam-Score: -102.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79421>


Do some verb-noun agreement changes
Clarify some file globbing cases
Fixed a wrong statement in an example.

Signed-off-by: Jon Loeliger <jdl@jdl.com>
---

Some discussion in the next message.  Blah.

 Documentation/git-rm.txt |   49 +++++++++++++++++++++++++++------------------
 1 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index dc36c66..2066def 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -11,28 +11,34 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Remove files from the working tree and from the index.  The
-files have to be identical to the tip of the branch, and no
-updates to its contents must have been placed in the staging
-area (aka index).  When --cached is given, the staged content has to
-match either the tip of the branch *or* the file on disk.
+Remove files from the index, or from the working tree and the index.
+`git rm` will not remove a file from just your working directory.
+The files being removed have to be identical to the tip of the branch,
+and no updates to their contents can be staged in the index.
+When '--cached' is given, the staged content has to
+match either the tip of the branch or the file on disk,
+allowing the file to be removed from just the index.
 
 
 OPTIONS
 -------
 <file>...::
 	Files to remove.  Fileglobs (e.g. `*.c`) can be given to
-	remove all matching files.  Also a leading directory name
-	(e.g. `dir` to add `dir/file1` and `dir/file2`) can be
-	given to remove all files in the directory, recursively,
-	but this requires `-r` option to be given for safety.
+	remove all matching files.  If you want git to expand
+	file glob characters, you may need to shell-escape them.
+	A leading directory name
+	(e.g. `dir` to remove `dir/file1` and `dir/file2`) can be
+	given to remove all files in the directory, and recursively
+	all sub-directories,
+	but this requires the `-r` option to be explicitly given.
 
 -f::
 	Override the up-to-date check.
 
 -n, \--dry-run::
-        Don't actually remove the file(s), just show if they exist in
-        the index.
+	Don't actually remove any file(s).  Instead, just show
+	if they exist in the index and would otherwise be removed
+	by the command.
 
 -r::
         Allow recursive removal when a leading directory name is
@@ -44,9 +50,9 @@ OPTIONS
 	for command-line options).
 
 \--cached::
-	This option can be used to tell the command to remove
-	the paths only from the index, leaving working tree
-	files.
+	Use this option to unstage and remove paths only from the index.
+	Working tree files, whether modified or not, will be
+	left alone.
 
 \--ignore-unmatch::
 	Exit with a zero status even if no files matched.
@@ -59,11 +65,15 @@ OPTIONS
 DISCUSSION
 ----------
 
-The list of <file> given to the command can be exact pathnames,
-file glob patterns, or leading directory name.  The command
-removes only the paths that is known to git.  Giving the name of
+The <file> list given to the command can be exact pathnames,
+file glob patterns, or leading directory names.  The command
+removes only the paths that are known to git.  Giving the name of
 a file that you have not told git about does not remove that file.
 
+File globbing matches across directory boundaries.  Thus, given
+two directories `d` and `d2`, there is a difference between
+using `git rm \'d\*\'` and `git rm \'d/\*\'`, as the former will
+also remove all of directory `d2`.
 
 EXAMPLES
 --------
@@ -72,11 +82,10 @@ git-rm Documentation/\\*.txt::
 	`Documentation` directory and any of its subdirectories.
 +
 Note that the asterisk `\*` is quoted from the shell in this
-example; this lets the command include the files from
-subdirectories of `Documentation/` directory.
+example; this lets git, and not the shell, expand the pathnames
+of files and subdirectories under the `Documentation/` directory.
 
 git-rm -f git-*.sh::
-	Remove all git-*.sh scripts that are in the index.
 	Because this example lets the shell expand the asterisk
 	(i.e. you are listing the files explicitly), it
 	does not remove `subdir/git-foo.sh`.
-- 
1.5.5.50.g71060
