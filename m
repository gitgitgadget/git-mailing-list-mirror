From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] diff_filespec: reorder dirty_submodule macro definitions
Date: Thu, 16 Jan 2014 20:19:46 -0500
Message-ID: <20140117011945.GA7249@sigill.intra.peff.net>
References: <20140117011844.GA6870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 02:19:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3y6B-00085n-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 02:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbaAQBTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 20:19:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:33877 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750898AbaAQBTr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 20:19:47 -0500
Received: (qmail 5906 invoked by uid 102); 17 Jan 2014 01:19:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 19:19:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 20:19:46 -0500
Content-Disposition: inline
In-Reply-To: <20140117011844.GA6870@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240551>

diff_filespec has a 2-bit "dirty_submodule" field and
defines two flags as macros. Originally these were right
next to each other, but a new field was accidentally added
in between in commit 4682d85. This patch puts the field and
its flags back together.

Using an enum like:

  enum {
	  DIRTY_SUBMODULE_UNTRACKED = 1,
	  DIRTY_SUBMODULE_MODIFIED = 2
  } dirty_submodule;

would be more obvious, but it bloats the structure. Limiting
the enum size like:

  } dirty_submodule : 2;

might work, but it is not portable.

Signed-off-by: Jeff King <peff@peff.net>
---
 diffcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore.h b/diffcore.h
index 1c16c85..f822f9e 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -43,9 +43,9 @@ struct diff_filespec {
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
 	unsigned dirty_submodule : 2;  /* For submodules: its work tree is dirty */
-	unsigned is_stdin : 1;
 #define DIRTY_SUBMODULE_UNTRACKED 1
 #define DIRTY_SUBMODULE_MODIFIED  2
+	unsigned is_stdin : 1;
 	unsigned has_more_entries : 1; /* only appear in combined diff */
 	struct userdiff_driver *driver;
 	/* data should be considered "binary"; -1 means "don't know yet" */
-- 
1.8.5.2.500.g8060133
