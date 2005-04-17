From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] update-cache --remove marks the path merged.
Date: Sat, 16 Apr 2005 23:00:13 -0700
Message-ID: <7vpswu0wpe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 07:56:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN2ly-00015j-8r
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 07:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVDQGAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 02:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVDQGAU
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 02:00:20 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:63722 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261267AbVDQGAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 02:00:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417060013.DBNU7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 02:00:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When update-cache --remove is run, resolve unmerged state for
the path.  This is consistent with the update-cache --add
behaviour.  Essentially, the user is telling us how he wants to
resolve the merge by running update-cache.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 read-cache.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

read-cache.c: e16c37403092e1e94c50b04685b6417405ffc724
--- read-cache.c
+++ read-cache.c	2005-04-16 22:43:55.000000000 -0700
@@ -368,7 +368,9 @@
 int remove_file_from_cache(char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
-	if (pos >= 0)
+	if (pos < 0)
+		pos = -pos-1;
+	while (! strcmp(active_cache[pos]->name, path))
 		remove_entry_at(pos);
 	return 0;
 }

