X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Adjust t5510 to put remotes in config
Date: Sun, 17 Dec 2006 15:46:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612171545390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 17 Dec 2006 14:46:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34691>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvxHI-0003en-1a for gcvg-git@gmane.org; Sun, 17 Dec
 2006 15:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752731AbWLQOqH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 09:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbWLQOqH
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 09:46:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:33184 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1752731AbWLQOqG
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 09:46:06 -0500
Received: (qmail invoked by alias); 17 Dec 2006 14:46:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp043) with SMTP; 17 Dec 2006 15:46:02 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


Since .git/remotes/ is no longer created by default, t5510 failed.
While at it, convert the tests to use the config way of specifying
remotes instead of creating a file in .git/remotes/.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/t5510-fetch.sh |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a11ab0a..6229433 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -23,20 +23,16 @@ test_expect_success "clone and setup child repos" '
 	git clone . two &&
 	cd two &&
 	git repo-config branch.master.remote one &&
-	{
-		echo "URL: ../one/.git/"
-		echo "Pull: refs/heads/master:refs/heads/one"
-	} >.git/remotes/one
+	git repo-config remote.one.url ../one/.git/ &&
+	git repo-config remote.one.fetch refs/heads/master:refs/heads/one &&
 	cd .. &&
 	git clone . three &&
 	cd three &&
 	git repo-config branch.master.remote two &&
 	git repo-config branch.master.merge refs/heads/one &&
-	{
-		echo "URL: ../two/.git/"
-		echo "Pull: refs/heads/master:refs/heads/two"
-		echo "Pull: refs/heads/one:refs/heads/one"
-	} >.git/remotes/two
+	git repo-config remote.two.url ../two/.git/ &&
+	git repo-config remote.two.fetch refs/heads/master:refs/heads/two &&
+	git repo-config --add remote.two.fetch refs/heads/one:refs/heads/one
 '
 
 test_expect_success "fetch test" '
-- 
1.4.4.2.ga4be2-dirty
