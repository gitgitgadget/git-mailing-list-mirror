Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71892C4727D
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 22:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDDBC20848
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 22:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pb2UuCk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgI2WGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 18:06:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63681 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgI2WGi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 18:06:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0FC587F0F;
        Tue, 29 Sep 2020 18:06:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=H
        1k0HLdIFl1C9YGEUOBpVxUSqg8=; b=pb2UuCk7hIoilP6WmFfzfTT00N8gM/gfV
        cTPbrxgMxaLZQ40QZQkyPKflEMfCRwlBVQ0kS2FSvOUb0XBnToU2YTCpHgHYGTlW
        oRucDQSKYM8+jPMP0gDWUDbMly+lU8SXG7xW8yOP9jy13NGIl40CZ9MJwF7Nu598
        GuB1xMaJ2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=VAp
        j/v6/lfTVaZDh8xQ0fNhkswjNOMxH8duCLFuq+iEnv7BpBO9laXGIB41rWF/stbH
        6OhRMMe3ZqSQaVeOKuiwy05x9AUycYSlgfyOmZY/HzYcev00i+K6Gf61WB9akcTG
        2+xMawqRwWnoNUJD9dTcG9mh2pjZGtkqFn2j6HQQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C31D587F0E;
        Tue, 29 Sep 2020 18:06:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C895F87F08;
        Tue, 29 Sep 2020 18:06:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2020, #08; Tue, 29)
X-master-at: 306ee63a703ad67c54ba1209dc11dd9ea500dc1f
X-next-at: fda3e449589e6e1698cd98ab4cab9214fe925eec
Date:   Tue, 29 Sep 2020 15:06:27 -0700
Message-ID: <xmqqv9fwgrvg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0648EC26-02A0-11EB-8AEE-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

We have a topic on 'seen', sk/force-if-includes, that behaves
differently when the commit-graph feature is in use (a working
in_merge_bases_many() implementation is critical for the topic to
work as expected).  Help in debugging it is very much appreciated.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* ah/pull (2020-09-24) 1 commit
  (merged to 'next' on 2020-09-25 at b5ddf0cf8b)
 + pull: don't warn if pull.ff has been set

 Earlier we taught "git pull" to warn when the user does not say the
 histories need to be merged, rebased or accepts only fast-
 forwarding, but the warning triggered for those who have set the
 pull.ff configuration variable.


* bc/clone-with-git-default-hash-fix (2020-09-22) 1 commit
  (merged to 'next' on 2020-09-22 at 62ea45c20e)
 + builtin/clone: avoid failure with GIT_DEFAULT_HASH

 "git clone" that clones from SHA-1 repository, while
 GIT_DEFAULT_HASH set to use SHA-256 already, resulted in an
 unusable repository that half-claims to be SHA-256 repository
 with SHA-1 objects and refs.  This has been corrected.


* bc/faq-misc (2020-09-20) 3 commits
  (merged to 'next' on 2020-09-22 at a81b728010)
 + docs: explain how to deal with files that are always modified
 + docs: explain why reverts are not always applied on merge
 + docs: explain why squash merges are broken with long-running branches

 More FAQ entries.


* dl/zero-oid-in-hooks (2020-09-23) 3 commits
  (merged to 'next' on 2020-09-25 at 3c7d03d61a)
 + hooks--update.sample: use hash-agnostic zero OID
 + hooks--pre-push.sample: use hash-agnostic zero OID
 + hooks--pre-push.sample: modernize script

 Adjust sample hooks for hash algorithm other than SHA-1.


* jc/t1506-rev-parse-leaves-range-endpoint-unpeeled (2020-09-25) 1 commit
  (merged to 'next' on 2020-09-25 at e5233774ba)
 + t1506: rev-parse A..B and A...B

 Test update.


* jk/make-protocol-v2-the-default (2020-09-25) 1 commit
  (merged to 'next' on 2020-09-25 at 21a5f9e880)
 + protocol: re-enable v2 protocol by default

 The transport protocol v2 has become the default again.


* tb/bloom-improvements (2020-09-18) 13 commits
  (merged to 'next' on 2020-09-22 at 520d531ad8)
 + commit-graph: introduce 'commitGraph.maxNewFilters'
 + builtin/commit-graph.c: introduce '--max-new-filters=<n>'
 + commit-graph: rename 'split_commit_graph_opts'
 + bloom: encode out-of-bounds filters as non-empty
 + bloom/diff: properly short-circuit on max_changes
 + bloom: use provided 'struct bloom_filter_settings'
 + bloom: split 'get_bloom_filter()' in two
 + commit-graph.c: store maximum changed paths
 + commit-graph: respect 'commitGraph.readChangedPaths'
 + t/helper/test-read-graph.c: prepare repo settings
 + commit-graph: pass a 'struct repository *' in more places
 + t4216: use an '&&'-chain
 + commit-graph: introduce 'get_bloom_filter_settings()'

 "git commit-graph write" learned to limit the number of bloom
 filters that are computed from scratch with the --max-new-filters
 option.


* tg/range-diff-same-file-fix (2020-09-24) 1 commit
  (merged to 'next' on 2020-09-25 at c2078e5505)
 + diff: fix modified lines stats with --stat and --numstat

 "git range-diff" showed incorrect diffstat, which has been
 corrected.

--------------------------------------------------
[New Topics]

* al/ref-filter-merged-and-no-merged (2020-09-26) 1 commit
  (merged to 'next' on 2020-09-29 at 748a286753)
 + ref-filter: plug memory leak in reach_filter()

 Hotfix.

 Will merge to 'master'.


* au/complete-restore-s (2020-09-26) 2 commits
  (merged to 'next' on 2020-09-29 at 7bbf508562)
 + completion: complete refs after 'git restore -s'
 + completion: use "prev" variable instead of introducing "prevword"

 The command line completion (in contrib/) learned that "git restore
 -s <TAB>" is often followed by a refname.

 Will merge to 'master'.


* eg/mailinfo-doc-scissors (2020-09-28) 1 commit
  (merged to 'next' on 2020-09-29 at 4694f22fe9)
 + Doc: show example scissors line

 The explanation of the "scissors line" has been clarified.

 Will merge to 'master'.


* jc/fmt-merge-msg-suppress-destination (2020-09-27) 1 commit
  (merged to 'next' on 2020-09-29 at 2b1f8ee654)
 + config/fmt-merge-msg.txt: drop space in quote

 Docfix.

 Will merge to 'master'.


* jk/format-auto-base-when-able (2020-09-26) 1 commit
 - format-patch: teach format.useAutoBase "whenAble" option

 "git format-patch" learns to take "if-able" as a possible value for
 its "--base" option, and "whenAble" as a possible value for the
 format.useAutoBase configuration variable to become no-op when the
 automatically computed base does not make sense.


* ma/worktree-cleanups (2020-09-27) 7 commits
 - worktree: use skip_prefix to parse target
 - worktree: rename copy-pasted variable
 - worktree: update renamed variable in comment
 - worktree: inline `worktree_ref()` into its only caller
 - wt-status: introduce wt_status_state_free_buffers()
 - wt-status: print to s->fp, not stdout
 - wt-status: replace sha1 mentions with oid

 Code clean-up.

 Will merge to 'next'.


* mt/delta-base-cache-races (2020-09-28) 2 commits
  (merged to 'next' on 2020-09-29 at ee2d60c077)
 + packfile: fix memory leak in add_delta_base_cache()
 + packfile: fix race condition on unpack_entry()

 A race that leads to an access to a free'd data was corrected in
 the codepath that reads pack files.

 Will merge to 'master'.


* nl/credential-crlf (2020-09-28) 3 commits
 - docs: make notes regarding credential line reading
 - credentials: make line reading Windows compatible
 - credential.c: fix credential reading with regards to CR/LF

 cf. <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>


* tb/upload-pack-filters (2020-09-27) 1 commit
  (merged to 'next' on 2020-09-29 at 3dde767170)
 + config/uploadpack.txt: fix typo in `--filter=tree:<n>`

 Hotfix.

 Will merge to 'master'.


* so/combine-diff-simplify (2020-09-29) 1 commit
 - diff: get rid of redundant 'dense' argument

--------------------------------------------------
[Stalled]

* vv/send-email-with-less-secure-apps-access (2020-08-29) 1 commit
 - Documentation/git-send-email.txt: Mention less secure app access might need to enable.

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

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Discard for now.
 cf. <xmqqv9gu7c61.fsf@gitster.c.googlers.com>
 cf. <20200911214358.acl3hy2e763begoo@feanor>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* cc/bisect-start-fix (2020-09-25) 1 commit
  (merged to 'next' on 2020-09-29 at 637011d04a)
 + bisect: don't use invalid oid as rev when starting

 "git bisect start X Y", when X and Y are not valid committish
 object names, should take X and Y as pathspec, but didn't.

 Will merge to 'master'.


* mt/parallel-checkout-part-1 (2020-09-22) 19 commits
 - ci: run test round with parallel-checkout enabled
 - parallel-checkout: add tests related to .gitattributes
 - parallel-checkout: add tests related to clone collisions
 - parallel-checkout: add tests for basic operations
 - checkout-index: add parallel checkout support
 - builtin/checkout.c: complete parallel checkout support
 - make_transient_cache_entry(): optionally alloc from mem_pool
 - parallel-checkout: support progress displaying
 - parallel-checkout: make it truly parallel
 - unpack-trees: add basic support for parallel checkout
 - entry: add checkout_entry_ca() which takes preloaded conv_attrs
 - entry: move conv_attrs lookup up to checkout_entry()
 - entry: extract cache_entry update from write_entry()
 - entry: make fstat_output() and read_blob_entry() public
 - entry: extract a header file for entry.c functions
 - convert: add conv_attrs classification
 - convert: add get_stream_filter_ca() variant
 - convert: add [async_]convert_to_working_tree_ca() variants
 - convert: make convert_attrs() and convert structs public

 Parallel checkout.


* jk/drop-unaligned-loads (2020-09-24) 2 commits
  (merged to 'next' on 2020-09-29 at 29c05387a0)
 + Revert "fast-export: use local array to store anonymized oid"
 + bswap.h: drop unaligned loads

 Compilation fix around type punning.

 Will merge to 'master'.


* jc/blame-ignore-fix (2020-09-24) 2 commits
  (merged to 'next' on 2020-09-29 at 96fbdb57fb)
 + blame: validate and peel the object names on the ignore list
 + t8013: minimum preparatory clean-up

 "git blame --ignore-rev/--ignore-revs-file" failed to validate
 their input are valid revision, and failed to take into account
 that the user may want to give an annotated tag instead of a
 commit, which has been corrected.

 Will merge to 'master'.


* jk/shortlog-group-by-trailer (2020-09-27) 8 commits
  (merged to 'next' on 2020-09-29 at 3706b06db5)
 + shortlog: allow multiple groups to be specified
 + shortlog: parse trailer idents
 + shortlog: rename parse_stdin_ident()
 + shortlog: de-duplicate trailer values
 + shortlog: match commit trailers with --group
 + trailer: add interface for iterating over commit trailers
 + shortlog: add grouping option
 + shortlog: change "author" variables to "ident"

 "git shortlog" has been taught to group commits by the contents of
 the trailer lines, like "Reviewed-by:", "Coauthored-by:", etc.

 Will merge to 'master'.


* js/cmake-vs (2020-09-28) 11 commits
 - cmake: fix typo in message when `msgfmt` was not found
 - hashmap_for_each_entry(): workaround MSVC's runtime check failure #3
 - cmake (Windows): recommend using Visual Studio's built-in CMake support
 - cmake (Windows): initialize vcpkg/build dependencies automatically
 - cmake (Windows): complain when encountering an unknown compiler
 - cmake (Windows): let the `.dll` files be found when running the tests
 - cmake: quote the path accurately when editing `test-lib.sh`
 - cmake: fall back to using `vcpkg`'s `msgfmt.exe` on Windows
 - cmake: ensure that the `vcpkg` packages are found on Windows
 - cmake: do find Git for Windows' shell interpreter
 - cmake: ignore files generated by CMake as run in Visual Studio

 Using the CMake support we added some time ago for real with Visual
 Studio build revealed there were lot of usability improvements
 possible, which have been carried out.

 Expecting a (hopefully) final reroll.
 cf. <nycvar.QRO.7.76.6.2009291406310.50@tvgsbejvaqbjf.bet>
 cf. <nycvar.QRO.7.76.6.2009291407130.50@tvgsbejvaqbjf.bet>


* sv/t7001-modernize (2020-09-25) 11 commits
 - t7001: move cleanup code from outside the tests into them
 - t7001: use `test` rather than `[`
 - t7001: use here-docs instead of echo
 - t7001: put each command on a separate line
 - t7001: use ': >' rather than 'touch'
 - t7001: change (cd <path> && git foo) to (git -C <path> foo)
 - t7001: remove whitespace after redirect operators
 - t7001: change the style for cd according to subshell
 - t7001: remove unnecessary blank lines
 - t7001: use TAB instead of spaces
 - t7001: convert tests from the old style to the current style

 Test script modernization.

 Expecting a reroll.
 cf. <20200925170256.11490-1-shubhunic@gmail.com>


* jc/sequencer-stopped-sha-simplify (2020-09-25) 1 commit
  (merged to 'next' on 2020-09-29 at 9af3360572)
 + sequencer: stop abbreviating stopped-sha file

 Code simplification.

 Will merge to 'master'.


* rs/archive-add-file (2020-09-19) 3 commits
 - Makefile: use git-archive --add-file
 - archive: add --add-file
 - archive: read short blobs in archive.c::write_archive_entry()

 "git archive" learns the "--add-file" option to include untracked
 files into a snapshot from a tree-ish.


* js/default-branch-name-part-2 (2020-09-26) 5 commits
 - t9902: avoid using the branch name `master`
 - tests: avoid variations of the `master` branch name
 - t3200: avoid variations of the `master` branch name
 - fast-export: avoid using unnecessary language in a code comment
 - t/test-terminal: avoid non-inclusive language

 Update the tests to drop word 'master' from them


* jt/keep-partial-clone-filter-upon-lazy-fetch (2020-09-28) 2 commits
 - fetch: do not override partial clone filter
 - promisor-remote: remove unused variable

 The lazy fetching done internally to make missing objects available
 in a partial clone incorrectly made permanent damate to the partial
 clone filter in the repository, which has been corrected.


* dl/diff-merge-base (2020-09-21) 10 commits
 - contrib/completion: complete `git diff --merge-base`
 - builtin/diff-tree: learn --merge-base
 - builtin/diff-index: learn --merge-base
 - t4068: add --merge-base tests
 - diff-lib: define diff_get_merge_base()
 - diff-lib: accept option flags in run_diff_index()
 - contrib/completion: extract common diff/difftool options
 - git-diff.txt: backtick quote command text
 - git-diff-index.txt: make --cached description a proper sentence
 - t4068: remove unnecessary >tmp

 "git diff A...B" learned "git diff --merge-base A B", which is a
 longer short-hand to say the same thing.

 Expecting a reroll.
 cf. <xmqqblhyepup.fsf@gitster.c.googlers.com>


* sb/clone-origin (2020-09-29) 7 commits
 - clone: allow configurable default for `-o`/`--origin`
 - clone: read new remote name from remote_name instead of option_origin
 - clone: validate --origin option before use
 - refs: consolidate remote name validation
 - remote: add tests for add and rename with invalid names
 - clone: use more conventional config/option layering
 - clone: add tests for --template and some disallowed option pairs

 "git clone" learned clone.defaultremotename configuration variable
 to customize what nickname to use to call the remote the repository
 was cloned from.

 Expecting an update.


* sk/force-if-includes (2020-09-27) 4 commits
 - SQUASH??? name an array in singular and avoid commenting obvious
 - t, doc: update tests, reference for "--force-if-includes"
 - push: parse and set flag for "--force-if-includes"
 - push: add reflog check for "--force-if-includes"

 "git push --force-with-lease[=<ref>]" can easily be misused to lose
 commits unless the user takes good care of their own "git fetch".
 A new option "--force-if-includes" attempts to ensure that what is
 being force-pushed was created after examining the commit at the
 tip of the remote ref that is about to be force-replaced.

 On hold.
 Seems to trigger gotchas in the reachability logic in commit-graph.


* ab/mediawiki-fixes (2020-09-21) 18 commits
  (merged to 'next' on 2020-09-25 at 878693716e)
 + remote-mediawiki: use "sh" to eliminate unquoted commands
 + remote-mediawiki: annotate unquoted uses of run_git()
 + remote-mediawiki: convert to quoted run_git() invocation
 + remote-mediawiki: provide a list form of run_git()
 + remote-mediawiki tests: annotate failing tests
 + remote-mediawiki: fix duplicate revisions being imported
 + remote-mediawiki tests: use CLI installer
 + remote-mediawiki tests: use inline PerlIO for readability
 + remote-mediawiki tests: replace deprecated Perl construct
 + remote-mediawiki tests: use a more idiomatic dispatch table
 + remote-mediawiki tests: use "$dir/" instead of "$dir."
 + remote-mediawiki tests: change `[]` to `test`
 + remote-mediawiki tests: use test_cmp in tests
 + remote-mediawiki tests: use a 10 character password
 + remote-mediawiki tests: use the login/password variables
 + remote-mediawiki doc: don't hardcode Debian PHP versions
 + remote-mediawiki doc: link to MediaWiki's current version
 + remote-mediawiki doc: correct link to GitHub project

 Modernization and fixes to MediaWiki remote backend.

 Will merge to 'master'.


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 - config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Needs more work.


* hn/reftable (2020-09-22) 14 commits
 - reftable: fix some sparse warnings
 - reftable: "test-tool dump-reftable" command.
 - reftable: rest of library
 - reftable: file level tests
 - reftable: read reftable files
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: utility functions
 - reftable: add a barebones unittest framework
 - vcxproj: adjust for the reftable changes
 - reftable: define the public API
 - reftable: add LICENSE


* bc/rev-parse-path-format (2020-09-08) 1 commit
 - rev-parse: add option for absolute or relative path formatting

 "git rev-parse" can be explicitly told to give output as absolute
 or relative path.

 Expecting a reroll.
 cf. <20200909222333.GH241078@camp.crustytoothpaste.net>


* ds/maintenance-part-3 (2020-09-25) 7 commits
 - maintenance: add troubleshooting guide to docs
 - maintenance: recommended schedule in register/start
 - maintenance: add start/stop subcommands
 - maintenance: add [un]register subcommands
 - for-each-repo: run subcommands on configured repos
 - maintenance: add --schedule option and config
 - maintenance: optionally skip --auto process
 (this branch uses ds/maintenance-part-2.)

 Parts of "git maintenance" to ease writing crontab entries (and
 other scheduling system configuration) for it.


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


* mt/grep-sparse-checkout (2020-09-10) 9 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - config: make do_git_config_sequence receive a 'struct repository'
 - t/helper/test-config: unify exit labels
 - t/helper/test-config: diagnose missing arguments
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


* mr/bisect-in-c-2 (2020-09-24) 6 commits
  (merged to 'next' on 2020-09-29 at a15f1729d2)
 + bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 + bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
 + bisect--helper: reimplement `bisect_autostart` shell function in C
 + bisect--helper: introduce new `write_in_file()` function
 + bisect--helper: use '-res' in 'cmd_bisect__helper' return
 + bisect--helper: BUG() in cmd_*() on invalid subcommand

 Rewrite of the "git bisect" script in C continues.

 Will merge to 'master'.


* js/no-builtins-on-disk-option (2020-09-21) 3 commits
  (merged to 'next' on 2020-09-25 at 6b976da4d2)
 + ci: stop linking built-ins to the dashed versions
 + Optionally skip linking/copying the built-ins
 + msvc: copy the correct `.pdb` files in the Makefile target `install`

 The installation procedure learned to optionally omit "git-foo"
 executable files for each 'foo' built-in subcommand, which are only
 required by old timers that still rely on the age old promise that
 prepending "git --exec-path" output to PATH early in their script
 will keep the "git-foo" calls they wrote working.

 The old attempt to remove these executables from the disk failed in
 the 1.6 era; it may be worth attempting again, but I think it is
 worth to keep this topic separate from such a policy change to help
 it graduate early.

 Will merge to 'master'.


* jk/refspecs-negative (2020-09-25) 1 commit
 - refspec: add support for negative refspecs

 "git fetch" and "git push" support negative refspecs.


* ds/maintenance-part-2 (2020-09-25) 8 commits
 - maintenance: add incremental-repack auto condition
 - maintenance: auto-size incremental-repack batch
 - maintenance: add incremental-repack task
 - midx: use start_delayed_progress()
 - midx: enable core.multiPackIndex by default
 - maintenance: create auto condition for loose-objects
 - maintenance: add loose-objects task
 - maintenance: add prefetch task
 (this branch is used by ds/maintenance-part-3.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.

--------------------------------------------------
[Discarded]

* js/ignore-cmake-build-artifacts (2020-09-23) 1 commit
 . cmake: ignore generated files

 Running CMake based build with VS (in contrib/) from the top-level
 of the working tree leaves extra build crufts behind.  Add patterns
 to .gitignore

 Retracted.
 cf. <pull.738.git.1601044118.gitgitgadget@gmail.com>
