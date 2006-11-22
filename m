X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [Patch to DRAFT 2 (2/2)] Branching and merging with git
Date: Wed, 22 Nov 2006 03:02:50 -0800
Message-ID: <7vlkm3u4kl.fsf@assigned-by-dhcp.cox.net>
References: <7vslghftix.fsf@assigned-by-dhcp.cox.net>
	<20061120235136.4841.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 11:03:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32078>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmpsW-0003oH-S7 for gcvg-git@gmane.org; Wed, 22 Nov
 2006 12:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162060AbWKVLCx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 06:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162063AbWKVLCx
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 06:02:53 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42644 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1162060AbWKVLCv
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 06:02:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122110251.DCQB4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Wed, 22
 Nov 2006 06:02:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id pn2y1V00M1kojtg0000000; Wed, 22 Nov 2006
 06:02:59 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

This comes on top of the ispell'ed one to correct technical
details:

* We made describe output to be a valid object name some time ago.

* With recent addition to take directory names and path patterns,
  it is not limited to "small number of files" case anymore.

* The original about separate-remote was full of half sentences
  so I stitched them together to make them make some sense.

* Sorry, I recently applied the same "fix" as Cogito got quite
  some time ago, and  both lightweight and annotated tags are
  now followed upon a tracking fetch.

* rsync has been deprecated for quite some time.

* The official party line for git-native-over-ssh is host:path

* Octopus should be discouraged unless talking about truly
  trivial merges.  Explain its downside better.

* Amend is a lot handier than --no-commit, as you do not have to
  plan ahead.  We should encourage "Pull/merge normally and if
  the result is not what you like, amend it" workflow.

--- a/doc
+++ b/doc
@@ -278,11 +278,14 @@
 
 Third is git-describe.  This is something like git-name-rev, but
 backwards: it finds the closest reference that is an ancestor of the
-specified commit.  Its output is not acceptable git input, but takes
-the form of either
+specified commit.  It takes the form of either
+
 	v1.2		(tag name), or
 	v1.2-g12345678	(commit 12345678, whose nearest ancestor is v1.2)
 
+and it is accepted as an input if the abbreviated object name that follows
+"tagname-g" prefix is unambiguous.
+
 git-describe's output is intended to be used as a software version
 number, something like the "rcsid" feature in RCS and CVS.
 By default, git-describe uses only heavyweight tags for its naming,
@@ -345,13 +348,14 @@
    in the working directory.  This option can be used with no <branch>
    specified (defaults to HEAD) to undo local edits.
 
-2) Revert changes to a small number of files.
+2) Revert changes to the files in the working tree.
 
 	git checkout [<revision>] [--] <paths>
    will copy the version of the <paths> from the index to the working
    directory.  If a <revision> is given, the index for those paths will
    be updated from the given revision before copying from the index to
-   the working tree.
+   the working tree.  <paths> can name directories, and/or contain
+   glob patterns to revert many files.
 
    Unlike the version with no <paths> specified, this does NOT change
    HEAD, even if <paths> is ".".
@@ -782,18 +786,12 @@
 default in future), that places copies of the remote servers' heads
 under .git/refs/remotes/<server>/<branch>.
 
-Then you can refer to
-
-If you use "git-line --use-separate-remote", it will set
-
-If you want to use the "separate remotes" tracking branch
-There's an alternate way, using the --use-separate-remote option
-to git-clone.  This sets up a copy of the remote server's heads
-under .git/refs/remotes/origin/<name>.  Then you can refer to
-"origin/<branch>" whenever you want.
+If you use "git-clone --use-separate-remote", it sets up a copy of
+the remote server's heads under .git/refs/remotes/origin/<name>.
+Then you can refer to "origin/<branch>" whenever you want.
 
 Because the branch names are got under .git/refs/heads, the git
-tools will not let you commit to the branch.
+tools will not let you commit to the remote branchbranch.
 
 * Remotes files
 
@@ -877,7 +875,7 @@
 * Remote tags
 
 When you fetch to a tracking branch, git-fetch also fetches every
-heavyweight tag (one that involves an actual tag object) that
+tag under .git/refs/tags/ in the remote repository that
 points to a commit reachable from the branch head and installs a
 copy locally.
 
@@ -913,11 +911,19 @@
 
    http clients also need some extra index information to help them
    find which pack files they need.  git-update-server-info is the
-   command that generates these files, but it's run automatically
-   from git-repack, so it's not too important to know.
+   command that generates these files, and it is important to keep
+   them up-to-date.  A recommended practice is to have this command in
+   .git/hooks/update so that every time you push into the repository
+   they are automatically updated.  You can enable the hook (which
+   is installed when the repository is initialized) with "chmod +x".
+
+   In addition to http://, https:// and ftp:// URL are allowed and
+   handled by the same backend that uses cURL library.
 
 2) rsync protocol.  This is basically an alternative to http, and
-   has the same strictures and limitations.
+   has the same strictures and limitations.  This is deprecated and
+   its use has been discouraged for quite some time, although it still
+   works.
 
 3) The git protocol.  This is represented with a git:// URL, and talks
    to a dedicated git daemon (see the git-daemon man page) on the
@@ -929,8 +935,9 @@
    require any special care when repacking.  git-daemon is purposefully
    written to provide read-only service.
 
-4) The git protocol over ssh.  This is a git+ssh:// URL; ssh:// is
-   accepted as a synonym.  It has the same efficiency issues as
+4) The git protocol over ssh.  This is spelled as "host:path" like scp
+   command, and ssh:// URL and git+ssh:// are
+   accepted as synonyms.  It has the same efficiency issues as
    plain git.  If you want to limit ssh users to just the git commands
    necessary to share work, git provides a git-shell command that can
    be used as a very limited login shell.
@@ -1046,7 +1053,7 @@
 
 
 Now, you can also specify a remote repository to merge from, using a
-git://, http:// or git+ssh:// URL.  This is what Linus does all day
+git:// or  http:// URLs or host:path syntax.  This is what Linus does all day
 long, and why the git-pull tool is optimized to allow that.  It uses
 git-fetch to fetch the remote branch without assigning it a branch name
 (as mentioned above, it gets the magic name FETCH_HEAD), and them merges
@@ -1213,15 +1220,15 @@
 what's already there, enter "5401f304" instead, and click "Goto".)
 
 The octopus strategy is invoked automatically when you specify more
-than one branch at a time to merge in with "git pull".  It can't handle
-complicated overlaps and file renames as well as the 2-way recursive
+than one branch at a time to merge in with "git pull".  It refuses to
+handle complicated overlaps and file renames as well as the 2-way recursive
 strategy, but if you have a number of simple, independent changes that you
 want to merge together, an octopus merge is the obvious way to document
 the fact that they're truly independent.
 
-The only downside to using an octopus to combine a number of simple
-changes is that any merge makes git-bisect's job harder.  If you have
-a development history like
+A major downside to using an octopus to combine a number of 
+changes is that an octopus merge makes git-bisect's job harder.
+If you have a development history like
 
     /-b-\
    /     \
@@ -1234,9 +1241,15 @@
     \-f-/
 
 And you know that a works but g doesn't, there's no way to do a binary
-search on b through f; they have to be searched linearly.  This is
-no harder to bisect, and a lot nicer-looking than the equivalent with
-2-way merges:
+search on b through f; they have to be searched linearly.  In
+addition, a merge tends to become more error prone as it has more
+parents.  Your bisect could show that all of b, c, d, e, f are good
+and the error is in a mismerge at g.  This is why the octopus strategy
+refuses to do anything other than a very simple merge.
+
+Although an octopus is somewhat nicer-looking than the equivalent with
+a series of 2-parent merges, the latter is a lot more efficient to
+bisect:
 
     /-b
    /   \
@@ -1248,7 +1261,12 @@
    \         /
     \-f-----/
 
-But if they were just done one after the other, you'd have
+With this structure, if bisecting at h proves that it was Ok,
+then you do not have to check b, c, d, g (the error must be in e, f
+or mismerge at i or j).
+
+Even simpler to bisect is if they were just done one after the other.
+In such a case, you'd have:
 
 --a--b--c--d--e--f--
 
@@ -1410,6 +1428,9 @@
 
 In many cases, this is fine, and you can save it and complete the
 commit.  Or you can add something about the merge if it needs saying.
+If the merge was complex, it will turn out to be useful to describe
+how you choose to resolve conflicts, and that is the primary reason
+the boilerplate lists conflicted files.
 
 When I'm done, if I don't need branch A any more, I can
 
@@ -1763,11 +1784,11 @@
 the changelog.  It could have been a separate commit, but didn't seem
 worth it.
 
-This was done by forcing the git-pull to not commit:
+This was done by amending the merge commit.
 
-	git pull --no-commit . <branch>
+	git pull . <branch>
 	(edit as desired)
-	git commit
+	git commit --amend -a
 
 The commit message should be edited to explain that this is not just
 a normal merge, as was done in this case.
