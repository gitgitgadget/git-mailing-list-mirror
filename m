From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 09 Apr 2008 02:43:38 -0700
Message-ID: <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 11:48:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjWvJ-0004Qy-Uk
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 11:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbYDIJsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 05:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYDIJsO
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 05:48:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbYDIJsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 05:48:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 161F315BB2;
	Wed,  9 Apr 2008 05:44:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AE7B215BB1; Wed,  9 Apr 2008 05:43:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79090>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

Caution. "next" has been rebuilt with the remaining topics on top of
"master".  "maint" is still for 1.5.4.X maintenance track for tonight.

A rough timeline from now on.

 * Brown paper back fixes, if any, for 1.5.5.1 (2008-04-16).

 * Discussion and review on new feature and enhancement patch series
   begins.  Please resubmit things that you were cooking in your head
   during 1.5.5-rc period after cleaning up and retesting.

 * 1.5.6 merge window closes (2008-05-14).

 * Fixes of 'master' continues; 1.5.6-rc0 gets tagged (2008-05-21).

 * 1.5.6 Final (2008-06-08).

----------------------------------------------------------------
[New Topics]

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 6 commits
 - merge: remove deprecated summary and diffstat options and config
   variables
 - merge, pull: add '--(no-)log' command line option
 - fmt-merge-msg: add '--(no-)log' options and 'merge.log' config
   variable
 - add 'merge.stat' config variable
 - merge, pull: introduce '--(no-)stat' option
 - doc: moved merge.* config variables into separate merge-config.txt

I tried to fix its too-eager deprecation.  The last one needs re-review;
it should remove "these are still supported but will be removed" comments
that earlier ones add, and must be held back until 1.6.0 or later.

* jc/blame (Wed Apr 2 22:17:53 2008 -0700) 5 commits
 - git-blame --reverse
 - builtin-blame.c: allow more than 16 parents
 - builtin-blame.c: move prepare_final() into a separate function.
 - rev-list --children
 - revision traversal: --children option

The reverse blame I talked about earlier.

* jc/lstat (Sun Mar 30 12:39:25 2008 -0700) 3 commits
 - diff-files: mark an index entry we know is up-to-date as such
 - write_index(): optimize ce_smudge_racily_clean_entry() calls with
   CE_UPTODATE
 - lstat: introduce a wrapper xlstat

Further reduce redundant lstat(2) calls during "git status" and other
common operations.

----------------------------------------------------------------
[Graduated to "master"]

* jc/rebase (Sat Mar 15 13:17:42 2008 -0700) 1 commit
 + rebase [--onto O] A B: omit needless checkout

We used to "git checkout B && git rebase A" internally to implement this,
which meant the work tree was smudged one time too many.

* gs/pretty-hexval (Fri Mar 21 10:05:06 2008 -0500) 1 commit
 + pretty.c: add %x00 format specifier.

Adds a generic "insert any byte value" to --pretty=format:<> specifier.

* jk/add-i-mode (Thu Mar 27 03:32:25 2008 -0400) 2 commits
 + add--interactive: allow user to choose mode update
 + add--interactive: ignore mode change in 'p'atch command

Allows mode change "pseudo hunk" to be staged separately.

NOTE NOTE NOTE!  It might be interesting to extend the idea of this patch
to treat "new file" as a pseudo hunk to record the much talked about
"intent to add".  That is, add a new command (or a new submode to patch
subcommand) that lets you add a file that is so far untracked, but only
with its mode and e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 which is the
blob object name for an _empty_ blob.  After such an operation is done,
"git diff" will show the new contents of the file you build in your work
tree that you _could_ commit with "git commit -a".

* fl/send-email-outside (Fri Mar 14 18:29:30 2008 +0100) 4 commits
 + send-email: Don't require to be called in a repository
 + Git.pm: Don't require repository instance for ident
 + Git.pm: Don't require a repository instance for config
 + var: Don't require to be in a git repository.

People couldn't invoke "git send-email" from outside their repositories,
but this series allows them to.

* mk/unpack-careful (Fri Mar 7 08:39:53 2008 +0100) 5 commits
 + t5300: add test for "index-pack --strict"
 + receive-pack: allow using --strict mode for unpacking objects
 + unpack-objects: fix --strict handling
 + t5300: add test for "unpack-objects --strict"
 + unpack-objects: prevent writing of inconsistent objects

This would re-instate the "unpack-objects --strict".

* gp/gitweb (Sat Apr 5 16:37:18 2008 +0000) 2 commits
 + gitweb: fallback to system-wide config file (fixup)
 + gitweb: fallback to system-wide config file if default config does
   not exist

* jc/rename (Fri Mar 7 14:03:19 2008 -0800) 1 commit
 + Optimize rename detection for a huge diff

This makes memory consumption of the rename detection operation for a huge
diff (that is, a change that touches many many files).  I've been running
with this for quite a while in my day-job repository without adverse
effects.

----------------------------------------------------------------
[Actively Cooking]

* mv/defer-gc (Wed Apr 2 21:35:11 2008 +0200) 3 commits
 + contrib/hooks: add an example pre-auto-gc hook
 + Documentation/hooks: add pre-auto-gc hook
 + git-gc --auto: add pre-auto-gc hook

A new hook to stop "git gc --auto" from running.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 + "git push": tellme-more protocol extension

Allows common ancestor negotiation for git-push to help people with shared
repository workflow in certain minority situations.  The lack of protocol
support has been bugging me for quite some time, and that was the reason I
did this.  There recently was a problem report that had a scent of this
issue which turned out to be a false alarm (it was about http-push which
does not do the native pack protocol optimization and the reporter was
pushing into an empty repository which needs full transfer anyway).

* jc/dirstat (Tue Feb 12 17:06:58 2008 -0800) 1 commit
 + diff: make --dirstat binary-file safe

The current "dirstat" does totally wrong thing when the set of files
changed includes a binary one.  This uses the same similarity evaluation
code as rename heuristics uses to treat text and binary the same way.

* lt/case-insensitive (Sat Mar 22 14:22:44 2008 -0700) 9 commits
 + Make git-add behave more sensibly in a case-insensitive
   environment
 + When adding files to the index, add support for case-independent
   matches
 + Make unpack-tree update removed files before any updated files
 + Make branch merging aware of underlying case-insensitive
   filsystems
 + Add 'core.ignorecase' option
 + Make hash_name_lookup able to do case-independent lookups
 + Make "index_name_exists()" return the cache_entry it found
 + Move name hashing functions into a file of its own
 + Make unpack_trees_options bit flags actual bitfields

The beginning of case insensitive filesystem support, currently
ASCII-only.

* lh/git-file (Wed Feb 20 23:13:16 2008 +0100) 4 commits
 + Teach GIT-VERSION-GEN about the .git file
 + Teach git-submodule.sh about the .git file
 + Teach resolve_gitlink_ref() about the .git file
 + Add platform-independent .git "symlink"

The idea and the implementation seem Ok, but this leaves
distinct feeling that it is a solution still waiting for a user
(e.g. "git submodule" enhancements to take advantage of this
facility to preserve the subrepository while switching between a
revision with a submodule and another before the submodule was
bound to the superproject).

* jc/sha1-lookup (Sun Dec 30 03:13:27 2007 -0800) 2 commits
 + sha1-lookup: make selection of 'middle' less aggressive
 + sha1-lookup: more memory efficient search in sorted list of SHA-1

Micro-optimization whose real world benefit is not proven, so let's prove
it or revert it by giving it a bit more exposure.

----------------------------------------------------------------
[On Hold]

Some of these will start moving to "next", some I may have to ask for
clean-up and resubmission for further discussion.  Also the topics raised
during the 1.5.5-rc freeze period should be rebased, cleaned-up and
resubmit for discussion and review for inclusion in 1.5.6.

* bc/filter-branch (Wed Mar 26 10:47:09 2008 -0500) 1 commit
 - filter-branch.sh: support nearly proper tag name filtering

Instead of discarding signed tags, this demotes them to simply annotated,
which is technically not that different from signed tags.

* jc/test (Thu Feb 21 21:17:54 2008 -0800) 2 commits
 - tests: convert "cmp" and "cmp -s" to test_cmp
 - tests: test_cmp helper function

This one may be more elaborate, but Jeff's patch is much simpler.

* jc/rename-file-table (Fri Mar 7 14:03:19 2008 -0800) 1 commit
 - diffcore-rename: make file_table available outside exact rename
   detection

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/cherry-pick (Wed Feb 20 23:17:06 2008 -0800) 3 commits
 - WIP: rethink replay merge
 - Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive

This is meant to improve cherry-pick's behaviour by not using
merge-recursive, but unfortunately has stalled for some time now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

Just my toy at this moment.
