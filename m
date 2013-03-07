From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH] Fix revision walk for commits with the same dates
Date: Thu, 7 Mar 2013 19:03:22 +0100
Message-ID: <20130307180321.GA26756@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 07 19:38:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDfhk-0003L1-RN
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 19:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453Ab3CGShr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 13:37:47 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:50857 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755542Ab3CGShq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 13:37:46 -0500
X-Greylist: delayed 2053 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2013 13:37:46 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 7BF155F004C
	for <git@vger.kernel.org>; Thu,  7 Mar 2013 19:02:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Qe0vjgoatvwA for <git@vger.kernel.org>;
	Thu,  7 Mar 2013 19:01:58 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id A01EC5F004B
	for <git@vger.kernel.org>; Thu,  7 Mar 2013 19:01:58 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 67DAF3400D; Thu,  7 Mar 2013 19:03:22 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217607>

git rev-list A^! --not B provides wrong answer if all commits in the
range A..B had the same commit times and there are more then 8 of them.
This commits fixes the logic in still_interesting function to prevent
this error.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index ef60205..cf620c6 100644
--- a/revision.c
+++ b/revision.c
@@ -709,7 +709,7 @@ static int still_interesting(struct commit_list *src, unsigned long date, int sl
 	 * Does the destination list contain entries with a date
 	 * before the source list? Definitely _not_ done.
 	 */
-	if (date < src->item->date)
+	if (date <= src->item->date)
 		return SLOP;
 
 	/*
-- 
1.8.2.rc2
