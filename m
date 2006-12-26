From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Mon, 25 Dec 2006 19:25:44 -0800
Message-ID: <7vmz5bfidj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 26 04:25:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz2wp-0003Tg-03
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 04:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWLZDZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 22:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWLZDZq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 22:25:46 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:38126 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196AbWLZDZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 22:25:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061226032545.RVAR20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 Dec 2006 22:25:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3FRy1W00P1kojtg0000000; Mon, 25 Dec 2006 22:25:58 -0500
To: git@vger.kernel.org
X-master-at: d5e86da89155b462c30a59bc724037fb111d3894
X-next-at: 2f7db2c3bfa8ed9ffd2962c60906f6b0252900e3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35407>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.


* jc/fsck-reflog (Fri Dec 22 23:42:30 2006 -0800) 9 commits
 + reflog expire: do not punt on tags that point at non commits.
 + reflog expire: prune commits that are not incomplete
 + Don't crash during repack of a reflog with pruned commits.
 + git reflog expire
 + Move in_merge_bases() to commit.c
 + reflog: fix warning message.
 + Teach git-repack to preserve objects referred to by reflog
   entries.
 + Protect commits recorded in reflog from pruning.
 + add for_each_reflog_ent() iterator

I'd like to push this out before we go -rc1, since the reflogs
are now enabled by default, and otherwise would grow unbounded.


* jc/utf8 (Mon Dec 25 11:48:35 2006 -0800) 3 commits
 - Teach log family --encoding
 - i18n.logToUTF8: convert commit log message to UTF-8
 - Move encoding conversion routine out of mailinfo to utf8.c

This allows repositories to have commit messages in "wrong"
encodings, and converts them to UTF-8 upon "git log" output.  I
think it is much nicer solution than insisting the commit log
message to always be in UTF-8, especially with automated
conversion when making a commit.  If the conversion is botched
(or involves non-reversible conversion) at commit time, the
information is lost forever, but even if the conversion at the
output time fails or loses information, the log message can be
recovered in the original encoding, and conversion can later be
fixed/improved.

This is not a must-have for v1.5.0, but I feel it would be
better to push it out as it can introduce slight backward
incompatibility to people's scripts, if they are expecting to
get messages in original encodings.  If we are going to break
them, we would be better off breaking them at a major revision
boundary than later.


* sp/mmap (Sun Dec 24 00:47:23 2006 -0500) 20 commits
 - Replace mmap with xmmap, better handling MAP_FAILED.
 - Release pack windows before reporting out of memory.
 - Default core.packdGitWindowSize to 1 MiB if NO_MMAP.
 - Test suite for sliding window mmap implementation.
 - Create pack_report() as a debugging aid.
 - Support unmapping windows on 'temporary' packfiles.
 - Improve error message when packfile mmap fails.
 - Ensure core.packedGitWindowSize cannot be less than 2 pages.
 - Load core configuration in git-verify-pack.
 - Fully activate the sliding window pack access.
 - Unmap individual windows rather than entire files.
 - Document why header parsing won't exceed a window.
 - Loop over pack_windows when inflating/accessing data.
 - Replace use_packed_git with window cursors.
 - Refactor how we open pack files to prepare for multiple windows.
 - Create read_or_die utility routine.
 - Use off_t for index and pack file lengths.
 - Refactor packed_git to prepare for sliding mmap windows.
 - Introduce new config option for mmap limit.
 - Replace unpack_entry_gently with unpack_entry.

I wanted to have this in 'next' but it appears that this makes
git-push with a non-trivial amount of data to fail.  v1.5.0 does
not have to wait for this because this should not change any UI.


All the rest are post v1.5.0; some of them will never be merged.

* jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward
* js/shallow (Fri Nov 24 16:00:13 2006 +0100) 15 commits
 + fetch-pack: Do not fetch tags for shallow clones.
 + get_shallow_commits: Avoid memory leak if a commit has been
   reached already.
 + git-fetch: Reset shallow_depth before auto-following tags.
 + upload-pack: Check for NOT_SHALLOW flag before sending a shallow
   to the client.
 + fetch-pack: Properly remove the shallow file when it becomes
   empty.
 + shallow clone: unparse and reparse an unshallowed commit
 + Why didn't we mark want_obj as ~UNINTERESTING in the old code?
 + Why does it mean we do not have to register shallow if we have
   one?
 + We should make sure that the protocol is still extensible.
 + add tests for shallow stuff
 + Shallow clone: do not ignore shallowness when following tags
 + allow deepening of a shallow repository
 + allow cloning a repository "shallowly"
 + support fetching into a shallow repository
 + upload-pack: no longer call rev-list

* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
* jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain
* jn/web (Sat Dec 16 17:12:55 2006 +0100) 1 commit
 - gitweb: Add some mod_perl specific support
* jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org
* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.
