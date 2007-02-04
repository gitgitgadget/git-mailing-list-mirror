From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sun, 04 Feb 2007 01:36:29 -0800
Message-ID: <7vps8qtgbm.fsf@assigned-by-dhcp.cox.net>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 10:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDdnX-0007aZ-9C
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 10:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbXBDJgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 04:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbXBDJgc
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 04:36:32 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:63770 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752188AbXBDJgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 04:36:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204093630.UVRZ1343.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 04:36:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KMcW1W0011kojtg0000000; Sun, 04 Feb 2007 04:36:30 -0500
X-maint-at: 6534141151f7fd4334f62827d9234acf3974ca4d
X-master-at: ec8048913217d8ff6e54950a0cb8ab2e739a1d1f
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38672>

Thanks everybody for helping to tie the loose ends for the next
release.

Thanks to Nico's handful updates, I think his "reflog on HEAD
itself" series is ready for inclusion, although tonight's update
still has it parked in 'next' (I did try out 'next' with his
latest for a couple of hours today).  I've already updated the
draft release notes for 1.5.0 (v1.5.0.txt in todo branch), with
its inclusion in mind.

I've re-read the three tutorials and tried to fix them up
somewhat to match the recent reality.  I'd appreciate somebody
can look at JBF's user manual.

Several things to note (in the following, substitute $gmane with
http://article.gmane.org/gmane.comp.version-control.git):

 - Working around Tk geometry problem, especially on non Linux+X
   platforms.  I've forwarded Mark Levedahl's patches
   ($gmane/38361) to Paul Mackerras for his blessing; hopefully
   he can Ack and/or suggest improvements.  I'd really like to
   have them in 1.5.0 in some form.

 - Nico's "reflog on HEAD".  I'll merge this tomorrow (I just
   ran out of time today).  I will re-try to break its "git
   reflog expire --stale-fix --all" before actually merging it,
   though.

 - Reverting the patch to allow tracking branch names as the
   value of branch.*.merge ($gmane/38621).  I think it is a good
   idea to revert this before 1.5.0 gets out; just haven't got
   around to do so.

 - Teaching "git blame" to also use the working tree files
   and/or index.  I actually think defaulting to working tree
   when an explicit HEAD is not given (and --cached to use the
   one in the index) makes a lot of sense, but I haven't got
   around to code the latter yet.  Not defaulting to HEAD
   changes semantics, so if we ever are going to do it, I think
   we should do so before 1.5.0.

 - Preventing push from updating the current branch of non-bare
   repository.  I think doing so unconditionally is a bad idea
   (and I have Linus's veto to back it up $gmane/38592), but I
   suspect most people would want the default to be less
   confusing to new people.  If we are ever going to forbid by
   default and allow pusher to force, that would be a behaviour
   change and it would be better to do so before 1.5.0.

 - We might want to allow git-push to use the wildcard refspec,
   like git-fetch does, for symmetry.  It would make the
   mothership-satellite arrangement much more natural
   ($gname/38549).  Unfortunately I haven't had a chance to
   start coding it.  I think however this could be added post
   1.5.0.

 - "git remote add -t -f -m" and rewrite of "git clone" based on
   it ($gmane/38470, $gmane/38545).  While I think this leads us
   in right direction, I do not think 1.5.0 needs to wait for
   it.  Certainly I do not want to reimplement "git clone"
   before 1.5.0, although I think the additions to "git remote add"
   are relatively safe.

 - Catering to filesystems whose readdir() returns pathnames
   that are different from what are used when they were creat()ed
   will not happen ($gmane/38620).


* The 'master' branch has these since v1.5.0-rc3.

 Andy Parkins (1):
  doc: hooks.txt said post-commit default sends an email, it doesn't

 Eric Wong (2):
  git-svn: do not let Git.pm warn if we prematurely close pipes
  Disallow invalid --pretty= abbreviations

 Johannes Schindelin (2):
  Teach the '@{...}' notation to git-log -g
  Update the documentation for the new '@{...}' syntax

 Junio C Hamano (9):
  detached HEAD -- finishing touches
  Use "git checkout -q" in git-bisect
  Tutorial: fix asciidoc formatting of "git add" section.
  Tutorial-2: Adjust git-status output to recent reality.
  core-tutorial: http reference link fix
  fix reflog entries for "git-branch"
  honor GIT_REFLOG_ACTION in git-commit
  Why is it bad to rewind a branch that has already been pushed out?
  combine-diff: special case --unified=0

 Mike Coleman (1):
  Fix some documentation typos and grammar

 Nicolas Pitre (4):
  reword the detached head message a little again
  add a quiet option to git-checkout
  prevent HEAD reflog to be interpreted as current branch reflog
  provide a nice @{...} syntax to always mean the current branch reflog

 Pavel Roskin (2):
  git-config --rename-section could rename wrong section
  Assorted typo fixes

 Shawn O. Pearce (18):
  Pull out remote listing functions in git-remote.
  Teach 'git remote' how to cleanup stale tracking branches.
  Cleanup prepare_packed_git_one to reuse install_packed_git.
  Correct comment in prepare_packed_git_one.
  Refactor open_packed_git to return an error code.
  Don't find objects in packs which aren't available anymore.
  Don't leak file descriptors from unavailable pack files.
  Cleanup subcommand documentation for git-remote.
  Keep untracked files not involved in a merge.
  Default GIT_MERGE_VERBOSITY to 5 during tests.
  bash: Remove short option completions for branch/checkout/diff.
  bash: Classify cat-file and reflog as plumbing.
  bash: Complete long options to git-add.
  bash: Add space after unique command name is completed.
  bash: Classify more commends out of completion.
  bash: Support unique completion on git-config.
  bash: Support unique completion when possible.
  bash: Support internal revlist options better.
