Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5F9C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 23:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbhLWXmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 18:42:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63364 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhLWXmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 18:42:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B200310AE86;
        Thu, 23 Dec 2021 18:42:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=9KEqe7W4dWBwdY47Mu0hcHM8b
        OPHjH4VppY9dINveqA=; b=AKXBGOONciT9sqwCuKue2e+QeT/1lc2T54eIEm6hj
        VRdf1xFEnDsyefOPQIY1Nf7jz8SlcV91B+6qkJipFNNLlW8AMW+X57uiAmucn6N8
        u664NGLBDI2PNiCIrV61OLYDypdz6V/VDNyQHMStaJJsYXFKmG82r/MSB5Gndh+D
        G0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A942310AE85;
        Thu, 23 Dec 2021 18:42:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2C9A10AE83;
        Thu, 23 Dec 2021 18:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2021, #05; Thu, 23)
X-master-at: 2ae0a9cb8298185a94e5998086f380a355dd8907
X-next-at: 21d7827218cb2304be633536bc9a50759e8f5c13
Date:   Thu, 23 Dec 2021 15:42:33 -0800
Message-ID: <xmqqsfui6g7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 010A120A-644A-11EC-9E94-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
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

A handful of topics have graduated to 'master' and also many topics
that I hadn't have a chance to move outside "Undecided" category
have been marked for 'next'.  We may have a chance to make a few
more updates to 'next' and possibly one more update to 'master' by
the end of the year.  Let's see what happens.

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
[Graduated to 'master']

* ab/common-main-cleanup (2021-12-07) 1 commit
  (merged to 'next' on 2021-12-15 at ff08c86f65)
 + common-main.c: call exit(), don't return

 Code clean-up.
 source: <patch-v2-1.1-4f52ecc94ba-20211207T101207Z-avarab@gmail.com>


* ab/fetch-set-upstream-while-detached (2021-12-07) 1 commit
  (merged to 'next' on 2021-12-15 at d0406f880a)
 + pull, fetch: fix segfault in --set-upstream option

 "git fetch --set-upstream" did not check if there is a current
 branch, leading to a segfault when it is run on a detached HEAD,
 which has been corrected.
 source: <patch-v5-1.1-69ab40d623b-20211207T215115Z-avarab@gmail.com>


* ak/protect-any-current-branch (2021-12-01) 8 commits
  (merged to 'next' on 2021-12-10 at dd2c6a557c)
 + branch: protect branches checked out in all worktrees
 + receive-pack: protect current branch for bare repository worktree
 + receive-pack: clean dead code from update_worktree()
 + fetch: protect branches checked out in all worktrees
 + worktree: simplify find_shared_symref() memory ownership model
 + branch: lowercase error messages
 + receive-pack: lowercase error messages
 + fetch: lowercase error messages

 "git fetch" without the "--update-head-ok" option ought to protect
 a checked out branch from getting updated, to prevent the working
 tree that checks it out to go out of sync.  The code was written
 before the use of "git worktree" got widespread, and only checked
 the branch that was checked out in the current worktree, which has
 been updated.
 source: <20211201221547.1796213-1-andersk@mit.edu>


* en/name-rev-shorter-output (2021-12-04) 1 commit
  (merged to 'next' on 2021-12-10 at ae8ec3912f)
 + name-rev: prefer shorter names over following merges

 "git name-rev" has been tweaked to give output that is shorter and
 easier to understand.
 source: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com>


* en/rebase-x-wo-git-dir-env (2021-12-04) 1 commit
  (merged to 'next' on 2021-12-07 at 44f2663314)
 + sequencer: do not export GIT_DIR and GIT_WORK_TREE for 'exec'

 "git rebase -x" by mistake started exporting the GIT_DIR and
 GIT_WORK_TREE environment variables when the command was rewritten
 in C, which has been corrected.
 source: <pull.1134.v3.git.git.1638596219656.gitgitgadget@gmail.com>


* es/chainlint (2021-12-13) 15 commits
  (merged to 'next' on 2021-12-15 at 49b7a37334)
 + chainlint.sed: stop splitting "(..." into separate lines "(" and "..."
 + chainlint.sed: swallow comments consistently
 + chainlint.sed: stop throwing away here-doc tags
 + chainlint.sed: don't mistake `<< word` in string as here-doc operator
 + chainlint.sed: make here-doc "<<-" operator recognition more POSIX-lik=
e
 + chainlint.sed: drop subshell-closing ">" annotation
 + chainlint.sed: drop unnecessary distinction between ?!AMP?! and ?!SEMI=
?!
 + chainlint.sed: tolerate harmless ";" at end of last line in block
 + chainlint.sed: improve ?!SEMI?! placement accuracy
 + chainlint.sed: improve ?!AMP?! placement accuracy
 + t/Makefile: optimize chainlint self-test
 + t/chainlint/one-liner: avoid overly intimate chainlint.sed knowledge
 + t/chainlint/*.test: generalize self-test commentary
 + t/chainlint/*.test: fix invalid test cases due to mixing quote types
 + t/chainlint/*.test: don't use invalid shell syntax

 The chainlint test script linter in the test suite has been updated.
 source: <20211213063059.19424-1-sunshine@sunshineco.com>


* fs/ssh-signing-key-lifetime (2021-12-09) 9 commits
  (merged to 'next' on 2021-12-10 at d5e7bd8b79)
 + ssh signing: verify ssh-keygen in test prereq
 + ssh signing: make fmt-merge-msg consider key lifetime
 + ssh signing: make verify-tag consider key lifetime
 + ssh signing: make git log verify key lifetime
 + ssh signing: make verify-commit consider key lifetime
 + ssh signing: add key lifetime test prereqs
 + ssh signing: use sigc struct to pass payload
 + t/fmt-merge-msg: make gpgssh tests more specific
 + t/fmt-merge-msg: do not redirect stderr

 Extend the signing of objects with SSH keys and learn to pay
 attention to the key validity time range when verifying.
 source: <20211209085249.13587-1-fs@gigacodes.de>


* fs/ssh-signing-other-keytypes (2021-11-19) 2 commits
  (merged to 'next' on 2021-12-10 at 2d0c8cb8e6)
 + ssh signing: make sign/amend test more resilient
 + ssh signing: support non ssh-* keytypes

 The cryptographic signing using ssh keys can specify literal keys
 for keytypes whose name do not begin with the "ssh-" prefix by
 using the "key::" prefix mechanism (e.g. "key::ecdsa-sha2-nistp256").
 source: <20211119150707.3924636-1-fs@gigacodes.de>


* jc/c99-var-decl-in-for-loop (2021-12-03) 1 commit
  (merged to 'next' on 2021-12-03 at 57100223b2)
 + revision: use C99 declaration of variable in for() loop

 Weather balloon to find compilers that do not grok variable
 declaration in the for() loop.
 source: <xmqqpmr2j5lq.fsf_-_@gitster.g>


* jc/grep-patterntype-default-doc (2021-12-05) 1 commit
  (merged to 'next' on 2021-12-10 at e46385ad9d)
 + grep: clarify what `grep.patternType=3Ddefault` means

 Doc update.
 source: <xmqqy24ykdel.fsf_-_@gitster.g>


* jk/limit-developers-to-gnu99 (2021-12-08) 2 commits
  (merged to 'next' on 2021-12-15 at 6b40e01445)
 + config.mak.dev: specify -std=3Dgnu99 for gcc/clang
 + Merge branch 'bc/require-c99' into jk/limit-developers-to-gnu99

 Enable -std=3Dgnu99 option in DEVELOPER builds.
 source: <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>


* jk/log-decorate-opts-with-implicit-decorate (2021-12-01) 2 commits
  (merged to 'next' on 2021-12-10 at 80585b2755)
 + log: load decorations with --simplify-by-decoration
 + log: handle --decorate-refs with userformat "%d"

 When "git log" implicitly enabled the "decoration" processing
 without being explicitly asked with "--decorate" option, it failed
 to read and honor the settings given by the "--decorate-refs"
 option.
 source: <YahbseXEC66dK0k8@coredump.intra.peff.net>


* js/scalar (2021-12-04) 15 commits
  (merged to 'next' on 2021-12-10 at 6248603a80)
 + scalar: implement the `version` command
 + scalar: implement the `delete` command
 + scalar: teach 'reconfigure' to optionally handle all registered enlist=
ments
 + scalar: allow reconfiguring an existing enlistment
 + scalar: implement the `run` command
 + scalar: teach 'clone' to support the --single-branch option
 + scalar: implement the `clone` subcommand
 + scalar: implement 'scalar list'
 + scalar: let 'unregister' handle a deleted enlistment directory gracefu=
lly
 + scalar: 'unregister' stops background maintenance
 + scalar: 'register' sets recommended config and starts maintenance
 + scalar: create test infrastructure
 + scalar: start documenting the command
 + scalar: create a rudimentary executable
 + scalar: add a README with a roadmap

 Add pieces from "scalar" to contrib/.
 source: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>


* jz/apply-quiet-and-allow-empty (2021-12-13) 2 commits
  (merged to 'next' on 2021-12-15 at e3f643eaa3)
 + git-apply: add --allow-empty flag
 + git-apply: add --quiet flag

 "git apply" has been taught to ignore a message without a patch
 with the "--allow-empty" option.  It also learned to honor the
 "--quiet" option given from the command line.
 source: <20211213220327.16042-2-jerry@skydio.com>


* ld/sparse-diff-blame (2021-12-06) 8 commits
  (merged to 'next' on 2021-12-10 at 57b89936d6)
 + blame: enable and test the sparse index
 + diff: enable and test the sparse index
 + diff: replace --staged with --cached in t1092 tests
 + repo-settings: prepare_repo_settings only in git repos
 + test-read-cache: set up repo after git directory
 + commit-graph: return if there is no git directory
 + git: ensure correct git directory setup with -h
 + Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
 (this branch is used by ds/fetch-pull-with-sparse-index.)

 Teach diff and blame to work well with sparse index.
 source: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>


* pw/xdiff-classify-record-in-histogram (2021-12-04) 6 commits
  (merged to 'next' on 2021-12-07 at 8cdad7bc9a)
 + xdiff: drop unused flags parameter from recs_match
 + xdiff: drop xpparam_t parameter from histogram cmp_recs()
 + xdiff: drop CMP_ENV macro from xhistogram
  (merged to 'next' on 2021-12-02 at 5ccd12d09b)
 + xdiff: simplify comparison
 + xdiff: avoid unnecessary memory allocations
 + diff histogram: intern strings

 "diff --histogram" optimization.
 source: <Yammtm+pIkMu43zZ@coredump.intra.peff.net>
 source: <pull.1079.git.1637148025.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* ab/do-not-limit-stash-help-to-push (2021-12-16) 1 commit
 - stash: don't show "git stash push" usage on bad "git stash" usage

 "git stash" by default triggers its "push" action, but its
 implementation also made "git stash -h" to show short help only for
 "git stash push", which has been corrected.

 Will merge to 'next'.
 source: <patch-v3-1.1-6b33b104c84-20211216T125317Z-avarab@gmail.com>


* km/help-prompt-fix (2021-12-16) 1 commit
 - help: make auto-correction prompt more consistent

 Among some code paths that ask an yes/no question, only one place
 gave a prompt that looked different from the others, which has been
 updated to match what the others create.

 Will merge to 'next'.
 source: <xmqqy24k8c0j.fsf@gitster.g>


* lh/use-gnu-color-in-grep (2021-12-16) 1 commit
 - grep: align default colors with GNU grep ones

 The color palette used by "git grep" has been updated to match that
 of GNU grep.

 On hold.
 cf. <xmqqh7b88b3o.fsf@gitster.g>
 source: <20211216115622.85506-1-lenaic@lhuard.fr>


* ws/fast-export-with-revision-options (2021-12-21) 1 commit
 - fast-export: fix surprising behavior with --first-parent

 Use of certain "git rev-list" options with "git fast-export"
 created nonsense results (the worst two of which being "--reverse"
 and "--invert-grep --grep=3D<foo>").  The use of "--first-parent" is
 made to behave a bit more sensible than before.

 Will merge to 'next'.
 source: <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>


* jc/t4204-do-not-write-git-on-upstream-of-pipe (2021-12-16) 1 commit
 - t4204 is not sanitizer clean at all

 Test fixes.

 Will merge to 'next'.
 source: <xmqqtuf86t7z.fsf_-_@gitster.g>


* jc/unleak-log (2021-12-16) 1 commit
  (merged to 'next' on 2021-12-21 at c39506ec86)
 + format-patch: mark rev_info with UNLEAK

 "git format-patch" uses a single rev_info instance and then exits.
 Mark the structure with UNLEAK() macro to squelch leak sanitizer.

 Will merge to 'master'.
 source: <xmqqee6dz5s9.fsf@gitster.g>


* ds/repack-fixlets (2021-12-20) 2 commits
 - repack: make '--quiet' disable progress
 - repack: respect kept objects with '--write-midx -b'

 Two fixes around "git repack".

 Will merge to 'next'.
 source: <pull.1098.v2.git.1640011691.gitgitgadget@gmail.com>


* gh/gpg-doc-markup-fix (2021-12-17) 1 commit
 - docs: add missing colon to Documentation/config/gpg.txt

 Doc markup fix.

 Will merge to 'next'.
 source: <20211217161718.15767-1-greg@hurrell.net>


* jc/merge-detached-head-name (2021-12-20) 1 commit
 - merge: allow to pretend a merge is made into a different branch

 The default merge message prepared by "git merge" records the name
 of the current branch; the name can be overridden with a new option
 to allow users to pretend a merge is made on a different branch.

 Will merge to 'next'.
 source: <xmqqee66ubuw.fsf_-_@gitster.g>


* jh/p4-human-unit-numbers (2021-12-20) 2 commits
 - git-p4: show progress as an integer
 - git-p4: print size values in appropriate units

 The way "git p4" shows file sizes in its output has been updated to
 use human-readable units.

 Will merge to 'next'.
 source: <20211219154028.3288756-1-jholdsworth@nvidia.com>


* jz/apply-3-corner-cases (2021-12-20) 1 commit
 - git-apply: skip threeway in add / rename cases

 "git apply --3way" bypasses the attempt to do a three-way
 application in more cases to address the regression caused by the
 recent change to use direct application as a fallback.

 Will merge to 'next'?
 source: <20211217224328.7646-1-jerry@skydio.com>


* pw/add-p-hunk-split-fix (2021-12-20) 2 commits
 - builtin add -p: fix hunk splitting
 - t3701: clean up hunk splitting tests

 "git add -p" rewritten in C regressed hunk splitting in some cases,
 which has been corrected.

 Expecting a reroll.
 source: <pull.1100.git.1640010777.gitgitgadget@gmail.com>


* rs/daemon-plug-leak (2021-12-20) 1 commit
 - daemon: plug memory leak on overlong path

 Plug a memory leak.

 Will merge to 'next'.
 source: <5b151dc3-d4c7-29d3-71ed-a79033693d5d@web.de>


* rs/log-invert-grep-with-headers (2021-12-17) 1 commit
 - log: let --invert-grep only invert --grep

 "git log --invert-grep --author=3D<name>" used to exclude commits
 written by the given author, but now "--invert-grep" only affects
 the matches made by the "--grep=3D<pattern>" option.

 Will merge to 'next'.
 source: <xmqqee6cbalb.fsf@gitster.g>


* rs/pcre2-utf (2021-12-20) 2 commits
 - grep/pcre2: factor out literal variable
 - grep/pcre2: use PCRE2_UTF even with ASCII patterns

 "git grep --perl-regexp" failed to match UTF-8 characters with
 wildcard when the pattern consists only of ASCII letters, which has
 been corrected.

 Will merge to 'next'.
 source: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>


* rs/t4202-invert-grep-test-fix (2021-12-17) 1 commit
 - t4202: fix patternType setting in --invert-grep test

 Test fix.

 Will merge to 'next'.
 source: <79dcebc0-e569-cc8a-4702-c572b062ed6d@web.de>


* ds/sparse-checkout-requires-per-worktree-config (2021-12-21) 5 commits
 - sparse-checkout: use repo_config_set_worktree_gently()
 - config: add repo_config_set_worktree_gently()
 - worktree: add upgrade_to_worktree_config()
 - config: make some helpers repo-aware
 - setup: use a repository when upgrading format

 "git sparse-checkout" wants to work with per-worktree configration,
 but did not work well in a worktree attached to a bare repository.

 Expecting a redesign?
 cf. <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 source: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>


* en/remerge-diff (2021-12-21) 10 commits
 - doc/diff-options: explain the new --remerge-diff option
 - show, log: provide a --remerge-diff capability
 - merge-ort: format messages slightly different for use in headers
 - diff: add ability to insert additional headers for paths
 - merge-ort: make path_messages available to external callers
 - merge-ort: mark a few more conflict messages as omittable
 - merge-ort: capture and print ll-merge warnings in our preferred fashio=
n
 - ll-merge: make callers responsible for showing warnings
 - tmp_objdir: add a helper function for discarding all contained objects
 - Merge branch 'ns/tmp-objdir' into en/remerge-diff
 (this branch uses ns/tmp-objdir.)

 "git log --remerge-diff" shows the difference from mechanical merge
 result and the merge result that is actually recorded.

 Expecting a reroll.
 cf. <xmqqa6gto74z.fsf@gitster.g>
 source: <pull.1103.git.1640109948.gitgitgadget@gmail.com>


* gc/fetch-negotiate-only-early-return (2021-12-21) 3 commits
 - builtin/fetch: die on --negotiate-only and --recurse-submodules
 - builtin/fetch: skip unnecessary tasks when using --negotiate-only
 - builtin/fetch: use goto cleanup in cmd_fetch()

 Expecting a reroll.
 cf. <kl6l4k70z8po.fsf@chooglen-macbookpro.roam.corp.google.com>
 source: <20211222001134.28933-1-chooglen@google.com>


* hn/refs-debug-update (2021-12-22) 3 commits
 - refs: centralize initialization of the base ref_store.
 - refs: print error message in debug output
 - refs: pass gitdir to packed_ref_store_create

 Debugging support for refs API.

 Will merge to 'next'.
 source: <pull.1163.v2.git.git.1640196714.gitgitgadget@gmail.com>


* hn/test-ref-store-show-hash-algo (2021-12-21) 1 commit
 - test-ref-store: print hash algorithm

 Debugging support for refs API.

 Will merge to 'next'.
 source: <pull.1167.git.git.1640092500725.gitgitgadget@gmail.com>


* ja/perf-use-specified-shell (2021-12-21) 1 commit
 - t/perf: do not run tests in user's $SHELL

 Perf tests were run with end-user's shell, but it has been
 corrected to use the shell specified by $TEST_SHELL_PATH.

 Will merge to 'next'.
 source: <f22f978a-26eb-8fe9-cab4-3fd60df69635@web.de>


* js/l10n-mention-ngettext-early-in-readme (2021-12-21) 1 commit
 - l10n: README: call more attention to plural strings

 Localization doc update.

 Will merge to 'next'.
 source: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmo=
n@google.com>


* ab/reflog-prep (2021-12-22) 9 commits
 - reflog + refs-backend: move "verbose" out of the backend
 - refs files-backend: assume cb->newlog if !EXPIRE_REFLOGS_DRY_RUN
 - reflog: reduce scope of "struct rev_info"
 - reflog expire: don't use lookup_commit_reference_gently()
 - reflog expire: refactor & use "tip_commit" only for UE_NORMAL
 - reflog expire: use "switch" over enum values
 - reflog: change one->many worktree->refnames to use a string_list
 - reflog expire: narrow scope of "cb" in cmd_reflog_expire()
 - reflog delete: narrow scope of "cmd" passed to count_reflog_ent()

 Code refactoring in the reflog part of refs API.

 Will merge to 'next'.
 source: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>


* bs/forbid-i18n-of-protocol-token-in-fetch-pack (2021-12-22) 2 commits
 - fixup! fetch-pack: parameterize message containing 'ready' keyword
 - fetch-pack: parameterize message containing 'ready' keyword

 L10n support for a few error messages.

 Expecting an ack for fixup.
 source: <20211222075805.19027-1-bagasdotme@gmail.com>


* hn/ref-api-tests-update (2021-12-22) 4 commits
 - t7004: use "test-tool ref-store" for reflog inspection
 - t7004: create separate tags for different tests
 - t5550: require REFFILES
 - t5540: require REFFILES

 Test updates.

 Will merge to 'next'.
 source: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>


* jh/p4-remove-unused (2021-12-22) 2 commits
 - git-p4: remove "rollback" verb
 - git-p4: remove "debug" verb

 Remove a few commands from "git p4" that aren't very useful.

 Will merge to 'next'.
 source: <20211222145552.93786-1-jholdsworth@nvidia.com>


* hn/reftable-fixes (2021-12-23) 3 commits
 - reftable: support preset file mode for writing
 - reftable: signal overflow
 - reftable: fix typo in header

 Assorted fixlets in reftable code.

 Will merge to 'next'.
 source: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>

--------------------------------------------------
[Stalled]

* je/http-better-error-output (2021-12-03) 1 commit
 . http-backend: give a hint that web browser access is not supported

 When the http-backend program, which is the server-side component
 for the smart HTTP transport, sends a "404 Not found" error, we
 deliberately did not say anything to the requesting client.  We now
 send a message back to the browser to tell the user that they do
 not want to visit the URL via their browser, instead of a totally
 blank page.

 Expecting a reroll.
 Breaks its self tests.
 cf. <7r23s082-o3q0-479o-srqn-r45q778s5nq7@vanv.qr>
 source: <20211202102855.23907-1-jengelh@inai.de>


* cb/save-term-across-editor-invocation (2021-12-01) 3 commits
 - fixup! editor: allow for saving/restoring terminal state
 - editor: allow for saving/restoring terminal state
 - terminal: teach save_term to fail when not foreground

 Some editors are reported to leave the terminal in funny state
 after they exit on Windows.  Work it around by saving and restoring
 the terminal state when needed.

 Expecting a reroll.
 cf. <CAPUEsphktbdxeV7hvF52Or3CVHS8oOk5-WV=3DxfEZa8kfCVVnVg@mail.gmail.co=
m>
 source: <20211202035446.1154-1-carenas@gmail.com>


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

 Expecting a reroll?
 cf. <YWiXL+plA7GHfuVv@google.com>
 source: <20211013051805.45662-10-raykar.ath@gmail.com>

--------------------------------------------------
[Cooking]

* jh/p4-rcs-expansion-in-bytestring (2021-12-16) 5 commits
 - git-p4: resolve RCS keywords in bytes not utf-8
 - git-p4: open temporary patch file for write only
 - git-p4: add raw option to read_pipelines
 - git-p4: pre-compile RCS keyword regexes
 - git-p4: use with statements to close files after use in patchRCSKeywor=
ds

 The RCS keyword substitution in "git p4" used to be done assuming
 that the contents are UTF-8 text, which can trigger decoding
 errors.  We now treat the contents as a bytestring for robustness
 and correctness.

 Will merge to 'next'.
 source: <20211216134619.2048348-1-jholdsworth@nvidia.com>


* ds/sparse-checkout-malformed-pattern-fix (2021-12-16) 3 commits
 - sparse-checkout: refuse to add to bad patterns
 - sparse-checkout: fix OOM error with mixed patterns
 - sparse-checkout: fix segfault on malformed patterns

 Certain sparse-checkout patterns that are valid in non-cone mode
 led to segfault in cone mode, which has been corrected.

 Will merge to 'next'.
 source: <pull.1069.v4.git.1639671222.gitgitgadget@gmail.com>


* gc/branch-recurse-submodules (2021-12-20) 6 commits
 - branch: add --recurse-submodules option for branch creation
 - builtin/branch: clean up action-picking logic in cmd_branch()
 - branch: add a dry_run parameter to create_branch()
 - branch: make create_branch() always create a branch
 - branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
 - Merge branch 'js/branch-track-inherit' into gc/branch-recurse-submodul=
es
 (this branch uses js/branch-track-inherit.)

 "git branch" learned the "--recurse-submodules" option.

 Will merge to 'next'?
 source: <20211220233459.45739-1-chooglen@google.com>


* jk/ssh-signing-doc-markup-fix (2021-12-15) 1 commit
 - doc/config: mark ssh allowedSigners example as literal

 Docfix.

 Will merge to 'next'.
 source: <YboWlOG3vZD/7Osx@coredump.intra.peff.net>


* jv/use-larger-buffer-in-upload-pack (2021-12-15) 1 commit
 - upload-pack.c: increase output buffer size

 "git upload-pack" (the other side of "git fetch") used a 8kB buffer
 but most of its payload came on 64kB "packets".  The buffer size
 has been enlarged so that such a packet fits.

 Will merge to 'next'.
 source: <20211214194626.33814-1-jacob@gitlab.com>


* en/sparse-checkout-set (2021-12-23) 11 commits
 - sparse-checkout: remove stray trailing space
  (merged to 'next' on 2021-12-21 at 36a98aed11)
 + clone: avoid using deprecated `sparse-checkout init`
 + Documentation: clarify/correct a few sparsity related statements
 + git-sparse-checkout.txt: update to document init/set/reapply changes
 + sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
 + sparse-checkout: enable `set` to initialize sparse-checkout mode
 + sparse-checkout: split out code for tweaking settings config
 + sparse-checkout: disallow --no-stdin as an argument to set
 + sparse-checkout: add sanity-checks on initial sparsity state
 + sparse-checkout: break apart functions for sparse_checkout_(set|add)
 + sparse-checkout: pass use_stdin as a parameter instead of as a global

 The "init" and "set" subcommands in "git sparse-checkout" have been
 unified for a better user experience and performance.

 Will merge to 'next' and then to 'master'.
 source: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>


* hn/reftable-coverity-fixes (2021-12-22) 18 commits
 - reftable: be more paranoid about 0-length memcpy calls
 - reftable: add print functions to the record types
 - reftable: make reftable_record a tagged union
 - reftable: remove outdated file reftable.c
 - reftable: implement record equality generically
 - reftable: make reftable-record.h function signatures const correct
 - reftable: handle null refnames in reftable_ref_record_equal
 - reftable: drop stray printf in readwrite_test
 - reftable: order unittests by complexity
 - reftable: all xxx_free() functions accept NULL arguments
 - reftable: fix resource warning
 - reftable: ignore remove() return value in stack_test.c
 - reftable: check reftable_stack_auto_compact() return value
 - reftable: fix resource leak blocksource.c
 - reftable: fix resource leak in block.c error path
 - reftable: fix OOB stack write in print functions
 - Merge branch 'hn/create-reflog-simplify' into hn/reftable-coverity-fix=
es
 - Merge branch 'hn/reftable' into hn/reftable-coverity-fixes

 Problems identified by Coverity in the reftable code have been
 corrected.

 Will merge to 'next'?
 source: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>


* tb/midx-bitmap-corruption-fix (2021-12-23) 9 commits
 - midx: read `RIDX` chunk when present
 - t/lib-bitmap.sh: parameterize tests over reverse index source
 - t5326: move tests to t/lib-bitmap.sh
 - t5326: extract `test_rev_exists`
 - t5326: drop unnecessary setup
 - pack-revindex.c: instrument loading on-disk reverse index
 - midx.c: make changing the preferred pack safe
 - t5326: demonstrate bitmap corruption after permutation
 - Merge branch 'tb/cruft-packs' into tb/midx-bitmap-corruption-fix
 (this branch uses tb/cruft-packs.)

 A bug that made multi-pack bitmap and the object order out-of-sync
 (hence the .midx data gets corrupted) has been fixed.

 What's the status of this thing?
 source: <cover.1639446906.git.me@ttaylorr.com>


* es/test-chain-lint (2021-12-13) 19 commits
  (merged to 'next' on 2021-12-21 at d6f56f3248)
 + t6000-t9999: detect and signal failure within loop
 + t5000-t5999: detect and signal failure within loop
 + t4000-t4999: detect and signal failure within loop
 + t0000-t3999: detect and signal failure within loop
 + tests: simplify by dropping unnecessary `for` loops
 + tests: apply modern idiom for exiting loop upon failure
 + tests: apply modern idiom for signaling test failure
 + tests: fix broken &&-chains in `{...}` groups
 + tests: fix broken &&-chains in `$(...)` command substitutions
 + tests: fix broken &&-chains in compound statements
 + tests: use test_write_lines() to generate line-oriented output
 + tests: simplify construction of large blocks of text
 + t9107: use shell parameter expansion to avoid breaking &&-chain
 + t6300: make `%(raw:size) --shell` test more robust
 + t5516: drop unnecessary subshell and command invocation
 + t4202: clarify intent by creating expected content less cleverly
 + t1020: avoid aborting entire test script when one test fails
 + t1010: fix unnoticed failure on Windows
 + t/lib-pager: use sane_unset() to avoid breaking &&-chain

 Broken &&-chains in the test scripts have been corrected.

 Will merge to 'master'.
 source: <20211209051115.52629-1-sunshine@sunshineco.com>


* jc/flex-array-definition (2021-12-08) 1 commit
 - flex-array: simplify compiler-specific workaround

 The conditions to choose different definitions of the FLEX_ARRAY
 macro for vendor compilers has been simplified to make it easier to
 maintain.

 Will merge to 'next'.
 source: <xmqqee6mv9no.fsf@gitster.g>


* pw/fix-some-issues-in-reset-head (2021-12-08) 14 commits
 - rebase -m: don't fork git checkout
 - rebase --apply: set ORIG_HEAD correctly
 - rebase --apply: fix reflog
 - reset_head(): take struct rebase_head_opts
 - rebase: cleanup reset_head() calls
 - reset_head(): make default_reflog_action optional
 - reset_head(): factor out ref updates
 - create_autostash(): remove unneeded parameter
 - reset_head(): remove action parameter
 - rebase --apply: don't run post-checkout hook if there is an error
 - rebase: do not remove untracked files on checkout
 - rebase: pass correct arguments to post-checkout hook
 - t5403: refactor rebase post-checkout hook tests
 - rebase: factor out checkout for up to date branch

 Fix "some issues" in a helper function reset_head().

 Expecting a reroll.
 cf. <xmqqk0gdskkh.fsf@gitster.g>
 cf. <xmqqwnkdr3xb.fsf@gitster.g>
 cf. <xmqqpmq5r3j9.fsf@gitster.g>
 cf. <xmqqczm5r34h.fsf@gitster.g>
 cf. <CABPp-BEHW4VLG18twcM_8iOco1jZ2iuGT+KN8aS+-sAAnBhTnw@mail.gmail.com>
 source: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>


* ja/i18n-similar-messages (2021-12-05) 10 commits
 - i18n: ref-filter: factorize "%(foo) atom used without %(bar) atom"
 - i18n: factorize "--foo outside a repository"
 - i18n: refactor "unrecognized %(foo) argument" strings
 - i18n: factorize "no directory given for --foo"
 - i18n: factorize "--foo requires --bar" and the like
 - i18n: tag.c factorize i18n strings
 - i18n: standardize "cannot open" and "cannot read"
 - i18n: turn "options are incompatible" into "are mutually exclusive"
 - i18n: refactor "%s, %s and %s are mutually exclusive"
 - i18n: refactor "foo and bar are mutually exclusive"

 Similar message templates have been consolidated so that
 translators need to work on fewer number of messages.

 Expecting a reroll.
 cf. <2447705.sFPtriHfYS@cayenne>
 source: <pull.1088.git.1638514909.gitgitgadget@gmail.com>


* ab/usage-die-message (2021-12-07) 6 commits
 - config API: use get_error_routine(), not vreportf()
 - usage.c + gc: add and use a die_message_errno()
 - gc: return from cmd_gc(), don't call exit()
 - usage.c API users: use die_message() for error() + exit 128
 - usage.c API users: use die_message() for "fatal :" + exit 128
 - usage.c: add a die_message() routine

 Code clean-up to hide vreportf() from public API.

 Will merge to 'next'?
 source: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>


* ab/cat-file (2021-12-22) 10 commits
 - cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
 - object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
 - cat-file: correct and improve usage information
 - cat-file: fix remaining usage bugs
 - cat-file: make --batch-all-objects a CMDMODE
 - cat-file: move "usage" variable to cmd_cat_file()
 - cat-file docs: fix SYNOPSIS and "-h" output
 - parse-options API: add a usage_msg_optf()
 - cat-file tests: test messaging on bad objects/paths
 - cat-file tests: test bad usage

 Assorted updates to "git cat-file", especially "-h".

 Will merge to 'next'?
 source: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>


* ab/grep-patterntype (2021-12-22) 7 commits
 - grep: simplify config parsing and option parsing
 - grep API: call grep_config() after grep_init()
 - grep.c: don't pass along NULL callback value
 - built-ins: trust the "prefix" from run_builtin()
 - grep tests: add missing "grep.patternType" config test
 - log tests: check if grep_config() is called by "log"-like cmds
 - grep.h: remove unused "regex_t regexp" from grep_opt

 Some code clean-up in the "git grep" machinery.

 Needs review.
 source: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>


* js/use-builtin-add-i (2021-12-01) 2 commits
 - add -i: default to the built-in implementation
 - t2016: require the PERL prereq only when necessary

 "git add -i" was rewritten in C some time ago and has been in
 testing; the reimplementation is now exposed to general public by
 default.

 On hold.
 There are known breakages on macOS.
 cf. <nycvar.QRO.7.76.6.2112021832060.63@tvgsbejvaqbjf.bet>
 source: <pull.1087.git.1638281655.gitgitgadget@gmail.com>


* jt/conditional-config-on-remote-url (2021-12-15) 2 commits
 - config: include file if remote URL matches a glob
 - config: make git_config_include() static

 The conditional inclusion mechanism of configuration files using
 "[includeIf <condition>]" learns to base its decision on the
 URL of the remote repository the repository interacts with.

 How does this one look these days?
 source: <cover.1639509048.git.jonathantanmy@google.com>


* tb/cruft-packs (2021-11-29) 17 commits
 - sha1-file.c: don't freshen cruft packs
 - builtin/gc.c: conditionally avoid pruning objects via loose
 - builtin/repack.c: add cruft packs to MIDX during geometric repack
 - builtin/repack.c: use named flags for existing_packs
 - builtin/repack.c: allow configuring cruft pack generation
 - builtin/repack.c: support generating a cruft pack
 - builtin/pack-objects.c: --cruft with expiration
 - reachable: report precise timestamps from objects in cruft packs
 - reachable: add options to add_unseen_recent_objects_to_traversal
 - builtin/pack-objects.c: --cruft without expiration
 - builtin/pack-objects.c: return from create_object_entry()
 - t/helper: add 'pack-mtimes' test-tool
 - pack-mtimes: support writing pack .mtimes files
 - chunk-format.h: extract oid_version()
 - pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
 - pack-mtimes: support reading .mtimes files
 - Documentation/technical: add cruft-packs.txt
 (this branch is used by tb/midx-bitmap-corruption-fix.)

 Instead of leaving unreachable objects in loose form when packing,
 or ejecting them into loose form when repacking, gather them in a
 packfile with an auxiliary file that records the last-use time of
 these objects.

 Expecting a reroll.
 cf. <865b99dd-0b18-9a07-49c1-3959a777c685@gmail.com>
 cf. <c9437c89-9258-4034-9886-8a2aec46aa6b@gmail.com>
 cf. <YaqiYGM48p5F9lS1@nand.local>
 source: <cover.1638224692.git.me@ttaylorr.com>


* jl/subtree-check-parents-argument-passing-fix (2021-12-05) 1 commit
 - subtree: fix argument handling in check_parents

 Fix performance-releated bug in "git subtree" (in contrib/).

 Expecting a reroll.
 cf. <nycvar.QRO.7.76.6.2112072243310.90@tvgsbejvaqbjf.bet>
 source: <pull.1086.v3.git.1638758742741.gitgitgadget@gmail.com>


* ab/ambiguous-object-name (2021-11-26) 6 commits
 - object-name: re-use "struct strbuf" in show_ambiguous_object()
 - object-name: iterate ambiguous objects before showing header
 - object-name: show date for ambiguous tag objects
 - object-name: make ambiguous object output translatable
 - object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
 - object-name tests: add tests for ambiguous object blind spots

 Error output given in response to an ambiguous object name has been
 improved.

 An earlier iteration that was much smaller had seen some reviews,
 but the latest round enlarged its scope and needs to be reviewed
 afresh.
 source: <patch-v5-6.6-78bb0995f08-20211125T215529Z-avarab@gmail.com>


* en/keep-cwd (2021-12-09) 11 commits
 - t2501: simplify the tests since we can now assume desired behavior
 - dir: new flag to remove_dir_recurse() to spare the original_cwd
 - dir: avoid incidentally removing the original_cwd in remove_path()
 - stash: do not attempt to remove startup_info->original_cwd
 - rebase: do not attempt to remove startup_info->original_cwd
 - clean: do not attempt to remove startup_info->original_cwd
 - symlinks: do not include startup_info->original_cwd in dir removal
 - unpack-trees: add special cwd handling
 - unpack-trees: refuse to remove startup_info->original_cwd
 - setup: introduce startup_info->original_cwd
 - t2501: add various tests for removing the current working directory

 Many git commands that deal with working tree files try to remove a
 directory that becomes empty (i.e. "git switch" from a branch that
 has the directory to another branch that does not would attempt
 remove all files in the directory and the directory itself).  This
 drops users into an unfamiliar situation if the command was run in
 a subdirectory that becomes subject to removal due to the command.
 The commands have been taught to keep an empty directory if it is
 the directory they were started in to avoid surprising users.

 Will merge to 'next'.
 source: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>


* tl/ls-tree-oid-only (2021-12-21) 1 commit
 - ls-tree.c: support `--object-only` option for "git-ls-tree"

 "git ls-tree" learns "--oid-only" option, similar to "--name-only".

 Will merge to 'next'?
 source: <cover.1639721750.git.dyroneteng@gmail.com>


* ds/fetch-pull-with-sparse-index (2021-12-22) 5 commits
 - test-read-cache: remove --table, --expand options
 - t1091/t3705: remove 'test-tool read-cache --table'
 - t1092: replace 'read-cache --table' with 'ls-files --sparse'
 - ls-files: add --sparse option
 - fetch/pull: use the sparse index

 "git fetch" and "git pull" are now declared sparse-index clean.
 Also "git ls-files" learns the "--sparse" option to help debugging.

 Will merge to 'next'.
 source: <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>


* xw/am-empty (2021-12-15) 3 commits
 - am: support --allow-empty to record specific empty patches
 - am: support --empty=3D<option> to handle empty patches
 - doc: git-format-patch: describe the option --always

 "git am" learns "--empty=3D(stop|drop|keep)" option to tweak what is
 done to a piece of e-mail without a patch in it.

 Will merge to 'next'.
 source: <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>


* pw/diff-color-moved-fix (2021-12-09) 15 commits
 - diff --color-moved: intern strings
 - diff: use designated initializers for emitted_diff_symbol
 - diff --color-moved-ws=3Dallow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=3Dallow-indentation-change: simplify and optimiz=
e
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zebra color=
ing
 - diff --color-moved=3Dzebra: fix alternate coloring
 - diff --color-moved: rewind when discarding pmb
 - diff --color-moved: factor out function
 - diff --color-moved: clear all flags on blocks that are too short
 - diff --color-moved: add perf tests

 Correctness and performance update to "diff --color-moved" feature.

 Will merge to 'next'.
 source: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>


* jc/doc-submitting-patches-choice-of-base (2021-12-23) 1 commit
 - SubmittingPatchs: clarify choice of base and testing

 Extend the guidance to choose the base commit to build your work
 on, and hint/nudge contributors to read others' changes.

 Needs review.
 source: <xmqq5yre7w5o.fsf@gitster.g>


* ab/config-based-hooks-2 (2021-12-22) 17 commits
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

 More "config-based hooks".

 Needs review.
 At this point, as =C3=86var and Emily both read the major part of this
 series, a final and quick read-over plus an Ack by Emily on her
 part plus a serious review on the patches attributed to =C3=86var by
 somebody other than =C3=86var would be sufficient to move it in some
 direction (hopefully forward).
 source: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>


* js/branch-track-inherit (2021-12-20) 3 commits
 - config: require lowercase for branch.*.autosetupmerge
 - branch: add flags and config to inherit tracking
 - branch: accept multiple upstream branches for tracking
 (this branch is used by gc/branch-recurse-submodules.)

 "git -c branch.autosetupmerge=3Dinherit branch new old" makes "new"
 to have the same upstream as the "old" branch, instead of marking
 "old" itself as its upstream.

 Will merge to 'next'?
 source: <cover.1640039978.git.steadmon@google.com>


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
 - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daem=
on
 - help: include fsmonitor--daemon feature flag in version info
 - fsmonitor--daemon: implement handle_client callback
 - compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacO=
S
 - compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
 - compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Wind=
ows
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

 Expecting a reroll.
 Seems that the discussion stalled.
 cf. <d9c3ef61-768c-3560-2858-3438c355a742@jeffhostetler.com>
 source: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>


* ns/tmp-objdir (2021-12-08) 2 commits
  (merged to 'next' on 2021-12-21 at d316ff36fc)
 + tmp-objdir: disable ref updates when replacing the primary odb
 + tmp-objdir: new API for creating temporary writable databases
 (this branch is used by en/remerge-diff.)

 New interface into the tmp-objdir API to help in-core use of the
 quarantine feature.

 Will merge to 'master'.
 source: <pull.1091.v3.git.1638828305.gitgitgadget@gmail.com>


* es/superproject-aware-submodules (2021-11-18) 5 commits
 - submodule: use config to find superproject worktree
 - submodule: record superproject gitdir during 'update'
 - submodule: record superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir record
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Expecting a reroll.
 cf. <20211117234300.2598132-1-jonathantanmy@google.com>
 source: <20211117005701.371808-1-emilyshaffer@google.com>


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

 Needs review.
 The last three rounds has seen little reaction, even though earlier
 round saw a lot of responses. The latest round needs a serious
 review or at least Acks from past commentors.
 source: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>

--------------------------------------------------
[Discarded]

* ms/customizable-ident-expansion (2021-09-01) 1 commit
 - keyword expansion: make "$Id$" string configurable

 Instead of "$Id$", user-specified string (like $FreeBSD$) can be
 used as an in-blob placeholder for keyword expansion.

 Will discard.
 Stalled for too long.
 cf. <xmqqfsuosvrh.fsf@gitster.g>
 cf. <211101.86fssf3bn3.gmgdl@evledraar.gmail.com>
 source: <pull.1074.v3.git.git.1630462385587.gitgitgadget@gmail.com>
