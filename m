From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH-maint] test-lib.sh: Help test_create_repo() find the templates dir
Date: Tue, 21 Apr 2009 11:19:03 +0200
Message-ID: <1240305543-27163-1-git-send-email-git@drmicha.warpmail.net>
References: <7vocuqbmgu.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 11:22:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwCAa-0002jQ-2d
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756577AbZDUJTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756323AbZDUJTP
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:19:15 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38100 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756192AbZDUJTM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 05:19:12 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 5706D31EE49;
	Tue, 21 Apr 2009 05:19:11 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 21 Apr 2009 05:19:11 -0400
X-Sasl-enc: +V8VUgNIXnc2iS3if6sybpoCk+WxQVoRps6C1rndKb+s 1240305550
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B0E1556166;
	Tue, 21 Apr 2009 05:19:10 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc0.201.g3759d
In-Reply-To: <7vocuqbmgu.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117114>

Currently, test_create_repo() expects that templates can be found below
$GIT_EXEC_DIR. This assumption fails when tests are run against a git
installed somewhere else.
Therefore, use $TEST_DIRECTORY as introduced in 2d84e9fb and expect
templates to be present in $TEST_DIRECTORY/.. which should be the root
dir of the git checkout.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is a patch against maint as discussed in
http://article.gmane.org/gmane.comp.version-control.git/11699 although
maint does not (yet) contain a6d63b7 which actually exposes the problem.

The patch does not apply cleanly to master and needs a different commit
message there anyways. Therefore, I will send a follow-up with a patch
against master. I suggest considering this "maint for master", i.e.
applying to master where the bug is actually exposed.

 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 59d82d2..dbce26a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -434,7 +434,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir -p "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init "--template=$GIT_EXEC_PATH/templates/blt/" >&3 2>&4 ||
+	"$GIT_EXEC_PATH/git" init "--template=$TEST_DIRECTORY/../templates/blt/" >&3 2>&4 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
-- 
1.6.3.rc0.201.g3759d
