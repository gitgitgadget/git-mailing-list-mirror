From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2013, #07; Wed, 28)
Date: Wed, 28 Aug 2013 16:24:33 -0700
Message-ID: <xmqqtxi9761a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 01:24:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEp6S-0005kC-Pw
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 01:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab3H1XYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 19:24:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420Ab3H1XYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 19:24:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB1183D85B;
	Wed, 28 Aug 2013 23:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=0
	eQMQsdvv7OciHsxCYo7n8nwNyg=; b=BvvTMKT27MgFYzeB6w2/0A+I4ZDHhjIAW
	9gsSElrzz3yF16wfUUghrX1O6jVTDojlWVsT8ijZQLqvCd6NgdHTD6tE1I44O0hA
	MAXrSjaep76ENYEH0SPoKTejL3RGNCxzur9muNaLCQSiyqRZ+9CzLvGIv3cm0M+t
	kUtEpVuueY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=iSO
	EBdXUB1tzV8z9EaVRv4wXBGeqHMp4YJNyx/EtDsvaiCCrBAh+t0cYdbCHWoDEMV1
	HWPZhJ8HagSP0Y7PYTC8+fm7qoykNnpgfFqx46UfkqOh1Vg/Lm04FEdOGapM/Dj4
	5Aquf/Qqxlqpq1xvqQZQAwuUu2XeGzA9542HlktI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEB713D85A;
	Wed, 28 Aug 2013 23:24:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B8383D855;
	Wed, 28 Aug 2013 23:24:35 +0000 (UTC)
X-master-at: e230c568c4b9a991e3175e5f65171a566fd8e39c
X-next-at: 4ec6b414090cf91b9ca5200ee6921ae9a92582ff
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 004DFBBA-1039-11E3-BFE3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233231>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The tip of 'next' has been rewound. I ejected a handful of topics
that have been cooking there while rebuilding it, but it is not
because I found anything in them problematic, but merely because
they were young and I wanted to give their authors a chance to tweak
with a reroll instead of a set of follow-up patches. Unless I hear
otherwise in a few days, they will be merged back to 'next'.

By the way, the push that overrides the usual "must fast-forward"
was done using the "force-with-lease" option that has been cooking
in next, like so:

    $ git fetch ko next
    $ anchor=$(git rev-parse --verify FETCH_HEAD)
    $ for remote in ko repo gph github2
      do
        git push --force-with-lease=refs/heads/next:$anchor $remote next
      done

I used to do this with just --force.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* cc/replace-with-the-same-type (2013-08-27) 5 commits
 - Documentation/replace: add Creating Replacement Objects section
 - t6050-replace: add test to clean up all the replace refs
 - t6050-replace: test that objects are of the same type
 - Documentation/replace: state that objects must be of the same type
 - replace: forbid replacing an object with one of a different type

 Using the replace mechanism to swap an object with another object
 of a different type can introduce inconsistency (e.g. a tree
 expects an object name to refer to a blob, but the blob object can
 be mistakenly or maliciously replaced with an object with a
 different type). Attempt to forbid such.

 This may need to be given an escape hatch "--force", though.


* jx/clean-interactive (2013-08-28) 1 commit
 - documentation: clarify notes for clean.requireForce

 Finishing touches to update the document to adjust to a new option
 "git clean" learned recently.

 Will merge to 'next'.


* mm/status-without-comment-char (2013-08-28) 3 commits
 - SQUASH??? wt-status.c decl-after-stmt
 - status: introduce status.displayCommentChar to disable display of #
 - submodule: introduce --[no-]display-comment-char

 Allow "git status" to omit the prefix to make its output a comment
 in a commit log editor, which is not necessary for human
 consumption.


* xx/cleanup (2013-08-28) 1 commit
 - builtin/stripspace.c: fix broken indentation

 Will probably directly cherry-pick to 'maint' or 'master' and kill
 the branch.

--------------------------------------------------
[Stalled]

* rv/send-email-cache-generated-mid (2013-08-21) 2 commits
 - git-send-email: Cache generated message-ids, use them when prompting
 - git-send-email: add optional 'choices' parameter to the ask sub


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* jk/list-objects-sans-blobs (2013-06-06) 4 commits
 . archive: ignore blob objects when checking reachability
 . list-objects: optimize "revs->blob_objects = 0" case
 . upload-archive: restrict remote objects with reachability check
 . clear parsed flag when we free tree buffers

 Attempt to allow "archive --remote=$there $arbitrary_sha1" while
 keeping the reachability safety.

 Seems to break some tests in a trivial and obvious way.


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* js/xread-in-full (2013-08-20) 1 commit
 - stream_to_pack: xread does not guarantee to read all requested bytes

 Originally merged to 'next' on 2013-08-20

 A call to xread() was used without a loop around to cope with short
 read in the codepath to stream new contents to a pack.

 Will merge to 'next'.


* sb/mailmap-freeing-NULL-is-ok (2013-08-20) 1 commit
 - mailmap: remove redundant check for freeing memory

 Originally merged to 'next' on 2013-08-20

 Will merge to 'next'.


* tg/index-struct-sizes (2013-08-20) 1 commit
  (merged to 'next' on 2013-08-28 at c815042)
 + read-cache: use fixed width integer types

 Originally merged to 'next' on 2013-08-22

 The code that reads from a region that mmaps an on-disk index
 assumed that "int"/"short" are always 32/16 bits.

 Will merge to 'master' in the second batch.


* bc/completion-for-bash-3.0 (2013-08-22) 3 commits
  (merged to 'next' on 2013-08-28 at fb87a84)
 + contrib/git-prompt.sh: handle missing 'printf -v' more gracefully
 + t9902-completion.sh: old Bash still does not support array+=('') notation
 + git-completion.bash: use correct Bash/Zsh array length syntax

 Originally merged to 'next' on 2013-08-22

 Some people still use rather old versions of bash, which cannot
 grok some constructs like 'printf -v varname' the prompt and
 completion code started to use recently.

 Will merge to 'master'.


* bc/submodule-status-ignored (2013-08-20) 2 commits
 - submodule: don't print status output with ignore=all
 - submodule: fix confusing variable name

 Originally merged to 'next' on 2013-08-22

 Will merge to 'next'.


* jk/config-int-range-check (2013-08-21) 2 commits
 - teach git-config to output large integers
 - config: properly range-check integer values

 Originally merged to 'next' on 2013-08-22

 "git config --int section.var 3g" should somehow diagnose that the
 number does not fit in "int" (on 32-bit platforms anyway) but it
 did not.


* jk/duplicate-objects-in-packs (2013-08-24) 6 commits
 - default pack.indexDuplicates to false
 - index-pack: optionally reject packs with duplicate objects
 - test index-pack on packs with recoverable delta cycles
 - add tests for indexing packs with delta cycles
 - sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP
 - test-sha1: add a binary output mode

 A packfile that stores the same object more than once is broken and
 will be rejected.

 Will merge to 'next'.


* mm/mediawiki-dumb-push-fix (2013-08-21) 2 commits
 - git-remote-mediawiki: add test and check Makefile targets
 - git-remote-mediawiki: reset private ref after non-dumb push

 Waiting for a reroll.


* rt/rebase-p-no-merge-summary (2013-08-21) 1 commit
 - rebase --preserve-merges: ignore "merge.log" config

 Originally merged to 'next' on 2013-08-22

 "git rebase -p" internally used the merge machinery, but when
 rebasing, there should not be a need for merge summary.

 Will merge to 'next'.


* sp/clip-read-write-to-8mb (2013-08-20) 2 commits
  (merged to 'next' on 2013-08-28 at c9840d7)
 + Revert "compat/clipped-write.c: large write(2) fails on Mac OS X/XNU"
 + xread, xwrite: limit size of IO to 8MB

 Originally merged to 'next' on 2013-08-22

 Send a large request to read(2)/write(2) as a smaller but still
 reasonably large chunks, which would improve the latency when the
 operation needs to be killed and incidentally works around broken
 64-bit systems that cannot take a 2GB write or read in one go.

 Will merge to 'master' in the second batch.


* sp/doc-smart-http (2013-08-21) 1 commit
  (merged to 'next' on 2013-08-28 at 20a6877)
 + Document the HTTP transport protocols

 Originally merged to 'next' on 2013-08-22

 Will merge to 'master'.


* dw/diff-no-index-doc (2013-08-28) 2 commits
 - diff --no-index: describe in a separate paragraph
 - diff --no-index: clarify operation when not inside a repository

 When the user types "git diff" outside a working tree, thinking he
 is inside one, the current error message that is a single-liner
 "usage: git diff --no-index <path> <path>" may not be sufficient to
 make him realize the mistake. Add "Not a git repository" to the
 error message when we fell into the "--no-index" mode without an
 explicit command line option to instruct us to do so.


* sb/repack-in-c (2013-08-22) 3 commits
 - repack: rewrite the shell script in C (squashing proposal)
 - repack: retain the return value of pack-objects
 - repack: rewrite the shell script in C


* ap/commit-author-mailmap (2013-08-24) 1 commit
 - commit: search author pattern against mailmap

 "git commit --author=$name", when $name is not in the canonical
 "A. U. Thor <au.thor@example.xz>" format, looks for a matching name
 from existing history, but did not consult mailmap to grab the
 preferred author name.

 Will merge to 'next'.


* hv/config-from-blob (2013-08-26) 1 commit
  (merged to 'next' on 2013-08-28 at 189c6c1)
 + config: do not use C function names as struct members

 Portability fix.

 Will merge to 'master', aiming to later apply to 1.8.4.x maintenance track.


* jk/mailmap-incomplete-line (2013-08-28) 1 commit
 - mailmap: handle mailmap blobs without trailing newlines

 Will merge to 'next' and later to 'master' and 'maint'.


* jk/write-broken-index-with-nul-sha1 (2013-08-26) 1 commit
 - write_index: optionally allow broken null sha1s

 Am I waiting for another reroll?


* kk/tests-with-no-perl (2013-08-24) 4 commits
 - reset test: modernize style
 - t/t7106-reset-unborn-branch.sh: Add PERL prerequisite
 - add -i test: use skip_all instead of repeated PERL prerequisite
 - Make test "using invalid commit with -C" more strict

 Some tests were not skipped under NO_PERL build.

 Will merge to 'next'.


* mm/fast-import-feature-doc (2013-08-25) 1 commit
 - Documentation/fast-import: clarify summary for `feature` command

 Will merge to 'next'.


* mm/remote-helpers-doc (2013-08-26) 1 commit
 - Documentation/remote-helpers: document common use-case for private ref

 Will merge to 'next'.


* mn/doc-pack-heu-remove-dead-pastebin (2013-08-23) 1 commit
 - remove dead pastebin link from pack-heuristics document

 Will merge to 'next'.


* nd/fetch-pack-shallow-fix (2013-08-25) 1 commit
  (merged to 'next' on 2013-08-28 at 6f5ed42)
 + fetch-pack: do not remove .git/shallow file when --depth is not specified

 Originally merged to 'next' on 2013-08-27

 Recent "short-cut clone connectivity check" topic broke a shallow
 repository when a fetch operation tries to auto-follow tags.

 Will merge to 'master', aiming to later apply to 1.8.4.x maintenance track.


* ta/user-manual (2013-08-27) 11 commits
 - "git prune" is safe
 - Remove irrelevant reference from "Tying it all together"
 - Remove unnecessary historical note from "Object storage format"
 - Improve section "Merging multiple trees"
 - Improve section "Manipulating branches"
 - Simplify "How to make a commit"
 - Fix some typos and improve wording
 - Use "git merge" instead of "git pull ."
 - Use current output for "git repack"
 - Use current "detached HEAD" message
 - Call it "Git User Manual" and remove reference to very old Git version

 Update the user's manual to more recent versions of Git.


* tb/precompose-autodetect-fix (2013-08-27) 1 commit
 - Set core.precomposeunicode to true on e.g. HFS+

 Will merge to 'next'.


* tf/gitweb-ss-tweak (2013-08-20) 4 commits
 - gitweb: make search help link less ugly
 - gitweb: omit the repository owner when it is unset
 - gitweb: vertically centre contents of page footer
 - gitweb: ensure OPML text fits inside its box

 Originally merged to 'next' on 2013-08-22

 Tweak Gitweb CSS to layout some elements better.

 Will merge to 'next'.


* es/rebase-i-respect-core-commentchar (2013-08-18) 1 commit
 - rebase -i: fix cases ignoring core.commentchar

 Originally merged to 'next' on 2013-08-20

 Will merge to 'next'.


* jx/branch-vv-always-compare-with-upstream (2013-08-26) 2 commits
 - status: always show tracking branch even no change
 - branch: report invalid tracking branch as gone

 "git branch -v -v" (and "git status") did not distinguish among a
 branch that does not build on any other branch, a branch that is in
 sync with the branch it builds on, and a branch that is configured
 to build on some other branch that no longer exists.

 Am I waiting for another reroll?


* nd/fetch-into-shallow (2013-08-28) 7 commits
 - Add testcase for needless objects during a shallow fetch
 - list-objects: mark more commits as edges in mark_edges_uninteresting
 - list-objects: reduce one argument in mark_edges_uninteresting
 - upload-pack: delegate rev walking in shallow fetch to pack-objects
 - shallow: add setup_temporary_shallow()
 - shallow: only add shallow graft points to new shallow file
 - move setup_alternate_shallow and write_shallow_commits to shallow.c

 When there is no sufficient overlap between old and new history
 during a fetch into a shallow repository, we unnecessarily sent
 objects the sending side knows the receiving end has.

 Will merge to 'next'.


* sb/diff-delta-remove-needless-comparison (2013-08-18) 1 commit
  (merged to 'next' on 2013-08-28 at ba09c3f)
 + create_delta_index: simplify condition always evaluating to true

 Originally merged to 'next' on 2013-08-20

 Will merge to 'master'.


* sg/bash-prompt-lf-in-cwd-test (2013-08-18) 1 commit
  (merged to 'next' on 2013-08-28 at eb449b5)
 + bash prompt: test the prompt with newline in repository path

 Originally merged to 'next' on 2013-08-20

 Will merge to 'master'.


* jl/some-submodule-config-are-not-boolean (2013-08-19) 1 commit
  (merged to 'next' on 2013-08-28 at 7fabc3e)
 + avoid segfault on submodule.*.path set to an empty "true"

 Originally merged to 'next' on 2013-08-20

 Will merge to 'master'.


* jc/ls-files-killed-optim (2013-08-23) 4 commits
 - dir.c::test_one_path(): work around directory_exists_in_index_icase() breakage
 - t3010: update to demonstrate "ls-files -k" optimization pitfalls
 - ls-files -k: a directory only can be killed if the index has a non-directory
 - dir.c: use the cache_* macro to access the current index

 Originally merged to 'next' on 2013-08-27

 "git ls-files -k" needs to crawl only the part of the working tree
 that may overlap the paths in the index to find killed files, but
 shared code with the logic to find all the untracked files, which
 made it unnecessarily inefficient.

 Will merge to 'next'.


* es/blame-L-twice (2013-08-06) 16 commits
  (merged to 'next' on 2013-08-28 at e83ae2e)
 + line-range: reject -L line numbers less than 1
 + t8001/t8002: blame: add tests of -L line numbers less than 1
 + line-range: teach -L^:RE to search from start of file
 + line-range: teach -L:RE to search from end of previous -L range
 + line-range: teach -L^/RE/ to search from start of file
 + line-range-format.txt: document -L/RE/ relative search
 + log: teach -L/RE/ to search from end of previous -L range
 + blame: teach -L/RE/ to search from end of previous -L range
 + line-range: teach -L/RE/ to search relative to anchor point
 + blame: document multiple -L support
 + t8001/t8002: blame: add tests of multiple -L options
 + blame: accept multiple -L ranges
 + blame: inline one-line function into its lone caller
 + range-set: publish API for re-use by git-blame -L
 + line-range-format.txt: clarify -L:regex usage form
 + git-log.txt: place each -L option variation on its own line
 (this branch is used by es/contacts-blame-L-multi; uses es/blame-L-more.)

 Originally merged to 'next' on 2013-08-08

 Teaches "git blame" to take more than one -L ranges.

 Will merge to 'master' in the second batch.


* mm/no-shell-escape-in-die-message (2013-08-07) 1 commit
  (merged to 'next' on 2013-08-28 at 86b300f)
 + die_with_status: use "printf '%s\n'", not "echo"

 Originally merged to 'next' on 2013-08-08

 Fixes a minor bug in "git rebase -i" (there could be others, as the
 root cause is pretty generic) where the code feeds a random, data
 dependeant string to 'echo' and expects it to come out literally.

 Will merge to 'master'.


* tr/fd-gotcha-fixes (2013-08-06) 1 commit
  (merged to 'next' on 2013-08-28 at 5305271)
 + t0070: test that git_mkstemps correctly checks return value of open()

 Originally merged to 'next' on 2013-08-08

 Finishing touches to an earlier fix already in 'master'.

 Will merge to 'master'.


* ap/remote-hg-tilde-is-home-directory (2013-08-09) 1 commit
  (merged to 'next' on 2013-08-28 at 9bfc430)
 + remote-hg: fix path when cloning with tilde expansion

 Originally merged to 'next' on 2013-08-14

 Will merge to 'master'.


* es/rebase-i-no-abbrev (2013-08-25) 3 commits
 - rebase -i: fix short SHA-1 collision
 - t3404: rebase -i: demonstrate short SHA-1 collision
 - t3404: make tests more self-contained

 Originally merged to 'next' on 2013-08-26

 Will merge to 'next'.


* fc/remote-hg-shared-setup (2013-08-11) 2 commits
  (merged to 'next' on 2013-08-28 at 41ee3fe)
 + remote-hg: add shared repo upgrade
 + remote-hg: ensure shared repo is initialized

 Originally merged to 'next' on 2013-08-14

 Will merge to 'master'.


* jc/transport-do-not-use-connect-twice-in-fetch (2013-08-07) 5 commits
  (merged to 'next' on 2013-08-28 at 2ed86df)
 + fetch: work around "transport-take-over" hack
 + fetch: refactor code that fetches leftover tags
 + fetch: refactor code that prepares a transport
 + fetch: rename file-scope global "transport" to "gtransport"
 + t5802: add test for connect helper

 Originally merged to 'next' on 2013-08-20

 The auto-tag-following code in "git fetch" tries to reuse the same
 transport twice when the serving end does not cooperate and does
 not give tags that point to commits that are asked for as part of
 the primary transfer.  Unfortunately, Git-aware transport helper
 interface is not designed to be used more than once, hence this
 does not work over smart-http transfer.

 Will merge to 'master' in the second batch.


* ks/p4-view-spec (2013-08-11) 3 commits
 - WAITING FOR ACK
 - git p4: implement view spec wildcards with "p4 where"
 - git p4 test: sanitize P4CHARSET

 Waiting for an ack.


* mm/war-on-whatchanged (2013-08-13) 2 commits
  (merged to 'next' on 2013-08-28 at 25e9c18)
 + whatchanged: document its historical nature
 + core-tutorial: trim the section on Inspecting Changes

 Originally merged to 'next' on 2013-08-14

 Will merge to 'master'.


* nd/gc-lock-against-each-other (2013-08-09) 1 commit
  (merged to 'next' on 2013-08-28 at 46e072b)
 + gc: reject if another gc is running, unless --force is given

 Originally merged to 'next' on 2013-08-14

 Will merge to 'master'.


* rt/doc-merge-file-diff3 (2013-08-09) 1 commit
  (merged to 'next' on 2013-08-28 at d6b8006)
 + Documentation/git-merge-file: document option "--diff3"

 Originally merged to 'next' on 2013-08-14

 Will merge to 'master'.


* sb/misc-cleanup (2013-08-09) 3 commits
  (merged to 'next' on 2013-08-28 at bc2045b)
 + rm: remove unneeded null pointer check
 + diff: fix a possible null pointer dereference
 + diff: remove ternary operator evaluating always to true

 Originally merged to 'next' on 2013-08-14

 Will merge to 'master'.


* aj/p4-symlink-lose-nl (2013-08-12) 1 commit
  (merged to 'next' on 2013-08-28 at 5ce9ceb)
 + git-p4: Fix occasional truncation of symlink contents.

 Originally merged to 'next' on 2013-08-14

 Will merge to 'master'.


* es/contacts-blame-L-multi (2013-08-13) 3 commits
  (merged to 'next' on 2013-08-28 at 24ff8b4)
 + contacts: reduce git-blame invocations
 + contacts: gather all blame sources prior to invoking git-blame
 + contacts: validate hunk length earlier
 (this branch uses es/blame-L-more and es/blame-L-twice.)

 Originally merged to 'next' on 2013-08-14

 Will merge to 'master' in the second batch.


* fc/unpack-trees-leakfix (2013-08-13) 1 commit
  (merged to 'next' on 2013-08-28 at 3ad1f21)
 + unpack-trees: plug a memory leak

 Originally merged to 'next' on 2013-08-14

 Will merge to 'master'.


* nd/push-no-thin (2013-08-13) 1 commit
 - push: respect --no-thin

 Originally merged to 'next' on 2013-08-14

 Will merge to 'next'.


* sh/pull-rebase-preserve (2013-08-13) 1 commit
 - pull: Allow pull to preserve merges when rebasing.

 Originally merged to 'next' on 2013-08-14

 Will merge to 'next'.


* es/blame-L-more (2013-08-05) 11 commits
  (merged to 'next' on 2013-08-28 at b73cdc9)
 + blame: reject empty ranges -L,+0 and -L,-0
 + t8001/t8002: blame: demonstrate acceptance of bogus -L,+0 and -L,-0
 + blame: reject empty ranges -LX,+0 and -LX,-0
 + t8001/t8002: blame: demonstrate acceptance of bogus -LX,+0 and -LX,-0
 + log: fix -L bounds checking bug
 + t4211: retire soon-to-be unimplementable tests
 + t4211: log: demonstrate -L bounds checking bug
 + blame: fix -L bounds checking bug
 + t8001/t8002: blame: add empty file & partial-line tests
 + t8001/t8002: blame: demonstrate -L bounds checking bug
 + t8001/t8002: blame: decompose overly-large test
 (this branch is used by es/blame-L-twice and es/contacts-blame-L-multi.)

 Originally merged to 'next' on 2013-08-06

 More fixes to the code to parse the "-L" option in "log" and "blame".

 Will merge to 'master' in the second batch.


* jk/cat-file-batch-optim (2013-08-05) 1 commit
  (merged to 'next' on 2013-08-28 at 624e60d)
 + cat-file: only split on whitespace when %(rest) is used

 Originally merged to 'next' on 2013-08-06

 Rework the reverted change to `cat-file --batch-check`.

 Will merge to 'master' in the second batch.


* jn/post-receive-utf8 (2013-08-05) 3 commits
 - hooks/post-receive-email: set declared encoding to utf-8
 - hooks/post-receive-email: force log messages in UTF-8
 - hooks/post-receive-email: use plumbing instead of git log/show

 Originally merged to 'next' on 2013-08-20

 Update post-receive-email script to make sure the message contents
 and pathnames are encoded consistently in UTF-8.

 I have a feeling that it is a lost cause to solve the issue the
 topic tries to address in general, because the patch text can have
 payload in any encodings that are different from either the
 pathnames or the log message.  Patches that touch paths that use an
 encoding that conflicts with the encoding of the payload and/or the
 log message could be transferred with core.quotepath set and patch
 generated as all binary, but that would be pretty much useless.

 Will merge to 'next'.


* sb/parseopt-boolean-removal (2013-08-07) 9 commits
  (merged to 'next' on 2013-08-28 at 2f3f21f)
 + revert: use the OPT_CMDMODE for parsing, reducing code
 + checkout-index: fix negations of even numbers of -n
 + config parsing options: allow one flag multiple times
 + hash-object: replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
 + branch, commit, name-rev: ease up boolean conditions
 + checkout: remove superfluous local variable
 + log, format-patch: parsing uses OPT__QUIET
 + Replace deprecated OPT_BOOLEAN by OPT_BOOL
 + Remove deprecated OPTION_BOOLEAN for parsing arguments
 (this branch uses jc/parseopt-command-modes.)

 Convert most uses of OPT_BOOLEAN/OPTION_BOOLEAN that can use
 OPT_BOOL/OPTION_BOOLEAN which have much saner semantics, and turn
 remaining ones into OPT_SET_INT, OPT_COUNTUP, etc. as necessary.

 Will merge to 'master'.


* mb/docs-favor-en-us (2013-08-01) 1 commit
  (merged to 'next' on 2013-08-28 at 82910e5)
 + Provide some linguistic guidance for the documentation.

 Originally merged to 'next' on 2013-08-06

 Declare that the official grammar & spelling of the source of this
 project is en_US, but strongly discourage patches only to "fix"
 existing en_UK strings to avoid unnecessary churns.

 Will merge to 'master'.


* jc/parseopt-command-modes (2013-07-30) 2 commits
  (merged to 'next' on 2013-08-28 at 738b399)
 + tag: use OPT_CMDMODE
 + parse-options: add OPT_CMDMODE()
 (this branch is used by sb/parseopt-boolean-removal.)

 Many commands use --dashed-option as a operation mode selector
 (e.g. "git tag --delete") that the user can use at most one
 (e.g. "git tag --delete --verify" is a nonsense) and you cannot
 negate (e.g. "git tag --no-delete" is a nonsense).  Make it easier
 for users of parse_options() to enforce these restrictions.

 Will merge to 'master'.


* tr/log-full-diff-keep-true-parents (2013-08-05) 2 commits
  (merged to 'next' on 2013-08-28 at e86ec11)
 + log: use true parents for diff when walking reflogs
 + log: use true parents for diff even when rewriting

 Originally merged to 'next' on 2013-08-08

 Output from "git log --full-diff -- <pathspec>" looked strange,
 because comparison was done with the previous ancestor that touched
 the specified <pathspec>, causing the patches for paths outside the
 pathspec to show more than the single commit has changed.

 Tweak "git reflog -p" for the same reason using the same mechanism.

 Will merge to 'master' in the second batch.


* bc/unuse-packfile (2013-08-02) 2 commits
  (merged to 'next' on 2013-08-28 at 9029801)
 + Don't close pack fd when free'ing pack windows
 + sha1_file: introduce close_one_pack() to close packs on fd pressure

 Originally merged to 'next' on 2013-08-06

 Handle memory pressure and file descriptor pressure separately when
 deciding to release pack windows to honor resource limits.

 Will merge to 'master'.


* da/darwin (2013-08-05) 3 commits
  (merged to 'next' on 2013-08-28 at 6e4c5ae)
 + OS X: Fix redeclaration of die warning
 + Makefile: Fix APPLE_COMMON_CRYPTO with BLK_SHA1
 + imap-send: use Apple's Security framework for base64 encoding

 Originally merged to 'next' on 2013-08-05

 Will merge to 'master'.


* nd/sq-quote-buf (2013-07-30) 3 commits
  (merged to 'next' on 2013-08-28 at d0ffd55)
 + quote: remove sq_quote_print()
 + tar-tree: remove dependency on sq_quote_print()
 + for-each-ref, quote: convert *_quote_print -> *_quote_buf

 Originally merged to 'next' on 2013-08-01

 Code simplification as a preparatory step to something larger.

 Will merge to 'master'.


* jc/url-match (2013-08-09) 7 commits
  (merged to 'next' on 2013-08-28 at 2a9fd23)
 + builtin/config.c: compilation fix
 + config: "git config --get-urlmatch" parses section.<url>.key
 + builtin/config: refactor collect_config()
 + config: parse http.<url>.<variable> using urlmatch
 + config: add generic callback wrapper to parse section.<url>.key
 + config: add helper to normalize and match URLs
 + http.c: fix parsing of http.sslCertPasswordProtected variable

 Originally merged to 'next' on 2013-08-12

 Allow section.<urlpattern>.var configuration variables to be
 treated as a "virtual" section.var given a URL, and use the
 mechanism to enhance http.* configuration variables.

 This is a reroll of Kyle J. McKay's work.

 Will merge to 'master' in the second batch.


* jl/submodule-mv (2013-08-06) 5 commits
  (merged to 'next' on 2013-08-28 at 4ec6b41)
 + rm: delete .gitmodules entry of submodules removed from the work tree
 + mv: update the path entry in .gitmodules for moved submodules
 + submodule.c: add .gitmodules staging helper functions
 + mv: move submodules using a gitfile
 + mv: move submodules together with their work trees
 (this branch uses nd/magic-pathspec.)

 Originally merged to 'next' on 2013-08-08

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Will merge to 'master' in the second batch.


* nd/clone-connectivity-shortcut (2013-07-23) 1 commit
  (merged to 'next' on 2013-08-28 at d227f9f)
 + smart http: use the same connectivity check on cloning

 Originally merged to 'next' on 2013-07-30

 Will merge to 'master' in the second batch.


* db/http-savecookies (2013-08-05) 2 commits
  (merged to 'next' on 2013-08-28 at 22a8464)
 + t5551: Remove header from curl cookie file
 + http: add http.savecookies option to write out HTTP cookies

 Originally merged to 'next' on 2013-08-05

 Will merge to 'master' in the second batch.


* rr/feed-real-path-to-editor (2013-07-29) 1 commit
  (merged to 'next' on 2013-08-28 at 7458fa4)
 + editor: use canonicalized absolute path

 Originally merged to 'next' on 2013-07-30

 Will merge to 'master'.


* rj/doc-rev-parse (2013-07-22) 2 commits
  (merged to 'next' on 2013-08-28 at 0fce928)
 + rev-parse(1): logically group options
 + rev-parse: remove restrictions on some options

 Originally merged to 'next' on 2013-07-22

 Will merge to 'master'.


* jk/fast-import-empty-ls (2013-06-23) 4 commits
  (merged to 'next' on 2013-08-28 at 876a39d)
 + fast-import: allow moving the root tree
 + fast-import: allow ls or filecopy of the root tree
 + fast-import: set valid mode on root tree in "ls"
 + t9300: document fast-import empty path issues

 Originally merged to 'next' on 2013-07-22

 Will merge to 'master'.


* jc/diff-filter-negation (2013-07-19) 6 commits
  (merged to 'next' on 2013-08-28 at 5cc7720)
 + diff: deprecate -q option to diff-files
 + diff: allow lowercase letter to specify what change class to exclude
 + diff: reject unknown change class given to --diff-filter
 + diff: preparse --diff-filter string argument
 + diff: factor out match_filter()
 + diff: pass the whole diff_options to diffcore_apply_filter()
 (this branch is used by jc/hold-diff-remove-q-synonym-for-no-deletion.)

 Originally merged to 'next' on 2013-07-22

 Teach "git diff --diff-filter" to express "I do not want to see
 these classes of changes" more directly by listing only the
 unwanted ones in lowercase (e.g. "--diff-filter=d" will show
 everything but deletion) and deprecate "diff-files -q" which did
 the same thing as "--diff-filter=d".

 Will merge to 'master' in the second batch.


* nd/magic-pathspec (2013-07-23) 48 commits
  (merged to 'next' on 2013-08-28 at 305c6e9)
 + rm: do not set a variable twice without intermediate reading.
 + t6131 - skip tests if on case-insensitive file system
 + parse_pathspec: accept :(icase)path syntax
 + pathspec: support :(glob) syntax
 + pathspec: make --literal-pathspecs disable pathspec magic
 + pathspec: support :(literal) syntax for noglob pathspec
 + kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 + parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 + parse_pathspec: make sure the prefix part is wildcard-free
 + rename field "raw" to "_raw" in struct pathspec
 + tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 + remove match_pathspec() in favor of match_pathspec_depth()
 + remove init_pathspec() in favor of parse_pathspec()
 + remove diff_tree_{setup,release}_paths
 + convert common_prefix() to use struct pathspec
 + convert add_files_to_cache to take struct pathspec
 + convert {read,fill}_directory to take struct pathspec
 + convert refresh_index to take struct pathspec
 + convert report_path_error to take struct pathspec
 + checkout: convert read_tree_some to take struct pathspec
 + convert unmerge_cache to take struct pathspec
 + convert run_add_interactive to use struct pathspec
 + convert read_cache_preload() to take struct pathspec
 + line-log: convert to use parse_pathspec
 + reset: convert to use parse_pathspec
 + add: convert to use parse_pathspec
 + check-ignore: convert to use parse_pathspec
 + archive: convert to use parse_pathspec
 + ls-files: convert to use parse_pathspec
 + rm: convert to use parse_pathspec
 + checkout: convert to use parse_pathspec
 + rerere: convert to use parse_pathspec
 + status: convert to use parse_pathspec
 + commit: convert to use parse_pathspec
 + clean: convert to use parse_pathspec
 + guard against new pathspec magic in pathspec matching code
 + parse_pathspec: support prefixing original patterns
 + parse_pathspec: support stripping/checking submodule paths
 + parse_pathspec: support stripping submodule trailing slashes
 + parse_pathspec: add special flag for max_depth feature
 + convert some get_pathspec() calls to parse_pathspec()
 + parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL} flags
 + parse_pathspec: save original pathspec for reporting
 + add parse_pathspec() that converts cmdline args to struct pathspec
 + pathspec: add copy_pathspec
 + pathspec: i18n-ize error strings in pathspec parsing code
 + move struct pathspec and related functions to pathspec.[ch]
 + clean: remove unused variable "seen"
 (this branch is used by jl/submodule-mv.)

 Originally merged to 'next' on 2013-07-23

 Use "struct pathspec" interface in more places, instead of array of
 characters, the latter of which cannot express magic pathspecs
 (e.g. ":(icase)makefile" that matches both Makefile and makefile).

 Will merge to 'master' in the second batch.


* jc/check-x-z (2013-07-11) 4 commits
  (merged to 'next' on 2013-08-28 at a7670ce)
 + check-attr -z: a single -z should apply to both input and output
 + check-ignore -z: a single -z should apply to both input and output
 + check-attr: the name of the character is NUL, not NULL
 + check-ignore: the name of the character is NUL, not NULL

 Originally merged to 'next' on 2013-07-15

 "git check-ignore -z" applied the NUL termination to both its input
 (with --stdin) and its output, but "git check-attr -z" ignored the
 option on the output side.

 This is potentially a backward incompatible fix.  Let's see if
 anybody screams before deciding if we want to do anything to help
 existing users (there may be none).

 Will merge to 'master'.


* ms/fetch-prune-configuration (2013-07-18) 1 commit
  (merged to 'next' on 2013-08-28 at fa6ffc7)
 + fetch: make --prune configurable

 Originally merged to 'next' on 2013-07-21

 Allow fetch.prune and remote.*.prune configuration variables to be set,
 and "git fetch" to behave as if "--prune" is given.

 "git fetch" that honors remote.*.prune is fine, but I wonder if we
 should somehow make "git push" aware of it as well.  Perhaps
 remote.*.prune should not be just a boolean, but a 4-way "none",
 "push", "fetch", "both"?

 Will merge to 'master' in the second batch.


* km/svn-1.8-serf-only (2013-07-18) 3 commits
  (merged to 'next' on 2013-08-28 at 1119134)
 + Git.pm: revert _temp_cache use of temp_is_locked
 + git-svn: allow git-svn fetching to work using serf
 + Git.pm: add new temp_is_locked function

 Originally merged to 'next' on 2013-07-19

 Subversion 1.8.0 that was recently released breaks older subversion
 clients coming over http/https in various ways.

 Will merge to 'master'.


* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Will hold, until we get any user.


* jc/push-cas (2013-08-02) 9 commits
  (merged to 'next' on 2013-08-28 at 784281f)
 + push: teach --force-with-lease to smart-http transport
 + send-pack: fix parsing of --force-with-lease option
 + t5540/5541: smart-http does not support "--force-with-lease"
 + t5533: test "push --force-with-lease"
 + push --force-with-lease: tie it all together
 + push --force-with-lease: implement logic to populate old_sha1_expect[]
 + remote.c: add command line option parser for "--force-with-lease"
 + builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
 + cache.h: move remote/connect API out of it

 Originally merged to 'next' on 2013-08-05

 Allow a safer "rewind of the remote tip" push than blind "--force",
 by requiring that the overwritten remote ref to be unchanged since
 the new history to replace it was prepared.

 The machinery is more or less ready.  The "--force" option is again
 the big red button to override any safety, thanks to J6t's sanity
 (the original round allowed --lockref to defeat --force).

 The logic to choose the default implemented here is fragile
 (e.g. "git fetch" after seeing a failure will update the
 remote-tracking branch and will make the next "push" pass,
 defeating the safety pretty easily).  It is suitable only for the
 simplest workflows, and it may hurt users more than it helps them.

 Will merge to 'master' in the second batch.


* jc/pull-training-wheel (2013-07-19) 1 commit
  (merged to 'next' on 2013-08-28 at c39bd15)
 + pull: require choice between rebase/merge on non-fast-forward pull

 Originally merged to 'next' on 2013-07-22

 Make "git pull" (without arguments that say what branch to
 integrate from where) refuse with "it does not fast forward; choose
 between 'pull --merge' and 'pull --rebase'".

 See

 http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225326
 http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=229221

 for full discussion.

 Will merge to 'master' in the second batch.


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
 - diff: remove "diff-files -q" in a version of Git in a distant future
 (this branch uses jc/diff-filter-negation.)

 Will cook in 'next' until a distant future.

--------------------------------------------------
[Discarded]

* jh/remote-hg-fetch-fix (2013-07-25) 2 commits
 . Revert "remotes-hg: bugfix for fetching non local remotes"
 . remotes-hg: bugfix for fetching non local remotes


* km/http-curl-config-per-url (2013-07-31) 7 commits
 . Revert km/http-curl-config-per-url in its entirety
 . docs: update http.<url>.* options documentation
 . config: allow http.<url>.* any user matching
 . tests: add new test for the url_normalize function
 . config: improve support for http.<url>.* settings
 . config: add support for http.<url>.* settings
 . http.c: fix parsing of http.sslCertPasswordProtected variable

 Reverted to be replaced with a reroll (jc/url-match topic).


* sb/fsck-opt-bool (2013-07-29) 1 commit
 . fsck: Replace deprecated OPT_BOOLEAN by OPT_BOOL

 sb/parseopt-boolean-removal contains the moral equivalent of this
 change.
