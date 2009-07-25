From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 10/19] Test for the config file when creating a new repository
Date: Sat, 25 Jul 2009 11:52:53 -0700
Message-ID: <1248547982-4003-11-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
 <1248547982-4003-5-git-send-email-spearce@spearce.org>
 <1248547982-4003-6-git-send-email-spearce@spearce.org>
 <1248547982-4003-7-git-send-email-spearce@spearce.org>
 <1248547982-4003-8-git-send-email-spearce@spearce.org>
 <1248547982-4003-9-git-send-email-spearce@spearce.org>
 <1248547982-4003-10-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO4-0002ZF-CH
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbZGYSxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbZGYSx3
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:29 -0400
Received: from george.spearce.org ([209.20.77.23]:35569 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbZGYSxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:10 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C4C9438260; Sat, 25 Jul 2009 18:53:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 15709381FF;
	Sat, 25 Jul 2009 18:53:06 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-10-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124043>

If the configuration file already exists then we should assume that
the repository also exists.  Rather than computing the file name
we should rely upon the computation done in the constructor, whose
result is held in the RepositoryConfig's file property.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 4e987e1..7fb1ef7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -171,7 +171,8 @@ public synchronized void create() throws IOException {
 	 *             in case of IO problem
 	 */
 	public void create(boolean bare) throws IOException {
-		if ((bare ? new File(gitDir, "config") : gitDir).exists()) {
+		final RepositoryConfig cfg = getConfig();
+		if (cfg.getFile().exists()) {
 			throw new IllegalStateException("Repository already exists: "
 					+ gitDir);
 		}
@@ -184,7 +185,6 @@ public void create(boolean bare) throws IOException {
 		final String master = Constants.R_HEADS + Constants.MASTER;
 		refs.link(Constants.HEAD, master);
 
-		RepositoryConfig cfg = getConfig();
 		cfg.create();
 		if (bare)
 			cfg.setBoolean("core", null, "bare", true);
-- 
1.6.4.rc2.216.g769fa
