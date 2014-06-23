From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 4/5] t7510: exit for loop with test result
Date: Mon, 23 Jun 2014 09:05:50 +0200
Message-ID: <9013cca44cba0235e5fbb2f99f88cc6cbb0e0032.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 09:06:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyyKc-0000rM-2C
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 09:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbaFWHGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 03:06:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50394 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751577AbaFWHGB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2014 03:06:01 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5504820E4F
	for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:05:58 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 23 Jun 2014 03:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=X/
	MRzisnH8ONCiMPcBCJh2AMiWY=; b=f57EXTzlBRgJbO/3JMHE5UKswwn1o6qMoG
	anN15v2nN6qpPo6M46jv30S6yTA0vpCp8UeFQMysfrPMHOD6HTD0bfCVkb6BQ63I
	fXSdTBh/NvubBbxf7fsDk9b/8Q0XM4FS/HoQe1zsecz3Daf0Nw+U0DLA4aenEvIj
	KsQ1ivosA=
X-Sasl-enc: N1yQQmUxPR3apW3LLLWrlMTVLnZeHrvO7oRjUbNv8IHn 1403507158
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 93D3DC0000C;
	Mon, 23 Jun 2014 03:05:58 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1403506792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252321>

t7510 uses for loops in a subshell, which need to make sure that the test
returns with the appropriate error code from within the loop.

Restructure the loops as the usual && chains with a single point of
"exit 1" at the end of the loop to make this clearer.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7510-signed-commit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 5ddac1a..96cfddf 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -50,7 +50,7 @@ test_expect_success GPG 'show signatures' '
 		for commit in initial second merge fourth-signed fifth-signed sixth-signed master
 		do
 			git show --pretty=short --show-signature $commit >actual &&
-			grep "Good signature from" actual || exit 1
+			grep "Good signature from" actual &&
 			! grep "BAD signature from" actual || exit 1
 			echo $commit OK
 		done
@@ -59,7 +59,7 @@ test_expect_success GPG 'show signatures' '
 		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
 		do
 			git show --pretty=short --show-signature $commit >actual &&
-			grep "Good signature from" actual && exit 1
+			! grep "Good signature from" actual &&
 			! grep "BAD signature from" actual || exit 1
 			echo $commit OK
 		done
-- 
2.0.0.426.g37dbf84
