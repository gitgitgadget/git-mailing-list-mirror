From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 01/12] Fix math thinko in similarity estimator.
Date: Fri, 27 May 2005 15:49:54 -0700
Message-ID: <7vekbs5lnx.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:49:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbncy-0001l3-W0
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVE0WuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVE0WuU
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:50:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:22515 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262633AbVE0Wt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:49:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527224956.TTJQ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:49:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The math to reject delta that is too big was confused.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diffcore-rename.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -163,7 +163,7 @@ static int estimate_similarity(struct di
 	/* A delta that has a lot of literal additions would have
 	 * big delta_size no matter what else it does.
 	 */
-	if (minimum_score < MAX_SCORE * delta_size / base_size)
+	if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
 	/* Estimate the edit size by interpreting delta. */
------------------------------------------------

