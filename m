From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 23 Mar 2008 03:08:25 -0700
Message-ID: <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 11:09:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdN8p-00036G-Iy
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 11:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbYCWKIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 06:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755064AbYCWKIh
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 06:08:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128AbYCWKIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 06:08:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96A5629C7;
	Sun, 23 Mar 2008 06:08:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 549EE29C6; Sun, 23 Mar 2008 06:08:32 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77877>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

Since we tagged -rc0, we've seen regression fixes at a reasonable rate.
At -rc1 tonight, I think we are fairly in good shape.

----------------------------------------------------------------
[New Topics]

* fl/send-email-outside (Fri Mar 14 18:29:30 2008 +0100) 4 commits
 + send-email: Don't require to be called in a repository
 + Git.pm: Don't require repository instance for ident
 + Git.pm: Don't require a repository instance for config
 + var: Don't require to be in a git repository.

People couldn't invoke "git send-email" from outside their repositories,
but this series allows them to.  I do not think it is urgent, though.
This does not look risky, even though it touches Git.pm that is shared
with other things.  This has been cooking in 'next' for some time and we
haven't heard about breakages caused by this.  Will probably be the first
thing to be merged in 'master' post 1.5.5.

* jc/rebase (Sat Mar 15 13:17:42 2008 -0700) 1 commit
 + rebase [--onto O] A B: omit needless checkout

We used to "git checkout B && git rebase A" internally to implement this,
which meant the work tree was smudged one time too many.  This is probably
a safe optimization, but it case after -rc0 and is not really a must-have
fix.  One of the first after post 1.5.5.

* lt/case-insensitive (Sat Mar 22 14:22:44 2008 -0700) 9 commits
 - Make git-add behave more sensibly in a case-insensitive
   environment
 - When adding files to the index, add support for case-independent
   matches
 - Make unpack-tree update removed files before any updated files
 - Make branch merging aware of underlying case-insensitive
   filsystems
 - Add 'core.ignorecase' option
 - Make hash_name_lookup able to do case-independent lookups
 - Make "index_name_exists()" return the cache_entry it found
 - Move name hashing functions into a file of its own
 - Make unpack_trees_options bit flags actual bitfields

The beginning of ASCII-only case insensitive filesystem support.  It is
not complete yet, though.  E.g. if you enable core.ignorecase in t0050,
the merge test fails.

* gs/pretty-hexval (Fri Mar 21 10:05:06 2008 -0500) 1 commit
 + pretty.c: add %x00 format specifier.

Adds a generic "insert any byte value" to --pretty=format:<> specifier.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

Allows common ancestor negotiation for git-push to help people with shared
repository workflow in certain minority situations.  The lack of protocol
support has been bugging me for quite some time, and that was the reason I
did this, but because I have met no real user with shared repository
workflow who complained on this issue, I think this is not urgent.

----------------------------------------------------------------
[Graduated to 'master']

* cc/help (Thu Mar 13 19:15:30 2008 -0700) 6 commits
 + Documentation/git-help: typofix
 + help: warn if specified 'man.viewer' is unsupported, instead of
   erroring out
 + Documentation: help: explain 'man.viewer' multiple values
 + help: implement multi-valued "man.viewer" config option
 + Documentation: help: describe 'man.viewer' config variable
 + help: add "man.viewer" config var to use "woman" or "konqueror"

There are some leftover bits posted after -rc0, but I think they can
wait.

* db/diff-to-fp (Mon Mar 10 13:58:26 2008 -0400) 2 commits
 + wt-status.c: no need for dup() dance anymore
 + Write diff output to a file in struct diff_options

* py/submodule (Wed Mar 12 09:30:01 2008 +0100) 6 commits
 + git-submodule summary: fix that some "wc" flavors produce leading
   spaces
 + git-submodule summary: test
 + git-submodule summary: documentation
 + git-submodule summary: limit summary size
 + git-submodule summary: show commit summary
 + git-submodule summary: code framework

I didn't see anybody very supportive for this series, but I do not think
this regresses existing other subcommands to "git submodule", so let's see
how useful submodule users find this.  Maybe they have improvement ideas
for its output before we decide post 1.5.5 if it is a good idea to include
it in "git status" output.

* jc/makefile (Wed Mar 12 01:46:26 2008 -0700) 2 commits
 - Makefile: flatten enumeration of headers, objects and programs
 - Makefile: DIFF_OBJS is not special at all these days

I promised to do this immediately after -rc0, so this will shortly be in
'next' and then in 'master'.

* jk/portable (Wed Mar 12 17:42:43 2008 -0400) 13 commits
 + t7505: use SHELL_PATH in hook
 + t9112: add missing #!/bin/sh header
 + filter-branch: use $SHELL_PATH instead of 'sh'
 + filter-branch: don't use xargs -0
 + add NO_EXTERNAL_GREP build option
 + t6000lib: tr portability fix
 + t4020: don't use grep -a
 + add test_cmp function for test scripts
 + remove use of "tail -n 1" and "tail -1"
 + grep portability fix: don't use "-e" or "-q"
 + more tr portability test script fixes
 + t0050: perl portability fix
 + tr portability fixes

Initially triggered by Solaris porting effort but these are harmless
portability changes.  Perhaps in 1.5.5, perhaps immediately after that.

----------------------------------------------------------------
[Dropped]

* jc/test (Thu Feb 21 21:17:54 2008 -0800) 2 commits
 . tests: convert "cmp" and "cmp -s" to test_cmp
 . tests: test_cmp helper function

This one may be more elaborate, but Jeff's patch is much simpler.

* nd/worktree (Sun Mar 2 17:35:43 2008 +0700) 10 commits
 . Additional tests to capture worktree special cases
 . Documentation: update api-builtin and api-setup
 . Make setup_git_directory() auto-setup worktree if found
 . builtin-archive: mark unused prefix "unused_prefix"
 . Completely move out worktree setup from
   setup_git_directory_gently()
 . http-push: Avoid calling setup_git_directory() twice
 . Make setup_work_tree() return new prefix
 . Make get_git_dir() and 'git rev-parse --git-dir' absolute path
 . Make sure setup_git_directory is called before accessing
   repository
 . "git read-tree -m" and the like require worktree

Every time we touch work-tree stuff we seem to have unstabilized things.
This is excluded from 'pu' for now although I still have copies.

----------------------------------------------------------------
[On Hold]

* jc/unpack-careful (Fri Mar 7 08:39:53 2008 +0100) 5 commits
 + t5300: add test for "index-pack --strict"
 + receive-pack: allow using --strict mode for unpacking objects
 + unpack-objects: fix --strict handling
 + t5300: add test for "unpack-objects --strict"
 + unpack-objects: prevent writing of inconsistent objects

This would re-instate the "unpack-objects --strict" but we probably should
not do this before 1.5.5.

* jc/rename (Fri Mar 7 14:03:19 2008 -0800) 2 commits
 - diffcore-rename: make file_table available outside exact rename
   detection
 + Optimize rename detection for a huge diff

* jc/dirstat (Tue Feb 12 17:06:58 2008 -0800) 1 commit
 - diff: make --dirstat binary-file safe

* lh/git-file (Wed Feb 20 23:13:16 2008 +0100) 4 commits
 - Teach GIT-VERSION-GEN about the .git file
 - Teach git-submodule.sh about the .git file
 - Teach resolve_gitlink_ref() about the .git file
 - Add platform-independent .git "symlink"

The idea and the implementation seem Ok, but this leaves
distinct feeling that it is a solution still waiting for a user
(e.g. "git submodule" enhancements to take advantage of this
facility to preserve the subrepository while switching between a
revision with a submodule and another before the submodule was
bound to the superproject).

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.  I am not sure if we should merge this to
'next' before 1.5.5.  Most active people will be on 'next' and
if we have this there, the resulting 1.5.5 release might end up
having issues that come from differences this one introduces.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/sha1-lookup (Sun Dec 30 03:13:27 2007 -0800) 2 commits
 - sha1-lookup: make selection of 'middle' less aggressive
 - sha1-lookup: more memory efficient search in sorted list of SHA-1

Micro-optimization whose real world benefit is not proven.

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
