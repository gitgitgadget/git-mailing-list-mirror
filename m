From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 1/6] user-manual: edit "ignoring files" for conciseness
Date: Sun, 26 Aug 2007 12:16:57 -0400
Message-ID: <30953.9472837516$1188145077@news.gmane.org>
References: <11881450221019-git-send-email->
Cc: git@vger.kernel.org,
	"J. Bruce Fields" <bfields@puzzle.fieldses.org>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 18:17:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKo7-0003GX-R5
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 18:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbXHZQRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 12:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbXHZQRT
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 12:17:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57992 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbXHZQRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 12:17:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPKnP-0007Tu-2U; Sun, 26 Aug 2007 12:17:03 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <11881450221019-git-send-email->
Message-Id: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56701>

From: J. Bruce Fields <bfields@puzzle.fieldses.org>

The immediate motivation for writing this section was to explain the
various places ignore patterns could be used.  However, I still think
.gitignore is the case most people will want to learn about first.  It
also makes it a bit more concrete to introduce ignore patterns in the
context of .gitignore first.  And the existance of gitignore(5) relieves
the pressure to explain it all here.

So, stick to the .gitignore example, with only a brief mention of the
others, explain the syntax only by example, and leave the rest to
gitignore(5).

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Cc: Johan Herland <johan@herland.net>
---
 Documentation/user-manual.txt |   63 +++++++++++-----------------------------
 1 files changed, 18 insertions(+), 45 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d6caff4..0331bad 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1100,20 +1100,14 @@ backup files made by your editor. Of course, 'not' tracking files with git
 is just a matter of 'not' calling "`git add`" on them. But it quickly becomes
 annoying to have these untracked files lying around; e.g. they make
 "`git add .`" and "`git commit -a`" practically useless, and they keep
-showing up in the output of "`git status`", etc.
+showing up in the output of "`git status`".
 
-Git therefore provides "exclude patterns" for telling git which files to
-actively ignore. Exclude patterns are thoroughly explained in the
-gitlink:gitignore[5] manual page, but the heart of the concept is simply
-a list of files which git should ignore. Entries in the list may contain
-globs to specify multiple files, or may be prefixed by "`!`" to
-explicitly include (un-ignore) a previously excluded (ignored) file
-(i.e. later exclude patterns override earlier ones).  The following
-example should illustrate such patterns:
+You can tell git to ignore certain files by creating a file called .gitignore
+in the top level of your working directory, with contents such as:
 
 -------------------------------------------------
 # Lines starting with '#' are considered comments.
-# Ignore foo.txt.
+# Ignore any file named foo.txt.
 foo.txt
 # Ignore (generated) html files,
 *.html
@@ -1123,41 +1117,20 @@ foo.txt
 *.[oa]
 -------------------------------------------------
 
-The next question is where to put these exclude patterns so that git can
-find them. Git looks for exclude patterns in the following files:
-
-`.gitignore` files in your working tree:::
-	   You may store multiple `.gitignore` files at various locations in your
-	   working tree. Each `.gitignore` file is applied to the directory where
-	   it's located, including its subdirectories. Furthermore, the
-	   `.gitignore` files can be tracked like any other files in your working
-	   tree; just do a "`git add .gitignore`" and commit. `.gitignore` is
-	   therefore the right place to put exclude patterns that are meant to
-	   be shared between all project participants, such as build output files
-	   (e.g. `\*.o`), etc.
-`.git/info/exclude` in your repo:::
-	   Exclude patterns in this file are applied to the working tree as a
-	   whole. Since the file is not located in your working tree, it does
-	   not follow push/pull/clone like `.gitignore` can do. This is therefore
-	   the place to put exclude patterns that are local to your copy of the
-	   repo (i.e. 'not' shared between project participants), such as
-	   temporary backup files made by your editor (e.g. `\*~`), etc.
-The file specified by the `core.excludesfile` config directive:::
-	   By setting the `core.excludesfile` config directive you can tell git
-	   where to find more exclude patterns (see gitlink:git-config[1] for
-	   more information on configuration options). This config directive
-	   can be set in the per-repo `.git/config` file, in which case the
-	   exclude patterns will apply to that repo only. Alternatively, you
-	   can set the directive in the global `~/.gitconfig` file to apply
-	   the exclude pattern to all your git repos. As with the above
-	   `.git/info/exclude` (and, indeed, with git config directives in
-	   general), this directive does not follow push/pull/clone, but remain
-	   local to your repo(s).
-
-[NOTE]
-In addition to the above alternatives, there are git commands that can take
-exclude patterns directly on the command line. See gitlink:git-ls-files[1]
-for an example of this.
+See gitlink:gitignore[5] for a detailed explanation of the syntax.  You can
+also place .gitignore files in other directories in your working tree, and they
+will apply to those directories and their subdirectories.  The `.gitignore`
+files can be added to your repository like any other files (just run `git add
+.gitignore` and `git commit`, as usual), which is convenient when the exclude
+patterns (such as patterns matching build output files) would also make sense
+for other users who clone your repository.
+
+If you wish the exclude patterns to affect only certain repositories
+(instead of every repository for a given project), you may instead put
+them in a file in your repository named .git/info/exclude, or in any file
+specified by the `core.excludesfile` configuration variable.  Some git
+commands can also take exclude patterns directly on the command line.
+See gitlink:gitignore[5] for the details.
 
 [[how-to-merge]]
 How to merge
-- 
1.5.3.rc5.19.g0734d
