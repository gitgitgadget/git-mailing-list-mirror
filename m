From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] diff_filespec: drop xfrm_flags field
Date: Thu, 16 Jan 2014 20:21:59 -0500
Message-ID: <20140117012158.GC7249@sigill.intra.peff.net>
References: <20140117011844.GA6870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 02:22:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3y8L-0003J0-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 02:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbaAQBWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 20:22:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:33882 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751435AbaAQBWA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 20:22:00 -0500
Received: (qmail 6026 invoked by uid 102); 17 Jan 2014 01:22:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 19:22:00 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 20:21:59 -0500
Content-Disposition: inline
In-Reply-To: <20140117011844.GA6870@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240553>

The only mention of this field in the code is by some
debugging code which prints it out (and it will always be
zero, since we never touch it otherwise). It was obsoleted
very early on by 25d5ea4 ([PATCH] Redo rename/copy detection
logic., 2005-05-24).

Signed-off-by: Jeff King <peff@peff.net>
---
No savings here on 64-bit, since this ended up going to padding, but it
is what makes the next patch work.

 diff.c     | 4 ++--
 diffcore.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 6b4cd0e..8e4a6a9 100644
--- a/diff.c
+++ b/diff.c
@@ -4139,9 +4139,9 @@ void diff_debug_filespec(struct diff_filespec *s, int x, const char *one)
 		DIFF_FILE_VALID(s) ? "valid" : "invalid",
 		s->mode,
 		s->sha1_valid ? sha1_to_hex(s->sha1) : "");
-	fprintf(stderr, "queue[%d] %s size %lu flags %d\n",
+	fprintf(stderr, "queue[%d] %s size %lu\n",
 		x, one ? one : "",
-		s->size, s->xfrm_flags);
+		s->size);
 }
 
 void diff_debug_filepair(const struct diff_filepair *p, int i)
diff --git a/diffcore.h b/diffcore.h
index 92e4d48..22993e1 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -31,7 +31,6 @@ struct diff_filespec {
 	void *cnt_data;
 	unsigned long size;
 	int count;               /* Reference count */
-	int xfrm_flags;		 /* for use by the xfrm */
 	int rename_used;         /* Count of rename users */
 	unsigned short mode;	 /* file mode */
 	unsigned sha1_valid : 1; /* if true, use sha1 and trust mode;
-- 
1.8.5.2.500.g8060133
