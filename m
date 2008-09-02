From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-objects: don't include missing preferred base objects
Date: Tue, 02 Sep 2008 10:22:21 -0400
Message-ID: <1220365342-21308-2-git-send-email-nico@cam.org>
References: <1220365342-21308-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 16:23:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaWnE-0006X9-I0
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 16:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbYIBOWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 10:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYIBOWf
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 10:22:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46761 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbYIBOWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 10:22:35 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6K00ILVNXAG9W9@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Sep 2008 10:22:23 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.276.g59b81
In-reply-to: <1220365342-21308-1-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94673>

This improves commit 6d6f9cddbe a bit by simply not including missing
bases in the list of objects to process at all.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ba2cf00..e16b7e8 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1725,6 +1725,14 @@ static void prepare_pack(int window, int depth)
 			if (entry->type < 0)
 				die("unable to get type of object %s",
 				    sha1_to_hex(entry->idx.sha1));
+		} else {
+			if (entry->type < 0) {
+				/*
+				 * This object is not found, but we
+				 * don't have to include it anyway.
+				 */
+				continue;
+			}
 		}
 
 		delta_list[n++] = entry;
-- 
1.6.0.1.276.g59b81
