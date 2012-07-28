From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/2] t1100-*.sh: Fix an intermittent test failure
Date: Sat, 28 Jul 2012 19:48:06 +0100
Message-ID: <501433E6.6060904@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 20:54:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvC9N-0004QO-LV
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 20:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab2G1Sxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 14:53:54 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:48650 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751533Ab2G1Sxx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 14:53:53 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id A81CBA0C080;
	Sat, 28 Jul 2012 19:53:52 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 11F97A0C07F;	Sat, 28 Jul 2012 19:53:52 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sat, 28 Jul 2012 19:53:51 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202452>


In particular, the final test ('flags and then non flags') fails
intermittently, depending on how much time elapsed between the
invocations of "git commit-tree" when creating the commits which
later have their commit id's compared. For example, if the commits
for childid-3 and childid-4 are created 1 or more seconds apart,
then the commits, which would otherwise be identical, will have
different commit id's.

In order to make the test reproducible, we remove the variability
by setting the author and committer times to a well defined state.
We accomplish this with a single call to 'test_tick' at the start
of the test.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t1100-commit-tree-options.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index a3b7723..f8457f9 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -47,6 +47,7 @@ test_expect_success \
 
 
 test_expect_success 'flags and then non flags' '
+	test_tick &&
 	echo comment text |
 	git commit-tree $(cat treeid) >commitid &&
 	echo comment text |
-- 
1.7.11.2
