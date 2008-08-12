From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 20/26] Allow the new DirCacheIterator in command line arguments
Date: Mon, 11 Aug 2008 18:08:07 -0700
Message-ID: <1218503293-14057-21-git-send-email-spearce@spearce.org>
References: <1218503293-14057-1-git-send-email-spearce@spearce.org>
 <1218503293-14057-2-git-send-email-spearce@spearce.org>
 <1218503293-14057-3-git-send-email-spearce@spearce.org>
 <1218503293-14057-4-git-send-email-spearce@spearce.org>
 <1218503293-14057-5-git-send-email-spearce@spearce.org>
 <1218503293-14057-6-git-send-email-spearce@spearce.org>
 <1218503293-14057-7-git-send-email-spearce@spearce.org>
 <1218503293-14057-8-git-send-email-spearce@spearce.org>
 <1218503293-14057-9-git-send-email-spearce@spearce.org>
 <1218503293-14057-10-git-send-email-spearce@spearce.org>
 <1218503293-14057-11-git-send-email-spearce@spearce.org>
 <1218503293-14057-12-git-send-email-spearce@spearce.org>
 <1218503293-14057-13-git-send-email-spearce@spearce.org>
 <1218503293-14057-14-git-send-email-spearce@spearce.org>
 <1218503293-14057-15-git-send-email-spearce@spearce.org>
 <1218503293-14057-16-git-send-email-spearce@spearce.org>
 <1218503293-14057-17-git-send-email-spearce@spearce.org>
 <1218503293-14057-18-git-send-email-spearce@spearce.org>
 <1218503293-14057-19-git-send-email-spearce@spearce.org>
 <1218503293-14057-20-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:11:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSiPZ-0006OQ-ST
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 03:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYHLBI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 21:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbYHLBI6
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 21:08:58 -0400
Received: from george.spearce.org ([209.20.77.23]:38616 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbYHLBIj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 21:08:39 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2C8AF3838B; Tue, 12 Aug 2008 01:08:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AE6573837B;
	Tue, 12 Aug 2008 01:08:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.22.g71b99
In-Reply-To: <1218503293-14057-20-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92047>

By assuming files passed where we want an AbtractTreeIterator to
be supplied are actually 'DIRC' files (aka .git/index) we can
automatically load them for the command line tool.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/pgm/opt/AbstractTreeIteratorHandler.java  |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
index 8e216c7..e439c87 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
@@ -46,6 +46,8 @@ import org.kohsuke.args4j.OptionDef;
 import org.kohsuke.args4j.spi.OptionHandler;
 import org.kohsuke.args4j.spi.Parameters;
 import org.kohsuke.args4j.spi.Setter;
+import org.spearce.jgit.dircache.DirCache;
+import org.spearce.jgit.dircache.DirCacheIterator;
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.ObjectId;
@@ -87,6 +89,17 @@ public class AbstractTreeIteratorHandler extends
 			return 1;
 		}
 
+		if (new File(name).isFile()) {
+			final DirCache dirc;
+			try {
+				dirc = DirCache.read(new File(name));
+			} catch (IOException e) {
+				throw new CmdLineException(name + " is not an index file", e);
+			}
+			setter.addValue(new DirCacheIterator(dirc));
+			return 1;
+		}
+
 		final ObjectId id;
 		try {
 			id = clp.getRepository().resolve(name);
-- 
1.6.0.rc2.22.g71b99
