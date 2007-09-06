From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Thu, 06 Sep 2007 01:52:57 -0700
Message-ID: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 10:53:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITD6u-0003ww-M4
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 10:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbXIFIxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 04:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbXIFIxD
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 04:53:03 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbXIFIxA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 04:53:00 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C639512F564;
	Thu,  6 Sep 2007 04:53:20 -0400 (EDT)
X-master-at: b5ef6ac978012475660a36583b2174e9bd8188a5
X-next-at: 2cce29856d4a5bcd7dbaaeede0a55b383e73b20d
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57843>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* js/tag (Mon Sep 3 17:51:43 2007 +0100) 1 commit
 + verify-tag: also grok CR/LFs in the tag signature

Looks correct.  Merge to 'master' this weekend.

* lh/svn-first-parent (Wed Sep 5 11:35:29 2007 +0200) 1 commit
 + git-svn: add support for --first-parent

Queued to 'next' with Eric's blessing.  Perhaps merge to
'master' by the end of next week unless there are issues.

* rs/archive (Mon Sep 3 20:08:01 2007 +0200) 3 commits
 + Remove unused function convert_sha1_file()
 + archive: specfile support (--pretty=format: in archive files)
 + Export format_commit_message()

Waiting for the "$Format: ...$" updates.

* js/remote (Sun Sep 2 21:10:14 2007 +0100) 1 commit
 + Teach "git remote" a mirror mode

Waiting for tests.  We should resurrect earlier "git remote rm"
and add tests for it as well.

* jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
 - rebase: allow starting from a dirty tree.
 - stash: implement "stash create"

A quick hack to allow starting "git rebase" in a dirty work tree
by automatically stashing the changes first, and unstashing them
after rebase is done.  Needs tests and documentation.

* np/delta (Thu Sep 6 02:13:11 2007 -0400) 4 commits
 - basic threaded delta search
 - rearrange delta search progress reporting
 - localize window memory usage accounting
 - straighten the list of objects to deltify

I do not know where Nico's "threaded pack generation" would lead
us to yet, so they are parked on 'pu' for now.  The first in the
series should be applicable to 'next', though.

* jc/pack (Sat Sep 1 23:53:47 2007 -0700) 1 commit
 + Keep last used delta base in the delta window

Would need to straighten out the implementation from the one
that is suited for the original FIFO usage to another that is
more appropriate for LRU.

* jc/autogc (Wed Sep 5 14:59:59 2007 -0700) 2 commits
 - Invoke "git gc --auto" from commit, merge, am and rebase.
 - Implement git gc --auto

This has been updated since the ones I sent to the list earlier
in the day.  It detects a situation where the user has too much
cruft in the repository that too many loose objects are left
unpruned, and issues a warning.  Also 'rebase' is covered by
running "git gc --auto" from either merge or am.

* ph/strbuf (Wed Sep 5 21:18:43 2007 +0200) 7 commits
 - Use strbuf in cache-tree.c
 - Use strbuf in buitin-rerere.c
 - Use strbuf in apply, blame, commit-tree and diff
 - mktree: Simplify write_tree() using strbuf's.
 - fast-import: Use strbuf API, and simplify cmd_data()
 - Simplify strbuf uses in archive-tar.c using strbuf API
 - Rework strbuf API and semantics.

The idea is good, and removes more code than it adds, but I find
it not 'next' material yet.  I haven't checked every single line
yet, and this series needs that kind of vetting.

* jc/pathspec (Tue Sep 4 02:47:25 2007 -0700) 1 commit
 - tree-diff.c: split out a function to match a single pattern.

Just started and not even started to cause breakage yet ;-).
I'd want to fix pathspec semantics of "diff-tree", "log" and
"ls-tree" so that they understand globs in addition to leading
directory prefix, just like "ls-files", "diff-files",
"diff-index" and "grep" does.

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

Have been on hold for a long time.  This is about traversing the
index, work tree and zero or more trees in parallel, which is
one way to rewrite the merge backend.  I may end up reusing
merge-tree.c implementation which would make this series
unnecessary.
