From: Jeff King <peff@peff.net>
Subject: [PATCH 5/4] check-docs: factor out command-list
Date: Wed, 8 Aug 2012 16:56:04 -0400
Message-ID: <20120808205604.GA12838@sigill.intra.peff.net>
References: <20120808205456.GB29528@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzDIe-0003wA-PI
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758147Ab2HHU4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:56:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57677 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750Ab2HHU4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:56:10 -0400
Received: (qmail 11634 invoked by uid 107); 8 Aug 2012 20:56:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 16:56:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 16:56:04 -0400
Content-Disposition: inline
In-Reply-To: <20120808205456.GB29528@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203127>

The check-docs command list is composed from several
Makefile variables plus some special cases. Let's make the
meaning of the list more obvious and avoid repeating
ourselves by factoring it out.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 41d9db8..6ae868d 100644
--- a/Makefile
+++ b/Makefile
@@ -2804,8 +2804,12 @@ endif
 
 ### Check documentation
 #
+ALL_COMMANDS = $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS)
+ALL_COMMANDS += git
+ALL_COMMANDS += gitk
+ALL_COMMANDS += gitweb
 check-docs::
-	@(for v in $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk gitweb; \
+	@(for v in $(ALL_COMMANDS); \
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
@@ -2858,7 +2862,7 @@ check-docs::
 		documented,gitweb.conf | \
 		sentinel,not,matching,is,ok ) continue ;; \
 		esac; \
-		case " $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk gitweb " in \
+		case " $(ALL_COMMANDS) " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
 		esac; \
-- 
1.7.12.rc2.36.gb1dc81b
