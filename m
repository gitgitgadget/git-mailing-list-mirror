From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 18:40:40 -0800
Message-ID: <7virezwzpz.fsf@assigned-by-dhcp.cox.net>
References: <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
	<20070119034404.GA17521@spearce.org>
	<20070119104935.GA5189@moooo.ath.cx>
	<7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
	<20070120111832.GA30368@moooo.ath.cx>
	<7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
	<20070121103724.GA23256@moooo.ath.cx>
	<7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
	<20070121220114.GA24729@coredump.intra.peff.net>
	<45B415B1.30407@midwinter.com>
	<20070122015252.GA26934@coredump.intra.peff.net>
	<7vwt3fx1am.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701211813410.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 03:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8p70-00067q-Nl
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 03:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbXAVCkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 21:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbXAVCkm
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 21:40:42 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:46503 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbXAVCkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 21:40:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122024041.YQPX7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jan 2007 21:40:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E2gy1W00n1kojtg0000000; Sun, 21 Jan 2007 21:40:59 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211813410.14248@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 21 Jan 2007 18:23:29 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37389>

Linus Torvalds <torvalds@osdl.org> writes:

> However, now that rebasing ends up being visible in the branch reflog, 
> we're back to the "normally nothing to ever prune" situation, and as such, 
> the only object pruning that _should_ take place is basically as part of 
> "git repack -a -d" (which unlike a prune is actually safe, since it only 
> prunes objects that are reachable from a pack).
>
> So to recap: "git prune" simply isn't a safe thing to do. Don't do it 
> without thinking. I'm not at all sure it's a good idea that "git gc" does 
> it for you, since it just encourages mindless pruning that probably 
> shouldn't happen in the first place.

I guess we are in agreement on this.

-- >8 --
[PATCH] git-gc: do not run prune mindlessly.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-gc.txt |    1 -
 git-gc.sh                |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 2bcc949..f53ca97 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -50,7 +50,6 @@ kept.  This defaults to 15 days.
 
 See Also
 --------
-gitlink:git-prune[1]
 gitlink:git-reflog[1]
 gitlink:git-repack[1]
 gitlink:git-rerere[1]
diff --git a/git-gc.sh b/git-gc.sh
index 6de55f7..7716f62 100755
--- a/git-gc.sh
+++ b/git-gc.sh
@@ -11,5 +11,4 @@ SUBDIRECTORY_OK=Yes
 git-pack-refs --prune &&
 git-reflog expire --all &&
 git-repack -a -d -l &&
-git-prune &&
 git-rerere gc || exit
-- 
1.5.0.rc2
