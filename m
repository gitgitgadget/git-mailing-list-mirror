From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2012, #07; Thu, 31)
Date: Thu, 31 May 2012 16:13:29 -0700
Message-ID: <7vfwag54h2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 01:13:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaEYm-0003N2-6U
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 01:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270Ab2EaXNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 19:13:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758594Ab2EaXNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 19:13:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D63729BB0;
	Thu, 31 May 2012 19:13:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	oMUAquDvgomv80m3p7vBpYEkMM=; b=p5twBBsQRlX3ACpRl+85BPFw/pCFkuJG3
	luWeI6SDneTmT+VEwEWi/c9vYtYC/HJitcs2i3u6EmNdiGn9+KwmnFsqAmEoRtoo
	ie9ivl3Ade/RSnf2DXp6PQfChbRmC+M+R3+Vpr3CxXhGwL01P5rvGcgF9nM4rSF3
	IX5l333jVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=RC0
	yTZH0GTdJeVbX8KIyDc7l3pEn10xSHNlt0YV66J46FH2K1b16tWCtQUwYD4yFHlt
	FdjomiyUZqCrDuzXHbY+NBVacCxRYV4DrlviptVMvwiVDWYgpqfL9eMkKqV8eo3L
	ryY1zDG2PYSfIvM+RPwNK0SvNaXrbB+uJHGUxhys=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC8389BAF;
	Thu, 31 May 2012 19:13:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA8999BAE; Thu, 31 May 2012
 19:13:30 -0400 (EDT)
X-master-at: b2478aa0858811c29061ed32c2686468b89d7296
X-next-at: 11af7cdeca7ffbfb4387fb8253081fd22c3dd697
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CA41EB0-AB76-11E1-A823-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198952>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

I am planning to merge topics that are in 'next' soonish and tag
v1.7.11-rc1 before the next week starts.  Everything else on 'pu'
will have to wait until the next cycle; please concentrate on
finding and fixing regressions since 1.7.10 from now on.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ap/checkout-no-progress-for-non-tty (2012-05-24) 1 commit
  (merged to 'next' on 2012-05-24 at dc473bd)
 + checkout: no progress messages if !isatty(2).

"git checkout" gave progress display even when the standard error
stream was not connected to the tty, which made little sense.

* fc/git-complete-helper-fix (2012-05-20) 2 commits
  (merged to 'next' on 2012-05-23 at 6124da2)
 + completion: add support for backwards compatibility
 + completion: rename internal helpers _git and _gitk

Would help people who relied on (unofficial) _git/_gitk helper in their
completion tweaks.

* jk/fetch-pack-remove-dups-optim (2012-05-24) 6 commits
  (merged to 'next' on 2012-05-24 at cf56fe6)
 + fetch-pack: sort incoming heads list earlier
  (merged to 'next' on 2012-05-23 at 6057c21)
 + fetch-pack: avoid quadratic loop in filter_refs
 + fetch-pack: sort the list of incoming refs
 + add sorting infrastructure for list refs
 + fetch-pack: avoid quadratic behavior in remove_duplicates
 + fetch-pack: sort incoming heads

The way "fetch-pack" that is given multiple references to fetch tried to
remove duplicates was very inefficient.

* jk/format-person-part-buffer-limit (2012-05-22) 1 commit
  (merged to 'next' on 2012-05-23 at ef025b0)
 + pretty: avoid buffer overflow in format_person_part

* jk/ident-gecos-strbuf (2012-05-24) 22 commits
  (merged to 'next' on 2012-05-24 at 7148763)
 + format-patch: do not use bogus email addresses in message ids
 + ident: reject bogus email addresses with IDENT_STRICT
 + ident: rename IDENT_ERROR_ON_NO_NAME to IDENT_STRICT
 + format-patch: use GIT_COMMITTER_EMAIL in message ids
 + ident: let callers omit name with fmt_indent
 + ident: refactor NO_DATE flag in fmt_ident
 + ident: reword empty ident error message
  (merged to 'next' on 2012-05-23 at 6fce816)
 + format-patch: refactor get_patch_filename
 + ident: trim whitespace from default name/email
 + ident: use a dynamic strbuf in fmt_ident
 + ident: use full dns names to generate email addresses
 + ident: report passwd errors with a more friendly message
 + drop length limitations on gecos-derived names and emails
 + ident: don't write fallback username into git_default_name
 + fmt_ident: drop IDENT_WARN_ON_NO_NAME code
 + format-patch: use default email for generating message ids
 + ident: trim trailing newline from /etc/mailname
 + move git_default_* variables to ident.c
 + move identity config parsing to ident.c
 + fmt-merge-msg: don't use static buffer in record_person
 + http-push: do not access git_default_email directly
 + ident: split setup_ident into separate functions

Fixes quite a lot of brokenness when ident information needs to be taken
from the system and cleans up the code.

* jk/ident-split-fix (2012-05-22) 1 commit
  (merged to 'next' on 2012-05-23 at 811c9ec)
 + fix off-by-one error in split_ident_line

An author/committer name that is a single character was mishandled as an
invalid name by mistake.

* jk/pretty-commit-header-incomplete-line (2012-05-22) 1 commit
  (merged to 'next' on 2012-05-23 at f788433)
 + avoid segfault when reading header of malformed commits

* mh/fetch-pack-constness (2012-05-22) 4 commits
  (merged to 'next' on 2012-05-23 at be95121)
 + cmd_fetch_pack(): respect constness of argv parameter
 + cmd_fetch_pack(): combine the loop termination conditions
 + cmd_fetch_pack(): handle non-option arguments outside of the loop
 + cmd_fetch_pack(): declare dest to be const

Tighten constness of some local variables in a callchain.

* mh/ref-api (2012-05-24) 1 commit
  (merged to 'next' on 2012-05-24 at c8d54c0)
 + Avoid sorting if references are added to ref_cache in order

* mh/ref-api-lazy-loose (2012-05-20) 1 commit
  (merged to 'next' on 2012-05-23 at c41a30a)
 + free_ref_entry(): do not trigger reading of loose refs

The code to lazily read loose refs by mistake unnecessarily read the refs
in a subhierarchy when we free the data for the subhierarchy.

* mh/test-keep-prove-cache (2012-05-20) 1 commit
  (merged to 'next' on 2012-05-23 at 870d1f9)
 + t/Makefile: retain cache t/.prove across prove runs

* ng/pack-objects-cleanup (2012-05-18) 2 commits
  (merged to 'next' on 2012-05-23 at f90b1ba)
 + pack-objects: refactor write_object() into helper functions
 + pack-objects, streaming: turn "xx >= big_file_threshold" to ".. > .."

* rs/dir-strbuf-read-recursive-fix (2012-05-11) 2 commits
  (merged to 'next' on 2012-05-23 at 2e22549)
 + dir: simplify fill_directory()
 + dir: respect string length argument of read_directory_recursive()

* rs/maint-grep-F (2012-05-21) 4 commits
  (merged to 'next' on 2012-05-23 at b24143c)
 + grep: stop leaking line strings with -f
 + grep: support newline separated pattern list
 + grep: factor out do_append_grep_pat()
 + grep: factor out create_grep_pat()

"git grep -e '$pattern'", unlike the case where the patterns are read from
a file, did not treat individual lines in the given pattern argument as
separate regular expressions as it should.

* rs/refs-string-slice (2012-05-22) 4 commits
  (merged to 'next' on 2012-05-23 at d224de1)
 + refs: do not create ref_entry when searching
 + refs: use strings directly in find_containing_dir()
 + refs: convert parameter of create_dir_entry() to length-limited string
 + refs: convert parameter of search_ref_dir() to length-limited string

Avoid unnecessary temporary allocations while looking for matching refs
inside refs API.

* rs/xdiff-fast-hash-fix (2012-05-23) 3 commits
  (merged to 'next' on 2012-05-23 at 8df26a5)
 + xdiff: import new 32-bit version of count_masked_bytes()
 + xdiff: avoid more compiler warnings with XDL_FAST_HASH on 32-bit machines
 + xdiff: avoid compiler warnings with XDL_FAST_HASH on 32-bit machines

* sp/sh-windows-pwd (2012-05-16) 1 commit
  (merged to 'next' on 2012-05-23 at 63004c3)
 + git-sh-setup: define workaround wrappers before they are used

* va/git-p4-test (2012-05-23) 2 commits
 - git-p4: Verify detection of "empty" branch creation
 - git-p4: Test changelists touching two branches

Rerolled and Acked by Pete.

--------------------------------------------------
[New Topics]

* jl/submodule-report-new-path-once (2012-05-29) 1 commit
  (merged to 'next' on 2012-05-30 at e482dd9)
 + submodules: print "registered for path" message only once

Will merge to master by 1.7.11 final.

* mm/levenstein-penalize-deletion-less (2012-05-29) 1 commit
  (merged to 'next' on 2012-05-30 at b2a0346)
 + Reduce cost of deletion in levenstein distance (4 -> 3)

Will merge to master by 1.7.11 final.

* nd/exclude-workaround-top-heavy (2012-05-29) 2 commits
 - exclude: do strcmp as much as possible before fnmatch
 - Unindent excluded_from_list()

* nd/stream-pack-objects (2012-05-29) 1 commit
 - pack-objects: use streaming interface for reading large loose blobs

* vr/rebase-autosquash-does-not-imply-i (2012-05-29) 1 commit
  (merged to 'next' on 2012-05-30 at 10dd3af)
 + Do not autosquash in case of an implied interactive rebase

Will merge to master by 1.7.11 final.

* nh/empty-rebase (2012-05-29) 1 commit
  (merged to 'next' on 2012-05-30 at 270703a)
 + cherry-pick: regression fix for empty commits

Will merge to master by 1.7.11 final.

* ef/maint-rebase-error-message (2012-05-30) 1 commit
  (merged to 'next' on 2012-05-30 at 5194fe3)
 + rebase: report invalid commit correctly

Will merge to master by 1.7.11 final.

* jk/clone-local (2012-05-30) 2 commits
 - clone: allow --no-local to turn off local optimizations
 - docs/clone: mention that --local may be ignored

* jk/no-more-asciidoc7 (2012-05-30) 2 commits
 - docs: drop antique comment from Makefile
 - docs: drop asciidoc7compatible flag

* jk/no-op-push-message (2012-05-30) 1 commit
 - improve no-op push output

* ef/http-o-depends-on-gvf (2012-05-31) 1 commit
  (merged to 'next' on 2012-05-31 at 11af7cd)
 + Makefile: add missing GIT-VERSION-FILE dependency

Will merge to master by 1.7.11 final.

--------------------------------------------------
[Stalled]

* nl/http-proxy-more (2012-05-11) 2 commits
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice

I queued only the later two patches from this series, even though they do
not make much sense without the first one that seems to need a bit more
work, so that we won't forget.

* sg/bash-prompt (2012-05-09) 4 commits
 - completion: respect $GIT_DIR
 - completion: use __gitdir() in _git_log()
 - tests: add tests for the bash prompt functions in the completion script
 - tests: move code to run tests under bash into a helper library
 (this branch is tangled with fc/git-prompt-script.)

This is only the "correction" bits taken from the beginning of a larger
series that is to be rerolled.  The first two are tangled with Felipe's
topic so a reroll, if comes, should build on top of them.

* jc/apply-3way (2012-05-16) 12 commits
 - WIP: the message is bogus in apply:::check_patch()
 - apply: refactor "previous patch" logic
 - apply: a bit more comments on PATH_TO_BE_DELETED
 - apply: document --3way option
 - apply: allow rerere() upon --3way results
 - apply: register conflicted stages to the index
 - apply: plug the three-way merge logic in
 - apply: fall back on three-way merge
 - apply: accept -3/--3way command line option
 - apply: split load_preimage() helper function out
 - apply: refactor read_file_or_gitlink()
 - apply: clear_image() clears things a bit more

"git apply" learns to wiggle the base version and perform three-way merge
when a patch does not exactly apply to the version you have.

It turns out that it is somewhat unpleasant to handle add/add conflicts in
this code, but it seems necessary if we want to use "apply -3" to replace
the use of "apply --build-fake-ancestor" followed by the slow "merge" in
"am -3".

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
Not ready.
There still seem to be other bugs hiding (e.g. try pushing twice).

* jc/run-hook-env-1 (2012-03-11) 1 commit
 - run_hook(): enhance the interface to pass arbitrary environment

Not urgent.

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks.

* jc/split-blob (2012-04-03) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* fc/git-prompt-script (2012-05-22) 5 commits
 - completion: split __git_ps1 into a separate script
 - completion: remove executable mode
 - Merge branch 'fc/git-complete-helper' into fc/git-prompt-script
 - tests: add tests for the bash prompt functions in the completion script
 - tests: move code to run tests under bash into a helper library
 (this branch is tangled with sg/bash-prompt.)

The last remaining sticking point is what to do with the duplicated shell
function.

* cr/persistent-https (2012-05-30) 1 commit
 - Add persistent-https to contrib

A remote helper that acts as a proxy that caches ssl session for the
https:// transport is added to the contrib/ area.

* nd/stream-index-pack (2012-05-24) 4 commits
 - index-pack: use streaming interface for collision test on large blobs
 - index-pack: factor out unpack core from get_data_from_pack
 - index-pack: use streaming interface on large blobs (most of the time)
 - index-pack: hash non-delta objects while reading from stream

Use streaming API to read from the object store to avoid having to hold
a large blob object in-core while running index-pack.

* js/submodule-relative (2012-05-29) 3 commits
 - t7403-*.sh: Avoid use of the nonportable '==' operator
 - submodule: fix handling of relative superproject origin URLs
 - submodule: document handling of relative superproject origin URLs

Reroll went to v7 but hasn't settled yet.

* mm/push-default-switch-warning (2012-04-26) 2 commits
 - t5541: warning message is given even with --quiet
 - push: start warning upcoming default change for push.default

Will squash the two, but this has to wait for a few release cycles.

--------------------------------------------------
[Discarded]

* cb/daemon-test-race-fix (2012-04-27) 2 commits
  (merged to 'next' on 2012-04-27 at 84bbcf8)
 + Revert "git-daemon wrapper to wait until daemon is ready"
  (merged to 'next' on 2012-04-24 at d5c30be)
 + git-daemon wrapper to wait until daemon is ready

Reverted from 'next' to replace it with js/daemon-test-race-fix.

* jc/revert-nh-empty-rebase (2012-05-23) 1 commit
 . Revert nh/empty-rebase topic

The earlier series was found to regress the more important "cherry-pick";
I'd prefer to see it fixed, but in case if it does not happen soon, this
is a fallback measure that can be merged before 1.7.11 final.
