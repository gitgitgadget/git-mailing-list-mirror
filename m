Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2855E53
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436795; cv=none; b=IVTLGjLJJB5fGDoD84x4IbNuczQ+9VdMO1SeBx6GI0owCV3wElSyXz2oebyGSZTjHy8+wSGpd5PEjPH6D9Q4NNmGbxhfqcceJ3nWq0WBa0zymUc0cGeOvMQSMZSv6mOg2obuMZ09fDXShdlAvtMZp0ts8d4qR86utvd+KBSmg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436795; c=relaxed/simple;
	bh=V5H211I9ToP5s10E71/jSEvymU9jFvSNqgAsV0gU05I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=At9Io9/u9qS7j1pcrK57CYFBpAvxcTlp2X2djiylsO3pI8RNF8bY3MidoOCdikJpLEtqKf48GXkTwgAT52gVWovZKIj/ZaK8nUMXV1EPn27yHPFtqxBSObp/+R+h88NXGNRQaFeKCHQAqhfOsJZlwnGf5n6amoOiQ5xKmJlxGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O2jlYeQs; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O2jlYeQs"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CB622C15B;
	Fri, 23 Aug 2024 14:13:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=V
	5H211I9ToP5s10E71/jSEvymU9jFvSNqgAsV0gU05I=; b=O2jlYeQsur9kyfUUO
	96sKixRUSASA9WkUgHPnci77ltDGcQrywIPwicap63n5nvdtYqO1S5ONq37Zzgq2
	jy3hcIchPjdTSnaV160asGauoP9FPD2k2WKXq0XNE4oRAsbx1dgH9dwPBVAFZjwk
	1K603ajEfpe9Jp7ST8qktszi8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 726F32C15A;
	Fri, 23 Aug 2024 14:13:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B18F92C159;
	Fri, 23 Aug 2024 14:13:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2024, #09; Fri, 23)
X-master-at: 6a09c36371cbb902c573aee38d7cfd38f884f448
X-next-at: ac735039a0b08a95923f47bbd2c235c5d9005b93
Date: Fri, 23 Aug 2024 11:13:09 -0700
Message-ID: <xmqqwmk7nm4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5B0150DA-617B-11EF-A8DA-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Among the topics that were sent to the list but not in 'next', there
are a few (conceptual) biggies like the Rust binding, clar unit test
framework, and documentation mark-up with s:[], that may need
further discussion.  There also are topics that are not covered well
by reviewers (yet).

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-scm/git/

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

* cp/unit-test-reftable-readwrite (2024-08-13) 4 commits
  (merged to 'next' on 2024-08-16 at 8d68f73455)
 + t-reftable-readwrite: add test for known error
 + t-reftable-readwrite: use 'for' in place of infinite 'while' loops
 + t-reftable-readwrite: use free_names() instead of a for loop
 + t: move reftable/readwrite_test.c to the unit testing framework

 Will merge to 'master'.
 source: <20240813144440.4602-1-chandrapratap3519@gmail.com>


* ps/config-wo-the-repository (2024-08-13) 21 commits
  (merged to 'next' on 2024-08-16 at 3d5462a90e)
 + config: hide functions using `the_repository` by default
 + global: prepare for hiding away repo-less config functions
 + config: don't depend on `the_repository` with branch conditions
 + config: don't have setters depend on `the_repository`
 + config: pass repo to functions that rename or copy sections
 + config: pass repo to `git_die_config()`
 + config: pass repo to `git_config_get_expiry_in_days()`
 + config: pass repo to `git_config_get_expiry()`
 + config: pass repo to `git_config_get_max_percent_split_change()`
 + config: pass repo to `git_config_get_split_index()`
 + config: pass repo to `git_config_get_index_threads()`
 + config: expose `repo_config_clear()`
 + config: introduce missing setters that take repo as parameter
 + path: hide functions using `the_repository` by default
 + path: stop relying on `the_repository` in `worktree_git_path()`
 + path: stop relying on `the_repository` when reporting garbage
 + hooks: remove implicit dependency on `the_repository`
 + editor: do not rely on `the_repository` for interactive edits
 + path: expose `do_git_common_path()` as `repo_common_pathv()`
 + path: expose `do_git_path()` as `repo_git_pathv()`
 + Merge branch 'ps/refs-wo-the-repository' into ps/config-wo-the-repository

 Use of API functions that implicitly depend on the_repository
 object in the config subsystem has been rewritten to pass a
 repository object through the call chain.
 source: <cover.1723540226.git.ps@pks.im>


* ps/hash-and-ref-format-from-config (2024-08-16) 5 commits
  (merged to 'next' on 2024-08-16 at 2028c02d01)
 + setup: make ref storage format configurable via config
 + setup: make object format configurable via config
 + setup: merge configuration of repository formats
 + t0001: delete repositories when object format tests finish
 + t0001: exercise initialization with ref formats more thoroughly

 The default object hash and ref backend format used to be settable
 only with explicit command line option to "git init" and
 environment variables, but now they can be configured in the user's
 global and system wide configuration.
 source: <cover.1723798388.git.ps@pks.im>


* ps/leakfixes-part-4 (2024-08-14) 23 commits
  (merged to 'next' on 2024-08-16 at 37502271ec)
 + builtin/diff: free symmetric diff members
 + diff: free state populated via options
 + builtin/log: fix leak when showing converted blob contents
 + userdiff: fix leaking memory for configured diff drivers
 + builtin/format-patch: fix various trivial memory leaks
 + diff: fix leak when parsing invalid ignore regex option
 + unpack-trees: clear index when not propagating it
 + sequencer: release todo list on error paths
 + merge-ort: unconditionally release attributes index
 + builtin/fast-export: plug leaking tag names
 + builtin/fast-export: fix leaking diff options
 + builtin/fast-import: plug trivial memory leaks
 + builtin/notes: fix leaking `struct notes_tree` when merging notes
 + builtin/rebase: fix leaking `commit.gpgsign` value
 + config: fix leaking comment character config
 + submodule-config: fix leaking name entry when traversing submodules
 + read-cache: fix leaking hashfile when writing index fails
 + bulk-checkin: fix leaking state TODO
 + object-name: fix leaking symlink paths in object context
 + object-file: fix memory leak when reading corrupted headers
 + git: fix leaking system paths
 + remote: plug memory leak when aliasing URLs
 + Merge branch 'ps/leakfixes-part-3' into ps/leakfixes-part-4
 (this branch is used by ps/leakfixes-part-5.)

 More leak fixes.
 source: <cover.1723614263.git.ps@pks.im>


* ps/stash-keep-untrack-empty-fix (2024-08-16) 1 commit
  (merged to 'next' on 2024-08-16 at 3db6b6a815)
 + builtin/stash: fix `--keep-index --include-untracked` with empty HEAD

 A corner case bug in "git stash" was fixed.
 source: <6067675b5edf36e2eb28e98119a1c02d0a7ae670.1723804926.git.ps@pks.im>

--------------------------------------------------
[New Topics]

* dh/runtime-prefix-on-zos (2024-08-22) 1 commit
 - exec_cmd: RUNTIME_PREFIX on z/OS systems

 Support for the RUNTIME_PREFIX feature has been added to z/OS port.

 Will merge to 'next'.
 source: <pull.1769.git.git.1724334732249.gitgitgadget@gmail.com>


* ds/sparse-diff-index (2024-08-22) 1 commit
  (merged to 'next' on 2024-08-23 at d33f670977)
 + diff-index: integrate with the sparse index

 The underlying machinery for "git diff-index" has long been made to
 expand the sparse index as needed, but the command fully expanded
 the sparse index upfront, which now has been taught not to do.

 Will merge to 'master'.
 source: <pull.1777.git.1724342607793.gitgitgadget@gmail.com>


* cl/config-regexp-docfix (2024-08-23) 1 commit
 - doc: replace 3 dash with correct 2 dash in git-config(1)

 Docfix.

 Will merge to 'next'.
 source: <20240823-fix-doc-regexp-v2-1-e4eafdd60378@gmail.com>


* aa/cat-file-batch-output-doc (2024-08-22) 1 commit
 - docs: explain the order of output in the batched mode of git-cat-file(1)

 Docfix.

 Will merge to 'next'.
 source: <pull.1768.v3.git.git.1724356231639.gitgitgadget@gmail.com>


* js/fetch-push-trace2-annotation (2024-08-22) 3 commits
 - send-pack: add new tracing regions for push
 - fetch: add top-level trace2 regions
 - trace2: implement trace2_printf() for event target

 More trace2 events at key points on push and fetch code paths have
 been added.

 Will merge to 'next'.
 source: <cover.1724363615.git.steadmon@google.com>

--------------------------------------------------
[Stalled]

* pp/add-parse-range-unit-test (2024-05-27) 1 commit
 - apply: add unit tests for parse_range

 A unit test for code that parses the hunk offset and length from a
 patch fragment header as been added.

 Expecting a reroll.
 cf. <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
 source: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* jk/send-email-mailmap (2024-08-20) 3 commits
 - send-email: add mailmap support via sendemail.mailmap and --mailmap
 - check-mailmap: add options for additional mailmap sources
 - check-mailmap: accept "user@host" contacts

 "git send-email" learned "--mailmap" option to allow rewriting the
 recipient addresses.

 Expecting a reroll.
 cf. <3e4ba368-ab44-4940-856a-800e0ba7ff9f@intel.com>
 source: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>


* ps/leakfixes-part-5 (2024-08-22) 21 commits
 - transport: fix leaking negotiation tips
 - transport: fix leaking arguments when fetching from bundle
 - builtin/fetch: fix leaking transaction with `--atomic`
 - remote: fix leaking peer ref when expanding refmap
 - remote: fix leaks when matching refspecs
 - remote: fix leaking config strings
 - builtin/fetch-pack: fix leaking refs
 - sideband: fix leaks when configuring sideband colors
 - builtin/send-pack: fix leaking refspecs
 - transport: fix leaking OID arrays in git:// transport data
 - t/helper: fix leaking multi-pack-indices in "read-midx"
 - builtin/repack: fix leaks when computing packs to repack
 - midx-write: fix leaking hashfile on error cases
 - builtin/archive: fix leaking `OPT_FILENAME()` value
 - builtin/upload-archive: fix leaking args passed to `write_archive()`
 - builtin/merge-tree: fix leaking `-X` strategy options
 - pretty: fix leaking key/value separator buffer
 - pretty: fix memory leaks when parsing pretty formats
 - convert: fix leaks when resetting attributes
 - mailinfo: fix leaking header data
 - Merge branch 'ps/leakfixes-part-4' into ps/leakfixes-part-5

 Even more leak fixes.

 Will merge to 'next'.
 source: <cover.1724315484.git.ps@pks.im>


* sj/ref-contents-check (2024-08-20) 4 commits
 - ref: add symlink ref consistency check for files backend
 - ref: add symbolic ref content check for files backend
 - ref: add regular ref content check for files backend
 - fsck: introduce "FSCK_REF_REPORT_DEFAULT" macro

 Plumb through extra checks in refs API to "git fsck".

 Expecting a reroll.
 source: <ZsIMc6cJ-kzMzW_8@ArchLinux>


* jc/coding-style-c-operator-with-spaces (2024-08-20) 1 commit
  (merged to 'next' on 2024-08-21 at 36bbb9022a)
 + CodingGuidelines: spaces around C operators

 Write down whitespacing rules around C opeators.

 Will merge to 'master'.
 source: <xmqq7ccb6if8.fsf@gitster.g>


* jc/mailinfo-header-cleanup (2024-08-20) 1 commit
 - mailinfo: we parse fixed headers

 Code clean-up.

 On hold.
 cf. <Zsb1rGQbglHMiBHI@tanuki>
 source: <xmqq1q2i6gw7.fsf@gitster.g>


* jk/mark-unused-parameters (2024-08-20) 16 commits
  (merged to 'next' on 2024-08-20 at 610d16d751)
 + t-hashmap: stop calling setup() for t_intern() test
  (merged to 'next' on 2024-08-19 at f85d6096c9)
 + scalar: mark unused parameters in dummy function
 + daemon: mark unused parameters in non-posix fallbacks
 + setup: mark unused parameter in config callback
 + test-mergesort: mark unused parameters in trivial callback
 + t-hashmap: mark unused parameters in callback function
 + reftable: mark unused parameters in virtual functions
 + reftable: drop obsolete test function declarations
 + reftable: ignore unused argc/argv in test functions
 + unit-tests: ignore unused argc/argv
 + t/helper: mark more unused argv/argc arguments
 + oss-fuzz: mark unused argv/argc argument
 + refs: mark unused parameters in do_for_each_reflog_helper()
 + refs: mark unused parameters in ref_store fsck callbacks
 + update-ref: mark more unused parameters in parser callbacks
 + imap-send: mark unused parameter in ssl_socket_connect() fallback

 Mark unused parameters as UNUSED to squelch -Wunused warnings.

 Will merge to 'master'.
 source: <20240817082101.GA6761@coredump.intra.peff.net>


* jk/drop-unused-parameters (2024-08-17) 5 commits
  (merged to 'next' on 2024-08-19 at f5c703013d)
 + diff-lib: drop unused index argument from get_stat_data()
 + ref-filter: drop unused parameters from email_atom_option_parser()
 + pack-bitmap: drop unused parameters from select_pseudo_merges()
 + pack-bitmap: load writer config from repository parameter
 + refs: drop some unused parameters from create_symref_lock()

 Drop unused parameters from functions.

 Will merge to 'master'.
 source: <20240817072621.GA1535666@coredump.intra.peff.net>


* ps/maintenance-detach-fix-more (2024-08-21) 3 commits
  (merged to 'next' on 2024-08-22 at cbb6723488)
 + builtin/maintenance: fix loose objects task emitting pack hash
 + t7900: exercise detaching via trace2 regions
 + t7900: fix flaky test due to leaking background job
 (this branch uses ps/maintenance-detach-fix.)

 A tests for "git maintenance" that were broken on Windows have been
 corrected.

 Will merge to 'master'.
 cf. <ZsbPiGJlgxWiM-t9@tanuki>
 source: <cover.1724053639.git.ps@pks.im>


* ps/reftable-concurrent-compaction (2024-08-23) 11 commits
 - reftable/stack: fix segfault when reload with reused readers fails
 - reftable/stack: reorder swapping in the reloaded stack contents
 - reftable/reader: keep readers alive during iteration
 - reftable/reader: introduce refcounting
 - reftable/stack: fix broken refnames in `write_n_ref_tables()`
 - reftable/reader: inline `reader_close()`
 - reftable/reader: inline `init_reader()`
 - reftable/reader: rename `reftable_new_reader()`
 - reftable/stack: inline `stack_compact_range_stats()`
 - reftable/blocksource: drop malloc block source
 - Merge branch 'ps/reftable-drop-generic' into ps/reftable-concurrent-compaction
 (this branch uses ps/reftable-drop-generic.)

 The code path for compacting reftable files saw some bugfixes
 against concurrent operation.

 Will merge to 'next'.
 source: <cover.1724420744.git.ps@pks.im>


* ah/git-prompt-portability (2024-08-20) 8 commits
  (merged to 'next' on 2024-08-21 at 14fa411577)
 + git-prompt: support custom 0-width PS1 markers
 + git-prompt: ta-da! document usage in other shells
 + git-prompt: don't use shell $'...'
 + git-prompt: add some missing quotes
 + git-prompt: replace [[...]] with standard code
 + git-prompt: don't use shell arrays
 + git-prompt: fix uninitialized variable
 + git-prompt: use here-doc instead of here-string

 The command line prompt support used to be littered with bash-isms,
 which has been corrected to work with more shells.

 Will merge to 'master'.
 source: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>


* ps/reftable-drop-generic (2024-08-22) 16 commits
  (merged to 'next' on 2024-08-22 at c6706c1b16)
 + reftable/generic: drop interface
 + t/helper: refactor to not use `struct reftable_table`
 + t/helper: use `hash_to_hex_algop()` to print hashes
 + t/helper: inline printing of reftable records
 + t/helper: inline `reftable_table_print()`
 + t/helper: inline `reftable_stack_print_directory()`
 + t/helper: inline `reftable_reader_print_file()`
 + t/helper: inline `reftable_dump_main()`
 + reftable/dump: drop unused `compact_stack()`
 + reftable/generic: move generic iterator code into iterator interface
 + reftable/iter: drop double-checking logic
 + reftable/stack: open-code reading refs
 + reftable/merged: stop using generic tables in the merged table
 + reftable/merged: rename `reftable_new_merged_table()`
 + reftable/merged: expose functions to initialize iterators
 + Merge branch 'ps/reftable-stack-compaction' into ps/reftable-drop-generic
 (this branch is used by ps/reftable-concurrent-compaction.)

 The code in the reftable library has been cleaned up by discarding
 unused "generic" interface.

 Will merge to 'master'.
 source: <cover.1724308389.git.ps@pks.im>


* tb/pseudo-merge-bitmap-fixes (2024-08-15) 8 commits
  (merged to 'next' on 2024-08-19 at 10cc82b2fb)
 + pseudo-merge.c: ensure pseudo-merge groups are closed
 + pseudo-merge.c: do not generate empty pseudo-merge commits
 + t/t5333-pseudo-merge-bitmaps.sh: demonstrate empty pseudo-merge groups
 + pack-bitmap-write.c: select pseudo-merges even for small bitmaps
 + pack-bitmap: drop redundant args from `bitmap_writer_finish()`
 + pack-bitmap: drop redundant args from `bitmap_writer_build()`
 + pack-bitmap: drop redundant args from `bitmap_writer_build_type_index()`
 + pack-bitmap: initialize `bitmap_writer_init()` with packing_data
 (this branch is used by tb/incremental-midx-part-2.)

 We created a useless pseudo-merge reachability bitmap that is about
 0 commits, and attempted to include commits that are not in packs,
 which made no sense.  These bugs have been corrected.

 Will merge to 'master'.
 cf. <20240817104412.GE551779@coredump.intra.peff.net>
 source: <cover.1723743050.git.me@ttaylorr.com>


* tb/incremental-midx-part-2 (2024-08-15) 15 commits
 - midx: implement writing incremental MIDX bitmaps
 - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
 - pack-bitmap.c: keep track of each layer's type bitmaps
 - ewah: implement `struct ewah_or_iterator`
 - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
 - pack-bitmap.c: compute disk-usage with incremental MIDXs
 - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
 - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
 - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
 - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 - pack-bitmap.c: open and store incremental bitmap layers
 - pack-revindex: prepare for incremental MIDX bitmaps
 - Documentation: describe incremental MIDX bitmaps
 - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
 - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2
 (this branch uses tb/pseudo-merge-bitmap-fixes.)

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1723760847.git.me@ttaylorr.com>


* mt/rebase-x-quiet (2024-08-21) 1 commit
  (merged to 'next' on 2024-08-22 at 1018555d89)
 + rebase --exec: respect --quiet

 "git rebase -x --quiet" was not quiet, which was corrected.

 Will merge to 'master'.
 source: <f105b34b8e6b33448f4d0ef07d51b7bbf4e71aaa.1724203912.git.matheus.tavb@gmail.com>


* gt/unit-test-urlmatch-normalization (2024-08-20) 1 commit
  (merged to 'next' on 2024-08-21 at 3efed1ed8d)
 + t: migrate t0110-urlmatch-normalization to the new framework

 Another rewrite of test.

 Will merge to 'master'.
 source: <20240820152008.21354-2-shyamthakkar001@gmail.com>


* ps/clar-unit-test (2024-08-20) 13 commits
 - clar: add CMake support
 - t/unit-tests: convert ctype tests to use clar
 - t/unit-tests: convert strvec tests to use clar
 - Makefile: wire up the clar unit testing framework
 - Makefile: do not use sparse on third-party sources
 - Makefile: make hdr-check depend on generated headers
 - Makefile: fix sparse dependency on GENERATED_H
 - clar: stop including `shellapi.h` unnecessarily
 - clar(win32): avoid compile error due to unused `fs_copy()`
 - clar: avoid compile error with mingw-w64
 - t/clar: fix compatibility with NonStop
 - t: import the clar unit testing framework
 - t: do not pass GIT_TEST_OPTS to unit tests with prove

 Import clar unit tests framework libgit2 folks invented for our
 use.

 Need to decide how to fill feature gap with our home-grown one
 cf. <b87700d2-0c9a-4d0c-9ee4-e6a91278d596@gmail.com>
 source: <cover.1724159966.git.ps@pks.im>


* ps/maintenance-detach-fix (2024-08-16) 7 commits
  (merged to 'next' on 2024-08-16 at 5db1344236)
 + run-command: fix detaching when running auto maintenance
 + builtin/maintenance: add a `--detach` flag
 + builtin/gc: add a `--detach` flag
 + builtin/gc: stop processing log file on signal
 + builtin/gc: fix leaking config values
 + builtin/gc: refactor to read config into structure
 + config: fix constness of out parameter for `git_config_get_expiry()`
 (this branch is used by ps/maintenance-detach-fix-more.)

 Allow maintenance tasks other than "gc" to properly go background
 when "git maintenance" run them.

 Will merge to 'master'.
 source: <cover.1723804990.git.ps@pks.im>


* jk/send-email-translate-aliases (2024-08-17) 3 commits
  (merged to 'next' on 2024-08-19 at dd207c3560)
 + send-email: teach git send-email option to translate aliases
 + t9001-send-email.sh: update alias list used for pine test
 + t9001-send-email.sh: fix quoting for mailrc --dump-aliases test

 "git send-email" learned "--translate-aliases" option that reads
 addresses from the standard input and emits the result of applying
 aliases on them to the standard output.

 Will merge to 'master'.
 source: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>


* cp/unit-test-reftable-block (2024-08-21) 11 commits
  (merged to 'next' on 2024-08-22 at 234d8701da)
 + t-reftable-block: add tests for index blocks
 + t-reftable-block: add tests for obj blocks
 + t-reftable-block: add tests for log blocks
 + t-reftable-block: remove unnecessary variable 'j'
 + t-reftable-block: use xstrfmt() instead of xstrdup()
 + t-reftable-block: use block_iter_reset() instead of block_iter_close()
 + t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
 + t-reftable-block: use reftable_record_equal() instead of check_str()
 + t-reftable-block: release used block reader
 + t: harmonize t-reftable-block.c with coding guidelines
 + t: move reftable/block_test.c to the unit testing framework

 Another test for reftable library ported to the unit test framework.

 Will merge to 'master'.
 cf. <ZsbdFU9aBQvqE3pb@tanuki>
 source: <20240821124150.4463-1-chandrapratap3519@gmail.com>


* js/libgit-rust (2024-08-09) 5 commits
 - cgit: add higher-level cgit crate
 - config: add git_configset_alloc() and git_configset_clear_and_free()
 - cgit-sys: add repo initialization and config access
 - cgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Comments?
 source: <cover.1723242556.git.steadmon@google.com>


* jc/range-diff-lazy-setup (2024-08-09) 2 commits
 - remerge-diff: clean up temporary objdir at a central place
 - remerge-diff: lazily prepare temporary objdir on demand

 Code clean-up.

 Comments?
 source: <xmqqr0ax9vlk.fsf@gitster.g>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* ds/for-each-ref-is-base (2024-08-14) 4 commits
  (merged to 'next' on 2024-08-20 at dd5da48f40)
 + p1500: add is-base performance tests
 + for-each-ref: add 'is-base' token
 + commit: add gentle reference lookup method
 + commit-reach: add get_branch_base_for_tip

 'git for-each-ref' learned a new "--format" atom to find the branch
 that the history leading to a given commit "%(is-base:<commit>)" is
 likely based on.

 Will merge to 'master'.
 source: <pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>


* cc/promisor-remote-capability (2024-07-31) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Expecting a reroll.
 cf. <ZrDYIFolRlERFdUT@tanuki>
 source: <20240731134014.2299361-1-christian.couder@gmail.com>


* ja/doc-synopsis-markup (2024-08-12) 3 commits
 - doc: apply synopsis simplification on git-clone and git-init
 - doc: update the guidelines to reflect the current formatting rules
 - doc: introduce a synopsis custom paragraph attribute

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.

 Will merge to 'next'?
 cf. <xmqqzfp8cm30.fsf@gitster.g>
 source: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>


* tc/fetch-bundle-uri (2024-07-24) 3 commits
 - fetch: use bundle URIs when having creationToken heuristic
 - transport: introduce transport_has_remote_bundle_uri()
 - clone: remove double bundle list clear code

 Allow "git fetch" take advantage of bundleURI feature.

 Expecting a reroll or retraction.
 source: <ZqObobw8FsDMkllm@tanuki>


* ew/cat-file-optim (2024-07-15) 10 commits
 - cat-file: use writev(2) if available
 - cat-file: batch_write: use size_t for length
 - cat-file: batch-command uses content_limit
 - object_info: content_limit only applies to blobs
 - packfile: packed_object_info avoids packed_to_object_type
 - cat-file: use delta_base_cache entries directly
 - packfile: inline cache_or_unpack_entry
 - packfile: fix off-by-one in content_limit comparison
 - packfile: allow content-limit for cat-file
 - packfile: move sizep computation

 "git cat-file --batch" has been optimized.

 Expecting a reroll.
 cf. <ZqC82sDnj7Se_aVB@tanuki>
 source: <20240715003519.2671385-1-e@80x24.org>
