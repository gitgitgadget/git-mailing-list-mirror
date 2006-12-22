From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Fri, 22 Dec 2006 01:37:50 -0800
Message-ID: <7vzm9g2rv5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 22 10:38:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxgrH-0007gD-IP
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 10:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946011AbWLVJhw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 04:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946015AbWLVJhw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 04:37:52 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:57275 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946013AbWLVJhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 04:37:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222093750.FZKI15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 04:37:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1ld81W0031kojtg0000000; Fri, 22 Dec 2006 04:37:08 -0500
To: git@vger.kernel.org
X-master-at: 2295e8d0c4cec41fbe257ddb957516a7c1a139df
X-next-at: e228b5351ee4831987e1d1a82d842c92042fd27a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35155>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/rm (Fri Dec 22 01:02:59 2006 -0800) 2 commits
 - t3600: update the test for updated git rm
 - git-rm: update to saner semantics

This still needs 'require -r to descend into directories'
safety.  I'd really want to have this in v1.5.0.

* jc/fsck-reflog (Fri Dec 22 00:46:33 2006 -0800) 8 commits
 + reflog expire: prune commits that are not incomplete
 + Don't crash during repack of a reflog with pruned commits.
 + git reflog expire
 + Move in_merge_bases() to commit.c
 + reflog: fix warning message.
 + Teach git-repack to preserve objects referred to by reflog
   entries.
 + Protect commits recorded in reflog from pruning.
 + add for_each_reflog_ent() iterator

The latest 'reflog expire' hopefully should revive Shawn's
repository and make prune or repack working again for him.

Tip for 'next' users.  fsck and prune consider commits that are
referenced by reflog entries reachable, but your repositories
may have been pruned by earlier 'prune' already, which may cause
repack to barf and refuse.  Please use 'reflog expire --all' to
prune out reflog entries that refer to commits that are already
lost if repack fails in your repository and try again.

Because we have made the reflog enabled by default, I really
would want to have this in v1.5.0 to prevent unbounded growth of
reflog files.

I think none of the rest are 'must have's for v1.5.0.  Perhaps
except for js/rerere series.

* js/rerere (Wed Dec 20 17:39:41 2006 +0100) 3 commits
 + Make git-rerere a builtin
 + Add a test for git-rerere
 + move read_mmfile() into xdiff-interface
* jc/skip-count (Tue Dec 19 18:25:32 2006 -0800) 1 commit
 + revision: --skip=<n>
* jn/web (Sat Dec 16 17:12:55 2006 +0100) 1 commit
 - gitweb: Add some mod_perl specific support
* jc/git-add--interactive (Mon Dec 11 17:09:26 2006 -0800) 2 commits
 + git-add --interactive: hunk splitting
 + git-add --interactive
* jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain
* jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward
* js/shallow (Fri Nov 24 16:00:13 2006 +0100) 15 commits
 + fetch-pack: Do not fetch tags for shallow clones.
 + get_shallow_commits: Avoid memory leak if a commit has been
   reached already.
 + git-fetch: Reset shallow_depth before auto-following tags.
 + upload-pack: Check for NOT_SHALLOW flag before sending a shallow
   to the client.
 + fetch-pack: Properly remove the shallow file when it becomes
   empty.
 + shallow clone: unparse and reparse an unshallowed commit
 + Why didn't we mark want_obj as ~UNINTERESTING in the old code?
 + Why does it mean we do not have to register shallow if we have
   one?
 + We should make sure that the protocol is still extensible.
 + add tests for shallow stuff
 + Shallow clone: do not ignore shallowness when following tags
 + allow deepening of a shallow repository
 + allow cloning a repository "shallowly"
 + support fetching into a shallow repository
 + upload-pack: no longer call rev-list
* jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org
* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.
* jc/diff (Mon Sep 25 23:03:34 2006 -0700) 1 commit
 - para-walk: walk n trees, index and working tree in parallel
* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)
