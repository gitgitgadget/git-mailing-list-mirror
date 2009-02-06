From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Propose author and committer in the commit dialog
Date: Fri, 06 Feb 2009 13:24:05 +0100
Message-ID: <498C2BE5.3010602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 13:25:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVPm7-0003Rk-Tq
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 13:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbZBFMYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 07:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbZBFMYM
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 07:24:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:9448 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbZBFMYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 07:24:09 -0500
Received: by fg-out-1718.google.com with SMTP id 16so480614fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 04:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=6vEIXqn7t26HG/H3H19sstbPtu+aV4Bzhw96CEJV8S4=;
        b=rQLkisFE6zFnO/wAwSvvHlk3biB7dTgQcoUEWfCeiwFoyMCkovAWe46I4mECjBJsRH
         MZ0SzieATG5t8uSgqmZO3KYIX1SMpT55XsSryXeR8wV7F9m+VCoHJ7maPb+UzRx5+wUG
         B7oJ0vF3R/urWqSwPdWu/MutZOsNPX9OZVF4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=IG2v2X864nqeT89s3prHJ3zjKWLi9lg7FFeGpcR2e591JNlmvpJhD4i9zjl4PnVr0U
         SvCZfvKAL2t9vcyjQPH+WjIZXHUEBeaioqbuSg20bPTO9SDa+/UXODQQVgjGBa1RDRnx
         i+QCuK7wZCi8KRJXqJpoMSCgsicNadINs5/fw=
Received: by 10.86.91.3 with SMTP id o3mr925355fgb.35.1233923046836;
        Fri, 06 Feb 2009 04:24:06 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id d6sm3017904fga.49.2009.02.06.04.24.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 04:24:06 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108692>

Add a field 'committer'.
The fields 'author' and 'committer' are populated with the values
found in the configuration.

Validate the author and the committer.

Add the signed-off line in the comment text box when the user clicks
on the signed-off checkbox.

Use Text.DELIMITER as line break for plateform independance.

A default PersonIdent is an author and gets the values from the
configuration.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    6 +
 .../egit/ui/internal/actions/CommitAction.java     |   55 +++++------
 .../egit/ui/internal/dialogs/CommitDialog.java     |   97 +++++++++++++++++++-
 .../src/org/spearce/egit/ui/uitext.properties      |    2 +
 .../src/org/spearce/jgit/lib/PersonIdent.java      |   20 +----
 5 files changed, 128 insertions(+), 52 deletions(-)

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
index ae26770..9a9d494 100644
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
+			final String committerEmail = config.getAuthorEmail();
+			committer = committer + " <" + committerEmail + ">";
 		}
 
 		loadPreviousCommit();
@@ -117,9 +118,13 @@ public void run(IAction act) {
 		commitDialog.setAmendAllowed(amendAllowed);
 		commitDialog.setFileList(files);
 		commitDialog.setAuthor(author);
+		commitDialog.setCommitter(committer);
 
-		if (previousCommit != null)
+		if (previousCommit != null) {
 			commitDialog.setPreviousCommitMessage(previousCommit.getMessage());
+			PersonIdent previousAuthor = previousCommit.getAuthor();
+			commitDialog.setPreviousAuthor(previousAuthor.getName() + " <" + previousAuthor.getEmailAddress() + ">");
+		}
 
 		if (commitDialog.open() != IDialogConstants.OK_ID)
 			return;
@@ -167,7 +172,7 @@ private void performCommit(CommitDialog commitDialog, String commitMessage)
 		}
 
 		try {
-			commitMessage = doCommits(commitDialog, commitMessage, treeMap);
+			doCommits(commitDialog, commitMessage, treeMap);
 		} catch (IOException e) {
 			throw new TeamException("Committing changes", e);
 		}
@@ -176,8 +181,17 @@ private void performCommit(CommitDialog commitDialog, String commitMessage)
 		}
 	}
 
-	private String doCommits(CommitDialog commitDialog, String commitMessage,
+	private void doCommits(CommitDialog commitDialog, String commitMessage,
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
@@ -195,27 +209,9 @@ private String doCommits(CommitDialog commitDialog, String commitMessage,
 			}
 			Commit commit = new Commit(repo, parentIds);
 			commit.setTree(tree);
-			commitMessage = commitMessage.replaceAll("\r", "\n");
-
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
@@ -228,7 +224,6 @@ private String doCommits(CommitDialog commitDialog, String commitMessage,
 						+ " to commit " + commit.getCommitId() + ".");
 			}
 		}
-		return commitMessage;
 	}
 
 	private void prepareTrees(IFile[] selectedItems,
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index fede948..6b6cb55 100644
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
@@ -129,6 +132,7 @@ createButton(parent, IDialogConstants.CANCEL_ID,
 
 	Text commitText;
 	Text authorText;
+	Text committerText;
 	Button amendingButton;
 	Button signedOffButton;
 
@@ -170,11 +174,18 @@ public void keyPressed(KeyEvent arg0) {
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
 			amendingButton.setEnabled(false); // if already set, don't allow any changes
 			commitText.setText(previousCommitMessage);
+			authorText.setText(previousAuthor);
 		} else if (!amendAllowed) {
 			amendingButton.setEnabled(false);
 		}
@@ -187,8 +198,9 @@ public void widgetSelected(SelectionEvent arg0) {
 					alreadyAdded = true;
 					String curText = commitText.getText();
 					if (curText.length() > 0)
-						curText += "\n"; //$NON-NLS-1$
+						curText += Text.DELIMITER;
 					commitText.setText(curText + previousCommitMessage);
+					authorText.setText(previousAuthor);
 				}
 			}
 
@@ -205,6 +217,33 @@ public void widgetDefaultSelected(SelectionEvent arg0) {
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
+					if (!curText.endsWith(Text.DELIMITER)) {
+						curText += Text.DELIMITER;
+					}
+
+					if (!signedOffPattern.matcher(new StringBuilder(curText)).matches()) {
+						// if the last line is not a signed off (amend a commit), add a line break
+						curText += Text.DELIMITER;
+					}
+					commitText.setText(curText + "Signed-off-by: " + committerText.getText()); //$NON-NLS-1$
+				}
+			}
+
+			public void widgetDefaultSelected(SelectionEvent arg0) {
+				// Empty
+			}
+		});
+
 		Table resourcesTable = new Table(container, SWT.H_SCROLL | SWT.V_SCROLL
 				| SWT.FULL_SELECTION | SWT.MULTI | SWT.CHECK | SWT.BORDER);
 		resourcesTable.setLayoutData(GridDataFactory.fillDefaults().hint(600,
@@ -237,6 +276,7 @@ private Menu getContextMenu() {
 		MenuItem item = new MenuItem(menu, SWT.PUSH);
 		item.setText(UIText.CommitDialog_AddFileOnDiskToIndex);
 		item.addListener(SWT.Selection, new Listener() {
+			@SuppressWarnings("unchecked")
 			public void handleEvent(Event arg0) {
 				IStructuredSelection sel = (IStructuredSelection) filesViewer.getSelection();
 				if (sel.isEmpty()) {
@@ -312,6 +352,7 @@ private static String getFileStatus(IFile file) {
 			}
 
 		} catch (Exception e) {
+			e.printStackTrace();
 		}
 
 		return prefix;
@@ -321,6 +362,7 @@ private static String getFileStatus(IFile file) {
 	 * @return The message the user entered
 	 */
 	public String getCommitMessage() {
+		commitMessage.replaceAll(Text.DELIMITER, "\n"); //$NON-NLS-1$
 		return commitMessage;
 	}
 
@@ -334,6 +376,8 @@ public void setCommitMessage(String s) {
 
 	private String commitMessage = ""; //$NON-NLS-1$
 	private String author = null;
+	private String committer = null;
+	private String previousAuthor = null;
 	private boolean signedOff = false;
 	private boolean amending = false;
 	private boolean amendAllowed = true;
@@ -397,6 +441,7 @@ public void widgetSelected(SelectionEvent e) {
 	protected void okPressed() {
 		commitMessage = commitText.getText();
 		author = authorText.getText().trim();
+		committer = committerText.getText().trim();
 		signedOff = signedOffButton.getSelection();
 		amending = amendingButton.getSelection();
 
@@ -410,14 +455,33 @@ protected void okPressed() {
 			return;
 		}
 
+		boolean authorValid = false;
 		if (author.length() > 0) {
 			try {
 				new PersonIdent(author);
+				authorValid = true;
 			} catch (IllegalArgumentException e) {
-				MessageDialog.openWarning(getShell(), UIText.CommitDialog_ErrorInvalidAuthor, UIText.CommitDialog_ErrorInvalidAuthorSpecified);
-				return;
+				authorValid = false;
 			}
-		} else author = null;
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
+			} catch (IllegalArgumentException e) {
+				committerValid = false;
+			}
+		}
+		if (!committerValid) {
+			MessageDialog.openWarning(getShell(), UIText.CommitDialog_ErrorInvalidAuthor, UIText.CommitDialog_ErrorInvalidCommitterSpecified);
+			return;
+		}
 
 		if (selectedFiles.isEmpty() && !amending) {
 			MessageDialog.openWarning(getShell(), UIText.CommitDialog_ErrorNoItemsSelected, UIText.CommitDialog_ErrorNoItemsSelectedToBeCommitted);
@@ -470,6 +534,31 @@ public void setAuthor(String author) {
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
+	 * Pre-set the previous author if amending the commit
+	 *
+	 * @param previousAuthor
+	 */
+	public void setPreviousAuthor(String previousAuthor) {
+		this.previousAuthor = previousAuthor;
+	}
+
+	/**
 	 * @return whether to auto-add a signed-off line to the message
 	 */
 	public boolean isSignedOff() {
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
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
index bc5479a..8438683 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
@@ -57,16 +57,6 @@
 
 	private final int tzOffset;
 
-	private static String getHostName() {
-		try {
-			java.net.InetAddress addr = java.net.InetAddress.getLocalHost();
-			String hostname = addr.getCanonicalHostName();
-			return hostname;
-		} catch (java.net.UnknownHostException e) {
-			return "localhost";
-		}
-	}
-
 	/**
 	 * Creates new PersonIdent from config info in repository, with current time
 	 * 
@@ -74,14 +64,8 @@ private static String getHostName() {
 	 */
 	public PersonIdent(final Repository repo) {
 		RepositoryConfig config = repo.getConfig();
-		String username = config.getString("user", null, "name");
-		if (username == null)
-			username = System.getProperty("user.name");
-
-		String email = config.getString("user", null, "email");
-		if (email == null)
-			email = System.getProperty("user.name") + "@" + getHostName();
-
+		String username = config.getAuthorName();
+		String email = config.getAuthorEmail();
 		name = username;
 		emailAddress = email;
 		when = System.currentTimeMillis();
-- 
1.6.0.4
