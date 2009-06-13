From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit] Fix "Save as..." for a file changed in the working dir
Date: Sat, 13 Jun 2009 13:04:04 +0200
Message-ID: <1244891044-10582-2-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 13:04:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFR27-0002Ai-9w
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 13:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762757AbZFMLEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 07:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762598AbZFMLEN
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 07:04:13 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:56122 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762675AbZFMLEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 07:04:10 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id AC904103304FC;
	Sat, 13 Jun 2009 13:04:12 +0200 (CEST)
Received: from [89.59.112.3] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MFR1w-0005Oz-01; Sat, 13 Jun 2009 13:04:12 +0200
X-Mailer: git-send-email 1.6.3.2.248.g8cb59
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+j9LSpSSLuBRAMVp/uQZbpV+8Ub66Fi4Zo4FEV
	dgbxgwI7YN3vkgr8e41CrUP3jDGJNlkvyjYgDvn/iS+22aUuL3
	JApl4BrNsZPs1Jq5ExmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121492>

The second argument of Git::saveFile() is the filename, but the commit
SHA1 has been used, leading to the following error message:

An error occurred while executing command:

cat 0000000000000000000000000000000000000000

Git says:

/bin/cat: 0000000000000000000000000000000000000000: No such file or directory

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

	Is there a difference between rv->st.fileName() and f.filename()?
	They seem to be equal, I chose the former for the function call.

 src/mainimpl.cpp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index bd19ea1..382dc5d 100644
--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -1353,7 +1353,7 @@ void MainImpl::ActSaveFile_activated() {
 
 	QApplication::setOverrideCursor(QCursor(Qt::WaitCursor));
 	QString fileSha(git->getFileSha(rv->st.fileName(), rv->st.sha()));
-	if (!git->saveFile(fileSha, rv->st.sha(), fileName))
+	if (!git->saveFile(fileSha, rv->st.fileName(), fileName))
 		statusBar()->showMessage("Unable to save " + fileName);
 
 	QApplication::restoreOverrideCursor();
-- 
1.6.3.2.248.g8cb59
