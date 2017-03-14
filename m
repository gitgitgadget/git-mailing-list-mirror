Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0AF20951
	for <e@80x24.org>; Tue, 14 Mar 2017 23:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbdCNXfy (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 19:35:54 -0400
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:61181 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdCNXfv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 19:35:51 -0400
Received: from pb-sasl-trial3.pobox.com (ro.sql.listbox.com [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 8D9E42E753;
        Tue, 14 Mar 2017 19:35:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=o
        flj5LD9OmH3mC1Tqixm/E1a0V8=; b=M7QLNlhuhdAYRISqlLkWAdZw6RjoM/pSC
        GQCBoQAwRkA+dIaqaQVx3BPAV+TG0rGYJyD2BSU+xae3A/k4lI11cSc/DgYs8EvM
        FB1z+SUc/kosrL2Slug/QFZWrQBCWZ3NzmMGp6v5v2O8EsrYOBwBWGPtfYOF/wCb
        apu6fa9zQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=WLe
        fkHA+DC6Gg7m/Kv4tBjDnfiRasTqKcgEKBtyP2EUxtIhE97gigMa7kILW0wPx6iO
        0yQbaCjoPfjntbGYMElDR/ZueXUmivVRqQyIp688sL1vdT2mcDgQssRJd2JkwSsQ
        8KtkO703+8mmpnEV3Gqj+l9eBgFtAMixx+d1VyZM=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 6BA1C2E752;
        Tue, 14 Mar 2017 19:35:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CA7F7374D;
        Tue, 14 Mar 2017 19:35:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2017, #06; Tue, 14)
X-master-at: 4a9b9b32d47212e4ea43cd1fa3c11afef6d4c491
X-next-at: 48829862c7ec047bdce13a3e5d758eb4d703d5b8
Date:   Tue, 14 Mar 2017 16:35:47 -0700
Message-ID: <xmqq4lyvh1nw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3FF70D2-090E-11E7-A156-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Among the topics merged to 'master' since v2.12 was tagged, 40+ of
them could be also merged to 'maint' (some of these are new features
and by default should not be, though).  Among them two are fixes for
regressions found in v2.12:

 * The patch subcommand of "git add -i" was meant to have paths
   selection prompt just like other subcommand, unlike "git add -p"
   directly jumps to hunk selection.  Recently, this was broken and
   "add -i" lost the paths selection dialog, but it now has been
   fixed.
   (merge c852bd54bd jk/add-i-patch-do-prompt later to maint).

 * Git v2.12 was shipped with an embarrassing breakage where various
   operations that verify paths given from the user stopped dying when
   seeing an issue, and instead later triggering segfault.
   (merge ce83eadd9a js/realpath-pathdup-fix later to maint).

These two have been merged to 'master' only a few days ago;
additional tests on 'master' to make sure they fix the issues, and
more importantly they do not introduce new regressions, are greatly
appreciated.  I am hoping we can merge them (and probably others)
to 'maint' to cut v2.12.1 by early next week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/cond-skip-tests (2017-03-01) 3 commits
  (merged to 'next' on 2017-03-10 at 38124fb5ce)
 + gitweb tests: skip tests when we don't have Time::HiRes
 + gitweb tests: change confusing "skip_all" phrasing
 + cvs tests: skip tests that call "cvs commit" when running as root

 A few tests were run conditionally under (rare) conditions where
 they cannot be run (like running cvs tests under 'root' account).


* dp/filter-branch-prune-empty (2017-03-03) 4 commits
  (merged to 'next' on 2017-03-10 at 9317e24cd3)
 + p7000: add test for filter-branch with --prune-empty
 + filter-branch: fix --prune-empty on parentless commits
 + t7003: ensure --prune-empty removes entire branch when applicable
 + t7003: ensure --prune-empty can prune root commit

 "git filter-branch --prune-empty" drops a single-parent commit that
 becomes a no-op, but did not drop a root commit whose tree is empty.


* ew/http-alternates-as-redirects-warning (2017-03-06) 2 commits
  (merged to 'next' on 2017-03-10 at 23be072a07)
 + http: release strbuf on disabled alternates
 + http: inform about alternates-as-redirects behavior

 Recent versions of Git treats http alternates (used in dumb http
 transport) just like HTTP redirects and requires the client to
 enable following it, due to security concerns.  But we forgot to
 give a warning when we decide not to honor the alternates.


* jk/interpret-branch-name (2017-03-02) 9 commits
  (merged to 'next' on 2017-03-10 at 95cc55f9a3)
 + checkout: restrict @-expansions when finding branch
 + strbuf_check_ref_format(): expand only local branches
 + branch: restrict @-expansions when deleting
 + t3204: test git-branch @-expansion corner cases
 + interpret_branch_name: allow callers to restrict expansions
 + strbuf_branchname: add docstring
 + strbuf_branchname: drop return value
 + interpret_branch_name: move docstring to header file
 + interpret_branch_name(): handle auto-namelen for @{-1}

 "git branch @" created refs/heads/@ as a branch, and in general the
 code that handled @{-1} and @{upstream} was a bit too loose in
 disambiguating.


* jk/push-deadlock-regression-fix (2017-03-07) 6 commits
  (merged to 'next' on 2017-03-10 at ceb0b819bf)
 + send-pack: report signal death of pack-objects
 + send-pack: read "unpack" status even on pack-objects failure
 + send-pack: improve unpack-status error messages
 + send-pack: use skip_prefix for parsing unpack status
 + send-pack: extract parsing of "unpack" response
 + receive-pack: fix deadlock when we cannot create tmpdir

 "git push" had a handful of codepaths that could lead to a deadlock
 when unexpected error happened, which has been fixed.


* js/travis-32bit-linux (2017-03-06) 1 commit
  (merged to 'next' on 2017-03-10 at 4cb69d0f77)
 + Travis: also test on 32-bit Linux

 Add 32-bit Linux variant to the set of platforms to be tested with
 Travis CI.


* jt/perf-updates (2017-03-03) 3 commits
  (merged to 'next' on 2017-03-10 at 0c0b124ed4)
 + t/perf: add fallback for pre-bin-wrappers versions of git
 + t/perf: use $MODERN_GIT for all repo-copying steps
 + t/perf: export variable used in other blocks

 The t/perf performance test suite was not prepared to test not so
 old versions of Git, but now it covers versions of Git that are not
 so ancient.


* kn/ref-filter-branch-list (2017-03-10) 1 commit
  (merged to 'next' on 2017-03-10 at 73b43443f1)
 + branch: honor --abbrev/--no-abbrev in --list mode

 "git branch --list" takes the "--abbrev" and "--no-abbrev" options
 to control the output of the object name in its "-v"(erbose)
 output, but a recent update started ignoring them; this fixes it
 before the breakage reaches to any released version.


* mm/fetch-show-error-message-on-unadvertised-object (2017-03-02) 3 commits
  (merged to 'next' on 2017-03-10 at 69e2023804)
 + fetch-pack: add specific error for fetching an unadvertised object
 + fetch_refs_via_pack: call report_unmatched_refs
 + fetch-pack: move code to report unmatched refs to a function

 "git fetch" that requests a commit by object name, when the other
 side does not allow such an request, failed without much
 explanation.

--------------------------------------------------
[New Topics]

* bw/submodule-is-active (2017-03-14) 10 commits
 - submodule add: respect submodule.active and submodule.<name>.active
 - submodule--helper init: set submodule.<name>.active
 - completion: clone can initialize specific submodules
 - clone: add --submodule-spec=<pathspec> switch
 - submodule update: add `--init-active` switch
 - submodule: decouple url and submodule existence
 - submodule--helper clone: check for configured submodules using helper
 - submodule sync: use submodule--helper is-active
 - submodule status: use submodule--helper is-active
 - submodule--helper: add is-active command

 "what URL do we want to update this submodule?" and "are we
 interested in this submodule?" are split into two distinct
 concepts, and then the way used to express the latter got extended,
 paving a way to make it easier to manage a project with many
 submodules and make it possible to later extend use of multiple
 worktrees for a project with submodules.

 This looks like almost ready for 'next' modulo minor niggles.


* jk/add-i-use-pathspecs (2017-03-14) 1 commit
  (merged to 'next' on 2017-03-14 at 13ce4d91e1)
 + add--interactive: do not expand pathspecs with ls-files

 "git add -p <pathspec>" unnecessarily expanded the pathspec to a
 list of individual files that matches the pathspec by running "git
 ls-files <pathspec>", before feeding it to "git diff-index" to see
 which paths have changes, because historically the pathspec
 language supported by "diff-index" was weaker.  These days they are
 equivalent and there is no reason to internally expand it.  This
 helps both performance and avoids command line argument limit on
 some platforms.

 Will merge to 'master'.


* mg/status-porcelain-no-i18n (2017-03-14) 1 commit
  (merged to 'next' on 2017-03-14 at 0955895825)
 + git-status: make porcelain more robust

 "git status --porcelain" is supposed to give a stable output, but a
 few strings were left as translatable by mistake.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* sg/completion-refs-speedup (2017-02-13) 13 commits
 - squash! completion: fill COMPREPLY directly when completing refs
 - completion: fill COMPREPLY directly when completing refs
 - completion: list only matching symbolic and pseudorefs when completing refs
 - completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
 - completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
 - completion: let 'for-each-ref' strip the remote name from remote branches
 - completion: let 'for-each-ref' and 'ls-remote' filter matching refs
 - completion: don't disambiguate short refs
 - completion: don't disambiguate tags and branches
 - completion: support excluding full refs
 - completion: support completing full refs after '--option=refs/<TAB>'
 - completion: wrap __git_refs() for better option parsing
 - completion: remove redundant __gitcomp_nl() options from _git_commit()

 The refs completion for large number of refs has been sped up,
 partly by giving up disambiguating ambiguous refs and partly by
 eliminating most of the shell processing between 'git for-each-ref'
 and 'ls-remote' and Bash's completion facility.

 What's the donness of this topic?


* nd/prune-in-worktree (2017-02-19) 15 commits
 . rev-list: expose and document --single-worktree
 . revision.c: --reflog add HEAD reflog from all worktrees
 . files-backend: make reflog iterator go through per-worktree reflog
 . refs: add refs_for_each_reflog[_ent]()
 . revision.c: --all adds HEAD from all worktrees
 . refs: remove dead for_each_*_submodule()
 . revision.c: use refs_for_each*() instead of for_each_*_submodule()
 . refs: add a refs_for_each_in() and friends
 . refs: add refs_for_each_ref()
 . refs: add refs_head_ref()
 . refs: add refs_read_ref[_full]()
 . refs: move submodule slash stripping code to get_submodule_ref_store
 . revision.c: --indexed-objects add objects from all worktrees
 . revision.c: refactor add_index_objects_to_pending()
 . revision.h: new flag in struct rev_info wrt. worktree-related refs
 (this branch uses nd/worktree-kill-parse-ref; is tangled with nd/files-backend-git-dir.)

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.


* nd/worktree-kill-parse-ref (2017-02-19) 22 commits
 . refs: kill set_worktree_head_symref()
 . refs: add refs_create_symref()
 . worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
 . refs.c: add refs_resolve_ref_unsafe()
 . refs: introduce get_worktree_ref_store()
 . refs: rename get_ref_store() to get_submodule_ref_store() and make it public
 . files-backend: remove submodule_allowed from files_downcast()
 . refs: move submodule code out of files-backend.c
 . path.c: move some code out of strbuf_git_path_submodule()
 . refs.c: make get_main_ref_store() public and use it
 . refs.c: kill register_ref_store(), add register_submodule_ref_store()
 . refs.c: flatten get_ref_store() a bit
 . refs: rename lookup_ref_store() to lookup_submodule_ref_store()
 . refs.c: introduce get_main_ref_store()
 . files-backend: remove the use of git_path()
 . refs.c: share is_per_worktree_ref() to files-backend.c
 . files-backend: replace *git_path*() with files_path()
 . files-backend: add files_path()
 . files-backend: convert git_path() to strbuf_git_path()
 . refs-internal.c: make files_log_ref_write() static
 . Merge branch 'mh/ref-remove-empty-directory' into nd/files-backend-git-dir
 . Merge branch 'mh/submodule-hash' into nd/files-backend-git-dir
 (this branch is used by nd/prune-in-worktree; is tangled with nd/files-backend-git-dir.)

 (hopefully) a beginning of safer "git worktree" that is resistant
 to "gc".

 Waiting for nd/files-backend-git-dir to settle.


* nd/files-backend-git-dir (2017-02-22) 26 commits
 . t1406: new tests for submodule ref store
 . t1405: some basic tests on main ref store
 . t/helper: add test-ref-store to test ref-store functions
 . refs: delete pack_refs() in favor of refs_pack_refs()
 . files-backend: avoid ref api targetting main ref store
 . refs: new transaction related ref-store api
 . refs: add new ref-store api
 . refs: rename get_ref_store() to get_submodule_ref_store() and make it public
 . files-backend: replace submodule_allowed check in files_downcast()
 . refs: move submodule code out of files-backend.c
 . path.c: move some code out of strbuf_git_path_submodule()
 . refs.c: make get_main_ref_store() public and use it
 . refs.c: kill register_ref_store(), add register_submodule_ref_store()
 . refs.c: flatten get_ref_store() a bit
 . refs: rename lookup_ref_store() to lookup_submodule_ref_store()
 . refs.c: introduce get_main_ref_store()
 . files-backend: remove the use of git_path()
 . files-backend: add and use files_refname_path()
 . files-backend: add and use files_reflog_path()
 . files-backend: move "logs/" out of TMP_RENAMED_LOG
 . files-backend: convert git_path() to strbuf_git_path()
 . files-backend: add and use files_packed_refs_path()
 . files-backend: make files_log_ref_write() static
 . refs.h: add forward declaration for structs used in this file
 . Merge branch 'mh/ref-remove-empty-directory' into nd/files-backend-git-dir
 . Merge branch 'mh/submodule-hash' into nd/files-backend-git-dir
 (this branch is tangled with nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 The "submodule" specific field in the ref_store structure is
 replaced with a more generic "gitdir" that can later be used also
 when dealing with ref_store that represents the set of refs visible
 from the other worktrees.


* nd/worktree-move (2017-01-27) 7 commits
 . fixup! worktree move: new command
 . worktree remove: new command
 . worktree move: refuse to move worktrees with submodules
 . worktree move: accept destination as directory
 . worktree move: new command
 . worktree.c: add update_worktree_location()
 . worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Tentatively ejected as it seems to break 'pu' when merged.


* pb/bisect (2017-02-18) 28 commits
 - fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: remove the dequote in bisect_start()
 - bisect--helper: retire `--bisect-auto-next` subcommand
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--bisect-write` subcommand
 - bisect--helper: `bisect_replay` shell function in C
 - bisect--helper: `bisect_log` shell function in C
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: `bisect_state` & `bisect_head` shell function in C
 - bisect--helper: `bisect_autostart` shell function in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 - t6030: no cleanup with bad merge base
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Expecting a reroll.
 cf. <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
 cf. <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>
 cf. <CAFZEwPNUXcNY9Qdz=_B7q2kQuaecPzJtTMGdv8YMUPEz2vnp8A@mail.gmail.com>


* sh/grep-tree-obj-tweak-output (2017-01-20) 2 commits
 - grep: use '/' delimiter for paths
 - grep: only add delimiter if there isn't one already

 "git grep", when fed a tree-ish as an input, shows each hit
 prefixed with "<tree-ish>:<path>:<lineno>:".  As <tree-ish> is
 almost always either a commit or a tag that points at a commit, the
 early part of the output "<tree-ish>:<path>" can be used as the
 name of the blob and given to "git show".  When <tree-ish> is a
 tree given in the extended SHA-1 syntax (e.g. "<commit>:", or
 "<commit>:<dir>"), however, this results in a string that does not
 name a blob (e.g. "<commit>::<path>" or "<commit>:<dir>:<path>").
 "git grep" has been taught to be a bit more intelligent about these
 cases and omit a colon (in the former case) or use slash (in the
 latter case) to produce "<commit>:<path>" and
 "<commit>:<dir>/<path>" that can be used as the name of a blob.

 Expecting a reroll?  Is this good enough with known limitations?


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

* ab/ref-filter-no-contains (2017-03-11) 1 commit
 - ref-filter: add --no-contains option to tag/branch/for-each-ref
 (this branch uses jk/ref-filter-flags-cleanup.)

 "git tag/branch/for-each-ref" family of commands long allowed to
 filter the refs by "--contains X" (show only the refs that are
 descendants of X), "--merged X" (show only the refs that are
 ancestors of X), "--no-merged X" (show only the refs that are not
 ancestors of X).  One curious omission, "--no-contains X" (show
 only the refs that are not descendants of X) has been added to
 them.

 Expecting a reroll.
 cf. <CACBZZX4v49zfyGVpcxGSKsxbMfVaUcGHtitpfaZMUtG82YzW-g@mail.gmail.com>
 The topic is almost there.


* bc/sha1-header-selection-with-cpp-macros (2017-03-14) 1 commit
  (merged to 'next' on 2017-03-14 at 60bf8c5822)
 + hash.h: move SHA-1 implementation selection into a header file

 Our source code has used the SHA1_HEADER cpp macro after "#include"
 in the C code to switch among the SHA-1 implementations. Instead,
 list the exact header file names and switch among implementations
 using "#ifdef BLK_SHA1/#include "block-sha1/sha1.h"/.../#endif";
 this helps some IDE tools.

 Will merge to 'master'.


* bw/attr-pathspec (2017-03-13) 2 commits
  (merged to 'next' on 2017-03-14 at 3af5d6c1fc)
 + pathspec: allow escaped query values
 + pathspec: allow querying for attributes

 The pathspec mechanism learned to further limit the paths that
 match the pattern to those that have specified attributes attached
 via the gitattributes mechanism.

 Will merge to 'master'.


* jk/http-walker-buffer-underflow-fix (2017-03-13) 1 commit
  (merged to 'next' on 2017-03-14 at 02020b475d)
 + http-walker: fix buffer underflow processing remote alternates

 "Dumb http" transport used to misparse a nonsense http-alternates
 response, which has been fixed.

 Will merge to 'master'.


* rs/blame-code-cleanup (2017-03-11) 1 commit
  (merged to 'next' on 2017-03-12 at 8fd4bf325a)
 + blame: move blame_entry duplication to add_blame_entry()

 Code clean-up.

 Will merge to 'master'.


* dl/credential-cache-socket-in-xdg-cache (2017-03-13) 1 commit
 - path.c: add xdg_cache_home

 The default location "~/.git-credential-cache/socket" for the
 socket used to communicate with the credential-cache daemon has
 been moved to "~/.cache/git/credential/socket".

 Waiting for a reroll.
 The patches do not yet match the above description without
 the second one that is not queued here.


* jk/ref-filter-flags-cleanup (2017-03-10) 4 commits
  (merged to 'next' on 2017-03-14 at c335c9cf6e)
 + ref-filter: use separate cache for contains_tag_algo
 + ref-filter: die on parse_commit errors
 + ref-filter: use contains_result enum consistently
 + ref-filter: move ref_cbdata definition into ref-filter.c
 (this branch is used by ab/ref-filter-no-contains.)

 "git tag --contains" used to (ab)use the object bits to keep track
 of the state of object reachability without clearing them after
 use; this has been cleaned up and made to use the newer commit-slab
 facility.

 Will merge to 'master'.


* sb/rev-parse-show-superproject-root (2017-03-08) 1 commit
  (merged to 'next' on 2017-03-14 at 537c299db6)
 + rev-parse: add --show-superproject-working-tree

 From a working tree of a repository, a new option of "rev-parse"
 lets you ask if the repository is used as a submodule of another
 project, and where the root level of the working tree of that
 project (i.e. your superproject) is.

 Will merge to 'master'.


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 What's the status of this one???

 cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>


* js/early-config (2017-03-14) 12 commits
  (merged to 'next' on 2017-03-14 at ce43b4a309)
 + setup.c: mention unresolved problems
 + t1309: document cases where we would want early config not to die()
 + setup_git_directory_gently_1(): avoid die()ing
 + t1309: test read_early_config()
 + read_early_config(): really discover .git/
 + read_early_config(): avoid .git/config hack when unneeded
 + setup: make read_early_config() reusable
 + setup: introduce the discover_git_directory() function
 + setup_git_directory_1(): avoid changing global state
 + setup: prepare setup_discovered_git_dir() for the root directory
 + setup_git_directory(): use is_dir_sep() helper
 + t7006: replace dubious test

 The start-up sequence of "git" needs to figure out some configured
 settings before it finds and set itself up in the location of the
 repository and was quite messy due to its "chicken-and-egg" nature.
 The code has been restructured.

 Will merge to 'master'.


* jk/sha1dc (2017-03-01) 7 commits
 - Put sha1dc on a diet
 - sha1dc: avoid 'for' loop initial decl
 - sha1dc: resurrect LICENSE file
 - sha1dc: avoid c99 declaration-after-statement
 - Makefile: add USE_SHA1DC knob
 - sha1dc: adjust header includes for git
 - add collision-detecting sha1 implementation

 Borrow "detect attempt to create collisions" variant of SHA-1
 implementation by Marc Stevens (CWI) and Dan Shumow (Microsoft).

 Expecting a cleaned-up reroll after discussion settles.
 cf. <CA+55aFxTWqsTTiDKo4DBZT-8Z9t80bGMD3uijzKONa_bYEZABQ@mail.gmail.com>


* nd/conditional-config-include (2017-03-11) 3 commits
 - config: add conditional include
 - config.txt: reflow the second include.path paragraph
 - config.txt: clarify multiple key values in include.path

 The configuration file learned a new "includeIf.<condition>.path"
 that includes the contents of the given path only when the
 condition holds.  This allows you to say "include this work-related
 bit only in the repositories under my ~/work/ directory".

 Will merge to 'next' after squashing niggle-fixes in.


* cc/split-index-config (2017-03-06) 22 commits
  (merged to 'next' on 2017-03-12 at 53cdc2016d)
 + Documentation/git-update-index: explain splitIndex.*
 + Documentation/config: add splitIndex.sharedIndexExpire
 + read-cache: use freshen_shared_index() in read_index_from()
 + read-cache: refactor read_index_from()
 + t1700: test shared index file expiration
 + read-cache: unlink old sharedindex files
 + config: add git_config_get_expiry() from gc.c
 + read-cache: touch shared index files when used
 + sha1_file: make check_and_freshen_file() non static
 + Documentation/config: add splitIndex.maxPercentChange
 + t1700: add tests for splitIndex.maxPercentChange
 + read-cache: regenerate shared index if necessary
 + config: add git_config_get_max_percent_split_change()
 + Documentation/git-update-index: talk about core.splitIndex config var
 + Documentation/config: add information for core.splitIndex
 + t1700: add tests for core.splitIndex
 + update-index: warn in case of split-index incoherency
 + read-cache: add and then use tweak_split_index()
 + split-index: add {add,remove}_split_index() functions
 + config: add git_config_get_split_index()
 + t1700: change here document style
 + config: mark an error message up for translation

 The experimental "split index" feature has gained a few
 configuration variables to make it easier to use.

 Will merge to 'master'.


* jk/interop-test (2017-03-10) 2 commits
  (merged to 'next' on 2017-03-12 at 704b328022)
 + t/interop: add test of old clients against modern git-daemon
 + t: add an interoperability test harness

 Picking two versions of Git and running tests to make sure the
 older one and the newer one interoperate happily has now become
 possible.

 Will merge to 'master'.


* sg/clone-refspec-from-command-line-config (2017-02-27) 1 commit
 - clone: respect configured fetch respecs during initial fetch

 Expecting a reroll.
 cf. <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 cf. <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>


* sk/dash-is-previous (2017-03-01) 5 commits
 - revert.c: delegate handling of "-" shorthand to setup_revisions
 - sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
 - revision.c: args starting with "-" might be a revision
 - revision.c: swap if/else blocks
 - revision.c: do not update argv with unknown option

 A dash "-" can be written to mean "the branch that was previously
 checked out" in more places.

 Needs review.
 cf. <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>


* jh/memihash-opt (2017-02-17) 5 commits
 - name-hash: remember previous dir_entry during lazy_init_name_hash
 - name-hash: specify initial size for istate.dir_hash table
 - name-hash: precompute hash values during preload-index
 - hashmap: allow memihash computation to be continued
 - name-hash: eliminate duplicate memihash call

 Expecting an update for perf.
 cf. <MWHPR03MB29581B0EDDEDCA7D51EC396F8A280@MWHPR03MB2958.namprd03.prod.outlook.com>


* sb/checkout-recurse-submodules (2017-03-11) 18 commits
 - submodule--helper.c: remove duplicate code
 - builtin/read-tree: add --recurse-submodules switch
 - builtin/checkout: add --recurse-submodules switch
 - entry.c: create submodules when interesting
 - unpack-trees: check if we can perform the operation for submodules
 - unpack-trees: pass old oid to verify_clean_submodule
 - update submodules: add submodule_move_head
 - update submodules: move up prepare_submodule_repo_env
 - submodules: introduce check to see whether to touch a submodule
 - update submodules: add a config option to determine if submodules are updated
 - update submodules: add submodule config parsing
 - connect_work_tree_and_git_dir: safely create leading directories
 - make is_submodule_populated gently
 - lib-submodule-update.sh: define tests for recursing into submodules
 - lib-submodule-update.sh: replace sha1 by hash
 - lib-submodule-update: teach test_submodule_content the -C <dir> flag
 - lib-submodule-update.sh: do not use ./. as submodule remote
 - lib-submodule-update.sh: reorder create_lib_submodule_repo

 "git checkout" is taught --recurse-submodules option.


* bc/object-id (2017-02-22) 19 commits
  (merged to 'next' on 2017-03-14 at 0b3ec5a05e)
 + wt-status: convert to struct object_id
 + builtin/merge-base: convert to struct object_id
 + Convert object iteration callbacks to struct object_id
 + sha1_file: introduce an nth_packed_object_oid function
 + refs: simplify parsing of reflog entries
 + refs: convert each_reflog_ent_fn to struct object_id
 + reflog-walk: convert struct reflog_info to struct object_id
 + builtin/replace: convert to struct object_id
 + Convert remaining callers of resolve_refdup to object_id
 + builtin/merge: convert to struct object_id
 + builtin/clone: convert to struct object_id
 + builtin/branch: convert to struct object_id
 + builtin/grep: convert to struct object_id
 + builtin/fmt-merge-message: convert to struct object_id
 + builtin/fast-export: convert to struct object_id
 + builtin/describe: convert to struct object_id
 + builtin/diff-tree: convert to struct object_id
 + builtin/commit: convert to struct object_id
 + hex: introduce parse_oid_hex

 "uchar [40]" to "struct object_id" conversion continues.

 Will merge to 'master'.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2017-02-27 at 7373a1b73d)
 + setup_git_env: avoid blind fall-back to ".git"

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2017-02-27 at 2c0f5f73d8)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will cook in 'next'.


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

--------------------------------------------------
[Discarded]

* jk/auto-namelen-in-interpret-branch-name (2017-02-27) 1 commit
 . interpret_branch_name(): handle auto-namelen for @{-1}

 A small bug in the code that parses @{...} has been fixed.

 This is now a part of jk/interpret-branch-name topic.


* jt/mark-tree-uninteresting-for-uninteresting-commit (2017-02-28) 3 commits
 . upload-pack: compute blob reachability correctly
 . revision: exclude trees/blobs given commit
 . revision: unify {tree,blob}_objects in rev_info

 The revision/object traversal machinery did not mark all tree and
 blob objects that are contained in an uninteresting commit as
 uninteresting, because that is quite costly.  Instead, it only
 marked those that are contained in an uninteresting boundary commit
 as uninteresting.

 Retracted.
