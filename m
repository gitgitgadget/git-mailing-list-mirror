From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 02/10] replace_object: don't check read_replace_refs twice
Date: Wed, 11 Dec 2013 08:46:05 +0100
Message-ID: <20131211074614.11117.8923.chriscool@tuxfamily.org>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 08:47:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqeWP-0007lg-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 08:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267Ab3LKHrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 02:47:49 -0500
Received: from [194.158.98.45] ([194.158.98.45]:37570 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751252Ab3LKHrr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 02:47:47 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 0A37554;
	Wed, 11 Dec 2013 08:47:27 +0100 (CET)
X-git-sha1: dcd5901b9da95c12c5eed99b3ce7a1fd5b595518 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131211074147.11117.1155.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239171>

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
1.8.5.1.102.g090758b
