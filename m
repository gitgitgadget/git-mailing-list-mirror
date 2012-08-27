From: Jeff King <peff@peff.net>
Subject: [PATCH 3/8] t/lib-httpd: only route auth/dumb to dumb repos
Date: Mon, 27 Aug 2012 09:24:42 -0400
Message-ID: <20120827132442.GC17375@sigill.intra.peff.net>
References: <20120827132145.GA17265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:24:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5zJD-0001Rp-VO
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 15:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab2H0NYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 09:24:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39692 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab2H0NYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 09:24:45 -0400
Received: (qmail 12808 invoked by uid 107); 27 Aug 2012 13:25:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 09:25:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 09:24:42 -0400
Content-Disposition: inline
In-Reply-To: <20120827132145.GA17265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204336>

Our test apache config points all of auth/ directly to the
on-disk repositories via an Alias directive. This works fine
because everything authenticated is currently in auth/dumb,
which is a subset.  However, this would conflict with a
ScriptAlias for auth/smart (which will come in future
patches), so let's narrow the Alias.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/apache.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 36b1596..d13fe64 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -46,7 +46,7 @@ PassEnv GIT_VALGRIND
 PassEnv GIT_VALGRIND_OPTIONS
 
 Alias /dumb/ www/
-Alias /auth/ www/auth/
+Alias /auth/dumb/ www/auth/dumb/
 
 <Location /smart/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
-- 
1.7.11.5.10.g3c8125b
