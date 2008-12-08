From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Use Constant.HEAD for "HEAD" references
Date: Mon,  8 Dec 2008 22:49:06 +0100
Message-ID: <1228772946-2491-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 08 22:50:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9nzw-0002jW-FY
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 22:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYLHVtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 16:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbYLHVtM
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 16:49:12 -0500
Received: from mail.dewire.com ([83.140.172.130]:14144 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbYLHVtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 16:49:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8A30F802855;
	Mon,  8 Dec 2008 22:49:08 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5INW8lbIaoiA; Mon,  8 Dec 2008 22:49:06 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 76F9C800251;
	Mon,  8 Dec 2008 22:49:06 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102587>

Unit tests are excluded.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/core/internal/storage/GitFileHistory.java |    3 ++-
 .../org/spearce/egit/core/op/BranchOperation.java  |    7 ++++---
 .../org/spearce/egit/core/op/ResetOperation.java   |    4 ++--
 .../egit/core/project/RepositoryMapping.java       |    3 ++-
 .../egit/ui/internal/actions/CommitAction.java     |   13 +++++++------
 .../actions/ResetQuickdiffBaselineAction.java      |    3 ++-
 .../egit/ui/internal/decorators/GitDocument.java   |    3 ++-
 .../internal/decorators/GitResourceDecorator.java  |    3 ++-
 .../egit/ui/internal/dialogs/CommitDialog.java     |    3 ++-
 .../egit/ui/internal/history/GitHistoryPage.java   |    3 ++-
 .../src/org/spearce/jgit/lib/IndexDiff.java        |    2 +-
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 .../spearce/jgit/transport/TransportAmazonS3.java  |    3 ++-
 .../org/spearce/jgit/transport/TransportSftp.java  |    3 ++-
 .../spearce/jgit/transport/WalkPushConnection.java |    2 +-
 15 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileHistory.java
index c01c1c3..8b47c37 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileHistory.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileHistory.java
@@ -20,6 +20,7 @@
 import org.spearce.egit.core.Activator;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.revwalk.RevCommit;
@@ -78,7 +79,7 @@ private KidWalk buildWalk(final int flags) {
 		final Repository db = walk.getRepository();
 		final RevCommit root;
 		try {
-			final AnyObjectId headId = db.resolve("HEAD");
+			final AnyObjectId headId = db.resolve(Constants.HEAD);
 			if (headId == null) {
 				Activator.logError("No HEAD revision available from Git"
 						+ " for project " + resource.getProject().getName()
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/BranchOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/BranchOperation.java
index c50d743..f472f29 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/BranchOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/BranchOperation.java
@@ -21,6 +21,7 @@
 import org.eclipse.team.core.TeamException;
 import org.spearce.jgit.errors.CheckoutConflictException;
 import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.RefLogWriter;
 import org.spearce.jgit.lib.Repository;
@@ -105,7 +106,7 @@ private void writeHeadReflog() throws TeamException {
 		try {
 			RefLogWriter.writeReflog(repository, oldCommit.getCommitId(),
 					newCommit.getCommitId(), "checkout: moving to " + refName,
-					"HEAD");
+					Constants.HEAD);
 		} catch (IOException e) {
 			throw new TeamException("Writing HEAD's reflog", e);
 		}
@@ -113,7 +114,7 @@ private void writeHeadReflog() throws TeamException {
 
 	private void updateHeadRef() throws TeamException {
 		try {
-			repository.writeSymref("HEAD", refName);
+			repository.writeSymref(Constants.HEAD, refName);
 		} catch (IOException e) {
 			throw new TeamException("Updating HEAD to ref: " + refName, e);
 		}
@@ -157,7 +158,7 @@ private void lookupRefs() throws TeamException {
 		}
 
 		try {
-			oldCommit = repository.mapCommit("HEAD");
+			oldCommit = repository.mapCommit(Constants.HEAD);
 		} catch (IOException e) {
 			throw new TeamException("Mapping commit HEAD commit", e);
 		}
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/ResetOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/ResetOperation.java
index f6b10d0..c28d618 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/ResetOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/ResetOperation.java
@@ -161,7 +161,7 @@ private void mapObjects() throws TeamException {
 		}
 		
 		try {
-			previousCommit = repository.mapCommit(repository.resolve("HEAD"));
+			previousCommit = repository.mapCommit(repository.resolve(Constants.HEAD));
 		} catch (IOException e) {
 			throw new TeamException("looking up HEAD commit", e);
 		}
@@ -233,7 +233,7 @@ private void writeReflog(String reflogRelPath) throws IOException {
 
 	private void writeReflogs() throws TeamException {
 		try {
-			writeReflog("HEAD");
+			writeReflog(Constants.HEAD);
 			writeReflog(repository.getFullBranch());
 		} catch (IOException e) {
 			throw new TeamException("Writing reflogs", e);
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
index 8eb6072..e9df630 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
@@ -24,6 +24,7 @@
 import org.eclipse.core.runtime.Path;
 import org.eclipse.team.core.RepositoryProvider;
 import org.spearce.egit.core.GitProvider;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Tree;
@@ -182,7 +183,7 @@ public boolean isResourceChanged(IResource rsrc) throws IOException, Unsupported
 		Repository repository = getRepository();
 		GitIndex index = repository.getIndex();
 		String repoRelativePath = getRepoRelativePath(rsrc);
-		Tree headTree = repository.mapTree("HEAD");
+		Tree headTree = repository.mapTree(Constants.HEAD);
 		TreeEntry blob = headTree!=null ? headTree.findBlobMember(repoRelativePath) : null;
 		Entry entry = index.getEntry(repoRelativePath);
 		if (rsrc instanceof IFile && entry == null && blob == null)
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index d703048..5617b5a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -33,6 +33,7 @@
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.internal.dialogs.CommitDialog;
 import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.IndexDiff;
 import org.spearce.jgit.lib.ObjectId;
@@ -128,7 +129,7 @@ private void loadPreviousCommit() {
 
 		Repository repo = RepositoryMapping.getMapping(project).getRepository();
 		try {
-			ObjectId parentId = repo.resolve("HEAD");
+			ObjectId parentId = repo.resolve(Constants.HEAD);
 			if (parentId != null)
 				previousCommit = repo.mapCommit(parentId);
 		} catch (IOException e) {
@@ -165,7 +166,7 @@ private String doCommits(CommitDialog commitDialog, String commitMessage,
 			Repository repo = tree.getRepository();
 			writeTreeWithSubTrees(tree);
 
-			ObjectId currentHeadId = repo.resolve("HEAD");
+			ObjectId currentHeadId = repo.resolve(Constants.HEAD);
 			ObjectId[] parentIds;
 			if (amending) {
 				parentIds = previousCommit.getParentIds();
@@ -202,7 +203,7 @@ private String doCommits(CommitDialog commitDialog, String commitMessage,
 			ObjectWriter writer = new ObjectWriter(repo);
 			commit.setCommitId(writer.writeCommit(commit));
 
-			final RefUpdate ru = repo.updateRef("HEAD");
+			final RefUpdate ru = repo.updateRef(Constants.HEAD);
 			ru.setNewObjectId(commit.getCommitId());
 			ru.setRefLogMessage(buildReflogMessage(commitMessage), false);
 			if (ru.forceUpdate() == RefUpdate.Result.LOCK_FAILURE) {
@@ -221,7 +222,7 @@ private void prepareTrees(IFile[] selectedItems,
 			for (IProject proj : getSelectedProjects()) {
 				Repository repo = RepositoryMapping.getMapping(proj).getRepository();
 				if (!treeMap.containsKey(repo))
-					treeMap.put(repo, repo.mapTree("HEAD"));
+					treeMap.put(repo, repo.mapTree(Constants.HEAD));
 			}
 		}
 
@@ -233,7 +234,7 @@ private void prepareTrees(IFile[] selectedItems,
 			Repository repository = repositoryMapping.getRepository();
 			Tree projTree = treeMap.get(repository);
 			if (projTree == null) {
-				projTree = repository.mapTree("HEAD");
+				projTree = repository.mapTree(Constants.HEAD);
 				if (projTree == null)
 					projTree = new Tree(repository);
 				treeMap.put(repository, projTree);
@@ -317,7 +318,7 @@ private void buildIndexHeadDiffList() throws IOException {
 			RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(project);
 			assert repositoryMapping != null;
 			Repository repository = repositoryMapping.getRepository();
-			Tree head = repository.mapTree("HEAD");
+			Tree head = repository.mapTree(Constants.HEAD);
 			GitIndex index = repository.getIndex();
 			IndexDiff indexDiff = new IndexDiff(head, index);
 			indexDiff.diff();
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java
index 597ee10..d7097ba 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java
@@ -11,6 +11,7 @@
 
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.jface.action.IAction;
+import org.spearce.jgit.lib.Constants;
 
 /**
  * Changes the reference for the quickdiff to HEAD
@@ -19,6 +20,6 @@
 
 	@Override
 	protected IWorkspaceRunnable createOperation(IAction act, List selection) {
-		return new QuickdiffBaselineOperation(getActiveRepository(), "HEAD");
+		return new QuickdiffBaselineOperation(getActiveRepository(), Constants.HEAD);
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
index 6e10144..a985a68 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
@@ -16,6 +16,7 @@
 import org.spearce.egit.core.GitProvider;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.Activator;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.IndexChangedEvent;
 import org.spearce.jgit.lib.ObjectLoader;
 import org.spearce.jgit.lib.RefsChangedEvent;
@@ -52,7 +53,7 @@ void populate() throws IOException {
 		repository.addRepositoryChangedListener(this);
 		String baseline = GitQuickDiffProvider.baseline.get(repository);
 		if (baseline == null)
-			baseline = "HEAD";
+			baseline = Constants.HEAD;
 		Tree baselineTree = repository.mapTree(baseline);
 		if (baselineTree == null) {
 			Activator.logError("Could not resolve quickdiff baseline "
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 97a0311..c3ae52d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -47,6 +47,7 @@
 import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.IndexChangedEvent;
 import org.spearce.jgit.lib.RefsChangedEvent;
@@ -295,7 +296,7 @@ public void decorate(final Object element, final IDecoration decoration) {
 				Repository repository = mapped.getRepository();
 				GitIndex index = repository.getIndex();
 				String repoRelativePath = mapped.getRepoRelativePath(rsrc);
-				Tree headTree = repository.mapTree("HEAD");
+				Tree headTree = repository.mapTree(Constants.HEAD);
 				TreeEntry blob = headTree!=null ? headTree.findBlobMember(repoRelativePath) : null;
 				Entry entry = index.getEntry(repoRelativePath);
 				if (entry == null) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index 4f932f2..a16d441 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -49,6 +49,7 @@
 import org.eclipse.swt.widgets.Text;
 import org.eclipse.ui.model.WorkbenchLabelProvider;
 import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Repository;
@@ -78,7 +79,7 @@ else if (columnIndex == 0) {
 
 					Repository repo = repositoryMapping.getRepository();
 					GitIndex index = repo.getIndex();
-					Tree headTree = repo.mapTree("HEAD");
+					Tree headTree = repo.mapTree(Constants.HEAD);
 
 					String repoPath = repositoryMapping
 							.getRepoRelativePath(file);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index e3ff8d4..d718cd7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -61,6 +61,7 @@
 import org.spearce.egit.ui.UIPreferences;
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.IndexChangedEvent;
 import org.spearce.jgit.lib.RefsChangedEvent;
 import org.spearce.jgit.lib.Repository;
@@ -575,7 +576,7 @@ else if (db != map.getRepository())
 
 		final AnyObjectId headId;
 		try {
-			headId = db.resolve("HEAD");
+			headId = db.resolve(Constants.HEAD);
 		} catch (IOException e) {
 			Activator.logError("Cannot parse HEAD in: "
 					+ db.getDirectory().getAbsolutePath(), e);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexDiff.java b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexDiff.java
index 86f83b9..db395f3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexDiff.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexDiff.java
@@ -59,7 +59,7 @@
 	 * @throws IOException
 	 */
 	public IndexDiff(Repository repository) throws IOException {
-		this.tree = repository.mapTree("HEAD");
+		this.tree = repository.mapTree(Constants.HEAD);
 		this.index = repository.getIndex();
 	}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index b63ef18..a319c00 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -883,7 +883,7 @@ public String getPatch() throws IOException {
 	 * @throws IOException
 	 */
 	public String getFullBranch() throws IOException {
-		final File ptr = new File(getDirectory(),"HEAD");
+		final File ptr = new File(getDirectory(),Constants.HEAD);
 		final BufferedReader br = new BufferedReader(new FileReader(ptr));
 		String ref;
 		try {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
index 9f1b516..a9fcdb9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3.java
@@ -53,6 +53,7 @@
 
 import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
@@ -257,7 +258,7 @@ void writeFile(final String path, final byte[] data) throws IOException {
 			final TreeMap<String, Ref> avail = new TreeMap<String, Ref>();
 			readPackedRefs(avail);
 			readLooseRefs(avail);
-			readRef(avail, "HEAD");
+			readRef(avail, Constants.HEAD);
 			return avail;
 		}
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index 544e77c..d8b4ff7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -53,6 +53,7 @@
 import java.util.TreeMap;
 
 import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.ProgressMonitor;
 import org.spearce.jgit.lib.Ref;
@@ -372,7 +373,7 @@ private void mkdir_p(String path) throws IOException {
 		Map<String, Ref> readAdvertisedRefs() throws TransportException {
 			final TreeMap<String, Ref> avail = new TreeMap<String, Ref>();
 			readPackedRefs(avail);
-			readRef(avail, ROOT_DIR + "HEAD", "HEAD");
+			readRef(avail, ROOT_DIR + Constants.HEAD, Constants.HEAD);
 			readLooseRefs(avail, ROOT_DIR + "refs", "refs/");
 			return avail;
 		}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
index 601ae66..3246ee6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -336,7 +336,7 @@ private void createNewRepository(final List<RemoteRefUpdate> updates)
 		try {
 			final String ref = "ref: " + pickHEAD(updates) + "\n";
 			final byte[] bytes = Constants.encode(ref);
-			dest.writeFile(ROOT_DIR + "HEAD", bytes);
+			dest.writeFile(ROOT_DIR + Constants.HEAD, bytes);
 		} catch (IOException e) {
 			throw new TransportException(uri, "cannot create HEAD", e);
 		}
-- 
1.6.0.3.640.g6331a
