From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Fix +x-related show-diff false positives
Date: Sun, 17 Apr 2005 13:44:51 +0200
Message-ID: <20050417114451.GB1487@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 13:41:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN89G-0004ME-Gj
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 13:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVDQLoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 07:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVDQLoy
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 07:44:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65422 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261303AbVDQLox (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 07:44:53 -0400
Received: (qmail 13605 invoked by uid 2001); 17 Apr 2005 11:44:51 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hi,

  the following patch fixes show-diff listing all +x files as differring.

Signed-off-by: Petr Baudis <pasky@ucw.cz>
--- read-cache.c
+++ read-cache.c	2005-04-17 13:42:13.322938268 +0200
@@ -306,7 +306,7 @@
 	    ce->ce_gid != htonl(st->st_gid))
 		changed |= OWNER_CHANGED;
 	/* We consider only the owner x bit to be relevant for "mode changes" */
-	if (0100 & (ntohs(ce->ce_mode) ^ st->st_mode))
+	if (0100 & (ntohl(ce->ce_mode) ^ st->st_mode))
 		changed |= MODE_CHANGED;
 	if (ce->ce_dev != htonl(st->st_dev) ||
 	    ce->ce_ino != htonl(st->st_ino))

  (It is against my tree, but I think it should apply cleanly to yours
too; perhaps with a tiny offset.)

  Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
