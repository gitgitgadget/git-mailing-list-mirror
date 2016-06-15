From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2011, #12; Thu, 26)
Date: Thu, 26 May 2011 09:02:08 -0700
Message-ID: <7vd3j5zbzz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 18:02:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPd0w-0006xh-CJ
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889Ab1EZQCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 12:02:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757113Ab1EZQCN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 12:02:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F7B24B41;
	Thu, 26 May 2011 12:04:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	K/4sKRPZ0lkyjqoYk86ZmbBBlU=; b=bW6Q0NoAQvTVpI7KjV9A29tIRQhgRCU8D
	Iq69n5tyAKpX2lvq3j+01g6XqQO2zI7P1L+JH3CR2s199urVlXImoLDsKywE8X6c
	1O0lJaE8sckq9XUNIp6k27ybnWwa90YLRWH0PIWtfyNpKqcDMEwtbR7at7lQVbEb
	R4j4m2UXlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=kgk
	r1QSJarbNRvWFzC7ANxbAZVmuqBBsZJApZl8hgahtpqvGCKueESg/wkzBBTC5cJ1
	FujoL0Ea4LxZEomWfJH/0I7URzLX1ZxrE3Va17AgaVP6XbZY8el9mUbv/jBf0AmE
	AVXqkxlcoi4NmEIT/4dPWB2Xep0/OFm0EPUhYZEc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B8EB4B3F;
	Thu, 26 May 2011 12:04:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 199984B3B; Thu, 26 May 2011
 12:04:16 -0400 (EDT)
X-master-at: 5cfe4256d98af22a570c78c5e3048391a90f5f98
X-next-at: 9f46ca0aec6956294992cda67b91c2fc82a8efa6
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0220952-87B1-11E0-9383-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174537>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

The main part of this cycle is expected to run thru May, aiming for a
feature freeze in early June.

We are in the middle of week #5 of this cycle. Let's plan to tag -rc0 with
what is in 'master' at the end of the month.

--------------------------------------------------
[New Topics]

* jc/fmt-req-fix (2011-05-25) 1 commit
  (merged to 'next' on 2011-05-25 at 9f46ca0)
 + userformat_find_requirements(): find requirement for the correct format

* jk/maint-config-alias-fix (2011-05-24) 4 commits
  (merged to 'next' on 2011-05-25 at 25b86e4)
 + handle_options(): do not miscount how many arguments were used
 + config: always parse GIT_CONFIG_PARAMETERS during git_config
 + git_config: don't peek at global config_parameters
 + config: make environment parsing routines static

--------------------------------------------------
[Graduated to "master"]

* jc/bigfile (2011-05-13) 3 commits
  (merged to 'next' on 2011-05-15 at 0ee7144)
 + Bigfile: teach "git add" to send a large file straight to a pack
 + index_fd(): split into two helper functions
 + index_fd(): turn write_object and format_check arguments into one flag
 (this branch is used by jc/streaming and jc/streaming-filter.)

This covers the entry point for a big file to the system. Other parts that
need to know about them are the exit point (i.e. write_entry()), packing
and repacking (as long as bigfilethreshold is sane this should work),
diffs and status (avoid slurping large binary in core only to do nothing,
which we already should), and transport (receive-pack/fetch-pack call
either unpack-objects or index-pack, which still want to hold the full
object in-core and need to be fixed).

* js/log-abbrev-commit-config (2011-05-18) 2 commits
  (merged to 'next' on 2011-05-23 at 4e7e932)
 + Add log.abbrevCommit config variable
 + "git log -h": typofix misspelled 'suppress'

--------------------------------------------------
[Stalled]

* mg/diff-stat-count (2011-05-03) 2 commits
 - diff-options.txt: describe --stat-{width,name-width,count}
 - diff: introduce --stat-count to limit the stat lines

There was a miscounting spotted.  Needs another round.

* jk/maint-merge-rename-create (2011-03-25) 3 commits
 - merge: turn on rewrite detection
 - merge: handle renames with replacement content
 - t3030: fix accidental success in symlink rename

Peff wanted to reroll this.

* jc/index-pack (2011-02-27) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP. Need to put histogram output into index-pack --verify to
really kill verify-pack.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

--------------------------------------------------
[Cooking]

* jl/read-tree-m-dry-run (2011-05-25) 2 commits
 - Teach read-tree the -n|--dry-run option
 - unpack-trees: add the dry_run flag to unpack_trees_options

Will merge to "next".

* da/git-prefix-everywhere (2011-05-23) 3 commits
 - git-mergetool--lib: Make vimdiff retain the current directory
 - git: Remove handling for GIT_PREFIX
 - setup: Provide GIT_PREFIX to built-ins

Is everybody happy with this?
Will merge to "next".

* jh/receive-count-limit (2011-05-23) 10 commits
 - receive-pack: Allow server to refuse pushes with too many objects
 - pack-objects: Estimate pack size; abort early if pack size limit is exceeded
 - send-pack/receive-pack: Allow server to refuse pushing too large packs
 - pack-objects: Allow --max-pack-size to be used together with --stdout
 - send-pack/receive-pack: Allow server to refuse pushes with too many commits
 - pack-objects: Teach new option --max-commit-count, limiting #commits in pack
 - receive-pack: Prepare for addition of the new 'limit-*' family of capabilities
 - Tighten rules for matching server capabilities in server_supports()
 - send-pack: Attempt to retrieve remote status even if pack-objects fails
 - Update technical docs to reflect side-band-64k capability in receive-pack

Would need another round to separate per-pack and per-session limits.

* jc/require-work-tree-exists (2011-05-24) 1 commit
  (merged to 'next' on 2011-05-24 at 6dbbf00)
 + require-work-tree wants more than what its name says

Rerolled _without_ any in-tree users, just to make sure that we can easily
adapt scripts when necessary in the future.

Will merge to "master" by the end of week #5.

* jn/gitweb-js (2011-05-24) 11 commits
  (merged to 'next' on 2011-05-24 at c385b9d)
 + gitweb: Make JavaScript ability to adjust timezones configurable
 + gitweb.js: Add UI for selecting common timezone to display dates
 + gitweb: JavaScript ability to adjust time based on timezone
 + gitweb: Unify the way long timestamp is displayed
 + gitweb: Refactor generating of long dates into format_timestamp_html
 + gitweb.js: Provide getElementsByClassName method (if it not exists)
 + gitweb.js: Introduce code to handle cookies from JavaScript
 + gitweb.js: Extract and improve datetime handling
 + gitweb.js: Provide default values for padding in padLeftStr and padLeft
 + gitweb.js: Update and improve comments in JavaScript files
 + gitweb: Split JavaScript for maintability, combining on build

Rebased on top of a more recent "master" that already has the two bottom
commits in the previous round of series.

Will merge to "master" by the end of week #5.

* jn/ctags-more (2011-04-29) 3 commits
  (merged to 'next' on 2011-05-24 at 41b50be)
 + gitweb: Optional grouping of projects by category
 + gitweb: Modularized git_get_project_description to be more generic
 + gitweb: Split git_project_list_body in two functions

As nobody seems to be helping gitweb maintenance, I'll merge the above two
series to "master" and see if anybody screams. That seems to be the only
way to make any progress.

Will merge to "master" by the end of week #5.

* jc/notes-batch-removal (2011-05-19) 4 commits
  (merged to 'next' on 2011-05-23 at 5bd78a6)
 + show: --ignore-missing
 + notes remove: --stdin reads from the standard input
 + notes remove: --ignore-missing
 + notes remove: allow removing more than one

Will merge to "master" by the end of week #5.

* jk/fetch-mark-complete-optimization (2011-05-19) 1 commit
  (merged to 'next' on 2011-05-23 at b56fb81)
 + fetch: avoid repeated commits in mark_complete

Trivially correct.
Will merge to "master" by the end of week #5.

* jk/haves-from-alternate-odb (2011-05-19) 3 commits
  (merged to 'next' on 2011-05-23 at 53b4735)
 + receive-pack: eliminate duplicate .have refs
 + bisect: refactor sha1_array into a generic sha1 list
 + refactor refs_from_alternate_cb to allow passing extra data

Will merge to "master" by the end of week #5.

* rg/no-gecos-in-pwent (2011-05-19) 1 commit
  (merged to 'next' on 2011-05-23 at d2c4c33)
 + ident: add NO_GECOS_IN_PWENT for systems without pw_gecos in struct passwd

Trivially correct and not intrusive, but the real value unknown.
Will merge to "master" by the end of week #5.

* jc/streaming-filter (2011-05-24) 8 commits
 - t0021: test application of both crlf and ident
 - t0021-conversion.sh: fix NoTerminatingSymbolAtEOF test
 - streaming: filter cascading
 - streaming filter: ident filter
 - Add LF-to-CRLF streaming conversion
 - stream filter: add "no more input" to the filters
 - Add streaming filter API
 - convert.h: move declarations for conversion from cache.h
 (this branch uses jc/streaming.)

Trivial lf-to-crlf and ident conversions can be performed without reading
everything in-core first.
Not urgent. Will not merge before 1.7.6.

* jn/userdiff-perl-updates (2011-05-23) 8 commits
  (merged to 'next' on 2011-05-23 at 2595ae1)
 + userdiff/perl: tighten BEGIN/END block pattern to reject here-doc delimiters
 + tests: make test_expect_code quieter on success
 + userdiff/perl: catch sub with brace on second line
 + userdiff/perl: match full line of POD headers
 + userdiff/perl: anchor "sub" and "package" patterns on the left
 + t4018 (funcname patterns): minor cleanups
 + t4018 (funcname patterns): make configuration easier to track
 + t4018 (funcname patterns): make .gitattributes state easier to track

Will merge to "master" by the end of week #5.

* jk/combine-diff-binary-etc (2011-05-24) 5 commits
  (merged to 'next' on 2011-05-24 at 07cf180)
 + combine-diff: respect textconv attributes
 + refactor get_textconv to not require diff_filespec
 + combine-diff: handle binary files as binary
 + combine-diff: calculate mode_differs earlier
 + combine-diff: split header printing into its own function

Will merge to "master" by the end of month.

* jc/advice-about-to-lose-commit (2011-05-24) 1 commit
 - checkout: make advice when reattaching the HEAD less loud

Re-rolled and resurrected from "Stalled" status.
Will merge to "next".

* jc/streaming (2011-05-20) 13 commits
  (merged to 'next' on 2011-05-23 at 7fd0b52)
 + streaming: read loose objects incrementally
 + sha1_file.c: expose helpers to read loose objects
 + streaming: read non-delta incrementally from a pack
 + streaming_write_entry(): support files with holes
 + convert: CRLF_INPUT is a no-op in the output codepath
 + streaming_write_entry(): use streaming API in write_entry()
 + streaming: a new API to read from the object store
 + write_entry(): separate two helper functions out
 + unpack_object_header(): make it public
 + sha1_object_info_extended(): hint about objects in delta-base cache
 + sha1_object_info_extended(): expose a bit more info
 + packed_object_info_detail(): do not return a string
 + Merge branches 'jc/convert', 'jc/bigfile' and 'jc/replacing' into jc/streaming
 (this branch is used by jc/streaming-filter.)

Not urgent. Will not merge before 1.7.6.

* ab/i18n-scripts (2011-05-21) 48 commits
  (merged to 'next' on 2011-05-23 at 69164a3)
 + i18n: git-bisect bisect_next_check "You need to" message
 + i18n: git-bisect [Y/n] messages
 + i18n: git-bisect bisect_replay + $1 messages
 + i18n: git-bisect bisect_reset + $1 messages
 + i18n: git-bisect bisect_run + $@ messages
 + i18n: git-bisect die + eval_gettext messages
 + i18n: git-bisect die + gettext messages
 + i18n: git-bisect echo + eval_gettext message
 + i18n: git-bisect echo + gettext messages
 + i18n: git-bisect gettext + echo message
 + i18n: git-bisect add git-sh-i18n
 + i18n: git-stash drop_stash say/die messages
 + i18n: git-stash "unknown option" message
 + i18n: git-stash die + eval_gettext $1 messages
 + i18n: git-stash die + eval_gettext $* messages
 + i18n: git-stash die + eval_gettext messages
 + i18n: git-stash die + gettext messages
 + i18n: git-stash say + gettext messages
 + i18n: git-stash echo + gettext message
 + i18n: git-stash add git-sh-i18n
 + i18n: git-submodule "blob" and "submodule" messages
 + i18n: git-submodule "path not initialized" message
 + i18n: git-submodule "[...] path is ignored" message
 + i18n: git-submodule "Entering [...]" message
 + i18n: git-submodule $errmsg messages
 + i18n: git-submodule "Submodule change[...]" messages
 + i18n: git-submodule "cached cannot be used" message
 + i18n: git-submodule $update_module say + die messages
 + i18n: git-submodule die + eval_gettext messages
 + i18n: git-submodule say + eval_gettext messages
 + i18n: git-submodule echo + eval_gettext messages
 + i18n: git-submodule add git-sh-i18n
 + i18n: git-pull eval_gettext + warning message
 + i18n: git-pull eval_gettext + die message
 + i18n: git-pull die messages
 + i18n: git-pull add git-sh-i18n
 + i18n: git-am printf(1) message to eval_gettext
 + i18n: git-am core say messages
 + i18n: git-am "Falling back" say message
 + i18n: git-am "Apply?" message
 + i18n: git-am clean_abort messages
 + i18n: git-am cannot_fallback messages
 + i18n: git-am die messages
 + i18n: git-am gettext + gettext to stderr message
 + i18n: git-am eval_gettext messages
 + i18n: git-am multi-line getttext $msg; echo
 + i18n: git-am one-line gettext $msg; echo
 + i18n: git-am add git-sh-i18n

Rerolled.

* mk/grep-pcre (2011-05-23) 13 commits
  (merged to 'next' on 2011-05-23 at fbd4877)
 + git-grep: Update tests (mainly for -P)
  (merged to 'next' on 2011-05-16 at 0c6c25e)
 + Makefile: Pass USE_LIBPCRE down in GIT-BUILD-OPTIONS
 + git-grep: update tests now regexp type is "last one wins"
  (merged to 'next' on 2011-05-15 at d110135)
 + git-grep: do not die upon -F/-P when grep.extendedRegexp is set.
 + git-grep: Bail out when -P is used with -F or -E
 + grep: Add basic tests
 + configure: Check for libpcre
 + git-grep: Learn PCRE
 + grep: Extract compile_regexp_failed() from compile_regexp()
 + grep: Fix a typo in a comment
  (merged to 'next' on 2011-05-08 at 5d3bede)
 + grep: Put calls to fixmatch() and regmatch() into patmatch()
 + contrib/completion: --line-number to git grep
 + Documentation: Add --line-number to git-grep synopsis

There was a confused test around BRE caused by GNU extension people so
used to use without even realizing it is GNU extension.

Will merge to "master" by the middle of week #5.

--------------------------------------------------
[Discarded]

* hg/add-i-qq (2011-05-17) 1 commit
 . add-interactive: add 'Quit' shortcut to add hunk and quit

The question "why is y+q any more deserving for a short-cut than d+q" was
raised late in the discussion, and I think it a very valid concern.

* jc/add-delete-default (2011-04-27) 1 commit
 . git add: notice removal of tracked paths by default

This is ill-thought out. When the user does want to say "take all changes
into account, not just addition", they can easily say "add -u" (update).

* jc/dotdot-is-parent-directory (2011-05-04) 1 commit
 . specifying ranges: we did not mean to make ".." an empty set

Updated documentation, but I do not feel a strong enough annoyance to push
this forward.

* jc/fix-config-environment-passing (2011-05-24) 1 commit
 . Allow built-ins to also use -c var=val via alias

* jc/git-handle-options-miscount (2011-05-24) 1 commit
 . handle_options(): do not miscount how many arguments were used

These two have been discarded; jk/maint-config-alias-fix replaces them.
