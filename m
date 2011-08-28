From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t5540-http-test: shorten grep pattern
Date: Sun, 28 Aug 2011 00:42:00 -0400
Message-ID: <1314506520-17430-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 28 06:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxXCP-00019J-UR
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 06:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800Ab1H1EmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 00:42:06 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60743 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab1H1EmE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 00:42:04 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 590EB1FFC167; Sun, 28 Aug 2011 04:41:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	by silverinsanity.com (Postfix) with ESMTPA id B6D681FFC0EE;
	Sun, 28 Aug 2011 04:41:49 +0000 (UTC)
X-Mailer: git-send-email 1.7.6.671.g4d09b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180254>

On OS X, the grep pattern

    "\"OP .*/objects/$x2/X38_X40 HTTP/[.0-9]*\" 20[0-9] "

is far too long ($x38 and $x40 represent 38 and 40 copies of
[0-9a-f]).  In order to still be able to match this, use the sed
invocation to replace what we're looking for a token.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t5540-http-push.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index a266ca5..5bf287d 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -132,8 +132,9 @@ x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
 x40="$x38$x2"
 
 test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
-	sed -e "s/PUT /OP /" -e "s/MOVE /OP /" "$HTTPD_ROOT_PATH"/access.log |
-	grep -e "\"OP .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*\" 20[0-9] "
+	sed -e "s/PUT /OP /" -e "s/MOVE /OP /" -e "s/$x40/X40/" -e "s/$x38/X38/"\
+		"$HTTPD_ROOT_PATH"/access.log |
+	grep -e "\"OP .*/objects/$x2/X38_X40 HTTP/[.0-9]*\" 20[0-9] "
 
 '
 
-- 
1.7.6.671.g4d09b
