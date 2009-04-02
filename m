From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/5] Update Quickdiff tracing statements
Date: Thu,  2 Apr 2009 20:46:30 +0200
Message-ID: <1238697991-12990-5-git-send-email-robin.rosenberg@dewire.com>
References: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com>
 <1238697991-12990-2-git-send-email-robin.rosenberg@dewire.com>
 <1238697991-12990-3-git-send-email-robin.rosenberg@dewire.com>
 <1238697991-12990-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 02 20:53:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpRyR-0007QY-HG
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 20:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758479AbZDBSrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 14:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756662AbZDBSrP
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 14:47:15 -0400
Received: from mail.dewire.com ([83.140.172.130]:5507 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271AbZDBSrO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 14:47:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 315521484DAF;
	Thu,  2 Apr 2009 20:47:12 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EvFSlucDwUjX; Thu,  2 Apr 2009 20:47:00 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 559C81488984;
	Thu,  2 Apr 2009 20:46:45 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.1.345.g89fb
In-Reply-To: <1238697991-12990-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115486>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/decorators/GitDocument.java   |    9 ++++++---
 .../internal/decorators/GitQuickDiffProvider.java  |    2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
index 8c82a55..347e6fc 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
@@ -34,6 +34,7 @@
 	static Map<GitDocument,Repository> doc2repo = new WeakHashMap<GitDocument, Repository>();
 
 	static GitDocument create(final IResource resource) throws IOException {
+		Activator.trace("(GitDocument) create: " + resource);
 		GitDocument ret = null;
 		if (RepositoryProvider.getProvider(resource.getProject()) instanceof GitProvider) {
 			ret = new GitDocument(resource);
@@ -51,6 +52,7 @@ private GitDocument(IResource resource) {
 	}
 
 	void populate() throws IOException {
+		Activator.trace("(GitDocument) populate: " + resource);
 		set("");
 		final IProject project = resource.getProject();
 		RepositoryMapping mapping = RepositoryMapping.getMapping(project);
@@ -70,7 +72,7 @@ void populate() throws IOException {
 		}
 		TreeEntry blobEnry = baselineTree.findBlobMember(gitPath);
 		if (blobEnry != null) {
-			Activator.trace("(GitQuickDiffProvider) compareTo: " + baseline);
+			Activator.trace("(GitDocument) compareTo: " + baseline);
 			ObjectLoader loader = repository.openBlob(blobEnry.getId());
 			byte[] bytes = loader.getBytes();
 			String charset;
@@ -91,13 +93,14 @@ void populate() throws IOException {
 			// to the content. We don't do that here.
 			String s = new String(bytes, charset);
 			set(s);
-			Activator.trace("(GitQuickDiffProvider) has reference doc, size=" + s.length() + " bytes");
+			Activator.trace("(GitDocument) has reference doc, size=" + s.length() + " bytes");
 		} else {
-			Activator.trace("(GitQuickDiffProvider) no revision.");
+			Activator.trace("(GitDocument) no revision.");
 		}
 	}
 
 	void dispose() {
+		Activator.trace("(GitDocument) dispose: " + resource);
 		doc2repo.remove(this);
 		Repository repository = getRepository();
 		if (repository != null)
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
index 6c71f3c..91efb56 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitQuickDiffProvider.java
@@ -42,6 +42,7 @@
 	 * Create the GitQuickDiffProvider instance
 	 */
 	public GitQuickDiffProvider() {
+		Activator.trace("(GitQuickDiffProvider) constructor");
 		// Empty
 	}
 
@@ -77,6 +78,7 @@ public boolean isEnabled() {
 	}
 
 	public void setActiveEditor(ITextEditor editor) {
+		Activator.trace("(GitQuickDiffProvider) setActiveEditor: " + editor.getTitle());
 		IEditorInput editorInput = editor.getEditorInput();
 		resource = ResourceUtil.getResource(editorInput);
 	}
-- 
1.6.2.1.345.g89fb
