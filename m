From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Branch bar in resource history.
Date: Sat,  8 Mar 2008 00:40:28 -0500
Message-ID: <1204954828-3937-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 04:43:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXpxl-0002v5-SJ
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 04:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbYCHDmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 22:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYCHDmP
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 22:42:15 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1113 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751013AbYCHDmO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 22:42:14 -0500
Received: (qmail 24002 invoked by uid 0); 8 Mar 2008 00:43:24 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.673259 secs); 08 Mar 2008 03:43:24 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.212.244)
  by cvxbsd.convex.com.br with SMTP; 8 Mar 2008 03:43:22 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76546>

Adds a bar to show the current branch in resource history.
Because other programs can change the current branch, the branch bar
helps the user to remember what is being displayed in resource history.
The bar can be disabled through a local menu preference.
---
 org.spearce.egit.ui/icons/elcl16/branch.gif        |  Bin 0 -> 313 bytes
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |   58 +++++++++++++++++++-
 .../egit/ui/PluginPreferenceInitializer.java       |    1 +
 .../src/org/spearce/egit/ui/UIIcons.java           |    4 ++
 .../src/org/spearce/egit/ui/UIPreferences.java     |    2 +
 .../src/org/spearce/egit/ui/UIText.java            |    4 ++
 .../src/org/spearce/egit/ui/uitext.properties      |    2 +
 7 files changed, 70 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/elcl16/branch.gif

diff --git a/org.spearce.egit.ui/icons/elcl16/branch.gif b/org.spearce.egit.ui/icons/elcl16/branch.gif
new file mode 100644
index 0000000000000000000000000000000000000000..50c33aa61169d83dc88e1e4d4f7aad90f0382bde
GIT binary patch
literal 313
zcmZ?wbhEHb6krfwSZc&z(h^g-t77Brs*QIlHr}b+c(-EHy|PXB$~WCF*>t~j^Znw@
zkMg%X%G>fdcgy3vEl;wxJjvPeBzMcx?5)o-x4lT-_9Aur%j9jZlD5A}+zupP$8Ud~
zu;Weqj<<0;-$(9zAGPyC_|6XzyFP~P`WU|JQ^>AQp}Rf@@A@3F=d1soZ@zoJ`R)Gh
zyXU+2p6@<;etPZw>9O~x=iZ-QYtHu(i4=dbFmf^2Gw3h?0mx4bY+(oH7kKDM^`BT$
zbW(+l;lc_N2bKjPD?_`Vb{&jscy(Nusn<pI(n%3HCM}WEs?9euEaq+#*pOf$B`6@o
hFDzVT&%ngO!pzFf#>v6e?jJNQ#CPVb+3t=E)&PoVqFDd{

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 268a6ba..7096f64 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -63,6 +63,7 @@ import org.eclipse.swt.events.SelectionAdapter;
 import org.eclipse.swt.events.SelectionEvent;
 import org.eclipse.swt.graphics.Font;
 import org.eclipse.swt.graphics.FontData;
+import org.eclipse.swt.graphics.Image;
 import org.eclipse.swt.graphics.Point;
 import org.eclipse.swt.layout.GridData;
 import org.eclipse.swt.layout.GridLayout;
@@ -70,6 +71,7 @@ import org.eclipse.swt.widgets.Composite;
 import org.eclipse.swt.widgets.Control;
 import org.eclipse.swt.widgets.Display;
 import org.eclipse.swt.widgets.Event;
+import org.eclipse.swt.widgets.Label;
 import org.eclipse.swt.widgets.Listener;
 import org.eclipse.swt.widgets.Menu;
 import org.eclipse.swt.widgets.Table;
@@ -115,8 +117,10 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	/* private */static final SimpleDateFormat DATETIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");
 	/* private */static final SimpleDateFormat DATETIMETZ_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss z");
 	/* private */Font BANNER_FONT_BOLD;
+	Image BRANCH_ICON;
 
 	private Composite parentComposite;
+	private Composite branchBarComposite;
 	private SashForm localComposite;
 	private SashForm revisionInfoComposite;
 	/* private */FindToolbar findToolbar;
@@ -127,12 +131,15 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	/* private */TextViewer revDetailTextViewer;
 	/* private */TextViewer revCommentTextViewer;
 	/* private */IAction toggleCommentWrapAction;
+	private IAction toggleBranchBarAction;
 	/* private */IAction toggleRevDetailAction;
 	/* private */IAction toggleRevCommentAction;
 	/* private */IAction toggleTooltipsAction;
 	/* private */IAction findAction;
 
 	/* private */Table table;
+	Label currentBranchLabel;
+
 	private MouseMoveListener tableMouseMoveListener;
 
 	/* private */List<IFileRevision> fileRevisions;
@@ -172,6 +179,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		Font bannerFont = JFaceResources.getBannerFont();
 		BANNER_FONT_BOLD = new Font(parent.getDisplay(),
 				new FontData(bannerFont.getFontData()[0].getName(), bannerFont.getFontData()[0].getHeight(), SWT.BOLD));
+		BRANCH_ICON = UIIcons.ELCL16_BRANCH.createImage();
 
 		parentComposite = new Composite(parent, SWT.NULL);
 		GridLayout parentLayout = new GridLayout();
@@ -182,6 +190,22 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		GridData parentData = new GridData(SWT.FILL, SWT.FILL, true, true);
 		parentComposite.setLayoutData(parentData);
 
+		branchBarComposite = new Composite(parentComposite, SWT.NULL);
+		GridLayout bbl = new GridLayout();
+		bbl.marginHeight = 0;
+		bbl.marginWidth = 1;
+		bbl.verticalSpacing = 0;
+		bbl.horizontalSpacing = 2;
+		bbl.numColumns = 2;
+		branchBarComposite.setLayoutData(new GridData(SWT.FILL, SWT.FILL, false, false));
+		branchBarComposite.setLayout(bbl);
+
+		Label branchIcon = new Label(branchBarComposite, SWT.NULL);
+		branchIcon.setImage(BRANCH_ICON);
+		branchIcon.setToolTipText(UIText.ResourceHistory_currentBranchTooltip);
+		currentBranchLabel = new Label(branchBarComposite, SWT.NULL);
+		currentBranchLabel.setToolTipText(UIText.ResourceHistory_currentBranchTooltip);
+
 		localComposite = new SashForm(parentComposite, SWT.VERTICAL);
 		GridData data = new GridData(SWT.FILL, SWT.FILL, true, true);
 		localComposite.setLayoutData(data);
@@ -376,6 +400,15 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		};
 		toggleCommentWrapAction.setChecked(prefs.getBoolean(UIPreferences.RESOURCEHISTORY_SHOW_COMMENT_WRAP));
 
+		toggleBranchBarAction = new Action(UIText.ResourceHistory_toggleBranchBar) {
+			public void run() {
+				showHideBranchBar();
+				prefs.setValue(UIPreferences.RESOURCEHISTORY_SHOW_BRANCHBAR, toggleBranchBarAction.isChecked());
+				Activator.getDefault().savePluginPreferences();
+			}
+		};
+		toggleBranchBarAction.setChecked(prefs.getBoolean(UIPreferences.RESOURCEHISTORY_SHOW_BRANCHBAR));
+
 		toggleRevDetailAction = new Action(UIText.ResourceHistory_toggleRevDetail) {
 			public void run() {
 				updateResourceHistoryComposites();
@@ -408,12 +441,14 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		if (menuManager != null) {
 			menuManager.add(toggleCommentWrapAction);
 			menuManager.add(new Separator());
+			menuManager.add(toggleBranchBarAction);
 			menuManager.add(toggleRevDetailAction);
 			menuManager.add(toggleRevCommentAction);
 			menuManager.add(toggleTooltipsAction);
 			menuManager.add(new Separator());
 		}
 		actionBars.updateActionBars();
+		showHideBranchBar();
 		updateResourceHistoryComposites();
 		updateShowTooltips();
 		showHideFindToolbar();
@@ -422,6 +457,15 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		revisionInfoComposite.setWeights(new int[] {40, 60});
 	}
 
+	private void showHideBranchBar() {
+		if(toggleBranchBarAction.isChecked()) {
+			((GridData) branchBarComposite.getLayoutData()).heightHint = SWT.DEFAULT;
+		} else {
+			((GridData) branchBarComposite.getLayoutData()).heightHint = 0;
+		}
+		parentComposite.layout();
+	}
+
 	/* private */void updateResourceHistoryComposites() {
 		boolean commentWrap = toggleCommentWrapAction.isChecked();
 		boolean showRevDetail = toggleRevDetailAction.isChecked();
@@ -471,6 +515,11 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 		parentComposite.layout();
 	}
 
+	private void updateCurrentBranch(String currentBranchName) {
+		currentBranchLabel.setText(currentBranchName);
+		branchBarComposite.layout();
+	}
+
 	/* private */boolean isShowAllRepoVersions() {
 		return showAllRepoVersions;
 	}
@@ -975,6 +1024,12 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				Map newappliedPatches = null;
 				try {
 					newappliedPatches = repositoryMapping.getRepository().getAppliedPatches();
+					final String currentBranchName = repositoryMapping.getRepository().getBranch();
+					table.getDisplay().asyncExec(new Runnable() {
+						public void run() {
+							updateCurrentBranch(currentBranchName);
+						}
+					});
 				} catch (IOException e) {
 					// TODO Auto-generated catch block
 					e.printStackTrace();
@@ -1063,7 +1118,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 				});
 				final Map fnewappliedPatches = newappliedPatches;
 				final Map<ObjectId,Tag[]> ftags = newtags;
-	
+
 				table.getDisplay().asyncExec(new Runnable() {
 				
 					public void run() {
@@ -1293,6 +1348,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 	@Override
 	public void dispose() {
 		BANNER_FONT_BOLD.dispose();
+		BRANCH_ICON.dispose();
 		super.dispose();
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
index ecb79b8..e480a9e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
@@ -41,6 +41,7 @@ public class PluginPreferenceInitializer extends AbstractPreferenceInitializer {
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_DETAIL, true);
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_COMMENT, true);
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS, false);
+		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_BRANCHBAR, true);
 
 		prefs.setDefault(UIPreferences.FINDTOOLBAR_IGNORE_CASE, true);
 		prefs.setDefault(UIPreferences.FINDTOOLBAR_COMMIT_ID, true);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index 881265d..7172aec 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -47,6 +47,9 @@ public class UIIcons {
 	/** Previous arrow icon */
 	public static final ImageDescriptor ELCL16_PREVIOUS;
 
+	/** Branch icon */
+	public static final ImageDescriptor ELCL16_BRANCH;
+
 	private static final URL base;
 
 	static {
@@ -59,6 +62,7 @@ public class UIIcons {
 		ELCL16_FIND = map("elcl16/find.gif");
 		ELCL16_NEXT = map("elcl16/next.gif");
 		ELCL16_PREVIOUS = map("elcl16/previous.gif");
+		ELCL16_BRANCH = map("elcl16/branch.gif");
 	}
 
 	private static ImageDescriptor map(final String icon) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
index cb9443b..de1dc10 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -32,6 +32,8 @@ public class UIPreferences {
 	/** */
 	public final static String RESOURCEHISTORY_SHOW_FINDTOOLBAR = "resourcehistory_show_findtoolbar";
 	/** */
+	public final static String RESOURCEHISTORY_SHOW_BRANCHBAR = "resourcehistory_show_branchbar";
+	/** */
 	public final static String FINDTOOLBAR_IGNORE_CASE = "findtoolbar_ignore_case";
 	/** */
 	public final static String FINDTOOLBAR_COMMIT_ID = "findtoolbar_commit_id";
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 1454124..4f0aeb8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -56,11 +56,15 @@ public class UIText extends NLS {
 	/** */
 	public static String ResourceHistory_toggleCommentWrap;
 	/** */
+	public static String ResourceHistory_toggleBranchBar;
+	/** */
 	public static String ResourceHistory_toggleRevDetail;
 	/** */
 	public static String ResourceHistory_toggleRevComment;
 	/** */
 	public static String ResourceHistory_toggleTooltips;
+	/** */
+	public static String ResourceHistory_currentBranchTooltip;
 
 	static {
 		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index be02978..c4eb779 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -30,6 +30,8 @@ Decorator_failedLazyLoading=Resource decorator failed to load tree contents on d
 QuickDiff_failedLoading=Quick diff failed to obtain file data.
 
 ResourceHistory_toggleCommentWrap=Wrap Comments
+ResourceHistory_toggleBranchBar=Show Branch Bar
 ResourceHistory_toggleRevDetail=Show Revision Details
 ResourceHistory_toggleRevComment=Show Revision Comment
 ResourceHistory_toggleTooltips=Show Revision Tooltip
+ResourceHistory_currentBranchTooltip=Current Branch
-- 
1.5.4.1

