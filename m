From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-pack: allow the same source to be pushed more than once.
Date: Sat, 06 Aug 2005 10:25:17 -0700
Message-ID: <7v8xzf9dvm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 06 19:27:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1SQX-0005xS-An
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 19:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbVHFRZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 13:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbVHFRZV
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 13:25:21 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54689 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S263293AbVHFRZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 13:25:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050806172519.RGFU1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 Aug 2005 13:25:19 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The revised code accidentally inherited the restriction that a
reference can be pushed only once, only because the original did
not allow renaming.  This is no longer necessary so lift it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 connect.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

db27ee63929fa4a161c321daf52df5635fd4828c
diff --git a/connect.c b/connect.c
--- a/connect.c
+++ b/connect.c
@@ -190,13 +190,6 @@ static int match_explicit_refs(struct re
 		}
 		if (errs)
 			continue;
-		if (matched_src->peer_ref) {
-			errs = 1;
-			error("src ref %s is sent to more than one dst.",
-			      matched_src->name);
-		}
-		else
-			matched_src->peer_ref = matched_dst;
 		if (matched_dst->peer_ref) {
 			errs = 1;
 			error("dst ref %s receives from more than one src.",
