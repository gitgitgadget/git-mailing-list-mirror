From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 02/10] replace_object: don't check read_replace_refs twice
Date: Sat, 28 Dec 2013 12:00:07 +0100
Message-ID: <20131228110016.2272.63916.chriscool@tuxfamily.org>
References: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 12:01:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwreF-0007rw-CV
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab3L1LBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:01:23 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33980 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab3L1LAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:00:48 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id EE4E26A;
	Sat, 28 Dec 2013 12:00:46 +0100 (CET)
X-git-sha1: dcd5901b9da95c12c5eed99b3ce7a1fd5b595518 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239779>

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
1.8.4.1.616.g07f5c81
