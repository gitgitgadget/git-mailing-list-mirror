Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F0BC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 00:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C882960FC3
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 00:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhKJBC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:02:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62653 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhKJBCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 20:02:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FEE5157290;
        Tue,  9 Nov 2021 19:59:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=L
        CT657hxrLA82t/et4wtudR5qhM2XawhF+6aT5nr7RU=; b=bfv/Ru4icFvjvmpKe
        wwOBpiUg3zyGl0caxfIZiWoPaD6j/CGbW65/WgHRYZvmFpJu63+5w0b3h/vzWdtq
        CUxkosM5tlpJQDAPfiPc22+ld+DLMOJCupYuDdJi6imIsOjJSm1JhtwHzTmlE27W
        FhOdYIXqfWHkeauXvVXkyobAuo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87C8D15728F;
        Tue,  9 Nov 2021 19:59:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1781F15728D;
        Tue,  9 Nov 2021 19:59:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2021, #03; Tue, 9)
X-master-at: 6c220937e2b26d85920bf2d38ff2464a0d57fd6b
X-next-at: 773e6cccef14fb4ef03dc964d7f80ceb691c12be
Date:   Tue, 09 Nov 2021 16:59:31 -0800
Message-ID: <xmqqy25wygek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77816DBC-41C1-11EC-842E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen',
which means nothing more than that I have found them of interest for
some reason (like "it may have hard-to-resolve conflicts with
another topic already in flight" or "this may turn out to be
useful").  Do not read too much into a topic being in (or not in)
'seen'.  The ones marked with '.' do not appear in any of the
integration branches, but I am still holding onto them.

Git 2.34-rc2 has been tagged with a few more regression fixes.
Thank you all for finding, reporting and fixing them so quickly.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[New Topics]

* ak/fetch-not-overwrite-any-current-branch (2021-11-08) 2 commits
 - receive-pack: protect current branch for bare repository worktree
 - fetch: protect branches checked out in all worktrees

 "git fetch" without the "--update-head-ok" option ought to protect
 a checked out branch from getting updated, to prevent the working
 tree that checks it out to go out of sync.  The code was written
 before the use of "git worktree" got widespread, and only checked
 the branch that was checked out in the current worktree, which has
 been updated.

 Reroll exists.


* jk/test-bitmap-fix (2021-11-05) 1 commit
 - test_bitmap_hashes(): handle repository without bitmaps

 Tighten code for testing pack-bitmap.

 Will merge to 'next'.


* jk/jump-merge-with-pathspec (2021-11-09) 1 commit
 - git-jump: pass "merge" arguments to ls-files

 The "merge" subcommand of "git jump" (in contrib/) silently ignored
 pathspec and other parameters.

 Will merge to 'next'.

--------------------------------------------------
[Graduated to 'master']

* ab/parse-options-cleanup (2021-11-09) 1 commit
  (merged to 'next' on 2021-11-09 at b2b859289b)
 + parse-options.[ch]: revert use of "enum" for parse_options()

 Last minute fix to the update already in 'master'.


* ad/ssh-signing-testfix (2021-11-05) 1 commit
  (merged to 'next' on 2021-11-09 at f5ff9c35ad)
 + t/lib-git.sh: fix ACL-related permissions failure

 Fix ssh-signing test to work on a platform where the default ACL is
 overly loose to upset OpenSSH (reported on an installation of Cygwin).


* ar/fix-git-pull-no-verify (2021-10-28) 1 commit
  (merged to 'next' on 2021-11-01 at 74677b0a76)
 + pull: honor --no-verify and do not call the commit-msg hook

 "git pull --no-verify" did not affect the underlying "git merge".


* ar/no-verify-doc (2021-10-29) 1 commit
  (merged to 'next' on 2021-11-01 at f6809a9ddb)
 + Document positive variant of commit and merge option "--no-verify"

 Doc update.


* rd/http-backend-code-simplification (2021-10-25) 1 commit
  (merged to 'next' on 2021-11-01 at f45b33890c)
 + http-backend: remove a duplicated code branch

 Code simplification.


* vd/pthread-setspecific-g11-fix (2021-11-03) 1 commit
  (merged to 'next' on 2021-11-03 at b4fce69914)
 + async_die_is_recursing: work around GCC v11.x issue on Fedora

 One CI task based on Fedora image noticed a not-quite-kosher
 consturct recently, which has been corrected.

--------------------------------------------------
[Stalled]

* mp/absorb-submodule-git-dir-upon-deinit (2021-10-07) 1 commit
 - submodule: absorb git dir instead of dying on deinit

 "git submodule deinit" for a submodule whose .git metadata
 directory is embedded in its working tree refused to work, until
 the submodule gets converted to use the "absorbed" form where the
 metadata directory is stored in superproject, and a gitfile at the
 top-level of the working tree of the submodule points at it.  The
 command is taught to convert such submodules to the absorbed form
 as needed.

 Expecting a reroll.
 cf. <xmqqwnmopqqk.fsf@gitster.g>


* ar/submodule-update (2021-10-13) 9 commits
 . submodule--helper: rename helper functions
 . submodule--helper: remove unused helpers
 . submodule: move core cmd_update() logic to C
 . submodule--helper: run update using child process struct
 . submodule--helper: allow setting superprefix for init_submodule()
 . submodule--helper: refactor get_submodule_displaypath()
 . submodule--helper: rename helpers for update-clone
 . submodule--helper: get remote names from any repository
 . submodule--helper: split up ensure_core_worktree()

 Rewrite of "git submodule update" in C.

 Kicked out of 'seen' to make room for es/superproject-aware-submodules
 which is among the topics this topic stomps on.


* cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
 - fetch: fix segfault on --set-upstream while on a detached HEAD

 "git fetch --set-upstream" while on detached HEAD segfaulted
 instead of noticing that such an operation did not make sense.

 Getting tired of waiting for a reroll; will discard.

--------------------------------------------------
[Cooking]

* jk/strbuf-addftime-seconds-since-epoch (2021-11-04) 1 commit
 - strbuf_addftime(): handle "%s" manually

 The "--date=format:<strftime>" gained a workaround for the lack of
 system support for a non-local timezone to handle "%s" placeholder.


* js/ci-no-directional-formatting (2021-11-04) 1 commit
 - ci: disallow directional formatting

 CI has been taught to catch some Unicode directional formatting
 sequence that can be used in certain mischief.


* tw/var-default-branch (2021-11-03) 1 commit
 - var: add GIT_DEFAULT_BRANCH variable

 "git var GIT_DEFAULT_BRANCH" is a way to see what name is used for
 the newly created branch if "git init" is run.


* ab/mark-leak-free-tests-even-more (2021-11-01) 15 commits
 - leak tests: mark some fast-import tests as passing with SANITIZE=leak
 - leak tests: mark some config tests as passing with SANITIZE=leak
 - leak tests: mark some status tests as passing with SANITIZE=leak
 - leak tests: mark some clone tests as passing with SANITIZE=leak
 - leak tests: mark some add tests as passing with SANITIZE=leak
 - leak tests: mark some diff tests as passing with SANITIZE=leak
 - leak tests: mark some apply tests as passing with SANITIZE=leak
 - leak tests: mark some notes tests as passing with SANITIZE=leak
 - leak tests: mark some update-index tests as passing with SANITIZE=leak
 - leak tests: mark some rev-parse tests as passing with SANITIZE=leak
 - leak tests: mark some rev-list tests as passing with SANITIZE=leak
 - leak tests: mark some misc tests as passing with SANITIZE=leak
 - leak tests: mark most gettext tests as passing with SANITIZE=leak
 - leak tests: mark "sort" test as passing SANITIZE=leak
 - leak tests: mark a read-tree test as passing SANITIZE=leak

 More tests are marked as leak-free.


* if/redact-packfile-uri (2021-10-29) 2 commits
 - http-fetch: redact url on die() message
 - fetch-pack: redact packfile urls in traces

 Redact the path part of packfile URI that appears in the trace output.


* ew/test-wo-fsync (2021-10-29) 1 commit
 - tests: disable fsync everywhere

 Allow running our tests while disabling internal fsync.


* ja/doc-cleanup (2021-11-09) 10 commits
 - init doc: --shared=0xxx does not give umask but perm bits
 - doc: git-init: clarify file modes in octal.
 - doc: git-http-push: describe the refs as pattern pairs
 - doc: uniformize <URL> placeholders' case
 - doc: use three dots for indicating repetition instead of star
 - doc: git-ls-files: express options as optional alternatives
 - doc: use only hyphens as word separators in placeholders
 - doc: express grammar placeholders between angle brackets
 - doc: split placeholders as individual tokens
 - doc: fix git credential synopsis

 Doc update.

 Will merge to 'next'.


* re/color-default-reset (2021-10-28) 3 commits
 - color: allow colors to be prefixed with "reset"
 - color: support "default" to restore fg/bg color
 - color: add missing GIT_COLOR_* white/black constants

 "default" and "reset" colors have been added to our palette.


* jc/fix-first-object-walk (2021-10-29) 2 commits
 - docs: add headers in MyFirstObjectWalk
 - docs: fix places that break compilation in MyFirstObjectWalk

 Doc update.


* jc/unsetenv-returns-an-int (2021-10-29) 1 commit
  (merged to 'next' on 2021-11-01 at a11670a5a5)
 + unsetenv(3) returns int, not void

 The compatibility implementation for unsetenv(3) were written to
 mimic ancient, non-POSIX, variant seen in an old glibc; it has been
 changed to return an integer to match the more modern era.

 Will cook in 'next'.


* mc/clean-smudge-with-llp64 (2021-11-03) 8 commits
  (merged to 'next' on 2021-11-03 at fe5160a170)
 + clean/smudge: allow clean filters to process extremely large files
 + odb: guard against data loss checking out a huge file
 + git-compat-util: introduce more size_t helpers
 + odb: teach read_blob_entry to use size_t
 + t1051: introduce a smudge filter test for extremely large files
 + test-lib: add prerequisite for 64-bit platforms
 + test-tool genzeros: generate large amounts of data more efficiently
 + test-genzeros: allow more than 2G zeros in Windows

 The clean/smudge conversion code path has been prepared to better
 work on platforms where ulong is narrower than size_t.

 Will cook in 'next'.


* pw/diff-color-moved-fix (2021-10-27) 15 commits
 - diff --color-moved: intern strings
 - diff: use designated initializers for emitted_diff_symbol
 - diff --color-moved-ws=allow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=allow-indentation-change: simplify and optimize
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zerba coloring
 - diff --color-moved=zebra: fix alternate coloring
 - diff --color-moved: rewind when discarding pmb
 - diff --color-moved: factor out function
 - diff --color-moved: clear all flags on blocks that are too short
 - diff --color-moved: add perf tests

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.


* ab/generate-command-list (2021-11-05) 10 commits
 - generate-cmdlist.sh: don't parse command-list.txt thrice
 - generate-cmdlist.sh: replace "grep' invocation with a shell version
 - generate-cmdlist.sh: do not shell out to "sed"
 - generate-cmdlist.sh: stop sorting category lines
 - generate-cmdlist.sh: replace for loop by printf's auto-repeat feature
 - generate-cmdlist.sh: run "grep | sort", not "sort | grep"
 - generate-cmdlist.sh: don't call get_categories() from category_list()
 - generate-cmdlist.sh: spawn fewer processes
 - generate-cmdlist.sh: trivial whitespace change
 - command-list.txt: sort with "LC_ALL=C sort"

 Build optimization.


* jc/fix-pull-ff-only-when-already-up-to-date (2021-10-29) 1 commit
  (merged to 'next' on 2021-10-29 at ad4753e668)
 + pull: --ff-only should make it a noop when already-up-to-date

 "git pull --ff-only" and "git pull --rebase --ff-only" should make
 it a no-op to attempt pulling from a remote that is behind us, but
 instead the command errored out by saying it was impossible to
 fast-forward, which may technically be true, but not a useful thing
 to diagnose as an error.  This has been corrected.

 Will cook in 'next'.


* ab/sh-retire-helper-functions (2021-10-21) 6 commits
  (merged to 'next' on 2021-11-03 at 4b49d9f4be)
 + git-sh-setup: remove "sane_grep", it's not needed anymore
 + git-sh-setup: remove unused sane_egrep() function
 + git-instaweb: unconditionally assume that gitweb is mod_perl capable
 + Makefile: remove $(NO_CURL) from $(SCRIPT_DEFINES)
 + Makefile: remove $(GIT_VERSION) from $(SCRIPT_DEFINES)
 + Makefile: move git-SCRIPT-DEFINES adjacent to $(SCRIPT_DEFINES)

 Make a few helper functions unused and then lose them.

 Will cook in 'next'.


* ow/stash-count-in-status-porcelain-output (2021-10-21) 2 commits
  (merged to 'next' on 2021-10-29 at 1a01b886e5)
 + status: print stash info with --porcelain=v2 --show-stash
 + status: count stash entries in separate function

 Allow "git status --porcelain=v2" to show the number of stash
 entries with --show-stash like the normal output does.

 Will cook in 'next'.


* tb/plug-pack-bitmap-leaks (2021-10-28) 9 commits
  (merged to 'next' on 2021-11-01 at 47d218862b)
 + pack-bitmap.c: more aggressively free in free_bitmap_index()
 + pack-bitmap.c: don't leak type-level bitmaps
 + midx.c: write MIDX filenames to strbuf
 + builtin/multi-pack-index.c: don't leak concatenated options
 + builtin/repack.c: avoid leaking child arguments
 + builtin/pack-objects.c: don't leak memory via arguments
 + t/helper/test-read-midx.c: free MIDX within read_midx_file()
 + midx.c: don't leak MIDX from verify_midx_file
 + midx.c: clean up chunkfile after reading the MIDX

 Leakfix.

 Will cook in 'next'.


* es/pretty-describe-more (2021-11-01) 3 commits
 - pretty: add abbrev option to %(describe)
 - pretty: add tag option to %(describe)
 - pretty.c: rework describe options parsing for better extensibility

 Extend "git log --format=%(describe)" placeholder to allow passing
 selected command-line options to the underlying "git describe"
 command.


* fs/ssh-signing-key-lifetime (2021-10-27) 8 commits
 - ssh signing: make fmt-merge-msg consider key lifetime
 - ssh signing: make verify-tag consider key lifetime
 - ssh signing: make git log verify key lifetime
 - ssh signing: make verify-commit consider key lifetime
 - ssh signing: add key lifetime test prereqs
 - ssh signing: use sigc struct to pass payload
 - Merge branch 'fs/ssh-signing-fix' into fs/ssh-signing-key-lifetime
 - Merge branch 'fs/ssh-signing' into fs/ssh-signing-key-lifetime

 Extend the signing of objects with SSH keys and learn to pay
 attention to the key validity time range when verifying.


* jc/doc-submitting-patches-choice-of-base (2021-10-25) 2 commits
 - (wip) reword the final review part
 - SubmittingPatchs: clarify choice of base and testing

 Extend the guidance to choose the base commit to build your work
 on, and hint/nudge contributors to read others' changes.


* gc/remote-with-fewer-static-global-variables (2021-10-28) 6 commits
 - remote: add struct repository parameter to external functions
 - remote: die if branch is not found in repository
 - remote: remove the_repository->remote_state from static methods
 - remote: use remote_state parameter internally
 - remote: move static variables into per-repository struct
 - t5516: add test case for pushing remote refspecs

 Code clean-up to eventually allow information on remotes defined
 for an arbitrary repository to be read.

 Will merge to 'next'?


* jk/loosen-urlmatch (2021-10-12) 1 commit
  (merged to 'next' on 2021-10-25 at f66ca39ebe)
 + urlmatch: add underscore to URL_HOST_CHARS

 Treat "_" as any other URL-valid characters in an URL when matching
 the per-URL configuration variable names.

 Will cook in 'next'.


* ab/config-based-hooks-2 (2021-11-01) 18 commits
 - run-command: remove old run_hook_{le,ve}() hook API
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change to use hook.h
 - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
 - git-p4: use 'git hook' to run hooks
 - send-email: use 'git hook run' for 'sendemail-validate'
 - git hook run: add an --ignore-missing flag
 - hooks: convert worktree 'post-checkout' hook to hook library
 - hooks: convert non-worktree 'post-checkout' hook to hook library
 - merge: convert post-merge to use hook.h
 - am: convert applypatch-msg to use hook.h
 - rebase: convert pre-rebase to use hook.h
 - hook API: add a run_hooks_l() wrapper
 - am: convert {pre,post}-applypatch to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - hook API: add a run_hooks() wrapper
 - hook: add 'run' subcommand
 - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2

 More "config-based hooks".


* so/stash-staged (2021-10-28) 2 commits
  (merged to 'next' on 2021-10-29 at 50335e8eeb)
 + stash: get rid of unused argument in stash_staged()
  (merged to 'next' on 2021-10-25 at 68b88e35c4)
 + stash: implement '--staged' option for 'push' and 'save'

 "git stash" learned the "--staged" option to stash away what has
 been added to the index (and nothing else).

 Will cook in 'next'.


* vd/sparse-sparsity-fix-on-read (2021-10-27) 3 commits
 - sparse-index: update do_read_index to ensure correct sparsity
 - sparse-index: add ensure_correct_sparsity function
 - test-read-cache.c: prepare_repo_settings after config init

 Ensure that the sparseness of the in-core index matches the
 index.sparse configuration specified by the repository immediately
 after the on-disk index file is read.

 Will merge to 'next'?


* jc/fix-ref-sorting-parse (2021-10-20) 2 commits
  (merged to 'next' on 2021-10-29 at e3ec6e8e77)
 + for-each-ref: delay parsing of --sort=<atom> options
 + Merge branch 'ab/ref-filter-leakfix' into jc/fix-ref-sorting-parse

 Things like "git -c branch.sort=bogus branch new HEAD", i.e. the
 operation modes of the "git branch" command that do not need the
 sort key information, no longer errors out by seeing a bogus sort
 key.

 Will cook in 'next'.


* jc/tutorial-format-patch-base (2021-10-23) 1 commit
  (merged to 'next' on 2021-10-29 at 67ff1a5a77)
 + MyFirstContribution: teach to use "format-patch --base=auto"

 Teach and encourage first-time contributors to this project to
 state the base commit when they submit their topic.

 Will cook in 'next'.


* js/branch-track-inherit (2021-10-18) 1 commit
 - branch: add flags and config to inherit tracking

 "git -c branch.autosetupmerge=inherit branch new old" makes "new"
 to have the same upstream as the "old" branch, instead of marking
 "old" itself as its upstream.

 Under discussion.
 cf. <87a6j6tbsv.fsf@gmgdl.gmail.com>


* jh/builtin-fsmonitor-part2 (2021-10-21) 29 commits
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - fsmonitor: force update index after large responses
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon: periodically truncate list of modified files
 - t/perf/p7519: add fsmonitor--daemon test cases
 - t/perf/p7519: speed up test on Windows
 - t/helper/test-chmtime: skip directories on Windows
 - t/perf: avoid copying builtin fsmonitor files into test repo
 - t7527: create test for fsmonitor--daemon
 - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
 - help: include fsmonitor--daemon feature flag in version info
 - fsmonitor--daemon: implement handle_client callback
 - compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
 - compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
 - compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor--daemon: implement 'start' command
 - fsmonitor--daemon: implement 'run' command
 - compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
 - compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
 - fsmonitor--daemon: implement 'stop' and 'status' commands
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: document builtin fsmonitor
 - fsmonitor: use IPC to query the builtin FSMonitor daemon
 - fsmonitor: config settings are repository-specific
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - fsmonitor: enhance existing comments

 Built-in fsmonitor (part 2).


* ld/sparse-diff-blame (2021-10-27) 3 commits
 - blame: enable and test the sparse index
 - diff: enable and test the sparse index
 - Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
 (this branch uses vd/sparse-reset.)

 Teach diff and blame to work well with sparse index.

 Expecting a reroll.
 cf. <YXgpqJIS2OgOgS+k@nand.local>


* ns/remerge-diff (2021-10-27) 9 commits
 - doc/diff-options: explain the new --remerge-diff option
 - show, log: adapt Elijah Newren's changes to common tmp-objdir API
 - show, log: provide a --remerge-diff capability
 - merge-ort: capture and print ll-merge warnings in our preferred fashion
 - ll-merge: add API for capturing warnings in a strbuf instead of stderr
 - merge-ort: add ability to record conflict messages in a file
 - merge-ort: mark a few more conflict messages as omittable
 - Merge branch 'ns/tmp-objdir' into ns/remerge-diff
 - Merge branch 'ns/tmp-objdir' into ns/remerge-diff
 (this branch uses ns/tmp-objdir.)

 A new presentation for two-parent merge "--remerge-diff" can be
 used to show the difference between mechanical (and possibly
 conflicted) merge results and the recorded resolution.

 On hold.
 This is Elijah's remerge-diff rebased on ns/tmp-objdir to share the
 "create objects temporarily, only to discard without committing
 them to longer-term storage" infrastructure with another topic.


* ns/tmp-objdir (2021-10-27) 4 commits
  (merged to 'next' on 2021-10-27 at 001a18c0e1)
 + fixup! tmp-objdir: new API for creating temporary writable databases
 + fixup! tmp-objdir: new API for creating temporary writable databases
  (merged to 'next' on 2021-10-23 at 358d376f61)
 + tmp-objdir: disable ref updates when replacing the primary odb
 + tmp-objdir: new API for creating temporary writable databases
 (this branch is used by ns/batched-fsync and ns/remerge-diff.)

 New interface into the tmp-objdir API to help in-core use of the
 quarantine feature.

 On hold.
 cf. <xmqqo87auqda.fsf@gitster.g>


* vd/sparse-reset (2021-10-27) 8 commits
 - unpack-trees: improve performance of next_cache_entry
 - reset: make --mixed sparse-aware
 - reset: make sparse-aware (except --mixed)
 - reset: integrate with sparse index
 - reset: expand test coverage for sparse checkouts
 - sparse-index: update command for expand/collapse test
 - reset: preserve skip-worktree bit in mixed reset
 - reset: rename is_missing to !is_in_reset_tree
 (this branch is used by ld/sparse-diff-blame.)

 Various operating modes of "git reset" have been made to work
 better with the sparse index.

 Will merge to 'next'?


* pw/fix-some-issues-in-reset-head (2021-10-01) 12 commits
 - rebase -m: don't fork git checkout
 - rebase --apply: set ORIG_HEAD correctly
 - rebase --apply: fix reflog
 - reset_head(): take struct rebase_head_opts
 - rebase: cleanup reset_head() calls
 - reset_head(): make default_reflog_action optional
 - reset_head(): factor out ref updates
 - reset_head(): remove action parameter
 - reset_head(): don't run checkout hook if there is an error
 - reset_head(): fix checkout
 - rebase: factor out checkout for up to date branch
 - Merge branch 'pw/rebase-of-a-tag-fix' into pw/fix-some-issues-in-reset-head

 Fix "some issues" in a helper function reset_head().

 Expecting a reroll.
 Needs a lot better explanation, including what the issues are,
 which codepaths the helper is used and to do what, and tests to
 protect the fixes.


* es/superproject-aware-submodules (2021-11-04) 4 commits
 - submodule: record superproject gitdir during 'update'
 - submodule: record superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir record
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).


* tp/send-email-completion (2021-10-28) 2 commits
  (merged to 'next' on 2021-11-01 at 7104356cc0)
 + send-email docs: add format-patch options
 + send-email: programmatically generate bash completions

 The command line complation for "git send-email" options have been
 tweaked to make it easier to keep it in sync with the command itself.

 Will cook in 'next'.


* ns/batched-fsync (2021-10-27) 9 commits
  (merged to 'next' on 2021-10-27 at eb2a3afdd1)
 + Merge branch 'ns/tmp-objdir' into ns/batched-fsync
  (merged to 'next' on 2021-10-25 at e45c907d41)
 + core.fsyncobjectfiles: performance tests for add and stash
 + core.fsyncobjectfiles: tests for batch mode
 + unpack-objects: use the bulk-checkin infrastructure
 + update-index: use the bulk-checkin infrastructure
 + core.fsyncobjectfiles: add windows support for batch mode
 + core.fsyncobjectfiles: batched disk flushes
 + bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 + Merge branch 'ns/tmp-objdir' into ns/batched-fsync
 (this branch uses ns/tmp-objdir.)

 The "core.fsyncobjectfiles" configuration variable can now be set
 to "batch" for improved performance.

 On hold.
 cf. <xmqqo87auqda.fsf@gitster.g>


* en/zdiff3 (2021-09-20) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.


* js/scalar (2021-10-27) 15 commits
 - scalar: accept -C and -c options before the subcommand
 - scalar: implement the `version` command
 - scalar: implement the `delete` command
 - scalar: teach 'reconfigure' to optionally handle all registered enlistments
 - scalar: allow reconfiguring an existing enlistment
 - scalar: implement the `run` command
 - scalar: teach 'clone' to support the --single-branch option
 - scalar: implement the `clone` subcommand
 - scalar: implement 'scalar list'
 - scalar: let 'unregister' handle a deleted enlistment directory gracefully
 - scalar: 'unregister' stops background maintenance
 - scalar: 'register' sets recommended config and starts maintenance
 - scalar: create test infrastructure
 - scalar: start documenting the command
 - scalar: create a rudimentary executable

 Add pieces from "scalar" to contrib/.

 What's the status of this thing?


* ms/customizable-ident-expansion (2021-09-01) 1 commit
 - keyword expansion: make "$Id$" string configurable

 Instead of "$Id$", user-specified string (like $FreeBSD$) can be
 used as an in-blob placeholder for keyword expansion.

 What's the status of this one?  Meh?


* ab/refs-errno-cleanup (2021-10-16) 21 commits
  (merged to 'next' on 2021-10-29 at 3f57147176)
 + refs API: post-migration API renaming [2/2]
 + refs API: post-migration API renaming [1/2]
 + refs API: don't expose "errno" in run_transaction_hook()
 + refs API: make expand_ref() & repo_dwim_log() not set errno
 + refs API: make resolve_ref_unsafe() not set errno
 + refs API: make refs_ref_exists() not set errno
 + refs API: make refs_resolve_refdup() not set errno
 + refs tests: ignore ignore errno in test-ref-store helper
 + refs API: ignore errno in worktree.c's find_shared_symref()
 + refs API: ignore errno in worktree.c's add_head_info()
 + refs API: make files_copy_or_rename_ref() et al not set errno
 + refs API: make loose_fill_ref_dir() not set errno
 + refs API: make resolve_gitlink_ref() not set errno
 + refs API: remove refs_read_ref_full() wrapper
 + refs/files: remove "name exist?" check in lock_ref_oid_basic()
 + reflog tests: add --updateref tests
 + refs API: make refs_rename_ref_available() static
 + refs API: make parse_loose_ref_contents() not set errno
 + refs API: make refs_read_raw_ref() not set errno
 + refs API: add a version of refs_resolve_ref_unsafe() with "errno"
 + branch tests: test for errno propagating on failing read

 The "remainder" of hn/refs-errno-cleanup topic.

 Will cook in 'next'.


* ab/only-single-progress-at-once (2021-11-03) 8 commits
 - progress.c: add & assert a "global_progress" variable
 - various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
 - pack-bitmap-write.c: don't return without stop_progress()
 - progress.c: add temporary variable from progress struct
 - progress.c tests: test some invalid usage
 - progress.c tests: make start/stop commands on stdin
 - progress.c test helper: add missing braces
 - leak tests: fix a memory leaks in "test-progress" helper

 Further tweaks on progress API.


* hn/reftable (2021-10-08) 19 commits
 - Add "test-tool dump-reftable" command.
 - reftable: add dump utility
 - reftable: implement stack, a mutable database of reftable files.
 - reftable: implement refname validation
 - reftable: add merged table view
 - reftable: add a heap-based priority queue for reftable records
 - reftable: reftable file level tests
 - reftable: read reftable files
 - reftable: generic interface to tables
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - Provide zlib's uncompress2 from compat/zlib-compat.c
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: add LICENSE
 - hash.h: provide constants for the hash IDs

 The "reftable" backend for the refs API, without integrating into
 the refs subsystem.
