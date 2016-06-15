From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2014, #05; Thu, 24)
Date: Thu, 24 Jul 2014 15:36:36 -0700
Message-ID: <xmqqzjfy75aj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 00:36:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XARd5-0003si-9c
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 00:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbaGXWgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 18:36:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64539 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbaGXWgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 18:36:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0AFB2BA0F;
	Thu, 24 Jul 2014 18:36:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	7Y/6g1sSRXDudF9hcSnFo00tPI=; b=hYnCCIuFAhJroWSsTbg5KGP8LVuFZkkAL
	hp1EMnHoR1Y8Kii7/AVOen0J8+gQJnqjrpaos6uZlRuHyEqPUztAfvggHm5XRmCi
	XxklJP5mvclhlhRd5btsHwJ6qqz8mV46Hqv8IKfWEdIHS2l4m45Kazr0qi7CgUN3
	QROu4wjy1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=b7H
	Kh5mzSZO74SIo5dVs3EuEot9azfR8cspq9O3D2jgBZtDq3Df5AntQ6Xn4vd5TxmR
	ru2pZT2eaTTM0VghxI/Zcm61q8SsHHkYVWwPmApJ8EQ8Nxa54dWGAbVR+ou6EiSy
	rKsrJanN21/g9oIC+xqGuIPhSHYFqRcOivPqZjPY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7F092BA0D;
	Thu, 24 Jul 2014 18:36:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB0122BA05;
	Thu, 24 Jul 2014 18:36:37 -0400 (EDT)
X-master-at: 996b0fdbb4ff63bfd880b3901f054139c95611cf
X-next-at: 7327a17171fc87d5f8f5c790eb1ba1d0e031482d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9735FA8-1382-11E4-84A7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254190>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

We would need to start slowing down to prepare for -rc0 preview at
the end of this week and then feature freeze.  Some topics that
joined 'next' late may want to stay there for the remainder of this
cycle.  Many of the accumulated fixes have been flushed to 'maint'
and Git 2.0.3 has been tagged.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/tag-sort (2014-07-17) 2 commits
  (merged to 'next' on 2014-07-21 at bc34738)
 + tag: support configuring --sort via .gitconfig
 + tag: fix --sort tests to use cat<<-\EOF format

 Teach "git tag" to pay attention to "tag.sort" configuration, to be
 used as the default sort order when no --sort=<value> is given.


* mb/local-clone-after-applying-insteadof (2014-07-17) 1 commit
  (merged to 'next' on 2014-07-21 at ebe07c2)
 + use local cloning if insteadOf makes a local URL

 Apply the "if cloning from a local disk, physically copy repository
 using hardlinks, unless otherwise told not to with --no-local"
 optimization when url.*.insteadOf mechanism rewrites a "git clone
 $URL" that refers to a repository over the network to a clone from
 a local disk.


* rs/fix-unlink-unix-socket (2014-07-21) 1 commit
  (merged to 'next' on 2014-07-22 at fad8c29)
 + unix-socket: remove stale socket before calling chdir()

 The unix-domain socket used by the sample credential cache daemon
 tried to unlink an existing stale one at a wrong path, if the path
 to the socket was given as an overlong path that does not fit in
 sun_path member of the sockaddr_un structure.


* ta/string-list-init (2014-07-21) 2 commits
  (merged to 'next' on 2014-07-21 at 63e8891)
 + replace memset with string-list initializers
 + string-list: add string_list initializer helper function
 (this branch is tangled with ta/config-set.)

--------------------------------------------------
[New Topics]

* nd/multiple-work-trees-1 (2014-07-23) 5 commits
 - environment.c: fix incorrect git_graft_file initialization
 - checkout --to: fix dangling pointers in remove_junk()
 - checkout --to: no auto-detach if the ref is already checked out
 - prune --repos: fix uninitialized access
 - gitrepository-layout.txt: s/ignored/ignored if/
 (this branch uses nd/multiple-work-trees.)

 Continue polishing nd/multiple-work-trees topic in 'next'.


* jk/misc-fixes-maint (2014-07-24) 5 commits
 - apply: avoid possible bogus pointer
 - fix memory leak parsing core.commentchar
 - transport: fix leaks in refs_from_alternate_cb
 - free ref string returned by dwim_ref
 - receive-pack: don't copy "dir" parameter

 Miscellaneous fixes.

 Will merge to 'next' and then to 'master'.


* rs/ref-transaction-reflog (2014-07-23) 15 commits
 - refs.c: allow deleting refs with a broken sha1
 - refs.c: remove lock_any_ref_for_update
 - refs.c: make unlock_ref/close_ref/commit_ref static
 - refs.c: rename log_ref_setup to create_reflog
 - reflog.c: use a reflog transaction when writing during expire
 - refs.c: allow multiple reflog updates during a single transaction
 - refs.c: only write reflog update if msg is non-NULL
 - refs.c: add a flag to allow reflog updates to truncate the log
 - refs.c: add a transaction function to append a reflog entry
 - lockfile.c: make hold_lock_file_for_append preserve meaningful errno
 - refs.c: add a function to append a reflog entry to a fd
 - refs.c: add a new update_type field to ref_update
 - refs.c: rename the transaction functions
 - refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 - refs.c: make ref_transaction_create a wrapper to ref_transaction_update
 (this branch uses rs/ref-transaction and rs/ref-transaction-1.)

 Cover updates to reflog with the same transaction mechanism as used
 for reflog manipulations.

--------------------------------------------------
[Stalled]

* jk/tag-contains (2014-06-30) 8 commits
 . perf: add tests for tag --contains
 . tag: use commit_contains
 . commit: provide a fast multi-tip contains function
 . string-list: add pos to iterator callback
 . add functions for memory-efficient bitmaps
 . paint_down_to_common: use prio_queue
 . tag: factor out decision to stream tags
 . tag: allow --sort with -n

 Expecting a reroll.


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* rh/prompt-tests (2014-06-05) 11 commits
 - t9904: new __git_ps1 tests for Zsh
 - test-lib: make it possible to override how test code is eval'd
 - lib-prompt-tests.sh: add variable for string that encodes percent in PS1
 - lib-prompt-tests.sh: put all tests inside a function
 - t9903: move prompt tests to a new lib-prompt-tests.sh file
 - t9903: move PS1 color code variable definitions to lib-bash.sh
 - t9903: include "Bash" in test names via new $shellname var
 - t9903: run pc mode tests again with PS1 expansion disabled
 - t9903: move test name prefix to a separate variable
 - t9903: put the Bash pc mode prompt test cases in a function
 - t9903: remove Zsh test from the suite of Bash prompt tests

 Expecting a reroll to limit the damage to test_eval_; also reported
 to be broken with older zsh that are still in the field ($gmane/251231).


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* cc/interpret-trailers (2014-05-28) 11 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from file or stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from input message and arguments
 - trailer: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.

 What is the status of this one?  I think I saw reviews by Michael
 but after that I do not recall seeing any updates.


* mh/lockfile (2014-04-15) 25 commits
 . trim_last_path_elm(): replace last_path_elm()
 . resolve_symlink(): take a strbuf parameter
 . resolve_symlink(): use a strbuf for internal scratch space
 . change lock_file::filename into a strbuf
 . commit_lock_file(): use a strbuf to manage temporary space
 . try_merge_strategy(): use a statically-allocated lock_file object
 . try_merge_strategy(): remove redundant lock_file allocation
 . struct lock_file: declare some fields volatile
 . lockfile: avoid transitory invalid states
 . commit_lock_file(): die() if called for unlocked lockfile object
 . commit_lock_file(): inline temporary variable
 . remove_lock_file(): call rollback_lock_file()
 . lock_file(): exit early if lockfile cannot be opened
 . write_packed_entry_fn(): convert cb_data into a (const int *)
 . prepare_index(): declare return value to be (const char *)
 . delete_ref_loose(): don't muck around in the lock_file's filename
 . cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 . lockfile.c: document the various states of lock_file objects
 . lock_file(): always add lock_file object to lock_file_list
 . hold_lock_file_for_append(): release lock on errors
 . lockfile: unlock file if lockfile permissions cannot be adjusted
 . rollback_lock_file(): set fd to -1
 . rollback_lock_file(): do not clear filename redundantly
 . api-lockfile: expand the documentation
 . unable_to_lock_die(): rename function from unable_to_lock_index_die()

 Ejected from 'pu' to unclutter.
 Expecting a reroll.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)


* tr/remerge-diff (2014-02-26) 5 commits
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . revision: fold all merge diff variants into an enum merge_diff_mode
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Needs to be rebased, now kb/fast-hashmap topic is in.


* jk/makefile (2014-02-05) 16 commits
 . FIXUP
 . move LESS/LV pager environment to Makefile
 . Makefile: teach scripts to include make variables
 . FIXUP
 . Makefile: auto-build C strings from make variables
 . Makefile: drop *_SQ variables
 . FIXUP
 . Makefile: add c-quote helper function
 . Makefile: introduce sq function for shell-quoting
 . Makefile: always create files via make-var
 . Makefile: store GIT-* sentinel files in MAKE/
 . Makefile: prefer printf to echo for GIT-*
 . Makefile: use tempfile/mv strategy for GIT-*
 . Makefile: introduce make-var helper function
 . Makefile: fix git-instaweb dependency on gitweb
 . Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.


* jh/submodule-tests (2014-04-17) 1 commit
 - t7410: 210 tests for various 'git submodule update' scenarios

 More or less abandoned.  Will drop.

--------------------------------------------------
[Cooking]

* nd/path-max-is-better-than-hardcoded-magic-1024 (2014-07-17) 1 commit
 - abspath.c: use PATH_MAX in real_path_internal()

 Still being discussed.


* sk/mingw-uni-fix-more (2014-07-21) 14 commits
 - Win32: enable color output in Windows cmd.exe
 - Win32: patch Windows environment on startup
 - Win32: keep the environment sorted
 - Win32: use low-level memory allocation during initialization
 - Win32: reduce environment array reallocations
 - Win32: don't copy the environment twice when spawning child processes
 - Win32: factor out environment block creation
 - Win32: unify environment function names
 - Win32: unify environment case-sensitivity
 - Win32: fix environment memory leaks
 - Win32: Unicode environment (incoming)
 - Win32: Unicode environment (outgoing)
 - Revert "Windows: teach getenv to do a case-sensitive search"
 - tests: do not pass iso8859-1 encoded parameter

 Most of these are battle-tested in msysgit and are needed to
 complete what has been merged to 'master' already.

 A fix has been squashed into "Unicode environ (outgoing)"; is this
 now ready to go?


* sk/mingw-tests-workaround (2014-07-21) 6 commits
 - t800[12]: work around MSys limitation
 - t9902: mingw-specific fix for gitfile link files
 - t4210: skip command-line encoding tests on mingw
 - MinGW: disable legacy encoding tests
 - t0110/MinGW: skip tests that pass arbitrary bytes on the command line
 - MinGW: Skip test redirecting to fd 4
 (this branch is used by jc/not-mingw-cygwin.)

 Make tests pass on msysgit by mostly disabling ones that are
 infeasible on that platform.

 The t0110 one has been replaced; is this now ready to go?


* cb/mergetool-difftool (2014-07-21) 2 commits
 - difftool: don't assume that default sh is sane
 - mergetool: don't require a work tree for --tool-help


* rs/strbuf-getcwd (2014-07-21) 4 commits
 - use xgetcwd() get the current directory or die
 - wrapper: add xgetcwd()
 - use strbuf_getcwd() to get the current working directory without fixed-sized buffers
 - strbuf: add strbuf_getcwd()

 Still being discussed.


* jc/not-mingw-cygwin (2014-07-21) 2 commits
 - test prerequisites: enumerate with commas
 - test prerequisites: eradicate NOT_FOO
 (this branch uses sk/mingw-tests-workaround.)

 We have been using NOT_{MINGW,CYGWIN} test prerequisites long
 before Peff invented support for negated prerequisites e.g. !MINGW
 and we still add more uses of the former.  Convert them to the
 latter to avoid confusion.


* jk/more-push-completion (2014-07-22) 3 commits
 - completion: complete `git push --force-with-lease=`
 - completion: add some missing options to `git push`
 - completion: complete "unstuck" `git push --recurse-submodules`


* jk/rebase-am-fork-point (2014-07-16) 2 commits
  (merged to 'next' on 2014-07-22 at 7648293)
 + rebase: omit patch-identical commits with --fork-point
 + rebase--am: use --cherry-pick instead of --ignore-if-in-upstream

 "git rebase --fork-point" did not filter out patch-identical
 commits correctly.

 Will merge to 'master'.


* jk/stable-prio-queue (2014-07-15) 4 commits
  (merged to 'next' on 2014-07-22 at 46e9bc3)
 + t5539: update a flaky test
 + paint_down_to_common: use prio_queue
 + prio-queue: make output stable with respect to insertion
 + prio-queue: factor out compare and swap operations

 Will merge to 'master'.


* ta/config-set (2014-07-24) 2 commits
 - test-config: add tests for the config_set API
 - add `config_set` API for caching config-like files

 More or less solidified enough to be built other enhancements upon.


* rs/ref-transaction-1 (2014-07-16) 20 commits
 - refs.c: make delete_ref use a transaction
 - refs.c: make prune_ref use a transaction to delete the ref
 - refs.c: remove lock_ref_sha1
 - refs.c: remove the update_ref_write function
 - refs.c: remove the update_ref_lock function
 - refs.c: make lock_ref_sha1 static
 - walker.c: use ref transaction for ref updates
 - fast-import.c: use a ref transaction when dumping tags
 - receive-pack.c: use a reference transaction for updating the refs
 - refs.c: change update_ref to use a transaction
 - branch.c: use ref transaction for all ref updates
 - fast-import.c: change update_branch to use ref transactions
 - sequencer.c: use ref transactions for all ref updates
 - commit.c: use ref transactions for updates
 - replace.c: use the ref transaction functions for updates
 - tag.c: use ref transactions when doing updates
 - refs.c: add transaction.status and track OPEN/CLOSED/ERROR
 - refs.c: make ref_transaction_begin take an err argument
 - refs.c: update ref_transaction_delete to check for error and return status
 - refs.c: change ref_transaction_create to do error checking and return status
 (this branch is used by rs/ref-transaction and rs/ref-transaction-reflog.)

 The second batch of the transactional ref update series.


* jc/reopen-lock-file (2014-07-14) 1 commit
  (merged to 'next' on 2014-07-21 at 8277dc9)
 + lockfile: allow reopening a closed but still locked file

 Needed in the "commit -p" code path to update the cache tree in the
 index.


* nd/multiple-work-trees (2014-07-17) 31 commits
  (merged to 'next' on 2014-07-17 at a29d310)
 + checkout: don't require a work tree when checking out into a new one
 + git_path(): keep "info/sparse-checkout" per work-tree
 + count-objects: report unused files in $GIT_DIR/repos/...
 + gc: support prune --repos
 + gc: factor out gc.pruneexpire parsing code
 + gc: style change -- no SP before closing parenthesis
 + prune: strategies for linked checkouts
 + checkout: detach if the branch is already checked out elsewhere
 + checkout: clean up half-prepared directories in --to mode
 + checkout: support checking out into a new working directory
 + use new wrapper write_file() for simple file writing
 + wrapper.c: wrapper to open a file, fprintf then close
 + setup.c: support multi-checkout repo setup
 + setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 + setup.c: convert check_repository_format_gently to use strbuf
 + setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 + setup.c: convert is_git_directory() to use strbuf
 + git-stash: avoid hardcoding $GIT_DIR/logs/....
 + *.sh: avoid hardcoding $GIT_DIR/hooks/...
 + git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 + $GIT_COMMON_DIR: a new environment variable
 + commit: use SEQ_DIR instead of hardcoding "sequencer"
 + fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 + reflog: avoid constructing .lock path with git_path
 + *.sh: respect $GIT_INDEX_FILE
 + git_path(): be aware of file relocation in $GIT_DIR
 + path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 + path.c: rename vsnpath() to do_git_path()
 + git_snpath(): retire and replace with strbuf_git_path()
 + path.c: make get_pathname() call sites return const char *
 + path.c: make get_pathname() return strbuf instead of static buffer
 (this branch is used by nd/multiple-work-trees-1.)

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Will cook in 'next'.


* dt/cache-tree-repair (2014-07-14) 4 commits
  (merged to 'next' on 2014-07-21 at e83db34)
 + cache-tree: Write updated cache-tree after commit
 + cache-tree: subdirectory tests
 + test-dump-cache-tree: invalid trees are not errors
 + cache-tree: create/update cache-tree on checkout

 Add a few more places in "commit" and "checkout" that make sure
 that the cache-tree is fully populated in the index.

 Will cook in 'next'.


* cc/replace-graft (2014-07-21) 9 commits
  (merged to 'next' on 2014-07-22 at 9b14090)
 + replace: add test for --graft with a mergetag
 + replace: check mergetags when using --graft
 + replace: add test for --graft with signed commit
 + replace: remove signature when using --graft
 + contrib: add convert-grafts-to-replace-refs.sh
 + Documentation: replace: add --graft option
 + replace: add test for --graft
 + replace: add --graft option
 + replace: cleanup redirection style in tests

 "git replace" learned a "--graft" option to rewrite parents of a
 commit.

 Will merge to 'master'.


* hv/submodule-config (2014-06-30) 4 commits
  (merged to 'next' on 2014-07-17 at 5e0ce45)
 + do not die on error of parsing fetchrecursesubmodules option
 + use new config API for worktree configurations of submodules
 + extract functions for submodule config set and lookup
 + implement submodule config cache for lookup of submodule names

 Will cook in 'next'.


* rs/ref-transaction (2014-07-17) 12 commits
 - refs.c: fix handling of badly named refs
 - refs.c: make write_ref_sha1 static
 - fetch.c: change s_update_ref to use a ref transaction
 - refs.c: propagate any errno==ENOTDIR from _commit back to the callers
 - refs.c: pass a skip list to name_conflict_fn
 - refs.c: call lock_ref_sha1_basic directly from commit
 - refs.c: move the check for valid refname to lock_ref_sha1_basic
 - refs.c: pass NULL as *flags to read_ref_full
 - refs.c: pass the ref log message to _create/delete/update instead of _commit
 - refs.c: add an err argument to delete_ref_loose
 - wrapper.c: add a new function unlink_or_msg
 - wrapper.c: simplify warn_if_unremovable
 (this branch is used by rs/ref-transaction-reflog; uses rs/ref-transaction-1.)


* jc/test-lazy-prereq (2014-06-13) 1 commit
 - tests: drop GIT_*_TIMING_TESTS environment variable support

 Test-script clean-up.

 Will hold.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.

 Will hold.
