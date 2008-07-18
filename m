From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 19/28] Convert fetch program to args4j
Date: Thu, 17 Jul 2008 21:44:12 -0400
Message-ID: <1216345461-59382-20-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
 <1216345461-59382-7-git-send-email-spearce@spearce.org>
 <1216345461-59382-8-git-send-email-spearce@spearce.org>
 <1216345461-59382-9-git-send-email-spearce@spearce.org>
 <1216345461-59382-10-git-send-email-spearce@spearce.org>
 <1216345461-59382-11-git-send-email-spearce@spearce.org>
 <1216345461-59382-12-git-send-email-spearce@spearce.org>
 <1216345461-59382-13-git-send-email-spearce@spearce.org>
 <1216345461-59382-14-git-send-email-spearce@spearce.org>
 <1216345461-59382-15-git-send-email-spearce@spearce.org>
 <1216345461-59382-16-git-send-email-spearce@spearce.org>
 <1216345461-59382-17-git-send-email-spearce@spearce.org>
 <1216345461-59382-18-git-send-email-spearce@spearce.org>
 <1216345461-59382-19-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4G-0006LD-9k
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758859AbYGRBph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbYGRBpf
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:35 -0400
Received: from george.spearce.org ([209.20.77.23]:47013 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757542AbYGRBou (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:50 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 18F0638579; Fri, 18 Jul 2008 01:44:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 85BA538351;
	Fri, 18 Jul 2008 01:44:30 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-19-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88964>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Fetch.java            |   27 ++++++-------------
 1 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index e5a0dce..194f669 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -37,9 +37,9 @@
 
 package org.spearce.jgit.pgm;
 
-import java.util.ArrayList;
 import java.util.List;
 
+import org.kohsuke.args4j.Argument;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.TextProgressMonitor;
 import org.spearce.jgit.transport.FetchResult;
@@ -48,26 +48,17 @@ import org.spearce.jgit.transport.TrackingRefUpdate;
 import org.spearce.jgit.transport.Transport;
 
 class Fetch extends TextBuiltin {
-	@Override
-	public void execute(String[] args) throws Exception {
-		int argi = 0;
-		for (; argi < args.length; argi++) {
-			final String a = args[argi];
-			if ("--".equals(a)) {
-				argi++;
-				break;
-			} else
-				break;
-		}
-		if (args.length == 0)
-			args = new String[] { "origin" };
+	@Argument(index = 0, metaVar = "uri-ish")
+	private String remote = "origin";
 
-		final Transport tn = Transport.open(db, args[argi++]);
+	@Argument(index = 1, metaVar = "refspec")
+	private List<RefSpec> toget;
+
+	@Override
+	protected void run() throws Exception {
+		final Transport tn = Transport.open(db, remote);
 		final FetchResult r;
 		try {
-			final List<RefSpec> toget = new ArrayList<RefSpec>();
-			for (; argi < args.length; argi++)
-				toget.add(new RefSpec(args[argi]));
 			r = tn.fetch(new TextProgressMonitor(), toget);
 			if (r.getTrackingRefUpdates().isEmpty())
 				return;
-- 
1.5.6.3.569.ga9185
