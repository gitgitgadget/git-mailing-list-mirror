Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030563A
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721324320; cv=none; b=TXXXUf1QjGI6slpes+L6QbDJKEdFCwgQuvhuOqnBiriHWzFBG6z/3IIZQwYLiVhprzmMHEc+cGGMJ1BXCeaBAOQ618Wt+Ha+Iwjq56JGrK54oPmURg9dgU2/9nVVaxTnFMRUXO8VwiTZ9JG/iEwYRYOi7f4JDCEC84wUNreSg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721324320; c=relaxed/simple;
	bh=zFw1BoHAifOi2Cwr54GFOUawYhNE3B99mQDjjMoQ/FU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a54OOAnqiv2q6l6PYoFLIj9T3nxKAPHPVk6LizWQ5Z/dV07cw9R3r1NRokPRxGLex9xPpkC8W7jpegUV5avqYzsvjXA79FOmTdyhuFBE+xbvJo/d31HWBUxlnHG0N/+ludnokuxzb0IDxXs4FIB+jjV4i4HPaSZyppEzByztglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SrTpQst1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SrTpQst1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E31322C70F;
	Thu, 18 Jul 2024 13:38:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=z
	Fw1BoHAifOi2Cwr54GFOUawYhNE3B99mQDjjMoQ/FU=; b=SrTpQst1R7qYuPHD8
	8GzhKC8Va3QnF2bLzaYVHO1ipRuFDRSwcX9FkJlTUoq9IvalFGpAYrBMBHCWvzIC
	ujEghcQ/Ac/FA7w8a6MV3Uso7/1svjvtbRKk5SEnXRRCw24vM5gxUrhFVdSXFUOP
	wsxokBtooDwG+iBhGyQqWugluc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DAB9E2C70E;
	Thu, 18 Jul 2024 13:38:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 463472C70D;
	Thu, 18 Jul 2024 13:38:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2024, #06; Thu, 18)
X-master-at: d19b6cd2dd72dc811f19df4b32c7ed223256c3ee
X-next-at: 9752f9e123323e801511d405efab0fe0db92f038
Date: Thu, 18 Jul 2024 10:38:35 -0700
Message-ID: <xmqqr0bqvbvo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8FAB6B74-452C-11EF-8DD8-34EEED2EC81B-77302942!pb-smtp1.pobox.com

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
[Graduated to 'master']

* ch/refs-without-the-repository-fix (2024-07-16) 1 commit
  (merged to 'next' on 2024-07-17 at 89f907db0d)
 + refs: correct the version numbers in a comment

 Comment fix.
 source: <20240716095544.65931-1-list@eworm.de>


* jc/http-cookiefile (2024-07-09) 1 commit
  (merged to 'next' on 2024-07-11 at abdd5711d2)
 + http.c: cookie file tightening

 The http.cookieFile and http.saveCookies configuration variables
 have a few values that need to be avoided, which are now ignored
 with warning messages.
 source: <xmqqed82cgmj.fsf@gitster.g>


* jk/am-retry (2024-07-17) 1 commit
  (merged to 'next' on 2024-07-17 at 012d05db3b)
 + t4153: stop redirecting input from /dev/zero

 Test fix as a follow-up to an already graduated topic.
 source: <20240717070050.GG547635@coredump.intra.peff.net>


* jk/test-body-in-here-doc (2024-07-10) 10 commits
  (merged to 'next' on 2024-07-11 at 854733cffc)
 + t/.gitattributes: ignore whitespace in chainlint expect files
 + t: convert some here-doc test bodies
 + test-lib: allow test snippets as here-docs
 + chainlint.pl: add tests for test body in heredoc
 + chainlint.pl: recognize test bodies defined via heredoc
 + chainlint.pl: check line numbers in expected output
 + chainlint.pl: force CRLF conversion when opening input files
 + chainlint.pl: do not spawn more threads than we have scripts
 + chainlint.pl: only start threads if jobs > 1
 + chainlint.pl: add test_expect_success call to test snippets

 The test framework learns to take the test body not as a single
 string but as a here-document.
 source: <20240710083416.GA2060328@coredump.intra.peff.net>


* js/unit-test-oidtree-cmake-fix (2024-07-12) 1 commit
  (merged to 'next' on 2024-07-15 at d7aac9004c)
 + cmake: fix build of `t-oidtree`

 Build fix.
 source: <pull.1761.git.1720816450344.gitgitgadget@gmail.com>


* js/var-git-shell-path (2024-07-13) 7 commits
  (merged to 'next' on 2024-07-15 at 2e5b0eea39)
 + var(win32): do report the GIT_SHELL_PATH that is actually used
 + run-command: declare the `git_shell_path()` function globally
 + run-command(win32): resolve the path to the Unix shell early
 + mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
 + win32: override `fspathcmp()` with a directory separator-aware version
 + strvec: declare the `strvec_push_nodup()` function globally
 + run-command: refactor getting the Unix shell path into its own function

 "git var GIT_SHELL_PATH" should report the path to the shell used
 to spawn external commands, but it didn't do so on Windows, which
 has been corrected.
 source: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>


* kn/push-empty-fix (2024-07-12) 1 commit
  (merged to 'next' on 2024-07-13 at 74598adb55)
 + builtin/push: call set_refspecs after validating remote

 "git push '' HEAD:there" used to hit a BUG(); it has been corrected
 to die with "fatal: bad repository ''".
 source: <20240711093954.20317-1-karthik.188@gmail.com>


* ps/doc-http-empty-cookiefile (2024-07-11) 1 commit
  (merged to 'next' on 2024-07-13 at 801dcb5a35)
 + doc: update http.cookieFile with in-memory cookie processing

 What happens when http.cookieFile gets the special value "" has
 been clarified in the documentation..
 source: <pull.1733.v2.git.git.1720687008915.gitgitgadget@gmail.com>


* ps/pseudo-ref-terminology (2024-07-17) 1 commit
  (merged to 'next' on 2024-07-17 at 8886abf078)
 + Documentation/glossary: fix double word

 Doc update.
 source: <20240717105432.2801097-2-martin.agren@gmail.com>


* rj/test-sanitize-leak-log-fix (2024-07-11) 2 commits
  (merged to 'next' on 2024-07-11 at 9961f42025)
 + test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by default
  (merged to 'next' on 2024-07-08 at c7ee7d03e1)
 + test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG

 Tests that use GIT_TEST_SANITIZE_LEAK_LOG feature got their exit
 status inverted, which has been corrected.
 source: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
 source: <fe8cd0d1-e451-43d0-b033-11bbb6d1ed56@gmail.com>


* tb/doc-max-tree-depth-fix (2024-07-17) 1 commit
  (merged to 'next' on 2024-07-17 at cdfc7a4f7b)
 + Documentation: fix default value for core.maxTreeDepth

 Doc update.
 source: <57610d9ca635b6c76b9af5b3d3f346a9bc7621be.1721222249.git.me@ttaylorr.com>


* tb/pseudo-merge-reachability-bitmap (2024-07-17) 1 commit
  (merged to 'next' on 2024-07-17 at f11cc8586a)
 + Documentation/gitpacking: make sample configs listing blocks

 Doc update.
 source: <20240717105432.2801097-1-martin.agren@gmail.com>

--------------------------------------------------
[New Topics]

* rj/make-cleanup (2024-07-18) 2 commits
 - config.mak.uname: remove unused uname_P variable
 - Makefile: drop -Wno-universal-initializer from SP_EXTRA_FLAGS

 A build tweak knob has been simplified by not setting the value
 that is already the default; another unused one has been removed.

 Will merge to 'next'.
 source: <0d132370-3e07-4332-bcfb-c4450100d736@ramsayjones.plus.com>

--------------------------------------------------
[Stalled]

* cp/unit-test-reftable-tree (2024-07-16) 6 commits
 - SQUASH?????
 - t-reftable-tree: improve the test for infix_walk()
 - t-reftable-tree: add test for non-existent key
 - t-reftable-tree: split test_tree() into two sub-test functions
 - t: move reftable/tree_test.c to the unit testing framework
 - reftable: remove unnecessary curly braces in reftable/tree.c

 A test in reftable library has been rewritten using the unit test
 framework.

 Needs review.
 source: <20240716075641.4264-1-chandrapratap3519@gmail.com>


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


* es/doc-platform-support-policy (2024-07-12) 1 commit
 - Documentation: add platform support policy

 A policy document that describes platform support levels and
 expectation on platform stakeholders has been introduced.

 Needs review response.
 cf. <xmqqed7ylbna.fsf@gitster.g>
 source: <20240711232413.693444-1-emilyshaffer@google.com>


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


* rj/add-p-pager (2024-07-15) 4 commits
 - add-patch: render hunks through the pager
 - pager: introduce wait_for_pager
 - pager: do not close fd 2 unnecessarily
 - add-patch: test for 'p' command

 A 'P' command to "git add -p" that passes the patch hunk to the
 pager has been added.

 Expecting a (hopefully small and final) reroll.
 cf. <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 source: <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>


* ad/merge-with-diff-algorithm (2024-07-13) 1 commit
  (merged to 'next' on 2024-07-16 at 90fe5aff4d)
 + merge-recursive: honor diff.algorithm

 Many Porcelain commands that internally use the merge machinery
 were taught to consistently honor the diff.algorithm configuration.

 Will cook in 'next'.
 source: <pull.1743.v3.git.git.1720889507066.gitgitgadget@gmail.com>


* jc/checkout-no-op-switch-errors (2024-07-02) 1 commit
 - checkout: special case error messages during noop switching

 "git checkout --ours" (no other arguments) complained that the
 option is incompatible with branch switching, which is technically
 correct, but found confusing by some users.  It now says that the
 user needs to give pathspec to specify what paths to checkout.

 Will merge to 'next'.
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


* rs/unit-tests-test-run (2024-07-01) 6 commits
 - t-strbuf: use TEST_RUN
 - t-strvec: use TEST_RUN
 - t-reftable-basics: use TEST_RUN
 - t-ctype: use TEST_RUN
 - unit-tests: add TEST_RUN
 - t0080: move expected output to a file

 Unit-test framework clean-up.

 Expecting a reroll.
 cf. <97390954-49bc-48c4-bab1-95be10717aca@web.de>
 source: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>


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
