Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BF8C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE0121D7E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q8ysfOG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIIWcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:32:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56218 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIWcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 18:32:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 089076DC49;
        Wed,  9 Sep 2020 18:32:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=MiG7H3TWepFq7qKgDNgN4ctQ0
        iQ=; b=q8ysfOG8nkpeP6iM9DKJ4kBJ/DvgV93sZjPC2R+KGhSti2KMNqRpAgab4
        mrh94uZ4ebltFZ87MfSSJbIsNgqf0efNlIEuLYOqJOVRGc+mkNDpzgVVQOeDqKHM
        OZ6yxCDeHcclM70hWJjPo417Oavfw+85mL1usF8hQ5yMpnB/Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=cTbUFrwLW53RifrSZVI
        hP/2rwSreBmHljAHrLl8sIph1ID6tYWqol0PM/5H00rxD585CZ7XxyepbiKmzXUb
        aGhTiZH6VRyMCjfJx6EU2DqV0Up/7PWtE83dy9JX6s8hs+31KtuenGU5kkLwvMdB
        mLLbWlvUjBWdkhE0IGvp4a4o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3EF16DC48;
        Wed,  9 Sep 2020 18:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69CEA6DC45;
        Wed,  9 Sep 2020 18:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2020, #03; Wed, 9)
X-master-at: 54e85e7af1ac9e9a92888060d6811ae767fea1bc
X-next-at: a41e38b8ca5c1f61d7a6b4dd5e741fcd76907bf1
Date:   Wed, 09 Sep 2020 15:32:38 -0700
Message-ID: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5E2E393C-F2EC-11EA-B35B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' ar=
e
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches of th=
e
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* es/worktree-repair (2020-08-31) 5 commits
  (merged to 'next' on 2020-08-31 at 604825c5e4)
 + init: make --separate-git-dir work from within linked worktree
 + init: teach --separate-git-dir to repair linked worktrees
 + worktree: teach "repair" to fix outgoing links to worktrees
 + worktree: teach "repair" to fix worktree back-links to main worktree
 + worktree: add skeleton "repair" command

 "git worktree" gained a "repair" subcommand to help users recover
 after moving the worktrees or repository manually without telling
 Git.  Also, "git init --separate-git-dir" no longer corrupts
 administrative data related to linked worktrees.


* hv/ref-filter-misc (2020-08-28) 8 commits
  (merged to 'next' on 2020-09-02 at 9a8bb84f20)
 + ref-filter: add `sanitize` option for 'subject' atom
 + pretty: refactor `format_sanitized_subject()`
 + ref-filter: add `short` modifier to 'parent' atom
 + ref-filter: add `short` modifier to 'tree' atom
 + ref-filter: rename `objectname` related functions and fields
 + ref-filter: modify error messages in `grab_objectname()`
 + ref-filter: refactor `grab_objectname()`
 + ref-filter: support different email formats

 The "--format=3D" option to the "for-each-ref" command and friends
 learned a few more tricks, e.g. the ":short" suffix that applies to
 "objectname" now also can be used for "parent", "tree", etc.


* jk/worktree-check-clean-leakfix (2020-08-27) 1 commit
  (merged to 'next' on 2020-08-31 at 220fc43629)
 + worktree: fix leak in check_clean_worktree()

 Leakfix.


* js/ci-squelch-false-failure (2020-09-02) 2 commits
  (merged to 'next' on 2020-09-03 at 254f390305)
 + ci: avoid ugly "failure" in the `ci-config` job
 + ci: fix indentation of the `ci-config` job

 CI noise reduction.


* jt/interpret-branch-name-fallback (2020-09-02) 3 commits
  (merged to 'next' on 2020-09-03 at 28914ab788)
 + wt-status: tolerate dangling marks
 + refs: move dwim_ref() to header file
 + sha1-name: replace unsigned int with option struct

 "git status" has trouble showing where it came from by interpreting
 reflog entries that recordcertain events, e.g. "checkout @{u}", and
 gives a hard/fatal error.  Even though it inherently is impossible
 to give a correct answer because the reflog entries lose some
 information (e.g. "@{u}" does not record what branch the user was
 on hence which branch 'the upstream' needs to be computed, and even
 if the record were available, the relationship between branches may
 have changed), at least hide the error to allow "status" show its
 output.


* os/vcbuild (2020-09-08) 3 commits
  (merged to 'next' on 2020-09-08 at 56551401c2)
 + contrib/buildsystems: fix expat library name for generated vcxproj
  (merged to 'next' on 2020-09-03 at 0216ec9cb9)
 + vcbuild: fix batch file name in README
 + vcbuild: fix library name for expat with make MSVC=3D1

 Fix build procedure for MSVC.


* pb/imap-send-updates (2020-08-31) 3 commits
  (merged to 'next' on 2020-09-02 at 899fca3919)
 + git-imap-send.txt: add note about localized Gmail folders
 + git-imap-send.txt: do verify SSL certificate for gmail.com
 + git-imap-send.txt: don't duplicate 'Examples' sections

 "git imap-send" updates.


* so/separate-field-for-m-and-diff-merges (2020-08-31) 1 commit
  (merged to 'next' on 2020-08-31 at 8def2984ca)
 + revision: add separate field for "-m" of "diff-index -m"

 Internal API clean-up to handle two options "diff-index" and "log"
 have, which happen to share the same short form, more sensibly.


* ss/submodule-summary-in-c (2020-08-12) 4 commits
  (merged to 'next' on 2020-08-17 at 9bc352cb70)
 + submodule: port submodule subcommand 'summary' from shell to C
 + t7421: introduce a test script for verifying 'summary' output
 + submodule: rename helper functions to avoid ambiguity
 + submodule: remove extra line feeds between callback struct and macro
 (this branch is used by ss/submodule-summary-in-c-fixes.)

 Yet another subcommand of "git submodule" is getting rewritten in C.


* ss/submodule-summary-in-c-fixes (2020-08-27) 3 commits
  (merged to 'next' on 2020-09-02 at 7f959811b8)
 + t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
 + submodule: fix style in function definition
 + submodule: eliminate unused parameters from print_submodule_summary()
 (this branch uses ss/submodule-summary-in-c.)

 Fixups to a topic in 'next'.


* tb/repack-clearing-midx (2020-08-28) 2 commits
  (merged to 'next' on 2020-08-28 at 4204c0cb5e)
 + midx: traverse the local MIDX first
  (merged to 'next' on 2020-08-27 at a465875cbb)
 + builtin/repack.c: invalidate MIDX only when necessary

 When a packfile is removed by "git repack", multi-pack-index gets
 cleared; the code was taught to do so less aggressively by first
 checking if the midx actually refers to a pack that no longer
 exists.

--------------------------------------------------
[New Topics]

* al/t3200-back-on-a-branch (2020-09-08) 1 commit
  (merged to 'next' on 2020-09-09 at 833e2fc60c)
 + t3200: clean side effect of git checkout --orphan

 Test fix.

 Will merge to 'master'.


* bc/rev-parse-path-format (2020-09-08) 1 commit
 - rev-parse: add option for absolute or relative path formatting

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.


* ds/maintenance-part-3 (2020-09-06) 6 commits
 - maintenance: recommended schedule in register/start
 - maintenance: add start/stop subcommands
 - maintenance: add [un]register subcommands
 - for-each-repo: run subcommands on configured repos
 - maintenance: add --schedule option and config
 - maintenance: optionally skip --auto process
 (this branch uses ds/maintenance-part-1 and ds/maintenance-part-2.)

 Parts of "git maintenance" to ease writing crontab entries (and
 other scheduling system configuration) for it.


* ea/blame-use-oideq (2020-09-08) 1 commit
  (merged to 'next' on 2020-09-09 at babefe4727)
 + blame.c: replace instance of !oidcmp for oideq

 Code cleanup.

 Will merge to 'master'.


* es/format-patch-interdiff-cleanup (2020-09-08) 3 commits
 - format-patch: use 'origin' as start of current-series-range when known
 - diff-lib: tighten show_interdiff()'s interface
 - diff: move show_interdiff() from its own file to diff-lib

 Code cleanup with a slight behaviour change when "format-patch
 --range-diff=3D<prev> origin..HEAD" gives a single revision to
 <prev>.

 Will merge to 'next'.


* es/wt-add-detach (2020-09-06) 3 commits
 - git-worktree.txt: discuss branch-based vs. throwaway worktrees
 - worktree: teach `add` to recognize -d as shorthand for --detach
 - git-checkout.txt: document -d short option for --detach

 "git worktree add" learns the "--detach" option to create a new
 worktree without being on a branch.

 Will merge to 'next'.


* hn/refs-ref-log-only-bit (2020-09-08) 1 commit
  (merged to 'next' on 2020-09-09 at f729cb2c81)
 + refs: move REF_LOG_ONLY to refs-internal.h

 A bit of API reshuffling to make sure stuff common to all backends
 are not defined only in files backend.

 Will merge to 'master'.


* jc/add-i-use-builtin-experimental (2020-09-08) 1 commit
  (merged to 'next' on 2020-09-09 at abcb7515dc)
 + add -i: use the built-in version when feature.experimental is set

 The "add -i/-p" machinery has been written in C but it is not used
 by default yet.  It is made default to those who are participating
 in feature.experimental experiment.

 Will merge to 'master'.


* jc/quote-path-cleanup (2020-09-08) 6 commits
 - quote: turn 'nodq' parameter into a set of flags
 - quote: rename misnamed sq_lookup[] to cq_lookup[]
 - wt-status: consistently quote paths in "status --short" output
 - quote_path: optionally allow quoting a path with SP in it
 - quote_path: give flags parameter to quote_path()
 - quote_path: rename quote_path_relative() to quote_path()

 "git status --short" quoted a path with SP in it when tracked, but
 not those that are untracked, ignored or unmerged.  They are all
 shown quoted consistently.

 Undecided.
 This is more involved than alternatives proposed by brian and R=C3=A9ne
 and I am not sure extra changes to the codebase is a net positive.
 cf. <20200908013013.1099937-1-sandals@crustytoothpaste.net>
 cf. <3a72c5f2-35cc-a865-d5f2-02706c48d8ec@web.de>


* jk/add-i-fixes (2020-09-08) 2 commits
  (merged to 'next' on 2020-09-09 at 46ea071a7a)
 + add--interactive.perl: specify --no-color explicitly
 + add-patch: fix inverted return code of repo_read_index()

 "add -i/-p" fixes.

 Will merge to 'master'.


* os/collect-changed-submodules-optim (2020-09-06) 1 commit
 - submodule: suppress checking for file name and ref ambiguity for objec=
t ids

 Optimization around submodule handling.

 Will merge to 'next'.


* os/fetch-submodule-optim (2020-09-06) 1 commit
 - fetch: do not look for submodule changes in unchanged refs

 Optimization around submodule handling.

 Will merge to 'next'.


* pw/add-p-edit-ita-path (2020-09-09) 1 commit
 - add -p: fix editing of intent-to-add paths

 "add -p" did not allow editing paths that were only added in
 intent.

 Will merge to 'next'.


* pw/add-p-leakfix (2020-09-08) 1 commit
  (merged to 'next' on 2020-09-09 at 4206d0503c)
 + add -p: fix memory leak

 Leakfix.

 Will merge to 'master'.


* rs/misc-cleanups (2020-09-06) 3 commits
  (merged to 'next' on 2020-09-09 at 4a19ea9672)
 + pack-bitmap-write: use hashwrite_be32() in write_hash_cache()
 + midx: use hashwrite_u8() in write_midx_header()
 + fast-import: use write_pack_header()

 Misc cleanups.

 Will merge to 'master'.


* rs/parallel-read-cache-fix (2020-09-06) 1 commit
  (merged to 'next' on 2020-09-09 at 92953a75c4)
 + read-cache: fix mem-pool allocation for multi-threaded index loading

 A follow-up fix to a topic already in 'master'.

 Will merge to 'master'.


* rs/refspec-leakfix (2020-09-06) 2 commits
  (merged to 'next' on 2020-09-09 at 10741e90a5)
 + refspec: add and use refspec_appendf()
 + push: release strbufs used for refspec formatting

 Leakfix.

 Will merge to 'master'.


* so/log-tree-diff-cleanup (2020-09-06) 2 commits
  (merged to 'next' on 2020-09-09 at f8744b8e8a)
 + log_tree_diff: get rid of extra check for NULL
 + log_tree_diff: get rid of code duplication for first_parent_only

 Code cleanup.

 Will merge to 'master'.


* hn/refs-trace-backend (2020-09-09) 1 commit
 - refs: add GIT_TRACE_REFS debugging mechanism

 Developer support.

 Will merge to 'next'.


* jc/dist-tarball-tweak (2020-09-09) 1 commit
 - Makefile: allow extra tweaking of distribution tarball

 Allow maintainers to tweak $(TAR) invocations done while making
 distribution tarballs.

 Will merge to 'next'.


* mt/config-fail-nongit-early (2020-09-09) 1 commit
 - config: complain about --worktree outside of a git repo

 Unlike "git config --local", "git config --worktree" did not fail
 early and cleanly when started outside a git repository.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* vv/send-email-with-less-secure-apps-access (2020-08-29) 1 commit
 - Documentation/git-send-email.txt: Mention less secure app access might=
 need to enable.

 Doc update.

 Expecting a reroll.
 cf. <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
 cf. <xmqqft85i72s.fsf@gitster.c.googlers.com>


* jc/war-on-dashed-git (2020-08-27) 1 commit
 - git: catch an attempt to run "git-foo"

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 On hold for now.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=3D" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200416152145.wp2zeibxmuyas6y6@feanor>
 cf. <xmqqv9gu7c61.fsf@gitster.c.googlers.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* tb/bloom-improvements (2020-09-09) 12 commits
 - builtin/commit-graph.c: introduce '--max-new-filters=3D<n>'
 - commit-graph: rename 'split_commit_graph_opts'
 - bloom: encode out-of-bounds filters as non-empty
 - bloom/diff: properly short-circuit on max_changes
 - bloom: use provided 'struct bloom_filter_settings'
 - bloom: split 'get_bloom_filter()' in two
 - commit-graph.c: store maximum changed paths
 - commit-graph: respect 'commitGraph.readChangedPaths'
 - t/helper/test-read-graph.c: prepare repo settings
 - commit-graph: pass a 'struct repository *' in more places
 - t4216: use an '&&'-chain
 - commit-graph: introduce 'get_bloom_filter_settings()'

 "git commit-graph write" learned to limit the number of bloom
 filters that are computed from scratch with the --max-new-filters
 option.


* es/config-hooks (2020-09-09) 9 commits
 - run_commit_hook: take strvec instead of varargs
 - commit: use config-based hooks
 - hook: replace run-command.h:find_hook
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.


* ls/mergetool-meld-auto-merge (2020-09-09) 1 commit
 - Support auto-merge for meld to follow the vim-diff behavior

 The 'meld' backend of the "git mergetool" learned to give the
 underlying 'meld' the '--auto-merge' option, which would help
 reduce the amount of text that requires manual merging.

 Will merge to 'next'.


* mf/submodule-summary-with-correct-repository (2020-06-24) 2 commits
 - submodule: use submodule repository when preparing summary
 - revision: use repository from rev_info when parsing commits

 "git diff/show" on a change that involves a submodule used to read
 the information on commits in the submodule from a wrong repository
 and gave a wrong information when the commit-graph is involved.

 Will merge to 'next'.
 cf. <xmqqzh667ca4.fsf@gitster.c.googlers.com>


* pb/clang-json-compilation-database (2020-09-06) 1 commit
  (merged to 'next' on 2020-09-09 at 9f5ea136f1)
 + Makefile: add support for generating JSON compilation database

 Developer support.

 Will merge to 'master'.


* mt/grep-sparse-checkout (2020-09-02) 8 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - t/helper/test-config: unify exit labels
 - t/helper/test-config: check argc before accessing argv
 - t/helper/test-config: be consistent with exit codes
 - t1308-config-set: avoid false positives when using test-config
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.


* ew/decline-core-abbrev (2020-09-01) 1 commit
 - core.abbrev <off|false|no> disables abbreviations

 Allow the configuration to specify no abbreviation regardless of
 the hash algorithm.

 Expecting a reroll.  The intent is very good.


* mr/bisect-in-c-2 (2020-08-31) 13 commits
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: reimplement `bisect_state` & `bisect_head` shell funct=
ions in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: finish porting `bisect_start()` to C
 - bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell=
 functions in C
 - bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
 - bisect--helper: reimplement `bisect_autostart` shell function in C
 - bisect--helper: introduce new `write_in_file()` function
 - bisect--helper: use '-res' in 'cmd_bisect__helper' return
 - bisect--helper: BUG() in cmd_*() on invalid subcommand

 Rewrite of the "git bisect" script in C continues.

 At v7; getting close
 cf. <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet>


* js/no-builtins-on-disk-option (2020-08-24) 3 commits
 - ci: stop linking built-ins to the dashed versions
 - install: optionally skip linking/copying the built-ins
 - msvc: copy the correct `.pdb` files in the Makefile target `install`

 The installation procedure learned to optionally omit "git-foo"
 executable files for each 'foo' built-in subcommand, which are only
 required by old timers that still rely on the age old promise that
 prepending "git --exec-path" output to PATH early in their script
 will keep the "git-foo" calls they wrote working.

 The old attempt to remove these executables from the disk failed in
 the 1.6 era; it may be worth attempting again, but I think it is
 worth to keep this topic separate from such a policy change to help
 it graduate early.

 Expecting a reroll to update log message for the last one.
 as it confused at least two reviewers.
 cf. <xmqqwo1baop3.fsf@gitster.c.googlers.com>
 cf. <20200903104537.GA27325@szeder.dev>


* jt/threaded-index-pack (2020-09-08) 7 commits
 - index-pack: make quantum of work smaller
 - index-pack: make resolve_delta() assume base data
 - index-pack: calculate {ref,ofs}_{first,last} early
 - index-pack: remove redundant child field
 - index-pack: unify threaded and unthreaded code
 - index-pack: remove redundant parameter
 - Documentation: deltaBaseCacheLimit is per-thread

 "git index-pack" learned to resolve deltified objects with greater
 parallelism.

 Will merge to 'next'.


* jk/refspecs-negative (2020-08-21) 1 commit
 - refspec: add support for negative refspecs

 "negative refspecs"


* jx/proc-receive-hook (2020-08-27) 10 commits
 - doc: add documentation for the proc-receive hook
 - transport: parse report options for tracking refs
 - t5411: test updates of remote-tracking branches
 - receive-pack: new config receive.procReceiveRefs
 - doc: add document for capability report-status-v2
 - New capability "report-status-v2" for git-push
 - receive-pack: feed report options to post-receive
 - receive-pack: add new proc-receive hook
 - t5411: add basic test cases for proc-receive hook
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Will merge to 'next'.


* ds/maintenance-part-2 (2020-09-06) 8 commits
 - maintenance: add incremental-repack auto condition
 - maintenance: auto-size incremental-repack batch
 - maintenance: add incremental-repack task
 - midx: use start_delayed_progress()
 - midx: enable core.multiPackIndex by default
 - maintenance: create auto condition for loose-objects
 - maintenance: add loose-objects task
 - maintenance: add prefetch task
 (this branch is used by ds/maintenance-part-3; uses ds/maintenance-part-=
1.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.


* ds/maintenance-part-1 (2020-09-06) 11 commits
 - maintenance: add trace2 regions for task execution
 - maintenance: add auto condition for commit-graph task
 - maintenance: use pointers to check --auto
 - maintenance: create maintenance.<task>.enabled config
 - maintenance: take a lock on the objects directory
 - maintenance: add --task option
 - maintenance: add commit-graph task
 - maintenance: initialize task array
 - maintenance: replace run_auto_gc()
 - maintenance: add --quiet option
 - maintenance: create basic maintenance runner
 (this branch is used by ds/maintenance-part-2 and ds/maintenance-part-3.=
)

 A "git gc"'s big brother has been introduced to take care of more
 repository maintenance tasks, not limited to the object database
 cleaning.

 Will merge to 'next'.

--------------------------------------------------
[Discarded]

* jc/remove-pack-redundant (2020-08-25) 1 commit
 . pack-redundant: gauge the usage before proposing its removal

 The first step to remove "git pack-redundant" by soliciting
 objections.

 Stop--we had some activity as late as last year.
