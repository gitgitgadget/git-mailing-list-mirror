From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Make commit amend work when a resource is selected
Date: Mon,  9 Mar 2009 23:35:39 +0100
Message-ID: <1236638139-17806-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Mar 09 23:37:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgo5v-00041B-IC
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 23:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbZCIWfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 18:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbZCIWfn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 18:35:43 -0400
Received: from mail.dewire.com ([83.140.172.130]:9615 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbZCIWfm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 18:35:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1E53D15E0E00;
	Mon,  9 Mar 2009 23:35:40 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CRabcSkdLRjf; Mon,  9 Mar 2009 23:35:39 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 8037E15E0DFC;
	Mon,  9 Mar 2009 23:35:39 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112751>

We previously made it possible to commit when any resource
was selected. Due to the internal workings of the commit
action the patch was not enough to extend this functionality
into the amend mode.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/actions/CommitAction.java     |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index 5996596..03649c6 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -175,7 +175,7 @@ private void performCommit(CommitDialog commitDialog, String commitMessage)
 		} catch (IOException e) {
 			throw new TeamException("Committing changes", e);
 		}
-		for (IProject proj : getSelectedProjects()) {
+		for (IProject proj : getProjectsForSelectedResources()) {
 			RepositoryMapping.getMapping(proj).fireRepositoryChanged();
 		}
 	}
@@ -230,7 +230,7 @@ private void prepareTrees(IFile[] selectedItems,
 			UnsupportedEncodingException {
 		if (selectedItems.length == 0) {
 			// amending commit - need to put something into the map
-			for (IProject proj : getSelectedProjects()) {
+			for (IProject proj : getProjectsForSelectedResources()) {
 				Repository repo = RepositoryMapping.getMapping(proj).getRepository();
 				if (!treeMap.containsKey(repo))
 					treeMap.put(repo, repo.mapTree(Constants.HEAD));
-- 
1.6.1.285.g35d8b
