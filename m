Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F557E792
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726341177; cv=none; b=ge64DlPVn3k8x9hFV9QEDMlHzeQezBYRPhJ05G+IJudJ8r/YwuABuCrW12gY44yL4LphUdWZ8zHS7S5uKgtFKva8uREZb+t1UbU0K7m4HtXVAHZNMBPrhAL5jtwuSlVinfTYBjmGUtV0temMt3CtvmgdO//9cepe3NYjBPUEAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726341177; c=relaxed/simple;
	bh=p5aJpuqZfJbUpO969+zJzNYFYDS9iNB3YIBkaFeSKuM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=irsa4Vt92eGkgEE5KQ+yof9l/3mzcfijD4LYUIV13CWzfu2gqBcORPbgTJxqeJTi43S2K4uK51aJInRdMk21EpvXM/khUhdKBpavZOJp9pHANJjz6tfNOAI9VK9swcEaPwPBw6YuWAAiGD+MsjXAsZBN5O0dmEoji0h0GWhscbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HLbTW3Zr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HLbTW3Zr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F7481A998;
	Sat, 14 Sep 2024 15:12:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=p
	5aJpuqZfJbUpO969+zJzNYFYDS9iNB3YIBkaFeSKuM=; b=HLbTW3Zro9XIze6ar
	DHcurGAUgi9ue454sDxxq6QzpPHhhTpKvoJL0ABeooW5/8UHLp3OMEEDPjBB1SL9
	tY91+CfkZIdI6Bx+1myrGFU+ME9TEkxp5/ovWhEvcFLp3SIHWSfT8glOsYn1Up+Q
	/r0w1bz3m0Zs8iCchmwuv2d1Ow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 377541A997;
	Sat, 14 Sep 2024 15:12:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98FC81A996;
	Sat, 14 Sep 2024 15:12:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2024, #05; Fri, 13)
X-master-at: ed155187b429a2a6b6475efe1767053df37ccfe1
X-next-at: 578e378164b3590ff9a370eb478d1fbaa7be2050
Date: Sat, 14 Sep 2024 12:12:46 -0700
Message-ID: <xmqqwmjerqvl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 54171DF0-72CD-11EF-8BB5-9B0F950A682E-77302942!pb-smtp2.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

As we have been accumulating many small fixes on the 'master' front,
I merged them to 'maint' and tagged the result as Git 2.46.1.  I
expect Git 2.46.2, primarily with CI fixes and not much more, to
follow shortly.

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

* bl/trailers-and-incomplete-last-line-fix (2024-09-06) 1 commit
  (merged to 'next' on 2024-09-09 at a09f0889bb)
 + interpret-trailers: handle message without trailing newline

 The interpret-trailers command failed to recognise the end of the
 message when the commit log ends in an incomplete line.
 
 source: <20240906145743.2059405-1-brianmlyles@gmail.com>


* ds/doc-wholesale-disabling-advice-messages (2024-09-06) 1 commit
  (merged to 'next' on 2024-09-07 at a52a31f161)
 + advice: recommend GIT_ADVICE=0 for tools

 The environment GIT_ADVICE has been intentionally kept undocumented
 to discourage its use by interactive users.  Add documentation to
 help tool writers.
 
 source: <pull.1781.v2.git.1725654155162.gitgitgadget@gmail.com>


* ds/scalar-no-tags (2024-09-06) 1 commit
  (merged to 'next' on 2024-09-07 at fc06d19cfb)
 + scalar: add --no-tags option to 'scalar clone'

 The "scalar clone" command learned the "--no-tags" option.
 
 source: <pull.1780.v2.git.1725654102035.gitgitgadget@gmail.com>


* jc/doc-skip-fetch-all-and-prefetch (2024-09-09) 1 commit
  (merged to 'next' on 2024-09-09 at a2bf302636)
 + doc: remote.*.skip{DefaultUpdate,FetchAll} stops prefetch

 Doc updates.
 
 source: <xmqqseu8u8m0.fsf@gitster.g>


* jk/sparse-fdleak-fix (2024-09-06) 3 commits
  (merged to 'next' on 2024-09-07 at 2551aeee9e)
 + sparse-checkout: use fdopen_lock_file() instead of xfdopen()
 + sparse-checkout: check commit_lock_file when writing patterns
 + sparse-checkout: consolidate cleanup when writing patterns

 A file descriptor left open is now properly closed when "git
 sparse-checkout" updates the sparse patterns.
 
 source: <20240906034557.GA3693911@coredump.intra.peff.net>


* rj/cygwin-has-dev-tty (2024-09-08) 1 commit
  (merged to 'next' on 2024-09-09 at 5c5726050f)
 + config.mak.uname: add HAVE_DEV_TTY to cygwin config section

 Cygwin does have /dev/tty support that is needed by things like
 single-key input mode.
 
 source: <e3339b4d-dab1-4247-b70e-d3224bab1b6b@ramsayjones.plus.com>


* rs/diff-exit-code-fix (2024-09-08) 2 commits
  (merged to 'next' on 2024-09-09 at f52bb4afb2)
 + diff: report dirty submodules as changes in builtin_diff()
 + diff: report copies and renames as changes in run_diff_cmd()

 In a few corner cases "git diff --exit-code" failed to report
 "changes" (e.g., renamed without any content change), which has
 been corrected.
 
 source: <0864c86a-5562-4780-92c5-59d6c1a35aad@web.de>

--------------------------------------------------
[New Topics]

* bb/unicode-width-table-16 (2024-09-12) 1 commit
  (merged to 'next' on 2024-09-13 at 87dc391469)
 + unicode: update the width tables to Unicode 16

 Update the character width table for Unicode 16.

 Will merge to 'master'.
 source: <20240912204047.1020213-1-dev+git@drbeat.li>


* jc/strbuf-commented-something (2024-09-12) 2 commits
 - strbuf: retire strbuf_commented_lines()
 - strbuf: retire strbuf_commented_addf()

 Update two functions whose callers always pass the same global
 variable to omit the redundant parameter and use the global in the
 callee themselves.

 On hold.
 source: <20240912205301.1809355-1-gitster@pobox.com>


* jk/git-pm-bare-repo-fix (2024-09-13) 2 commits
  (merged to 'next' on 2024-09-13 at 7f9bb8501c)
 + Git.pm: use "rev-parse --absolute-git-dir" rather than perl code
 + Git.pm: fix bare repository search with Directory option

 In Git 2.39, Git.pm stopped working in a bare repository, which has
 been corrected.

 Will merge to 'master'.
 source: <20240912223413.GA649897@coredump.intra.peff.net>


* jc/t5512-sigpipe-fix (2024-09-13) 1 commit
 - t5512.40 sometimes dies by SIGPIPE

 Test fix.

 Will merge to 'next'.
 source: <xmqqmskbwe1a.fsf@gitster.g>

--------------------------------------------------
[Cooking]

* jc/ci-upload-artifact-and-linux32 (2024-09-09) 1 commit
  (merged to 'next' on 2024-09-11 at 62991bef5b)
 + ci: remove 'Upload failed tests' directories' step from linux32 jobs
 (this branch is used by jk/ci-linux32-update.)

 CI started failing completely for linux32 jobs, as the step to
 upload failed test directory uses GitHub actions that is deprecated
 and is now disabled.  Remove the step so at least we will know if
 the tests are passing.

 Will merge to 'master'.
 source: <xmqqy140o2kb.fsf@gitster.g>


* jk/ref-filter-trailer-fixes (2024-09-10) 10 commits
  (merged to 'next' on 2024-09-10 at ce7299fe2e)
 + ref-filter: fix leak with unterminated %(if) atoms
 + ref-filter: add ref_format_clear() function
 + ref-filter: fix leak when formatting %(push:remoteref)
 + ref-filter: fix leak with %(describe) arguments
 + ref-filter: fix leak of %(trailers) "argbuf"
 + ref-filter: store ref_trailer_buf data per-atom
 + ref-filter: drop useless cast in trailers_atom_parser()
 + ref-filter: strip signature when parsing tag trailers
 + ref-filter: avoid extra copies of payload/signature
 + t6300: drop newline from wrapped test title

 Bugfixes and leak plugging in "git for-each-ref --format=..." code
 paths.

 Will merge to 'master'.
 source: <20240909230758.GA921697@coredump.intra.peff.net>


* jk/ci-linux32-update (2024-09-13) 5 commits
  (merged to 'next' on 2024-09-13 at e937339388)
 + ci: add Ubuntu 16.04 job to GitLab CI
 + ci: use regular action versions for linux32 job
 + ci: use more recent linux32 image
 + ci: unify ubuntu and ubuntu32 dependencies
 + ci: drop run-docker scripts
 (this branch uses jc/ci-upload-artifact-and-linux32.)

 CI updates

 Will merge to 'master'.
 source: <20240912094238.GA589050@coredump.intra.peff.net>


* jk/interop-test-build-options (2024-09-12) 1 commit
  (merged to 'next' on 2024-09-13 at 0ab66e77a1)
 + t/interop: allow per-version make options

 The support to customize build options to adjust for older versions
 and/or older systems for the interop tests has been improved.

 Will merge to 'master'.
 source: <20240911061009.GA1538383@coredump.intra.peff.net>


* jk/no-openssl-with-openssl-sha1 (2024-09-12) 1 commit
  (merged to 'next' on 2024-09-13 at 07f5e4856d)
 + imap-send: handle NO_OPENSSL even when openssl exists

 The "imap-send" now allows to be compiled with NO_OPENSSL and
 OPENSSL_SHA1 defined together.

 Will merge to 'master'.
 source: <20240911061257.GA1538490@coredump.intra.peff.net>


* ma/test-libcurl-prereq (2024-09-11) 2 commits
  (merged to 'next' on 2024-09-13 at 6d4ad6b054)
 + t0211: add missing LIBCURL prereq
 + t1517: add missing LIBCURL prereq

 Test portability fix.

 Will merge to 'master'.
 source: <cover.1726049108.git.martin.agren@gmail.com>


* cc/promisor-remote-capability (2024-09-10) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?
 source: <20240910163000.1985723-1-christian.couder@gmail.com>


* ah/apply-3way-ours (2024-09-09) 1 commit
  (merged to 'next' on 2024-09-10 at 989ba9708b)
 + apply: support --ours, --theirs, and --union for three-way merges

 "git apply --3way" learned to take "--ours" and other options.

 Will merge to 'master'.
 source: <20240909141109.3102-2-alexhenrie24@gmail.com>


* ds/pack-name-hash-tweak (2024-09-09) 4 commits
 - p5313: add size comparison test
 - p5314: add a size test for name-hash collisions
 - git-repack: update usage to match docs
 - pack-objects: add --full-name-hash option

 In a repository with too many (more than --window size) similarly
 named files, "git repack" would not find good delta-base candidate
 and worse, it may not use a blob from exactly the same path as a
 good delta-base candidate.  Optionally replace the name hash so
 that only blobs at the same path and nothing else are used as
 delta-base candidate.

 Needs review.
 source: <pull.1785.git.1725890210.gitgitgadget@gmail.com>


* ps/reftable-exclude (2024-09-09) 7 commits
 - refs/reftable: wire up support for exclude patterns
 - reftable/reader: make table iterator reseekable
 - t/unit-tests: introduce reftable library
 - Makefile: stop listing test library objects twice
 - builtin/receive-pack: fix exclude patterns when announcing refs
 - refs: properly apply exclude patterns to namespaced refs
 - Merge branch 'cp/unit-test-reftable-stack' into ps/reftable-exclude
 (this branch uses cp/unit-test-reftable-stack.)

 The reftable backend learned to more efficiently handle exclude
 patterns while enumerating the refs.

 Needs review.
 source: <cover.1725881266.git.ps@pks.im>


* pw/rebase-autostash-fix (2024-09-03) 1 commit
  (merged to 'next' on 2024-09-13 at 6b41d66efd)
 + rebase: apply and cleanup autostash when rebase fails to start

 "git rebase --autostash" failed to resurrect the autostashed
 changes when the command gets aborted after giving back control
 asking for hlep in conflict resolution.

 Will merge to 'master'.
 source: <pull.1772.v2.git.1725289979450.gitgitgadget@gmail.com>


* cp/unit-test-reftable-stack (2024-09-09) 6 commits
  (merged to 'next' on 2024-09-09 at 0dddbbb60d)
 + t-reftable-stack: add test for stack iterators
 + t-reftable-stack: add test for non-default compaction factor
 + t-reftable-stack: use reftable_ref_record_equal() to compare ref records
 + t-reftable-stack: use Git's tempfile API instead of mkstemp()
 + t: harmonize t-reftable-stack.c with coding guidelines
 + t: move reftable/stack_test.c to the unit testing framework
 (this branch is used by ps/reftable-exclude.)

 Another reftable test migrated to the unit-test framework.

 Will merge to 'master'.
 source: <20240908041632.4948-1-chandrapratap3519@gmail.com>


* jc/pass-repo-to-builtins (2024-09-13) 4 commits
 - add: pass in repo variable instead of global the_repository
 - builtin: remove USE_THE_REPOSITORY for those without the_repository
 - builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
 - builtin: add a repository parameter for builtin functions

 The convention to calling into built-in command implementation has
 been updated to pass the repository, if known, together with the
 prefix value.

 Will merge to 'next'?
 source: <pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>


* tb/weak-sha1-for-tail-sum (2024-09-06) 9 commits
 - csum-file.c: use fast SHA-1 implementation when available
 - Makefile: allow specifying a SHA-1 for non-cryptographic uses
 - hash.h: scaffolding for _fast hashing variants
 - sha1: do not redefine `platform_SHA_CTX` and friends
 - i5500-git-daemon.sh: use compile-able version of Git without OpenSSL
 - pack-objects: use finalize_object_file() to rename pack/idx/etc
 - finalize_object_file(): implement collision check
 - finalize_object_file(): refactor unlink_or_warn() placement
 - finalize_object_file(): check for name collision before renaming

 The checksum at the tail of files are now computed without
 collision detection protection.

 Will merge to 'next'?
 source: <cover.1725651952.git.me@ttaylorr.com>


* es/chainlint-message-updates (2024-09-10) 3 commits
  (merged to 'next' on 2024-09-11 at a3fd02a009)
 + chainlint: reduce annotation noise-factor
 + chainlint: make error messages self-explanatory
 + chainlint: don't be fooled by "?!...?!" in test body

 The error messages from the test script checker have been improved.

 Will merge to 'master'.
 source: <20240910041013.68948-1-ericsunshine@charter.net>


* ps/environ-wo-the-repository (2024-09-12) 21 commits
 - environment: stop storing "core.notesRef" globally
 - environment: stop storing "core.warnAmbiguousRefs" globally
 - environment: stop storing "core.preferSymlinkRefs" globally
 - environment: stop storing "core.logAllRefUpdates" globally
 - refs: stop modifying global `log_all_ref_updates` variable
 - branch: stop modifying `log_all_ref_updates` variable
 - repo-settings: track defaults close to `struct repo_settings`
 - repo-settings: split out declarations into a standalone header
 - environment: guard state depending on a repository
 - environment: reorder header to split out `the_repository`-free section
 - environment: move `set_git_dir()` and related into setup layer
 - environment: make `get_git_namespace()` self-contained
 - environment: move object database functions into object layer
 - config: make dependency on repo in `read_early_config()` explicit
 - config: document `read_early_config()` and `read_very_early_config()`
 - environment: make `get_git_work_tree()` accept a repository
 - environment: make `get_graft_file()` accept a repository
 - environment: make `get_index_file()` accept a repository
 - environment: make `get_object_directory()` accept a repository
 - environment: make `get_git_common_dir()` accept a repository
 - environment: make `get_git_dir()` accept a repository

 Code clean-up.

 Will merge to 'next'.
 source: <cover.1726139990.git.ps@pks.im>


* gt/unit-test-oidset (2024-08-25) 1 commit
 - unit-tests: add tests for oidset.h

 Another unit-test.

 Expecting a reroll.
 source: <20240824172028.39419-1-shyamthakkar001@gmail.com>


* ps/leakfixes-part-6 (2024-09-05) 22 commits
  (merged to 'next' on 2024-09-13 at 9be3125b10)
 + builtin/repack: fix leaking keep-pack list
 + merge-ort: fix two leaks when handling directory rename modifications
 + match-trees: fix leaking prefixes in `shift_tree()`
 + builtin/fmt-merge-msg: fix leaking buffers
 + builtin/grep: fix leaking object context
 + builtin/pack-objects: plug leaking list of keep-packs
 + builtin/repack: fix leaking line buffer when packing promisors
 + negotiator/skipping: fix leaking commit entries
 + shallow: fix leaking members of `struct shallow_info`
 + shallow: free grafts when unregistering them
 + object: clear grafts when clearing parsed object pool
 + gpg-interface: fix misdesigned signing key interfaces
 + send-pack: fix leaking push cert nonce
 + remote: fix leak in reachability check of a remote-tracking ref
 + remote: fix leaking tracking refs
 + builtin/submodule--helper: fix leaking refs on push-check
 + submodule: fix leaking fetch task data
 + upload-pack: fix leaking child process data on reachability checks
 + builtin/push: fix leaking refspec query result
 + send-pack: fix leaking common object IDs
 + fetch-pack: fix memory leaks on fetch negotiation
 + t/test-lib: allow skipping leak checks for passing tests

 More leakfixes.

 Will merge to 'master'.
 source: <cover.1725530720.git.ps@pks.im>


* sj/ref-contents-check (2024-09-13) 5 commits
 - ref: add symlink ref content check for files backend
 - ref: add symref content check for files backend
 - ref: add more strict checks for regular refs
 - ref: port git-fsck(1) regular refs check for files backend
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).
 source: <ZuRzCyjQFilGhj8j@ArchLinux>


* tb/incremental-midx-part-2 (2024-08-28) 16 commits
 - fixup! midx: implement writing incremental MIDX bitmaps
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

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1723760847.git.me@ttaylorr.com>


* ps/clar-unit-test (2024-09-10) 15 commits
  (merged to 'next' on 2024-09-11 at ccc0289490)
 + Makefile: rename clar-related variables to avoid confusion
  (merged to 'next' on 2024-09-05 at 87fb0a399a)
 + clar: add CMake support
 + t/unit-tests: convert ctype tests to use clar
 + t/unit-tests: convert strvec tests to use clar
 + t/unit-tests: implement test driver
 + Makefile: wire up the clar unit testing framework
 + Makefile: do not use sparse on third-party sources
 + Makefile: make hdr-check depend on generated headers
 + Makefile: fix sparse dependency on GENERATED_H
 + clar: stop including `shellapi.h` unnecessarily
 + clar(win32): avoid compile error due to unused `fs_copy()`
 + clar: avoid compile error with mingw-w64
 + t/clar: fix compatibility with NonStop
 + t: import the clar unit testing framework
 + t: do not pass GIT_TEST_OPTS to unit tests with prove

 Import clar unit tests framework libgit2 folks invented for our
 use.

 Will merge to 'master'.
 cf. <d5b1c95b-cbdc-4711-849e-c2cfc67787ee@gmail.com>
 source: <cover.1725459142.git.ps@pks.im>


* js/libgit-rust (2024-09-09) 7 commits
 . SQUASH???
 . Makefile: add option to build and test libgit-rs and libgit-rs-sys
 . libgit: add higher-level libgit crate
 . config: add git_configset_alloc() and git_configset_clear_and_free()
 . libgit-sys: add repo initialization and config access
 . libgit-sys: introduce Rust wrapper for libgit.a
 . common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Expecting a reroll.
 cf. <xmqqv7z8tjd7.fsf@gitster.g>
 source: <20240906221853.257984-1-calvinwan@google.com>


* jc/range-diff-lazy-setup (2024-08-09) 2 commits
  (merged to 'next' on 2024-09-10 at 2e04a06b22)
 + remerge-diff: clean up temporary objdir at a central place
 + remerge-diff: lazily prepare temporary objdir on demand

 Code clean-up.

 Will merge to 'master'.
 source: <xmqqr0ax9vlk.fsf@gitster.g>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* ja/doc-synopsis-markup (2024-09-05) 3 commits
 - doc: apply synopsis simplification on git-clone and git-init
 - doc: update the guidelines to reflect the current formatting rules
 - doc: introduce a synopsis typesetting

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.

 Will merge to 'next'.
 source: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>


* ew/cat-file-optim (2024-08-25) 10 commits
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

 Waiting for review responses.
 source: <20240823224630.1180772-1-e@80x24.org>
