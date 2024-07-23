Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705C13BC0B
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721703475; cv=none; b=uYgB3po/5lmICHu37DGe+R2qDu719XzlXhEAu3xX2mU+62FyrUEjA7+KVCexhHpr34sJguVqMolzl6+RnYNtIoopeycJUK5jd1R7K9h6mlqMpP8LuLR8SdD5hGnv6RSyD3xvXiPuEn76g7+duxR2jtNlll/ZIfTYZR/U5fjmXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721703475; c=relaxed/simple;
	bh=L5MsMWIqhNjUlrtLt0JPW4SMHcEYWKIscRIVwoBUR5o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WK0R/1yOKrvk4QgahOcrWPldtyM6skzehP17yTH4vNCvI6ycN2CFUMKmhn9IkAEwESqe9b+mglFK71hVR3paei8hKMp3qIocVnt41YfZmhU8GMVMrVenvkECFUCKIfAzX/UNQ1jqwBxXC2BdGZqBaFJkDED45KlX97OsWTa5WiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lehp4HrP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lehp4HrP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D03DB28DF6;
	Mon, 22 Jul 2024 22:57:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=L
	5MsMWIqhNjUlrtLt0JPW4SMHcEYWKIscRIVwoBUR5o=; b=Lehp4HrPSDENaItee
	7d6hr8iL5wHqomRZ8Y2sRkkV8xiCyJxfNpapV3lr/C7Nhug1WWbhKy5xSa+m3kV6
	B5UPe66KWHx2DvPuP+tVzslFES+Jnk/gukPnWkOK0Hz/fgY0Ld/m6AHZ4x8tTQN3
	ZQjxT4zC1Up1oeff904yKNQGnc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C8CF428DF5;
	Mon, 22 Jul 2024 22:57:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1F09E28DF4;
	Mon, 22 Jul 2024 22:57:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2024, #07; Mon, 22)
X-master-at: d19b6cd2dd72dc811f19df4b32c7ed223256c3ee
X-next-at: 9573259db95170f58f57a4a1f0dc806cd823113f
Date: Mon, 22 Jul 2024 19:57:44 -0700
Message-ID: <xmqqsew04xxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 572E356C-489F-11EF-9A33-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Git 2.46-rc1 has been tagged.  From now on until the final release,
which is planned to happen near the end of this month, please make
sure you place priorities on finding and fixing new regressions
introduced during this cycle over finding and fixing old bugs, over
any shiny new features.

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
[New Topics]

* ag/git-svn-global-ignores (2024-07-18) 2 commits
 - git-svn: use `svn:global-ignores` to create .gitignore
 - git-svn: add public property `svn:global-ignores`

 "git svn" has been taught about svn:global-ignores property
 recent versions of Subversion has.

 Needs review.
 source: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>


* ds/midx-write-repack-fix (2024-07-19) 2 commits
  (merged to 'next' on 2024-07-22 at 0a64b3ed42)
 + midx-write: revert use of --stdin-packs
 + t5319: add failing test case for repack/expire

 Repacking a repository with multi-pack index started making stupid
 pack selections in Git 2.45, which has been corrected.

 Will cook in 'next'.
 source: <pull.1764.git.1721332546.gitgitgadget@gmail.com>


* jc/how-to-maintain-updates (2024-07-19) 2 commits
 - howto-maintain: update daily tasks
 - howto-maintain: cover a whole development cycle

 Doc update.

 Will merge to 'next'?
 source: <xmqq1q3phzpi.fsf@gitster.g>


* es/shell-check-updates (2024-07-22) 4 commits
 - check-non-portable-shell: suggest alternative for `VAR=val shell-func`
 - check-non-portable-shell: improve `VAR=val shell-func` detection
 - t4034: fix use of one-shot variable assignment with shell function
 - t3430: modernize one-shot "VAR=val shell-func" invocation

 Test script linter has been updated to catch an attempt to use
 one-shot export construct "VAR=VAL func" for shell functions (which
 does not work for some shells) better.

 Will merge to 'next'?
 source: <20240722065915.80760-1-ericsunshine@charter.net>


* ja/doc-markup-updates-fix (2024-07-20) 1 commit
 - doc: git-clone fix discrepancy between asciidoc and asciidoctor

 Fix documentation mark-up regression in 2.45.

 Will merge to 'next' and then to 'master'.
 source: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>


* jc/doc-one-short-export-with-shell-func (2024-07-22) 1 commit
 - CodingGuidelines: document a shell that "fails" "VAR=VAL shell_func"

 It has been documented that we avoid "VAR=VAL shell_func" and why.

 Will merge to 'next'.
 source: <xmqqwmld55y1.fsf@gitster.g>


* jc/safe-directory (2024-07-20) 2 commits
 - safe.directory: normalize the configured path
 - safe.directory: normalize the checked path

 Follow-up on 2.45.1 regression fix.

 Needs review.
 source: <20240720220915.2933266-1-gitster@pobox.com>


* js/doc-markup-updates-fix (2024-07-22) 2 commits
 - SQUASH???
 - asciidoctor: fix `synopsis` rendering

 Work around asciidoctor's css that renders `monospace` material
 in the SYNOPSIS section of manual pages as block elements.

 Waiting for a review response.
 source: <pull.1749.v2.git.git.1721679949618.gitgitgadget@gmail.com>


* pw/add-patch-with-suppress-blank-empty (2024-07-20) 2 commits
  (merged to 'next' on 2024-07-22 at 5437b7dee3)
 + add-patch: use normalize_marker() when recounting edited hunk
 + add-patch: handle splitting hunks with diff.suppressBlankEmpty

 "git add -p" by users with diff.suppressBlankEmpty set to true
 failed to parse the patch that represents an unmodified empty line
 with an empty line (not a line with a single space on it), which
 has been corrected.

 Will cook in 'next'.
 source: <pull.1763.v2.git.1721491320.gitgitgadget@gmail.com>


* tn/doc-commit-fix (2024-07-22) 1 commit
 - doc: remove dangling closing parenthesis

 Docfix.

 Will merge to 'next'.
 source: <20240722225302.124356-1-tomasn@posteo.net>

--------------------------------------------------
[Stalled]

* sj/ref-fsck (2024-07-15) 10 commits
 - fsck: add ref content check for files backend
 - fsck: add ref name check for files backend
 - files-backend: add unified interface for refs scanning
 - builtin/fsck: add `git-refs verify` child process
 - git refs: add verify subcommand
 - refs: set up ref consistency check infrastructure
 - fsck: add refs-related error report function
 - fsck: rename objects-related fsck error functions
 - fsck: add a unified interface for reporting fsck messages
 - fsck: rename "skiplist" to "skip_oids"

 "git fsck" infrastructure has been taught to also check the sanity
 of the ref database, in addition to the object database.

 Needs review.
 source: <ZpPEdmUN1Z5tqbK3@ArchLinux>


* cp/unit-test-reftable-pq (2024-06-14) 7 commits
 - t-reftable-pq: add tests for merged_iter_pqueue_top()
 - t-reftable-pq: add test for index based comparison
 - t-reftable-pq: make merged_iter_pqueue_check() callable by reference
 - t-reftable-pq: make merged_iter_pqueue_check() static
 - t: move reftable/pq_test.c to the unit testing framework
 - reftable: change the type of array indices to 'size_t' in reftable/pq.c
 - reftable: remove unncessary curly braces in reftable/pq.c

 The tests for "pq" part of reftable library got rewritten to use
 the unit test framework.

 Needs review.
 source: <20240614095136.12052-1-chandrapratap3519@gmail.com>


* tb/incremental-midx-part-1 (2024-07-17) 19 commits
 - midx: implement support for writing incremental MIDX chains
 - t/t5313-pack-bounds-checks.sh: prepare for sub-directories
 - t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - midx: implement verification support for incremental MIDXs
 - midx: support reading incremental MIDX chains
 - midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
 - midx: teach `midx_preferred_pack()` about incremental MIDXs
 - midx: teach `midx_contains_pack()` about incremental MIDXs
 - midx: remove unused `midx_locate_pack()`
 - midx: teach `fill_midx_entry()` about incremental MIDXs
 - midx: teach `nth_midxed_offset()` about incremental MIDXs
 - midx: teach `bsearch_midx()` about incremental MIDXs
 - midx: introduce `bsearch_one_midx()`
 - midx: teach `nth_bitmapped_pack()` about incremental MIDXs
 - midx: teach `nth_midxed_object_oid()` about incremental MIDXs
 - midx: teach `prepare_midx_pack()` about incremental MIDXs
 - midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
 - midx: add new fields for incremental MIDX chains
 - Documentation: describe incremental MIDX format

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1721250704.git.me@ttaylorr.com>


* pp/add-parse-range-unit-test (2024-05-27) 1 commit
 - apply: add unit tests for parse_range

 A unit test for code that parses the hunk offset and length from a
 patch fragment header as been added.

 Expecting a reroll.
 cf. <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
 source: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>


* cw/git-std-lib (2024-02-28) 4 commits
 . SQUASH??? get rid of apparent debugging crufts
 . test-stdlib: show that git-std-lib is independent
 . git-std-lib: introduce Git Standard Library
 . pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>

--------------------------------------------------
[Cooking]

* cp/unit-test-reftable-tree (2024-07-22) 5 commits
 - t-reftable-tree: improve the test for infix_walk()
 - t-reftable-tree: add test for non-existent key
 - t-reftable-tree: split test_tree() into two sub-test functions
 - t: move reftable/tree_test.c to the unit testing framework
 - reftable: remove unnecessary curly braces in reftable/tree.c

 A test in reftable library has been rewritten using the unit test
 framework.

 Needs review.
 source: <20240722061836.4176-1-chandrapratap3519@gmail.com>


* rj/make-cleanup (2024-07-18) 2 commits
  (merged to 'next' on 2024-07-22 at bf3991f70f)
 + config.mak.uname: remove unused uname_P variable
 + Makefile: drop -Wno-universal-initializer from SP_EXTRA_FLAGS

 A build tweak knob has been simplified by not setting the value
 that is already the default; another unused one has been removed.

 Will cook in 'next'.
 source: <0d132370-3e07-4332-bcfb-c4450100d736@ramsayjones.plus.com>


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

 Needs review.
 source: <20240715003519.2671385-1-e@80x24.org>


* jc/document-use-of-local (2024-07-15) 1 commit
 - doc: note that AT&T ksh does not work with our test suite

 Doc update.

 Needs review.
 source: <xmqq1q3u8zmr.fsf@gitster.g>


* jt/doc-post-receive-hook-update (2024-07-15) 1 commit
  (merged to 'next' on 2024-07-17 at 624ac4ebe2)
 + doc: clarify post-receive hook behavior

 Doc update.

 Will cook in 'next'.
 source: <20240715183739.7808-1-jltobler@gmail.com>


* jc/reflog-expire-lookup-commit-fix (2024-07-16) 1 commit
 - Revert "reflog expire: don't use lookup_commit_reference_gently()"

 "git reflog expire" failed to honor annotated tags when computing
 reachable commits.

 Needs review.
 source: <xmqqv8156rh2.fsf@gitster.g>


* es/doc-platform-support-policy (2024-07-18) 2 commits
 - SQUASH???
 - Documentation: add platform support policy

 A policy document that describes platform support levels and
 expectation on platform stakeholders has been introduced.
 source: <20240718173843.2411415-1-emilyshaffer@google.com>


* kn/ci-clang-format (2024-07-18) 6 commits
 - ci/style-check: add `RemoveBracesLLVM` in CI job
 - check-whitespace: detect if no base_commit is provided
 - ci: run style check on GitHub and GitLab
 - clang-format: formalize some of the spacing rules
 - clang-format: avoid spacing around bitfield colon
 - clang-format: indent preprocessor directives after hash

 A CI job that use clang-format to check coding style issues in new
 code has been added.

 Will merge to 'next'.
 source: <20240718081605.452366-1-karthik.188@gmail.com>


* rj/add-p-pager (2024-07-22) 6 commits
 - pager: make wait_for_pager a no-op for "cat"
 - t3701: avoid one-shot export for shell functions
 - add-patch: render hunks through the pager
 - pager: introduce wait_for_pager
 - pager: do not close fd 2 unnecessarily
 - add-patch: test for 'p' command

 A 'P' command to "git add -p" that passes the patch hunk to the
 pager has been added.

 source: <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 source: <c37f0d54-4ead-422c-8193-f0c2ec84ca4a@gmail.com>
 source: <5536b336-5122-47fd-be57-42c299abe60c@gmail.com>


* ad/merge-with-diff-algorithm (2024-07-13) 1 commit
  (merged to 'next' on 2024-07-16 at 90fe5aff4d)
 + merge-recursive: honor diff.algorithm

 Many Porcelain commands that internally use the merge machinery
 were taught to consistently honor the diff.algorithm configuration.

 Will cook in 'next'.
 source: <pull.1743.v3.git.git.1720889507066.gitgitgadget@gmail.com>


* jc/checkout-no-op-switch-errors (2024-07-02) 1 commit
  (merged to 'next' on 2024-07-22 at 9573259db9)
 + checkout: special case error messages during noop switching

 "git checkout --ours" (no other arguments) complained that the
 option is incompatible with branch switching, which is technically
 correct, but found confusing by some users.  It now says that the
 user needs to give pathspec to specify what paths to checkout.

 Will cook in 'next'.
 source: <xmqqikxnqzz4.fsf@gitster.g>


* cp/unit-test-reftable-merged (2024-07-12) 7 commits
 - t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
 - t-reftable-merged: use reftable_ref_record_equal to compare ref records
 - t-reftable-merged: add tests for reftable_merged_table_max_update_index
 - t-reftable-merged: improve the const-correctness of helper functions
 - t-reftable-merged: improve the test t_merged_single_record()
 - t: harmonize t-reftable-merged.c with coding guidelines
 - t: move reftable/merged_test.c to the unit testing framework

 Another reftable test has been ported to use the unit test framework.

 Will merge to 'next'.
 source: <20240712055041.6476-1-chandrapratap3519@gmail.com>


* rs/t-strvec-use-test-msg (2024-07-16) 3 commits
  (merged to 'next' on 2024-07-16 at 3e860b3f12)
 + t-strvec: fix type mismatch in check_strvec
  (merged to 'next' on 2024-07-15 at f26e434515)
 + t-strvec: improve check_strvec() output
  (merged to 'next' on 2024-07-08 at c28c2553de)
 + t-strvec: use test_msg()

 Unit test clean-up.

 Will cook in 'next'.
 source: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 source: <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
 source: <1521ed89-989e-452b-b7fc-9e73672e0764@web.de>


* gt/unit-test-hashmap (2024-07-12) 1 commit
 - t: port helper/test-hashmap.c to unit-tests/t-hashmap.c

 An existing test of hashmap API has been rewritten with the
 unit-test framework.

 What's the doneness of this one?
 source: <20240711235159.5320-1-shyamthakkar001@gmail.com>


* rs/unit-tests-test-run (2024-07-22) 6 commits
 - t-strbuf: use for_test
 - t-strvec: use for_test
 - t-reftable-basics: use for_test
 - t-ctype: use for_test
 - unit-tests: add for_test
 - t0080: move expected output to a file

 Unit-test framework clean-up.

 Waiting for a review response.
 cf. <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 source: <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>


* jc/patch-id (2024-06-21) 5 commits
 - patch-id: tighten code to detect the patch header
 - patch-id: rewrite code that detects the beginning of a patch
 - patch-id: make get_one_patchid() more extensible
 - patch-id: call flush_current_id() only when needed
 - t4204: patch-id supports various input format

 The patch parser in "git patch-id" has been tightened to avoid
 getting confused by lines that look like a patch header in the log
 message.

 Needs review.
 source: <20240621231826.3280338-1-gitster@pobox.com>

--------------------------------------------------
[Discarded]

* jk/add-patch-with-suppress-blank-empty (2024-07-10) 1 commit
  (merged to 'next' on 2024-07-11 at cec8ebb668)
 + add-patch: handle splitting hunks with diff.suppressBlankEmpty

 When the diff.suppressBlankEmpty configuration variable is set,
 "git add -p" failed to process a patch with an unmodified empty
 line, which has been corrected.

 Reverted out of 'next'.
 source: <20240710093610.GA2076910@coredump.intra.peff.net>
