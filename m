From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 6/6] fix for more minor memory leaks
Date: Tue, 16 Oct 2007 21:55:50 -0400
Message-ID: <1192586150-13743-7-git-send-email-nico@cam.org>
References: <1192586150-13743-1-git-send-email-nico@cam.org>
 <1192586150-13743-2-git-send-email-nico@cam.org>
 <1192586150-13743-3-git-send-email-nico@cam.org>
 <1192586150-13743-4-git-send-email-nico@cam.org>
 <1192586150-13743-5-git-send-email-nico@cam.org>
 <1192586150-13743-6-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihy9T-0003Wi-Pi
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934957AbXJQB4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935959AbXJQB4I
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:56:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8510 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936189AbXJQB4B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:56:01 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ10063X9D2E630@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 21:55:54 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1212.gdb015
In-reply-to: <1192586150-13743-6-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61309>

Now that some pointers have lost their const attribute, we can free their
associated memory when done with them.  This is more a correctness issue
about the rule for freeing those pointers which isn't completely trivial
more than the leak itself which didn't matter as the program is
exiting anyway.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 index-pack.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 60173d5..2f149a4 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -815,6 +815,10 @@ int main(int argc, char **argv)
 	free(objects);
 	free(index_name_buf);
 	free(keep_name_buf);
+	if (pack_name == NULL)
+		free(curr_pack);
+	if (index_name == NULL)
+		free(curr_index);
 
 	return 0;
 }
-- 
1.5.3.4.1212.gdb015
