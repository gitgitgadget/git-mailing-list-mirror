From: "Daniel Cheng (aka SDiZ) git@sdiz.net" <j16sdiz+freenet@gmail.com>
Subject: [PATCH EGIT] Fix NPE on move/delete ignored file
Date: Mon, 27 Apr 2009 15:49:02 +0800
Message-ID: <1240818542-10905-1-git-send-email-git@sdiz.net>
Cc: git@vger.kernel.org,
	"Daniel Cheng (aka SDiZ) git@sdiz.net" <git@sdiz.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyLap-0006mf-PJ
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 09:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbZD0HtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 03:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbZD0HtL
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 03:49:11 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:51993 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbZD0HtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 03:49:10 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1868567qwd.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=7aU23P22XZXRBJbSY5/DK0GUTIobt6hdceQEZGGR2wY=;
        b=U4k81cqGoV08MY8AbYJ462NWhlR6BDHlCb3QQy4XQF7V7uDC7ydUPvKia+JfsFZcF7
         /Y1gwufMCfDP9hP07DhrCKcXSCW208Ix0cjkURqVFlX1jlLlZGQa+1YirXgGcYulTLqQ
         Y50G5mb0SemNBLdRWW265s0T54EbpY0UrYK8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=ryQ4zCsLoxzzKnGedYItvsuUt8EYM6RrOmI4DeeIIaRNz3FIMhmjLeRyqNLkK1CTWo
         FkTNS5giBoyLam+WiJ2woKLxIZwMjeu8Y+kBgo0+IOdZftd1sfFSpsYbmcymp+cMvQwR
         8HJyogRfWN6bvpPR+vUxEB1I9gvwsabT7RIBE=
Received: by 10.224.28.129 with SMTP id m1mr5435477qac.85.1240818549337;
        Mon, 27 Apr 2009 00:49:09 -0700 (PDT)
Received: from localhost.localdomain (n1164956087.netvigator.com [116.49.56.87])
        by mx.google.com with ESMTPS id 6sm9696669yxg.20.2009.04.27.00.49.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 00:49:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117621>


Signed-off-by: Daniel Cheng (aka SDiZ) git@sdiz.net <git@sdiz.net>
---

When I rename a class, it give out NPE. I *guess* this is related
to ignored resource, as it was called from BatchImageBuilder.cleanOutputFolders().
This patch mask the NPE.

!ENTRY org.eclipse.core.resources 2 75 2009-04-27 15:34:25.873
!MESSAGE Errors during build.
!SUBENTRY 1 org.eclipse.jdt.core 2 75 2009-04-27 15:34:25.874
!MESSAGE Errors running builder 'Java Builder' on project 'fred'.
!SUBENTRY 1 org.eclipse.jdt.core 2 75 2009-04-27 15:34:25.874
!MESSAGE null argument:
!STACK 0
org.eclipse.core.runtime.AssertionFailedException: null argument:
    at org.eclipse.core.runtime.Assert.isNotNull(Assert.java:86)
    at org.eclipse.core.runtime.Assert.isNotNull(Assert.java:74)
    at org.spearce.egit.core.GitMoveDeleteHook.<init>(GitMoveDeleteHook.java:40)
    at org.spearce.egit.core.GitProvider.getMoveDeleteHook(GitProvider.java:55)
    at org.eclipse.team.internal.core.MoveDeleteManager.getHookFor(MoveDeleteManager.java:34)
    at org.eclipse.team.internal.core.MoveDeleteManager.deleteFolder(MoveDeleteManager.java:62)
    at org.eclipse.core.internal.resources.Resource.unprotectedDelete(Resource.java:1723)
    at org.eclipse.core.internal.resources.Resource.delete(Resource.java:711)
    at org.eclipse.jdt.internal.core.builder.BatchImageBuilder.cleanOutputFolders(BatchImageBuilder.java:114)
    at org.eclipse.jdt.internal.core.builder.BatchImageBuilder.build(BatchImageBuilder.java:46)
    at org.eclipse.jdt.internal.core.builder.JavaBuilder.buildAll(JavaBuilder.java:254)
    at org.eclipse.jdt.internal.core.builder.JavaBuilder.build(JavaBuilder.java:178)
    at org.eclipse.core.internal.events.BuildManager$2.run(BuildManager.java:633)                                           at org.eclipse.core.runtime.SafeRunner.run(SafeRunner.java:37)
    at org.eclipse.core.internal.events.BuildManager.basicBuild(BuildManager.java:170)
    at org.eclipse.core.internal.events.BuildManager.basicBuild(BuildManager.java:201)
    at org.eclipse.core.internal.events.BuildManager$1.run(BuildManager.java:253)
    at org.eclipse.core.runtime.SafeRunner.run(SafeRunner.java:37)
    at org.eclipse.core.internal.events.BuildManager.basicBuild(BuildManager.java:256)
    at org.eclipse.core.internal.events.BuildManager.basicBuildLoop(BuildManager.java:309)
    at org.eclipse.core.internal.events.BuildManager.build(BuildManager.java:341)
    at org.eclipse.core.internal.events.AutoBuildJob.doBuild(AutoBuildJob.java:140)
    at org.eclipse.core.internal.events.AutoBuildJob.run(AutoBuildJob.java:238)
    at org.eclipse.core.internal.jobs.Worker.run(Worker.java:55)




 .../src/org/spearce/egit/core/GitProvider.java     |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
index c7baf65..db3a857 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitProvider.java
@@ -52,7 +52,9 @@ public boolean canHandleLinkedResourceURI() {
 
 	public synchronized IMoveDeleteHook getMoveDeleteHook() {
 		if (hook == null) {
-			hook = new GitMoveDeleteHook(getData());
+			GitProjectData _data = getData();
+			if (_data != null)
+				hook = new GitMoveDeleteHook(_data);
 		}
 		return hook;
 	}
-- 
1.6.2.1
