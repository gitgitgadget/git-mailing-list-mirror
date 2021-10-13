Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09016C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 00:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB21260BD3
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 00:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhJMAVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:21:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55120 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhJMAVA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 20:21:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98EC514D7D9;
        Tue, 12 Oct 2021 20:18:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=wQg/Kspn/4Wfot3ZpNqQJ4K25
        ymWlbe8NyxjIWP4RaA=; b=kI6YnFbMVHQ9FohqGKKybwMMktAP0mLEjrfRtj2y0
        g1959MnJW0wQhLsQtD0Ty+G9fgsqzKHi76BLdDsOipK/P2cT+MPuUgwGtjqQb3eu
        lK9NsGmGQ1a/e9D0J+DDWaS6kIG8RLZv4Eq8zCZ0BZK30UuO/g5geNPNzr5Ya/HN
        DU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9196314D7D8;
        Tue, 12 Oct 2021 20:18:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1350114D7D7;
        Tue, 12 Oct 2021 20:18:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.33.1
Date:   Tue, 12 Oct 2021 17:18:53 -0700
Message-ID: <xmqqczo922vm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 26C4CDB8-2BBB-11EC-889E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.33.1 is now available at the
usual places.  There is nothing spectacular; just backporting
accumulated fixes that already are merged for the next feature
release.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.33.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.33.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This primarily is to backport various fixes accumulated during the
development towards Git 2.34, the next feature release.


Fixes since v2.33
-----------------

 * The unicode character width table (used for output alignment) has
   been updated.

 * Input validation of "git pack-objects --stdin-packs" has been
   corrected.

 * Bugfix for common ancestor negotiation recently introduced in "git
   push" codepath.

 * "git pull" had various corner cases that were not well thought out
   around its --rebase backend, e.g. "git pull --ff-only" did not stop
   but went ahead and rebased when the history on other side is not a
   descendant of our history.  The series tries to fix them up.

 * "git apply" miscounted the bytes and failed to read to the end of
   binary hunks.

 * "git range-diff" code clean-up.

 * "git commit --fixup" now works with "--edit" again, after it was
   broken in v2.32.

 * Use upload-artifacts v1 (instead of v2) for 32-bit linux, as the
   new version has a blocker bug for that architecture.

 * Checking out all the paths from HEAD during the last conflicted
   step in "git rebase" and continuing would cause the step to be
   skipped (which is expected), but leaves MERGE_MSG file behind in
   $GIT_DIR and confuses the next "git commit", which has been
   corrected.

 * Various bugs in "git rebase -r" have been fixed.

 * mmap() imitation used to call xmalloc() that dies upon malloc()
   failure, which has been corrected to just return an error to the
   caller to be handled.

 * "git diff --relative" segfaulted and/or produced incorrect result
   when there are unmerged paths.

 * The delayed checkout code path in "git checkout" etc. were chatty
   even when --quiet and/or --no-progress options were given.

 * "git branch -D <branch>" used to refuse to remove a broken branch
   ref that points at a missing commit, which has been corrected.

 * Build update for Apple clang.

 * The parser for the "--nl" option of "git column" has been
   corrected.

 * "git upload-pack" which runs on the other side of "git fetch"
   forgot to take the ref namespaces into account when handling
   want-ref requests.

 * The sparse-index support can corrupt the index structure by storing
   a stale and/or uninitialized data, which has been corrected.

 * Buggy tests could damage repositories outside the throw-away test
   area we created.  We now by default export GIT_CEILING_DIRECTORIES
   to limit the damage from such a stray test.

 * Even when running "git send-email" without its own threaded
   discussion support, a threading related header in one message is
   carried over to the subsequent message to result in an unwanted
   threading, which has been corrected.

 * The output from "git fast-export", when its anonymization feature
   is in use, showed an annotated tag incorrectly.

 * Recent "diff -m" changes broke "gitk", which has been corrected.

 * "git maintenance" scheduler fix for macOS.

 * A pathname in an advice message has been made cut-and-paste ready.

 * The "git apply -3" code path learned not to bother the lower level
   merge machinery when the three-way merge can be trivially resolved
   without the content level merge.

 * The code that optionally creates the *.rev reverse index file has
   been optimized to avoid needless computation when it is not writing
   the file out.

 * "git range-diff -I... <range> <range>" segfaulted, which has been
   corrected.

 * The order in which various files that make up a single (conceptual)
   packfile has been reevaluated and straightened up.  This matters in
   correctness, as an incomplete set of files must not be shown to a
   running Git.

 * The "mode" word is useless in a call to open(2) that does not
   create a new file.  Such a call in the files backend of the ref
   subsystem has been cleaned up.

 * "git update-ref --stdin" failed to flush its output as needed,
   which potentially led the conversation to a deadlock.

 * When "git am --abort" fails to abort correctly, it still exited
   with exit status of 0, which has been corrected.

 * Correct nr and alloc members of strvec struct to be of type size_t.

 * "git stash", where the tentative change involves changing a
   directory to a file (or vice versa), was confused, which has been
   corrected.

 * "git clone" from a repository whose HEAD is unborn into a bare
   repository didn't follow the branch name the other side used, which
   is corrected.

 * "git cvsserver" had a long-standing bug in its authentication code,
   which has finally been corrected (it is unclear and is a separate
   question if anybody is seriously using it, though).

 * "git difftool --dir-diff" mishandled symbolic links.

 * Sensitive data in the HTTP trace were supposed to be redacted, but
   we failed to do so in HTTP/2 requests.

 * "make clean" has been updated to remove leftover .depend/
   directories, even when it is not told to use them to compute header
   dependencies.

 * Protocol v0 clients can get stuck parsing a malformed feature line.

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.33.0 are as follows:

Alex Henrie (1):
      pull: abort if --ff-only is given and fast-forwarding is impossible

Andrzej Hunt (1):
      connect: also update offset for features without values

Bagas Sanjaya (1):
      Documentation: fix default directory of git bugreport -o

Carlo Marcelo Arenas Bel=C3=B3n (12):
      build: update detect-compiler for newer Xcode version
      builtin/merge: avoid -Wformat-extra-args from ancient Xcode
      ci: run a pedantic build as part of the GitHub workflow
      ci: update freebsd 12 cirrus job
      ci: use upload-artifacts v1 for dockerized jobs
      remote: avoid -Wunused-but-set-variable in gcc with -DNDEBUG
      tree-diff: fix leak when not HAVE_ALLOCA_H
      t0000: avoid masking git exit value through pipes
      git-cvsserver: use crypt correctly to compare password hashes
      git-cvsserver: protect against NULL in crypt(3)
      Documentation: cleanup git-cvsserver
      unicode: update the width tables to Unicode 14

David Aguilar (1):
      difftool: fix symlink-file writing in dir-diff mode

Derrick Stolee (1):
      maintenance: skip bootout/bootstrap when plist is registered

Elijah Newren (25):
      t7601: test interaction of merge/rebase/fast-forward flags and opti=
ons
      t7601: add tests of interactions with multiple merge heads and conf=
ig
      pull: since --ff-only overrides, handle it first
      pull: make --rebase and --no-rebase override pull.ff=3Donly
      pull: abort by default when fast-forwarding is not possible
      pull: update docs & code for option compatibility with rebasing
      pull: fix handling of multiple heads
      git-rebase.txt: correct antiquated claims about --rebase-merges
      directory-rename-detection.txt: small updates due to merge-ort opti=
mizations
      Documentation: edit awkward references to `git merge-recursive`
      merge-strategies.txt: update wording for the resolve strategy
      merge-strategies.txt: do not imply using copy detection is desired
      merge-strategies.txt: avoid giving special preference to patience a=
lgorithm
      merge-strategies.txt: fix simple capitalization error
      git-rebase.txt: correct out-of-date and misleading text about renam=
es
      merge-strategies.txt: add coverage of the `ort` merge strategy
      Update error message and code comment
      t3903: document a pair of directory/file bugs
      stash: avoid feeding directories to update-index
      stash: restore untracked files AFTER restoring tracked files
      git-am.txt: clarify --abort behavior
      t4151: add a few am --abort tests
      am: fix incorrect exit status on am fail to abort
      trace2.h: fix trivial comment typo
      merge-ort: fix completely wrong comment

Felipe Contreras (4):
      completion: bash: fix prefix detection in branch.*
      completion: bash: fix for suboptions with value
      completion: bash: fix for multiple dash commands
      completion: bash: add correct suffix in variables

Jeff Hostetler (1):
      sparse-index: copy dir_hash in ensure_full_index()

Jeff King (13):
      build: clang version may not be followed by extra words
      range-diff: drop useless "offset" variable from read_patches()
      range-diff: handle unterminated lines in read_patches()
      range-diff: use ssize_t for parsed "len" in read_patches()
      apply: keep buffer/size pair in sync when parsing binary hunks
      t5323: drop mentions of "master"
      logmsg_reencode(): warn when iconv() fails
      docs: use "character encoding" to refer to commit-object encoding
      t5562: use alarm() to interrupt timed child-wait
      strvec: use size_t to store nr and alloc
      t1400: avoid SIGPIPE race condition on fifo
      clone: handle unborn branch in bare repos
      http: match headers case-insensitively when redacting

Joel Klinghed (1):
      commit: restore --edit when combined with --fixup

Johannes Schindelin (1):
      maintenance: create `launchctl` configuration using a lock file

Johannes Sixt (1):
      t9001: PATH must not use Windows-style paths

Jonathan Tan (3):
      send-pack: fix push.negotiate with remote helper
      send-pack: fix push nego. when remote has refs
      fetch: die on invalid --negotiation-tip hash

Josh Steadmon (1):
      connect, protocol: log negotiated protocol version

Junio C Hamano (4):
      build: catch clang that identifies itself as "$VENDOR clang"
      apply: resolve trivial merge without hitting ll-merge with "--3way"
      hash-object: prefix_filename() returns allocated memory these days
      Git 2.33.1

Kim Altintop (3):
      t5730: introduce fetch command helper
      upload-pack.c: treat want-ref relative to namespace
      docs: clarify the interaction of transfer.hideRefs and namespaces

Kyle Zhao (1):
      pack-revindex.h: correct the time complexity descriptions

Marvin H=C3=A4user (1):
      send-email: avoid incorrect header propagation

Matheus Tavares (1):
      checkout: make delayed checkout respect --quiet and --no-progress

Matthias A=C3=9Fhauer (1):
      documentation: add documentation for 'git version'

Mickey Endito (1):
      t5582: remove spurious 'cd "$D"' line

Mike Hommey (1):
      credential: fix leak in credential_apply_config()

Patrick Steinhardt (1):
      update-ref: fix streaming of status updates

Philip Oakley (1):
      doc: config, tell readers of `git help --config`

Phillip Wood (7):
      t3403: fix commit authorship
      rebase --apply: restore some tests
      rebase --continue: remove .git/MERGE_MSG
      rebase -r: make 'merge -c' behave like reword
      rebase -i: add another reword test
      rebase -r: don't write .git/MERGE_MSG when fast-forwarding
      rebase -r: fix merge -c with a merge strategy

Ren=C3=A9 Scharfe (10):
      compat: let git_mmap use malloc(3) directly
      xopen: explicitly report creation failures
      use xopen() to handle fatal open(2) failures
      show-branch: simplify rev_is_head()
      archive: convert queue_directory to struct object_id
      branch: allow deleting dangling branches with --force
      range-diff: avoid segfault with -I
      setup: use xopen and xdup in sanitize_stdfds
      refs/files-backend: remove unused open mode parameter
      compression: drop write-only core_compression_* variables

SZEDER G=C3=A1bor (3):
      Makefile: remove archives before manipulating them with 'ar'
      column: fix parsing of the '--nl' option
      test-lib: set GIT_CEILING_DIRECTORIES to protect the surrounding re=
pository

Sergey Organov (1):
      diff-index: restore -c/--cc options handling

Takashi Iwai (1):
      completion: tcsh: Fix regression by drop of wrapper functions

Tal Kelrich (1):
      fast-export: fix anonymized tag using original length

Taylor Blau (4):
      bulk-checkin.c: store checksum directly
      pack-write.c: rename `.idx` files after `*.rev`
      builtin/repack.c: move `.idx` files into place last
      builtin/index-pack.c: move `.idx` files into place last

Zoker (1):
      doc: fix syntax error and the format of printf

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (20):
      pack-objects tests: cover blindspots in stdin handling
      pack-objects: fix segfault in --stdin-packs option
      bundle doc: rewrite the "DESCRIPTION" section
      bundle doc: elaborate on object prerequisites
      bundle doc: elaborate on rev<->ref restriction
      bundle doc: replace "basis" with "prerequsite(s)"
      ls-remote: set packet_trace_identity(<name>)
      rebase: emit one "fatal" in "fatal: fatal: <error>"
      protocol-caps.c: fix memory leak in send_info()
      mailmap.c: fix a memory leak in free_mailap_{info,entry}()
      gc: remove trailing dot from "gc.log" line
      send-email: fix a "first config key wins" regression in v2.33.0
      Makefile: remove the check_bindir script
      pack-write: skip *.rev work when not writing *.rev
      pack.h: line-wrap the definition of finish_tmp_packfile()
      pack-write: refactor renaming in finish_tmp_packfile()
      index-pack: refactor renaming in final()
      pack-write: split up finish_tmp_packfile() function
      pack-objects: rename .idx files into place after .bitmap files
      Makefile: clean .depend dirs under COMPUTE_HEADER_DEPENDENCIES !=3D=
 yes

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (3):
      t6300: don't run cat-file on non-existent object
      t6300: check for cat-file exit status code
      diff-lib: ignore paths that are outside $cwd if --relative asked

