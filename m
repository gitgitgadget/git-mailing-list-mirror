From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] rev-list --bisect: Fix best == NULL case.
Date: Thu, 20 Sep 2007 07:23:01 +0200
Message-ID: <20070920072301.689b96c9.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 07:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYEOL-00080w-R4
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 07:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbXITFPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 01:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752508AbXITFPx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 01:15:53 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51003 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbXITFPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 01:15:52 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2897A1AB2AD;
	Thu, 20 Sep 2007 07:15:52 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id E87111AB2C9;
	Thu, 20 Sep 2007 07:15:51 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58756>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

 Not sure if the "if (best)" check is really needed, but it looks safer
 with this patch.

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 899a31d..3894633 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -436,10 +436,10 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	/* Do the real work of finding bisection commit. */
 	best = do_find_bisection(list, nr, weights);
 
-	if (best)
+	if (best) {
 		best->next = NULL;
-
-	*reaches = weight(best);
+		*reaches = weight(best);
+	}
 	free(weights);
 
 	return best;
-- 
1.5.3.2.80.g077d6f
