From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix t1410 for core.filemode==false
Date: Wed, 10 Jan 2007 13:22:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701101322310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jan 10 13:22:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4cTn-0004Wu-4R
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 13:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbXAJMWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 07:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932797AbXAJMWw
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 07:22:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:41941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932792AbXAJMWw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 07:22:52 -0500
Received: (qmail invoked by alias); 10 Jan 2007 12:22:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 10 Jan 2007 13:22:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36504>


Since c869753e, core.filemode is hardwired to false on Cygwin.
So this test had no chance to succeed, since an early commit
(changing just the filemode) failed, and therefore all subsequent
tests.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/t1410-reflog.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 738d151..8e8d526 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -71,6 +71,8 @@ test_expect_success setup '
 	check_fsck &&
 
 	chmod +x C &&
+	( test "`git repo-config --bool core.filemode`" != false ||
+	  echo executable >>C ) &&
 	git add C &&
 	test_tick && git commit -m dragon &&
 	L=`git rev-parse --verify HEAD` &&
-- 
1.4.4.4.g774d-dirty
