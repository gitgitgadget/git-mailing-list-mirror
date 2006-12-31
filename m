From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sun, 31 Dec 2006 00:07:17 -0800
Message-ID: <7vhcvcfpze.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 31 09:07:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0vj9-0005ZE-1Y
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 09:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbWLaIH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 03:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933093AbWLaIH1
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 03:07:27 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35614 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933092AbWLaIH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 03:07:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231080723.CLEH2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 03:07:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5L6d1W00C1kojtg0000000; Sun, 31 Dec 2006 03:06:37 -0500
To: git@vger.kernel.org
X-master-at: a862f97e98decc317437fa3b04081f68fb4ffbf3
X-next-at: ef675248958d4ea0716c08d2cc57225955bfd281
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35688>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/send-pack-pipeline (Fri Dec 29 12:14:30 2006 -0800) 2 commits
 + Documentation: illustrate send-pack pipeline.
 + send-pack: fix pipeline.

There was a longstanding bug that was exposed only by accident
when used with Shawn's sliding mmap changes (sp/mmap), and these
are to fix it.  I'll merge this to 'master' before v1.5.0-rc1.

* sp/mmap (Sat Dec 30 22:13:43 2006 -0500) 25 commits
 + Update packedGit config option documentation.
 + mmap: set FD_CLOEXEC for file descriptors we keep open for mmap()
 + pack-objects: fix use of use_pack().
 + Fix random segfaults in pack-objects.
 + Cleanup read_cache_from error handling.
 + Replace mmap with xmmap, better handling MAP_FAILED.
 + Release pack windows before reporting out of memory.
 + Default core.packdGitWindowSize to 1 MiB if NO_MMAP.
 + Test suite for sliding window mmap implementation.
 + Create pack_report() as a debugging aid.
 + Support unmapping windows on 'temporary' packfiles.
 + Improve error message when packfile mmap fails.
 + Ensure core.packedGitWindowSize cannot be less than 2 pages.
 + Load core configuration in git-verify-pack.
 + Fully activate the sliding window pack access.
 + Unmap individual windows rather than entire files.
 + Document why header parsing won't exceed a window.
 + Loop over pack_windows when inflating/accessing data.
 + Replace use_packed_git with window cursors.
 + Refactor how we open pack files to prepare for multiple windows.
 + Create read_or_die utility routine.
 + Use off_t for index and pack file lengths.
 + Refactor packed_git to prepare for sliding mmap windows.
 + Introduce new config option for mmap limit.
 + Replace unpack_entry_gently with unpack_entry.

This is Shawn's sliding mmap series to allow smaller virtual
memory footprint to access larger packfiles.  I started using
this series in production tonight.  Although the size of the
series is somewhat intimidating, they are sane changes and I
think it may be worth considering for 'master'.  This does not
change the user experience majorly as has almost no UI elements,
so it could go in either before or after v1.5.0.

* jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward

A few people wanted to have this in v1.5.0, but I am a bit
reluctant to do so --- I think the behaviour of its failure mode
is rather nasty, even though it tries to help the user by
dropping the local diff in .git/LOCAL_DIFF file.

* sp/merge (Sun Dec 31 00:02:13 2006 -0500) 6 commits
 - Refresh the index before starting merge-recursive.
 - Improve merge performance by avoiding in-index merges.
 - Avoid git-fetch in `git-pull .` when possible.
 + Use merge-recursive in git-am -3.
 + Allow merging bare trees in merge-recursive.
 + Move better_branch_name above get_ref in merge-recursive.

I'm reasonably happy with the earlier three of this series but
not really about the latter, and I've already described why.

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
* jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain
* jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org
* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.
* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

These are not for 'master' for now.
