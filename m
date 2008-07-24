From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH] t6030 (bisect): work around Mac OS X "ls"
Date: Wed, 23 Jul 2008 20:37:35 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 03:38:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLpn3-0000qp-O1
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 03:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbYGXBhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 21:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbYGXBhk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 21:37:40 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:34676 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbYGXBhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 21:37:39 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6O1bZqu018365;
	Wed, 23 Jul 2008 20:37:36 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6O1bZXG016016;
	Wed, 23 Jul 2008 20:37:35 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89825>

t6030-bisect-porcelain.sh relies on "ls" exiting with nonzero
status when asked to list nonexistent files.  Unfortunately,
/bin/ls on Mac OS X 10.3 exits with exit code 0.  So use "echo
<shell glob pattern>" and grep instead.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
	With this change, all the non-git-svn tests pass on my machine.
	I think the fix is portable but I do not have the experience to
	be sure.  So I would be happier if someone looks it over.

 t/t6030-bisect-porcelain.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 0626544..d19fc1c 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -76,7 +76,7 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 	test_must_fail git bisect start foo $HASH1 -- &&
 	test_must_fail git bisect start $HASH4 $HASH1 bar -- &&
 	test -z "$(git for-each-ref "refs/bisect/*")" &&
-	test_must_fail ls .git/BISECT_* &&
+	echo .git/BISECT_* | test_must_fail grep BISECT_[^*] &&
 	git bisect start &&
 	test_must_fail git bisect good foo $HASH1 &&
 	test_must_fail git bisect good $HASH1 bar &&
-- 
1.5.6.3.549.g8ca11
