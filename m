From: Jeff King <peff@peff.net>
Subject: [PATCH] valgrind: also ignore Addr16 in check_refname_format
Date: Sat, 26 Jul 2014 07:38:49 -0400
Message-ID: <20140726113849.GA23117@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:39:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XB0JZ-0002OL-0t
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 13:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbaGZLi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2014 07:38:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:40782 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750732AbaGZLi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2014 07:38:56 -0400
Received: (qmail 24404 invoked by uid 102); 26 Jul 2014 11:38:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Jul 2014 06:38:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jul 2014 07:38:49 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254279>

We already suppress Addr8 warnings, but t1402 reliably
triggers Addr16 on my machine.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't look at the code, so I'm not sure if we could similarly trigger
Addr32, etc. This is enough for my machine.

 t/valgrind/default.supp | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 9d51c92..d49a8b2 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -50,11 +50,16 @@
 	fun:copy_ref
 }
 {
-	ignore-sse-check_refname_format-addr
+	ignore-sse-check_refname_format-addr8
 	Memcheck:Addr8
 	fun:check_refname_format
 }
 {
+	ignore-sse-check_refname_format-addr16
+	Memcheck:Addr16
+	fun:check_refname_format
+}
+{
 	ignore-sse-check_refname_format-cond
 	Memcheck:Cond
 	fun:check_refname_format
-- 
2.0.0.566.gfe3e6b2
