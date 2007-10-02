From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Mon, 01 Oct 2007 22:53:02 -0700
Message-ID: <7v3awunjup.fsf@gitster.siamese.dyndns.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 07:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icah9-0005Rv-2v
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 07:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbXJBFxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 01:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbXJBFxI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 01:53:08 -0400
Received: from rune.pobox.com ([208.210.124.79]:38945 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbXJBFxH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 01:53:07 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 39594140004;
	Tue,  2 Oct 2007 01:53:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A5EC13FFD2;
	Tue,  2 Oct 2007 01:53:26 -0400 (EDT)
X-master-at: 34c6dbdef439f7cd93d3fe22493a3c1496ce96f7
X-next-at: f10f2db2eec4845703fba11a5393ed123106b4b0
In-Reply-To: <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 26 Sep 2007 13:05:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59660>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

----------------------------------------------------------------

* ph/strbuf (Thu Sep 27 13:33:19 2007 +0200) 44 commits
 + Make read_patch_file work on a strbuf.
 + strbuf_read_file enhancement, and use it.
 + strbuf change: be sure ->buf is never ever NULL.
 + double free in builtin-update-index.c
 + Clean up stripspace a bit, use strbuf even more.
 + Add strbuf_read_file().
 ...

Will be in 'master' soon.  We've seen nice linecount reduction
and the end result is rather pleasant to read.

* jc/am-quiet (Mon Oct 1 00:27:51 2007 -0700) 2 commits
 + git-am: fix typo in the previous one.
 + git-am: make the output quieter.

Response against recent "rebase being too chatty" complaints.
This should be a 'master' material.

* ap/dateformat (Fri Sep 28 15:17:45 2007 +0100) 3 commits
 + Make for-each-ref's grab_date() support per-atom formatting
 + Make for-each-ref allow atom names like "<name>:<something>"
 + parse_date_format(): convert a format name to an enum date_mode

With some test suite additions, this could go to 'master' soon.
Yes, that's a HINT, people ;-).

* je/hooks (Wed Sep 26 15:31:01 2007 -0600) 1 commit
 + post-checkout hook, tests, and docs

Will be in 'master' soon.

* db/fetch-pack (Mon Oct 1 00:59:39 2007 +0100) 49 commits
 + fetch/push: readd rsync support
 + Introduce remove_dir_recursively()
 + bundle transport: fix an alloc_ref() call
 + Allow abbreviations in the first refspec to be merged
 + Prevent send-pack from segfaulting when a branch doesn't match
 + Cleanup unnecessary break in remote.c
 ...

Has been cooking for quite long time.

There was a regression that made me quite unhappy about the
rewrite, but Daniel fixed it, so I should be happy.  There is
another usability regression: http transport is now totally
silent.  Even when you fetch daily, if the other end frequently
repacks everything into one big ball of wax like repo.or.cz
does, you will end up transferring quite a large pack every
time, and the total lack of progress report is unacceptably
unnerving.  At least we should reinstate "Fetching blah from URL
using http", and preferrably "walk $object_name" lines.  The
latter could be replaced with just series of CR + "walked N
commits..." if we do not like many output from the current "walk
$object_name" lines scrolling the other information away.

I am not sure the quality of "rsync" transport near the tip,
either, but at least the change should not affect other
transports.  Nobody should using about rsync transport these
days anyway.  Perhaps we should put a deprecation notice in the
release notes to 1.5.4, and remove it three months later.

* jc/autogc (Mon Sep 17 00:55:13 2007 -0700) 10 commits
 + git-gc --auto: run "repack -A -d -l" as necessary.
 + git-gc --auto: restructure the way "repack" command line is built.
 + git-gc --auto: protect ourselves from accumulated cruft
 + git-gc --auto: add documentation.
 + git-gc --auto: move threshold check to need_to_gc() function.
 + repack -A -d: use --keep-unreachable when repacking
 + pack-objects --keep-unreachable
 + Export matches_pack_name() and fix its return value
 + Invoke "git gc --auto" from commit, merge, am and rebase.
 + Implement git gc --auto

I think this one is reasonably sane, but I was the one who wrote
it so people should take that with a grain of salt.  What it is
and isn't:

 - "gc --auto" is a way to prevent you from keeping your
   repository _grossly_ inefficient.  Ideally, if you ever
   rapacked your repository once, and do the regular repository
   maintenance ("'git gc' before you leave for lunch every other
   day"), it should never trigger.

 - "gc --auto" is not something you can background.  We do not
   want to lock the repository and worry about associated stale
   lock, expiry etc.  The complexity is not worth it, compared
   to the stated purpose above (I suspect it might already be
   safe to run multiple instances at the same time, but the
   effort to analyze if it is is not even worth, compared to the
   stated purpose above.  Just let it run synchronously if it
   triggers, but it should not trigger for you).

* js/rebase-i (Tue Sep 25 16:43:15 2007 +0100) 1 commits
 + rebase -i: work on a detached HEAD

Will be in 'master', together with "gc --auto", soon.

* mv/unknown (Tue Sep 25 16:38:46 2007 +0200) 1 commit
 + Don't use "<unknown>" for placeholders and suppress printing of
   empty user formats.

Will be in 'master' soon.

* lh/merge (Mon Sep 24 00:51:45 2007 +0200) 6 commits
 + git-merge: add --ff and --no-ff options
 + git-merge: add support for --commit and --no-squash
 + git-merge: add support for branch.<name>.mergeoptions
 + git-merge: refactor option parsing
 + git-merge: fix faulty SQUASH_MSG
 + Add test-script for git-merge porcelain

Will be in 'master' soon.

* jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
 + rebase: allow starting from a dirty tree.
 + stash: implement "stash create"

Instead of refusing to rebase, telling you that your work tree
is dirty, this stashes your local changes, runs rebase and then
unstashes automatically.  That _sounds_ nicer and easier to use,
but I am not sure if it is a wise/sane thing to do.  We may want
to revert the "autostash" from rebase.  Opinions?

* kh/commit (Mon Sep 17 20:06:47 2007 -0400)
 + Export rerere() and launch_editor().
 + Introduce entry point add_interactive and add_files_to_cache
 + Clean up stripspace a bit, use strbuf even more.
 + Add strbuf_read_file().
 + rerere: Fix use of an empty strbuf.buf
 + Small cache_tree_write refactor.
 ...

Stalled.

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 - pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 - ls-tree.c: refactor show_recursive() and rename it.
 - tree-diff.c: split out a function to match a single pattern.

Stalled.  This is about my pet-peeve that log (diff-tree) family
has much limited pathspec semantics.  It should learn to glob
like ls-files and grep do.
