X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Documentation/git-commit.txt
Date: Fri, 08 Dec 2006 21:58:14 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612082141260.2630@xanadu.home>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 9 Dec 2006 02:58:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33793>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GssPy-0006xK-9d for gcvg-git@gmane.org; Sat, 09 Dec
 2006 03:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756807AbWLIC6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 21:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758606AbWLIC6Q
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 21:58:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13482 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1756807AbWLIC6P (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 21:58:15 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9Z002XYK92HK90@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Fri,
 08 Dec 2006 21:58:15 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 8 Dec 2006, Junio C Hamano wrote:

> I attempted to rewrite the git-commit documentation.
> 
> I think I went overboard and ended up not using the word
> "index", but eradicating the word was not my intention.  I think
> we should hint how the index is used to implement the semantics
> somewhere near the end where it is not distracting to ordinary
> users but is accessbile by people who are interested in the
> plumbing-Porcelain interface. 
[...]

Frankly I feel unconfortable with this.

1) too many examples.

Yes, examples are good, but somehow there is something in the current 
text that make me feel they are not providing the clarification they 
should.  Dunno... I think I'd still push them after option list.

2) explanation of how to resolve and commit a conflicting merge should 
   really be found in git-merge.txt not in git-commit.txt.

It feels a bit awkward to suddenly start talking about git ls-files and 
merge here.  It would be much clearer to simply say "when done just 
commit your changes as usual" in the merge doc than bringing in merge 
concepts in the commit doc.

[...]

I started to insert my comments inline, but at some point it became too 
messy.  So I decided to give it a try of my own instead.  Here what I 
think would be a better direction for improving the commit man page 
(would need a few examples inserted towards the end like usual, and the 
env vars too):

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 517a86b..6a9cec9 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -14,25 +14,43 @@ SYNOPSIS
 
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
+1) by using gitlink:git-add[1] to incrementally "add" changes to the
+   next commit before using the 'commit' command (Note: even modified
+   files must be "added");
 
+2) by using gitlink:git-rm[1] to identify content removal for the next
+   commit, again before using the 'commit' command;
+
+3) by directly listing files containing changes to be committed as arguments
+   to the 'commit' command, in which cases only those files alone will be
+   considered for the commit;
+
+4) by using the -a switch with the 'commit' command to automatically "add"
+   changes from all known files i.e. files that have already been committed
+   before, and perform the actual commit.
+
+The 'git status' command can be used to obtain a summary of what is included
+by (1) and (2) for the next commit.
+
+If you make a commit and then found a mistake immediately after
+that, you can recover from it with gitlink:git-reset[1].
 
 This command can run `commit-msg`, `pre-commit`, and
 `post-commit` hooks.  See link:hooks.html[hooks] for more
 information.
 
+
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
@@ -95,68 +113,18 @@ but can be used to amend a merge commit.
 --
 
 -i|--include::
-	Instead of committing only the files specified on the
-	command line, update them in the index file and then
-	commit the whole index.  This is the traditional
-	behavior.
-
--o|--only::
-	Commit only the files specified on the command line.
-	This format cannot be used during a merge, nor when the
-	index and the latest commit does not match on the
-	specified paths to avoid confusion.
+	Before making a commit out of staged contents so far,
+	stage the contents of paths given on the command line
+	as well.  This is usually not what you want unless you
+	are concluding a conflicted merge.
 
 \--::
 	Do not interpret any more arguments as options.
 
 <file>...::
-	Files to be committed.  The meaning of these is
-	different between `--include` and `--only`.  Without
-	either, it defaults `--only` semantics.
-
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
+	Files to be committed.  If provided, only those files are
+	considered FOR COMMIT.  If `-i` or `--include` is also provided
+	then the staged content is included as well.
 
 
