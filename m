From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2012, #11; Sun, 29)
Date: Sun, 29 Apr 2012 18:45:14 -0700
Message-ID: <7vbomahu1h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, David Aguilar <davvid@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 03:45:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOfg8-0002Eg-RV
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 03:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031Ab2D3BpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 21:45:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754959Ab2D3BpS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 21:45:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6B6C86EB;
	Sun, 29 Apr 2012 21:45:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=L
	SM2mm+Rv57wyLkv9fejCy9J4vQ=; b=I8QLIyi1d0Ozg0+FnLmOrKYUMdQ2BiKQp
	KEDtATbov0TCbbrANG+Rdyr11mFAitHEi3auzHmYE9gUbX5TZtvRmGRZDETVMmdY
	MkmIZOn0QJg0sxP3WKp9Hl78lOIZhljMAOSVIlVsqnrZ4FqN3U024nphecDGp5FZ
	0vzMf4c5aU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=WTpIMinfAIAGXITBQg+zAGiNi7+creEGrqP5WFC4i6GDZMDSU4ULAQcD
	HN6uVybNlYnawVrfZexh9113mzChPGi6twUniDeHOjlMvjk6iHvasTxLRkPuwUXM
	4btk7NNv7Po2an+owIydiZktkFaSx+tOgTQTRPxemNxEU2UnpVs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD3F386EA;
	Sun, 29 Apr 2012 21:45:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5A9286E9; Sun, 29 Apr 2012
 21:45:15 -0400 (EDT)
X-master-at: 10d4332e007132a38dc61f03c760d355da5cd550
X-next-at: ed71f9c8badf2d237c862b15ea4145e0ecd96004
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 226015AA-9266-11E1-BFAB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196533>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The sixth and seventh batch of topics in this cycle is now in 'master'.  I
also merged accumulated fixes that have been in 'master' since v1.7.10 to
'maint', so that we can issue the first maintenance release sometime next
week.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* cb/cherry-pick-rev-path-confusion (2012-04-15) 1 commit
  (merged to 'next' on 2012-04-23 at f872ba5)
 + cherry-pick: do not expect file arguments

The command line parser choked "git cherry-pick $name" when $name can be
both revision name and a pathname, even though $name can never be a path
in the context of the command.

The issue the patch addresses is real, but the way it is implemented felt
unnecessarily invasive a bit.  It may be cleaner for this caller to add
the "--" to the end of the argv_array it passes to setup_revisions().

* cb/http-multi-curl-auth (2012-04-14) 4 commits
  (merged to 'next' on 2012-04-23 at b0259be)
 + http: use newer curl options for setting credentials
 + http: clean up leak in init_curl_http_auth
 + fix http auth with multiple curl handles
 + http auth fails with multiple curl handles

Fixes http authentication breakage when we keep multiple HTTP requests in
flight using curl-multi.

* cb/maint-report-mount-point-correctly-in-setup (2012-04-15) 1 commit
  (merged to 'next' on 2012-04-23 at 9e0c8b4)
 + properly keep track of current working directory

The filesystem boundary was not correctly reported when .git directory
discovery stopped at a mount point.

* jc/merge-reduce-parents-early (2012-04-18) 5 commits
  (merged to 'next' on 2012-04-23 at 16e7e53)
 + fmt-merge-msg: discard needless merge parents
 + builtin/merge.c: reduce parents early
 + builtin/merge.c: collect other parents early
 + builtin/merge.c: remove "remoteheads" global variable
 + merge tests: octopus with redundant parents

* jk/repack-no-explode-objects-from-old-pack (2012-04-18) 4 commits
  (merged to 'next' on 2012-04-20 at 4eb2534)
 + gc: use argv-array for sub-commands
 + argv-array: add a new "pushl" method
 + argv-array: refactor empty_argv initialization
  (merged to 'next' on 2012-04-15 at 7586e50)
 + gc: do not explode objects which will be immediately pruned

* js/daemon-test-race-fix (2012-04-27) 1 commit
  (merged to 'next' on 2012-04-27 at 6edb57f)
 + t5570: fix forwarding of git-daemon messages via cat

The shell construct to launch git-daemon and wait for it to start
serving during the test was faulty, and this fixes it.

Replaced cb/daemon-test-race-fix topic with this, as this addresses
the real cause of the issue.

* js/fast-import-test-9300 (2012-04-20) 1 commit
  (merged to 'next' on 2012-04-23 at a9bd236)
 + t9300-fast-import: avoid 'exit' in test_expect_success snippets

* kk/gitweb-omit-expensive (2012-04-26) 2 commits
  (merged to 'next' on 2012-04-27 at b057127)
 + gitweb: Option to not display information about owner
 + gitweb: Option to omit column with time of the last change
 (this branch uses kk/maint-gitweb-missing-owner.)

"gitweb" learned to optionally omit output of fields that are expensive
to generate.

* kk/maint-gitweb-missing-owner (2012-04-25) 1 commit
  (merged to 'next' on 2012-04-27 at e526304)
 + gitweb: Don't set owner if got empty value from projects.list
 (this branch is used by kk/gitweb-omit-expensive.)

* mm/include-userpath (2012-04-25) 2 commits
  (merged to 'next' on 2012-04-26 at c68e261)
 + fixup! config: expand tildes in include.path variable
 + config: expand tildes in include.path variable

The new "include.path" directive in the configuration files learned
to understand "~/path" and "~user/path".

* pw/t5800-import-race-fix (2012-04-24) 1 commit
  (merged to 'next' on 2012-04-24 at e97bb42)
 + git-remote-testgit: fix race when spawning fast-import

Longstanding bug in a test scaffolding that occasionally made t5800
hang was fixed.

* rs/commit-list-append (2012-04-25) 3 commits
  (merged to 'next' on 2012-04-26 at 2ba48b3)
 + commit: remove commit_list_reverse()
 + revision: append to list instead of insert and reverse
 + sequencer: export commit_list_append()

* rt/cherry-revert-conflict-summary (2012-04-19) 1 commit
  (merged to 'next' on 2012-04-23 at e7766c2)
 + sequencer: remove additional blank line

In the older days, the header "Conflicts:" in "cherry-pick" and
"merge" was separated by a blank line from the list of paths that
follow for readability, but when "merge" was rewritten in C, we lost
it by mistake. Remove the newline from "cherry-pick" to make them
match again.

--------------------------------------------------
[New Topics]

* zj/mksh-columns-breakage (2012-04-27) 1 commit
 - test-lib: skip test with COLUMNS=1 under mksh
 (this branch is used by lp/diffstat-with-graph and nd/columns.)

A broken shell does not let us set an environment value to an
arbitrary value, interfering with some of the tests. Introduce a test
prerequisite so that we can skip some tests on such a platform.

Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jc/run-hook-env-1 (2012-03-11) 1 commit
 - run_hook(): enhance the interface to pass arbitrary environment

Not urgent.

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks.

* jc/split-blob (2012-04-03) 7 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions
 + varint: make it available outside the context of pack
 (this branch is tangled with jc/index-v4.)

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

* mm/simple-push (2012-04-24) 7 commits
 - push.default doc: explain simple after upstream
 - push: document the future default change for push.default (matching -> simple)
 - t5570: use explicit push refspec
 - push: introduce new push.default mode "simple"
 - t5528-push-default.sh: add helper functions
 - Undocument deprecated alias 'push.default=tracking'
 - Documentation: explain push.default option a bit more
 (this branch is used by mm/push-default-switch-warning.)

New users tend to work on one branch at a time and push the result
out. The current and upstream modes of push is a more suitable default
mode than matching mode for these people, but neither is surprise-free
depending on how the project is set up. Introduce a "simple" mode that
is a subset of "upstream" but only works when the branch is named the same
between the remote and local repositories.

The plan is to make it the new default when push.default is not
configured.

Will merge to 'next'.

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

* jk/maint-config-bogus-section (2012-04-25) 1 commit
  (merged to 'next' on 2012-04-26 at 9919198)
 + config: reject bogus section names for --rename-section

"git config --rename-section" to rename an existing section into a
bogus one did not check the new name.

Will merge to 'master'.

* jk/doc-asciidoc-inline-literal (2012-04-26) 1 commit
 - docs: stop using asciidoc no-inline-literal

Our documentation was written for an ancient version of AsciiDoc,
making the source not very readable.

Will merge to 'next'.

* nd/i18n (2012-04-25) 11 commits
 - help: replace underlining "help -a" headers using hyphens with a blank line
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

Will merge to 'next'.

* nh/empty-rebase (2012-04-24) 4 commits
  (merged to 'next' on 2012-04-24 at 91d2dfd)
 + git-rebase: add keep_empty flag
 + git-cherry-pick: Add test to validate new options
 + git-cherry-pick: Add keep-redundant-commits option
 + git-cherry-pick: add allow-empty option

"git rebase" learned to optionally keep commits that do not introduce
any change in the original history.

* lp/diffstat-with-graph (2012-04-27) 8 commits
 - t4052: work around shells unable to set COLUMNS to 1
 - Merge branch 'zj/mksh-columns-breakage' into lp/diffstat-with-graph
  (merged to 'next' on 2012-04-23 at 8de0747)
 + Prevent graph_width of stat width from falling below min
 + t4052: Test diff-stat output with minimum columns
 + t4052: Adjust --graph --stat output for prefixes
 + Adjust stat width calculations to take --graph output into account
 + Add output_prefix_length to diff_options
 + t4052: test --stat output with --graph
 (this branch uses zj/mksh-columns-breakage; is tangled with nd/columns.)

Will merge to 'next'.

* nd/columns (2012-04-27) 10 commits
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add dense layout support
 - t9002: work around shells that are unable to set COLUMNS to 1
 - column: add columnar layout
 - Stop starting pager recursively
 - Add column layout skeleton and git-column
 (this branch uses zj/mksh-columns-breakage; is tangled with lp/diffstat-with-graph.)

A couple of commands learn --column option to produce columnar output.

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

What's the current status of this topic?  Pete?

* nd/threaded-index-pack (2012-04-19) 4 commits
 - index-pack: disable threading if NO_PREAD is defined
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function
 - compat/win32/pthread.h: Add an pthread_key_delete() implementation

* tr/xdiff-fast-hash (2012-04-09) 1 commit
  (merged to 'next' on 2012-04-24 at ed693cf)
 + xdiff: load full words in the inner loop of xdl_hash_record

Breakage reported on MacOS X.  Perhaps needs to be reverted out of 'next'.

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
checksum overhead.  It even comes with a technical doc updates ;-)

* th/difftool-diffall (2012-04-23) 8 commits
 - difftool: print list of valid tools with '--tool-help'
 - difftool: teach difftool to handle directory diffs
 - difftool: eliminate setup_environment function
 - difftool: stop appending '.exe' to git
 - difftool: remove explicit change of PATH
 - difftool: exit(0) when usage is printed
 - difftool: add '--no-gui' option
 - difftool: parse options using Getopt::Long

Rolls the two-directory-diff logic from diffall script (in contrib/) into
"git difftool" framework. 

What's the doneness of this topic?  David?

* mm/push-default-switch-warning (2012-04-26) 2 commits
 - t5541: warning message is given even with --quiet
 - push: start warning upcoming default change for push.default
 (this branch uses mm/simple-push.)

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
