From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/3] make sure throughput display gets updated even if progress
 doesn't move
Date: Thu, 01 Nov 2007 16:59:56 -0400
Message-ID: <1193950797-29631-3-git-send-email-nico@cam.org>
References: <1193950797-29631-1-git-send-email-nico@cam.org>
 <1193950797-29631-2-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inh9b-0000yZ-Jy
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbXKAVAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbXKAVAB
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:00:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31466 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbXKAU77 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 16:59:59 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQU002D3IBX07M0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Nov 2007 16:59:58 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.279.gb2d9d-dirty
In-reply-to: <1193950797-29631-2-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63000>

Currently the progress/throughput display update happens only through
display_progress().  If the progress based on object count remains
unchanged because a large object is being received, the latest throughput
won't be displayed.  The display update should occur through
display_throughput() as well.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 progress.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/progress.c b/progress.c
index 34a5961..39d5d2c 100644
--- a/progress.c
+++ b/progress.c
@@ -160,6 +160,9 @@ void display_throughput(struct progress *progress, unsigned long n)
 		tp->last_misecs[tp->idx] = misecs;
 		tp->idx = (tp->idx + 1) % TP_IDX_MAX;
 		tp->count = 0;
+
+		if (progress->last_value != -1 && progress_update)
+			display(progress, progress->last_value, 0);
 	}
 }
 
-- 
1.5.3.4.279.gb2d9d-dirty
