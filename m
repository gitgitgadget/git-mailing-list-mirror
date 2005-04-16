From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] update-cache --refresh cache entry leak
Date: Sat, 16 Apr 2005 15:51:46 -0700
Message-ID: <7v8y3i5o8t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:48:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMw5A-0000vc-TR
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVDPWvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDPWvv
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:51:51 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41156 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261176AbVDPWvu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 18:51:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416225147.BOIV2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 18:51:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When update-cache --refresh replaces an existing cache entry
with a new one, it forgets to free the original.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
update-cache.c:  61d2b93a751f35ba24f479cd4fc151188916f02a
--- update-cache.c
+++ update-cache.c	2005-04-16 15:49:03.000000000 -0700
@@ -203,6 +203,8 @@
 			printf("%s: needs update\n", ce->name);
 			continue;
 		}
+		if (new != ce)
+			free(ce);
 		active_cache[i] = new;
 	}
 }

