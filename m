From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/19] Allow a RemoteConfig to use the more generic Config class
Date: Sat, 25 Jul 2009 11:52:47 -0700
Message-ID: <1248547982-4003-5-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
 <1248547982-4003-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO1-0002ZF-PT
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbZGYSxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbZGYSxW
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:22 -0400
Received: from george.spearce.org ([209.20.77.23]:35552 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbZGYSxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:04 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 221CF38239; Sat, 25 Jul 2009 18:53:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F1A67381FD;
	Sat, 25 Jul 2009 18:53:03 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124041>

A RemoteConfig can be parsed from any Config type object, not just
the RepositoryConfig object.  This change makes it easier to use
other types of Config storage, such as in unit tests.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/RemoteConfig.java   |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index 93a5873..ca84acf 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -43,6 +43,7 @@
 import java.util.Collections;
 import java.util.List;
 
+import org.spearce.jgit.lib.Config;
 import org.spearce.jgit.lib.RepositoryConfig;
 
 /**
@@ -143,7 +144,7 @@
 	 * @throws URISyntaxException
 	 *             one of the URIs within the remote's configuration is invalid.
 	 */
-	public RemoteConfig(final RepositoryConfig rc, final String remoteName)
+	public RemoteConfig(final Config rc, final String remoteName)
 			throws URISyntaxException {
 		name = remoteName;
 
@@ -192,7 +193,7 @@ public RemoteConfig(final RepositoryConfig rc, final String remoteName)
 	 * @param rc
 	 *            the configuration file to store ourselves into.
 	 */
-	public void update(final RepositoryConfig rc) {
+	public void update(final Config rc) {
 		final List<String> vlst = new ArrayList<String>();
 
 		vlst.clear();
@@ -222,7 +223,7 @@ public void update(final RepositoryConfig rc) {
 		set(rc, KEY_TIMEOUT, timeout, 0);
 	}
 
-	private void set(final RepositoryConfig rc, final String key,
+	private void set(final Config rc, final String key,
 			final String currentValue, final String defaultValue) {
 		if (defaultValue.equals(currentValue))
 			unset(rc, key);
@@ -230,7 +231,7 @@ private void set(final RepositoryConfig rc, final String key,
 			rc.setString(SECTION, getName(), key, currentValue);
 	}
 
-	private void set(final RepositoryConfig rc, final String key,
+	private void set(final Config rc, final String key,
 			final boolean currentValue, final boolean defaultValue) {
 		if (defaultValue == currentValue)
 			unset(rc, key);
@@ -238,15 +239,15 @@ private void set(final RepositoryConfig rc, final String key,
 			rc.setBoolean(SECTION, getName(), key, currentValue);
 	}
 
-	private void set(final RepositoryConfig rc, final String key,
-			final int currentValue, final int defaultValue) {
+	private void set(final Config rc, final String key, final int currentValue,
+			final int defaultValue) {
 		if (defaultValue == currentValue)
 			unset(rc, key);
 		else
 			rc.setInt(SECTION, getName(), key, currentValue);
 	}
 
-	private void unset(final RepositoryConfig rc, final String key) {
+	private void unset(final Config rc, final String key) {
 		rc.unset(SECTION, getName(), key);
 	}
 
-- 
1.6.4.rc2.216.g769fa
