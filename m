From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2012, #01; Wed, 2)
Date: Wed, 02 May 2012 15:12:43 -0700
Message-ID: <7vipgegrl0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 00:12:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPhn3-0001sc-01
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 00:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab2EBWMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 18:12:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688Ab2EBWMq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 18:12:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB69480DD;
	Wed,  2 May 2012 18:12:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	Y2CjQXgRH6iExotGX68fZkn4MM=; b=C66AQSOMVbJn6JoQZAQg1YyzHjzxOEVWu
	BKDNOsl/1yQF/mL6K1pfzXqI21iDmq9sk4mRk2HLtJWTV1U4B6r4Q61X9KNYOyNv
	OWqx3K7QIKr1538C1j3ArBUIrzRDx5cWUSQ/2DF6lNT/lp4lm5Y5G7E8z3Sy4xxS
	8VMYvTa2HA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ifq
	VXKFbuqJwR+lirtO/vS85R2xbYXNYFVTnxgjnJBJSv+6TN3fP5Qi7Jh9b/FQFaWf
	UyMM0HvdprcSWwVPy6vGyjl2vNcr8D471sFJPr3gZchQjkGgF92MK8xzF49PJOn6
	9f1l7+ZfkRSl0Blaj4CJBJ6DPb3HRwgIO91rF5GI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7DBC80DC;
	Wed,  2 May 2012 18:12:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA1D280DA; Wed,  2 May 2012
 18:12:44 -0400 (EDT)
X-master-at: 34875f4a53b9e495622553a671776f66dc37eb2b
X-next-at: 54d16fbcc9122b1e712cc718d11dda4a9c125ec6
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F165AD1C-94A3-11E1-A440-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196866>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The eighth batch of topics in this cycle is now in 'master', the topics in
'next' all look ready, and we do not have many topics left in 'pu'.  The
cycle is going well ;-)

Except for folks with libsvn-perl 1.6.x where x is greater than 9; we know
how the fix should look like, and we will have it in tomorrow's integration
round.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jk/maint-tformat-with-z (2012-05-01) 2 commits
  (merged to 'next' on 2012-05-02 at a0f8af7)
 + log-tree: the previous one is still not quite right
 + log-tree: use custom line terminator in line termination mode

"log -z --pretty=tformat:..." does not terminate each record with NUL
and this is a beginning of an attempt to fix it.  It still is not right
but the patch does not make externally observable behaviour worse.

Will merge to 'master'.

* nd/stream-to-archive (2012-04-30) 9 commits
 - archive-zip: streaming for deflated files
 - archive-zip: streaming for stored files
 - archive-zip: factor out helpers for writing sizes and CRC
 - archive-zip: remove uncompressed_size
 - streaming: void pointer instead of char pointer
 - archive-tar: stream large blobs to tar file
 - archive: delegate blob reading to backend
 - archive-tar: unindent write_tar_entry by one level
 - archive-tar: turn write_tar_entry into blob-writing only

Stream large blobs directly out to archive files without slurping
everything in memory first.  The streaming version of "tar" may need
further fixing.

Expecting another reroll; the second version already had review exchanges
so I didn't pick it up.

* jk/maint-push-progress (2012-05-01) 3 commits
  (merged to 'next' on 2012-05-01 at 2286130)
 + t5541: test more combinations of --progress
 + teach send-pack about --[no-]progress
 + send-pack: show progress when isatty(2)

"git push" over smart-http lost progress output and this resurrects it.

Will merge to 'master'.

* zj/diff-empty-chmod (2012-05-02) 5 commits
  (merged to 'next' on 2012-05-02 at fb8cb11)
 + t4006: Windows do not have /dev/zero
  (merged to 'next' on 2012-05-01 at 5a92787)
 + diff --stat: do not run diff on indentical files
 + diff --stat: report mode-only changes for binary files like text files
 + tests: check --[short]stat output after chmod
 + test: modernize style of t4006

"git diff --stat" used to fully count a binary file with modified
execution bits whose contents is unmodified, which was not right.

Will merge to 'master'.

--------------------------------------------------
[Graduated to "master"]

* ab/i18n (2012-04-30) 3 commits
  (merged to 'next' on 2012-04-30 at 5e7620d)
 + git-commit: remove lego in i18n messages
 + git-commit: remove lego in i18n messages
 + git-branch: remove lego in i18n messages

Fixes some constructs that build messages meant for i18n by concatenating
pieces of strings.

* jc/index-v4 (2012-04-27) 12 commits
  (merged to 'next' on 2012-04-29 at ed71f9c)
 + index-v4: document the entry format
 + unpack-trees: preserve the index file version of original
  (merged to 'next' on 2012-04-19 at 5e4b029)
 + update-index: upgrade/downgrade on-disk index version
 + read-cache.c: write prefix-compressed names in the index
 + read-cache.c: read prefix-compressed names in index on-disk version v4
 + read-cache.c: move code to copy incore to ondisk cache to a helper function
 + read-cache.c: move code to copy ondisk to incore cache to a helper function
 + read-cache.c: report the header version we do not understand
 + read-cache.c: make create_from_disk() report number of bytes it consumed
 + read-cache.c: allow unaligned mapping of the index file
 + cache.h: hide on-disk index details
 + varint: make it available outside the context of pack
 (this branch is tangled with jc/split-blob.)

Trivially shrinks the on-disk size of the index file to save both I/O and
checksum overhead.  It even comes with a technical doc updates.

The topic should give a solid base to build on further updates, with the
code refactoring in its earlier parts, and the backward compatibility
mechanism in its later parts.

* jc/rerere-train (2012-04-30) 1 commit
  (merged to 'next' on 2012-04-30 at 0cc4308)
 + contrib/rerere-train: use installed git-sh-setup

A script written long time ago proved to be useful this week for me ;-)
with a minor tweak.

* jk/doc-asciidoc-inline-literal (2012-04-26) 1 commit
  (merged to 'next' on 2012-04-30 at a52b4e6)
 + docs: stop using asciidoc no-inline-literal

Our documentation was written for an ancient version of AsciiDoc,
making the source not very readable.

* jk/maint-config-bogus-section (2012-04-25) 1 commit
  (merged to 'next' on 2012-04-26 at 9919198)
 + config: reject bogus section names for --rename-section

"git config --rename-section" to rename an existing section into a
bogus one did not check the new name.

* jk/maint-gitweb-test-use-sane-perl (2012-05-01) 2 commits
  (merged to 'next' on 2012-05-01 at 88b3f80)
 + Consistently use perl from /usr/bin/ for scripts
 + t/gitweb-lib: use $PERL_PATH to run gitweb

When using a Perl script on a system where "perl" found on user's $PATH
could be ancient or otherwise broken, we allow builders to specify the
path to a good copy of Perl with $PERL_PATH.  The gitweb test forgot to
use that Perl when running its test.

* ld/git-p4-tags-and-labels (2012-04-25) 7 commits
  (merged to 'next' on 2012-04-25 at 8b959e5)
 + git p4: fix unit tests
  (merged to 'next' on 2012-04-24 at bf55d92)
 + git p4: move verbose to base class
 + git p4: Ignore P4EDITOR if it is empty
 + git p4: Squash P4EDITOR in test harness
 + git p4: fix-up "import/export of labels to/from p4"
  (merged to 'next' on 2012-04-15 at 1b1e9a1)
 + git p4: import/export of labels to/from p4
 + git p4: Fixing script editor checks

Support p4 labels by importing/exporting them as git tags.

* lp/diffstat-with-graph (2012-04-27) 8 commits
  (merged to 'next' on 2012-04-30 at b301202)
 + t4052: work around shells unable to set COLUMNS to 1
 + Merge branch 'zj/mksh-columns-breakage' into lp/diffstat-with-graph
  (merged to 'next' on 2012-04-23 at 8de0747)
 + Prevent graph_width of stat width from falling below min
 + t4052: Test diff-stat output with minimum columns
 + t4052: Adjust --graph --stat output for prefixes
 + Adjust stat width calculations to take --graph output into account
 + Add output_prefix_length to diff_options
 + t4052: test --stat output with --graph
 (this branch uses zj/mksh-columns-breakage; is tangled with nd/columns.)

"log --graph" was not very friendly with "--stat" option and its output
had line breaks at wrong places.

* mm/simple-push (2012-04-24) 7 commits
  (merged to 'next' on 2012-04-30 at 1a571d2)
 + push.default doc: explain simple after upstream
 + push: document the future default change for push.default (matching -> simple)
 + t5570: use explicit push refspec
 + push: introduce new push.default mode "simple"
 + t5528-push-default.sh: add helper functions
 + Undocument deprecated alias 'push.default=tracking'
 + Documentation: explain push.default option a bit more
 (this branch is used by mm/push-default-switch-warning.)

New users tend to work on one branch at a time and push the result
out. The current and upstream modes of push is a more suitable default
mode than matching mode for these people, but neither is surprise-free
depending on how the project is set up. Introduce a "simple" mode that
is a subset of "upstream" but only works when the branch is named the same
between the remote and local repositories.

The plan is to make it the new default when push.default is not
configured.

* nd/i18n (2012-04-25) 11 commits
  (merged to 'next' on 2012-04-30 at d8bbd7a)
 + help: replace underlining "help -a" headers using hyphens with a blank line
  (merged to 'next' on 2012-04-24 at 07965a4)
 + i18n: bundle: mark strings for translation
 + i18n: index-pack: mark strings for translation
 + i18n: apply: update say_patch_name to give translators complete sentence
 + i18n: apply: mark strings for translation
 + i18n: remote: mark strings for translation
 + i18n: make warn_dangling_symref() automatically append \n
 + i18n: help: mark strings for translation
 + i18n: mark relative dates for translation
 + strbuf: convenience format functions with \n automatically appended
 + Makefile: feed all header files to xgettext

More message strings marked for i18n.

* nh/empty-rebase (2012-04-24) 4 commits
  (merged to 'next' on 2012-04-24 at 91d2dfd)
 + git-rebase: add keep_empty flag
 + git-cherry-pick: Add test to validate new options
 + git-cherry-pick: Add keep-redundant-commits option
 + git-cherry-pick: add allow-empty option

"git rebase" learned to optionally keep commits that do not introduce
any change in the original history.

* pw/message-cleanup (2012-04-30) 2 commits
  (merged to 'next' on 2012-04-30 at 703c0c4)
 + remove blank filename in error message
 + remove superfluous newlines in error messages

Many error/warning messages had extra trailing newlines that are
unnecessary.

* pw/p4-various (2012-04-30) 4 commits
  (merged to 'next' on 2012-04-30 at b20428c)
 + git p4: submit files with wildcards
 + git p4: fix writable file after rename or copy
 + git p4: test submit
 + git p4: bring back files in deleted client directory

Miscellaneous updates to "git p4".

* tr/xdiff-fast-hash (2012-05-01) 2 commits
  (merged to 'next' on 2012-05-01 at 5155b98)
 + xdiff: choose XDL_FAST_HASH code on sizeof(long) instead of __WORDSIZE
  (merged to 'next' on 2012-04-24 at ed693cf)
 + xdiff: load full words in the inner loop of xdl_hash_record

Use word-at-a-time comparison to find end of line or NUL (end of buffer),
borrowed from the linux-kernel discussion.

* zj/diff-stat-smaller-num-columns (2012-04-30) 1 commit
  (merged to 'next' on 2012-05-01 at eb68d3b)
 + diff --stat: use less columns for change counts

Spend only minimum number of columns necessary to show the number of lines
in the output from "diff --stat", instead of always allocating 4 columns
even when showing changes that are much smaller than 1000 lines.

* zj/mksh-columns-breakage (2012-04-27) 1 commit
  (merged to 'next' on 2012-04-30 at cce82a8)
 + test-lib: skip test with COLUMNS=1 under mksh
 (this branch is used by lp/diffstat-with-graph and nd/columns.)

A broken shell may not let us set an environment value to an arbitrary
value, interfering with some of the tests. Introduce a test prerequisite
so that we can skip some tests on such a platform.

--------------------------------------------------
[Stalled]

* nl/http-proxy-more (2012-04-26) 8 commits
 - http: try an uppercase version of $proto_proxy
 - http: fix proxy password passing
 - http: fix proxy authentication
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice
 - http: handle proxy authentication failure (error 407)
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not set

Still needs to address review comments from Peff, some of which were
partly addressed with later "fixup" patches queued here.

It probably is a good idea to re-roll the entire series.

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

* mh/ref-api-lazy-loose (2012-04-26) 18 commits
 - refs: read loose references lazily
 - read_loose_refs(): eliminate ref_cache argument
 - struct ref_dir: store a reference to the enclosing ref_cache
 - search_for_subdir(): return (ref_dir *) instead of (ref_entry *)
 - get_ref_dir(): add function for getting a ref_dir from a ref_entry
 - read_loose_refs(): rename function from get_ref_dir()
 - refs: wrap top-level ref_dirs in ref_entries
 - find_containing_dir(): use strbuf in implementation of this function
 - bisect: copy filename string obtained from git_path()
 - do_for_each_reflog(): reuse strbuf across recursive function calls
 - do_for_each_reflog(): use a strbuf to hold logfile name
 - do_for_each_reflog(): return early on error
 - get_ref_dir(): take the containing directory as argument
 - refs.c: extract function search_for_subdir()
 - get_ref_dir(): require that the dirname argument ends in '/'
 - get_ref_dir(): rename "base" parameter to "dirname"
 - get_ref_dir(): use a strbuf to hold refname
 - get_ref_dir(): return early if directory cannot be read

Refs API is updated to lazily read sub-hierarchies of refs/ namespace,
so that we do not have to grab everything from the filesystem when we
are only interested in listing branches, for example.

This looked mostly sane. Did I miss "needs more work" review comments?

* nd/columns (2012-04-27) 10 commits
  (merged to 'next' on 2012-04-30 at 93bb157)
 + tag: add --column
 + column: support piping stdout to external git-column process
 + status: add --column
 + branch: add --column
 + help: reuse print_columns() for help -a
 + column: add dense layout support
 + t9002: work around shells that are unable to set COLUMNS to 1
 + column: add columnar layout
 + Stop starting pager recursively
 + Add column layout skeleton and git-column

A couple of commands learn --column option to produce columnar output.

Will merge to 'master'.

* nd/threaded-index-pack (2012-04-19) 4 commits
 - index-pack: disable threading if NO_PREAD is defined
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function
 - compat/win32/pthread.h: Add an pthread_key_delete() implementation

* th/difftool-diffall (2012-04-23) 8 commits
  (merged to 'next' on 2012-05-02 at fdc9f60)
 + difftool: print list of valid tools with '--tool-help'
 + difftool: teach difftool to handle directory diffs
 + difftool: eliminate setup_environment function
 + difftool: stop appending '.exe' to git
 + difftool: remove explicit change of PATH
 + difftool: exit(0) when usage is printed
 + difftool: add '--no-gui' option
 + difftool: parse options using Getopt::Long

Rolls the two-directory-diff logic from diffall script (in contrib/) into
"git difftool" framework. 

Will merge to 'master'.

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

Fix race condition between starting and waiting for git-daemon in the
test.

Reverted from 'next' to replace it with js/daemon-test-race-fix.
