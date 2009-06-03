From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2] Send non-standard port in host header of git://
Date: Wed, 3 Jun 2009 10:19:00 -0700
Message-ID: <20090603171900.GK3355@spearce.org>
References: <1244049330-4019-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:19:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBu7L-0006CN-T6
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 19:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbZFCRS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 13:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbZFCRS6
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 13:18:58 -0400
Received: from george.spearce.org ([209.20.77.23]:51537 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbZFCRS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 13:18:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B9D60381D1; Wed,  3 Jun 2009 17:19:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1244049330-4019-1-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120624>

On a git://host:port/path style URL, if port is not the IANA
registered port 9418 for git, the remote git daemon expects
us to send "\0host=host:port\0" in the virtual host slot.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Arrrgh.  v2 deals with the case when the port isn't in the URL at
 all, its <= 0, in which case its the default port, so we shouldn't
 send it to the server.

 Sorry.  :-)

 .../spearce/jgit/transport/TransportGitAnon.java   |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
index add7e2a..0c80b9d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
@@ -103,6 +103,10 @@ void service(final String name, final PacketLineOut pckOut)
 		cmd.append('\0');
 		cmd.append("host=");
 		cmd.append(uri.getHost());
+		if (uri.getPort() > 0 && uri.getPort() != GIT_PORT) {
+			cmd.append(":");
+			cmd.append(uri.getPort());
+		}
 		cmd.append('\0');
 		pckOut.writeString(cmd.toString());
 		pckOut.flush();
-- 
1.6.3.1.333.g3ebba7
