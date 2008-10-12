From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: remove stale howto/rebase-and-edit.txt
Date: Sun, 12 Oct 2008 13:21:48 +0200
Message-ID: <1223810508-23615-1-git-send-email-trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 12 13:23:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Koz2w-0002yW-KG
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 13:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbYJLLWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 07:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYJLLWA
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 07:22:00 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:50673 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbYJLLV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 07:21:59 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 12 Oct 2008 13:21:51 +0200
Received: from localhost.localdomain ([84.75.157.245]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 12 Oct 2008 13:21:51 +0200
X-Mailer: git-send-email 1.6.0.2.804.g2004
X-OriginalArrivalTime: 12 Oct 2008 11:21:51.0140 (UTC) FILETIME=[B9220E40:01C92C5C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98012>

The "rebase and edit" howto predates the much easier solution 'git
rebase -i' by two years.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 Documentation/howto/rebase-and-edit.txt |   79 -------------------------------
 1 files changed, 0 insertions(+), 79 deletions(-)

diff --git a/Documentation/howto/rebase-and-edit.txt b/Documentation/howto/rebase-and-edit.txt
deleted file mode 100644
index 554909f..0000000
--- a/Documentation/howto/rebase-and-edit.txt
+++ /dev/null
@@ -1,79 +0,0 @@
-Date:	Sat, 13 Aug 2005 22:16:02 -0700 (PDT)
-From:	Linus Torvalds <torvalds@osdl.org>
-To:	Steve French <smfrench@austin.rr.com>
-cc:	git@vger.kernel.org
-Subject: Re: sending changesets from the middle of a git tree
-Abstract: In this article, Linus demonstrates how a broken commit
- in a sequence of commits can be removed by rewinding the head and
- reapplying selected changes.
-
-On Sat, 13 Aug 2005, Linus Torvalds wrote:
-
-> That's correct. Same things apply: you can move a patch over, and create a
-> new one with a modified comment, but basically the _old_ commit will be
-> immutable.
-
-Let me clarify.
-
-You can entirely _drop_ old branches, so commits may be immutable, but
-nothing forces you to keep them. Of course, when you drop a commit, you'll
-always end up dropping all the commits that depended on it, and if you
-actually got somebody else to pull that commit you can't drop it from
-_their_ repository, but undoing things is not impossible.
-
-For example, let's say that you've made a mess of things: you've committed
-three commits "old->a->b->c", and you notice that "a" was broken, but you
-want to save "b" and "c". What you can do is
-
-	# Create a branch "broken" that is the current code
-	# for reference
-	git branch broken
-
-	# Reset the main branch to three parents back: this
-	# effectively undoes the three top commits
-	git reset HEAD^^^
-	git checkout -f
-
-	# Check the result visually to make sure you know what's
-	# going on
-	gitk --all
-
-	# Re-apply the two top ones from "broken"
-	#
-	# First "parent of broken" (aka b):
-	git-diff-tree -p broken^ | git-apply --index
-	git commit --reedit=broken^
-
-	# Then "top of broken" (aka c):
-	git-diff-tree -p broken | git-apply --index
-	git commit --reedit=broken
-
-and you've now re-applied (and possibly edited the comments) the two
-commits b/c, and commit "a" is basically gone (it still exists in the
-"broken" branch, of course).
-
-Finally, check out the end result again:
-
-	# Look at the new commit history
-	gitk --all
-
-to see that everything looks sensible.
-
-And then, you can just remove the broken branch if you decide you really
-don't want it:
-
-	# remove 'broken' branch
-	git branch -d broken
-
-	# Prune old objects if you're really really sure
-	git prune
-
-And yeah, I'm sure there are other ways of doing this. And as usual, the
-above is totally untested, and I just wrote it down in this email, so if
-I've done something wrong, you'll have to figure it out on your own ;)
-
-			Linus
--
-To unsubscribe from this list: send the line "unsubscribe git" in
-the body of a message to majordomo@vger.kernel.org
-More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
tg: (e782e12..) t/doc-remove-old-howto (depends on: spearce/master)
