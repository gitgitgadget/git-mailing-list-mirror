From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Really honor umask when creating files
Date: Sun, 17 Apr 2005 01:15:48 -0700
Message-ID: <7v7jj124zv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 10:12:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN4tO-0000VI-0E
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 10:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVDQIQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 04:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDQIQS
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 04:16:18 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:29325 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261281AbVDQIQP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 04:16:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417081548.DUCK18934.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 04:15:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The stated plan was to create new files with either 0666 or 0777
and let the system take care of applying umask().  Running
fchmod afterwards defeats this plan, so drop it.

You still need to spell your octals with prefix in addition to
this patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 checkout-cache.c |    2 --
 1 files changed, 2 deletions(-)

checkout-cache.c: a87022a97c4604ef42ae6c31d641dc749a076ca3
--- checkout-cache.c
+++ checkout-cache.c	2005-04-17 01:11:17.000000000 -0700
@@ -62,8 +62,6 @@
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 		}
 	}
-	if (fd >= 0)
-		fchmod(fd, mode);
 	return fd;
 }
 

