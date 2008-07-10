From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5] Don't display passwords on the console in fetch/push output
Date: Thu, 10 Jul 2008 02:13:20 -0400
Message-ID: <1215670403-19191-3-git-send-email-spearce@spearce.org>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org>
 <1215670403-19191-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 08:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGpQI-0004ug-Ni
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 08:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbYGJGNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 02:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYGJGNa
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 02:13:30 -0400
Received: from george.spearce.org ([209.20.77.23]:55191 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbYGJGN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 02:13:26 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9D2CE38262; Thu, 10 Jul 2008 06:13:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DEE4A381FF;
	Thu, 10 Jul 2008 06:13:24 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <1215670403-19191-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87945>

When we show the URI we just fetched or pushed against there may
be a user password embedded in that URI, as saved in the user's
.git/config file.  We shouldn't display that in public to prying
eyes so nulling it out will give us a copy of the URI without that
field in it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Fetch.java            |    2 +-
 .../src/org/spearce/jgit/pgm/Push.java             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
index c9c997e..36a0592 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Fetch.java
@@ -71,7 +71,7 @@ class Fetch extends TextBuiltin {
 			return;
 
 		out.print("From ");
-		out.print(tn.getURI());
+		out.print(tn.getURI().setPass(null));
 		out.println();
 		for (final TrackingRefUpdate u : r.getTrackingRefUpdates()) {
 			final char type = shortTypeOf(u.getResult());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
index cbdf465..8411a11 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Push.java
@@ -149,7 +149,7 @@ class Push extends TextBuiltin {
 			final RemoteRefUpdate rru) {
 		if (first) {
 			first = false;
-			out.format("To %s\n", transport.getURI());
+			out.format("To %s\n", transport.getURI().setPass(null));
 		}
 
 		final String remoteName = rru.getRemoteName();
-- 
1.5.6.2.393.g45096
