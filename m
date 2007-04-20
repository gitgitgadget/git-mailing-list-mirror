From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/3] delay progress display when checking out files
Date: Fri, 20 Apr 2007 15:27:44 -0400
Message-ID: <S1030980AbXDTTaV/20070420193021Z+120@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Apr 20 21:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeyoK-0007Kn-R5
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 21:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031006AbXDTTaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 15:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030980AbXDTTaV
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 15:30:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23025 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767210AbXDTTaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 15:30:18 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGT005VUA6G8ME0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 Apr 2007 15:30:16 -0400 (EDT)
Apparently-To: <nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45127>

Let's start displaying progress only if more than 50% of total number
of files remains to be checked out after 2 seconds.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 unpack-trees.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index cefc404..675a999 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -304,13 +304,8 @@ static void check_updates(struct cache_entry **src, int nr,
 				total++;
 		}
 
-		/* Don't bother doing this for very small updates */
-		if (total < 250)
-			total = 0;
-
-		if (total)
-			start_progress(&progress, "Checking %u files out...",
-				       "", total);
+		start_progress_delay(&progress, "Checking %u files out...",
+				     "", total, 50, 2);
 		cnt = 0;
 	}
 
-- 
1.5.1.1.874.g4f52f-dirty
