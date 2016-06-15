From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2008, #08; Wed, 27)
Date: Wed, 27 Aug 2008 19:54:56 -0700
Message-ID: <7v3akpkfwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 04:56:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXgM-0002Yt-EL
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbYH1CzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 22:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbYH1CzH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:55:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYH1CzE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 22:55:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 11E7553314;
	Wed, 27 Aug 2008 22:55:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 17C3053312; Wed, 27 Aug 2008 22:54:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4FC3D3E-74AC-11DD-86C6-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94030>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

----------------------------------------------------------------
[New Topics]

* dk/emacs (Tue Aug 26 22:24:40 2008 -0500) 2 commits
 - Teach git.el to mark/unmark files by regexp
 - git.el: Diff only file at point by default

With my limited elisp expertise I did not see anything obviously wrong
with these two patches from David K=C3=A5gedal and David Christensen.

* tl/p4 (Thu Aug 28 00:36:12 2008 +0200) 1 commit
 - git-p4: Fix checkout bug when using --import-local.

A fix forked from 'maint' waiting for an Ack.

----------------------------------------------------------------
[Stalled -- Needs Action to Proceed (or to be dropped)]

* bd/blame (Thu Aug 21 18:22:01 2008 -0500) 5 commits
 . Use xdiff caching to improve git blame performance
 . Allow xdiff machinery to cache hash results for a file
 . Always initialize xpparam_t to 0
 . Bypass textual patch generation and parsing in git blame
 . Allow alternate "low-level" emit function from xdl_diff

R=C3=A9ne had good comments on how the callback should be structured.

* jc/maint-name-hash-clear (Sat Aug 23 13:05:10 2008 -0700) 1 commit
 - discard_cache: reset lazy name_hash bit

I spotted this by accident while working on something unrelated.

When a program calls discard_cache() to read the index again, we do not
properly re-initialize the name_hash structure that is used by the case
insensitivitly logic.  This _might_ improve issues people may be having=
 on
case insensitive filesystems.  I dunno.

* jc/cc-ld-dynpath (Sat Aug 16 15:01:23 2008 +0200) 2 commits
 - configure: auto detect dynamic library path switches
 - Makefile: Allow CC_LD_DYNPATH to be overriden

Needs success reports from people who do use user-defined dynamic libra=
ry
path when they build their "git" before this series can go anywhere.

* lt/time-reject-fractional-seconds (Sat Aug 16 21:25:40 2008 -0700) 1 =
commit
 - date/time: do not get confused by fractional seconds

Linus hints further enhancements as "the right way", so let's see if
somebody else steps up and tries it before merging this to 'next'.

----------------------------------------------------------------
[Actively Cooking]

* sb/daemon (Sun Aug 24 13:27:10 2008 -0700) 5 commits
 + daemon.c: minor style fixup
 + git-daemon: rewrite kindergarden, new option --max-connections
 + git-daemon: Simplify dead-children reaping logic
 + git-daemon: use LOG_PID, simplify logging code
 + git-daemon: call logerror() instead of error()

I re-reviewed the changes and they look quite sane.  Hopefully be moved=
 to
'master' soonish.

* jc/add-ita (Thu Aug 21 01:44:53 2008 -0700) 3 commits
 - git-add --intent-to-add (-N)
 - cached_object: learn empty blob
 - sha1_object_info(): pay attention to cached objects

Teaches "git add" to record only the intent to add a path later.
I think this is better done without the hardcoded empty blob object.

* cc/bisect (Fri Aug 22 05:52:29 2008 +0200) 2 commits
 + bisect: only check merge bases when needed
 + bisect: test merge base if good rev is not an ancestor of bad rev

* mv/merge-recursive (Mon Aug 25 16:25:57 2008 +0200) 3 commits
 - merge-recursive: introduce merge_options
 - merge-recursive.c: Add more generic merge_recursive_generic()
 - Split out merge_recursive() to merge-recursive.c

Miklos's update; will move to 'next' shortly after reading it again.

* jc/diff-prefix (Mon Aug 18 20:08:09 2008 -0700) 1 commit
 - diff: vary default prefix depending on what are compared

As some people may have noticed, I've been running with this one when
sending out "How about this" patches to the discussion threads.

* sp/missing-thin-base (Tue Aug 12 11:31:06 2008 -0700) 1 commit
 + pack-objects: Allow missing base objects when creating thin packs

* tr/filter-branch (Tue Aug 12 10:45:59 2008 +0200) 7 commits
 + filter-branch: use --simplify-merges
 + filter-branch: fix ref rewriting with --subdirectory-filter
 + filter-branch: Extend test to show rewriting bug

=46ixes a longstanding filter branch bug.  Success stories?
Later parts depends on the earlier part of "--simplify-merges"

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 8 commits
 - revision --simplify-merges: incremental simplification
 - revision --simplify-merges: prepare for incremental simplification
 - revision --simplify-merges: make it a no-op without pathspec
 + revision --simplify-merges: do not leave commits unprocessed
 + revision --simplify-merges: use decoration instead of commit->util
   field
 + Topo-sort before --simplify-merges
 + revision traversal: show full history with merge simplification
 + revision.c: whitespace fix

"log --full-history" is with too much clutter, "log" itself is too clev=
erer
than some people, and here is the middle level of merge simplification.

I started making this incremental but the progress is not so great.

* tr/rev-list-docs (Tue Aug 12 01:55:37 2008 +0200) 5 commits
 + Documentation: rev-list-options: move --simplify-merges
   documentation

----------------------------------------------------------------
[On Hold]

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

* jc/merge-whitespace (Sun Feb 24 23:29:36 2008 -0800) 1 commit
 - WIP: start teaching the --whitespace=3Dfix to merge machinery

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

This was previously in "will be in master soon" category, but it turns =
out
that the synonyms to the ones this one deletes are fairly new invention
that happend in 1.5.6 timeframe, and we cannot do this just yet.  Perha=
ps
in 1.7.0, but with the loud whining about moving git-foo out of $PATH w=
e
have been hearing, it might not be a bad idea to drop this.

* jc/dashless (Wed Jun 25 15:55:11 2008 -0700) 1 commit
 . Make clients ask for "git program" over ssh and local transport

And this is now dropped.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will=
 be
hit due to tcl/tk's limitation, so I am holding this back for now.

----------------------------------------------------------------
[Graduated to "master"]

* mv/maint-merge-fix (Sat Aug 23 12:56:57 2008 -0700) 1 commit
 + merge: fix numerus bugs around "trivial merge" area

* ml/submodule (Thu Aug 21 19:54:01 2008 -0400) 2 commits
 + git-submodule.sh - Remove trailing / from URL if found
 + git-submodule.sh - Remove trailing / from URL if found

Soon to be in 'master', I guess.

* np/verify-pack (Fri Aug 22 15:45:53 2008 -0400) 1 commit
 + discard revindex data when pack list changes

* jc/no-slim-shell (Tue Aug 19 18:05:43 2008 -0700) 2 commits
 + Build-in "git-shell"
 + shell: do not play duplicated definition games to shrink the
   executable

* mv/merge-custom (Sat Aug 23 19:23:22 2008 -0700) 9 commits
 + t7606: fix custom merge test
 + Fix "git-merge -s bogo" help text
 + Update .gitignore to ignore git-help
 + Builtin git-help.
 + builtin-help: always load_command_list() in cmd_help()
 + Add a second testcase for handling invalid strategies in git-merge
 + Add a new test for using a custom merge strategy
 + builtin-merge: allow using a custom strategy
 + builtin-help: make some internal functions available to other
   builtins

The one at the tip fixes a test that assumed git-merge has a broken
"trivial merge" implementation.

* jc/add-addremove (Tue Jul 22 22:30:40 2008 -0700) 2 commits
 + builtin-add.c: optimize -A option and "git add ."
 + builtin-add.c: restructure the code for maintainability

* am/cherry-pick-rerere (Sun Aug 10 17:18:55 2008 +0530) 1 commit
 + Make cherry-pick use rerere for conflict resolution.
