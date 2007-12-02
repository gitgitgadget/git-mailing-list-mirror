From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-show: only chdir(prefix) when prefix is not NULL, and
 check for success
Date: Sun, 2 Dec 2007 01:42:06 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712020141530.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 02 02:42:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iydr7-0003QB-CY
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 02:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbXLBBm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 20:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbXLBBm1
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 20:42:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:54065 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753385AbXLBBm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 20:42:27 -0500
Received: (qmail invoked by alias); 02 Dec 2007 01:42:25 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp048) with SMTP; 02 Dec 2007 02:42:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vFTkNFHDvbV5sTVjE8POxrQX5ynZBQM4gUfNicJ
	9hepx8yldNtpdg
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66745>


We blindly called "chdir(prefix);" and did not even check if it succeeded.
Found by valgrind.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-log.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 21f3b0f..0f38579 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -285,7 +285,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	struct object_array_entry *objects;
 	int i, count, ret = 0;
 
-	chdir(prefix);
+	if (prefix && chdir(prefix))
+		die ("Could not change directory to '%s'", prefix);
 
 	git_config(git_log_config);
 	init_revisions(&rev, prefix);
-- 
1.5.3.6.2112.ge2263
