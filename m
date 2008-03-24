From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 3/4] Add "find in references" to the find toolbar.
Date: Sun, 23 Mar 2008 22:57:46 -0400
Message-ID: <1206327466-6521-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 02:59:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdbyM-00054D-4Z
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 02:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbYCXB64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 21:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbYCXB6z
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 21:58:55 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1390 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754260AbYCXB6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 21:58:54 -0400
Received: (qmail 4620 invoked by uid 0); 23 Mar 2008 23:01:21 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.769914 secs); 24 Mar 2008 02:01:21 -0000
Received: from unknown (HELO localhost.localdomain) (189.79.228.249)
  by cvxbsd.convex.com.br with SMTP; 24 Mar 2008 02:01:19 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77992>

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 org.spearce.egit.ui/icons/elcl16/refs.gif          |  Bin 0 -> 340 bytes
 .../src/org/spearce/egit/ui/FindToolbar.java       |   55 ++++++++++++++++++-
 .../src/org/spearce/egit/ui/FindToolbarThread.java |   58 ++++++++++++++++++--
 .../src/org/spearce/egit/ui/GitHistoryPage.java    |    2 +-
 .../src/org/spearce/egit/ui/UIIcons.java           |    3 +
 .../src/org/spearce/egit/ui/UIText.java            |    2 +
 .../src/org/spearce/egit/ui/uitext.properties      |    1 +
 7 files changed, 114 insertions(+), 7 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/elcl16/refs.gif

diff --git a/org.spearce.egit.ui/icons/elcl16/refs.gif b/org.spearce.egit.ui/icons/elcl16/refs.gif
new file mode 100644
index 0000000000000000000000000000000000000000..f605ae6206a87ac162c1377f7e47d494dda7cb2b
GIT binary patch
literal 340
zcmZ?wbhEHb6krfwSZcwbmgJ(D<!M+OZdey#(h{>QTVQ3Lz`Dgc9cw*1)_S$C^XypX
z(Xr06bDdAediTx^?%mt$dUu&s?y8u$%j@pWtd-X?S6$0kbv=F6^^8?FQdZqaTXiFS
z)y>qkcTzUquG)B~V&k34jdv?H-7DL4uYAL!$W8Z4Hr+4Xe7|_ZGr!GGGB&?)`F*$f
z_x;Y__q%>Snf?38oIgPHbk6UW>;Al4_xsh_->=sF0iw4%|Kk9PKUo;L80;Bz7=Qre
zCkD2{1M>?!bfo%EJlS|4$B5tUaIV)}u`brx*W4zb&D#2U!vn3^$s59bZ1Q$S>+IOg
zAmGu~HnncOzDo#;i=Q96fJUP;BQGZh7Y{cdzpzS&6SJt8gt)YnjHImQRC^XV1qFFU
XWhFIL^+iG~8#iq(_uA&=$Y2cs2pX!@

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
index f744db7..4396cda 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
@@ -18,6 +18,7 @@ package org.spearce.egit.ui;
 
 import java.util.ArrayList;
 import java.util.List;
+import java.util.Map;
 
 import org.eclipse.core.runtime.Preferences;
 import org.eclipse.swt.SWT;
@@ -49,6 +50,8 @@ import org.eclipse.swt.widgets.ToolBar;
 import org.eclipse.swt.widgets.ToolItem;
 import org.eclipse.swt.widgets.Widget;
 import org.eclipse.team.core.history.IFileRevision;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Tag;
 
 /**
  * A toolbar for the history page.
@@ -62,6 +65,8 @@ public class FindToolbar extends Composite {
 
 	private static final int PREFS_FINDIN_COMMENTS = 2;
 
+	private static final int PREFS_FINDIN_REFS = 3;
+
 	private static final int PREFS_FINDIN_AUTHOR = 4;
 
 	private static final int PREFS_FINDIN_COMMITTER = 5;
@@ -81,6 +86,10 @@ public class FindToolbar extends Composite {
 
 	private List<IFileRevision> fileRevisions;
 
+	private Map<ObjectId, Tag[]> tags;
+
+	private Map<ObjectId, String[]> branches;
+
 	private Text patternField;
 
 	private Button nextButton;
@@ -97,6 +106,8 @@ public class FindToolbar extends Composite {
 
 	private MenuItem commentsItem;
 
+	private MenuItem refsItem;
+
 	private MenuItem authorItem;
 
 	private MenuItem committerItem;
@@ -109,6 +120,8 @@ public class FindToolbar extends Composite {
 
 	private Image commentsIcon;
 
+	private Image referencesIcon;
+
 	private Image authorIcon;
 
 	private Image committerIcon;
@@ -130,6 +143,7 @@ public class FindToolbar extends Composite {
 		previousIcon = UIIcons.ELCL16_PREVIOUS.createImage();
 		commitIdIcon = UIIcons.ELCL16_COMMIT.createImage();
 		commentsIcon = UIIcons.ELCL16_COMMENTS.createImage();
+		referencesIcon = UIIcons.ELCL16_REFERENCES.createImage();
 		authorIcon = UIIcons.ELCL16_AUTHOR.createImage();
 		committerIcon = UIIcons.ELCL16_COMMITTER.createImage();
 
@@ -170,6 +184,8 @@ public class FindToolbar extends Composite {
 		commitIdItem.setText("Revision");
 		commentsItem = new MenuItem(prefsMenu, SWT.RADIO);
 		commentsItem.setText("Comments");
+		refsItem = new MenuItem(prefsMenu, SWT.RADIO);
+		refsItem.setText("References");
 		authorItem = new MenuItem(prefsMenu, SWT.RADIO);
 		authorItem.setText("Author");
 		committerItem = new MenuItem(prefsMenu, SWT.RADIO);
@@ -189,6 +205,9 @@ public class FindToolbar extends Composite {
 						commentsItem.notifyListeners(SWT.Selection, null);
 						break;
 					case PREFS_FINDIN_COMMENTS:
+						refsItem.notifyListeners(SWT.Selection, null);
+						break;
+					case PREFS_FINDIN_REFS:
 						authorItem.notifyListeners(SWT.Selection, null);
 						break;
 					case PREFS_FINDIN_AUTHOR:
@@ -225,10 +244,13 @@ public class FindToolbar extends Composite {
 				final FindToolbarThread finder = new FindToolbarThread();
 				finder.pattern = ((Text) e.getSource()).getText();
 				finder.fileRevisions = fileRevisions;
+				finder.tags = tags;
+				finder.branches = branches;
 				finder.toolbar = thisToolbar;
 				finder.ignoreCase = caseItem.getSelection();
 				finder.findInCommitId = commitIdItem.getSelection();
 				finder.findInComments = commentsItem.getSelection();
+				finder.findInReferences = refsItem.getSelection();
 				finder.findInAuthor = authorItem.getSelection();
 				finder.findInCommitter = committerItem.getSelection();
 				Display.getDefault().timerExec(200, new Runnable() {
@@ -248,10 +270,13 @@ public class FindToolbar extends Composite {
 					final FindToolbarThread finder = new FindToolbarThread();
 					finder.pattern = patternField.getText();
 					finder.fileRevisions = fileRevisions;
+					finder.tags = tags;
+					finder.branches = branches;
 					finder.toolbar = thisToolbar;
 					finder.ignoreCase = caseItem.getSelection();
 					finder.findInCommitId = commitIdItem.getSelection();
 					finder.findInComments = commentsItem.getSelection();
+					finder.findInReferences = refsItem.getSelection();
 					finder.findInAuthor = authorItem.getSelection();
 					finder.findInCommitter = committerItem.getSelection();
 					finder.start();
@@ -339,7 +364,7 @@ public class FindToolbar extends Composite {
 			public void widgetSelected(SelectionEvent e) {
 				prefsItem.setImage(commentsIcon);
 				prefsItem
-						.setToolTipText(UIText.ResourceHistory_findbar_changeto_author);
+						.setToolTipText(UIText.ResourceHistory_findbar_changeto_refs);
 				prefsItemChanged(PREFS_FINDIN_COMMENTS, commentsItem);
 			}
 		});
@@ -347,6 +372,21 @@ public class FindToolbar extends Composite {
 			commentsItem.setSelection(true);
 			prefsItem.setImage(commentsIcon);
 			prefsItem
+					.setToolTipText(UIText.ResourceHistory_findbar_changeto_refs);
+		}
+
+		refsItem.addSelectionListener(new SelectionAdapter() {
+			public void widgetSelected(SelectionEvent e) {
+				prefsItem.setImage(referencesIcon);
+				prefsItem
+						.setToolTipText(UIText.ResourceHistory_findbar_changeto_author);
+				prefsItemChanged(PREFS_FINDIN_REFS, refsItem);
+			}
+		});
+		if (selectedPrefsItem == PREFS_FINDIN_REFS) {
+			refsItem.setSelection(true);
+			prefsItem.setImage(referencesIcon);
+			prefsItem
 					.setToolTipText(UIText.ResourceHistory_findbar_changeto_author);
 		}
 
@@ -386,6 +426,7 @@ public class FindToolbar extends Composite {
 		Activator.getDefault().savePluginPreferences();
 		commitIdItem.setSelection(false);
 		commentsItem.setSelection(false);
+		refsItem.setSelection(false);
 		authorItem.setSelection(false);
 		committerItem.setSelection(false);
 		item.setSelection(true);
@@ -399,6 +440,7 @@ public class FindToolbar extends Composite {
 		previousIcon.dispose();
 		commitIdIcon.dispose();
 		commentsIcon.dispose();
+		referencesIcon.dispose();
 		authorIcon.dispose();
 		committerIcon.dispose();
 		super.dispose();
@@ -419,9 +461,18 @@ public class FindToolbar extends Composite {
 	 *
 	 * @param fileRevisions
 	 *            the revision list to be searched
+	 * @param tags
+	 *            a map containing the tags that are being displayed in the
+	 *            history page
+	 * @param branches
+	 *            a map containing the branches that are being displayed in the
+	 *            history page
 	 */
-	public void setFileRevisions(List<IFileRevision> fileRevisions) {
+	public void setFileRevisions(List<IFileRevision> fileRevisions,
+			Map<ObjectId, Tag[]> tags, Map<ObjectId, String[]> branches) {
 		this.fileRevisions = fileRevisions;
+		this.tags = tags;
+		this.branches = branches;
 	}
 
 	void progressUpdate(int percent) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbarThread.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbarThread.java
index 6a6d72c..097b785 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbarThread.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbarThread.java
@@ -17,10 +17,13 @@
 package org.spearce.egit.ui;
 
 import java.util.List;
+import java.util.Map;
 
 import org.eclipse.swt.widgets.Display;
 import org.eclipse.team.core.history.IFileRevision;
 import org.spearce.egit.core.internal.mapping.GitCommitFileRevision;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Tag;
 
 /**
  * This class executes the search function for the find toolbar. Only one thread
@@ -49,6 +52,10 @@ public class FindToolbarThread extends Thread {
 
 	List<IFileRevision> fileRevisions;
 
+	Map<ObjectId, Tag[]> tags;
+
+	Map<ObjectId, String[]> branches;
+
 	FindToolbar toolbar;
 
 	boolean ignoreCase;
@@ -57,6 +64,8 @@ public class FindToolbarThread extends Thread {
 
 	boolean findInComments;
 
+	boolean findInReferences;
+
 	boolean findInAuthor;
 
 	boolean findInCommitter;
@@ -78,15 +87,18 @@ public class FindToolbarThread extends Thread {
 	}
 
 	public void run() {
-		execFind(currentThreadIx, fileRevisions, pattern, toolbar, ignoreCase,
-				findInCommitId, findInComments, findInAuthor, findInCommitter);
+		execFind(currentThreadIx, fileRevisions, tags, branches, pattern,
+				toolbar, ignoreCase, findInCommitId, findInComments,
+				findInReferences, findInAuthor, findInCommitter);
 	}
 
 	private synchronized static void execFind(int threadIx,
-			List<IFileRevision> fileRevisions, final String pattern,
+			List<IFileRevision> fileRevisions, Map<ObjectId, Tag[]> tags,
+			Map<ObjectId, String[]> branches, final String pattern,
 			final FindToolbar toolbar, boolean ignoreCase,
 			boolean findInCommitId, boolean findInComments,
-			boolean findInAuthor, boolean findInCommitter) {
+			boolean findInReferences, boolean findInAuthor,
+			boolean findInCommitter) {
 		// If it isn't the last event, just ignore it.
 		if (threadIx < globalThreadIx) {
 			return;
@@ -161,6 +173,44 @@ public class FindToolbarThread extends Thread {
 						}
 					}
 
+					if (findInReferences && notFound) {
+						Tag[] tagArray = tags.get(revision.getCommitId());
+						if (tagArray != null) {
+							for (Tag tag : tagArray) {
+								String tagName = tag.getTag();
+								if (ignoreCase) {
+									tagName = tagName.toLowerCase();
+								}
+								if (tagName.indexOf(findPattern) != -1) {
+									totalMatches++;
+									findResults.add(i);
+									notFound = false;
+									break;
+								}
+							}
+						}
+						if (notFound) {
+							String[] branchNameArray = branches.get(revision
+									.getCommitId());
+							if (branchNameArray != null) {
+								for (String branchName : branchNameArray) {
+									if (branchName.startsWith("refs/heads/")) {
+										branchName = branchName.substring(11);
+									}
+									if (ignoreCase) {
+										branchName = branchName.toLowerCase();
+									}
+									if (branchName.indexOf(findPattern) != -1) {
+										totalMatches++;
+										findResults.add(i);
+										notFound = false;
+										break;
+									}
+								}
+							}
+						}
+					}
+
 					if (findInAuthor && notFound) {
 						String author = revision.getCommit().getAuthor()
 								.getName();
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
index 5da095b..d0346a9 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/GitHistoryPage.java
@@ -842,7 +842,7 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
 								monitor,
 								isShowAllRepoVersions());
 				fileRevisions = Collections.synchronizedList(fileHistoryFor.getFileRevisionsList());
-				findToolbar.setFileRevisions(fileRevisions);
+				findToolbar.setFileRevisions(fileRevisions, newtags, branches);
 				Display.getDefault().syncExec(new Runnable() {
 					public void run() {
 						if (findToolbar.isDisposed()) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index 33edcec..a04bb5c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -50,6 +50,8 @@ public class UIIcons {
 	public static final ImageDescriptor ELCL16_COMMIT;
 	/** Comments icon */
 	public static final ImageDescriptor ELCL16_COMMENTS;
+	/** References icon */
+	public static final ImageDescriptor ELCL16_REFERENCES;
 	/** Author icon */
 	public static final ImageDescriptor ELCL16_AUTHOR;
 	/** Committer icon */
@@ -69,6 +71,7 @@ public class UIIcons {
 		ELCL16_PREVIOUS = map("elcl16/previous.gif");
 		ELCL16_COMMIT = map("elcl16/commit.gif");
 		ELCL16_COMMENTS = map("elcl16/comment.gif");
+		ELCL16_REFERENCES = map("elcl16/refs.gif");
 		ELCL16_AUTHOR = map("elcl16/author.gif");
 		ELCL16_COMMITTER = map("elcl16/committer.gif");
 	}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 318c12a..87a6b67 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -67,6 +67,8 @@ public class UIText extends NLS {
 	/** */
 	public static String ResourceHistory_findbar_changeto_comments;
 	/** */
+	public static String ResourceHistory_findbar_changeto_refs;
+	/** */
 	public static String ResourceHistory_findbar_changeto_author;
 	/** */
 	public static String ResourceHistory_findbar_changeto_committer;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 7bbca5f..da8e88b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -36,5 +36,6 @@ ResourceHistory_toggleTooltips=Show Revision Tooltip
 
 ResourceHistory_findbar_changeto_commit=Change to Revision
 ResourceHistory_findbar_changeto_comments=Change to Comments
+ResourceHistory_findbar_changeto_refs=Change to References
 ResourceHistory_findbar_changeto_author=Change to Author
 ResourceHistory_findbar_changeto_committer=Change to Committer
-- 
1.5.4.1
