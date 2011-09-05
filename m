From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t5541: avoid TAP test miscounting
Date: Mon,  5 Sep 2011 16:24:06 +0200
Message-ID: <e4e82f1267da3edfc600361de0041f618c31e30c.1315232475.git.git@drmicha.warpmail.net>
References: <4E64DA0A.8090202@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, tobiasu@tmux.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 16:24:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0a5v-0002Mi-IB
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 16:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab1IEOYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 10:24:10 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46348 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753942Ab1IEOYJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2011 10:24:09 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 225C824AA3;
	Mon,  5 Sep 2011 10:24:09 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 05 Sep 2011 10:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=2CDwZzI1cFx9lT2Qr4d+n5UFi
	Wg=; b=A31hJucvsN4FErQWt1Y72Mu5ODP7G3xzsd1f4a9fXWTEbk0NYLMoY0Dqn
	ymhjHBo3dcbRXWS8cqPEdU0uZbsozN46hDlMUqN25+UBS8mLYnNzYNcRTTjDpyB4
	svLK3o4ZbnhwUgXqG84Ti5atcuuj8ZHsiihzw9kjoNLI0VtyFQ=
X-Sasl-enc: HsfawQVa2tB3ic46W39BncvhXfizsXBLVvw+wXyEpQua 1315232648
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 91D3DB02800;
	Mon,  5 Sep 2011 10:24:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.328.g9d6c7
In-Reply-To: <4E64DA0A.8090202@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180746>

lib-terminal.sh runs a test and thus increases the test count, but the
output is lost so that TAP produces a "no plan found error".

Move the lib-terminal call after the lib-httpd and make TAP happy
(though still leave me clueless).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t5541-http-push.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 0dcb8df..a18265c 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -5,7 +5,6 @@
 
 test_description='test smart pushing over http via http-backend'
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-terminal.sh
 
 if test -n "$NO_CURL"; then
 	skip_all='skipping test, git built without http support'
@@ -15,6 +14,7 @@ fi
 ROOT_PATH="$PWD"
 LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5541'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 start_httpd
 
 test_expect_success 'setup remote repository' '
-- 
1.7.7.rc0.328.g9d6c7
