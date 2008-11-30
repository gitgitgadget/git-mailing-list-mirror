From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 4/8] Add a counter to make sure the test repo name is unique
Date: Mon,  1 Dec 2008 00:40:31 +0100
Message-ID: <1228088435-23722-5-git-send-email-robin.rosenberg@dewire.com>
References: <20081127214916.GD23984@spearce.org>
 <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-2-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-3-git-send-email-robin.rosenberg@dewire.com>
 <1228088435-23722-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 01 00:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6vvi-0001xS-1b
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 00:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbYK3Xkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 18:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbYK3Xkv
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 18:40:51 -0500
Received: from mail.dewire.com ([83.140.172.130]:25213 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012AbYK3Xkq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 18:40:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6FE9C1471C21;
	Mon,  1 Dec 2008 00:40:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-t6RknuClKt; Mon,  1 Dec 2008 00:40:42 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B9FE4147D53B;
	Mon,  1 Dec 2008 00:40:37 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1228088435-23722-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101988>

System.currentTimeMillis() does not have the granularity
necessary to guarantee uniqueness. We keep it to make sure we
have unique names between different runs, but add a counter to
make it unique within the execution of a test suite.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 3b08fa5..6ea9b45 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -150,11 +150,13 @@ protected static void checkFile(File f, final String checkData)
 
 	protected Repository db;
 
+	private static int testcount;
+
 	public void setUp() throws Exception {
 		super.setUp();
 		configure();
 		recursiveDelete(trashParent);
-		trash = new File(trashParent,"trash"+System.currentTimeMillis());
+		trash = new File(trashParent,"trash"+System.currentTimeMillis()+"."+(testcount++));
 		trash_git = new File(trash, ".git");
 
 		Runtime.getRuntime().addShutdownHook(new Thread() {
@@ -200,7 +202,7 @@ protected void tearDown() throws Exception {
 	 * @throws IOException
 	 */
 	protected Repository createNewEmptyRepo() throws IOException {
-		File newTestRepo = new File(trashParent, "new"+System.currentTimeMillis()+"/.git");
+		File newTestRepo = new File(trashParent, "new"+System.currentTimeMillis()+"."+(testcount++)+"/.git");
 		assertFalse(newTestRepo.exists());
 		final Repository newRepo = new Repository(newTestRepo);
 		newRepo.create();
-- 
1.6.0.3.640.g6331a
