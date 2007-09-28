From: Jing Xue <jingxue@digizenstudio.com>
Subject: [EGIT PATCH] Won't append '/' to an empty repo relative path.
Date: Fri, 28 Sep 2007 00:39:57 -0400
Message-ID: <20070928043957.GA18592@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 06:40:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib7eD-0006dc-To
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 06:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbXI1EkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 00:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754755AbXI1EkI
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 00:40:08 -0400
Received: from k2smtpout03-02.prod.mesa1.secureserver.net ([64.202.189.172]:55454
	"HELO k2smtpout03-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754361AbXI1EkG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 00:40:06 -0400
Received: (qmail 1115 invoked from network); 28 Sep 2007 04:40:06 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-02.prod.mesa1.secureserver.net (64.202.189.172) with ESMTP; 28 Sep 2007 04:40:05 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id DC88B100A0B
	for <git@vger.kernel.org>; Fri, 28 Sep 2007 04:40:05 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yb-1eMGJLVC9 for <git@vger.kernel.org>;
	Fri, 28 Sep 2007 00:39:59 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 25ECC1000A2
	for <git@vger.kernel.org>; Fri, 28 Sep 2007 00:39:59 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id 0428E7B523; Fri, 28 Sep 2007 00:39:57 -0400 (EDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59358>


When the repo relative path is empty, the extra "/" causes all subsequent
"startsWith" tests to fail.

Signed-off-by: Jing Xue <jingxue@digizenstudio.com>
---
 .../egit/ui/internal/actions/CommitAction.java     |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index 82cad58..7d638c7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -358,7 +358,11 @@ public class CommitAction implements IObjectActionDelegate {
 	}
 
 	private void includeList(IProject project, HashSet<String> added, ArrayList<IFile> category) {
-		String repoRelativePath = RepositoryMapping.getMapping(project).getRepoRelativePath(project) + "/";
+		String repoRelativePath = RepositoryMapping.getMapping(project).getRepoRelativePath(project);
+		if (repoRelativePath.length() > 0) { 
+			repoRelativePath += "/";
+		}
+
 		for (String filename : added) {
 			try {
 				if (!filename.startsWith(repoRelativePath))
-- 
1.5.3.2.116.ge36bb5
