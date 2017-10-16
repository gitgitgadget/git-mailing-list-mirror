Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F29C1FF32
	for <e@80x24.org>; Mon, 16 Oct 2017 06:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdJPGzE (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 02:55:04 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:56069 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdJPGzC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 02:55:02 -0400
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 0580021143;
        Mon, 16 Oct 2017 02:54:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=C
        Gj3BjGUJdlZqlEV+MM3U3+RkWs=; b=L5KfQWJ5GLtqig1QMf+KpsCJrPhrA5loS
        TKtA57q+5XZcigPZ2cqBTcjNZlkIbCIT0gFvngFZw7oWxv4p4OMwsmoaaLtcuRTe
        2O6QHgoxdYxQr2QD0SQFgdxuyouti4kJlg61+IKdK9ELc0n3UOnZcgIECNGR+iod
        vze9dx9ypU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=VdA
        +siyDjwmv5BB05HqMgMkJ8JmBQhzdGAPKkj04zGMMpclIdgHaxVJPRsG55MZJun1
        pDKu3g9qKuFdcUKnHl5/woy3Zw8hp9jN3I/U/wT+5Vf67oRGZle2dd2WeacjJAx5
        m7oI1C6bo37llT9lQcdjGm47iT1Jht+SMjJZXisI=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id D14C621142;
        Mon, 16 Oct 2017 02:54:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBCA19C898;
        Mon, 16 Oct 2017 02:54:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2017, #03; Mon, 16)
X-master-at: 111ef79afe185f8731920569450f6a65320f5d5f
X-next-at: 2b38de12cc0e926ec9a73ad73767e578a81645ba
Date:   Mon, 16 Oct 2017 15:54:56 +0900
Message-ID: <xmqqefq3shtr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC31535A-B23E-11E7-94FF-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

2.15-rc1 has been tagged, but 2.15-rc2 is going to slip.  The topics
that are cooking in 'next' that are not urgent fixes are classified
as "Will cook in 'next'", and will not graduate to 'master' until
the final.

We haven't decided how to resolve the "git add -i" regression (see
the thread at
https://public-inbox.org/git/xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com/
for the two approaches), and 'next' has one of them ("demote
'always' to 'auto' when given to color.ui from the configuration
file"), while 'pu' has f6b2410f20 that takes a different approach
("It was a mistake to allow plumbing to pay attention to color.ui
config, so revert it to unbreak 'add -i'").

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jk/ui-color-always-to-auto-maint (2017-10-13) 2 commits
  (merged to 'next' on 2017-10-13 at bb16e1edc8)
 + color: document that "git -c color.*=always" is a bit special
 + color: downgrade "always" to "auto" only for on-disk configuration

 It turns out that "git -c color.ui=always cmd" is relied on by many
 third-party tools as a way to force coloured output no matter what
 the end-user configuration is, and a recent attempt to downgrade
 'always' to 'auto' to fix the regression to "git add -p" broke it.


* jk/ref-filter-colors-fix (2017-10-14) 4 commits
 - tag: respect color.ui config
 - Revert "color: check color.ui in git_default_config()"
 - Revert "t6006: drop "always" color config tests"
 - Revert "color: make "always" the same as "auto" in config"

 This is the "theoretically more correct" approach of simply
 stepping back to the state before plumbing commands started paying
 attention to "color.ui" configuration variable.


* jc/branch-name-sanity (2017-10-14) 3 commits
  (merged to 'next' on 2017-10-16 at 174646d1c3)
 + branch: forbid refs/heads/HEAD
 + branch: split validate_new_branchname() into two
 + branch: streamline "attr_only" handling in validate_new_branchname()

 "git branch" and "git checkout -b" are now forbidden from creating
 a branch whose name is "HEAD".

 Will cook in 'next'.


* jk/revision-pruning-optim (2017-10-14) 1 commit
  (merged to 'next' on 2017-10-16 at 2662baa21d)
 + revision: quit pruning diff more quickly when possible

 Pathspec-limited revision traversal was taught not to keep finding
 unneeded differences once it knows two trees are different inside
 given pathspec.

 Will cook in 'next'.


* js/rebase-i-final (2017-10-16) 1 commit
  (merged to 'next' on 2017-10-16 at 72362f5f9c)
 + sequencer.c: fix and unify error messages in rearrange_squash()

 Error message fix.

 Will merge to 'master'.


* wk/merge-options-gpg-sign-doc (2017-10-12) 1 commit
  (merged to 'next' on 2017-10-16 at ae61d824da)
 + Documentation/merge-options.txt: describe -S/--gpg-sign for 'pull'

 Doc updates.

 Will cook in 'next'.


* wk/pull-signoff (2017-10-13) 1 commit
  (merged to 'next' on 2017-10-16 at 5e48f349d9)
 + pull: pass --signoff/--no-signoff to "git merge"

 "git pull" has been taught to accept "--[no-]signoff" option and
 pass it down to "git merge".

 Will cook in 'next'.


* sb/diff-color-move (2017-10-16) 1 commit
  (merged to 'next' on 2017-10-16 at 69de1bad9d)
 + diff: fix infinite loop with --color-moved --ignore-space-change

 A recently added "--color-moved" feature of "diff" fell into
 infinite loop when ignoring whitespace changes, which has been
 fixed.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).


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

--------------------------------------------------
[Cooking]

* dm/run-command-ignored-hook-advise (2017-10-10) 1 commit
  (merged to 'next' on 2017-10-10 at 0827814922)
 + run-command: add hint when a hook is ignored

 A hook script that is set unexecutable is simply ignored.  Git
 notifies when such a file is ignored, unless the message is
 squelched via advice.ignoredHook configuration.

 Will cook in 'next'.


* hv/fetch-moved-submodules-on-demand (2017-10-08) 5 commits
 - DONTMERGE: mark failing tests for now
 - submodule: simplify decision tree whether to or not to fetch
 - implement fetching of moved submodules
 - change submodule push test to use proper repository setup
 - fetch: add test to make sure we stay backwards compatible

 WIP.


* js/for-each-ref-remote-name-and-ref (2017-10-11) 3 commits
 - for-each-ref: test :remotename and :remoteref
 - for-each-ref: let upstream/push optionally report the remote ref name
 - for-each-ref: let upstream/push optionally report the remote name

 The "--format=..." option "git for-each-ref" takes learned to show
 the name of the 'remote' repository and the ref at the remote side
 that is affected for 'upstream' and 'push' via "%(push:remotename)"
 and friends.

 Needs a bit more work on the documentation part?


* pb/bisect-helper (2017-10-06) 6 commits
  (merged to 'next' on 2017-10-13 at ffc9aefe63)
 + bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 + t6030: explicitly test for bisection cleanup
 + bisect--helper: `bisect_clean_state` shell function in C
 + bisect--helper: `write_terms` shell function in C
 + bisect--helper: rewrite `check_term_format` shell function in C
 + bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 An early part of piece-by-piece rewrite of "git bisect".

 Will cook in 'next'.


* bc/object-id (2017-10-16) 25 commits
 - refs/files-backend: convert static functions to object_id
 - refs: convert read_raw_ref backends to struct object_id
 - refs: convert peel_object to struct object_id
 - refs: convert resolve_ref_unsafe to struct object_id
 - worktree: convert struct worktree to object_id
 - refs: convert resolve_gitlink_ref to struct object_id
 - Convert remaining callers of resolve_gitlink_ref to object_id
 - sha1_file: convert index_path and index_fd to struct object_id
 - refs: convert reflog_expire parameter to struct object_id
 - refs: convert read_ref_at to struct object_id
 - refs: convert peel_ref to struct object_id
 - builtin/pack-objects: convert to struct object_id
 - pack-bitmap: convert traverse_bitmap_commit_list to object_id
 - refs: convert dwim_log to struct object_id
 - builtin/reflog: convert remaining unsigned char uses to object_id
 - refs: convert dwim_ref and expand_ref to struct object_id
 - refs: convert read_ref and read_ref_full to object_id
 - refs: convert resolve_refdup and refs_resolve_refdup to struct object_id
 - Convert check_connected to use struct object_id
 - refs: update ref transactions to use struct object_id
 - refs: prevent accidental NULL dereference in write_pseudoref
 - refs: convert update_ref and refs_update_ref to use struct object_id
 - refs: convert delete_ref and refs_delete_ref to struct object_id
 - refs/files-backend: convert struct ref_to_prune to object_id
 - walker: convert to struct object_id

 Conversion from uchar[20] to struct object_id continues.


* jc/no-cmd-as-subroutine (2017-10-11) 2 commits
  (merged to 'next' on 2017-10-16 at 5f4ee919ac)
 + merge-ours: do not use cmd_*() as a subroutine
 + describe: do not use cmd_*() as a subroutine

 Calling cmd_foo() as if it is a general purpose helper function is
 a no-no.  Correct two instances of such to set an example.

 Will cook in 'next'.


* jc/doc-checkout (2017-10-11) 1 commit
  (merged to 'next' on 2017-10-13 at c000f4bd84)
 + checkout doc: clarify command line args for "checkout paths" mode

 Doc update.

 Will merge to 'master'.


* jc/merge-symlink-ours-theirs (2017-09-26) 1 commit
 - merge: teach -Xours/-Xtheirs to symbolic link merge

 "git merge -Xours/-Xtheirs" learned to use our/their version when
 resolving a conflicting updates to a symbolic link.

 Needs review.


* jt/partial-clone-lazy-fetch (2017-10-02) 18 commits
 - fetch-pack: restore save_commit_buffer after use
 - unpack-trees: batch fetching of missing blobs
 - clone: configure blobmaxbytes in created repos
 - clone: support excluding large blobs
 - fetch: support excluding large blobs
 - fetch: refactor calculation of remote list
 - fetch-pack: support excluding large blobs
 - pack-objects: support --blob-max-bytes
 - pack-objects: rename want_.* to ignore_.*
 - gc: do not repack promisor packfiles
 - rev-list: support termination at promisor objects
 - sha1_file: support lazily fetching missing objects
 - introduce fetch-object: fetch one promisor object
 - index-pack: refactor writing of .keep files
 - fsck: support promisor objects as CLI argument
 - fsck: support referenced promisor objects
 - fsck: support refs pointing to promisor objects
 - fsck: introduce partialclone extension

 A journey for "git clone" and "git fetch" to become "lazier" by
 depending more on its remote repository---this is the beginning of
 it.

 Expecting a reroll.
 cf. <CAGf8dgLu-TeK8KbHv-U+18O+L2TxKcGv5vFFHy38J6a_YXRfew@mail.gmail.com>


* ma/lockfile-fixes (2017-10-07) 12 commits
  (merged to 'next' on 2017-10-16 at 19fae5c138)
 + read_cache: roll back lock in `update_index_if_able()`
 + read-cache: leave lock in right state in `write_locked_index()`
 + read-cache: drop explicit `CLOSE_LOCK`-flag
 + cache.h: document `write_locked_index()`
 + apply: remove `newfd` from `struct apply_state`
 + apply: move lockfile into `apply_state`
 + cache-tree: simplify locking logic
 + checkout-index: simplify locking logic
 + tempfile: fix documentation on `delete_tempfile()`
 + lockfile: fix documentation on `close_lock_file_gently()`
 + treewide: prefer lockfiles on the stack
 + sha1_file: do not leak `lock_file`

 An earlier update made it possible to use an on-stack in-core
 lockfile structure (as opposed to having to deliberately leak an
 on-heap one).  Many codepaths have been updated to take advantage
 of this new facility.

 Will cook in 'next'.


* ot/mru-on-list (2017-10-01) 1 commit
  (merged to 'next' on 2017-10-07 at e6ad4a16a2)
 + mru: use double-linked list from list.h

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 Will cook in 'next'.


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
 - git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.

 Needs a test, perhaps as a follow-up patch.


* mg/merge-base-fork-point (2017-09-17) 3 commits
 - merge-base: find fork-point outside partial reflog
 - merge-base: return fork-point outside reflog
 - t6010: test actual test output

 "merge-base --fork-point $branch $commit" is used to guess on which
 commit among the commits that were once at the tip of the $branch the
 $commit was built on top of, and it learns these historical tips from
 the reflog of the $branch.  When the true fork-point is lost due to
 pruning of old reflog entries, the command does not give any output,
 because it has no way to guess correctly and does not want to mislead
 the user with a wrong guess.

 The command has been updated to give the best but not known to be
 correct guess, based on a hope that a merge-base between $commit and a
 virtual merge across all the reflog entries that still are available
 for $branch may still be a closer to the true fork-point than the
 merge-base between $commit and the current tip of the $branch.

 This may have to be offered by an additional option, to allow the
 users that are prepared to see a potentially incorrect guess to opt
 into the feature, without affecting the current callers that may not
 be prepared to accept a guess that is not known to be correct.

 What's the doneness of this one?


* ds/find-unique-abbrev-optim (2017-10-13) 4 commits
  (merged to 'next' on 2017-10-16 at 7f4479ac52)
 + sha1_name: minimize OID comparisons during disambiguation
 + sha1_name: parse less while finding common prefix
 + sha1_name: unroll len loop in find_unique_abbrev_r()
 + p4211-line-log.sh: add log --online --raw --parents perf test

 Optimize the code to find shortest unique prefix of object names.

 Will cook in 'next'.


* cc/perf-run-config (2017-09-24) 9 commits
 - perf: store subsection results in "test-results/$GIT_PERF_SUBSECTION/"
 - perf/run: show name of rev being built
 - perf/run: add run_subsection()
 - perf/run: update get_var_from_env_or_config() for subsections
 - perf/run: add get_subsections()
 - perf/run: add calls to get_var_from_env_or_config()
 - perf/run: add GIT_PERF_DIRS_OR_REVS
 - perf/run: add get_var_from_env_or_config()
 - perf/run: add '--config' option to the 'run' script

 Needs review.


* bp/fsmonitor (2017-10-05) 15 commits
  (merged to 'next' on 2017-10-05 at 964a029d13)
 + fsmonitor: preserve utf8 filenames in fsmonitor-watchman log
 + fsmonitor: read entirety of watchman output
 + fsmonitor: MINGW support for watchman integration
  (merged to 'next' on 2017-10-02 at cf0c67979c)
 + fsmonitor: add a performance test
 + fsmonitor: add a sample integration script for Watchman
 + fsmonitor: add test cases for fsmonitor extension
 + split-index: disable the fsmonitor extension when running the split index test
 + fsmonitor: add a test tool to dump the index extension
 + update-index: add fsmonitor support to update-index
 + ls-files: Add support in ls-files to display the fsmonitor valid bit
 + fsmonitor: add documentation for the fsmonitor extension.
 + fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 + update-index: add a new --force-write-index option
 + preload-index: add override to enable testing preload-index
 + bswap: add 64 bit endianness helper get_be64

 We learned to talk to watchman to speed up "git status" and other
 operations that need to see which paths have been modified.

 Will cook in 'next'.


* bw/protocol-v1 (2017-10-04) 10 commits
 - ssh: introduce a 'simple' ssh variant
 - i5700: add interop test for protocol transition
 - http: tell server that the client understands v1
 - connect: tell server that the client understands v1
 - connect: teach client to recognize v1 server response
 - upload-pack, receive-pack: introduce protocol version 1
 - daemon: recognize hidden request arguments
 - protocol: introduce protocol extention mechanisms
 - pkt-line: add packet_write function
 - connect: in ref advertisement, shallows are last

 A new mechanism to upgrade the wire protocol in place is proposed
 and demonstrated that it works with the older versions of Git
 without harming them.

 Expecting a reroll.
 cf. <20171003214206.GY19555@aiede.mtv.corp.google.com>
 The tip one needs to clarify that it is not just '-o' but also '-p'
 option in the documentation.  Other than that, the approach taken
 by the series basically seems sane and well received.


* pc/submodule-helper (2017-10-07) 3 commits
  (merged to 'next' on 2017-10-16 at 2b38de12cc)
 + submodule: port submodule subcommand 'status' from shell to C
 + submodule--helper: introduce for_each_listed_submodule()
 + submodule--helper: introduce get_submodule_displaypath()

 GSoC.
 Will merge to 'master'.


* bc/hash-algo (2017-10-04) 6 commits
 - fixup! hash-algo: integrate hash algorithm support with repo setup
 - hash-algo: switch empty tree and blob lookups to use hash abstraction
 - hash-algo: integrate hash algorithm support with repo setup
 - hash-algo: add structure representing hash algorithm
 - setup: expose enumerated repo info
 - Merge branch 'bc/vcs-svn-cleanup' into bc/hash-algo

 RFC
 cf. <20170821000022.26729-1-sandals@crustytoothpaste.net>


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Will be rerolled after tc/curl-with-backports stabilizes.


* sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
 - Documentation/checkout: clarify submodule HEADs to be detached
 - recursive submodules: detach HEAD from new state

 "git checkout --recursive" may overwrite and rewind the history of
 the branch that happens to be checked out in submodule
 repositories, which might not be desirable.  Detach the HEAD but
 still allow the recursive checkout to succeed in such a case.

 Undecided.
 This needs justification in a larger picture; it is unclear why
 this is better than rejecting recursive checkout, for example.


* jk/check-ref-format-oor-fix (2017-07-14) 1 commit
 - check-ref-format: require a repository for --branch

 Discussion slowly continued but then stalled.
 cf. <20170717172709.GL93855@aiede.mtv.corp.google.com>
 cf. <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-08-14 at 24db08a6e8)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.
 As the draft RelNotes says, let's merge this to 'master' after
 this release cycle.

--------------------------------------------------
[Discarded]

* jc/ref-filter-colors-fix (2017-10-14) 2 commits
 . colors: git_default_config() does not read color.ui
 . Revert "color: check color.ui in git_default_config()"

 Recent tip of 'master' and 'maint' (at least as of v2.14.2) has a
 regression in "git add -p" for those who set ui.color=always in
 their configuration, caused by us being overly aggressive in
 allowing plumbing commands to honor the configuration to fix a
 fallout from an earlier change that made everybody, even the
 plumbing commands, to automatically color its output by default.
 Revert it for now from the released version (and to be released
 one) until we come up with a different fix to the problem.


* jc/allow-lazy-cas (2017-07-06) 1 commit
 . push: disable lazy --force-with-lease by default

 Because "git push --force-with-lease[=<ref>]" that relies on the
 stability of remote-tracking branches is unsafe when something
 fetches into the repository behind user's back, it is now disabled
 by default.  A new configuration variable can be used to enable it
 by users who know what they are doing.  This would pave the way to
 possibly turn `--force` into `--force-with-lease`.

 Will discard.
 Independent from disabling the feature by default, this stirred up
 a discussion to replace the DWIM heuristics with a better one, which
 deserves to be its own topic.
 cf. <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>


* sg/clone-refspec-from-command-line-config (2017-06-16) 2 commits
 . Documentation/clone: document ignored configuration variables
 . clone: respect additional configured fetch refspecs during initial fetch
 (this branch is used by sg/remote-no-string-refspecs.)

 "git clone -c var=val" is a way to set configuration variables in
 the resulting repository, but it is more useful to also make these
 variables take effect while the initial clone is happening,
 e.g. these configuration variables could be fetch refspecs.

 Got tired of waiting for a response.
 cf. <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
 cf. <xmqqmv8zhdap.fsf@gitster.mtv.corp.google.com>


* rs/sha1-file-micro-optim (2017-07-09) 2 commits
 . SQUASH???
 . sha1_file: add slash once in for_each_file_in_obj_subdir()

 Code cleanup.

 Perhaps drop.
 cf. <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>


* mg/merge-pre-merge-hook (2017-09-24) 4 commits
 - t7503: add tests for pre-merge-hook
 - merge: --no-verify to bypass pre-merge hook
 - merge: do no-verify like commit
 - git-merge: honor pre-merge hook

 "git merge" learned a 'pre-merge' hook, that would be triggered
 before the merge commit is created by a clean auto-merge.

 What's the doneness of this?  Is everybody happy?
