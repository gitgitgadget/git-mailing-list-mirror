From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t1300: use test_must_fail as appropriate
Date: Sat,  7 Mar 2009 12:14:04 -0500
Message-ID: <1236446046-18319-2-git-send-email-peff@peff.net>
References: <1236446046-18319-1-git-send-email-peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 18:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg08E-0002bt-V3
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 18:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbZCGROq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 12:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754967AbZCGROq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 12:14:46 -0500
Received: from peff.net ([208.65.91.99]:47630 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754350AbZCGROp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 12:14:45 -0500
Received: (qmail 15959 invoked by uid 107); 7 Mar 2009 17:14:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 12:14:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 12:14:35 -0500
X-Mailer: git-send-email 1.6.2.195.g44251.dirty
In-Reply-To: <1236446046-18319-1-git-send-email-peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112551>

Some of the tests checked the exit code manually, even going
so far as to run git outside of the test_expect harness.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a cleanup I noticed when one of the tests failed for me.

 t/t1300-repo-config.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 11b82f4..3c06842 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -336,10 +336,10 @@ test_expect_success 'get bool variable with empty value' \
 	'git config --bool emptyvalue.variable > output &&
 	 cmp output expect'
 
-git config > output 2>&1
-
-test_expect_success 'no arguments, but no crash' \
-	"test $? = 129 && grep usage output"
+test_expect_success 'no arguments, but no crash' '
+	test_must_fail git config >output 2>&1 &&
+	grep usage output
+'
 
 cat > .git/config << EOF
 [a.b]
@@ -373,7 +373,7 @@ EOF
 test_expect_success 'new variable inserts into proper section' 'cmp .git/config expect'
 
 test_expect_success 'alternative GIT_CONFIG (non-existing file should fail)' \
-	'git config --file non-existing-config -l; test $? != 0'
+	'test_must_fail git config --file non-existing-config -l'
 
 cat > other-config << EOF
 [ein]
-- 
1.6.2.195.g44251.dirty
