From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 7/9] Include commonly used commands in main help output
Date: Fri, 25 Jul 2008 12:46:05 -0700
Message-ID: <1217015167-4680-8-git-send-email-spearce@spearce.org>
References: <1217015167-4680-1-git-send-email-spearce@spearce.org>
 <1217015167-4680-2-git-send-email-spearce@spearce.org>
 <1217015167-4680-3-git-send-email-spearce@spearce.org>
 <1217015167-4680-4-git-send-email-spearce@spearce.org>
 <1217015167-4680-5-git-send-email-spearce@spearce.org>
 <1217015167-4680-6-git-send-email-spearce@spearce.org>
 <1217015167-4680-7-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:48:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTGe-0005n2-Vq
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbYGYTqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbYGYTqV
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:21 -0400
Received: from george.spearce.org ([209.20.77.23]:45944 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbYGYTqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:12 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DDFCA38420; Fri, 25 Jul 2008 19:46:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0945B383A5;
	Fri, 25 Jul 2008 19:46:10 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217015167-4680-7-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90106>

If the main loop did not get a subcommand during parsing of the
command line then we should offer up a list of commonly used
commands and their one-line usage summary, to help the user make
a decision about which command they should try to execute.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Main.java             |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
index c069989..c8bade8 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
@@ -121,6 +121,24 @@ public class Main {
 				System.err.println();
 				clp.printUsage(System.err);
 				System.err.println();
+			} else if (subcommand == null) {
+				System.err.println();
+				System.err.println("The most commonly used commands are:");
+				final CommandRef[] common = CommandCatalog.common();
+				int width = 0;
+				for (final CommandRef c : common)
+					width = Math.max(width, c.getName().length());
+				width += 2;
+
+				for (final CommandRef c : common) {
+					System.err.print(' ');
+					System.err.print(c.getName());
+					for (int i = c.getName().length(); i < width; i++)
+						System.err.print(' ');
+					System.err.print(c.getUsage());
+					System.err.println();
+				}
+				System.err.println();
 			}
 			System.exit(1);
 		}
-- 
1.6.0.rc0.182.gb96c7
