X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Wed, 20 Dec 2006 13:21:44 -0800
Message-ID: <7vejqu8dqv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 21:22:22 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-master-at: 54851157acf707eb953eada2a84830897dde5c1d
X-next-at: 545bc003712097e3f2d6252c8fd397551c4e61f5
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34962>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx8t7-0006sx-ID for gcvg-git@gmane.org; Wed, 20 Dec
 2006 22:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030279AbWLTVVt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 16:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWLTVVt
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 16:21:49 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:59151 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030279AbWLTVVr (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 16:21:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220212147.PBHY7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 16:21:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 19M31W0081kojtg0000000; Wed, 20 Dec 2006
 16:21:05 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* js/rerere (Wed Dec 20 17:39:41 2006 +0100) 3 commits
 - Make git-rerere a builtin
 - Add a test for git-rerere
 - move read_mmfile() into xdiff-interface

Rewrite of rerere in C by Johannes; this is supposed to contain
no feature change, and I should be able to merge it anytime when
it is shown to be correct.  We'll see.

* jc/skip-count (Tue Dec 19 18:25:32 2006 -0800) 1 commit
 + revision: --skip=<n>

This could help gitweb, but otherwise no strong reason to merge
to 'master' yet.

* jc/leftright (Tue Dec 19 02:28:16 2006 -0800) 4 commits
 + Revert "Make left-right automatic."
 + Make left-right automatic.
 + Teach all of log family --left-right output.
 + rev-list --left-right

Since I reverted the 'automatic' bits, this is ready to be
merged to 'master'.  Perhaps in v1.5.0.

* jc/fsck-reflog (Tue Dec 19 00:23:12 2006 -0800) 6 commits
 - git reflog expire
 - Move in_merge_bases() to commit.c
 - reflog: fix warning message.
 - Teach git-repack to preserve objects referred to by reflog
   entries.
 - Protect commits recorded in reflog from pruning.
 - add for_each_reflog_ent() iterator

Because reflogs are enabled by default in end user repositories
now, this series will be needed sooner or later.  The earlier
ones prevent commits lost by reset/rebase from getting pruned
while reflogs point at them, while the latter ones allow reflogs
to be pruned.  Earlier parts cannot be merged without the expiry
mechanism in the later ones, because doing so would mean crufts
will accumulate not just in reflogs but in object database,
without an easy way to prune them.

* jc/clone (Tue Dec 19 01:39:07 2006 +0100) 10 commits
 + Move "no merge candidate" warning into git-pull
 + Use preprocessor constants for environment variable names.
 + Do not create $GIT_DIR/remotes/ directory anymore.
 + Introduce GIT_TEMPLATE_DIR
 + Revert "fix testsuite: make sure they use templates freshly built
   from the source"
 + fix testsuite: make sure they use templates freshly built from the
   source
 + git-clone: lose the traditional 'no-separate-remote' layout
 + git-clone: lose the artificial "first" fetch refspec
 + git-pull: refuse default merge without branch.*.merge
 + git-clone: use wildcard specification for tracking branches

This is to conclude the move of the default repository layout
created by git-clone to separate-remote layout.  I think this is
ready and the next push would include this in the 'master'.

* jc/branch-remove-remote (Tue Dec 19 09:42:16 2006 +1100) 2 commits
 + git-branch -d: do not stop at the first failure.
 + Teach git-branch to delete tracking branches with -r -d

Will merge.

* jc/blame (Mon Dec 18 14:04:38 2006 -0800) 1 commit
 + blame: -b (blame.blankboundary) and --root (blame.showroot)

Will merge.

* jn/web (Sat Dec 16 17:12:55 2006 +0100) 1 commit
 - gitweb: Add some mod_perl specific support

On hold, Jakub's call.

* ew/svn-pm (Fri Dec 15 23:58:08 2006 -0800) 3 commits
 + git-svn: rename 'commit' command to 'set-tree'
 + git-svn: remove support for the svn command-line client
 + git-svn: convert to using Git.pm

I've heard a few comments that renaming 'commit' to 'set-tree'
are received favorably by users, so this might be ready to be
merged.  Eric's call, but I am not in the rush.

* jc/git-add--interactive (Wed Dec 20 13:06:46 2006 -0800) 3 commits
 . git-add: error out when given no arguments.
 + git-add --interactive: hunk splitting
 + git-add --interactive

This is a bit too young and I am not sure how useful it is in
practice.  I might cherry-pick its tip to 'master' first without
adding the --interactive bits.

* jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain

Probably not in v1.5.0.

* jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward

Not in v1.5.0.

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

Post v1.5.0.

* jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org
* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.
* jc/diff (Mon Sep 25 23:03:34 2006 -0700) 1 commit
 - para-walk: walk n trees, index and working tree in parallel
* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

The above four are on hold.
