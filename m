From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Tue, 13 Mar 2007 01:49:48 -0700
Message-ID: <7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	<7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 09:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR2hl-0001tf-8a
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 09:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbXCMItu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 04:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbXCMItu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 04:49:50 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:57385 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbXCMItt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 04:49:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070313084949.ISUT748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Mar 2007 04:49:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a8po1W00E1kojtg0000000; Tue, 13 Mar 2007 04:49:48 -0400
X-master-at: 27ebd6e0443bdd795869f598ecebc9eadd64a26c
X-next-at: bf75cf511bfc53ad0b60efb9b984f0b2b83d4580
In-Reply-To: <7v7itx5mep.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 04 Mar 2007 02:32:46 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42108>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.


* sp/run-command (Mon Mar 12 19:00:29 2007 -0400) 9 commits
 + Use run_command within send-pack
 + Use run_command within receive-pack to invoke index-pack
 + Use run_command within merge-index
 + Use run_command for proxy connections
 + Use RUN_GIT_CMD to run push backends
 + Correct new compiler warnings in builtin-revert
 + Replace fork_with_pipe in bundle with run_command
 + Teach run-command to redirect stdout to /dev/null
 + Teach run-command about stdout redirection

This is really internal clean-up without behaviour change (but I
suspect the error messages from failure cases might be
different).  Good to flush these to 'master' before 1.5.1-rc1.

* dz/mailinfo (Mon Mar 12 15:52:07 2007 -0400) 3 commits
 + Add a couple more test cases to the suite.
 + restrict the patch filtering
 + builtin-mailinfo.c infrastrcture changes

The mailinfo implementation in 'master' I punted to do
complicated multi-part and Don Zickus rewrote much of the hacky
parts.  The less hacky code of mine remains in the tree, the
happier I am.  Should be in 'master' before 1.5.1-rc1.

* jc/repack (Fri Mar 9 03:52:12 2007 -0800) 1 commit
 + prepare_packed_git(): sort packs by age and localness.

This is to improve the access pattern when repository has many
small packfiles, as recent push/fetch tend to keep packs
unexploded.  The idea is to check younger packs and local packs
before others when we iterate over .idx files to look for packed
objects from find_pack_entry().  I've repacked linux-2.6 kernel
repository so that it has one pack per one public tag (which is
a bit excessive -- it results in 70 or so small packs), and saw
"git log -r --raw v2.6.20.." got some speed-up in hot cache case
(4.4 seconds vs 5.3 seconds on average).

* jc/fetch (Sun Mar 4 15:36:08 2007 -0800) 15 commits
 + .gitignore: add git-fetch--tool
 + builtin-fetch--tool: fix reflog notes.
 + git-fetch: retire update-local-ref which is not used anymore.
 + builtin-fetch--tool: make sure not to overstep ls-remote-result
   buffer.
 + fetch--tool: fix uninitialized buffer when reading from stdin
 + builtin-fetch--tool: adjust to updated sha1_object_info().
 + git-fetch--tool takes flags before the subcommand.
 + Use stdin reflist passing in git-fetch.sh
 + Use stdin reflist passing in parse-remote
 + Allow fetch--tool to read from stdin
 + git-fetch: rewrite expand_ref_wildcard in C
 + git-fetch: rewrite another shell loop in C
 + git-fetch: move more code into C.
 + git-fetch--tool: start rewriting parts of git-fetch in C.
 + git-fetch: split fetch_main into fetch_dumb and fetch_native

This is a partial C rewrite of heaviest part of git-fetch to
help fetching between repositories with hundreds of refs.  I do
not like the way it is split, but it may be a good idea to throw
it in 'master' as it does not seem to regress anything and see
if there are other interested people who want to finish the
rewriting.

* pb/branch-track (Thu Mar 8 13:59:54 2007 -0800) 2 commits
 + Fix broken create_branch() in builtin-branch.
 + git-branch, git-checkout: autosetup for remote branch tracking

As I personally do not use "git branch --track", all I can say
is that this, with the fix-up patch already in, does not seem to
regress anything.  Positive feedbacks requested before advancing
to 'master'.

* jb/per-user-exclude (Tue Feb 27 22:31:10 2007 -0500) 1 commit
 + add: Support specifying an excludes file with a configuration
   variable

Same as above.

* ml/workdir (Sun Mar 11 22:29:06 2007 +0100) 3 commits
 - use $GIT_DIR/workdir as working directory with $GIT_DIR
 - introduce GIT_WORK_DIR environment variable
 - rev-parse: --is-bare-repository option

Not in 'next' yet, but I think this one is ready to be tested.
We need testsuite for it before that happens, though.

* js/fetch-progress (Sun Feb 25 13:13:17 2007 -0800) 1 commit
 + git-fetch: add --quiet

This does not break anything, but I am not sure how useful it
would be.

* sb/fetch (Mon Mar 12 19:01:11 2007 -0700) 19 commits
 + git-fetch.sh:append_fetch_head() no longer has a remote_nick
   argument
 + git-fetch: Split fetch and merge logic

I have a soft spot to anything that claims to be a clean-up, but
I suspect that the shell loop this series introduces may defeat
the git-fetch--tool optimization.  Also I think having to base
the patch on this made Paolo's "dot is special token to mean
'git pull' merges from a local branch" needlessly complex (but I
haven't tried rewriting it myself without these two).  Although
I merged these to 'next', I am considering to revert them.

* jc/pathattr (Thu Mar 1 01:20:21 2007 -0800) 5 commits
 - pathattr: allow piping to external program.
 - pathattr: read from git_config().
 - git-show: use pathattr to run "display"
 - pathattr: path based configuration of various attributes.
 + convert: add scaffolding for path based selection of conversion
   routines.

Stalled.

* jc/merge-subtree (Thu Feb 15 16:32:45 2007 -0800) 1 commit
 - A new merge stragety 'subtree'.

Stalled.

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

Just a reference code.
