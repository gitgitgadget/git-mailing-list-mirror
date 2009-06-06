From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit 2/4] Correctly count the entries in the revs context menu
Date: Sat,  6 Jun 2009 13:57:49 +0200
Message-ID: <1244289471-698-3-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 13:59:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCuXy-0007Qq-N9
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 13:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbZFFL6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 07:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbZFFL6U
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 07:58:20 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59868 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbZFFL6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 07:58:18 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 0275E1049D47B;
	Sat,  6 Jun 2009 13:58:20 +0200 (CEST)
Received: from [89.59.108.98] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MCuXT-0006b6-01; Sat, 06 Jun 2009 13:58:19 +0200
X-Mailer: git-send-email 1.6.3.2.213.g30b07
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19uZwTygwbC8fJHlEzt+V6KCzHjWmbcK4XmRhos
	kENXhak0DvoDxPrIpZGqIL+bJ2l4lWWOil0HHboPQWHoueJXO6
	V1YuDY3ib+KO/JMGKxlQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120913>

The previous implementation counted all the QAction entries. A separator
is of type QAction, but shouldn't be considered when calculating the
menu size.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/mainimpl.cpp |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index 60414ab..24b4ef1 100644
--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -1124,6 +1124,17 @@ void MainImpl::doUpdateRecentRepoMenu(SCRef newEntry) {
 	settings.setValue(REC_REP_KEY, newRecents);
 }
 
+static int cntMenuEntries(const QMenu& menu) {
+
+	int cnt = 0;
+	QList<QAction*> al(menu.actions());
+	FOREACH (QList<QAction*>, it, al) {
+		if (!(*it)->isSeparator())
+			cnt++;
+	}
+	return cnt;
+}
+
 void MainImpl::doContexPopup(SCRef sha) {
 
 	QMenu contextMenu(this);
@@ -1186,7 +1197,7 @@ void MainImpl::doContexPopup(SCRef sha) {
 			contextMenu.addSeparator();
 
 		FOREACH_SL (it, bn) {
-			if (contextMenu.actions().count() < MAX_MENU_ENTRIES)
+			if (cntMenuEntries(contextMenu) < MAX_MENU_ENTRIES)
 				act = contextMenu.addAction(*it);
 			else
 				act = contextSubMenu.addAction(*it);
@@ -1200,7 +1211,7 @@ void MainImpl::doContexPopup(SCRef sha) {
 				contextMenu.addSeparator();
 
 		FOREACH_SL (it, tn) {
-			if (contextMenu.actions().count() < MAX_MENU_ENTRIES)
+			if (cntMenuEntries(contextMenu) < MAX_MENU_ENTRIES)
 				act = contextMenu.addAction(*it);
 			else
 				act = contextSubMenu.addAction(*it);
-- 
1.6.3.2.213.g30b07
