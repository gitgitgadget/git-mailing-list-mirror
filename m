From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 24/28] Convert push program to args4j
Date: Thu, 17 Jul 2008 21:44:17 -0400
Message-ID: <1216345461-59382-25-git-send-email-spearce@spearce.org>
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
 <1216345461-59382-20-git-send-email-spearce@spearce.org>
 <1216345461-59382-21-git-send-email-spearce@spearce.org>
 <1216345461-59382-22-git-send-email-spearce@spearce.org>
 <1216345461-59382-23-git-send-email-spearce@spearce.org>
 <1216345461-59382-24-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4L-0006LD-QI
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbYGRBqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759057AbYGRBp6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:58 -0400
Received: from george.spearce.org ([209.20.77.23]:47018 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758787AbYGRBpU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:45:20 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B30F938420; Fri, 18 Jul 2008 01:44:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7F6B73845C;
	Fri, 18 Jul 2008 01:44:32 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-24-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88972>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Push.java             |   95 +++++++++-----------
 1 files changed, 44 insertions(+), 51 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index 5671cc5..df6c664 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -37,9 +37,12 @@
 
 package org.spearce.jgit.pgm;
 
+import java.util.ArrayList;
 import java.util.Collection;
-import java.util.LinkedList;
+import java.util.List;
 
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.TextProgressMonitor;
 import org.spearce.jgit.transport.PushResult;
@@ -49,64 +52,54 @@ import org.spearce.jgit.transport.Transport;
 import org.spearce.jgit.transport.RemoteRefUpdate.Status;
 
 class Push extends TextBuiltin {
+	@Argument(index = 0, metaVar = "uri-ish")
+	private String remote = "origin";
 
+	@Argument(index = 1, metaVar = "refspec")
+	private final List<RefSpec> refSpecs = new ArrayList<RefSpec>();
+
+	@Option(name = "--all")
+	void addAll(final boolean ignored) {
+		refSpecs.add(Transport.REFSPEC_PUSH_ALL);
+	}
+
+	@Option(name = "--tags")
+	void addTags(final boolean ignored) {
+		refSpecs.add(Transport.REFSPEC_TAGS);
+	}
+
+	@Option(name = "--verbose", aliases = { "-v" })
 	private boolean verbose = false;
 
+	@Option(name = "--thin")
+	private boolean thin = Transport.DEFAULT_PUSH_THIN;
+
+	@Option(name = "--no-thin")
+	void nothin(final boolean ignored) {
+		thin = false;
+	}
+
+	@Option(name = "--force", aliases = { "-f" })
+	private boolean force;
+
+	@Option(name = "--receive-pack", metaVar = "path")
+	private String receivePack;
+
 	private boolean first = true;
 
 	@Override
-	public void execute(String[] args) throws Exception {
-		final LinkedList<RefSpec> refSpecs = new LinkedList<RefSpec>();
-		Boolean thin = null;
-		String exec = null;
-		boolean forceAll = false;
-
-		int argi = 0;
-		for (; argi < args.length; argi++) {
-			final String a = args[argi];
-			if ("--thin".equals(a))
-				thin = true;
-			else if ("--no-thin".equals(a))
-				thin = false;
-			else if ("-f".equals(a) || "--force".equals(a))
-				forceAll = true;
-			else if (a.startsWith("--exec="))
-				exec = a.substring("--exec=".length());
-			else if (a.startsWith("--receive-pack="))
-				exec = a.substring("--receive-pack=".length());
-			else if ("--tags".equals(a))
-				refSpecs.add(Transport.REFSPEC_TAGS);
-			else if ("--all".equals(a))
-				refSpecs.add(Transport.REFSPEC_PUSH_ALL);
-			else if ("-v".equals(a))
-				verbose = true;
-			else if ("--".equals(a)) {
-				argi++;
-				break;
-			} else if (a.startsWith("-"))
-				die("usage: push [--all] [--tags] [--force] [--thin]\n"
-						+ "[--receive-pack=<git-receive-pack>] [<repository> [<refspec>]...]");
-			else
-				break;
+	protected void run() throws Exception {
+		if (force) {
+			final List<RefSpec> orig = new ArrayList<RefSpec>(refSpecs);
+			refSpecs.clear();
+			for (final RefSpec spec : orig)
+				refSpecs.add(spec.setForceUpdate(true));
 		}
 
-		final String repository;
-		if (argi == args.length)
-			repository = "origin";
-		else
-			repository = args[argi++];
-		final Transport transport = Transport.open(db, repository);
-		if (thin != null)
-			transport.setPushThin(thin);
-		if (exec != null)
-			transport.setOptionReceivePack(exec);
-
-		for (; argi < args.length; argi++) {
-			RefSpec spec = new RefSpec(args[argi]);
-			if (forceAll)
-				spec = spec.setForceUpdate(true);
-			refSpecs.add(spec);
-		}
+		final Transport transport = Transport.open(db, remote);
+		transport.setPushThin(thin);
+		if (receivePack != null)
+			transport.setOptionReceivePack(receivePack);
 		final Collection<RemoteRefUpdate> toPush = transport
 				.findRemoteRefUpdatesFor(refSpecs);
 
-- 
1.5.6.3.569.ga9185
