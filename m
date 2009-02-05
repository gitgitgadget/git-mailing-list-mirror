From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 11/11] Implement label decorations for folders and projects
Date: Thu,  5 Feb 2009 02:00:18 +0100
Message-ID: <1233795618-20249-12-git-send-email-torarnv@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
 <1233795618-20249-2-git-send-email-torarnv@gmail.com>
 <1233795618-20249-3-git-send-email-torarnv@gmail.com>
 <1233795618-20249-4-git-send-email-torarnv@gmail.com>
 <1233795618-20249-5-git-send-email-torarnv@gmail.com>
 <1233795618-20249-6-git-send-email-torarnv@gmail.com>
 <1233795618-20249-7-git-send-email-torarnv@gmail.com>
 <1233795618-20249-8-git-send-email-torarnv@gmail.com>
 <1233795618-20249-9-git-send-email-torarnv@gmail.com>
 <1233795618-20249-10-git-send-email-torarnv@gmail.com>
 <1233795618-20249-11-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 02:07:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUshw-0002D4-Sd
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 02:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbZBEBFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 20:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbZBEBFf
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 20:05:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:22064 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbZBEBFd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 20:05:33 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2646fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 17:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Kplv/z0uxBkPY3wHWMGvdJdSLt5wrLfuLAobQGqudX8=;
        b=Nzru6M73nwMY6WQPzGPMsDU6oJKQsH82FaCxOXaDuNXpbFtmXmux/1T0LfgXAfb3xs
         Up/xlCa9dyz7wB9TReAxMivMWKivP6KqPFdqXj4klbg5JA6at3nCksydQclJ+6gqhGyv
         RpxZ81Ecjek9b9GgbXznl+zLBiadJgDS794Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PpmMVZAsVZjTZrl6cnyxI31WcuYvnvq4Xus2pR716kCpoy8L61ZEgRAaYkSUaM8xt6
         uHL5L7vqslbXcnh8qsxRV6dNtKeGsxJQ66foYYy12NbC8aqfR8KE99qgW7LI+X+yuCnd
         FF6cCXpb3zUl48Wf/+EXCXMN/urKHJEGj+IgU=
Received: by 10.86.60.14 with SMTP id i14mr164fga.21.1233795593059;
        Wed, 04 Feb 2009 16:59:53 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 4sm25209fgg.55.2009.02.04.16.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 16:59:52 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id CE976468008; Thu,  5 Feb 2009 02:00:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1233795618-20249-11-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108488>

The option "Inspect dirty state of children..." controls
if the decoration process should look at child resources
to decide if a container is dirty or not. For large/deep
projects this can be quite time consuming.

The other option, "Also re-decorate ancestors..." controls if
parents of a re-decorated resource also should be updated, for
example to signal that the containing folder is now dirty.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 org.spearce.egit.ui/.options                       |    8 +-
 .../src/org/spearce/egit/ui/Activator.java         |    2 +-
 .../egit/ui/PluginPreferenceInitializer.java       |    3 +-
 .../src/org/spearce/egit/ui/UIPreferences.java     |    4 +-
 .../src/org/spearce/egit/ui/UIText.java            |    5 +-
 .../decorators/GitLightweightDecorator.java        |  344 ++++++++++++=
+++-----
 .../preferences/GitDecoratorPreferencePage.java    |   33 ++-
 .../src/org/spearce/egit/ui/uitext.properties      |    3 +-
 8 files changed, 311 insertions(+), 91 deletions(-)

diff --git a/org.spearce.egit.ui/.options b/org.spearce.egit.ui/.option=
s
index a084b35..8fc1c19 100644
--- a/org.spearce.egit.ui/.options
+++ b/org.spearce.egit.ui/.options
@@ -1 +1,7 @@
-org.spearce.egit.ui/trace/verbose =3D false
+# Debugging options for the org.spearce.egit.ui plugin.
+
+# Show general verbose output
+org.spearce.egit.ui/verbose =3D false
+
+# Show debug output for label decorations
+org.spearce.egit.ui/decorations =3D false
\ No newline at end of file
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java=
 b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
index 9d03c70..45010ce 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
@@ -190,7 +190,7 @@ public Activator() {
=20
 	public void start(final BundleContext context) throws Exception {
 		super.start(context);
-		traceVerbose =3D isOptionSet("/trace/verbose");
+		traceVerbose =3D isOptionSet("/verbose");
 		setupSSH(context);
 		setupProxy(context);
 		setupRepoChangeScanner();
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferen=
ceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/Plugin=
PreferenceInitializer.java
index ef886cf..9af35bc 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceIniti=
alizer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceIniti=
alizer.java
@@ -35,7 +35,8 @@ public void initializeDefaultPreferences() {
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_COMMENT, tru=
e);
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS, false)=
;
=20
-		prefs.setDefault(UIPreferences.DECORATOR_CALCULATE_DIRTY, true);
+		prefs.setDefault(UIPreferences.DECORATOR_RECOMPUTE_ANCESTORS, true);
+		prefs.setDefault(UIPreferences.DECORATOR_COMPUTE_DEEP_DIRTY, true);
 		prefs.setDefault(UIPreferences.DECORATOR_FILETEXT_DECORATION,
 				UIText.DecoratorPreferencesPage_fileFormatDefault);
 		prefs.setDefault(UIPreferences.DECORATOR_FOLDERTEXT_DECORATION,
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.=
java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
index 409b335..f0a5e28 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -53,7 +53,9 @@
 	public final static String THEME_CommitMessageFont =3D "org.spearce.e=
git.ui.CommitMessageFont";
=20
 	/** */
-	public final static String DECORATOR_CALCULATE_DIRTY =3D "decorator_c=
alculate_dirty";
+	public final static String DECORATOR_RECOMPUTE_ANCESTORS =3D "decorat=
or_recompute_ancestors";
+	/** */
+	public final static String DECORATOR_COMPUTE_DEEP_DIRTY =3D "decorato=
r_compute_deep_dirty";
 	/** */
 	public final static String DECORATOR_FILETEXT_DECORATION =3D "decorat=
or_filetext_decoration";
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/=
org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index b62ca4c..5dd28df 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -920,7 +920,10 @@
 	public static String DecoratorPreferencesPage_addVariablesAction;
=20
 	/** */
-	public static String DecoratorPreferencesPage_computeDeep;
+	public static String DecoratorPreferencesPage_recomputeAncestorDecora=
tions;
+
+	/** */
+	public static String DecoratorPreferencesPage_computeDeepDirtyState;
=20
 	/** */
 	public static String DecoratorPreferencesPage_description;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/GitLightweightDecorator.java b/org.spearce.egit.ui/src/org/spearc=
e/egit/ui/internal/decorators/GitLightweightDecorator.java
index 45b9f83..c72bfdb 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
@@ -31,6 +31,7 @@
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.Platform;
 import org.eclipse.jface.preference.IPreferenceStore;
 import org.eclipse.jface.resource.ImageDescriptor;
 import org.eclipse.jface.util.IPropertyChangeListener;
@@ -48,6 +49,7 @@
 import org.eclipse.team.ui.TeamUI;
 import org.eclipse.ui.IContributorResourceAdapter;
 import org.eclipse.ui.PlatformUI;
+import org.spearce.egit.core.ContainerTreeIterator;
 import org.spearce.egit.core.GitException;
 import org.spearce.egit.core.internal.util.ExceptionCollector;
 import org.spearce.egit.core.project.GitProjectData;
@@ -61,6 +63,8 @@
 import org.spearce.jgit.dircache.DirCache;
 import org.spearce.jgit.dircache.DirCacheEntry;
 import org.spearce.jgit.dircache.DirCacheIterator;
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.IndexChangedEvent;
@@ -72,7 +76,11 @@
 import org.spearce.jgit.revwalk.RevWalk;
 import org.spearce.jgit.treewalk.EmptyTreeIterator;
 import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.WorkingTreeIterator;
+import org.spearce.jgit.treewalk.filter.AndTreeFilter;
 import org.spearce.jgit.treewalk.filter.PathFilterGroup;
+import org.spearce.jgit.treewalk.filter.TreeFilter;
+import org.spearce.jgit.util.FS;
=20
 /**
  * Supplies annotations for displayed resources
@@ -110,6 +118,34 @@
 			IStatus.ERROR, Activator.getDefault().getLog());
=20
 	/**
+	 * Property constant indicating if tracing/debugging of decorations i=
s
+	 * enabled
+	 */
+	private static boolean DEBUG_DECORATIONS =3D false;
+
+	static {
+		DEBUG_DECORATIONS =3D "true".equals(Platform.getDebugOption(Activato=
r.getPluginId() + "/decorations")); //$NON-NLS-1$ //$NON-NLS-2$
+	}
+
+	private static void debug(String what) {
+		StackTraceElement frame =3D Thread.currentThread().getStackTrace()[2=
];
+		if (frame.getMethodName().endsWith("access$1"))
+			frame =3D Thread.currentThread().getStackTrace()[3];
+		String className =3D frame.getClassName().substring(
+				frame.getClassName().lastIndexOf('.') + 1);
+		System.out.print(className + "::" + frame.getMethodName() + "(): ");
+
+		debug(what, 0);
+	}
+
+	private static void debug(String what, int numIndents) {
+		for (int i =3D 0; i < numIndents; ++i)
+			System.out.print("\t");
+
+		System.out.println(what);
+	}
+
+	/**
 	 * Constructs a new Git resource decorator
 	 */
 	public GitLightweightDecorator() {
@@ -174,6 +210,9 @@ public void decorate(Object element, IDecoration de=
coration) {
 		if (activator =3D=3D null)
 			return;
=20
+		if (DEBUG_DECORATIONS)
+			debug("deocrating '" + resource.getLocation() + "'");
+
 		try {
 			DecorationHelper helper =3D new DecorationHelper(activator
 					.getPreferenceStore());
@@ -184,7 +223,8 @@ public void decorate(Object element, IDecoration de=
coration) {
 		}
 	}
=20
-	private class DecoratableResourceAdapter implements IDecoratableResou=
rce {
+	private static class DecoratableResourceAdapter implements
+			IDecoratableResource {
=20
 		private final IResource resource;
=20
@@ -212,6 +252,111 @@ public void decorate(Object element, IDecoration =
decoration) {
=20
 		static final int T_WORKSPACE =3D 2;
=20
+		private static class ContainerDiffFilter extends TreeFilter {
+			static final ContainerDiffFilter INSTANCE =3D new ContainerDiffFilt=
er();
+
+			@Override
+			public boolean include(final TreeWalk tw)
+					throws MissingObjectException,
+					IncorrectObjectTypeException, IOException {
+
+				if (tw.getFileMode(T_HEAD) =3D=3D FileMode.MISSING
+						&& tw.getFileMode(T_INDEX) =3D=3D FileMode.MISSING)
+					return false; // Untracked and unstaged, so not dirty
+
+				if (DEBUG_DECORATIONS)
+					debug("checking '" + tw.getPathString() + "'");
+
+				int mHead =3D tw.getRawMode(T_HEAD);
+				int mIndex =3D tw.getRawMode(T_INDEX);
+				int mWorkspace =3D tw.getRawMode(T_WORKSPACE);
+
+				if (!FS.INSTANCE.supportsExecute()) {
+					// We need to clear the executable bits of the head and
+					// index modes, to prevent false positives when the
+					// resource is +x in the repository but not on disk
+					mHead &=3D (~0111);
+					mIndex &=3D (~0111);
+				}
+
+				if (DEBUG_DECORATIONS) {
+					debug("mHead=3D" + Integer.toOctalString(mHead) + " mIndex=3D"
+							+ Integer.toOctalString(mIndex) + " mWorkspace=3D"
+							+ Integer.toOctalString(mWorkspace), 1);
+				}
+
+				if (mHead !=3D mIndex || mHead !=3D mWorkspace) {
+					// If all three modes aren't identical there is a difference
+					// here. Its the fastest test we have and it neatly handles
+					// weird D->F/F->D style changes that may cause issues later
+
+					if (DEBUG_DECORATIONS) {
+						debug("Modes did not match, so concider the whole "
+								+ "tree dirty", 1);
+					}
+
+					return true;
+				}
+
+				if (FileMode.TREE.equals(mHead)) {
+					// We must include trees otherwise the walker won't recurse
+					// into a subtree for us. Computing anything more about a
+					// tree is too expensive from the workspace so we do not do
+					// a prune based on no changes.
+
+					final IPreferenceStore store =3D Activator.getDefault()
+							.getPreferenceStore();
+					return store
+							.getBoolean(UIPreferences.DECORATOR_COMPUTE_DEEP_DIRTY);
+				}
+
+				final DirCacheIterator iIndex =3D tw.getTree(T_INDEX,
+						DirCacheIterator.class);
+				final WorkingTreeIterator iWorkspace =3D tw.getTree(T_WORKSPACE,
+						WorkingTreeIterator.class);
+
+				if (!timestampMatches(iIndex, iWorkspace)) {
+					// If the modification time of the file differs we know the
+					// folder is (possibly) dirty and should be marked as such.
+					// This is faster than the id check below so it goes first.
+
+					if (DEBUG_DECORATIONS) {
+						debug("Timestamps did not match, so concider the "
+								+ "whole tree dirty", 1);
+					}
+
+					return true;
+				}
+
+				if (!tw.idEqual(T_HEAD, T_INDEX)) {
+					// Staged id difference indicates the path is modified.
+
+					if (DEBUG_DECORATIONS) {
+						debug("File is staged, so concider the whole "
+								+ "tree dirty", 1);
+					}
+
+					return true;
+				}
+
+				// TODO: Consider doing a content check here, to rule out false
+				// positives, as we might get mismatch between timestamps, even
+				// if the content is the same
+
+				return false;
+			}
+
+			@Override
+			public boolean shouldBeRecursive() {
+				return true;
+			}
+
+			@Override
+			public TreeFilter clone() {
+				return this;
+			}
+		}
+
 		public DecoratableResourceAdapter(IResource resourceToWrap)
 				throws IOException {
 			resource =3D resourceToWrap;
@@ -219,25 +364,12 @@ public DecoratableResourceAdapter(IResource resou=
rceToWrap)
 			repository =3D mapping.getRepository();
 			headId =3D repository.resolve(Constants.HEAD);
=20
-			switch (resource.getType()) {
-			case IResource.FILE:
-				extractFileProperties();
-				break;
-			case IResource.FOLDER:
-				extractContainerProperties();
-				break;
-			case IResource.PROJECT:
-				extractProjectProperties();
-				break;
-			}
-		}
+			// TODO: Add option to shorten branch name to 6 chars if it's a SHA
+			branch =3D repository.getBranch();
=20
-		private void extractFileProperties() throws IOException {
 			TreeWalk treeWalk =3D createHeadVsIndexTreeWalk();
-			if (treeWalk =3D=3D null)
-				return;
-
-			if (treeWalk.next())
+			if (resource.getType() =3D=3D IResource.PROJECT
+					|| (treeWalk !=3D null && treeWalk.next()))
 				tracked =3D true;
 			else
 				return;
@@ -248,6 +380,27 @@ private void extractFileProperties() throws IOExce=
ption {
 				return;
 			}
=20
+			switch (resource.getType()) {
+			case IResource.FILE:
+				extractFileProperties(treeWalk);
+				break;
+
+			case IResource.FOLDER:
+				extractContainerProperties();
+				break;
+
+			case IResource.PROJECT:
+				final IPreferenceStore store =3D Activator.getDefault()
+						.getPreferenceStore();
+				if (!store
+						.getBoolean(UIPreferences.DECORATOR_COMPUTE_DEEP_DIRTY))
+					return;
+				extractContainerProperties();
+				break;
+			}
+		}
+
+		private void extractFileProperties(TreeWalk treeWalk) {
 			final DirCacheIterator indexIterator =3D treeWalk.getTree(T_INDEX,
 					DirCacheIterator.class);
 			final DirCacheEntry indexEntry =3D indexIterator !=3D null ? indexI=
terator
@@ -265,18 +418,7 @@ private void extractFileProperties() throws IOExce=
ption {
 						.getBits()) {
 					staged =3D Staged.ADDED;
 				} else {
-					long indexEntryLastModified =3D indexEntry.getLastModified();
-					long resourceLastModified =3D resource.getLocalTimeStamp();
-
-					// C-Git under Windows stores timestamps with 1-seconds
-					// resolution, so we need to check to see if this is the
-					// case here, and possibly fix the timestamp of the resource
-					// to match the resolution of the index.
-					if (indexEntryLastModified % 1000 =3D=3D 0) {
-						resourceLastModified -=3D resourceLastModified % 1000;
-					}
-
-					if (resourceLastModified !=3D indexEntryLastModified) {
+					if (!timestampMatches(indexIterator, resource)) {
 						// TODO: Consider doing a content check here, to rule
 						// out false positives, as we might get mismatch between
 						// timestamps, even if the content is the same
@@ -290,37 +432,27 @@ private void extractFileProperties() throws IOExc=
eption {
 					}
 				}
 			}
-
 		}
=20
 		private void extractContainerProperties() throws IOException {
 			TreeWalk treeWalk =3D createHeadVsIndexTreeWalk();
-			if (treeWalk =3D=3D null)
-				return;
-
-			if (treeWalk.next())
-				tracked =3D true;
+			treeWalk.setFilter(AndTreeFilter.create(treeWalk.getFilter(),
+					ContainerDiffFilter.INSTANCE));
+			treeWalk.setRecursive(true);
+
+			if (repository.getWorkDir().equals(
+					resource.getProject().getLocation().toFile()))
+				treeWalk.addTree(new ContainerTreeIterator(resource
+						.getProject()));
 			else
-				return;
-
-			// TODO: Also read ignores from .git/info/excludes et al.
-			if (Team.isIgnoredHint(resource)) {
-				ignored =3D true;
-				return;
-			}
-
-			// TODO: Compute dirty state for folder, using ContainerTreeIterato=
r
-			// and ContainerDiffFilter
-
-		}
-
-		private void extractProjectProperties() throws IOException {
-			branch =3D repository.getBranch();
-			tracked =3D true;
-
-			// TODO: Compute dirty state for folder, using ContainerTreeIterato=
r
-			// and ContainerDiffFilter
+				treeWalk.addTree(new ContainerTreeIterator(resource
+						.getWorkspace().getRoot()));
=20
+			// TODO: Add fallback for projects with the repository more than
+			// one parent up, for example by using a stack of DummyIterators
+		=09
+			if (treeWalk.next())
+				dirty =3D true;
 		}
=20
 		/**
@@ -328,9 +460,10 @@ private void extractProjectProperties() throws IOE=
xception {
 		 * those matching the resource specified by
 		 * <code>resourceToFilterBy</code>
 		 * <p>
-		 * If the resource does not exists in the current repository, or it =
has
-		 * an empty path (it is the project itself), the filter is not added=
,
-		 * and the method returns <code>null</code>.
+		 * If the resource does not exists in the current repository, no fil=
ter
+		 * is added and the method returns <code>false</code>. If the resour=
ce
+		 * is a project, no filter is added, but the operation is considered=
 a
+		 * success.
 		 *=20
 		 * @param treeWalk
 		 *            the tree walk to add the filter to
@@ -344,9 +477,12 @@ private boolean addResourceFilter(final TreeWalk t=
reeWalk,
 				final IResource resourceToFilterBy) {
 			Set<String> repositoryPaths =3D Collections.singleton(mapping
 					.getRepoRelativePath(resourceToFilterBy));
-			if (repositoryPaths.isEmpty() || repositoryPaths.contains(""))
+			if (repositoryPaths.isEmpty())
 				return false;
=20
+			if (repositoryPaths.contains(""))
+				return true; // Project filter
+
 			treeWalk.setFilter(PathFilterGroup
 					.createFromStrings(repositoryPaths));
 			return true;
@@ -376,6 +512,31 @@ private TreeWalk createHeadVsIndexTreeWalk() throw=
s IOException {
 			return treeWalk;
 		}
=20
+		private static boolean timestampMatches(DirCacheIterator index,
+				IResource workspaceResource) {
+			return timestampMatches(index.getDirCacheEntry().getLastModified(),
+					workspaceResource.getLocalTimeStamp());
+		}
+
+		private static boolean timestampMatches(DirCacheIterator index,
+				WorkingTreeIterator workspaceResource) {
+			return timestampMatches(index.getDirCacheEntry().getLastModified(),
+					workspaceResource.getEntryLastModified());
+		}
+
+		private static boolean timestampMatches(long index,
+				long workspaceResource) {
+			// C-Git under Windows stores timestamps with 1-seconds resolution,
+			// so we need to check to see if this is the case here, and possibl=
y
+			// fix the timestamp of the resource to match the resolution of the
+			// index.
+			if (index % 1000 =3D=3D 0) {
+				return index =3D=3D (workspaceResource - (workspaceResource % 1000=
));
+			} else {
+				return index =3D=3D workspaceResource;
+			}
+		}
+
 		public String getName() {
 			return resource.getName();
 		}
@@ -555,11 +716,13 @@ else if (staged =3D=3D Staged.REMOVED)
 				}
=20
 				// Conflicts override everything
-				if (store.getBoolean(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON)
+				if (store
+						.getBoolean(UIPreferences.DECORATOR_SHOW_CONFLICTS_ICON)
 						&& resource.hasConflicts())
 					overlay =3D conflictImage;
=20
-			} else if (store.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_=
ICON)) {
+			} else if (store
+					.getBoolean(UIPreferences.DECORATOR_SHOW_UNTRACKED_ICON)) {
 				overlay =3D untrackedImage;
 			}
=20
@@ -657,6 +820,9 @@ public static void decorate(IDecoration decoration,=
 String format,
 	 * Perform a blanket refresh of all decorations
 	 */
 	public static void refresh() {
+		if (DEBUG_DECORATIONS)
+			debug("blanket refesh");
+
 		Display.getDefault().asyncExec(new Runnable() {
 			public void run() {
 				Activator.getDefault().getWorkbench().getDecoratorManager()
@@ -679,6 +845,9 @@ public void propertyChange(PropertyChangeEvent even=
t) {
 		if (prop.equals(TeamUI.GLOBAL_IGNORES_CHANGED)
 				|| prop.equals(TeamUI.GLOBAL_FILE_TYPES_CHANGED)
 				|| prop.equals(Activator.DECORATORS_CHANGED)) {
+			if (DEBUG_DECORATIONS)
+				debug("property=3D" + prop);
+
 			postLabelEvent(new LabelProviderChangedEvent(this));
 		}
 	}
@@ -696,9 +865,20 @@ public void propertyChange(PropertyChangeEvent eve=
nt) {
 	public void resourceChanged(IResourceChangeEvent event) {
 		final Set<IResource> resourcesToUpdate =3D new HashSet<IResource>();
=20
+		if (DEBUG_DECORATIONS)
+			debug("IResourceChangeEvent");
+
 		try { // Compute the changed resources by looking at the delta
 			event.getDelta().accept(new IResourceDeltaVisitor() {
 				public boolean visit(IResourceDelta delta) throws CoreException {
+
+					// If the file has changed but not in a way that we care
+					// about (e.g. marker changes to files) then ignore
+					if (delta.getKind() =3D=3D IResourceDelta.CHANGED
+							&& (delta.getFlags() & INTERESTING_CHANGES) =3D=3D 0) {
+						return true;
+					}
+
 					final IResource resource =3D delta.getResource();
=20
 					// If the resource is not part of a project under Git
@@ -709,6 +889,11 @@ public boolean visit(IResourceDelta delta) throws =
CoreException {
 						// Ignore the change
 						return true;
 					}
+
+					if (DEBUG_DECORATIONS)
+						debug("Git resource: "
+								+ resource.getLocation().toString(), 1);
+
 					if (resource.getType() =3D=3D IResource.ROOT) {
 						// Continue with the delta
 						return true;
@@ -720,16 +905,10 @@ public boolean visit(IResourceDelta delta) throws=
 CoreException {
 							return false;
 					}
=20
-					// If the file has changed but not in a way that we care
-					// about
-					// (e.g. marker changes to files) then ignore the change
-					if (delta.getKind() =3D=3D IResourceDelta.CHANGED
-							&& (delta.getFlags() & INTERESTING_CHANGES) =3D=3D 0) {
-						return true;
-					}
-
 					// All seems good, schedule the resource for update
 					resourcesToUpdate.add(resource);
+					if (DEBUG_DECORATIONS)
+						debug("Will update this resource", 2);
 					return true;
 				}
 			}, true /* includePhantoms */);
@@ -737,19 +916,25 @@ public boolean visit(IResourceDelta delta) throws=
 CoreException {
 			handleException(null, e);
 		}
=20
-		// If deep decorator calculation is enabled in the preferences we
-		// walk the ancestor tree of each of the changed resources and add
+		if (resourcesToUpdate.isEmpty())
+			return;
+
+		// If ancestor-decoration is enabled in the preferences we walk
+		// the ancestor tree of each of the changed resources and add
 		// their parents to the update set
 		final IPreferenceStore store =3D Activator.getDefault()
 				.getPreferenceStore();
-		if (store.getBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY)) {
+		if (store.getBoolean(UIPreferences.DECORATOR_RECOMPUTE_ANCESTORS)) {
+			if (DEBUG_DECORATIONS)
+				debug("Calulcating dirty ancestor..", 1);
+
 			final IResource[] changedResources =3D resourcesToUpdate
 					.toArray(new IResource[resourcesToUpdate.size()]);
-			for (int i =3D 0; i < changedResources.length; i++) {
-				IResource current =3D changedResources[i];
+			for (IResource current : changedResources) {
 				while (current.getType() !=3D IResource.ROOT) {
 					current =3D current.getParent();
-					resourcesToUpdate.add(current);
+					if (resourcesToUpdate.add(current) && DEBUG_DECORATIONS)
+						debug("Will also update " + current.getLocation(), 2);
 				}
 			}
 		}
@@ -768,6 +953,9 @@ postLabelEvent(new LabelProviderChangedEvent(this, =
resourcesToUpdate
 	 *            The original change event
 	 */
 	private void repositoryChanged(RepositoryChangedEvent e) {
+		if (DEBUG_DECORATIONS)
+			debug("RepositoryChangedEvent=3D" + e.getRepository().getWorkDir())=
;
+
 		final Set<RepositoryMapping> ms =3D new HashSet<RepositoryMapping>()=
;
 		for (final IProject p : ResourcesPlugin.getWorkspace().getRoot()
 				.getProjects()) {
@@ -809,6 +997,9 @@ public void refsChanged(RefsChangedEvent e) {
 	 * @see org.spearce.egit.core.project.RepositoryChangeListener#reposi=
toryChanged(org.spearce.egit.core.project.RepositoryMapping)
 	 */
 	public void repositoryChanged(RepositoryMapping mapping) {
+		if (DEBUG_DECORATIONS)
+			debug("RepositoryMapping=3D" + mapping.getWorkDir());
+
 		// Until we find a way to refresh visible labels within a project
 		// we have to use this blanket refresh that includes all projects.
 		postLabelEvent(new LabelProviderChangedEvent(this));
@@ -845,6 +1036,9 @@ private static IResource getResource(Object elemen=
t) {
 	 *            The event to post
 	 */
 	private void postLabelEvent(final LabelProviderChangedEvent event) {
+		if (DEBUG_DECORATIONS)
+			debug("event=3D" + event.getElements());
+
 		Display.getDefault().asyncExec(new Runnable() {
 			public void run() {
 				fireLabelProviderChanged(event);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/prefe=
rences/GitDecoratorPreferencePage.java b/org.spearce.egit.ui/src/org/sp=
earce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
index 74bc209..1a13a15 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
@@ -89,7 +89,9 @@
=20
 	private Text projectTextFormat;
=20
-	private Button computeDeepDirtyState;
+	private Button recomputeAncestorDecorations;
+
+	private Button computeDeepDirtyStateForContainers;
=20
 	private Button showTracked;
=20
@@ -204,8 +206,10 @@ private Control createGeneralDecoratorPage(Composi=
te parent) {
 		data.horizontalAlignment =3D GridData.FILL;
 		composite.setLayoutData(data);
=20
-		computeDeepDirtyState =3D SWTUtils.createCheckBox(composite,
-				UIText.DecoratorPreferencesPage_computeDeep);
+		recomputeAncestorDecorations =3D SWTUtils.createCheckBox(composite,
+				UIText.DecoratorPreferencesPage_recomputeAncestorDecorations);
+		computeDeepDirtyStateForContainers =3D SWTUtils.createCheckBox(compo=
site,
+				UIText.DecoratorPreferencesPage_computeDeepDirtyState);
=20
 		return composite;
 	}
@@ -317,8 +321,10 @@ public void handleEvent(Event event) {
 	private void initializeValues() {
 		final IPreferenceStore store =3D getPreferenceStore();
=20
-		computeDeepDirtyState.setSelection(store
-				.getBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY));
+		recomputeAncestorDecorations.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_RECOMPUTE_ANCESTORS));
+		computeDeepDirtyStateForContainers.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_COMPUTE_DEEP_DIRTY));
=20
 		fileTextFormat.setText(store
 				.getString(UIPreferences.DECORATOR_FILETEXT_DECORATION));
@@ -342,7 +348,9 @@ public void widgetSelected(SelectionEvent e) {
 			}
 		};
=20
-		computeDeepDirtyState.addSelectionListener(selectionListener);
+		recomputeAncestorDecorations.addSelectionListener(selectionListener)=
;
+		computeDeepDirtyStateForContainers
+				.addSelectionListener(selectionListener);
 		showTracked.addSelectionListener(selectionListener);
 		showUntracked.addSelectionListener(selectionListener);
 		showStaged.addSelectionListener(selectionListener);
@@ -384,8 +392,10 @@ public boolean performOk() {
 	 */
 	private boolean performOk(IPreferenceStore store) {
=20
-		store.setValue(UIPreferences.DECORATOR_CALCULATE_DIRTY,
-				computeDeepDirtyState.getSelection());
+		store.setValue(UIPreferences.DECORATOR_RECOMPUTE_ANCESTORS,
+				recomputeAncestorDecorations.getSelection());
+		store.setValue(UIPreferences.DECORATOR_COMPUTE_DEEP_DIRTY,
+				computeDeepDirtyStateForContainers.getSelection());
=20
 		store.setValue(UIPreferences.DECORATOR_FILETEXT_DECORATION,
 				fileTextFormat.getText());
@@ -414,8 +424,11 @@ protected void performDefaults() {
 		super.performDefaults();
 		IPreferenceStore store =3D getPreferenceStore();
=20
-		computeDeepDirtyState.setSelection(store
-				.getDefaultBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY));
+		recomputeAncestorDecorations
+				.setSelection(store
+						.getDefaultBoolean(UIPreferences.DECORATOR_RECOMPUTE_ANCESTORS))=
;
+		computeDeepDirtyStateForContainers.setSelection(store
+				.getDefaultBoolean(UIPreferences.DECORATOR_COMPUTE_DEEP_DIRTY));
=20
 		fileTextFormat.setText(store
 				.getDefaultString(UIPreferences.DECORATOR_FILETEXT_DECORATION));
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.propert=
ies b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 2762d11..770de4a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -344,7 +344,8 @@ Decorator_exceptionMessage=3DErrors occurred while =
applying Git decorations to res
=20
 DecoratorPreferencesPage_addVariablesTitle=3DAdd Variables
 DecoratorPreferencesPage_addVariablesAction=3DAdd &Variables...
-DecoratorPreferencesPage_computeDeep=3DInclude &ancestors when re-deco=
rating changed resources
+DecoratorPreferencesPage_recomputeAncestorDecorations=3DAlso re-decora=
te &ancestors when decorating changed resources
+DecoratorPreferencesPage_computeDeepDirtyState=3DInspect dirty state o=
f &children when decorating folders and projects
 DecoratorPreferencesPage_description=3DShows Git specific information =
on resources in projects under version control.
=20
 DecoratorPreferencesPage_decorationSettings=3DDecoration &settings:
--=20
1.6.1.2.309.g2ea3
