From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2012, #04; Fri, 13)
Date: Fri, 13 Jul 2012 16:53:50 -0700
Message-ID: <7vfw8v6wvl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 01:54:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sppgz-0004xX-BB
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 01:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766Ab2GMXxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 19:53:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755167Ab2GMXxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 19:53:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD70189FC;
	Fri, 13 Jul 2012 19:53:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	j9uB7uQXEjCsuTek9TUDQxasHY=; b=BeRiIydmlPvTBEumnAZKDAbNJu8WJcSPl
	Ys/frUrkPnIziLIG8bkpUmS3W38FbnxISMwiBK+cVwRsxWWruS9WmCqTLYKvHLof
	XNZwj5+9cXO+yNYkweDZy9Y/6gZ7Y2r4iSJfledIOpPAbgqvJK8z26eeImz3Xbl/
	OXNj6nsz8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=vBA
	H4eyXo9XTb/J9HAEpVAJ79BYoZ7zinb4v0LgEtSsPvIKgc37JuOL/tpsHDEYcEbB
	gV9hONQvufTgdGyFR/OZdgD0/5ODcy3V4G1h3dfECYbu7+uI1JUATkHY5Hoxmvih
	J3lJP5tx7l3LmKKyasa2aUiDmuzRwBVFqVAXB3Xw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB3789FB;
	Fri, 13 Jul 2012 19:53:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7BD289FA; Fri, 13 Jul 2012
 19:53:51 -0400 (EDT)
X-master-at: 48c42ff66244f754cc02d9bcca0962c791c7d57e
X-next-at: 534e6fe3169c23d847bc59311217dedfc6669bc1
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF44741A-CD45-11E1-920E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201430>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The sixth batch of topics are now in 'master'.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jc/refactor-diff-stdin (2012-06-28) 3 commits
  (merged to 'next' on 2012-07-09 at ef407ee)
 + diff-index.c: "git diff" has no need to read blob from the standard input
 + diff-index.c: unify handling of command line paths
 + diff-index.c: do not pretend paths are pathspecs

Due to the way "git diff --no-index" is bolted onto by touching the
low level code that is shared with the rest of the "git diff" code,
even though it has to work in a very different way, any comparison
that involves a file "-" at the root level incorrectly tried to read
from the standard input.  This cleans up the no-index codepath
further to remove code that reads from the standard input from the
core side, which is never necessary when git is running its usual
diff operation.

* jn/vcs-svn (2012-07-05) 12 commits
  (merged to 'next' on 2012-07-09 at 1d97a8f)
 + vcs-svn: allow 64-bit Prop-Content-Length
 + vcs-svn: suppress a signed/unsigned comparison warning
 + vcs-svn: suppress a signed/unsigned comparison warning
 + vcs-svn: suppress signed/unsigned comparison warnings
 + vcs-svn: use strstr instead of memmem
 + vcs-svn: use constcmp instead of prefixcmp
 + vcs-svn: simplify cleanup in apply_one_window
 + vcs-svn: avoid self-assignment in dummy initialization of pre_off
 + vcs-svn: drop no-op reset methods
 + vcs-svn: suppress -Wtype-limits warning
 + vcs-svn: allow import of > 4GiB files
 + vcs-svn: rename check_overflow and its arguments for clarity

Reroll of db/vcs-svn.

* mm/mediawiki-file-attachments (2012-07-04) 6 commits
  (merged to 'next' on 2012-07-09 at 4b85fa2)
 + git-remote-mediawiki: improve support for non-English Wikis
  (merged to 'next' on 2012-07-03 at 90f2f45)
 + git-remote-mediawiki: import "File:" attachments
 + git-remote-mediawiki: split get_mw_pages into smaller functions
 + git-remote-mediawiki: send "File:" attachments to a remote wiki
 + git-remote-mediawiki: don't "use encoding 'utf8';"
 + git-remote-mediawiki: don't compute the diff when getting commit message
 (this branch is used by mm/mediawiki-tests.)

"mediawiki" remote helper (in contrib/) learned to handle file
attachments.

* mm/mediawiki-tests (2012-07-06) 12 commits
  (merged to 'next' on 2012-07-09 at 4d874e8)
 + git-remote-mediawiki: be more defensive when requests fail
 + git-remote-mediawiki: more efficient 'pull' in the best case
 + git-remote-mediawiki: extract revision-importing loop to a function
 + git-remote-mediawiki: refactor loop over revision ids
 + git-remote-mediawiki: change return type of get_mw_pages
 + git-remote-mediawiki (t9363): test 'File:' import and export
 + git-remote-mediawiki: support for uploading file in test environment
 + git-remote-mediawiki (t9362): test git-remote-mediawiki with UTF8 characters
 + git-remote-mediawiki (t9361): test git-remote-mediawiki pull and push
 + git-remote-mediawiki (t9360): test git-remote-mediawiki clone
 + git-remote-mediawiki: test environment of git-remote-mediawiki
 + git-remote-mediawiki: scripts to install, delete and clear a MediaWiki
 (this branch uses mm/mediawiki-file-attachments.)

* mz/rebase-no-mbox (2012-06-26) 4 commits
  (merged to 'next' on 2012-07-03 at 5bf5c12)
 + am: don't call mailinfo if $rebasing
 + am --rebasing: get patch body from commit, not from mailbox
 + rebase --root: print usage on too many args
 + rebase: don't source git-sh-setup twice

Teach "am --rebasing" codepath to grab authorship, log message and
the patch text directly out of existing commits.  This will help
rebasing commits that have confusing "diff" output in their log
messages.

* tb/sanitize-decomposed-utf-8-pathname (2012-07-08) 1 commit
  (merged to 'next' on 2012-07-09 at 61b12c2)
 + git on Mac OS and precomposed unicode

Teaches git to normalize pathnames read from readdir(3) and all
arguments from the command line into precomposed UTF-8 (assuming
that they come as decomposed UTF-8) to work around issues on Mac OS.

I think there still are other places that need conversion
(e.g. paths that are read from stdin for some commands), but this
should be a good first step in the right direction.

* tg/ce-namelen (2012-07-08) 1 commit
  (merged to 'next' on 2012-07-10 at 87755d8)
 + Replace strlen() with ce_namelen()

Trivially correct clean-up and micro optimization.

* tr/maint-show-walk (2012-06-19) 2 commits
  (merged to 'next' on 2012-07-09 at c8e0e06)
 + show: fix "range implies walking"
 + Demonstrate git-show is broken with ranges

Fixes "git show"'s auto-walking behaviour, and make it behave just
like "git log" does when it walks.

Note that this is different from Thomas's patch.

--------------------------------------------------
[New Topics]

* as/t4012-style-updates (2012-07-12) 7 commits
 - t4012: use 'printf' instead of 'dd' to generate a binary file
 - t4012: Re-indent test snippets
 - t4012: Make --shortstat test more robust
 - t4012: Break up pipe into serial redirections
 - t4012: Actually quote the sed script
 - t4012: Unquote git command fragment in test title
 - t4012: modernize style for quoting

Should I wait for a reroll???

* jl/maint-1.7.10-recurse-submodules-with-symlink (2012-07-12) 1 commit
 - submodules: don't stumble over symbolic links when cloning recursively

When "git submodule add" clones a submodule repository, it can get
confused where to store the resulting submodule repository in the
superproject's .git/ directory when there is a symbolic link in the
path to the current directory.

* mm/config-xdg (2012-07-12) 2 commits
 - fixup! config: fix several access(NULL) calls
 - config: fix several access(NULL) calls

Either we do the stupid literal conversion (shown in fixup!), or the
reason why we special case missing HOME needs to be better explained.

* jk/revision-walk-stop-at-max-count (2012-07-13) 1 commit
 - revision: avoid work after --max-count is reached

"git log -n 1 -- rarely-touched-path" was spending unnecessary
cycles after showing the first change to find the next one, only to
discard it.

* pg/maint-1.7.9-am-where-is-patch (2012-07-13) 1 commit
 - am: indicate where a failed patch is to be found

When "git am" failed, old timers knew to check .git/rebase-apply/patch
to see what went wrong, but we never told the users about it.

--------------------------------------------------
[Stalled]

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
There still seem to be other bugs hiding (e.g. try pushing twice).

Not ready.

* jc/split-blob (2012-04-03) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* jc/maint-filter-branch-epoch-date (2012-07-12) 3 commits
  (merged to 'next' on 2012-07-13 at d144342)
 + t7003: add test to filter a branch with a commit at epoch
 + date.c: Fix off by one error in object-header date parsing
  (merged to 'next' on 2012-07-10 at f9774ca)
 + filter-branch: do not forget the '@' prefix to force git-timestamp

In 1.7.9 era, we taught "git rebase" about the raw timestamp format
but we did not teach the same trick to "filter-branch", which rolled
a similar logic on its own.

* jk/maint-commit-amend-only-no-paths (2012-07-10) 1 commit
  (merged to 'next' on 2012-07-10 at 1c650c2)
 + commit: fix "--amend --only" with no pathspec

"git commit --amend --only --" was meant to allow "Clever" people to
rewrite the commit message without making any change even when they
have already changes for the next commit added to their index, but
it never worked as advertised since it was introduced in 1.3.0 era.

* jk/index-pack-streaming-fix (2012-07-10) 1 commit
 - index-pack: loop while inflating objects in unpack_data

The streaming index-pack introduced in 1.7.11 had a data corruption
bug, and this should fix it.

Will merge to 'next'.

* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

When the user does not specify what remote to interact with, we
often attempt to use 'origin'.  This can now be customized via a
configuration variable.

* tg/ce-namelen-field (2012-07-11) 2 commits
 - Strip namelen out of ce_flags into a ce_namelen field
 - Merge branch 'tg/maint-cache-name-compare' into tg/ce-namelen-field
 (this branch uses tg/maint-cache-name-compare.)

Split lower bits of ce_flags field and creates a new ce_namelen
field in the in-core index structure.

* tg/maint-cache-name-compare (2012-07-11) 1 commit
 - cache_name_compare(): do not truncate while comparing paths
 (this branch is used by tg/ce-namelen-field.)

Even though the index can record pathnames longer than 1<<12 bytes,
in some places we were not comparing them in full, potentially
replacing index entries instead of adding.

Will merge to 'next', and then later down to older maintenance releases.

* jc/apply-3way (2012-07-09) 19 commits
  (merged to 'next' on 2012-07-10 at fb5c872)
 + apply: tests for the --3way option
 + apply: document --3way option
 + apply: allow rerere() to work on --3way results
 + apply: register conflicted stages to the index
 + apply: --3way with add/add conflict
 + apply: move verify_index_match() higher
 + apply: plug the three-way merge logic in
 + apply: fall back on three-way merge
 + apply: accept -3/--3way command line option
 + apply: move "already exists" logic to check_to_create()
 + apply: move check_to_create_blob() closer to its sole caller
 + apply: further split load_preimage()
 + apply: refactor "previous patch" logic
 + apply: split load_preimage() helper function out
 + apply: factor out checkout_target() helper function
 + apply: refactor read_file_or_gitlink()
 + apply: clear_image() clears things a bit more
 + apply: a bit more comments on PATH_TO_BE_DELETED
 + apply: fix an incomplete comment in check_patch()

"git apply" learns to wiggle the base version and perform three-way merge
when a patch does not exactly apply to the version you have.

* jl/submodule-rm (2012-07-05) 2 commits
 - rm: remove submodules from the index and the .gitmodules file
 - rm: don't fail when removing populated submodules

Expecting a reroll.

* mh/maint-revisions-doc (2012-07-05) 2 commits
 - Document rev^! and rev^@ as revision specifiers
 - Make <refname> documentation more consistent.

Expecting a reroll of the tip one.

* nk/maint-gitweb-log-by-lines (2012-07-05) 3 commits
 - gitweb: Add support to Link: tag
 - gitweb: Handle other types of tag in git_print_log
 - gitweb: Cleanup git_print_log()

Needs to be eyeballed for the correctness of the esc_html() in the tip one.

* pw/git-p4-jobs (2012-07-05) 3 commits
  (merged to 'next' on 2012-07-10 at c6ef8f9)
 + git p4: notice Jobs lines in git commit messages
 + git p4 test: refactor marshal_dump
 + git p4: remove unused P4Submit interactive setting

Teach "git p4" to notice "Jobs:" in the log message and relay it to
Perforce to trigger its "jobs" support.

* pw/git-p4-move (2012-07-12) 2 commits
 - git p4: add support for 'p4 move' in P4Submit
 - git p4: refactor diffOpts calculation

Will merge to 'next'.

* ar/clone-honor-umask-at-top (2012-07-09) 3 commits
  (merged to 'next' on 2012-07-10 at 680bc22)
 + add: create ADD_EDIT.patch with mode 0666
 + rerere: make rr-cache fanout directory honor umask
 + Restore umasks influence on the permissions of work tree created by clone

A handful of files and directories we create had tighter than
necessary permission bits when the user wanted to have group
writability (e.g. by setting "umask 002").

* ph/stash-rerere (2012-07-08) 2 commits
 - stash: invoke rerere in case of conflict
 - test: git-stash conflict sets up rerere

Will be rerolled but is going in the right direction.

* jn/makefile-cleanup (2012-07-09) 14 commits
  (merged to 'next' on 2012-07-10 at f55e6a1)
 + Makefile: document ground rules for target-specific dependencies
 + Makefile: move GIT-VERSION-FILE dependencies closer to use
 + Makefile: build instaweb similar to other scripts
 + Makefile: update scripts when build-time parameters change
 + Makefile: do not replace @@GIT_VERSION@@ in shell scripts
 + Makefile: split prefix flags from GIT-CFLAGS
 + Makefile: be silent when only GIT_USER_AGENT changes
 + Makefile: split GIT_USER_AGENT from GIT-CFLAGS
 + Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
 + Makefile: apply dependencies consistently to sparse/asm targets
 + Makefile: do not have git.o depend on common-cmds.h
 + Makefile: fold XDIFF_H and VCSSVN_H into LIB_H
 + Makefile: fold MISC_H into LIB_H
 + Makefile: sort LIB_H list

Tightens dependency rules to avoid unnecessary recompilation.

* cw/amend-commit-without-message (2012-07-09) 1 commit
  (merged to 'next' on 2012-07-10 at e7c75d5)
 + Allow edit of empty message with commit --amend

"commit --amend" used to refuse amending a commit with an empty log
message, with or without "--allow-empty-message".

* jk/push-delete-ref-error-message (2012-07-03) 1 commit
  (merged to 'next' on 2012-07-09 at 82c6bd2)
 + push: don't guess at qualifying remote refs on deletion

The error message from "git push $there :bogo" mentioned we tried
and failed to guess what ref is being deleted based on the LHS of
the refspec, which we don't.

* cw/rebase-i-root (2012-07-05) 3 commits
  (merged to 'next' on 2012-07-05 at aeb4c56)
 + t3404: make test 57 work with dash and others
  (merged to 'next' on 2012-07-03 at 231c0a4)
 + Add tests for rebase -i --root without --onto
 + rebase -i: support --root without --onto

"git rebase [-i] --root $tip" can now be used to rewrite all the
history down to the root.

* lt/commit-tree-guess-utf-8 (2012-06-28) 1 commit
 - commit/commit-tree: correct latin1 to utf-8

Teaches "git commit" and "git commit-tree" the "we are told to use
utf-8 in log message, but this does not look like utf-8---attempt to
pass it through convert-from-latin1-to-utf8 and see if it makes
sense" heuristics "git mailinfo" already uses.

A draft from Linus received privately without a log message.
Hopefully it will be rerolled.

* jc/test-lib-source-build-options-early (2012-06-24) 1 commit
 - test-lib: reorder and include GIT-BUILD-OPTIONS a lot earlier

Reorders t/test-lib.sh so that we dot-source GIT-BUILD-OPTIONS that
records the shell and Perl the user told us to use with Git a lot
early, so that test-lib.sh script itself can use "$PERL_PATH" in
one of its early operations.

Needs to be eyeballed by people who run tests with exotic options
like valgrind, --root=/dev/shm/somewhere, etc.

* jc/sha1-name-more (2012-07-13) 27 commits
  (merged to 'next' on 2012-07-13 at 534e6fe)
 + t1512: match the "other" object names
  (merged to 'next' on 2012-07-11 at d30ef51)
 + t1512: ignore whitespaces in wc -l output
  (merged to 'next' on 2012-07-10 at 669dd92)
 + rev-parse --disambiguate=<prefix>
 + rev-parse: A and B in "rev-parse A..B" refer to committish
 + reset: the command takes committish
 + commit-tree: the command wants a tree and commits
 + apply: --build-fake-ancestor expects blobs
 + sha1_name.c: add support for disambiguating other types
 + revision.c: the "log" family, except for "show", takes committish
 + revision.c: allow handle_revision_arg() to take other flags
 + sha1_name.c: introduce get_sha1_committish()
 + sha1_name.c: teach lookup context to get_sha1_with_context()
 + sha1_name.c: many short names can only be committish
 + sha1_name.c: get_sha1_1() takes lookup flags
 + sha1_name.c: get_describe_name() by definition groks only commits
 + sha1_name.c: teach get_short_sha1() a commit-only option
 + sha1_name.c: allow get_short_sha1() to take other flags
 + get_sha1(): fix error status regression
 + sha1_name.c: restructure disambiguation of short names
 + sha1_name.c: correct misnamed "canonical" and "res"
 + sha1_name.c: refactor find_short_packed_object()
 + sha1_name.c: rename "now" to "current"
 + sha1_name.c: clarify what "fake" is for in find_short_object_filename()
 + sha1_name.c: get rid of get_sha1_with_mode()
 + sha1_name.c: get rid of get_sha1_with_mode_1()
 + sha1_name.c: hide get_sha1_with_context_1() ugliness
 + sha1_name.c: indentation fix

Teaches the object name parser things like a "git describe" output
is always a commit object, "A" in "git log A" must be a committish,
and "A" and "B" in "git log A...B" both must be committish, etc., to
prolong the lifetime of abbreviated object names.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* mm/push-default-switch-warning (2012-06-24) 1 commit
  (merged to 'next' on 2012-06-26 at fea512a)
 + push: start warning upcoming default change for push.default

Will defer for another cycle.
