From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] Make clear_commit_marks() clean harder
Date: Sun, 2 Jul 2006 01:29:58 +0200
Message-ID: <20060701232958.GC2513@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org> <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org> <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net> <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org> <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jul 02 01:30:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwoub-0007qR-Jj
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 01:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWGAXaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 19:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWGAXaA
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 19:30:00 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:29412
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932109AbWGAX37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 19:29:59 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 6D786B478; Sun,  2 Jul 2006 01:29:58 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23079>

Don't care if objects have been parsed or not and don't stop when we
reach a commit that is already clean -- its parents could be dirty.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 commit.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 593414d..70a4eff 100644
--- a/commit.c
+++ b/commit.c
@@ -397,13 +397,12 @@ void clear_commit_marks(struct commit *c
 {
 	struct commit_list *parents;
 
+	if (!commit)
+		return;
 	parents = commit->parents;
 	commit->object.flags &= ~mark;
 	while (parents) {
-		struct commit *parent = parents->item;
-		if (parent && parent->object.parsed &&
-		    (parent->object.flags & mark))
-			clear_commit_marks(parent, mark);
+		clear_commit_marks(parents->item, mark);
 		parents = parents->next;
 	}
 }
-- 
1.4.1.rc2.gfc04
