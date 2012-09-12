From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 1/3] sha1: update pointer and remaining length after subfunction call
Date: Wed, 12 Sep 2012 12:01:25 +0200
Message-ID: <e6f0051409811fc57385ae712d3256772044bf09.1347442430.git.ydroneaud@opteya.com>
References: <cover.1347442430.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 12:02:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBjlj-0004Uy-MV
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 12:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab2ILKB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 06:01:56 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:59134 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316Ab2ILKBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 06:01:55 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:21d0:2ede:8970:5205])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A5B079400C6;
	Wed, 12 Sep 2012 12:01:45 +0200 (CEST)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id q8CA1iwl028826;
	Wed, 12 Sep 2012 12:01:44 +0200
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id q8CA1irE028825;
	Wed, 12 Sep 2012 12:01:44 +0200
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <cover.1347442430.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1347442430.git.ydroneaud@opteya.com>
References: <cover.1347442430.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205277>

There's no need to update the pointer and remaining length before
leaving or calling the SHA1 sub function.

Additionnaly, the partial block code could be looking more like
the full block handling branch.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 block-sha1/sha1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index a8d4bf9..c1af112 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -248,11 +248,11 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 			left = len;
 		memcpy(lenW + (char *)ctx->W, data, left);
 		lenW = (lenW + left) & 63;
-		len -= left;
-		data = ((const char *)data + left);
 		if (lenW)
 			return;
 		blk_SHA1_Block(ctx, ctx->W);
+		data = ((const char *)data + left);
+		len -= left;
 	}
 	while (len >= 64) {
 		blk_SHA1_Block(ctx, data);
-- 
1.7.11.4
