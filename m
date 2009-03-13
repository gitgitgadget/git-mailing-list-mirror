From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] test-lib.sh: Allow running the test suite against installed git
Date: Fri, 13 Mar 2009 16:45:16 +0100
Message-ID: <1236959116-3334-3-git-send-email-git@drmicha.warpmail.net>
References: <1236959116-3334-1-git-send-email-git@drmicha.warpmail.net>
 <1236959116-3334-2-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 16:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li9bm-0002hu-AL
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 16:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758045AbZCMPpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 11:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757315AbZCMPpg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 11:45:36 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52484 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755818AbZCMPpf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 11:45:35 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B88432EF5AE;
	Fri, 13 Mar 2009 11:45:33 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 13 Mar 2009 11:45:33 -0400
X-Sasl-enc: UCQYM5FVGSQleqbWR9Fn/7CvOkz7On+BvcoL0At5HU3t 1236959133
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 27643461E4;
	Fri, 13 Mar 2009 11:45:33 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
In-Reply-To: <1236959116-3334-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113200>

Introduce variables externalpath and externalexecpath such that the test
suite can be run against a git which is installed at $externalpath with
subcommands at $externalexecpath. externalpath defaults to the git.git
checkout, externalexecpath defaults to $externalpath. Run the suite as

externalpath=somepath externalexecpath=someotherpath make test

but note that this requires and uses parts of a compiled git in the
git.git checkout: test helpers, templates and perl libraries are taken
from there.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/test-lib.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b9da86e..f6c467f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -514,8 +514,14 @@ test_done () {
 TEST_DIRECTORY=$(pwd)
 if test -z "$valgrind"
 then
-	PATH=$TEST_DIRECTORY/..:$PATH
-	GIT_EXEC_PATH=$TEST_DIRECTORY/..
+	if test -z "$externalpath"
+	then
+		PATH=$TEST_DIRECTORY/..:$PATH
+		GIT_EXEC_PATH=$TEST_DIRECTORY/..
+	else
+		PATH=$externalpath:$TEST_DIRECTORY/..:$PATH
+		GIT_EXEC_PATH=${externalexecpath:-$externalpath}
+	fi
 else
 	make_symlink () {
 		test -h "$2" &&
-- 
1.6.2.149.g6462
