From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 15/28] Register most of our OptionHandler implementations for automatic use
Date: Thu, 17 Jul 2008 21:44:08 -0400
Message-ID: <1216345461-59382-16-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4E-0006LD-AY
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbYGRBp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758026AbYGRBp0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:26 -0400
Received: from george.spearce.org ([209.20.77.23]:47019 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758045AbYGRBot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:49 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id B7E3838522; Fri, 18 Jul 2008 01:44:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A208D38444;
	Fri, 18 Jul 2008 01:44:28 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-15-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88965>

Most of these types are common in our command line tools and we
will want to use them over and over again.  So we can register
them in our class initializer and be certain they get associated
to an instance member automatically by type.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/pgm/opt/CmdLineParser.java    |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java
index 257d88f..62197e4 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java
@@ -43,9 +43,14 @@ import org.kohsuke.args4j.Argument;
 import org.kohsuke.args4j.CmdLineException;
 import org.kohsuke.args4j.IllegalAnnotationError;
 import org.kohsuke.args4j.Option;
+import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.pgm.TextBuiltin;
+import org.spearce.jgit.revwalk.RevCommit;
+import org.spearce.jgit.revwalk.RevTree;
 import org.spearce.jgit.revwalk.RevWalk;
+import org.spearce.jgit.transport.RefSpec;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
 
 /**
  * Extended command line parser which handles --foo=value arguments.
@@ -56,6 +61,15 @@ import org.spearce.jgit.revwalk.RevWalk;
  * args4j style format prior to invoking args4j for parsing.
  */
 public class CmdLineParser extends org.kohsuke.args4j.CmdLineParser {
+	static {
+		registerHandler(AbstractTreeIterator.class,
+				AbstractTreeIteratorHandler.class);
+		registerHandler(ObjectId.class, ObjectIdHandler.class);
+		registerHandler(RefSpec.class, RefSpecHandler.class);
+		registerHandler(RevCommit.class, RevCommitHandler.class);
+		registerHandler(RevTree.class, RevTreeHandler.class);
+	}
+
 	private final Repository db;
 
 	private RevWalk walk;
-- 
1.5.6.3.569.ga9185
