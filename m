From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 26/28] Convert tag program to args4j
Date: Thu, 17 Jul 2008 21:44:19 -0400
Message-ID: <1216345461-59382-27-git-send-email-spearce@spearce.org>
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
 <1216345461-59382-25-git-send-email-spearce@spearce.org>
 <1216345461-59382-26-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4N-0006LD-Qn
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868AbYGRBqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbYGRBqG
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:46:06 -0400
Received: from george.spearce.org ([209.20.77.23]:47020 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758794AbYGRBpU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:45:20 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 477DC383A5; Fri, 18 Jul 2008 01:44:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8001D38262;
	Fri, 18 Jul 2008 01:44:33 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-26-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88974>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Tag.java              |   79 ++++++++------------
 1 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
index d59616b..a7bd037 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
@@ -37,48 +37,35 @@
 
 package org.spearce.jgit.pgm;
 
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
+import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ObjectLoader;
 import org.spearce.jgit.lib.PersonIdent;
 
 class Tag extends TextBuiltin {
+	@Option(name = "-f", usage = "force replacing an existing tag")
+	private boolean force;
+
+	@Option(name = "-m", metaVar = "message", usage = "tag message")
+	private String message = "";
+
+	@Argument(index = 0, required = true, metaVar = "name")
+	private String tagName;
+
+	@Argument(index = 1, metaVar = "object")
+	private ObjectId object;
+
 	@Override
-	public void execute(String[] args) throws Exception {
-		String tagName = null;
-		String message = null;
-		String ref = "HEAD";
-		boolean force = false;
-               if (args.length == 0)
-                       usage();
-		for (int i = 0; i < args.length; ++i) {
-			if (args[i].equals("-f")) {
-				force = true;
-				continue;
-			}
-			if (args[i].equals("-m")) {
-				if (i < args.length - 2)
-					message = args[i++] + "\n";
-				else
-					usage();
-				continue;
-			}
-			if (args[i].startsWith("-m")) {
-				message = args[i].substring(2) + "\n";
-				continue;
-			}
-			if (args[i].startsWith("-") && i == args.length - 1)
-				usage();
-			if (i == args.length - 2) {
-				tagName = args[i];
-				ref = args[i+1];
-				++i;
-				continue;
-			}
-			if (i == args.length - 1) {
-				tagName = args[i];
-				continue;
-			}
-			usage();
+	protected void run() throws Exception {
+		if (object == null) {
+			object = db.resolve(Constants.HEAD);
+			if (object == null)
+				throw die("Cannot resolve " + Constants.HEAD);
 		}
+
 		if (!tagName.startsWith(Constants.TAGS_PREFIX + "/"))
 			tagName = Constants.TAGS_PREFIX + "/" + tagName;
 		if (!force && db.resolve(tagName) != null) {
@@ -86,19 +73,17 @@ class Tag extends TextBuiltin {
 					+ tagName.substring(Constants.TAGS_PREFIX.length() + 1)
 					+ "' exists");
 		}
+
+		final ObjectLoader ldr = db.openObject(object);
+		if (ldr == null)
+			throw new MissingObjectException(object, "any");
+
 		org.spearce.jgit.lib.Tag tag = new org.spearce.jgit.lib.Tag(db);
-		tag.setObjId(db.resolve(ref));
-		if (message != null) {
-			message = message.replaceAll("\r", "");
-			tag.setMessage(message);
-			tag.setTagger(new PersonIdent(db));
-			tag.setType("commit");
-		}
+		tag.setObjId(object);
+		tag.setType(Constants.typeString(ldr.getType()));
+		tag.setTagger(new PersonIdent(db));
+		tag.setMessage(message.replaceAll("\r", ""));
 		tag.setTag(tagName.substring(Constants.TAGS_PREFIX.length() + 1));
 		tag.tag();
 	}
-
-	private void usage() {
-               throw die("Usage: [-m message] [-f] tag [head]");
-	}
 }
-- 
1.5.6.3.569.ga9185
