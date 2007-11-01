From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/3] return the prune-packed progress display to the inner loop
Date: Thu, 01 Nov 2007 16:59:55 -0400
Message-ID: <1193950797-29631-2-git-send-email-nico@cam.org>
References: <1193950797-29631-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:00:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inh9a-0000yZ-VZ
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbXKAVAC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753757AbXKAVAA
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:00:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31466 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbXKAU76 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 16:59:58 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQU002D3IBX07M0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Nov 2007 16:59:58 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.279.gb2d9d-dirty
In-reply-to: <1193950797-29631-1-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62998>

This reverts commit 0e549137966feb016927a827fb6e359aec8264a3 so to return
to the same state as commit b5d72f0a4cd3cce945ca0d37e4fa0ebbfcdcdb52.

On Wed, 31 Oct 2007, Shawn O. Pearce wrote:
> During my testing with a 40,000 loose object case (yea, I fully
> unpacked a git.git clone I had laying around) my system stalled
> hard in the first object directory.  A *lot* longer than 1 second.
> So I got no progress meter for a long time, and then a progress
> meter appeared on the second directory.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-prune-packed.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index f4287da..23faf31 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -15,8 +15,6 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 	struct dirent *de;
 	char hex[40];
 
-	display_progress(progress, i + 1);
-
 	sprintf(hex, "%02x", i);
 	while ((de = readdir(dir)) != NULL) {
 		unsigned char sha1[20];
@@ -32,6 +30,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 			printf("rm -f %s\n", pathname);
 		else if (unlink(pathname) < 0)
 			error("unable to unlink %s", pathname);
+		display_progress(progress, i + 1);
 	}
 	pathname[len] = 0;
 	rmdir(pathname);
-- 
1.5.3.4.279.gb2d9d-dirty
