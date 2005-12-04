From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Warn when send-pack does nothing
Date: Sun, 4 Dec 2005 11:59:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512041141280.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Dec 04 18:00:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EixCb-0000vG-GK
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 17:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVLDQ7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 11:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVLDQ7A
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 11:59:00 -0500
Received: from iabervon.org ([66.92.72.58]:25092 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932294AbVLDQ7A (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 11:59:00 -0500
Received: (qmail 772 invoked by uid 1000); 4 Dec 2005 11:59:37 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Dec 2005 11:59:37 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13186>

If you try to push into an empty repository with no ref arguments to
git push, it doesn't do anything and doesn't say anything. This adds a
warning when send-pack isn't going to push anything, so you don't
assume that it silently did what you wanted.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

 send-pack.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

applies-to: fe523a4df93cce3e5c5b0266b9d3f1cbea009afa
5519af6444d6da0ac55343fe48fe7f68fdb593d9
diff --git a/send-pack.c b/send-pack.c
index 3eeb18f..589e1f9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -190,6 +190,12 @@ static int send_pack(int in, int out, in
 	if (match_refs(local_refs, remote_refs, &remote_tail,
 		       nr_refspec, refspec, send_all))
 		return -1;
+
+	if (!remote_refs) {
+		fprintf(stderr, "No refs in common and none specified; doing nothing.\n");
+		return 0;
+	}
+
 	/*
 	 * Finally, tell the other end!
 	 */
---
0.99.9.GIT
