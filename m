From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix leak in diffcore-order.c
Date: Sat, 28 May 2005 09:44:57 -0700
Message-ID: <7vekbruwom.fsf@assigned-by-dhcp.cox.net>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 18:45:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dc4Oz-0003cE-D6
	for gcvg-git@gmane.org; Sat, 28 May 2005 18:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVE1QpF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 12:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVE1QpF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 12:45:05 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30120 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261151AbVE1QpB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 12:45:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528164458.DOTG7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 12:44:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 28 May 2005 02:54:39 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A temporary array used for sorting the filepairs were not freed
after use.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diffcore-order.c |    1 +
1 files changed, 1 insertion(+)

diff --git a/diffcore-order.c b/diffcore-order.c
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -117,5 +117,6 @@ void diffcore_order(const char *orderfil
 	qsort(o, q->nr, sizeof(*o), compare_pair_order);
 	for (i = 0; i < q->nr; i++)
 		q->queue[i] = o[i].pair;
+	free(o);
 	return;
 }
------------------------------------------------

