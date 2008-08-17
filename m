From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 20/31] Move clone logic away from GitCloneWizard to CloneOperation
Date: Sun, 17 Aug 2008 22:44:01 +0200
Message-ID: <1219005852-21496-21-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-16-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-17-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-18-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-19-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-20-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp9E-00038o-17
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbYHQUpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbYHQUpj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:27774 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbYHQUpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489195fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ONcNrTajxjMqgLGDcuEvxgJ8OCsa4uhUR6vuNV5Ba70=;
        b=WicAwt66OcEP17jYsmiqN0CK4cwWIqz90tT0+adhglqpoiILxAoaIjacM+yrcEyAlj
         AF7PjPoXzdkqmoA5O9CL5LsDBFHhIrj/G0not3Kc+FwUgn5zOBbmMQGqA0FPD/NCbh3j
         8Su777UVUW8yOIkNvv2/cnOg4Ak80c2D0dcjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RcPInSntaxeCO1ZnO2N3wbYpCjwG3MLt8XqMXWD3WKbbLxHdezK/5E2Dd+5moNBNag
         bN2uTu8rWkmjpxcBMRg1IdT37ZyNvoQO6zY0jl+UCmsmlhyBviIAojJlSWleCTMHfe8M
         DvnaDOlk2h7Eb0GxrztcYQ9c5VsWRpgSp9db0=
Received: by 10.86.31.19 with SMTP id e19mr3998213fge.45.1219005931214;
        Sun, 17 Aug 2008 13:45:31 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d6sm10373895fga.2.2008.08.17.13.45.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:30 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-20-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92648>

Clone logic was unnaturally splitted between GitCloneWizard and
CloneOperation classes. Now, repository initialization part is moved
to CloneOperation, so there is cleaner separation of responsibilties.

Failure handling is also improved, incompletely cloned repository
directory is removed before reporting problem to user.

Directory creation is problematic issue because of potential errors,
so it's keeped in GitCloneWizard.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/egit/core/op/CloneOperation.java   |  129 +++++++++++++++++---
 .../src/org/spearce/egit/ui/UIText.java            |    4 +
 .../egit/ui/internal/clone/GitCloneWizard.java     |   78 +++----------
 .../src/org/spearce/egit/ui/uitext.properties      |    1 +
 4 files changed, 130 insertions(+), 82 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
index 656f3cb..531045b 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
@@ -3,6 +3,7 @@
  * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Roger C. Soares <rogersoares@intelinet.com.br>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved. This program and the accompanying materials
  * are made available under the terms of the Eclipse Public License v1.0
@@ -10,8 +11,11 @@
  *******************************************************************************/
 package org.spearce.egit.core.op;
 
+import java.io.File;
 import java.io.IOException;
 import java.lang.reflect.InvocationTargetException;
+import java.net.URISyntaxException;
+import java.util.Collection;
 
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.NullProgressMonitor;
@@ -31,39 +35,71 @@ import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.WorkDirCheckout;
 import org.spearce.jgit.transport.FetchResult;
+import org.spearce.jgit.transport.RefSpec;
 import org.spearce.jgit.transport.RemoteConfig;
 import org.spearce.jgit.transport.Transport;
+import org.spearce.jgit.transport.URIish;
 
 /**
  * Clones a repository from a remote location to a local location.
  */
 public class CloneOperation implements IRunnableWithProgress {
-	private final Repository local;
+	private static final String HEADS_PREFIX = Constants.HEADS_PREFIX;
 
-	private final RemoteConfig remote;
+	private static final String REMOTES_PREFIX_S = Constants.REMOTES_PREFIX
+			+ "/";
+
+	private final URIish uri;
+
+	private final boolean allSelected;
+
+	private final Collection<Ref> selectedBranches;
+
+	private final File workdir;
 
 	private final String branch;
 
+	private final String remoteName;
+
+	private Repository local;
+
+	private RemoteConfig remoteConfig;
+
 	private FetchResult fetchResult;
 
 	/**
 	 * Create a new clone operation.
 	 * 
-	 * @param r
-	 *            repository the checkout will happen within.
-	 * @param t
+	 * @param uri
 	 *            remote we should fetch from.
-	 * @param b
+	 * @param allSelected
+	 *            true when all branches have to be fetched (indicates wildcard
+	 *            in created fetch refspec), false otherwise.
+	 * @param selectedBranches
+	 *            collection of branches to fetch. Ignored when allSelected is
+	 *            true.
+	 * @param workdir
+	 *            working directory to clone to. The directory may or may not
+	 *            already exist.
+	 * @param branch
 	 *            branch to initially clone from.
+	 * @param remoteName
+	 *            name of created remote config as source remote (typically
+	 *            named "origin").
 	 */
-	public CloneOperation(final Repository r, final RemoteConfig t,
-			final String b) {
-		local = r;
-		remote = t;
-		branch = b;
+	public CloneOperation(final URIish uri, final boolean allSelected,
+			final Collection<Ref> selectedBranches, final File workdir,
+			final String branch, final String remoteName) {
+		this.uri = uri;
+		this.allSelected = allSelected;
+		this.selectedBranches = selectedBranches;
+		this.workdir = workdir;
+		this.branch = branch;
+		this.remoteName = remoteName;
 	}
 
-	public void run(final IProgressMonitor pm) throws InvocationTargetException {
+	public void run(final IProgressMonitor pm)
+			throws InvocationTargetException, InterruptedException {
 		final IProgressMonitor monitor;
 		if (pm == null)
 			monitor = new NullProgressMonitor();
@@ -71,21 +107,65 @@ public class CloneOperation implements IRunnableWithProgress {
 			monitor = pm;
 
 		try {
-			monitor.beginTask(NLS.bind(CoreText.CloneOperation_title, remote
-					.getURIs().get(0).toString()), 5000);
-			doFetch(new SubProgressMonitor(monitor, 4000));
-			doCheckout(new SubProgressMonitor(monitor, 1000));
-		} catch (IOException e) {
-			if (!monitor.isCanceled())
+			monitor.beginTask(NLS.bind(CoreText.CloneOperation_title, uri),
+					5000);
+			try {
+				doInit(new SubProgressMonitor(monitor, 100));
+				doFetch(new SubProgressMonitor(monitor, 4000));
+				doCheckout(new SubProgressMonitor(monitor, 900));
+			} finally {
+				closeLocal();
+			}
+		} catch (final Exception e) {
+			delete(workdir);
+			if (monitor.isCanceled())
+				throw new InterruptedException();
+			else
 				throw new InvocationTargetException(e);
 		} finally {
 			monitor.done();
 		}
 	}
 
+	private void closeLocal() {
+		if (local != null) {
+			local.close();
+			local = null;
+		}
+	}
+
+	private void doInit(final IProgressMonitor monitor)
+			throws URISyntaxException, IOException {
+		monitor.setTaskName("Initializing local repository");
+
+		final File gitdir = new File(workdir, ".git");
+		local = new Repository(gitdir);
+		local.create();
+		local.writeSymref(Constants.HEAD, branch);
+
+		remoteConfig = new RemoteConfig(local.getConfig(), remoteName);
+		remoteConfig.addURI(uri);
+
+		final String dst = REMOTES_PREFIX_S + remoteConfig.getName();
+		RefSpec wcrs = new RefSpec();
+		wcrs = wcrs.setForceUpdate(true);
+		wcrs = wcrs.setSourceDestination(HEADS_PREFIX + "/*", dst + "/*");
+
+		if (allSelected) {
+			remoteConfig.addFetchRefSpec(wcrs);
+		} else {
+			for (final Ref ref : selectedBranches)
+				if (wcrs.matchSource(ref))
+					remoteConfig.addFetchRefSpec(wcrs.expandFromSource(ref));
+		}
+
+		remoteConfig.update(local.getConfig());
+		local.getConfig().save();
+	}
+
 	private void doFetch(final IProgressMonitor monitor)
 			throws NotSupportedException, TransportException {
-		final Transport tn = Transport.open(local, remote);
+		final Transport tn = Transport.open(local, remoteConfig);
 		try {
 			final EclipseGitProgressTransformer pm;
 			pm = new EclipseGitProgressTransformer(monitor);
@@ -116,4 +196,15 @@ public class CloneOperation implements IRunnableWithProgress {
 		monitor.setTaskName("Writing index");
 		index.write();
 	}
+
+	private static void delete(final File d) {
+		if (d.isDirectory()) {
+			final File[] items = d.listFiles();
+			if (items != null) {
+				for (final File c : items)
+					delete(c);
+			}
+		}
+		d.delete();
+	}
 }
\ No newline at end of file
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 0d39440..9150832 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -53,6 +53,9 @@ public class UIText extends NLS {
 	public static String GitCloneWizard_failed;
 
 	/** */
+	public static String GitCloneWizard_errorCannotCreate;
+
+	/** */
 	public static String RepositorySelectionPage_sourceSelectionTitle;
 
 	/** */
@@ -180,6 +183,7 @@ public class UIText extends NLS {
 
 	/** */
 	public static String ResourceHistory_toggleCommentFill;
+
 	/** */
 	public static String ResourceHistory_toggleRevDetail;
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
index 9c1d691..efcf57f 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/GitCloneWizard.java
@@ -10,9 +10,8 @@
 package org.spearce.egit.ui.internal.clone;
 
 import java.io.File;
-import java.io.IOException;
 import java.lang.reflect.InvocationTargetException;
-import java.net.URISyntaxException;
+import java.util.Collection;
 
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.IStatus;
@@ -29,22 +28,13 @@ import org.spearce.egit.ui.Activator;
 import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIText;
 import org.spearce.egit.ui.internal.components.RepositorySelectionPage;
-import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.Ref;
-import org.spearce.jgit.lib.Repository;
-import org.spearce.jgit.transport.RefSpec;
-import org.spearce.jgit.transport.RemoteConfig;
 import org.spearce.jgit.transport.URIish;
 
 /**
  * Import Git Repository Wizard. A front end to a git clone operation.
  */
 public class GitCloneWizard extends Wizard implements IImportWizard {
-	private static final String HEADS_PREFIX = Constants.HEADS_PREFIX;
-
-	private static final String REMOTES_PREFIX_S = Constants.REMOTES_PREFIX
-			+ "/";
-
 	private RepositorySelectionPage cloneSource;
 
 	private SourceBranchPage validSource;
@@ -68,62 +58,35 @@ public class GitCloneWizard extends Wizard implements IImportWizard {
 
 	@Override
 	public boolean performFinish() {
-		final URIish uri;
-		final Repository db;
-		final RemoteConfig origin;
-
-		uri = cloneSource.getSelection().getURI();
-
+		final URIish uri = cloneSource.getSelection().getURI();
+		final boolean allSelected = validSource.isAllSelected();
+		final Collection<Ref> selectedBranches = validSource
+				.getSelectedBranches();
 		final File workdir = cloneDestination.getDestinationFile();
 		final String branch = cloneDestination.getInitialBranch();
-		final File gitdir = new File(workdir, ".git");
-		try {
-			db = new Repository(gitdir);
-			db.create();
-			db.writeSymref(Constants.HEAD, branch);
+		final String remoteName = cloneDestination.getRemote();
 
-			final String rn = cloneDestination.getRemote();
-			origin = new RemoteConfig(db.getConfig(), rn);
-			origin.addURI(uri);
-
-			final String dst = REMOTES_PREFIX_S + origin.getName();
-			RefSpec wcrs = new RefSpec();
-			wcrs = wcrs.setForceUpdate(true);
-			wcrs = wcrs.setSourceDestination(HEADS_PREFIX + "/*", dst + "/*");
-
-			if (validSource.isAllSelected()) {
-				origin.addFetchRefSpec(wcrs);
-			} else {
-				for (final Ref ref : validSource.getSelectedBranches())
-					if (wcrs.matchSource(ref))
-						origin.addFetchRefSpec(wcrs.expandFromSource(ref));
-			}
-
-			origin.update(db.getConfig());
-			db.getConfig().save();
-		} catch (IOException err) {
-			Activator.logError(UIText.GitCloneWizard_failed, err);
+		if (!workdir.mkdirs()) {
+			final String errorMessage = NLS.bind(
+					UIText.GitCloneWizard_errorCannotCreate, workdir.getPath());
 			ErrorDialog.openError(getShell(), getWindowTitle(),
 					UIText.GitCloneWizard_failed, new Status(IStatus.ERROR,
-							Activator.getPluginId(), 0, err.getMessage(), err));
-			return false;
-		} catch (URISyntaxException e) {
+							Activator.getPluginId(), 0, errorMessage, null));
+			// let's give user a chance to fix this minor problem
 			return false;
 		}
 
-		final CloneOperation op = new CloneOperation(db, origin, branch);
+		final CloneOperation op = new CloneOperation(uri, allSelected,
+				selectedBranches, workdir, branch, remoteName);
 		final Job job = new Job(NLS.bind(UIText.GitCloneWizard_jobName, uri
 				.toString())) {
 			@Override
 			protected IStatus run(final IProgressMonitor monitor) {
 				try {
 					op.run(monitor);
-					if (monitor.isCanceled()) {
-						db.close();
-						delete(workdir);
-						return Status.CANCEL_STATUS;
-					}
 					return Status.OK_STATUS;
+				} catch (InterruptedException e) {
+					return Status.CANCEL_STATUS;
 				} catch (InvocationTargetException e) {
 					Throwable thr = e.getCause();
 					return new Status(IStatus.ERROR, Activator.getPluginId(),
@@ -135,15 +98,4 @@ public class GitCloneWizard extends Wizard implements IImportWizard {
 		job.schedule();
 		return true;
 	}
-
-	private static void delete(final File d) {
-		if (d.isDirectory()) {
-			final File[] items = d.listFiles();
-			if (items != null) {
-				for (final File c : items)
-					delete(c);
-			}
-		}
-		d.delete();
-	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 857568a..420b610 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -30,6 +30,7 @@ ExistingOrNewPage_createInParent=Create repository in project's parent directory
 GitCloneWizard_title=Import Git Repository
 GitCloneWizard_jobName=Cloning from {0}
 GitCloneWizard_failed=Git repository clone failed.
+GitCloneWizard_errorCannotCreate=Cannot create directory {0}.
 
 RepositorySelectionPage_sourceSelectionTitle=Source Git Repository
 RepositorySelectionPage_sourceSelectionDescription=Enter the location of the source repository.
-- 
1.5.6.3
