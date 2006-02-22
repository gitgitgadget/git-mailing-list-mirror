From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] relax delta selection filtering in pack-objects
Date: Tue, 21 Feb 2006 20:39:25 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602212034180.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:39:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBiyZ-0001Dq-WA
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 02:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWBVBj3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 20:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWBVBj3
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 20:39:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45773 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932324AbWBVBj2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 20:39:28 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV20030CF9PX030@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 21 Feb 2006 20:39:25 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16579>


This change provides a 8% saving on the pack size with a 4% CPU time 
increase for git-repack -a on the current git archive.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

 pack-objects.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

2aed7126f9b44d9ef953e8a1cbeab34356410842
diff --git a/pack-objects.c b/pack-objects.c
index ceb107f..4f8814d 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -748,11 +748,10 @@ static int try_delta(struct unpacked *cu
 	}
 
 	size = cur_entry->size;
-	if (size < 50)
-		return -1;
 	oldsize = old_entry->size;
 	sizediff = oldsize > size ? oldsize - size : size - oldsize;
-	if (sizediff > size / 8)
+
+	if (size < 50)
 		return -1;
 	if (old_entry->depth >= max_depth)
 		return 0;
-- 
1.2.2.g6643-dirty
