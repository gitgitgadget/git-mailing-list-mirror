From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH] Change GitResourceDecorator to use isAccessible
Date: Thu, 28 Aug 2008 17:08:26 -0700
Message-ID: <1219968506-30437-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 02:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrYS-00056T-Gl
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbYH2AI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbYH2AI2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:08:28 -0400
Received: from george.spearce.org ([209.20.77.23]:42947 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbYH2AI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:08:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7AEEE38376; Fri, 29 Aug 2008 00:08:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1E89138360;
	Fri, 29 Aug 2008 00:08:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.174.gd789c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94227>

f3a6ac20 says it switched to use isAccessible() here but it
changed to exists().  We can only use setSessionProperty if
the resource is accessible so we must use the correct test
here in order to fix the issue reported by Robert.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 I just pushed this out to master since you clearly meant
 for this to be the case.  :-|

 .../internal/decorators/GitResourceDecorator.java  |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 7c10ec6..1055fcc 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -199,7 +199,7 @@ synchronized (resources) {
 	} // End ResCL
 
 	void clearDecorationState(IResource r) throws CoreException {
-		if (r.exists()) {
+		if (r.isAccessible()) {
 			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
 			fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
 		}
-- 
1.6.0.174.gd789c
