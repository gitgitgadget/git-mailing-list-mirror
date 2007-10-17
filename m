From: Yaacov Akiba Slama <ya@slamail.org>
Subject: [QGIT4 PATCH] Add --no-color option to several calls to git
Date: Wed, 17 Oct 2007 19:54:09 +0200
Message-ID: <1192643649-18908-1-git-send-email-ya@slamail.org>
Cc: Marco Costalba <mcostalba@gmail.com>,
	Yaacov Akiba Slama <ya@slamail.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 19:54:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiD6W-0000NR-EM
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 19:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbXJQRyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 13:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758221AbXJQRyV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 13:54:21 -0400
Received: from mail.cyaris.com ([195.140.142.33]:59803 "EHLO c1-033.cyaris.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763765AbXJQRyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 13:54:20 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2007 13:54:19 EDT
Received: from [10.13.33.101] (helo=localhost.localdomain ident=yaslama)
	by c1-033.cyaris.net with esmtpa (Exim 4.50)
	id 1IiD5w-0001oV-72; Wed, 17 Oct 2007 19:54:17 +0200
X-Mailer: git-send-email 1.5.3.4
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Setting "diff.color = true" in the configuration makes the
	output of several git commands use color codes. The color codes aren't parsed
	by qgit, so adds the --no-color" option to the calls of these git commmands.
	[...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61400>

Setting "diff.color = true" in the configuration makes
the output of several git commands use color codes.
The color codes aren't parsed by qgit, so adds the --no-color" option
to the calls of these git commmands.

Signed-off-by: Yaacov Akiba Slama <ya@slamail.org>
---
 src/git.cpp         |   18 +++++++++---------
 src/git_startup.cpp |    6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/git.cpp b/src/git.cpp
index 6cb9c7d..ef7d736 100644
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -776,18 +776,18 @@ MyProcess* Git::getDiff(SCRef sha, QObject* receiver, SCRef diffToSha, bool comb
 
 	QString runCmd;
 	if (sha != ZERO_SHA) {
-		runCmd = "git diff-tree -r --patch-with-stat ";
+		runCmd = "git diff-tree --no-color -r --patch-with-stat ";
 		runCmd.append(combined ? "-c " : "-C -m "); // TODO rename for combined
 		runCmd.append(diffToSha + " " + sha); // diffToSha could be empty
 	} else
-		runCmd = "git diff-index -r -m --patch-with-stat HEAD";
+		runCmd = "git diff-index --no-color -r -m --patch-with-stat HEAD";
 
 	return runAsync(runCmd, receiver);
 }
 
 const QString Git::getWorkDirDiff(SCRef fileName) {
 
-	QString runCmd("git diff-index -r -z -m -p --full-index --no-commit-id HEAD"), runOutput;
+	QString runCmd("git diff-index --no-color -r -z -m -p --full-index --no-commit-id HEAD"), runOutput;
 	if (!fileName.isEmpty())
 		runCmd.append(" -- " + quote(fileName));
 
@@ -998,7 +998,7 @@ bool Git::isSameFiles(SCRef tree1Sha, SCRef tree2Sha) {
 	if (isParentOf(tree2Sha, tree1Sha))
 		return !isTreeModified(tree1Sha);
 
-	const QString runCmd("git diff-tree -r " + tree1Sha + " " + tree2Sha);
+	const QString runCmd("git diff-tree --no-color -r " + tree1Sha + " " + tree2Sha);
 	QString runOutput;
 	if (!run(runCmd, &runOutput))
 		return false;
@@ -1209,7 +1209,7 @@ const RevFile* Git::getAllMergeFiles(const Rev* r) {
 	if (revsFiles.contains(mySha))
 		return revsFiles[mySha];
 
-	QString runCmd("git diff-tree -r -m -C " + r->sha()), runOutput;
+	QString runCmd("git diff-tree --no-color -r -m -C " + r->sha()), runOutput;
 	if (!run(runCmd, &runOutput))
 		return NULL;
 
@@ -1230,7 +1230,7 @@ const RevFile* Git::getFiles(SCRef sha, SCRef diffToSha, bool allFiles, SCRef pa
 
 	if (!diffToSha.isEmpty() && (sha != ZERO_SHA)) {
 
-		QString runCmd("git diff-tree -r -m -C ");
+		QString runCmd("git diff-tree --no-color -r -m -C ");
 		runCmd.append(diffToSha + " " + sha);
 		if (!path.isEmpty())
 			runCmd.append(" " + path);
@@ -1250,7 +1250,7 @@ const RevFile* Git::getFiles(SCRef sha, SCRef diffToSha, bool allFiles, SCRef pa
 		dbs("ASSERT in Git::getFiles, ZERO_SHA not found");
 		return NULL;
 	}
-	QString runCmd("git diff-tree -r -c -C " + sha), runOutput;
+	QString runCmd("git diff-tree --no-color -r -c -C " + sha), runOutput;
 	if (!run(runCmd, &runOutput))
 		return NULL;
 
@@ -1337,7 +1337,7 @@ bool Git::getPatchFilter(SCRef exp, bool isRegExp, ShaSet& shaSet) {
 	if (buf.isEmpty())
 		return true;
 
-	QString runCmd("git diff-tree -r -s --stdin "), runOutput;
+	QString runCmd("git diff-tree --no-color -r -s --stdin "), runOutput;
 	if (isRegExp)
 		runCmd.append("--pickaxe-regex ");
 
@@ -1386,7 +1386,7 @@ bool Git::formatPatch(SCList shaList, SCRef dirPath, SCRef remoteDir) {
 	QSettings settings;
 	const QString FPArgs(settings.value(PATCH_ARGS_KEY).toString());
 
-	QString runCmd("git format-patch");
+	QString runCmd("git format-patch --no-color");
 	if (testFlag(NUMBERS_F) && !remote)
 		runCmd.append(" -n");
 
diff --git a/src/git_startup.cpp b/src/git_startup.cpp
index 95a9474..a281173 100644
--- a/src/git_startup.cpp
+++ b/src/git_startup.cpp
@@ -480,7 +480,7 @@ bool Git::startParseProc(SCList initCmd, FileHistory* fh, SCRef buf) {
 
 bool Git::startRevList(SCList args, FileHistory* fh) {
 
-	const QString baseCmd("git log --log-size --parents --boundary --pretty=raw -z");
+	const QString baseCmd("git log --no-color --log-size --parents --boundary --pretty=raw -z");
 	QStringList initCmd(baseCmd.split(' '));
 	if (!isMainHistory(fh))
 	/*
@@ -505,7 +505,7 @@ bool Git::startUnappliedList() {
 
 	// WARNING: with this command 'git log' could send spurious
 	// revs so we need some filter out logic during loading
-	QStringList cmd(QString("git log --parents --pretty=raw -z ^HEAD").split(' '));
+	QStringList cmd(QString("git log --no-color --parents --pretty=raw -z ^HEAD").split(' '));
 	cmd << unAppliedShaList;
 	return startParseProc(cmd, revData, QString());
 }
@@ -835,7 +835,7 @@ void Git::loadFileNames() {
 	}
 	if (!diffTreeBuf.isEmpty()) {
 		filesLoadingPending = filesLoadingCurSha = "";
-		const QString runCmd("git diff-tree -r -C --stdin");
+		const QString runCmd("git diff-tree --no-color -r -C --stdin");
 		runAsync(runCmd, this, diffTreeBuf);
 	}
 	indexTree();
-- 
1.5.3.4
