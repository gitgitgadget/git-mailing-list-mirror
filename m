From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH-master] test-lib.sh: Help test_create_repo() find the templates dir
Date: Tue, 21 Apr 2009 11:21:59 +0200
Message-ID: <1240305719-27224-1-git-send-email-git@drmicha.warpmail.net>
References: <1240305543-27163-1-git-send-email-git@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 11:27:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwCDk-0004PO-22
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbZDUJWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755121AbZDUJWJ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:22:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36408 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756902AbZDUJWH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 05:22:07 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 44ED831CCC3;
	Tue, 21 Apr 2009 05:22:07 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 21 Apr 2009 05:22:07 -0400
X-Sasl-enc: N204enkSvtOqmAx7ORHe+lLjOPd+l+jGBsPUq3r8NAFh 1240305726
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9A26330952;
	Tue, 21 Apr 2009 05:22:06 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc0.201.g3759d
In-Reply-To: <1240305543-27163-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117115>

Currently, test_create_repo() expects that templates can be found below
`pwd`/.. This assumption fails when tests are run against a git
installed somewhere else or test_create_repo() is called from
subdirectiories (several tests do this).
Therefore, use $TEST_DIRECTORY as introduced in 2d84e9fb and expect
templates to be present in $TEST_DIRECTORY/.. which should be the root
dir of the git checkout.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4bd986f..dad1437 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -491,7 +491,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir -p "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git-init" "--template=$owd/../templates/blt/" >&3 2>&4 ||
+	"$GIT_EXEC_PATH/git-init" "--template=$TEST_DIRECTORY/../templates/blt/" >&3 2>&4 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
-- 
1.6.3.rc0.201.g3759d
