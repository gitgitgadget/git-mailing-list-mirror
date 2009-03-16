From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 06/10] Rename the gitDir fields to indicate they refer to another dir than the default
Date: Mon, 16 Mar 2009 21:14:39 +0100
Message-ID: <1237234483-3405-7-git-send-email-robin.rosenberg@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-4-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-5-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-6-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:17:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJFV-0007z8-Th
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758628AbZCPUP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757886AbZCPUPY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:15:24 -0400
Received: from mail.dewire.com ([83.140.172.130]:5281 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174AbZCPUPY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:15:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 479E1138AD6E;
	Mon, 16 Mar 2009 21:15:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4U+VENoRd+AA; Mon, 16 Mar 2009 21:15:14 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 8F3B4138AD53;
	Mon, 16 Mar 2009 21:14:45 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1237234483-3405-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113371>

---
 .../src/org/spearce/jgit/pgm/ReceivePack.java      |   10 +++++-----
 .../src/org/spearce/jgit/pgm/UploadPack.java       |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java
index 579f893..7c72e2c 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java
@@ -45,7 +45,7 @@
 @Command(common = false, usage = "Server side backend for 'jgit push'")
 class ReceivePack extends TextBuiltin {
 	@Argument(index = 0, required = true, metaVar = "DIRECTORY", usage = "Repository to receive into")
-	File gitdir;
+	File newGitdir;
 
 	@Override
 	protected final boolean requiresRepository() {
@@ -56,11 +56,11 @@ protected final boolean requiresRepository() {
 	protected void run() throws Exception {
 		final org.spearce.jgit.transport.ReceivePack rp;
 
-		if (new File(gitdir, ".git").isDirectory())
-			gitdir = new File(gitdir, ".git");
-		db = new Repository(gitdir);
+		if (new File(newGitdir, ".git").isDirectory())
+			newGitdir = new File(newGitdir, ".git");
+		db = new Repository(newGitdir);
 		if (!db.getObjectsDirectory().isDirectory())
-			throw die("'" + gitdir.getPath() + "' not a git repository");
+			throw die("'" + newGitdir.getPath() + "' not a git repository");
 		rp = new org.spearce.jgit.transport.ReceivePack(db);
 		rp.receive(System.in, System.out, System.err);
 	}
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
index d6f6d7c..b9e25d0 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
@@ -45,7 +45,7 @@
 @Command(common = false, usage = "Server side backend for 'jgit fetch'")
 class UploadPack extends TextBuiltin {
 	@Argument(index = 0, required = true, metaVar = "DIRECTORY", usage = "Repository to read from")
-	File gitdir;
+	File newGitdir;
 
 	@Override
 	protected final boolean requiresRepository() {
@@ -56,11 +56,11 @@ protected final boolean requiresRepository() {
 	protected void run() throws Exception {
 		final org.spearce.jgit.transport.UploadPack rp;
 
-		if (new File(gitdir, ".git").isDirectory())
-			gitdir = new File(gitdir, ".git");
-		db = new Repository(gitdir);
+		if (new File(newGitdir, ".git").isDirectory())
+			newGitdir = new File(newGitdir, ".git");
+		db = new Repository(newGitdir);
 		if (!db.getObjectsDirectory().isDirectory())
-			throw die("'" + gitdir.getPath() + "' not a git repository");
+			throw die("'" + newGitdir.getPath() + "' not a git repository");
 		rp = new org.spearce.jgit.transport.UploadPack(db);
 		rp.upload(System.in, System.out, System.err);
 	}
-- 
1.6.1.285.g35d8b
