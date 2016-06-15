From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2012, #02; Fri, 4)
Date: Fri, 04 May 2012 16:06:18 -0700
Message-ID: <7vhavv8s2d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 01:06:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQRa0-0004LD-1e
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 01:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760600Ab2EDXGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 19:06:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62143 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760597Ab2EDXGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 19:06:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06A536A4B;
	Fri,  4 May 2012 19:06:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	+mTgaSJPCz14dT3WCRyxeDsRss=; b=bta9EupF2hbSns6ua+8vGuPh0kctMCwWo
	RppBiDM5WxcMAFNfJHgIejydM11Sjm0p8TSDbXOeV9e6DOFkpqdzjsPw7XpBVzmg
	mhrje4jXVhC1FU3zSNVSS6OxsNrrsfA5EcaTO3vN5G90j51ALqWxHSNsK4KcxUK/
	NeodcHqsis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=btZ
	ipj492Pi6Yy6O82BJp0vQyGll1q/H/HMPx7ZF3alIiYS9H5hDlg+v854Ccci05CF
	efMSF3I7DDPp796bSk18Q9J54Y2zIKuEY5fvrogc6n/zsxxQVk07PTAjR1Ng3WHA
	3zBn3N+YEdtSmgnjUN4oUFDKG7orW6bwwvY+sofE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1F1D6A4A;
	Fri,  4 May 2012 19:06:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6B306A48; Fri,  4 May 2012
 19:06:19 -0400 (EDT)
X-master-at: 8275905e7e9e8945f0bffdd207f622be39026943
X-next-at: 8a79d964318316d4ce0606e0bf1c5fa7b677a641
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2810988-963D-11E1-8A12-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197081>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

Both 'next' and 'pu' branches are rapidly shrinking.  Given that we would
want to go into feature freeze in a week and half, I think this cycle is
going fairly well.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/install-no-hardlinks (2012-05-04) 1 commit
 - Makefile: NO_INSTALL_HARDLINKS

Your build platform may support hardlinks but you may prefer not to use
them, e.g. when installing to DESTDIR to make a tarball and untarring on
a filesystem that has poor support for hardlinks.

The Makefile in git-gui project may need to learn to honor the same
setting; it unconditionally creates git-citool by hardlinking git-gui.

Will merge to 'next'.

* jk/maint-reflog-walk-count-vs-time (2012-05-04) 4 commits
 - reflog-walk: always make HEAD@{0} show indexed selectors
 - reflog-walk: clean up "flag" field of commit_reflog struct
 - log: respect date_mode_explicit with --format:%gd
 - t1411: add more selector index/date tests

Gives a better DWIM behaviour for --pretty=format:%gd, "stash list", and
"log -g", depending on how the starting point ("master" vs "master@{0}" vs
"master@{now}") and date formatting options (e.g. "--date=iso") are given
on the command line.

We may want to clean it up further so that "--date=default" is taken as an
explicit request to show them in timed, not counted, format.

* nd/i18n-branch-lego (2012-05-04) 1 commit
 - branch: remove lego in i18n tracking info strings

Fix yet another message construction by concatenating pieces of sentenes,
which is unfriendly to i18n.

Will merge to 'next'.

* nh/empty-rebase (2012-05-03) 1 commit
  (merged to 'next' on 2012-05-04 at 8a79d96)
 + git cherry-pick: do not dereference a potential NULL pointer

Fix to a topic merged to 'master'.

Will merge to 'master'.

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
Not ready.
There still seem to be other bugs hiding (e.g. try pushing twice).

* js/checkout-detach-count (2012-05-04) 2 commits
 - checkout (detached): truncate list of orphaned commits at the new HEAD
 - t2020-checkout-detach: check for the number of orphaned commits

When checking out another commit from an already detached state, we used
to report all commits that are not reachable from any of the refs as
lossage, but some of them might be reachable from the new HEAD, and there
is no need to warn about them.

Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* jk/maint-push-progress (2012-05-01) 3 commits
  (merged to 'next' on 2012-05-01 at 2286130)
 + t5541: test more combinations of --progress
 + teach send-pack about --[no-]progress
 + send-pack: show progress when isatty(2)

"git push" over smart-http lost progress output and this resurrects it.

Will merge to 'master'.

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

--------------------------------------------------
[Stalled]

* nl/http-proxy-more (2012-05-03) 6 commits
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice
 - http: handle proxy authentication failure (error 407)
 - http: fix http_proxy specified without protocol part
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not set

It appears that the scope of this series should be drastically reduced, or
perhaps wait the entire topic until cURL library gains the necessary hooks
to tell us what proxy server wants us to authenticate when giving us 407.

Probably we will end up discarding this series, at least for this cycle.

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

* jk/maint-tformat-with-z (2012-05-01) 2 commits
  (merged to 'next' on 2012-05-02 at a0f8af7)
 + log-tree: the previous one is still not quite right
 + log-tree: use custom line terminator in line termination mode

"log -z --pretty=tformat:..." does not terminate each record with NUL
and this is a beginning of an attempt to fix it.  It still is not right
but the patch does not make externally observable behaviour worse.

Will merge to 'master'.

* nd/stream-to-archive (2012-05-03) 10 commits
 - t5000: rationalize unzip tests
 - archive-zip: streaming for deflated files
 - archive-zip: streaming for stored files
 - archive-zip: factor out helpers for writing sizes and CRC
 - archive-zip: remove uncompressed_size
 - archive-tar: stream large blobs to tar file
 - archive: delegate blob reading to backend
 - archive-tar: unindent write_tar_entry by one level
 - archive-tar: turn write_tar_entry into blob-writing only
 - streaming: void pointer instead of char pointer

Stream large blobs directly out to archive files without slurping
everything in memory first.

Will merge to 'next'.

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

* mh/ref-api-lazy-loose (2012-05-04) 18 commits
  (merged to 'next' on 2012-05-04 at a70d858)
 + refs: fix find_containing_dir() regression
 + refs: read loose references lazily
 + read_loose_refs(): eliminate ref_cache argument
 + struct ref_dir: store a reference to the enclosing ref_cache
 + search_for_subdir(): return (ref_dir *) instead of (ref_entry *)
 + get_ref_dir(): add function for getting a ref_dir from a ref_entry
 + read_loose_refs(): rename function from get_ref_dir()
 + refs: wrap top-level ref_dirs in ref_entries
 + find_containing_dir(): use strbuf in implementation of this function
 + bisect: copy filename string obtained from git_path()
 + do_for_each_reflog(): use a strbuf to hold logfile name
 + do_for_each_reflog(): return early on error
 + get_ref_dir(): take the containing directory as argument
 + refs.c: extract function search_for_subdir()
 + get_ref_dir(): require that the dirname argument ends in '/'
 + get_ref_dir(): rename "base" parameter to "dirname"
 + get_ref_dir(): use a strbuf to hold refname
 + get_ref_dir(): return early if directory cannot be read

Refs API is updated to lazily read sub-hierarchies of refs/ namespace,
so that we do not have to grab everything from the filesystem when we
are only interested in listing branches, for example.

Will merge to 'master'.

* nd/threaded-index-pack (2012-04-19) 4 commits
 - index-pack: disable threading if NO_PREAD is defined
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function
 - compat/win32/pthread.h: Add an pthread_key_delete() implementation

The resulting code seems to be correct but is somewhat a confusing mess.
We may want to have a reroll before merging it to 'next'.

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
