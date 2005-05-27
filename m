From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 08/12] Remove a function not used anymore.
Date: Fri, 27 May 2005 15:55:01 -0700
Message-ID: <7v4qco46uy.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:54:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbnhV-0002DX-Iu
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVE0WzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVE0WzP
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:55:15 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41437 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262648AbVE0WzE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:55:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225502.OUSB550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:55:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Earlier rename/copy detection left unmodified filepair in the
output and forced downstream to keep them even when they are
filtering, and the diff_needs_to_stay() function was used for
the logic.  It is not used anymore, so remove it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c     |   22 ----------------------
diffcore.h |    3 ---
2 files changed, 25 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -647,28 +647,6 @@ static void diff_flush_patch(struct diff
 		run_diff(name, other, p->one, p->two, msg);
 }
 
-int diff_needs_to_stay(struct diff_queue_struct *q, int i,
-		       struct diff_filespec *it)
-{
-	/* If it will be used in later entry (either stay or used
-	 * as the source of rename/copy), we need to copy, not rename.
-	 */
-	while (i < q->nr) {
-		struct diff_filepair *p = q->queue[i++];
-		if (!DIFF_FILE_VALID(p->two))
-			continue; /* removed is fine */
-		if (strcmp(p->one->path, it->path))
-			continue; /* not relevant */
-
-		/* p has its src set to *it and it is not a delete;
-		 * it will be used for in-place change, rename/copy,
-		 * or just stays there.  We cannot rename it out.
-		 */
-		return 1;
-	}
-	return 0;
-}
-
 int diff_queue_is_empty(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -70,9 +70,6 @@ extern struct diff_filepair *diff_queue(
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
-extern int diff_needs_to_stay(struct diff_queue_struct *, int,
-			      struct diff_filespec *);
-
 #define DIFF_DEBUG 0
 #if DIFF_DEBUG
 void diff_debug_filespec(struct diff_filespec *, int, const char *);
------------------------------------------------

