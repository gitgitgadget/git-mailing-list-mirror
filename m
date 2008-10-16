From: drafnel@gmail.com
Subject: [PATCH maint 1/2] t4018-diff-funcname: rework negated last expression test
Date: Wed, 15 Oct 2008 19:58:49 -0500
Message-ID: <13723998.1224118688113.JavaMail.teamon@b307.teamon.com>
References: <7vljwpr6lr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 16 03:17:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqHUP-0007KG-11
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 03:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbYJPBQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 21:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbYJPBQC
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 21:16:02 -0400
Received: from www.teamon.com ([216.34.91.250]:60111 "EHLO b307.teamon.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751004AbYJPBQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 21:16:00 -0400
X-Greylist: delayed 1065 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Oct 2008 21:16:00 EDT
Received: from b307.teamon.com (localhost [127.0.0.1])
	by b307.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m9G0w8525095;
	Thu, 16 Oct 2008 00:58:08 GMT
X-Mailer: git-send-email 1.6.0.2.101.gb844
In-Reply-To: <7vljwpr6lr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98341>

This test used the non-zero exit status of 'git diff' to indicate that a
negated funcname pattern, when placed last, was correctly rejected.

The problem with this is that 'git diff' always returns non-zero if it
finds differences in the files it is comparing, and the files must
contain differences in order to trigger the funcname pattern codepath.

Instead of checking for non-zero exit status, make sure the expected
error message is printed.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


This is not really a series, but I expect you'll apply both, so this
seems easier for both of us.

-brandon


 t/t4018-diff-funcname.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 99fff97..72076ec 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -65,7 +65,8 @@ test_expect_success 'custom pattern' '
 
 test_expect_success 'last regexp must not be negated' '
 	git config diff.java.funcname "!static" &&
-	test_must_fail git diff --no-index Beer.java Beer-correct.java
+	git diff --no-index Beer.java Beer-correct.java 2>&1 |
+	grep "fatal: Last expression must not be negated:"
 '
 
 test_expect_success 'alternation in pattern' '
-- 
1.6.0.2.101.gb844
