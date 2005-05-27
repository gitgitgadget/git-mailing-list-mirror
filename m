From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 03/12] Make pathspec only care about the detination tree.
Date: Fri, 27 May 2005 15:51:52 -0700
Message-ID: <7vzmug4707.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:50:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbneN-0001tz-6Y
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVE0WwB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVE0WwB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:52:01 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:61638 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262641AbVE0Wvy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:51:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225153.WDUT7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:51:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Earlier it had a misguided attempt to include paths that matches
either source tree or destination tree after the rename/copy
detection.  The new semantics will be that pathspec defines a
narrowed down world the diffcore operates in, so it should not
even look at where in the source tree the path came from.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diffcore-pathspec.c |    3 +--
1 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
--- a/diffcore-pathspec.c
+++ b/diffcore-pathspec.c
@@ -55,8 +55,7 @@ void diffcore_pathspec(const char **path
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if (matches_pathspec(p->one->path, spec, speccnt) ||
-		    matches_pathspec(p->two->path, spec, speccnt))
+		if (matches_pathspec(p->two->path, spec, speccnt))
 			diff_q(&outq, p);
 		else
 			diff_free_filepair(p);
------------------------------------------------

