From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] t3501: check that commits are actually done
Date: Thu, 15 Jan 2009 14:03:17 +0100
Message-ID: <1232024597-16728-1-git-send-email-s-beyer@gmx.net>
Cc: gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 14:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNRtw-0006tb-4X
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbZAONDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbZAONDW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:03:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:53948 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753213AbZAONDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:03:21 -0500
Received: (qmail invoked by alias); 15 Jan 2009 13:03:19 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp028) with SMTP; 15 Jan 2009 14:03:19 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18fcCFwIuAfLMhCgHKwwM8uHJS8c3kOOOb3xMlDQg
	Wry8i/brHfLzYb
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNRsT-0004MH-Fp; Thu, 15 Jan 2009 14:03:17 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105791>

The basic idea of t3501 is to check whether revert
and cherry-pick works on renamed files.
But as there is no pure cherry-pick/revert test, it is
good to also check if commits are actually done in that
scenario.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

	This patch was originally motivated because of a bug that
	I introduced in my repo while hacking on cherry-pick/revert.
	None of the cherry-pick test cases failed, so I thought
	this tiny addition is useful.

 t/t3501-revert-cherry-pick.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 6da2128..bb4cf00 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -45,6 +45,7 @@ test_expect_success 'cherry-pick after renaming branch' '
 
 	git checkout rename2 &&
 	git cherry-pick added &&
+	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
 	test -f opos &&
 	grep "Add extra line at the end" opos
 
@@ -54,6 +55,7 @@ test_expect_success 'revert after renaming branch' '
 
 	git checkout rename1 &&
 	git revert added &&
+	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
 	test -f spoo &&
 	! grep "Add extra line at the end" spoo
 
-- 
1.6.1.160.gecdb
