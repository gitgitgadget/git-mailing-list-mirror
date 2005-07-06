From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] sha1_file.c;prepare_packed_git_one() - fix DIR leak
Date: Tue, 05 Jul 2005 23:52:17 -0700
Message-ID: <7voe9gxw7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 08:54:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq3n5-0006n1-B1
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 08:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVGFGxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 02:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVGFGxY
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 02:53:24 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:34467 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262087AbVGFGwn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 02:52:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050706065216.DHQF16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 6 Jul 2005 02:52:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The function calls opendir() without a matching closedir().

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 sha1_file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

7a47797264a0be7955f3422a6e79e3311ab2775f
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -463,6 +463,7 @@ static void prepare_packed_git_one(char 
 		p->next = packed_git;
 		packed_git = p;
 	}
+	closedir(dir);
 }
 
 void prepare_packed_git(void)
