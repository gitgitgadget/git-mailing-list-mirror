From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Sat, 13 Jun 2009 01:29:17 +0200
Message-ID: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:29:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFGBc-00029v-AH
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbZFLX3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 19:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbZFLX3T
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:29:19 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40898 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbZFLX3S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 19:29:18 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4149C1055CA70;
	Sat, 13 Jun 2009 01:29:20 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MFGBU-0006vd-00; Sat, 13 Jun 2009 01:29:20 +0200
X-Mailer: git-send-email 1.6.3.2.248.g8cb59
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19nJWeyJj7geo9r6h5zff4u50P+9cR2kwCI71Jp
	gjm3gQMa/yHJLjPuCdeFL4n6FNs6o9MtytJjZsP2qIpScIA9bo
	9FUrLjUc/Vq0FbBzGiUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121471>

Creating a patch series didn't work, because the SHA1 list was
interpreted in the wrong order.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

To find out if this problem was caused by a regression, I tested
2e63608 (Format patch: use selected patches as a range, 2008-01-13),
which changed the behavior of generating multiple patches and introduced
the lines that are now changed in my patch.

But that commit didn't work for me either. Now I don't think that it
didn't work for you at that time. Can this be a Qt problem?

 src/git.cpp |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/git.cpp b/src/git.cpp
index a20bf0d..0f18f61 100644
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -1577,9 +1577,9 @@ bool Git::formatPatch(SCList shaList, SCRef dirPath, SCRef remoteDir) {
 	if (remote)
 		workDir = remoteDir; // run() uses workDir value
 
-	// shaList is ordered by newest to oldest
-	runCmd.append(" " + shaList.last());
-	runCmd.append(QString::fromLatin1("^..") + shaList.first());
+	// shaList is ordered by oldest to newest
+	runCmd.append(" " + shaList.first());
+	runCmd.append(QString::fromLatin1("^..") + shaList.last());
 	bool ret = run(runCmd);
 	workDir = tmp;
 	return ret;
-- 
1.6.3.2.248.g8cb59
