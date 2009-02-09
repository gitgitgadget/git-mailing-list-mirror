From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Add the signed-off in the commit text dialog
Date: Mon, 09 Feb 2009 16:17:17 +0100
Message-ID: <499048FD.7050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 16:19:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWXuc-0000pv-LY
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 16:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbZBIPRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 10:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbZBIPRZ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 10:17:25 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:47113 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbZBIPRY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 10:17:24 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1061728fgg.17
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 07:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=+0j2dDVINTB7Gh89PDFg9ECsNWTp3CdhevYmKU+2vnQ=;
        b=iwDyP3uZomlPcd2XE6ttpoCnGcevhUvG9ETvXZyHZW22KNavBj8AJFIINk8s34PJxq
         HqcwE5Okv/3sRdTEf7yrKiTEmAs2RUcAUhrP3BXoDbVXDo5m/cvu6KQkbNuNOUbjQwIY
         Hi4vZsjQ/j9y7C/lZtNa8muF9JNdd5xtjkQwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=IyEkwZZ+uVzB0qsTwYzIKTiaVqwOvlGQnxIUeF1FXfJagtNHOSucSVdYQ2mGcn3/vw
         DpOWigonyWaRLLcT0RtPi07E7Mthp7LOEiQiWvGOeQ1BGHPezd+1r3gJuppvLBbF8gGL
         yl0XNr32DvfptuWDQ/jwjMphebSpEWqMIpwB0=
Received: by 10.86.59.18 with SMTP id h18mr442263fga.5.1234192642491;
        Mon, 09 Feb 2009 07:17:22 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 3sm177060fge.52.2009.02.09.07.17.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Feb 2009 07:17:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109079>

The user can see and edit the signed-off in the commit dialog
before committing.

For new lines in the commit dialog, use Text.DELIMITER for
plateform neutrality.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
This patch only applies after the 2 previous patches.
If you want to, I could probably modify this patch so that it would
apply on the current origin.

 .../egit/ui/internal/actions/CommitAction.java     |   10 +-----
 .../egit/ui/internal/dialogs/CommitDialog.java     |   29 +++++++++++++++++++-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index 97aa60f..6aff07e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -172,7 +172,7 @@ private void performCommit(CommitDialog commitDialog, String commitMessage)
 		}
 
 		try {
-			commitMessage = doCommits(commitDialog, commitMessage, treeMap);
+			doCommits(commitDialog, commitMessage, treeMap);
 		} catch (IOException e) {
 			throw new TeamException("Committing changes", e);
 		}
@@ -181,7 +181,7 @@ private void performCommit(CommitDialog commitDialog, String commitMessage)
 		}
 	}
 
-	private String doCommits(CommitDialog commitDialog, String commitMessage,
+	private void doCommits(CommitDialog commitDialog, String commitMessage,
 			HashMap<Repository, Tree> treeMap) throws IOException, TeamException {
 
 		String author = commitDialog.getAuthor();
@@ -209,11 +209,6 @@ private String doCommits(CommitDialog commitDialog, String commitMessage,
 			}
 			Commit commit = new Commit(repo, parentIds);
 			commit.setTree(tree);
-			commitMessage = commitMessage.replaceAll("\r", "\n");
-			if (commitDialog.isSignedOff())
-				commitMessage += "\n\nSigned-off-by: " + committerIdent.getName() + " <"
-								+ committerIdent.getEmailAddress() + ">";
-
 			commit.setMessage(commitMessage);
 			commit.setAuthor(new PersonIdent(authorIdent, commitDate, timeZone));
 			commit.setCommitter(new PersonIdent(committerIdent, commitDate, timeZone));
@@ -229,7 +224,6 @@ private String doCommits(CommitDialog commitDialog, String commitMessage,
 						+ " to commit " + commit.getCommitId() + ".");
 			}
 		}
-		return commitMessage;
 	}
 
 	private void prepareTrees(IFile[] selectedItems,
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index 9d062cc..8f85c08 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -17,6 +17,7 @@
 import java.util.Collections;
 import java.util.Comparator;
 import java.util.Iterator;
+import java.util.regex.Pattern;
 
 import org.eclipse.core.resources.IFile;
 import org.eclipse.core.resources.IProject;
@@ -67,6 +68,8 @@
  */
 public class CommitDialog extends Dialog {
 
+	private static Pattern signedOffPattern = Pattern.compile("(.|\r|\n)*Signed-off-by: .*(\r|\n)*"); //$NON-NLS-1$
+
 	class CommitContentProvider implements IStructuredContentProvider {
 
 		public void inputChanged(Viewer viewer, Object oldInput, Object newInput) {
@@ -214,6 +217,30 @@ public void widgetDefaultSelected(SelectionEvent arg0) {
 		signedOffButton.setText(UIText.CommitDialog_AddSOB);
 		signedOffButton.setLayoutData(GridDataFactory.fillDefaults().grab(true, false).span(2, 1).create());
 
+		signedOffButton.addSelectionListener(new SelectionListener() {
+			boolean alreadySigned = false;
+			public void widgetSelected(SelectionEvent arg0) {
+				if (alreadySigned)
+					return;
+				if (signedOffButton.getSelection()) {
+					alreadySigned = true;
+					String curText = commitText.getText();
+
+					// add new lines if necessary
+					if (!curText.endsWith(Text.DELIMITER))
+						curText += Text.DELIMITER;
+
+					// if the last line is not a signed off (amend a commit), add a line break
+					if (!signedOffPattern.matcher(new StringBuilder(curText)).matches())
+						curText += Text.DELIMITER;
+					commitText.setText(curText + "Signed-off-by: " + committerText.getText()); //$NON-NLS-1$
+				}
+			}
+
+			public void widgetDefaultSelected(SelectionEvent arg0) {
+				// Empty
+			}
+		});
 		Table resourcesTable = new Table(container, SWT.H_SCROLL | SWT.V_SCROLL
 				| SWT.FULL_SELECTION | SWT.MULTI | SWT.CHECK | SWT.BORDER);
 		resourcesTable.setLayoutData(GridDataFactory.fillDefaults().hint(600,
@@ -330,7 +357,7 @@ private static String getFileStatus(IFile file) {
 	 * @return The message the user entered
 	 */
 	public String getCommitMessage() {
-		return commitMessage;
+		return commitMessage.replaceAll(Text.DELIMITER, "\n"); //$NON-NLS-1$;
 	}
 
 	/**
-- 
1.6.0.4
