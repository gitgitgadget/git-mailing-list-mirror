From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 1/2] t3404: Add test case for aborted --continue after "edit"
Date: Thu, 15 Jan 2009 13:56:15 +0100
Message-ID: <1232024176-16600-1-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 13:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNRn9-0004Ra-Kg
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 13:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbZAOM4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 07:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbZAOM4V
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 07:56:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:60124 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752905AbZAOM4U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 07:56:20 -0500
Received: (qmail invoked by alias); 15 Jan 2009 12:56:17 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp064) with SMTP; 15 Jan 2009 13:56:17 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/aRNEhxM3aXC0uBRhygt5Cx4MBy3rThylF+ucSpk
	yphWia2Q4xJ4Lg
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNRlg-0004KE-31; Thu, 15 Jan 2009 13:56:16 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105790>

Add a test case for the bugfix introduced by commit 8beb1f33d
"git-rebase-interactive: do not squash commits on abort".

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/t3404-rebase-interactive.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7d10a27..1182b46 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -373,6 +373,21 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 	test $parent = $(git rev-parse HEAD^)
 '
 
+test_expect_success 'aborted --continue does not squash commits after "edit"' '
+	old=$(git rev-parse HEAD) &&
+	test_tick &&
+	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
+	echo "edited again" > file7 &&
+	git add file7 &&
+	(
+		FAKE_COMMIT_MESSAGE=" " &&
+		export FAKE_COMMIT_MESSAGE &&
+		test_must_fail git rebase --continue
+	) &&
+	test $old = $(git rev-parse HEAD) &&
+	git rebase --abort
+'
+
 test_expect_success 'rebase a detached HEAD' '
 	grandparent=$(git rev-parse HEAD~2) &&
 	git checkout $(git rev-parse HEAD) &&
-- 
1.6.1.160.gecdb
