Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3681D1FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 21:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbdGRVjx (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 17:39:53 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:65347 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbdGRVju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 17:39:50 -0400
Received: from pb-sasl-trial2.pobox.com (ro.sql.pobox.com [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 9102624060;
        Tue, 18 Jul 2017 17:39:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=n
        jQXzAaozr3csjobPIUk5NiKWiQ=; b=Roy/7KTwgytpdbXarEW8lDjFP5APIE3XI
        SoChAqSTcaGJ8NIrVLxtpyOwZ/yjiyVhXu0+5+jUJDuj52FEIrSAdkQ2lsITjWce
        ejSx1sjzWmS7gcdy1+037tBKmxRE8DPvAKRvwXDP7o12hYTPrDYEjviti+MObomu
        EZWiN8wSls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=ltZ
        0z/ur0iJQJ05r28MMHsozHIn7o2aXox3xJN6jK3XR0KrEU8iIpmr+MLuiW+eOoQv
        cfEbhPorjUwoWqkvYbARQunpWOhzf8jHuQVzt5jIcqFRhpdTkuMQt17D7UD3Qj9V
        aF1I0tFKfn+SH4hPxW0Mv22bnI/Vo4+dS1gGetdE=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 6D5272405F;
        Tue, 18 Jul 2017 17:39:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C5A47C441;
        Tue, 18 Jul 2017 17:39:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2017, #05; Tue, 18)
X-master-at: cac25fc330fc26050dcbc92c4bfff169a4848e93
X-next-at: a5a5890e50e4d3c12611adc886e44b2c07a74a76
Date:   Tue, 18 Jul 2017 14:39:45 -0700
Message-ID: <xmqqr2xdmnku.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E5F63B6-6C01-11E7-B017-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

A maintenance release for 2.13.x series, and the first preview for
2.14 series -rc0, have been tagged.  Let's close the 'master' except
for obvious fixes and clean-ups and concentrate on regressions from
now on.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/gc-pre-detach-under-hook (2017-07-12) 1 commit
  (merged to 'next' on 2017-07-12 at 9cf44c2b07)
 + gc: run pre-detach operations under lock

 We run an early part of "git gc" that deals with refs before
 daemonising (and not under lock) even when running a background
 auto-gc, which caused multiple gc processes attempting to run the
 early part at the same time.  This is now prevented by running the
 early part also under the GC lock.


* jn/hooks-pre-rebase-sample-fix (2017-07-11) 1 commit
  (merged to 'next' on 2017-07-12 at ed86887454)
 + pre-rebase hook: capture documentation in a <<here document

 Code clean-up, that makes us in sync with Debian by one patch.


* rs/progress-overall-throughput-at-the-end (2017-07-09) 1 commit
  (merged to 'next' on 2017-07-11 at f5168e975b)
 + progress: show overall rate in last update

 The progress meter did not give a useful output when we haven't had
 0.5 seconds to measure the throughput during the interval.  Instead
 show the overall throughput rate at the end, which is a much more
 useful number.


* tb/push-to-cygwin-unc-path (2017-07-05) 1 commit
  (merged to 'next' on 2017-07-11 at 4d9c3f82bd)
 + cygwin: allow pushing to UNC paths

 On Cygwin, similar to Windows, "git push //server/share/repository"
 ought to mean a repository on a network share that can be accessed
 locally, but this did not work correctly due to stripping the double
 slashes at the beginning.

 This may need to be heavily tested before it gets unleashed to the
 wild, as the change is at a fairly low-level code and would affect
 not just the code to decide if the push destination is local.  There
 may be unexpected fallouts in the path normalization.

--------------------------------------------------
[New Topics]

* jk/c99 (2017-07-18) 2 commits
  (merged to 'next' on 2017-07-18 at 1cfc30f7c1)
 + clean.c: use designated initializer
 + strbuf: use designated initializers in STRBUF_INIT

 Start using selected c99 constructs in small, stable and
 essentialpart of the system to catch people who care about
 older compilers that do not grok them.

 Will cook in 'next'.


* jk/check-ref-format-oor-fix (2017-07-14) 1 commit
 - check-ref-format: require a repository for --branch

 Objected...
 cf. <20170717172709.GL93855@aiede.mtv.corp.google.com>


* bw/grep-recurse-submodules (2017-07-18) 10 commits
 - grep: recurse in-process using 'struct repository'
 - submodule: merge repo_read_gitmodules and gitmodules_config
 - submodule: check for unmerged .gitmodules outside of config parsing
 - submodule: check for unstaged .gitmodules outside of config parsing
 - submodule: remove fetch.recursesubmodules from submodule-config parsing
 - submodule: remove submodule.fetchjobs from submodule-config parsing
 - config: add config_from_gitmodules
 - cache.h: add GITMODULES_FILE macro
 - repository: have the_repository use the_index
 - repo_read_index: don't discard the index


* bw/object-id (2017-07-17) 3 commits
  (merged to 'next' on 2017-07-18 at 90d27c0e7c)
 + receive-pack: don't access hash of NULL object_id pointer
 + notes: don't access hash of NULL object_id pointer
 + tree-diff: don't access hash of NULL object_id pointer

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'master'.


* ew/fd-cloexec-fix (2017-07-17) 1 commit
  (merged to 'next' on 2017-07-18 at a3de1b1998)
 + set FD_CLOEXEC properly when O_CLOEXEC is not supported

 Portability/fallback fix.

 Will merge to 'master'.


* jk/build-with-asan (2017-07-17) 1 commit
  (merged to 'next' on 2017-07-18 at f92636c616)
 + Makefile: allow combining UBSan with other sanitizers

 A recent update made it easier to use "-fsanitize=" option while
 compiling but supported only one sanitize option.  Allow more than
 one to be combined, joined with a comma, like "make SANITIZE=foo,bar".

 Will merge to 'master'.


* jk/test-copy-bytes-fix (2017-07-17) 1 commit
  (merged to 'next' on 2017-07-18 at c32c264e96)
 + t: handle EOF in test_copy_bytes()

 A test fix.

 Will merge to 'master'.


* js/alias-case-sensitivity (2017-07-17) 2 commits
  (merged to 'next' on 2017-07-18 at 31641a39f2)
 + alias: compare alias name *case-insensitively*
 + t1300: demonstrate that CamelCased aliases regressed

 A recent update broke an alias that contained an uppercase letter.

 Will merge to 'master'.


* ks/commit-abort-on-empty-message-fix (2017-07-17) 1 commit
 - commit: check for empty message before the check for untouched template

 "git commit" when seeing an totally empty message said "you did not
 edit the message", which is clearly wrong.  The message has been
 corrected.

 Will merge to 'next'.


* ks/doc-fixes (2017-07-17) 1 commit
 - doc: camelCase the i18n config variables to improve readability

 Will merge to 'next'.


* rs/bswap-ubsan-fix (2017-07-17) 2 commits
 - bswap: convert get_be16, get_be32 and put_be32 to inline functions
 - bswap: convert to unsigned before shifting in get_be32

 Will merge to 'next'.


* rs/move-array (2017-07-17) 4 commits
 - ls-files: don't try to prune an empty index
 - apply: use COPY_ARRAY and MOVE_ARRAY in update_image()
 - use MOVE_ARRAY
 - add MOVE_ARRAY

 Will merge to 'next'.


* rs/stat-data-unaligned-reads-fix (2017-07-17) 1 commit
 - dir: support platforms that require aligned reads

 Will merge to 'next'.


* wd/rebase-conflict-guide (2017-07-17) 1 commit
 - rebase: make resolve message clearer for inexperienced users

 Will merge to 'next'.


* hb/gitweb-project-list (2017-07-18) 1 commit
 - gitweb: skip unreadable subdirectories

 When a directory is not readable, "gitweb" fails to build the
 project list.  Work this around by skipping such a directory.

 Undecided.

 It might end up hiding a problem under the rug and a better
 solution might be to loudly complain to the administrator pointing
 out the problematic directory, but this will at least make it
 "work".

--------------------------------------------------
[Stalled]

* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>


* sg/clone-refspec-from-command-line-config (2017-06-16) 2 commits
 - Documentation/clone: document ignored configuration variables
 - clone: respect additional configured fetch refspecs during initial fetch
 (this branch is used by sg/remote-no-string-refspecs.)

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Waiting for a response.
 cf. <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
 cf. <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com>


* js/rebase-i-final (2017-06-15) 10 commits
 - rebase -i: rearrange fixup/squash lines using the rebase--helper
 - t3415: test fixup with wrapped oneline
 - rebase -i: skip unnecessary picks using the rebase--helper
 - rebase -i: check for missing commits in the rebase--helper
 - t3404: relax rebase.missingCommitsCheck tests
 - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 - rebase -i: remove useless indentation
 - rebase -i: generate the script via rebase--helper
 - t3415: verify that an empty instructionFormat is handled as before

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.

 Expecting a reroll.
 This is at its v5.
 cf. <cover.1497444257.git.johannes.schindelin@gmx.de>

--------------------------------------------------
[Cooking]

* jk/ref-filter-colors (2017-07-13) 15 commits
  (merged to 'next' on 2017-07-18 at 75d4eb7ecf)
 + ref-filter: consult want_color() before emitting colors
 + pretty: respect color settings for %C placeholders
 + rev-list: pass diffopt->use_colors through to pretty-print
 + for-each-ref: load config earlier
 + color: check color.ui in git_default_config()
 + ref-filter: pass ref_format struct to atom parsers
 + ref-filter: factor out the parsing of sorting atoms
 + ref-filter: make parse_ref_filter_atom a private function
 + ref-filter: provide a function for parsing sort options
 + ref-filter: move need_color_reset_at_eol into ref_format
 + ref-filter: abstract ref format into its own struct
 + ref-filter: simplify automatic color reset
 + t: use test_decode_color rather than literal ANSI codes
 + docs/for-each-ref: update pointer to color syntax
 + check return value of verify_ref_format()

 "%C(color name)" in the pretty print format always produced ANSI
 color escape codes, which was an early design mistake.  They now
 honor the configuration (e.g. "color.ui = never") and also tty-ness
 of the output medium.

 Will cook in 'next'.


* sb/object-id (2017-07-13) 2 commits
  (merged to 'next' on 2017-07-18 at e4df0ba3b1)
 + tag: convert gpg_verify_tag to use struct object_id
 + commit: convert lookup_commit_graft to struct object_id
 (this branch is used by bc/object-id.)

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'master'.


* rs/sha1-file-micro-optim (2017-07-09) 2 commits
 - SQUASH???
 - sha1_file: add slash once in for_each_file_in_obj_subdir()

 Code cleanup.

 Perhaps drop.
 cf. <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>


* ks/prepare-commit-msg-sample (2017-07-12) 4 commits
  (merged to 'next' on 2017-07-18 at 48d9650a30)
 + hook: add a simple first example
 + hook: add sign-off using "interpret-trailers"
 + hook: name the positional variables
 + hook: cleanup script

 Remove an example that is now obsolete from a sample hook,
 and improve an old example in it that added a sign-off manually
 to use the interpret-trailers command.

 Will cook in 'next'.


* jc/allow-lazy-cas (2017-07-06) 1 commit
 - push: disable lazy --force-with-lease by default

 Because "git push --force-with-lease[=<ref>]" that relies on the
 stability of remote-tracking branches is unsafe when something
 fetches into the repository behind user's back, it is now disabled
 by default.  A new configuration variable can be used to enable it
 by users who know what they are doing.  This would pave the way to
 possibly turn `--force` into `--force-with-lease`.

 Will wait for feedback, then merge to and cook in 'next'.

 Independent from disabling the feature by default, this stirred up
 a discussion to replace the DWIM heuristics with a better one, which
 deserves to be its own topic.
 cf. <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>


* bc/object-id (2017-07-17) 12 commits
  (merged to 'next' on 2017-07-18 at fd161056e4)
 + sha1_name: convert uses of 40 to GIT_SHA1_HEXSZ
 + sha1_name: convert GET_SHA1* flags to GET_OID*
 + sha1_name: convert get_sha1* to get_oid*
 + Convert remaining callers of get_sha1 to get_oid.
 + builtin/unpack-file: convert to struct object_id
 + bisect: convert bisect_checkout to struct object_id
 + builtin/update_ref: convert to struct object_id
 + sequencer: convert to struct object_id
 + remote: convert struct push_cas to struct object_id
 + submodule: convert submodule config lookup to use object_id
 + builtin/merge-tree: convert remaining caller of get_sha1 to object_id
 + builtin/fsck: convert remaining caller of get_sha1 to object_id
 (this branch uses sb/object-id.)

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'master'.


* jk/reflog-walk (2017-07-09) 9 commits
  (merged to 'next' on 2017-07-09 at 7449e964c6)
 + reflog-walk: apply --since/--until to reflog dates
 + reflog-walk: stop using fake parents
 + rev-list: check reflog_info before showing usage
 + get_revision_1(): replace do-while with an early return
 + log: do not free parents when walking reflog
 + log: clarify comment about reflog cycles
 + revision: disallow reflog walking with revs->limited
 + t1414: document some reflog-walk oddities
 + Merge branch 'jk/reflog-walk-maint' into jk/reflog-walk

 Numerous bugs in walking of reflogs via "log -g" and friends have
 been fixed.

 Will cook in 'next'.


* sb/hashmap-cleanup (2017-07-05) 10 commits
  (merged to 'next' on 2017-07-12 at ce31d06165)
 + t/helper/test-hashmap: use custom data instead of duplicate cmp functions
 + name-hash.c: drop hashmap_cmp_fn cast
 + submodule-config.c: drop hashmap_cmp_fn cast
 + remote.c: drop hashmap_cmp_fn cast
 + patch-ids.c: drop hashmap_cmp_fn cast
 + convert/sub-process: drop cast to hashmap_cmp_fn
 + config.c: drop hashmap_cmp_fn cast
 + builtin/describe: drop hashmap_cmp_fn cast
 + builtin/difftool.c: drop hashmap_cmp_fn cast
 + attr.c: drop hashmap_cmp_fn cast

 Many uses of comparision callback function the hashmap API uses
 cast the callback function type when registering it to
 hashmap_init(), which defeats the compile time type checking when
 the callback interface changes (e.g. gaining more parameters).
 The callback implementations have been updated to take "void *"
 pointers and cast them to the type they expect instead.

 Will cook in 'next'.


* mt/p4-parse-G-output (2017-07-13) 3 commits
  (merged to 'next' on 2017-07-18 at e065b689d4)
 + git-p4: filter for {'code':'info'} in p4CmdList
 + git-p4: parse marshal output "p4 -G" in p4 changes
 + git-p4: git-p4 tests with p4 triggers

 Use "p4 -G" to make "p4 changes" output more Python-friendly
 to parse.

 Will merge to 'master'.


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-06-26 at d026281517)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.


* mh/packed-ref-store (2017-07-03) 30 commits
  (merged to 'next' on 2017-07-05 at 6c68c603cc)
 + read_packed_refs(): die if `packed-refs` contains bogus data
 + t3210: add some tests of bogus packed-refs file contents
 + repack_without_refs(): don't lock or unlock the packed refs
 + commit_packed_refs(): remove call to `packed_refs_unlock()`
 + clear_packed_ref_cache(): don't protest if the lock is held
 + packed_refs_unlock(), packed_refs_is_locked(): new functions
 + packed_refs_lock(): report errors via a `struct strbuf *err`
 + packed_refs_lock(): function renamed from lock_packed_refs()
 + commit_packed_refs(): use a staging file separate from the lockfile
 + commit_packed_refs(): report errors rather than dying
 + packed_ref_store: make class into a subclass of `ref_store`
 + packed-backend: new module for handling packed references
 + packed_read_raw_ref(): new function, replacing `resolve_packed_ref()`
 + packed_ref_store: support iteration
 + packed_peel_ref(): new function, extracted from `files_peel_ref()`
 + repack_without_refs(): take a `packed_ref_store *` parameter
 + get_packed_ref(): take a `packed_ref_store *` parameter
 + rollback_packed_refs(): take a `packed_ref_store *` parameter
 + commit_packed_refs(): take a `packed_ref_store *` parameter
 + lock_packed_refs(): take a `packed_ref_store *` parameter
 + add_packed_ref(): take a `packed_ref_store *` parameter
 + get_packed_refs(): take a `packed_ref_store *` parameter
 + get_packed_ref_cache(): take a `packed_ref_store *` parameter
 + validate_packed_ref_cache(): take a `packed_ref_store *` parameter
 + clear_packed_ref_cache(): take a `packed_ref_store *` parameter
 + packed_ref_store: move `packed_refs_lock` member here
 + packed_ref_store: move `packed_refs_path` here
 + packed_ref_store: new struct
 + add_packed_ref(): teach function to overwrite existing refs
 + t1408: add a test of stale packed refs covered by loose refs

 The "ref-store" code reorganization continues.

 Will cook in 'next'.


* sd/branch-copy (2017-06-18) 3 commits
  (merged to 'next' on 2017-07-18 at 5e3b9357ea)
 + branch: add a --copy (-c) option to go with --move (-m)
 + branch: add test for -m renaming multiple config sections
 + config: create a function to format section headers

 "git branch" learned "-c/-C" to create and switch to a new branch
 by copying an existing one.

 Will cook in 'next'.

 I personally do not think "branch --copy master backup" while on
 "master" that switches to "backup" is a good UI, and I *will* say
 "I told you so" when users complain after we merge this down to
 'master'.


* ls/filter-process-delayed (2017-06-30) 7 commits
  (merged to 'next' on 2017-07-05 at a35e644082)
 + convert: add "status=delayed" to filter process protocol
 + convert: refactor capabilities negotiation
 + convert: move multiple file filter error handling to separate function
 + convert: put the flags field before the flag itself for consistent style
 + t0021: write "OUT <size>" only on success
 + t0021: make debug log file name configurable
 + t0021: keep filter log files on comparison

 The filter-process interface learned to allow a process with long
 latency give a "delayed" response.

 Will cook in 'next'.


* bp/fsmonitor (2017-06-12) 6 commits
 - fsmonitor: add a sample query-fsmonitor hook script for Watchman
 - fsmonitor: add documentation for the fsmonitor extension.
 - fsmonitor: add test cases for fsmonitor extension
 - fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 - dir: make lookup_untracked() available outside of dir.c
 - bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status".

 Expecting a reroll.
 cf. <bade1166-e646-b05a-f65b-adb8da8ba0a7@gmail.com>


* sb/diff-color-move (2017-06-30) 26 commits
  (merged to 'next' on 2017-07-06 at 758ed40e4f)
 + diff: document the new --color-moved setting
 + diff.c: add dimming to moved line detection
 + diff.c: color moved lines differently, plain mode
 + diff.c: color moved lines differently
 + diff.c: buffer all output if asked to
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
 + diff.c: convert word diffing to use emit_diff_symbol
 + diff.c: convert show_stats to use emit_diff_symbol
 + diff.c: convert emit_binary_diff_body to use emit_diff_symbol
 + submodule.c: migrate diff output to use emit_diff_symbol
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
 + diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
 + diff.c: migrate emit_line_checked to use emit_diff_symbol
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
 + diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
 + diff.c: introduce emit_diff_symbol
 + diff.c: factor out diff_flush_patch_all_file_pairs
 + diff.c: move line ending check into emit_hunk_header
 + diff.c: readability fix
 + Merge branch 'sb/hashmap-customize-comparison' into sb/diff-color-move

 "git diff" has been taught to optionally paint new lines that are
 the same as deleted lines elsewhere differently from genuinely new
 lines.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* mh/packed-ref-store-prep-extra (2017-06-18) 1 commit
 . prefix_ref_iterator_advance(): relax the check of trim length

 Split out of mh/packed-ref-store-prep.


* nd/prune-in-worktree (2017-04-24) 12 commits
 . rev-list: expose and document --single-worktree
 . revision.c: --reflog add HEAD reflog from all worktrees
 . files-backend: make reflog iterator go through per-worktree reflog
 . revision.c: --all adds HEAD from all worktrees
 . refs: remove dead for_each_*_submodule()
 . revision.c: use refs_for_each*() instead of for_each_*_submodule()
 . refs: add refs_head_ref()
 . refs: move submodule slash stripping code to get_submodule_ref_store
 . refs.c: refactor get_submodule_ref_store(), share common free block
 . revision.c: --indexed-objects add objects from all worktrees
 . revision.c: refactor add_index_objects_to_pending()
 . revision.h: new flag in struct rev_info wrt. worktree-related refs

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.
