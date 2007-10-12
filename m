From: Steffen Prohaska <prohaska@zib.de>
Subject: push fails with unexpected 'matches more than one'
Date: Fri, 12 Oct 2007 08:59:39 +0200
Message-ID: <11921723791817-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 09:00:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgEUy-0006y7-9l
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 08:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbXJLG7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 02:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXJLG7m
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 02:59:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:41597 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757583AbXJLG7l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 02:59:41 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9C6xd7w012050
	for <git@vger.kernel.org>; Fri, 12 Oct 2007 08:59:39 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9C6xdOM020538;
	Fri, 12 Oct 2007 08:59:39 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60659>

This adds a test case for unambigous local match but multiple remote
matches. To me, it is unexpected that a ref that is perfectly defined
on the local side fails with 'matches more than one'.

The following rule could solve this:
A ref shall first be unambigously resolved on the local side, and its
full name should be used for matching on the remote side.
For example 'frotz' resolves locally to 'heads/refs/frotz'.
Therefore pretend the user had typed 'heads/refs/frotz'.

But maybe there is some hidden secret about the current rules that
I do not see.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t5516-fetch-push.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ca46aaf..f249216 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -244,4 +244,12 @@ test_expect_success 'push with colon-less refspec (4)' '
 
 '
 
+test_expect_success 'push with colon-less refspec (locally unambigous)' '
+
+	mk_test heads/frotz heads/t/frotz &&
+	git branch -f frotz master &&
+	git push testrepo frotz
+
+'
+
 test_done
-- 
1.5.3.4.219.gd0b2
