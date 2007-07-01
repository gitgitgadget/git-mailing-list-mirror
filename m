From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Fix t5516-fetch for systems where `wc -l` outputs whitespace.
Date: Sun, 1 Jul 2007 11:48:54 -0400
Message-ID: <20070701154854.GA27038@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 01 17:49:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I51fl-0006ld-7K
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 17:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbXGAPtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 11:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbXGAPtJ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 11:49:09 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41054 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbXGAPtI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 11:49:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 0837B1FFC194
	for <git@vger.kernel.org>; Sun,  1 Jul 2007 15:49:07 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51304>

When wc outputs whitespace, the test "$(command | wc -l)" = 1 is
broken because "   1" != "1".  Let the shell eat the whitespace by
using test 1 = $(command | wc -l) instead.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 As per the previous discussion on the list.

 t/t5516-fetch-push.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 08d58e1..c0fa2ba 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -226,7 +226,7 @@ test_expect_success 'push with colon-less refspec (3)' '
 	git branch -f frotz master &&
 	git push testrepo frotz &&
 	check_push_result $the_commit heads/frotz &&
-	test "$( cd testrepo && git show-ref | wc -l )" = 1
+	test 1 = $( cd testrepo && git show-ref | wc -l )
 '
 
 test_expect_success 'push with colon-less refspec (4)' '
@@ -239,7 +239,7 @@ test_expect_success 'push with colon-less refspec (4)' '
 	git tag -f frotz &&
 	git push testrepo frotz &&
 	check_push_result $the_commit tags/frotz &&
-	test "$( cd testrepo && git show-ref | wc -l )" = 1
+	test 1 = $( cd testrepo && git show-ref | wc -l )
 
 '
 
-- 
1.5.2.2.590.gf578-dirty
