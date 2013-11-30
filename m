From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/5] replace_object: don't check read_replace_refs twice
Date: Sat, 30 Nov 2013 14:51:19 +0100
Message-ID: <20131130135124.2697.81789.chriscool@tuxfamily.org>
References: <20131130133934.2697.75781.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 14:52:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmkxy-0004XU-C8
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 14:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab3K3NwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 08:52:10 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:55422 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab3K3NwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 08:52:07 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 8AAA848;
	Sat, 30 Nov 2013 14:52:06 +0100 (CET)
X-git-sha1: af07d82b3282423686a267f61d73ee77266aedb8 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131130133934.2697.75781.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238558>

Since e1111cef (inline lookup_replace_object() calls,
May 15 2011) the read_replace_refs global variable is
checked twice, once in lookup_replace_object() and
once again in do_lookup_replace_object().

As do_lookup_replace_object() is called only from
lookup_replace_object(), we can remove the check in
do_lookup_replace_object().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 replace_object.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/replace_object.c b/replace_object.c
index d0b1548..cdcaf8c 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -97,9 +97,6 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 	int pos, depth = MAXREPLACEDEPTH;
 	const unsigned char *cur = sha1;
 
-	if (!read_replace_refs)
-		return sha1;
-
 	prepare_replace_object();
 
 	/* Try to recursively replace the object */
-- 
1.8.4.1.561.g12affca
