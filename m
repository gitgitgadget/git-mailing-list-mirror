From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 4/6] t7510: exit for loop with test result
Date: Fri, 13 Jun 2014 12:42:46 +0200
Message-ID: <99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 12:43:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvOxA-0007vU-20
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 12:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbaFMKnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 06:43:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49574 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753129AbaFMKm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 06:42:58 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8FE4920BE6
	for <git@vger.kernel.org>; Fri, 13 Jun 2014 06:42:57 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 13 Jun 2014 06:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=mz
	H9O9PBm8KaQBrDTPuVjnbxbSY=; b=fN7RmwczTHoRR4MxJOVJ4sZBFV/6tAM8c2
	8trs2OjPnbzYbXhm+YfhPRgoSHNoJucRC4TMtf12Ce/e9K77HwrWbj2SX7Kj38Ew
	fTqBE3ldm6YymGcBLYQYHvr7UVNsBGySaF32VhKTdWvWGtGtUBEz6vG+m6VGgBl5
	j0jG1Ub00=
X-Sasl-enc: jI8bDKzz7G6hrSb7ogc9az7rQtzkEIl96nDBd7tSk7mo 1402656176
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 64695C007B3;
	Fri, 13 Jun 2014 06:42:56 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402063795.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251543>

When t7510 was introduced, the author made sure that a for loop in
a subshell would return with the appropriate error code.

Make sure this is true also the for the first line in each loop, which
was missed.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7510-signed-commit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 5ddac1a..a5ba48e 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -49,7 +49,7 @@ test_expect_success GPG 'show signatures' '
 	(
 		for commit in initial second merge fourth-signed fifth-signed sixth-signed master
 		do
-			git show --pretty=short --show-signature $commit >actual &&
+			git show --pretty=short --show-signature $commit >actual || exit 1
 			grep "Good signature from" actual || exit 1
 			! grep "BAD signature from" actual || exit 1
 			echo $commit OK
@@ -58,7 +58,7 @@ test_expect_success GPG 'show signatures' '
 	(
 		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
 		do
-			git show --pretty=short --show-signature $commit >actual &&
+			git show --pretty=short --show-signature $commit >actual || exit 1
 			grep "Good signature from" actual && exit 1
 			! grep "BAD signature from" actual || exit 1
 			echo $commit OK
-- 
2.0.0.426.g37dbf84
