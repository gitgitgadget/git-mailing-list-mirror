From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] Send non-standard port in host header of git://
Date: Wed,  3 Jun 2009 10:15:30 -0700
Message-ID: <1244049330-4019-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:15:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBu3u-0003w4-1S
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 19:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbZFCRPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 13:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbZFCRP3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 13:15:29 -0400
Received: from george.spearce.org ([209.20.77.23]:51533 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbZFCRP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 13:15:29 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 75377381FE; Wed,  3 Jun 2009 17:15:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 112CB381CE;
	Wed,  3 Jun 2009 17:15:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.1.333.g3ebba7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120623>

On a git://host:port/path style URL, if port is not the IANA
registered port 9418 for git, the remote git daemon expects
us to send "\0host=host:port\0" in the virtual host slot.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/TransportGitAnon.java   |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
index add7e2a..9edd93e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
@@ -103,6 +103,10 @@ void service(final String name, final PacketLineOut pckOut)
 		cmd.append('\0');
 		cmd.append("host=");
 		cmd.append(uri.getHost());
+		if (uri.getPort() != GIT_PORT) {
+			cmd.append(":");
+			cmd.append(uri.getPort());
+		}
 		cmd.append('\0');
 		pckOut.writeString(cmd.toString());
 		pckOut.flush();
-- 
1.6.3.1.333.g3ebba7
