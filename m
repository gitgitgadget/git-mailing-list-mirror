From: drafnel@gmail.com
Subject: [PATCH maint 2/2] t4018-diff-funcname: demonstrate end of line funcname matching flaw
Date: Wed, 15 Oct 2008 19:58:50 -0500
Message-ID: <6078773.1224118690194.JavaMail.teamon@b307.teamon.com>
References: <7vljwpr6lr.fsf@gitster.siamese.dyndns.org>
 <1224118730-24711-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 16 03:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqHUO-0007KG-8F
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 03:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYJPBQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 21:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbYJPBQA
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 21:16:00 -0400
Received: from www.teamon.com ([216.34.91.250]:60111 "EHLO b307.teamon.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750973AbYJPBQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 21:16:00 -0400
X-Greylist: delayed 1065 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Oct 2008 21:16:00 EDT
Received: from b307.teamon.com (localhost [127.0.0.1])
	by b307.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m9G0wA525127;
	Thu, 16 Oct 2008 00:58:10 GMT
X-Mailer: git-send-email 1.6.0.2.101.gb844
In-Reply-To: <1224118730-24711-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98342>

Since the newline is not removed from lines before pattern matching, a
pattern cannot match to the end of the line using the '$' operator without
using an additional operator which will indirectly match the '\n' character.

Introduce a test which should pass, but which does not due to this flaw.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t4018-diff-funcname.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 72076ec..40a805a 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -69,6 +69,12 @@ test_expect_success 'last regexp must not be negated' '
 	grep "fatal: Last expression must not be negated:"
 '
 
+test_expect_failure 'pattern which matches to end of line' '
+	git config diff.java.funcname "Beer$" &&
+	git diff --no-index Beer.java Beer-correct.java |
+	grep "^@@.*@@ Beer"
+'
+
 test_expect_success 'alternation in pattern' '
 	git config diff.java.xfuncname "^[ 	]*((public|static).*)$" &&
 	git diff --no-index Beer.java Beer-correct.java |
-- 
1.6.0.2.101.gb844
