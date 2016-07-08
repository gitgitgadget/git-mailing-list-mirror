Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE36206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 23:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbcGHXAE (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 19:00:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756313AbcGHW77 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:59:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CD6172AA08;
	Fri,  8 Jul 2016 18:59:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	7O6CD0Dpzp7Tmt95n4N/cEsuO8=; b=H8CctRF0sDNTiql1th9SrrTOLE4Yekozm
	keKshSr6m1CqE18uNr4tt+TrvBDqPo93+Q/qfdwUoBZS9Wakdr5I+lCIuZCsTg0S
	ZkFGM7oOo/dpMIb3CUbanSa9+1CknQabIFBzxYFCSN9+bqhncAadizxTOXJ0NdPw
	iXav6eu1jU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=rzs
	kSUbNc1Zi3X1UbXHrbJGQO7283r8wcTbm6+payOoRc1TVQWmIy5or/uc6DJwRm1r
	VnbR5ILhOhsi+5CeWOHnhAy1eb+DmlT1EG48FsmY5UxAxusqs0EhigLGLlb4AjKH
	T/vkQz3iIZ/v37l/NWjW5GpkQSTI7Sul8PJeIrlU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C36962AA07;
	Fri,  8 Jul 2016 18:59:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 04E812AA06;
	Fri,  8 Jul 2016 18:59:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2016, #03; Fri, 8)
X-master-at: 5c589a73de4394ad125a4effac227b3aec856fa1
X-next-at: 281e4d64a61b891e32e0344654b580b4203effa6
Date:	Fri, 08 Jul 2016 15:59:53 -0700
Message-ID: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B01D609A-455F-11E6-96C9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The first few batches for this cycle has been merged to 'master',
and new topics are trickling into 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* rs/help-c-source-with-gitattributes (2016-07-07) 1 commit
 - .gitattributes: set file type for C files

 The .c/.h sources are marked as such in our .gitattributes file so
 that "git diff -W" and friends would work better.

 Will merge to 'next'.


* rs/notes-merge-no-toctou (2016-07-07) 1 commit
 - notes-merge: use O_EXCL to avoid overwriting existing files

 "git notes merge" had a code to see if a path exists (and fails if
 it does) and then open the path for writing (when it doesn't).
 Replace it with open with O_EXCL.


* rw/make-needs-librt (2016-07-07) 1 commit
 - Makefile: add NEEDS_LIBRT to optionally link with librt

 Makefile assumed that -lrt is always available on platforms that
 want to use clock_gettime() and CLOCK_MONOTONIC, which is not a
 case for recent Mac OS X.  The necessary symbols are often found in
 libc on many modern systems and having -lrt on the command line, as
 long as the library exists, had no effect, but when the platform
 removes librt.a that is a different matter--having -lrt will break
 the linkage.

 This change could be seen as a regression for those who do need to
 specify -lrt, as they now specifically ask for NEEDS_LIBRT when
 building. Hopefully they are in the minority these days.

 Will merge to 'next'.


* jc/renormalize-merge-kill-safer-crlf (2016-07-08) 2 commits
 - merge: avoid "safer crlf" during recording of merge results
 - convert: unify the "auto" handling of CRLF
 (this branch is tangled with tb/convert-peek-in-index.)

 "git merge" with renormalization did not work well with
 merge-recursive, due to "safer crlf" conversion kicking in when it
 shouldn't.


* jk/printf-format (2016-07-08) 3 commits
 - commit.c: remove print_commit_list()
 - avoid using sha1_to_hex output as printf format
 - walker: let walker_say take arbitrary formats

 Code clean-up to avoid using a variable string that compilers may
 feel untrustable as printf-style format given to write_file()
 helper function.

 Will merge to 'next'.


* jk/write-file (2016-07-08) 9 commits
 - branch: use write_file_buf instead of write_file
 - use write_file_buf where applicable
 - write_file: add format attribute
 - write_file: add pointer+len variant
 - write_file: use xopen
 - write_file: drop "gently" form
 - branch: use non-gentle write_file for branch description
 - am: ignore return value of write_file()
 - config: fix bogus fd check when setting up default config

 General code clean-up around a helper function to write a
 single-liner to a file.

 Will merge to 'next'.
 While it is textually independent, jk/printf-format needs to be
 merged before this one.


* js/am-call-theirs-theirs-in-fallback-3way (2016-07-08) 1 commit
 - am: counteract gender bias

 One part of "git am" had an oddball helper function that called
 stuff from outside "his" as opposed to calling what we have "ours",
 which was not gender-neutral and also inconsistent with the rest of
 the system where outside stuff is usuall called "theirs" in
 contrast to "ours".

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jh/clean-smudge-annex (2016-07-08) 9 commits
 - SQUASH??? compilation fix
 - use smudgeToFile filter in recursive merge
 - use smudgeToFile filter in git am
 - better recovery from failure of smudgeToFile filter
 - warn on unusable smudgeToFile/cleanFromFile config
 - use smudgeToFile in git checkout etc
 - use cleanFromFile in git add
 - add smudgeToFile and cleanFromFile filter configs
 - clarify %f documentation

 The interface to "clean/smudge" filters require Git to feed the
 whole contents via pipe, which is suboptimal for some applications.
 "cleanFromFile/smudgeToFile" commands are the moral equilvalents
 for these filters but they interact with the files on the
 filesystem directly.


* tb/convert-peek-in-index (2016-07-07) 3 commits
 . correct ce_compare_data() in a middle of a merge
 . read-cache: factor out get_sha1_from_index() helper
 - convert: unify the "auto" handling of CRLF
 (this branch is tangled with jc/renormalize-merge-kill-safer-crlf.)

 Tentatively replaced with jc/renormalize-merge-kill-safer-crlf


* sb/bisect (2016-04-15) 22 commits
 - SQUASH???
 - bisect: get back halfway shortcut
 - bisect: compute best bisection in compute_relevant_weights()
 - bisect: use a bottom-up traversal to find relevant weights
 - bisect: prepare for different algorithms based on find_all
 - bisect: rename count_distance() to compute_weight()
 - bisect: make total number of commits global
 - bisect: introduce distance_direction()
 - bisect: extract get_distance() function from code duplication
 - bisect: use commit instead of commit list as arguments when appropriate
 - bisect: replace clear_distance() by unique markers
 - bisect: use struct node_data array instead of int array
 - bisect: get rid of recursion in count_distance()
 - bisect: make algorithm behavior independent of DEBUG_BISECT
 - bisect: make bisect compile if DEBUG_BISECT is set
 - bisect: plug the biggest memory leak
 - bisect: add test for the bisect algorithm
 - t6030: generalize test to not rely on current implementation
 - t: use test_cmp_rev() where appropriate
 - t/test-lib-functions.sh: generalize test_cmp_rev
 - bisect: allow 'bisect run' if no good commit is known
 - bisect: write about `bisect next` in documentation

 The internal algorithm used in "git bisect" to find the next commit
 to check has been optimized greatly.

 Expecting a reroll.
 ($gmane/291163)


* sg/completion-updates (2016-02-28) 21 commits
 . completion: cache the path to the repository
 . completion: extract repository discovery from __gitdir()
 . completion: don't guard git executions with __gitdir()
 . completion: consolidate silencing errors from git commands
 . completion: don't use __gitdir() for git commands
 . completion: respect 'git -C <path>'
 . completion: fix completion after 'git -C <path>'
 . completion: don't offer commands when 'git --opt' needs an argument
 . rev-parse: add '--absolute-git-dir' option
 . completion: list short refs from a remote given as a URL
 . completion: don't list 'HEAD' when trying refs completion outside of a repo
 . completion: list refs from remote when remote's name matches a directory
 . completion: respect 'git --git-dir=<path>' when listing remote refs
 . completion: fix most spots not respecting 'git --git-dir=<path>'
 . completion: ensure that the repository path given on the command line exists
 . completion tests: add tests for the __git_refs() helper function
 . completion tests: check __gitdir()'s output in the error cases
 . completion tests: consolidate getting path of current working directory
 . completion tests: make the $cur variable local to the test helper functions
 . completion tests: don't add test cruft to the test repository
 . completion: improve __git_refs()'s in-code documentation

 Will be rerolled.
 ($gmane/287839)


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for a reroll.
 ($gmane/284368).


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.
 Will discard.

--------------------------------------------------
[Cooking]

* ak/lazy-prereq-mktemp (2016-07-06) 1 commit
 - t7610: test for mktemp before test execution

 A test that unconditionally used "mktemp" learned that the command
 is not necessarily available everywhere.

 Will merge to 'next'.


* ew/svn-bad-ref (2016-07-06) 1 commit
 - git-svn: warn instead of dying when commit data is missing

 An earlier update to "git svn" tightened the parsing of refs given
 as the command line arguments too much.  This has been fixed by
 loosening the check a bit.

 I'm likely to discard this, favouring a direct pull request from
 the subsystem maintainer directly going to 'master'.


* jk/difftool-in-subdir (2016-07-06) 1 commit
 - difftool: fix argument handling in subdirs

 "git difftool <paths>..." started in a subdirectory failed to
 interpret the paths relative to that directory, which has been
 fixed.

 Waiting for an ack.


* nd/test-helpers (2016-07-06) 2 commits
 - Makefile: use VCSSVN_LIB to refer to svn library
 - Makefile: drop extra dependencies for test helpers

 Build clean-up.

 Will merge to 'next'.


* dk/blame-move-no-reason-for-1-line-context (2016-05-29) 1 commit
  (merged to 'next' on 2016-07-06 at 087490c)
 + blame: require 0 context lines while finding moved lines with -M

 "git blame -M" missed a single line that was moved within the file.

 We may want to squash a test or two to this commit.  Volunteers?


* jk/common-main (2016-07-06) 1 commit
 - Merge branch 'jk/common-main-2.8' into jk/common-main
 (this branch uses jk/common-main-2.8.)

 Prepare jk/commin-main-2.8 topic to be mergeable to 2.9 and later.

 Will merge to 'next'.


* jk/common-main-2.8 (2016-07-06) 6 commits
 - mingw: declare main()'s argv as const
 - common-main: call git_setup_gettext()
 - common-main: call restore_sigpipe_to_default()
 - common-main: call sanitize_stdfds()
 - common-main: call git_extract_argv0_path()
 - add an extra level of indirection to main()
 (this branch is used by jk/common-main.)

 There are certain house-keeping tasks that need to be performed at
 the very beginning of any Git program, and programs that are not
 built-in commands had to do them exactly the same way as "git"
 potty does.  It was easy to make mistakes in one-off standalone
 programs (like test helpers).  A common "main()" function that
 calls cmd_main() of individual program has been introduced to
 make it harder to make mistakes.


* nd/ita-cleanup (2016-07-01) 3 commits
  (merged to 'next' on 2016-07-06 at f15aeba)
 + grep: fix grepping for "intent to add" files
 + t7810-grep.sh: fix a whitespace inconsistency
 + t7810-grep.sh: fix duplicated test name

 Git does not know what the contents in the index should be for a
 path added with "git add -N" yet, so "git grep --cached" should not
 show hits (or show lack of hits, with -L) in such a path.  But we
 did by mistake, which has been corrected.

 Will merge to 'master'.


* cc/apply-am (2016-06-28) 41 commits
 - apply: use error_errno() where possible
 - builtin/am: use apply api in run_apply()
 - apply: change error_routine when be_silent is set
 - usage: add get_error_routine() and get_warn_routine()
 - usage: add set_warn_routine()
 - apply: don't print on stdout when be_silent is set
 - apply: make 'be_silent' incompatible with 'apply_verbosely'
 - apply: add 'be_silent' variable to 'struct apply_state'
 - write_or_die: use warning() instead of fprintf(stderr, ...)
 - environment: add set_index_file()
 - apply: make some parsing functions static again
 - apply: move libified code from builtin/apply.c to apply.{c,h}
 - apply: rename and move opt constants to apply.h
 - builtin/apply: rename option parsing functions
 - builtin/apply: make create_one_file() return -1 on error
 - builtin/apply: make try_create_file() return -1 on error
 - builtin/apply: make write_out_results() return -1 on error
 - builtin/apply: make write_out_one_result() return -1 on error
 - builtin/apply: make create_file() return -1 on error
 - builtin/apply: make add_index_file() return -1 on error
 - builtin/apply: make add_conflicted_stages_file() return -1 on error
 - builtin/apply: make remove_file() return -1 on error
 - builtin/apply: make build_fake_ancestor() return -1 on error
 - builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
 - builtin/apply: make gitdiff_*() return -1 on error
 - builtin/apply: make gitdiff_*() return 1 at end of header
 - builtin/apply: make parse_traditional_patch() return -1 on error
 - builtin/apply: make apply_all_patches() return 128 or 1 on error
 - builtin/apply: move check_apply_state() to apply.c
 - builtin/apply: make check_apply_state() return -1 instead of die()ing
 - apply: make init_apply_state() return -1 instead of exit()ing
 - builtin/apply: move init_apply_state() to apply.c
 - builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
 - builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
 - builtin/apply: make parse_single_patch() return -1 on error
 - builtin/apply: make parse_chunk() return a negative integer on error
 - builtin/apply: make find_header() return -128 instead of die()ing
 - builtin/apply: read_patch_file() return -1 instead of die()ing
 - builtin/apply: make apply_patch() return -1 or -128 instead of die()ing
 - apply: move 'struct apply_state' to apply.h
 - apply: make some names more specific

 "git am" has been taught to make an internal call to "git apply"'s
 innards without spawning the latter as a separate process.

 Needs review.


* dp/autoconf-curl-ssl (2016-06-28) 1 commit
 - ./configure.ac: detect SSL in libcurl using curl-config

 The ./configure script generated from configure.ac was taught how
 to detect support of SSL by libcurl better.

 Needs review.


* js/color-on-windows-comment (2016-06-28) 1 commit
  (merged to 'next' on 2016-06-28 at 38a2ea1)
 + color.h: remove obsolete comment about limitations on Windows

 For a long time, we carried an in-code comment that said our
 colored output would work only when we use fprintf/fputs on
 Windows, which no longer is the case for the past few years.

 Will merge to 'master'.


* js/sign-empty-commit-fix (2016-06-29) 1 commit
  (merged to 'next' on 2016-07-06 at 448da1b)
 + commit -S: avoid invalid pointer with empty message

 "git commit --amend --allow-empty-message -S" for a commit without
 any message body could have misidentified where the header of the
 commit object ends.

 Will merge to 'master'.


* js/t3404-grammo-fix (2016-06-29) 1 commit
  (merged to 'next' on 2016-07-06 at 4378654)
 + t3404: fix a grammo (commands are ran -> commands are run)

 Grammofix.

 Will merge to 'master'.


* ls/p4-tmp-refs (2016-07-08) 1 commit
 - git-p4: place temporary refs used for branch import under refs/git-p4-tmp

 "git p4" used a location outside $GIT_DIR/refs/ to place its
 temporary branches, which has been moved to refs/git-p4-tmp/.

 Will merge to 'next'.


* jc/pull-rebase-ff (2016-06-29) 1 commit
 -   pull: fast-forward "pull --rebase=true"

 "git pull --rebase", when there is no new commits on our side since
 we forked from the upstream, should be able to fast-forward without
 invoking "git rebase", but it didn't.

 Needs a real log message and a few tests.


* ps/rebase-i-auto-unstash-upon-abort (2016-06-29) 1 commit
  (merged to 'next' on 2016-07-06 at 0fdcedb)
 + rebase -i: restore autostash on abort

 "git rebase -i --autostash" did not restore the auto-stashed change
 when the operation was aborted.

 Will merge to 'master'.


* dg/subtree-rebase-test (2016-06-28) 1 commit
  (merged to 'next' on 2016-07-06 at 4dec1ad)
 + contrib/subtree: Add a test for subtree rebase that loses commits

 This is just a test to specify the desired behaviour that currently
 is not available.

 Will merge to 'master'.


* jk/test-match-signal (2016-07-06) 4 commits
 - t/lib-git-daemon: use test_match_signal
 - test_must_fail: use test_match_signal
 - t0005: use test_match_signal as appropriate
 - tests: factor portable signal check out of t0005

 The test framework learned a new helper test_match_signal to check
 an exit code from getting killed by an expected signal.

 Will merge to 'next'.


* ah/unpack-trees-advice-messages (2016-06-27) 1 commit
  (merged to 'next' on 2016-07-06 at 4254fc2)
 + unpack-trees: fix English grammar in do-this-before-that messages

 Grammofix.

 Will merge to 'master'.


* ew/gc-auto-pack-limit-fix (2016-06-27) 1 commit
  (merged to 'next' on 2016-07-06 at aa023d3)
 + gc: fix off-by-one error with gc.autoPackLimit

 "gc.autoPackLimit" when set to 1 should not trigger a repacking
 when there is only one pack, but the code counted poorly and did
 so.

 Will merge to 'master'.


* nd/connect-ssh-command-config (2016-07-06) 1 commit
  (merged to 'next' on 2016-07-06 at 6eac316)
 + connect: read $GIT_SSH_COMMAND from config file

 A new configuration variable core.sshCommand to specify what value
 for GIT_SSH_COMMAND to use per repository.

 Will merge to 'master'.


* nd/doc-new-command (2016-06-27) 1 commit
  (merged to 'next' on 2016-07-06 at 1404b64)
 + new-command.txt: correct the command description file

 Typofix in a doc.

 Will merge to 'master'.


* po/range-doc (2016-07-01) 3 commits
 - doc: give headings for the two and three dot notations
 - doc: show the actual left, right, and boundary marks
 - doc: use 'symmetric difference' consistently

 Clarify various ways to specify the "revision ranges" in the
 documentation.

 Will hold.

 There is another one that tries to clarify r1..r2 excludes r1
 itself, which is not queued here waiting for the conclusion of a
 review discussion.  Otherwise looked good.


* sb/submodule-parallel-fetch (2016-06-27) 2 commits
  (merged to 'next' on 2016-07-06 at de5fd35)
 + xwrite: poll on non-blocking FDs
 + xread: retry after poll on EAGAIN/EWOULDBLOCK

 Fix a recently introduced codepaths that are involved in parallel
 submodule operations, which gave up on reading too early, and
 could have wasted CPU while attempting to write under a corner case
 condition.

 Will merge to 'master'.


* mm/doc-tt (2016-06-28) 7 commits
  (merged to 'next' on 2016-07-06 at a8c74bd)
 + doc: typeset HEAD and variants as literal
 + CodingGuidelines: formatting HEAD in documentation
 + doc: typeset long options with argument as literal
 + doc: typeset '--' as literal
 + doc: typeset long command-line options as literal
 + doc: typeset short command-line options as literal
 + Documentation/git-mv.txt: fix whitespace indentation

 More mark-up updates to typeset strings that are expected to
 literally typed by the end user in fixed-width font.

 Will merge to 'master'.


* nd/fetch-ref-summary (2016-07-06) 5 commits
 - fetch: reduce duplicate in ref update status lines with placeholder
 - fetch: align all "remote -> local" output
 - fetch: change flag code for displaying tag update and deleted ref
 - fetch: refactor ref update status formatting code
 - git-fetch.txt: document fetch output

 Improve the look of the way "git fetch" reports what happened to
 each ref that was fetched.

 Will merge to 'next'.


* jk/perf-any-version (2016-06-22) 2 commits
  (merged to 'next' on 2016-06-28 at 6a41c30)
 + p4211: explicitly disable renames in no-rename test
 + t/perf: fix regression in testing older versions of git

 Allow t/perf framework to use the features from the most recent
 version of Git even when testing an older installed version.

 Will merge to 'master'.


* jn/preformatted-doc-url (2016-06-22) 1 commit
  (merged to 'next' on 2016-06-28 at 60a99eb)
 + doc: git-htmldocs.googlecode.com is no more

 Will merge to 'master'.


* ex/deprecate-empty-pathspec-as-match-all (2016-06-22) 1 commit
 - pathspec: warn on empty strings as pathspec

 An empty string used as a pathspec element has always meant
 'everything matches', but it is too easy to write a script that
 finds a path to remove in $path and run 'git rm "$paht"', which
 ends up removing everything.  Start warning about this use of an
 empty string used for 'everything matches' and ask users to use a
 more explicit '.' for that instead.

 The hope is that existing users will not mind this change, and
 eventually the warning can be turned into a hard error, upgrading
 the deprecation into removal of this (mis)feature.

 Will merge to 'next'.


* jk/ansi-color (2016-06-23) 7 commits
  (merged to 'next' on 2016-06-28 at 354989c)
 + color: support strike-through attribute
 + color: support "italic" attribute
 + color: allow "no-" for negating attributes
 + color: refactor parse_attr
 + add skip_prefix_mem helper
 + doc: refactor description of color format
 + color: fix max-size comment

 The output coloring scheme learned two new attributes, italic and
 strike, in addition to existing bold, reverse, etc.

 Will merge to 'master'.


* nd/icase (2016-07-01) 12 commits
 - grep.c: reuse "icase" variable
 - diffcore-pickaxe: support case insensitive match on non-ascii
 - diffcore-pickaxe: Add regcomp_or_die()
 - grep/pcre: support utf-8
 - gettext: add is_utf8_locale()
 - grep/pcre: prepare locale-dependent tables for icase matching
 - grep: rewrite an if/else condition to avoid duplicate expression
 - grep/icase: avoid kwsset when -F is specified
 - grep/icase: avoid kwsset on literal non-ascii strings
 - test-regex: expose full regcomp() to the command line
 - test-regex: isolate the bug test code
 - grep: break down an "if" stmt in preparation for next changes

 "git grep -i" has been taught to fold case in non-ascii locales
 correctly.

 Will merge to 'next'.


* mj/log-show-signature-conf (2016-06-24) 3 commits
  (merged to 'next' on 2016-06-28 at c8b3347)
 + log: add log.showSignature configuration variable
 + log: add "--no-show-signature" command line option
 + t4202: refactor test

 "git log" learns log.showSignature configuration variable, and a
 command line option "--no-show-signature" to countermand it.

 Will merge to 'master'.


* mh/ref-store (2016-06-20) 38 commits
 - refs: implement iteration over only per-worktree refs
 - refs: make lock generic
 - refs: add method to rename refs
 - refs: add methods to init refs db
 - refs: make delete_refs() virtual
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add method iterator_begin
 - files_ref_iterator_begin(): take a ref_store argument
 - split_symref_update(): add a files_ref_store argument
 - lock_ref_sha1_basic(): add a files_ref_store argument
 - lock_ref_for_update(): add a files_ref_store argument
 - commit_ref_update(): add a files_ref_store argument
 - lock_raw_ref(): add a files_ref_store argument
 - repack_without_refs(): add a files_ref_store argument
 - refs: make peel_ref() virtual
 - refs: make create_symref() virtual
 - refs: make pack_refs() virtual
 - refs: make verify_refname_available() virtual
 - refs: make read_raw_ref() virtual
 - resolve_gitlink_ref(): rename path parameter to submodule
 - resolve_gitlink_ref(): avoid memory allocation in many cases
 - resolve_gitlink_ref(): implement using resolve_ref_recursively()
 - resolve_ref_recursively(): new function
 - read_raw_ref(): take a (struct ref_store *) argument
 - resolve_gitlink_packed_ref(): remove function
 - resolve_packed_ref(): rename function from resolve_missing_loose_ref()
 - refs: reorder definitions
 - refs: add a transaction_commit() method
 - {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
 - resolve_missing_loose_ref(): add a files_ref_store argument
 - get_packed_ref(): add a files_ref_store argument
 - add_packed_ref(): add a files_ref_store argument
 - refs: create a base class "ref_store" for files_ref_store
 - refs: add a backend method structure
 - refs: rename struct ref_cache to files_ref_store
 - rename_ref_available(): add docstring
 - resolve_gitlink_ref(): eliminate temporary variable
 (this branch uses mh/ref-iterators and mh/split-under-lock; is tangled with mh/update-ref-errors.)

 The ref-store abstraction was introduced to the refs API so that we
 can plug in different backends to store references.

 Needs a fixup.
 ($gmane/298137)


* mh/update-ref-errors (2016-06-20) 6 commits
 - lock_ref_for_update(): avoid a symref resolution
 - lock_ref_for_update(): make error handling more uniform
 - t1404: add more tests of update-ref error handling
 - t1404: document function test_update_rejected
 - t1404: remove "prefix" argument to test_update_rejected
 - t1404: rename file to t1404-update-ref-errors.sh
 (this branch uses mh/split-under-lock; is tangled with mh/ref-iterators and mh/ref-store.)

 Error handling in the codepaths that updates refs has been
 improved.

 Will merge to 'next'.


* js/find-commit-subject-ignore-leading-blanks (2016-06-29) 5 commits
  (merged to 'next' on 2016-06-29 at 9717e00)
 + reset --hard: skip blank lines when reporting the commit subject
 + sequencer: use skip_blank_lines() to find the commit subject
 + commit -C: skip blank lines at the beginning of the message
  (merged to 'next' on 2016-06-28 at 32bbd94)
 + commit.c: make find_commit_subject() more robust
 + pretty: make the skip_blank_lines() function public

 A helper function that takes the contents of a commit object and
 finds its subject line did not ignore leading blank lines, as is
 commonly done by other codepaths.  Make it ignore leading blank
 lines to match.

 Will merge to 'master'.


* js/log-to-diffopt-file (2016-06-28) 11 commits
  (merged to 'next' on 2016-07-06 at 39e7a5f)
 + diff: do not color output when --color=auto and --output=<file> is given
 + t4211: ensure that log respects --output=<file>
 + shortlog: respect the --output=<file> setting
 + format-patch: use stdout directly
 + format-patch: avoid freopen()
 + format-patch: explicitly switch off color when writing to files
 + shortlog: support outputting to streams other than stdout
 + graph: respect the diffopt.file setting
 + line-log: respect diffopt's configured output file stream
 + log-tree: respect diffopt's configured output file stream
 + log: prepare log/log-tree to reuse the diffopt.close_file attribute

 The commands in the "log/diff" family had an FILE* pointer in the
 data structure they pass around for a long time, but some codepaths
 used to always write to the standard output.  As a preparatory step
 to make "git format-patch" available to the internal callers, these
 codepaths have been updated to consistently write into that FILE*
 instead.

 Will merge to 'master'.


* bc/cocci (2016-06-28) 11 commits
  (merged to 'next' on 2016-07-06 at f2e8e2a)
 + diff: convert prep_temp_blob() to struct object_id
 + merge-recursive: convert merge_recursive_generic() to object_id
 + merge-recursive: convert leaf functions to use struct object_id
 + merge-recursive: convert struct merge_file_info to object_id
 + merge-recursive: convert struct stage_data to use object_id
 + diff: rename struct diff_filespec's sha1_valid member
 + diff: convert struct diff_filespec to struct object_id
 + coccinelle: apply object_id Coccinelle transformations
 + coccinelle: convert hashcpy() with null_sha1 to hashclr()
 + contrib/coccinelle: add basic Coccinelle transforms
 + hex: add oid_to_hex_r()

 Conversion from unsigned char sha1[20] to struct object_id
 continues.

 Will cook a bit in 'next' and then merge to 'master'.


* jk/big-and-future-archive-tar (2016-07-01) 5 commits
  (merged to 'next' on 2016-07-06 at 89f3835)
 + archive-tar: drop return value
 + archive-tar: write extended headers for far-future mtime
 + archive-tar: write extended headers for file sizes >= 8GB
 + t5000: test tar files that overflow ustar headers
 + t9300: factor out portable "head -c" replacement

 "git archive" learned to handle files that are larger than 8GB and
 commits far in the future than expressible by the traditional US-TAR
 format.

 Will merge to 'master'.


* lf/recv-sideband-cleanup (2016-07-06) 2 commits
  (merged to 'next' on 2016-07-06 at d527bcb)
 + sideband.c: small optimization of strbuf usage
 + sideband.c: refactor recv_sideband()

 Code simplification.

 Will merge to 'master'.


* sb/submodule-clone-retry (2016-06-13) 2 commits
  (merged to 'next' on 2016-06-28 at 8a86d54)
 + submodule update: continue when a clone fails
 + submodule--helper: initial clone learns retry logic

 "git submodule update" that drives many "git clone" could
 eventually hit flaky servers/network conditions on one of the
 submodules; the command learned to retry the attempt.

 Will merge to 'master'.


* jc/blame-reverse (2016-06-14) 2 commits
 - blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
 - blame: improve diagnosis for "--reverse NEW"

 It is a common mistake to say "git blame --reverse OLD path",
 expecting that the command line is dwimmed as if asking how lines
 in path in an old revision OLD have survived up to the current
 commit.

 Any supporters?  Otherwise will drop.


* nd/shallow-deepen (2016-06-13) 27 commits
 - fetch, upload-pack: --deepen=N extends shallow boundary by N commits
 - upload-pack: add get_reachable_list()
 - upload-pack: split check_unreachable() in two, prep for get_reachable_list()
 - t5500, t5539: tests for shallow depth excluding a ref
 - clone: define shallow clone boundary with --shallow-exclude
 - fetch: define shallow boundary with --shallow-exclude
 - upload-pack: support define shallow boundary by excluding revisions
 - refs: add expand_ref()
 - t5500, t5539: tests for shallow depth since a specific date
 - clone: define shallow clone boundary based on time with --shallow-since
 - fetch: define shallow boundary with --shallow-since
 - upload-pack: add deepen-since to cut shallow repos based on time
 - shallow.c: implement a generic shallow boundary finder based on rev-list
 - fetch-pack: use a separate flag for fetch in deepening mode
 - fetch-pack.c: mark strings for translating
 - fetch-pack: use a common function for verbose printing
 - fetch-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move rev-list code out of check_non_tip()
 - upload-pack: make check_non_tip() clean things up on error
 - upload-pack: tighten number parsing at "deepen" lines
 - upload-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move "unshallow" sending code out of deepen()
 - upload-pack: remove unused variable "backup"
 - upload-pack: move "shallow" sending code out of deepen()
 - upload-pack: move shallow deepen code out of receive_needs()
 - transport-helper.c: refactor set_helper_option()
 - remote-curl.c: convert fetch_git() to use argv_array

 The existing "git fetch --depth=<n>" option was hard to use
 correctly when making the history of an existing shallow clone
 deeper.  A new option, "--deepen=<n>", has been added to make this
 easier to use.  "git clone" also learned "--shallow-since=<date>"
 and "--shallow-exclude=<tag>" options to make it easier to specify
 "I am interested only in the recent N months worth of history" and
 "Give me only the history since that version".

 Needs review.

 Rerolled.  What this topic attempts to achieve is worthwhile, I
 would think.


* jc/attr-more (2016-06-09) 8 commits
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - fixup! d5ad6c13
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 (this branch uses jc/attr; is tangled with sb/pathspec-label and sb/submodule-default-paths.)

 The beginning of long and tortuous journey to clean-up attribute
 subsystem implementation.

 Needs to be redone.


* mh/ref-iterators (2016-06-20) 13 commits
 - for_each_reflog(): reimplement using iterators
 - dir_iterator: new API for iterating over a directory tree
 - for_each_reflog(): don't abort for bad references
 - do_for_each_ref(): reimplement using reference iteration
 - refs: introduce an iterator interface
 - ref_resolves_to_object(): new function
 - entry_resolves_to_object(): rename function from ref_resolves_to_object()
 - get_ref_cache(): only create an instance if there is a submodule
 - remote rm: handle symbolic refs correctly
 - delete_refs(): add a flags argument
 - refs: use name "prefix" consistently
 - do_for_each_ref(): move docstring to the header file
 - refs: remove unnecessary "extern" keywords
 (this branch is used by mh/ref-store; uses mh/split-under-lock; is tangled with mh/update-ref-errors.)

 The API to iterate over all the refs (i.e. for_each_ref(), etc.)
 has been revamped.

 Will merge to 'next'.


* mh/connect (2016-06-06) 10 commits
 - connect: [host:port] is legacy for ssh
 - connect: move ssh command line preparation to a separate function
 - connect: actively reject git:// urls with a user part
 - connect: change the --diag-url output to separate user and host
 - connect: make parse_connect_url() return the user part of the url as a separate value
 - connect: group CONNECT_DIAG_URL handling code
 - connect: make parse_connect_url() return separated host and port
 - connect: re-derive a host:port string from the separate host and port variables
 - connect: call get_host_and_port() earlier
 - connect: document why we sometimes call get_port after get_host_and_port

 Rewrite Git-URL parsing routine (hopefully) without changing any
 behaviour.

 Comments?


* va/i18n-even-more (2016-07-01) 39 commits
  (merged to 'next' on 2016-07-01 at fa5e50e3)
 + t5541: become resilient to GETTEXT_POISON
  (merged to 'next' on 2016-06-28 at 5919dfa)
 + i18n: branch: mark comment when editing branch description for translation
 + i18n: unmark die messages for translation
 + i18n: submodule: escape shell variables inside eval_gettext
 + i18n: submodule: join strings marked for translation
 + i18n: init-db: join message pieces
 + i18n: remote: allow translations to reorder message
 + i18n: remote: mark URL fallback text for translation
 + i18n: standardise messages
 + i18n: sequencer: add period to error message
 + i18n: merge: change command option help to lowercase
 + i18n: merge: mark messages for translation
 + i18n: notes: mark options for translation
 + i18n: notes: mark strings for translation
 + i18n: transport-helper.c: change N_() call to _()
 + i18n: bisect: mark strings for translation
 + t5523: use test_i18ngrep for negation
 + t4153: fix negated test_i18ngrep call
 + t9003: become resilient to GETTEXT_POISON
 + tests: unpack-trees: update to use test_i18n* functions
 + tests: use test_i18n* functions to suppress false positives
 + i18n: setup: mark strings for translation
 + i18n: rebase-interactive: mark comments of squash for translation
 + i18n: rebase-interactive: mark here-doc strings for translation
 + i18n: rebase-interactive: mark strings for translation
 + i18n: git-sh-setup.sh: mark strings for translation
 + t6030: update to use test_i18ncmp
 + i18n: bisect: simplify error message for i18n
 + i18n: rebase: mark placeholder for translation
 + i18n: rebase: fix marked string to use eval_gettext variant
 + merge-octopus: use die shell function from git-sh-setup.sh
 + i18n: merge-octopus: mark messages for translation
 + i18n: sequencer: mark string for translation
 + i18n: sequencer: mark entire sentences for translation
 + i18n: transport: mark strings for translation
 + i18n: advice: internationalize message for conflicts
 + i18n: advice: mark string about detached head for translation
 + i18n: builtin/remote.c: fix mark for translation
 + Merge branch 'jc/t2300-setup' into HEAD

 More markings of messages for i18n, with updates to various tests
 to pass GETTEXT_POISON tests.

 One patch from the original submission dropped due to conflicts
 with jk/upload-pack-hook, which is still in flux.

 Will merge to 'master'.


* nd/worktree-lock (2016-07-08) 6 commits
 - worktree.c: find_worktree() search by path suffix
 - worktree: add "unlock" command
 - worktree: add "lock" command
 - worktree.c: add is_worktree_locked()
 - worktree.c: add is_main_worktree()
 - worktree.c: add find_worktree()

 "git worktree prune" protected worktrees that are marked as
 "locked" by creating a file in a known location.  "git worktree"
 command learned a dedicated command pair to create and remoev such
 a file, so that the users do not have to do this with editor.

 Will merge to 'next'.


* sb/submodule-default-paths (2016-06-20) 5 commits
 - completion: clone can recurse into submodules
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - Merge branch 'sb/pathspec-label' into sb/submodule-default-paths
 - Merge branch 'jc/attr' into sb/submodule-default-paths
 (this branch uses jc/attr and sb/pathspec-label; is tangled with jc/attr-more.)

 Allow specifying the set of submodules the user is interested in on
 the command line of "git clone" that clones the superproject.


* jc/attr (2016-05-25) 18 commits
 - attr: support quoting pathname patterns in C style
 - attr: expose validity check for attribute names
 - attr: add counted string version of git_attr()
 - attr: add counted string version of git_check_attr()
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct git_attr_check"
 - attr: (re)introduce git_check_attr() and struct git_attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line
 (this branch is used by jc/attr-more, sb/pathspec-label and sb/submodule-default-paths.)

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.

 I wanted to polish this topic further to make the attribute
 subsystem thread-ready, but because other topics depend on this
 topic and they do not (yet) need it to be thread-ready, let's merge
 this early part together with the dependent topics to 'next', and
 back-burner the threading enhancement to another day.


* pb/bisect (2016-06-27) 9 commits
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 GSoC "bisect" topic.


* sb/pathspec-label (2016-06-03) 6 commits
 - pathspec: disable preload-index when attribute pathspec magic is in use
 - pathspec: allow escaped query values
 - pathspec: allow querying for attributes
 - pathspec: move prefix check out of the inner loop
 - pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 (this branch is used by sb/submodule-default-paths; uses jc/attr; is tangled with jc/attr-more.)

 The pathspec mechanism learned ":(attr:X)$pattern" pathspec magic
 to limit paths that match $pattern further by attribute settings.
 The preload-index mechanism is disabled when the new pathspec magic
 is in use (at least for now), because the attribute subsystem is
 not thread-ready.


* mh/split-under-lock (2016-06-13) 33 commits
 - lock_ref_sha1_basic(): only handle REF_NODEREF mode
 - commit_ref_update(): remove the flags parameter
 - lock_ref_for_update(): don't resolve symrefs
 - lock_ref_for_update(): don't re-read non-symbolic references
 - refs: resolve symbolic refs first
 - ref_transaction_update(): check refname_is_safe() at a minimum
 - unlock_ref(): move definition higher in the file
 - lock_ref_for_update(): new function
 - add_update(): initialize the whole ref_update
 - verify_refname_available(): adjust constness in declaration
 - refs: don't dereference on rename
 - refs: allow log-only updates
 - delete_branches(): use resolve_refdup()
 - ref_transaction_commit(): correctly report close_ref() failure
 - ref_transaction_create(): disallow recursive pruning
 - refs: make error messages more consistent
 - lock_ref_sha1_basic(): remove unneeded local variable
 - read_raw_ref(): move docstring to header file
 - read_raw_ref(): improve docstring
 - read_raw_ref(): rename symref argument to referent
 - read_raw_ref(): clear *type at start of function
 - read_raw_ref(): rename flags argument to type
 - ref_transaction_commit(): remove local variables n and updates
 - rename_ref(): remove unneeded local variable
 - commit_ref_update(): write error message to *err, not stderr
 - refname_is_safe(): insist that the refname already be normalized
 - refname_is_safe(): don't allow the empty string
 - refname_is_safe(): use skip_prefix()
 - remove_dir_recursively(): add docstring
 - safe_create_leading_directories(): improve docstring
 - read_raw_ref(): don't get confused by an empty directory
 - commit_ref(): if there is an empty dir in the way, delete it
 - t1404: demonstrate a bug resolving references
 (this branch is used by mh/ref-iterators, mh/ref-store and mh/update-ref-errors.)

 Further preparatory work on the refs API before the pluggable
 backend series can land.

 Will merge to 'next'.


* jc/send-email-skip-backup (2016-04-12) 1 commit
  (merged to 'next' on 2016-06-28 at 67dac59)
 + send-email: detect and offer to skip backup files

 A careless invocation of "git send-email directory/" after editing
 0001-change.patch with an editor often ends up sending both
 0001-change.patch and its backup file, 0001-change.patch~, causing
 embarrassment and a minor confusion.  Detect such an input and
 offer to skip the backup files when sending the patches out.

 Will merge to 'master'.
 Perhaps people will enhance it more once it gains more visibility.


* kn/ref-filter-branch-list (2016-05-17) 17 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add `:dir` and `:base` options for ref printing atoms
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce symref_atom_parser() and refname_atom_parser()
 - ref-filter: introduce refname_atom_parser_internal()
 - ref-filter: make "%(symref)" atom work with the ':short' modifier
 - ref-filter: add support for %(upstream:track,nobracket)
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: move get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: include reference to 'used_atom' within 'atom_value'
 - ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Rerolled.
 This also really needs review.


* dt/index-helper (2016-07-06) 21 commits
 - index-helper: indexhelper.exitAfter config
 - trace: measure where the time is spent in the index-heavy operations
 - index-helper: optionally automatically run
 - index-helper: autorun mode
 - index-helper: don't run if already running
 - index-helper: kill mode
 - watchman: add a config option to enable the extension
 - unpack-trees: preserve index extensions
 - update-index: enable/disable watchman support
 - index-helper: use watchman to avoid refreshing index with lstat()
 - watchman: support watchman to reduce index refresh cost
 - read-cache: add watchman 'WAMA' extension
 - index-helper: log warnings
 - index-helper: add --detach
 - daemonize(): set a flag before exiting the main process
 - index-helper: add --strict
 - index-helper: new daemon for caching index and related stuff
 - unix-socket.c: add stub implementation when unix sockets are not supported
 - pkt-line: add gentle version of packet_write
 - read-cache: allow to keep mmap'd memory after reading
 - read-cache.c: fix constness of verify_hdr()

 A new "index-helper" daemon has been introduced to give newly
 spawned Git process a quicker access to the data in the index, and
 optionally interface with the watchman daemon to further reduce the
 refresh cost.

 Is everybody happy with this version?
 At v14.


* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.

 While I think it would make it easier for people to experiment and
 build on if the topic is merged to 'next', I am at the same time a
 bit reluctant to merge an unproven new topic that introduces a new
 file format, which we may end up having to support til the end of
 time.  Comments?


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 ($gmane/282594)
