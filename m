From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 1/2] Revert "Fix commit id in egit test T0001_ConnectProviderOperationTest"
Date: Wed, 17 Dec 2008 23:28:06 +0100
Message-ID: <200812172328.07371.robin.rosenberg.lists@dewire.com>
References: <1229472439-24104-1-git-send-email-robin.rosenberg@dewire.com> <1229472439-24104-2-git-send-email-robin.rosenberg@dewire.com> <20081217160933.GD32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 23:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD4tX-00036k-7e
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 23:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbYLQW2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 17:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYLQW2N
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 17:28:13 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:35887 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279AbYLQW2M convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 17:28:12 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 47A979500536F5EE; Wed, 17 Dec 2008 23:28:08 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081217160933.GD32487@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103401>

onsdag 17 december 2008 17:09:33 skrev Shawn O. Pearce:
> The only thing I can think of is the timestamp we are creating by
> the deprecated Date constructor call back on line 82.  Perhaps
> on different JVMs it is using different values for the hh:mm:ss
> parts of the timestamp value?

Indeed it is. Date is dependent on local time zone.

>From e4d10dea5d62210868d71384e559a0d3ef1ca55d Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Wed, 17 Dec 2008 22:46:48 +0100
Subject: [EGIT PATCH 1/2 v2] Fix testcase that was sensitive to the local time zone.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../op/T0001_ConnectProviderOperationTest.java     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
index 0ce2d7f..092c048 100644
--- a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
@@ -80,7 +80,7 @@ public void testNewUnsharedFile() throws CoreException, IOException,
 		Commit commit = new Commit(thisGit);
 		commit.setTree(rootTree);
 		commit.setAuthor(new PersonIdent("J. Git", "j.git@egit.org", new Date(
-				1999, 1, 1), TimeZone.getTimeZone("GMT+1")));
+				60876075600000L), TimeZone.getTimeZone("GMT+1")));
 		commit.setCommitter(commit.getAuthor());
 		commit.setMessage("testNewUnsharedFile\n\nJunit tests\n");
 		ObjectId id = writer.writeCommit(commit);
-- 
1.6.0.3.640.g6331a
