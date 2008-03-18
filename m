From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Fix t3200 config
Date: Mon, 17 Mar 2008 22:04:40 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803172204240.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 03:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbRD5-0003zJ-L0
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 03:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbYCRCEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 22:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYCRCEq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 22:04:46 -0400
Received: from iabervon.org ([66.92.72.58]:41024 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbYCRCEp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 22:04:45 -0400
Received: (qmail 16602 invoked by uid 1000); 18 Mar 2008 02:04:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Mar 2008 02:04:40 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77479>

"git-config name = value" doesn't do anything most of the time. The
test meant "git-config name value", but that leaves the configuration
such that later tests will be confused, so move it to the end.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 t/t3200-branch.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 38a90ad..cb5f7a4 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -153,16 +153,6 @@ test_expect_success 'test tracking setup via config' \
      test $(git config branch.my3.remote) = local &&
      test $(git config branch.my3.merge) = refs/heads/master'
 
-test_expect_success 'avoid ambiguous track' '
-	git config branch.autosetupmerge true &&
-	git config remote.ambi1.url = lalala &&
-	git config remote.ambi1.fetch = refs/heads/lalala:refs/heads/master &&
-	git config remote.ambi2.url = lilili &&
-	git config remote.ambi2.fetch = refs/heads/lilili:refs/heads/master &&
-	git branch all1 master &&
-	test -z "$(git config branch.all1.merge)"
-'
-
 test_expect_success 'test overriding tracking setup via --no-track' \
     'git config branch.autosetupmerge true &&
      git config remote.local.url . &&
@@ -224,4 +214,14 @@ test_expect_success \
 	 test -f .git/logs/refs/heads/g/h/i &&
 	 diff expect .git/logs/refs/heads/g/h/i'
 
+test_expect_success 'avoid ambiguous track' '
+	git config branch.autosetupmerge true &&
+	git config remote.ambi1.url lalala &&
+	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
+	git config remote.ambi2.url lilili &&
+	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/master &&
+	git branch all1 master &&
+	test -z "$(git config branch.all1.merge)"
+'
+
 test_done
-- 
1.5.4.3.610.gea6cd
