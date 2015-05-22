From: Jeff King <peff@peff.net>
Subject: [PATCH] test_bitmap_walk: free bitmap with bitmap_free
Date: Thu, 21 May 2015 20:53:36 -0400
Message-ID: <20150522005336.GA26326@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 02:53:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvbDd-00089n-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 02:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbbEVAxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 20:53:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:34398 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932124AbbEVAxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 20:53:39 -0400
Received: (qmail 30275 invoked by uid 102); 22 May 2015 00:53:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 19:53:39 -0500
Received: (qmail 9947 invoked by uid 107); 22 May 2015 00:53:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 20:53:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 20:53:36 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269680>

Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
noticed that we leak the "result" bitmap. But we should use
"bitmap_free" rather than straight "free", as the former
remembers to free the bitmap array pointed to by the struct.

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry, I should have noticed this when reviewing the original.

 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 62a98cc..d64bd94 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -987,7 +987,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	else
 		fprintf(stderr, "Mismatch!\n");
 
-	free(result);
+	bitmap_free(result);
 }
 
 static int rebuild_bitmap(uint32_t *reposition,
-- 
2.4.1.528.g00591e3
