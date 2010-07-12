From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] test-lib: simplify GIT_SKIP_TESTS loop
Date: Mon, 12 Jul 2010 12:32:18 +0200
Message-ID: <89ce8052aa4bd464b7f7edcd3e6e9d0c9edc9862.1278930328.git.git@drmicha.warpmail.net>
References: <7v7hl4l0du.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 12 12:33:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYGKI-0004Il-M7
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 12:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab0GLKdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 06:33:16 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58986 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497Ab0GLKdP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 06:33:15 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7A9FD10A16C;
	Mon, 12 Jul 2010 06:33:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 12 Jul 2010 06:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=2LkTvpSs58RzjGXZ7DrGzAJ1NVw=; b=RL26oQBdmwhTb0jTNNUqQn1wsh9HROOXe48nhVzY8B5MXsW5mYUz0lwoAk2jgtkltMaRRvyQYEw1KR+aSxTIQhh8SdY9mo5l1Fq8NedzgtZdjhDjFsevDEvDooimcfUOuav5iHZp1hSr9VLO0yVaPgGly87kib95cGRZlu4ATdo=
X-Sasl-enc: fa+3WRM2cX4/fkcewKnuFVDMwQqxaWGBAXUf1R8LM38h 1278930794
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F3FB75E744;
	Mon, 12 Jul 2010 06:33:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.rc1.212.g850a
In-Reply-To: <7v7hl4l0du.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150808>

04ece59 (GIT_SKIP_TESTS: allow users to omit tests that are known to break, 2006-12-28)
introduced GIT_SKIP_TESTS, and since then we have had two nested loops
iterating over GIT_SKIP_TESTS with the same loop variable.

Reduce this to one loop.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
v2 is simplified even more and is really Junio's patch.

 t/test-lib.sh |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac496aa..bc06564 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -385,6 +385,7 @@ test_skip () {
 		case $this_test.$test_count in
 		$skp)
 			to_skip=t
+			break
 		esac
 	done
 	if test -z "$to_skip" && test -n "$prereq" &&
@@ -829,16 +830,8 @@ this_test=${0##*/}
 this_test=${this_test%%-*}
 for skp in $GIT_SKIP_TESTS
 do
-	to_skip=
-	for skp in $GIT_SKIP_TESTS
-	do
-		case "$this_test" in
-		$skp)
-			to_skip=t
-		esac
-	done
-	case "$to_skip" in
-	t)
+	case "$this_test" in
+	$skp)
 		say_color skip >&3 "skipping test $this_test altogether"
 		say_color skip "skip all tests in $this_test"
 		test_done
-- 
1.7.2.rc1.212.g850a
