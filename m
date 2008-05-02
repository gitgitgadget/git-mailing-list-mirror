From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 7/7] pack-objects: fix early eviction for max depth delta
 objects
Date: Fri, 02 May 2008 15:11:51 -0400
Message-ID: <1209755511-7840-8-git-send-email-nico@cam.org>
References: <1209755511-7840-1-git-send-email-nico@cam.org>
 <1209755511-7840-2-git-send-email-nico@cam.org>
 <1209755511-7840-3-git-send-email-nico@cam.org>
 <1209755511-7840-4-git-send-email-nico@cam.org>
 <1209755511-7840-5-git-send-email-nico@cam.org>
 <1209755511-7840-6-git-send-email-nico@cam.org>
 <1209755511-7840-7-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:14:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js0hb-00058j-Dq
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 21:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbYEBTMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 15:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936624AbYEBTMU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 15:12:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28091 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936449AbYEBTMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 15:12:12 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K090074V9BRMJ70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 May 2008 15:11:55 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.226.g6f6e8
In-reply-to: <1209755511-7840-7-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81023>

The 'depth' variable doesn't reflect the actual maximum depth used
when other objects already depend on the current one.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index f5dcd20..94c9875 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1484,7 +1484,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * depth, leaving it in the window is pointless.  we
 		 * should evict it first.
 		 */
-		if (entry->delta && depth <= n->depth)
+		if (entry->delta && max_depth <= n->depth)
 			continue;
 
 		/*
-- 
1.5.5.1.226.g6f6e8
