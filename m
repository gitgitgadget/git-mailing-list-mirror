From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 01/25] Use generics for collections in commit dialog and import page
Date: Wed, 18 Mar 2009 01:40:49 +0100
Message-ID: <1237336849-2036-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Mar 18 01:42:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjjrV-0007SV-5N
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 01:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbZCRAkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 20:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbZCRAky
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 20:40:54 -0400
Received: from mail.dewire.com ([83.140.172.130]:19303 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbZCRAky (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 20:40:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 351BF138AD7F;
	Wed, 18 Mar 2009 01:40:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Wii9KzcDHc5; Wed, 18 Mar 2009 01:40:50 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 0C98080289C;
	Wed, 18 Mar 2009 01:40:49 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113543>

A little cleaner and fewer warnings.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../ui/internal/clone/GitProjectsImportPage.java   |   16 ++++++++--------
 .../egit/ui/internal/dialogs/CommitDialog.java     |    2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java
index ece585a..5d82edc 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitProjectsImportPage.java
@@ -508,7 +508,7 @@ public void run(IProgressMonitor monitor) {
 							UIText.WizardProjectsImportPage_SearchingMessage,
 							100);
 					selectedProjects = new ProjectRecord[0];
-					Collection files = new ArrayList();
+					Collection<File> files = new ArrayList<File>();
 					monitor.worked(10);
 					if (directory.isDirectory()) {
 
@@ -516,14 +516,14 @@ public void run(IProgressMonitor monitor) {
 								null, monitor)) {
 							return;
 						}
-						Iterator filesIterator = files.iterator();
+						Iterator<File> filesIterator = files.iterator();
 						selectedProjects = new ProjectRecord[files.size()];
 						int index = 0;
 						monitor.worked(50);
 						monitor
 								.subTask(UIText.WizardProjectsImportPage_ProcessingMessage);
 						while (filesIterator.hasNext()) {
-							File file = (File) filesIterator.next();
+							File file = filesIterator.next();
 							selectedProjects[index] = new ProjectRecord(file);
 							index++;
 						}
@@ -562,8 +562,8 @@ setMessage(UIText.WizardProjectsImportPage_projectsInWorkspace,
 	 *            The monitor to report to
 	 * @return boolean <code>true</code> if the operation was completed.
 	 */
-	private boolean collectProjectFilesFromDirectory(Collection files,
-			File directory, Set directoriesVisited, IProgressMonitor monitor) {
+	private boolean collectProjectFilesFromDirectory(Collection<File> files,
+			File directory, Set<String> directoriesVisited, IProgressMonitor monitor) {
 
 		if (monitor.isCanceled()) {
 			return false;
@@ -577,7 +577,7 @@ private boolean collectProjectFilesFromDirectory(Collection files,
 
 		// Initialize recursion guard for recursive symbolic links
 		if (directoriesVisited == null) {
-			directoriesVisited = new HashSet();
+			directoriesVisited = new HashSet<String>();
 			try {
 				directoriesVisited.add(directory.getCanonicalPath());
 			} catch (IOException exception) {
@@ -759,13 +759,13 @@ public CheckboxTreeViewer getProjectsList() {
 	 *         workspace
 	 */
 	public ProjectRecord[] getValidProjects() {
-		List validProjects = new ArrayList();
+		List<ProjectRecord> validProjects = new ArrayList<ProjectRecord>();
 		for (int i = 0; i < selectedProjects.length; i++) {
 			if (!isProjectInWorkspace(selectedProjects[i].getProjectName())) {
 				validProjects.add(selectedProjects[i]);
 			}
 		}
-		return (ProjectRecord[]) validProjects
+		return validProjects
 				.toArray(new ProjectRecord[validProjects.size()]);
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index b69a4ba..e6bd02d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -366,7 +366,7 @@ public void handleEvent(Event arg0) {
 				}
 				try {
 					ArrayList<GitIndex> changedIndexes = new ArrayList<GitIndex>();
-					for (Iterator<Object> it = sel.iterator(); it.hasNext();) {
+					for (Iterator<?> it = sel.iterator(); it.hasNext();) {
 						CommitItem commitItem = (CommitItem) it.next();
 
 						IProject project = commitItem.file.getProject();
-- 
1.6.1.285.g35d8b
