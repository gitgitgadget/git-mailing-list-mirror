Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD7171AB
	for <git@vger.kernel.org>; Thu, 23 May 2024 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716495408; cv=none; b=cxR8eUIq6J0q/IMLiWJhK+MSBQBHJhNl5PmkkwT6RAZzn6/NujyKjq/e+x1klydszbCrn/MVfWWth8Z9Gj6wlOzxltvtAjh5cDim3NYo4bx8F/0cLPjr36AEHZlQLiEDOd4jA/7CKcyS/ijU0p+tbhURZ01tHeqtguMGVA8IFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716495408; c=relaxed/simple;
	bh=6nwoB68z4hjt1Z52Ao4Hek4ByOd9JJXeuJ28HZhTOUA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BgRkkv7RAClJeMTOpHEVoPSIFSZ1bMUDcRYZVwltvByyIppTIAN4njm1e8VsN9Pn54bJGYihMmT47hf4T56A1Zj8tJG21pWfCSXZhXcsD2v5OMgeULZsDAjmOtCF+cYvwg1j/NMply5jTB0Es/GWpUMDytvwkMAEkSbfZUMEQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xp5Tmu9b; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xp5Tmu9b"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38D45334B8;
	Thu, 23 May 2024 16:16:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=6
	nwoB68z4hjt1Z52Ao4Hek4ByOd9JJXeuJ28HZhTOUA=; b=xp5Tmu9bKdgdhRDfM
	jpdCP32I50DWAlbh+8gaul/4CDWVtmXIzkQgG2pRNJEDHF4YfCcO1ck3ZnsGjK2e
	SpevAxmc+SZqUlD5qFgPkCPULOB23nOs88a7RyOimzcjMPmWG4io7TfKh9yXzZAB
	+7NHmkmPP9DAaLDpYjS7XlYsIU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F8B7334B7;
	Thu, 23 May 2024 16:16:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67648334B6;
	Thu, 23 May 2024 16:16:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (May 2024, #09; Thu, 23)
X-master-at: b9cfe4845cb2562584837bc0101c0ab76490a239
X-next-at: bbe1065a7e6f9ab964c30003b9eadf3a65c611d5
Date: Thu, 23 May 2024 13:16:41 -0700
Message-ID: <xmqqr0dss2qe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5EB7B3CC-1941-11EF-88E9-25B3960A682E-77302942!pb-smtp2.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

We unfortunately had serious regressions in 2.45.1 (and below, down
to 2.39 maintenance track are affected), and we are trying to assess
the extent of damage and which changes that went into the release to
revert.  We know about "git lfs" and "git annex" getting affected.
If your workflow is affected, you would want to try out 'seen' that
has proposed reverts to alleviate and report back to us, to make sure
that the next set of maintenance releases will fix the regressions
for you.

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

* dg/fetch-pack-code-cleanup (2024-05-13) 1 commit
  (merged to 'next' on 2024-05-17 at c8f8136d2e)
 + fetch-pack: remove unused 'struct loose_object_iter'

 Code clean-up to remove an unused struct definition.
 source: <20240512005913.342287-1-dave@treblig.org>


* dm/update-index-doc-fix (2024-05-13) 1 commit
  (merged to 'next' on 2024-05-17 at 2f6cd0d1cc)
 + documentation: git-update-index: add --show-index-version to synopsis

 Doc fix.
 source: <20240512031400.28416-1-dov.murik@linux.dev>


* it/refs-name-conflict (2024-05-06) 1 commit
  (merged to 'next' on 2024-05-15 at 39ef3ecc88)
 + refs: return conflict error when checking packed refs

 Expose "name conflict" error when a ref creation fails due to D/F
 conflict in the ref namespace, to improve an error message given by
 "git fetch".
 source: <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>


* jc/patch-flow-updates (2024-05-10) 2 commits
  (merged to 'next' on 2024-05-16 at d7a885574b)
 + SubmittingPatches: extend the "flow" section
 + SubmittingPatches: move the patch-flow section earlier
 (this branch is used by kn/patch-iteration-doc.)

 Doc updates.
 source: <20240510165526.1412338-1-gitster@pobox.com>


* la/hide-trailer-info (2024-05-02) 11 commits
  (merged to 'next' on 2024-05-15 at 955ffe4f37)
 + trailer unit tests: inspect iterator contents
 + trailer: document parse_trailers() usage
 + trailer: retire trailer_info_get() from API
 + trailer: make trailer_info struct private
 + trailer: make parse_trailers() return trailer_info pointer
 + interpret-trailers: access trailer_info with new helpers
 + sequencer: use the trailer iterator
 + trailer: teach iterator about non-trailer lines
 + trailer: add unit tests for trailer iterator
 + Makefile: sort UNIT_TEST_PROGRAMS
 + Merge branch 'la/format-trailer-info' into la/hide-trailer-info

 The trailer API has been reshuffled a bit.
 source: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>


* mt/openindiana-portability (2024-05-17) 7 commits
  (merged to 'next' on 2024-05-17 at de53f37879)
 + t/t9001-send-email.sh: sed - remove the i flag for s
 + t/t9118-git-svn-funky-branch-names.sh: sed needs semicolon
 + t/t1700-split-index.sh: mv -v is not portable
 + t/t4202-log.sh: fix misspelled variable
 + t/t0600-reffiles-backend.sh: rm -v is not portable
 + t/t9902-completion.sh: backslashes in echo
 + Switch grep from non-portable BRE to portable ERE

 Portability updates to various uses of grep and sed.
 source: <ZkeMiifGHkIsehz3@telcontar>

--------------------------------------------------
[New Topics]

* gt/unit-test-strcmp-offset (2024-05-20) 1 commit
  (merged to 'next' on 2024-05-23 at f672ec425f)
 + t/: port helper/test-strcmp-offset.c to unit-tests/t-strcmp-offset.c

 The strcmp-offset tests have been rewritten using the unit test
 framework.

 Will merge to 'master'.
 source: <20240519204530.12258-3-shyamthakkar001@gmail.com>


* jc/add-patch-enforce-single-letter-input (2024-05-22) 1 commit
  (merged to 'next' on 2024-05-23 at 12fef48392)
 + add-patch: enforce only one-letter response to prompts

 "git add -p" learned to complain when an answer with more than one
 letter is given to a prompt that expects a single letter answer.

 Will merge to 'master'.
 source: <xmqqh6ep1pwz.fsf_-_@gitster.g>


* jc/fix-2.45.1-and-friends-for-2.39 (2024-05-22) 12 commits
 - Revert "fsck: warn about symlink pointing inside a gitdir"
 - Revert "Add a helper function to compare file contents"
 - clone: drop the protections where hooks aren't run
 - tests: verify that `clone -c core.hooksPath=/dev/null` works again
 - Revert "core.hooksPath: add some protection while cloning"
 - init: use the correct path of the templates directory again
 - hook: plug a new memory leak
 - ci: stop installing "gcc-13" for osx-gcc
 - ci: avoid bare "gcc" for osx-gcc job
 - ci: drop mention of BREW_INSTALL_PACKAGES variable
 - send-email: avoid creating more than one Term::ReadLine object
 - send-email: drop FakeTerm hack
 (this branch is used by jc/fix-2.45.1-and-friends-for-maint.)

 Revert overly aggressive "layered defence" that went into 2.45.1
 and friends, which broke "git-lfs", "git-annex", and other use
 cases, so that we can rebuild necessary counterparts in the open.

 Needs consensus on what (more) to revert or adjust.
 source: <20240521195659.870714-1-gitster@pobox.com>


* jc/fix-2.45.1-and-friends-for-maint (2024-05-22) 12 commits
 - Merge branch 'fixes/2.45.1/2.44' into jc/fix-2.45.1-and-friends-for-maint
 - Merge branch 'fixes/2.45.1/2.43' into fixes/2.45.1/2.44
 - Merge branch 'fixes/2.45.1/2.42' into fixes/2.45.1/2.43
 - Merge branch 'fixes/2.45.1/2.41' into fixes/2.45.1/2.42
 - Merge branch 'fixes/2.45.1/2.40' into fixes/2.45.1/2.41
 - Merge branch 'jc/fix-2.45.1-and-friends-for-2.39' into fixes/2.45.1/2.40
 - Merge branch 'fixes/2.45.1/2.44' into jc/fix-2.45.1-and-friends-for-maint
 - Merge branch 'fixes/2.45.1/2.43' into fixes/2.45.1/2.44
 - Merge branch 'fixes/2.45.1/2.42' into fixes/2.45.1/2.43
 - Merge branch 'fixes/2.45.1/2.41' into fixes/2.45.1/2.42
 - Merge branch 'fixes/2.45.1/2.40' into fixes/2.45.1/2.41
 - Merge branch 'jc/fix-2.45.1-and-friends-for-2.39' into fixes/2.45.1/2.40
 (this branch uses jc/fix-2.45.1-and-friends-for-2.39.)

 Adjust jc/fix-2.45.1-and-friends-for-2.39 for more recent
 maintenance track.

 Will be merged to 'next' when the base topic becomes ready.


* ps/fix-reinit-includeif-onbranch (2024-05-22) 1 commit
 - setup: fix bug with "includeIf.onbranch" when initializing dir

 "git init" in an already created directory, when the user
 configuration has includeif.onbranch, started to fail recently,
 which has been corrected.

 Will merge to 'next'.
 source: <cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>

--------------------------------------------------
[Cooking]

* es/chainlint-ncores-fix (2024-05-22) 3 commits
  (merged to 'next' on 2024-05-22 at 1e4ab85522)
 + chainlint.pl: latch CPU count directly reported by /proc/cpuinfo
 + chainlint.pl: fix incorrect CPU count on Linux SPARC
 + chainlint.pl: make CPU count computation more robust

 The chainlint script (invoked during "make test") did nothing when
 it failed to detect the number of available CPUs.  It now falls
 back to 1 CPU to avoid the problem.

 Will merge to 'master'.
 source: <20240520190131.94904-1-ericsunshine@charter.net>


* tb/pack-bitmap-write-cleanups (2024-05-15) 6 commits
  (merged to 'next' on 2024-05-20 at 585e7bde21)
 + pack-bitmap: introduce `bitmap_writer_free()`
 + pack-bitmap-write.c: avoid uninitialized 'write_as' field
 + pack-bitmap: drop unused `max_bitmaps` parameter
 + pack-bitmap: avoid use of static `bitmap_writer`
 + pack-bitmap-write.c: move commit_positions into commit_pos fields
 + object.h: add flags allocated by pack-bitmap.h

 The pack bitmap code saw some clean-up to prepare for a follow-up topic.

 Will merge to 'master'.
 source: <cover.1715716605.git.me@ttaylorr.com>


* jc/t0017-clarify-bogus-expectation (2024-05-16) 1 commit
  (merged to 'next' on 2024-05-20 at c64016ec43)
 + t0017: clarify dubious test set-up

 Test clean-up.

 Will merge to 'master'.
 source: <xmqqcypmx44l.fsf@gitster.g>


* kn/osxkeychain-skip-idempotent-store (2024-05-15) 2 commits
  (merged to 'next' on 2024-05-21 at 4d757167ad)
 + osxkeychain: state to skip unnecessary store operations
 + osxkeychain: exclusive lock to serialize execution of operations

 The credential helper that talks with osx keychain learned to avoid
 storing back the authentication material it just got received from
 the keychain.

 Will merge to 'master'.
 source: <pull.1729.v3.git.1715800868.gitgitgadget@gmail.com>


* kn/update-ref-symref (2024-05-23) 7 commits
 - update-ref: add support for 'symref-update' command
 - reftable: pick either 'oid' or 'target' for new updates
 - update-ref: add support for 'symref-create' command
 - update-ref: add support for 'symref-delete' command
 - update-ref: add support for 'symref-verify' command
 - refs: create and use `ref_update_ref_must_exist()`
 - Merge branch 'kn/ref-transaction-symref' into kn/update-ref-symref

 "git update-ref --stdin" learned to handle transactional updates of
 symbolic-refs.

 Needs review.
 source: <20240514124411.1037019-1-knayak@gitlab.com>


* mt/t0211-typofix (2024-05-16) 1 commit
  (merged to 'next' on 2024-05-20 at f4fba3c7d2)
 + t/t0211-trace2-perf.sh: fix typo patern -> pattern

 Test fix.

 Will merge to 'master'.
 source: <ZkW5ggOVlglfi64u@telcontar>


* ps/complete-config-w-subcommands (2024-05-17) 1 commit
  (merged to 'next' on 2024-05-20 at 14453d34fc)
 + completion: adapt git-config(1) to complete subcommands

 Update the command line completion script (in contrib/) to adjust
 to the recent update to "git config" that adopted subcommand based
 UI.

 Will merge to 'master'.
 source: <8d43dee33289969a5afbbf7635ac40b7312d8e19.1715926344.git.ps@pks.im>


* ps/refs-without-the-repository-updates (2024-05-17) 17 commits
  (merged to 'next' on 2024-05-22 at 744f37ab2b)
 + refs/packed: remove references to `the_hash_algo`
 + refs/files: remove references to `the_hash_algo`
 + refs/files: use correct repository
 + refs: remove `dwim_log()`
 + refs: drop `git_default_branch_name()`
 + refs: pass repo when peeling objects
 + refs: move object peeling into "object.c"
 + refs: pass ref store when detecting dangling symrefs
 + refs: convert iteration over replace refs to accept ref store
 + refs: retrieve worktree ref stores via associated repository
 + refs: refactor `resolve_gitlink_ref()` to accept a repository
 + refs: pass repo when retrieving submodule ref store
 + refs: track ref stores via strmap
 + refs: implement releasing ref storages
 + refs: rename `init_db` callback to avoid confusion
 + refs: adjust names for `init` and `init_db` callbacks
 + Merge branch 'ps/refs-without-the-repository' into ps/refs-without-the-repository-updates
 (this branch is used by ps/ref-storage-migration.)

 Further clean-up the refs subsystem to stop relying on
 the_repository, and instead use the repository associated to the
 ref_store object.

 Will merge to 'master'.
 source: <cover.1715929858.git.ps@pks.im>


* jc/doc-diff-name-only (2024-05-17) 1 commit
  (merged to 'next' on 2024-05-20 at 13b6f9350d)
 + diff: document what --name-only shows

 The documentation for "git diff --name-only" has been clarified
 that it is about showing the names in the post-image tree.

 Will merge to 'master'.
 source: <xmqqeda0jr7d.fsf@gitster.g>


* kn/patch-iteration-doc (2024-05-17) 2 commits
  (merged to 'next' on 2024-05-20 at e0ee0051a9)
 + SubmittingPatches: add section for iterating patches
 + Merge branch 'jc/patch-flow-updates' into kn/patch-iteration-doc

 Doc updates.

 Will merge to 'master'.
 source: <20240517122724.270706-1-knayak@gitlab.com>


* mt/openindiana-scalar (2024-05-17) 1 commit
 - scalar: make enlistment delete to work on all POSIX platforms

 Avoid removing the $(cwd) for portability.

 Needs review.
 source: <Zkds81OB7C5bTCl_@telcontar>


* ts/archive-prefix-with-add-virtual-file (2024-05-17) 1 commit
 - archive: make --add-virtual-file honor --prefix

 The "--add-virtual-file" option of "git archive", added primarily
 to help "git diagnose", has always ignored the "--prefix", but
 been documented to honor it.

 Iffy if updating the implementation is the best approach.
 cf. <bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
 source: <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>


* js/doc-decisions (2024-05-17) 1 commit
  (merged to 'next' on 2024-05-22 at 891a062720)
 + doc: describe the project's decision-making process

 The project decision making policy has been documented.

 Will merge to 'master'.
 source: <10f217915600eda3ebec886e4f020f87c22e318a.1715978031.git.steadmon@google.com>


* jc/undecided-is-not-necessarily-sha1-fix (2024-05-21) 6 commits
  (merged to 'next' on 2024-05-22 at 4bd7982ebe)
 + apply: fix uninitialized hash function
 + builtin/hash-object: fix uninitialized hash function
 + builtin/patch-id: fix uninitialized hash function
 + t1517: test commands that are designed to be run outside repository
 + setup: add an escape hatch for "no more default hash algorithm" change
 + Merge branch 'ps/undecided-is-not-necessarily-sha1' into jc/undecided-is-not-necessarily-sha1-fix
 (this branch uses ps/undecided-is-not-necessarily-sha1.)

 The base topic started to make it an error for a command to leave
 the hash algorithm unspecified, which revealed a few commands that
 were not ready for the change.  Give users a knob to revert back to
 the "default is sha-1" behaviour as an escape hatch, and start
 fixing these breakages.

 Will merge to 'master'.
 source: <20240520231434.1816979-1-gitster@pobox.com>


* ps/builtin-config-cleanup (2024-05-15) 22 commits
  (merged to 'next' on 2024-05-20 at b6f728f1f5)
 + builtin/config: pass data between callbacks via local variables
 + builtin/config: convert flags to a local variable
 + builtin/config: track "fixed value" option via flags only
 + builtin/config: convert `key` to a local variable
 + builtin/config: convert `key_regexp` to a local variable
 + builtin/config: convert `regexp` to a local variable
 + builtin/config: convert `value_pattern` to a local variable
 + builtin/config: convert `do_not_match` to a local variable
 + builtin/config: move `respect_includes_opt` into location options
 + builtin/config: move default value into display options
 + builtin/config: move type options into display options
 + builtin/config: move display options into local variables
 + builtin/config: move location options into local variables
 + builtin/config: refactor functions to have common exit paths
 + config: make the config source const
 + builtin/config: check for writeability after source is set up
 + builtin/config: move actions into `cmd_config_actions()`
 + builtin/config: move legacy options into `cmd_config()`
 + builtin/config: move subcommand options into `cmd_config()`
 + builtin/config: move legacy mode into its own function
 + builtin/config: stop printing full usage on misuse
 + Merge branch 'ps/config-subcommands' into ps/builtin-config-cleanup

 Code clean-up to reduce inter-function communication inside
 builtin/config.c done via the use of global variables.

 Will merge to 'master'.
 source: <cover.1715755055.git.ps@pks.im>


* jc/doc-manpages-l10n (2024-05-17) 1 commit
  (merged to 'next' on 2024-05-20 at fb103ed70f)
 + SubmittingPatches: advertise git-manpages-l10n project a bit

 The SubmittingPatches document now refers folks to manpages
 translation project.

 Will merge to 'master'.
 source: <xmqqv83muc12.fsf@gitster.g>


* ps/reftable-reusable-iterator (2024-05-13) 13 commits
  (merged to 'next' on 2024-05-22 at b92eb9939f)
 + reftable/merged: adapt interface to allow reuse of iterators
 + reftable/stack: provide convenience functions to create iterators
 + reftable/reader: adapt interface to allow reuse of iterators
 + reftable/generic: adapt interface to allow reuse of iterators
 + reftable/generic: move seeking of records into the iterator
 + reftable/merged: simplify indices for subiterators
 + reftable/merged: split up initialization and seeking of records
 + reftable/reader: set up the reader when initializing table iterator
 + reftable/reader: inline `reader_seek_internal()`
 + reftable/reader: separate concerns of table iter and reftable reader
 + reftable/reader: unify indexed and linear seeking
 + reftable/reader: avoid copying index iterator
 + reftable/block: use `size_t` to track restart point index

 Code clean-up to make the reftable iterator closer to be reusable.

 Will merge to 'master'.
 source: <cover.1715589670.git.ps@pks.im>


* tb/precompose-getcwd (2024-05-21) 1 commit
 - macOS: ls-files path fails if path of workdir is NFD

 We forgot to normalize the result of getcwd() to NFC on macOS where
 all other paths are normalized, which has been corrected.

 Reverted out of 'next' to be replaced with an updated version (this one).
 Expectign a reroll to clarify the proposed log message.
 cf. <20240520160601.GA29154@tb-raspi4>
 cf. <20240521205749.GA8165@tb-raspi4>
 source: <20240521141452.26210-1-tboegi@web.de>


* jc/format-patch-more-aggressive-range-diff (2024-05-06) 1 commit
  (merged to 'next' on 2024-05-21 at 899cce93fb)
 + format-patch: run range-diff with larger creation-factor

 The default "creation-factor" used by "git format-patch" has been
 raised to make it more aggressively find matching commits.

 Will merge to 'master'.
 source: <xmqqbk5i3ncw.fsf_-_@gitster.g>


* ps/reftable-write-options (2024-05-13) 11 commits
  (merged to 'next' on 2024-05-22 at ae8e378430)
 + refs/reftable: allow configuring geometric factor
 + reftable: make the compaction factor configurable
 + refs/reftable: allow disabling writing the object index
 + refs/reftable: allow configuring restart interval
 + reftable: use `uint16_t` to track restart interval
 + refs/reftable: allow configuring block size
 + reftable/dump: support dumping a table's block structure
 + reftable/writer: improve error when passed an invalid block size
 + reftable/writer: drop static variable used to initialize strbuf
 + reftable: pass opts as constant pointer
 + reftable: consistently refer to `reftable_write_options` as `opts`

 The knobs to tweak how reftable files are written have been made
 available as configuration variables.

 Will merge to 'master'.
 source: <cover.1715587849.git.ps@pks.im>


* ps/pseudo-ref-terminology (2024-05-15) 10 commits
  (merged to 'next' on 2024-05-20 at fc0f1f2607)
 + refs: refuse to write pseudorefs
 + ref-filter: properly distinuish pseudo and root refs
 + refs: pseudorefs are no refs
 + refs: classify HEAD as a root ref
 + refs: do not check ref existence in `is_root_ref()`
 + refs: rename `is_special_ref()` to `is_pseudo_ref()`
 + refs: rename `is_pseudoref()` to `is_root_ref()`
 + Documentation/glossary: define root refs as refs
 + Documentation/glossary: clarify limitations of pseudorefs
 + Documentation/glossary: redefine pseudorefs as special refs
 (this branch is used by ps/ref-storage-migration.)

 Terminology to call various ref-like things are getting
 straightened out.

 Will merge to 'master'.
 cf. <vgzwb5xnlvz2gfiqamzrfcjs2xya3zhhoootyzopfpdrjapayq@wfsomyal4cf6>
 source: <cover.1715755591.git.ps@pks.im>


* jc/rev-parse-fatal-doc (2024-05-01) 1 commit
  (merged to 'next' on 2024-05-21 at 9bbb973b7b)
 + rev-parse: document how --is-* options work outside a repository

 Doc update.

 Will merge to 'master'.
 source: <xmqqplu54fbg.fsf@gitster.g>


* ps/undecided-is-not-necessarily-sha1 (2024-05-06) 15 commits
  (merged to 'next' on 2024-05-08 at 9f8e894685)
 + repository: stop setting SHA1 as the default object hash
 + oss-fuzz/commit-graph: set up hash algorithm
 + builtin/shortlog: don't set up revisions without repo
 + builtin/diff: explicitly set hash algo when there is no repo
 + builtin/bundle: abort "verify" early when there is no repository
 + builtin/blame: don't access potentially unitialized `the_hash_algo`
 + builtin/rev-parse: allow shortening to more than 40 hex characters
 + remote-curl: fix parsing of detached SHA256 heads
 + attr: fix BUG() when parsing attrs outside of repo
 + attr: don't recompute default attribute source
 + parse-options-cb: only abbreviate hashes when hash algo is known
 + path: move `validate_headref()` to its only user
 + path: harden validation of HEAD with non-standard hashes
 + Merge branch 'ps/the-index-is-no-more' into ps/undecided-is-not-necessarily-sha1
 + Merge branch 'jc/no-default-attr-tree-in-bare' into ps/undecided-is-not-necessarily-sha1
 (this branch is used by jc/undecided-is-not-necessarily-sha1-fix.)

 Before discovering the repository details, We used to assume SHA-1
 as the "default" hash function, which has been corrected. Hopefully
 this will smoke out codepaths that rely on such an unwarranted
 assumptions.

 Will cook in 'next', as it has known breakage.
 source: <cover.1715057362.git.ps@pks.im>


* pw/rebase-i-error-message (2024-04-08) 2 commits
 - rebase -i: improve error message when picking merge
 - rebase -i: pass struct replay_opts to parse_insn_line()

 When the user adds to "git rebase -i" instruction to "pick" a merge
 commit, the error experience is not pleasant.  Such an error is now
 caught earlier in the process that parses the todo list.

 Expecting a reroll.
 cf. <88bc0787-e7ae-49e5-99e8-97f6c55ea8c6@gmail.com>
 source: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>


* ds/send-email-per-message-block (2024-04-10) 1 commit
  (merged to 'next' on 2024-05-20 at 189c49a1ca)
 + send-email: move newline characters out of a few translatable strings

 Preliminary code clean-up for "git send-email".

 Will merge to 'master'.
 The topmost commit in the original series was dropped per author's request.
 cf. <a07d3807a24f6d68cb48ee48366ae25e@manjaro.org>
 source: <29ea3a9b07bf1aa17b5d6a1e41325379c494bcb2.1712732383.git.dsimic@manjaro.org>


* ew/khash-to-khashl (2024-03-28) 3 commits
 - khashl: fix ensemble lookups on empty table
 - treewide: switch to khashl for memory savings
 - list-objects-filter: use kh_size API

 The hashtable library "khash.h" has been replaced with "khashl.h"
 that has better memory usage characteristics.

 Needs review.
 cf. <xmqqy1a4ao3t.fsf@gitster.g>
 source: <20240328101356.300374-1-e@80x24.org>


* ds/doc-config-reflow (2024-03-14) 1 commit
 - config.txt: perform some minor reformatting

 Reflow a paragraph in the documentation source without any effect
 to the formatted text.

 Will discard.
 source: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>


* ie/config-includeif-hostname (2024-03-19) 2 commits
 - config: learn the "hostname:" includeIf condition
 - t: add a test helper for getting hostname

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <20240319210428.GC1159535@coredump.intra.peff.net>
 cf. <20240320001934.GA903718@coredump.intra.peff.net>
 source: <20240319183722.211300-1-ignacio@iencinas.com>


* cw/git-std-lib (2024-02-28) 4 commits
 . SQUASH??? get rid of apparent debugging crufts
 . test-stdlib: show that git-std-lib is independent
 . git-std-lib: introduce Git Standard Library
 . pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Expecting a reroll.
 cf. <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 cf. <6683f24e-7e56-489d-be2d-8afe1fc38d2b@gmail.com>
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Expecting a reroll.
 cf. <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* tb/path-filter-fix (2024-01-31) 16 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: new Bloom filter version that fixes murmur3
 - commit-graph: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - t/helper/test-read-graph: implement `bloom-filters` mode
 - bloom.h: make `load_bloom_filter_from_graph()` public
 - t/helper/test-read-graph.c: extract `dump_graph_info()`
 - gitformat-commit-graph: describe version 2 of BDAT
 - commit-graph: ensure Bloom filters are read with consistent settings
 - revision.c: consult Bloom filters for root commits
 - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Waiting for a final ack?
 cf. <ZcFjkfbsBfk7JQIH@nand.local>
 source: <cover.1706741516.git.me@ttaylorr.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
