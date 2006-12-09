X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation/git-commit: rewrite to make it more end-user friendly.
Date: Fri, 08 Dec 2006 21:48:07 -0800
Message-ID: <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612082141260.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 05:48:31 +0000 (UTC)
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612082141260.2630@xanadu.home> (Nicolas Pitre's
	message of "Fri, 08 Dec 2006 21:58:14 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33803>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsv4W-000177-9C for gcvg-git@gmane.org; Sat, 09 Dec
 2006 06:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759033AbWLIFsL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 00:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759088AbWLIFsL
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 00:48:11 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:37418 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759083AbWLIFsJ (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 00:48:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061209054808.MRYD29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Sat, 9
 Dec 2006 00:48:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wVnX1V00M1kojtg0000000; Sat, 09 Dec 2006
 00:47:32 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org


Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * So how about this?

 Documentation/git-commit.txt |  227 ++++++++++++++++++++++++++++--------------
 1 files changed, 154 insertions(+), 73 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 517a86b..8fe42cb 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -14,25 +14,47 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Updates the index file for given paths, or all modified files if
-'-a' is specified, and makes a commit object.  The command specified
-by either the VISUAL or EDITOR environment variables are used to edit
-the commit log message.
+Use 'git commit' when you want to record your changes into the repository
+along with a log message describing what the commit is about. All changes
+to be committed must be explicitly identified using one of the following
+methods:
 
-Several environment variable are used during commits.  They are
-documented in gitlink:git-commit-tree[1].
+1. by using gitlink:git-add[1] to incrementally "add" changes to the
+   next commit before using the 'commit' command (Note: even modified
+   files must be "added");
 
+2. by using gitlink:git-rm[1] to identify content removal for the next
+   commit, again before using the 'commit' command;
+
+3. by directly listing files containing changes to be committed as arguments
+   to the 'commit' command, in which cases only those files alone will be
+   considered for the commit;
+
+4. by using the -a switch with the 'commit' command to automatically "add"
+   changes from all known files i.e. files that have already been committed
+   before, and perform the actual commit.
+
+Note that the contents of the paths that resolved cleanly by a
+conflicted merge are automatically staged for the next commit;
+you still need to explicitly identify what you want in the
+resulting commit using one of the above methods before
+recording the merge commit.
+
+The gitlink:git-status[1] command can be used to obtain a
+summary of what is included by any of the above for the next
+commit by giving the same set of parameters you would give to
+this command.
+
+If you make a commit and then found a mistake immediately after
+that, you can recover from it with gitlink:git-reset[1].
 
-This command can run `commit-msg`, `pre-commit`, and
-`post-commit` hooks.  See link:hooks.html[hooks] for more
-information.
 
 OPTIONS
 -------
 -a|--all::
-	Update all paths in the index file.  This flag notices
-	files that have been modified and deleted, but new files
-	you have not told git about are not affected.
+	Tell the command to automatically stage files that have
+	been modified and deleted, but new files you have not
+	told git about are not affected.
 
 -c or -C <commit>::
 	Take existing commit object, and reuse the log message
@@ -55,16 +77,13 @@ OPTIONS
 -s|--signoff::
 	Add Signed-off-by line at the end of the commit message.
 
--v|--verify::
-	Look for suspicious lines the commit introduces, and
-	abort committing if there is one.  The definition of
-	'suspicious lines' is currently the lines that has
-	trailing whitespaces, and the lines whose indentation
-	has a SP character immediately followed by a TAB
-	character.  This is the default.
-
--n|--no-verify::
-	The opposite of `--verify`.
+--no-verify::
+	By default, the command looks for suspicious lines the
+	commit introduces, and aborts committing if there is one.
+	The definition of 'suspicious lines' is currently the
+	lines that has trailing whitespaces, and the lines whose
+	indentation has a SP character immediately followed by a
+	TAB character.  This option turns off the check.
 
 -e|--edit::
 	The message taken from file with `-F`, command line with
@@ -95,16 +114,16 @@ but can be used to amend a merge commit.
 --
 
 -i|--include::
-	Instead of committing only the files specified on the
-	command line, update them in the index file and then
-	commit the whole index.  This is the traditional
-	behavior.
+	Before making a commit out of staged contents so far,
+	stage the contents of paths given on the command line
+	as well.  This is usually not what you want unless you
+	are concluding a conflicted merge.
 
 -o|--only::
-	Commit only the files specified on the command line.
-	This format cannot be used during a merge, nor when the
-	index and the latest commit does not match on the
-	specified paths to avoid confusion.
+	Commit only the files specified on the command line;
+	this is the default when pathnames are given on the
+	command line, so you usually do not have to give this
+	option.  This format cannot be used during a merge.
 
 \--::
 	Do not interpret any more arguments as options.
@@ -114,50 +133,112 @@ but can be used to amend a merge commit.
 	different between `--include` and `--only`.  Without
 	either, it defaults `--only` semantics.
 
-If you make a commit and then found a mistake immediately after
-that, you can recover from it with gitlink:git-reset[1].
-
-
-Discussion
-----------
-
-`git commit` without _any_ parameter commits the tree structure
-recorded by the current index file.  This is a whole-tree commit
-even the command is invoked from a subdirectory.
-
-`git commit --include paths...` is equivalent to
-
-	git update-index --remove paths...
-	git commit
-
-That is, update the specified paths to the index and then commit
-the whole tree.
-
-`git commit paths...` largely bypasses the index file and
-commits only the changes made to the specified paths.  It has
-however several safety valves to prevent confusion.
-
-. It refuses to run during a merge (i.e. when
-  `$GIT_DIR/MERGE_HEAD` exists), and reminds trained git users
-  that the traditional semantics now needs -i flag.
-
-. It refuses to run if named `paths...` are different in HEAD
-  and the index (ditto about reminding).  Added paths are OK.
-  This is because an earlier `git diff` (not `git diff HEAD`)
-  would have shown the differences since the last `git
-  update-index paths...` to the user, and an inexperienced user
-  may mistakenly think that the changes between the index and
-  the HEAD (i.e. earlier changes made before the last `git
-  update-index paths...` was done) are not being committed.
-
-. It reads HEAD commit into a temporary index file, updates the
-  specified `paths...` and makes a commit.  At the same time,
-  the real index file is also updated with the same `paths...`.
-
-`git commit --all` updates the index file with _all_ changes to
-the working tree, and makes a whole-tree commit, regardless of
-which subdirectory the command is invoked in.
 
+EXAMPLES
+--------
+When recording your own work, the contents of modified files in
+your working tree are temporarily stored to a staging area
+called the "index" with gitlink:git-add[1].  Removal
+of a file is staged with gitlink:git-rm[1].  After building the
+state to be committed incrementally with these commands, `git
+commit` (without any pathname parameter) is used to record what
+has been staged so far.  This is the most basic form of the
+command.  An example:
+
+------------
+$ edit hello.c
+$ git rm goodbye.c
+$ git add hello.c
+$ git commit
+------------
+
+////////////
+We should fix 'git rm' to remove goodbye.c from both index and
+working tree for the above example.
+////////////
+
+Instead of staging files after each individual change, you can
+tell `git commit` to notice the changes to the tracked files in
+your working tree and do corresponding `git add` and `git rm`
+for you.  That is, this example does the same as the earlier
+example if there is no other change in your working tree:
+
+------------
+$ edit hello.c
+$ rm goodbye.c
+$ git commit -a
+------------
+
+The command `git commit -a` first looks at your working tree,
+notices that you have modified hello.c and removed goodbye.c,
+and performs necessary `git add` and `git rm` for you.
+
+After staging changes to many files, you can alter the order the
+changes are recorded in, by giving pathnames to `git commit`.
+When pathnames are given, the command makes a commit that
+only records the changes made to the named paths:
+
+------------
+$ edit hello.c hello.h
+$ git add hello.c hello.h
+$ edit Makefile
+$ git commit Makefile
+------------
+
+This makes a commit that records the modification to `Makefile`.
+The changes staged for `hello.c` and `hello.h` are not included
+in the resulting commit.  However, their changes are not lost --
+they are still staged and merely held back.  After the above
+sequence, if you do:
+
+------------
+$ git commit
+------------
+
+this second commit would record the changes to `hello.c` and
+`hello.h` as expected.
+
+After a merge (initiated by either gitlink:git-merge[1] or
+gitlink:git-pull[1]) stops because of conflicts, cleanly merged
+paths are already staged to be committed for you, and paths that
+conflicted are left in unmerged state.  You would have to first
+check which paths are conflicting with gitlink:git-status[1]
+and after fixing them manually in your working tree, you would
+stage the result as usual with gitlink:git-add[1]:
+
+------------
+$ git status | grep unmerged
+unmerged: hello.c
+$ edit hello.c
+$ git add hello.c
+------------
+
+After resolving conflicts and staging the result, `git ls-files -u`
+would stop mentioning the conflicted path.  When you are done,
+run `git commit` to finally record the merge:
+
+------------
+$ git commit
+------------
+
+As with the case to record your own changes, you can use `-a`
+option to save typing.  One difference is that during a merge
+resolution, you cannot use `git commit` with pathnames to
+alter the order the changes are committed, because the merge
+should be recorded as a single commit.  In fact, the command
+refuses to run when given pathnames (but see `-i` option).
+
+
+ENVIRONMENT VARIABLES
+---------------------
+The command specified by either the VISUAL or EDITOR environment
+variables is used to edit the commit log message.
+
+HOOKS
+-----
+This command can run `commit-msg`, `pre-commit`, and
+`post-commit` hooks.  See link:hooks.html[hooks] for more
+information.
 
 Author
 ------
-- 
1.4.4.2.g7d2d-dirty

