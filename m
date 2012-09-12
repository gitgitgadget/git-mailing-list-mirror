From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 2/3] sha1: clean pointer arithmetic
Date: Wed, 12 Sep 2012 12:21:13 +0200
Message-ID: <20dce012a57900b61e51c0e0d8dfb5573693010e.1347442430.git.ydroneaud@opteya.com>
References: <cover.1347442430.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 13:16:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBkw3-0003CT-3N
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 13:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab2ILLQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 07:16:28 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:48728 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995Ab2ILLQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 07:16:26 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:21d0:2ede:8970:5205])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 4BD549400BC;
	Wed, 12 Sep 2012 13:16:16 +0200 (CEST)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id q8CBGF7D030220;
	Wed, 12 Sep 2012 13:16:15 +0200
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id q8CAUUKj029511;
	Wed, 12 Sep 2012 12:30:30 +0200
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <cover.1347442430.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205281>

One memcpy() argument is computed from a pointer added to an integer:
eg. int + pointer. It's unusal.
Let's write it in the correct order: pointer + offset.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 block-sha1/sha1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index c1af112..a7c4470 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -246,7 +246,7 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 		unsigned int left = 64 - lenW;
 		if (len < left)
 			left = len;
-		memcpy(lenW + (char *)ctx->W, data, left);
+		memcpy((char *)ctx->W + lenW, data, left);
 		lenW = (lenW + left) & 63;
 		if (lenW)
 			return;
-- 
1.7.11.4
