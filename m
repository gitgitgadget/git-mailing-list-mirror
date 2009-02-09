From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Propose author and committer in the commit dialog
Date: Mon, 09 Feb 2009 14:51:11 +0100
Message-ID: <499034CF.5010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 14:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWWZ3-0004J8-81
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 14:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbZBINvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 08:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbZBINvR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 08:51:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:29907 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbZBINvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 08:51:16 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1045717fgg.17
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 05:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=iS9h1+wVVjXKfATcbG/Nr8j2fdAtGprT4st5KjN7Jx4=;
        b=K0C83I1+0hM43VCnhr4HE/ArnqDbKmHIeqtmc4nkUu4Tdr79h6HqhUXb9zWUdwYxG5
         gIWtlCWtxR94X1EvhSj6GDNgdjS0C2mcUPhL6fgJrsqjt6D/yH0RLsVGsdR+ReoiBiyZ
         xDrXJe27OrgypKpi2tqclTeVKHUJKVrRMJSRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=cO0mY+pQyY91VAA9nN/CVSM6RBJ5opfPJqNmsTJ8OSrfua/RH+lh+QCD2M4c4+I2Cu
         sn/UWa052vpcGIX3PF1O8U30W1qGN7nYnS3x95vXiOouz+uJTfdYCD+aeiTqpWkXSPcT
         d1o2eE6SQvDZCTdOheXQGzoxNy1099yH62wqc=
Received: by 10.86.86.12 with SMTP id j12mr1422257fgb.1.1234187474063;
        Mon, 09 Feb 2009 05:51:14 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id l19sm746173fgb.27.2009.02.09.05.51.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Feb 2009 05:51:13 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109071>

Add a field 'committer'.
The fields 'author' and 'committer' are populated with the values
found in the configuration.

The author and the committer are validated against empty values
before accepting the commit.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
I reduced the number of changes for better reviewing.

 .../src/org/spearce/egit/ui/UIText.java            |    6 ++
 .../egit/ui/internal/actions/CommitAction.java     |   46 +++++++++---------
 .../egit/ui/internal/dialogs/CommitDialog.java     |   50 ++++++++++++++++++-
 .../src/org/spearce/egit/ui/uitext.properties      |    2 +
 4 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index d74f53e..249f2a0 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -584,6 +584,9 @@
 	public static String CommitDialog_CommitChanges;
 
 	/** */
+	public static String CommitDialog_Committer;
+
+	/** */
 	public static String CommitDialog_CommitMessage;
 
 	/** */
@@ -596,6 +599,9 @@
 	public static String CommitDialog_ErrorInvalidAuthorSpecified;
 
 	/** */
+	public static String CommitDialog_ErrorInvalidCommitterSpecified;
+
+	/** */
 	public static String CommitDialog_ErrorMustEnterCommitMessage;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index d30172f..97aa60f 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -99,15 +99,16 @@ public void run(IAction act) {
 		}
 
 		String author = null;
+		String committer = null;
 		if (repository != null) {
 			final RepositoryConfig config = repository.getConfig();
 			author = config.getAuthorName();
-			if (author != null && author.length() != 0) {
-				final String email = config.getAuthorEmail();
-				if (email != null && email.length() != 0) {
-					author = author + " <" + email + ">";
-				}
-			}
+			final String authorEmail = config.getAuthorEmail();
+			author = author + " <" + authorEmail + ">";
+
+			committer = config.getCommitterName();
+			final String committerEmail = config.getCommitterEmail();
+			committer = committer + " <" + committerEmail + ">";
 		}
 
 		loadPreviousCommit();
@@ -117,6 +118,7 @@ public void run(IAction act) {
 		commitDialog.setAmendAllowed(amendAllowed);
 		commitDialog.setFileList(files);
 		commitDialog.setAuthor(author);
+		commitDialog.setCommitter(committer);
 
 		if (previousCommit != null) {
 			commitDialog.setPreviousCommitMessage(previousCommit.getMessage());
@@ -181,6 +183,15 @@ private void performCommit(CommitDialog commitDialog, String commitMessage)
 
 	private String doCommits(CommitDialog commitDialog, String commitMessage,
 			HashMap<Repository, Tree> treeMap) throws IOException, TeamException {
+
+		String author = commitDialog.getAuthor();
+		String committer = commitDialog.getCommitter();
+		Date commitDate = new Date(Calendar.getInstance().getTimeInMillis());
+		TimeZone timeZone = TimeZone.getDefault();
+
+		PersonIdent authorIdent = new PersonIdent(author);
+		PersonIdent committerIdent = new PersonIdent(committer);
+
 		for (java.util.Map.Entry<Repository, Tree> entry : treeMap.entrySet()) {
 			Tree tree = entry.getValue();
 			Repository repo = tree.getRepository();
@@ -199,26 +210,13 @@ private String doCommits(CommitDialog commitDialog, String commitMessage,
 			Commit commit = new Commit(repo, parentIds);
 			commit.setTree(tree);
 			commitMessage = commitMessage.replaceAll("\r", "\n");
+			if (commitDialog.isSignedOff())
+				commitMessage += "\n\nSigned-off-by: " + committerIdent.getName() + " <"
+								+ committerIdent.getEmailAddress() + ">";
 
-			PersonIdent personIdent = new PersonIdent(repo);
-			String username = personIdent.getName();
-			String email = personIdent.getEmailAddress();
-
-			if (commitDialog.isSignedOff()) {
-				commitMessage += "\n\nSigned-off-by: " + username + " <"
-						+ email + ">";
-			}
 			commit.setMessage(commitMessage);
-
-			if (commitDialog.getAuthor() == null) {
-				commit.setAuthor(personIdent);
-			} else {
-				PersonIdent author = new PersonIdent(commitDialog.getAuthor());
-				commit.setAuthor(new PersonIdent(author, new Date(Calendar
-						.getInstance().getTimeInMillis()), TimeZone
-						.getDefault()));
-			}
-			commit.setCommitter(personIdent);
+			commit.setAuthor(new PersonIdent(authorIdent, commitDate, timeZone));
+			commit.setCommitter(new PersonIdent(committerIdent, commitDate, timeZone));
 
 			ObjectWriter writer = new ObjectWriter(repo);
 			commit.setCommitId(writer.writeCommit(commit));
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index b122fb8..9d062cc 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -129,6 +129,7 @@ createButton(parent, IDialogConstants.CANCEL_ID,
 
 	Text commitText;
 	Text authorText;
+	Text committerText;
 	Button amendingButton;
 	Button signedOffButton;
 
@@ -170,6 +171,12 @@ public void keyPressed(KeyEvent arg0) {
 		if (author != null)
 			authorText.setText(author);
 
+		new Label(container, SWT.LEFT).setText(UIText.CommitDialog_Committer);
+		committerText = new Text(container, SWT.BORDER);
+		committerText.setLayoutData(GridDataFactory.fillDefaults().grab(true, false).create());
+		if (committer != null)
+			committerText.setText(committer);
+
 		amendingButton = new Button(container, SWT.CHECK);
 		if (amending) {
 			amendingButton.setSelection(amending);
@@ -336,6 +343,7 @@ public void setCommitMessage(String s) {
 
 	private String commitMessage = ""; //$NON-NLS-1$
 	private String author = null;
+	private String committer = null;
 	private String previousAuthor = null;
 	private boolean signedOff = false;
 	private boolean amending = false;
@@ -400,6 +408,7 @@ public void widgetSelected(SelectionEvent e) {
 	protected void okPressed() {
 		commitMessage = commitText.getText();
 		author = authorText.getText().trim();
+		committer = committerText.getText().trim();
 		signedOff = signedOffButton.getSelection();
 		amending = amendingButton.getSelection();
 
@@ -413,14 +422,33 @@ protected void okPressed() {
 			return;
 		}
 
+		boolean authorValid = false;
 		if (author.length() > 0) {
 			try {
 				new PersonIdent(author);
+				authorValid = true;
+			} catch (IllegalArgumentException e) {
+				authorValid = false;
+			}
+		}
+		if (!authorValid) {
+			MessageDialog.openWarning(getShell(), UIText.CommitDialog_ErrorInvalidAuthor, UIText.CommitDialog_ErrorInvalidAuthorSpecified);
+			return;
+		}
+
+		boolean committerValid = false;
+		if (committer.length() > 0) {
+			try {
+				new PersonIdent(committer);
+				committerValid = true;
 			} catch (IllegalArgumentException e) {
-				MessageDialog.openWarning(getShell(), UIText.CommitDialog_ErrorInvalidAuthor, UIText.CommitDialog_ErrorInvalidAuthorSpecified);
-				return;
+				committerValid = false;
 			}
-		} else author = null;
+		}
+		if (!committerValid) {
+			MessageDialog.openWarning(getShell(), UIText.CommitDialog_ErrorInvalidAuthor, UIText.CommitDialog_ErrorInvalidCommitterSpecified);
+			return;
+		}
 
 		if (selectedFiles.isEmpty() && !amending) {
 			MessageDialog.openWarning(getShell(), UIText.CommitDialog_ErrorNoItemsSelected, UIText.CommitDialog_ErrorNoItemsSelectedToBeCommitted);
@@ -473,6 +501,22 @@ public void setAuthor(String author) {
 	}
 
 	/**
+	 * @return The committer to set for the commit
+	 */
+	public String getCommitter() {
+		return committer;
+	}
+
+	/**
+	 * Pre-set committer for the commit
+	 *
+	 * @param committer
+	 */
+	public void setCommitter(String committer) {
+		this.committer = committer;
+	}
+
+	/**
 	 * Pre-set the previous author if amending the commit
 	 *
 	 * @param previousAuthor
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 52fa4f8..142b426 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -226,10 +226,12 @@ CommitDialog_AmendPreviousCommit=A&mend previous commit
 CommitDialog_Author=&Author:
 CommitDialog_Commit=&Commit
 CommitDialog_CommitChanges=Commit Changes
+CommitDialog_Committer=Committer:
 CommitDialog_CommitMessage=Commit &Message:
 CommitDialog_DeselectAll=&Deselect All
 CommitDialog_ErrorInvalidAuthor=Invalid author
 CommitDialog_ErrorInvalidAuthorSpecified=Invalid author specified. Please use the form:\nA U Thor <author@example.com>
+CommitDialog_ErrorInvalidCommitterSpecified=Invalid committer specified. Please use the form:\nCommi T Ter <committer@example.com>
 CommitDialog_ErrorMustEnterCommitMessage=You must enter a commit message
 CommitDialog_ErrorNoItemsSelected=No items selected
 CommitDialog_ErrorNoItemsSelectedToBeCommitted=No items are currently selected to be committed.
-- 
1.6.0.4
