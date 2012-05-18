From: Jeff King <peff@peff.net>
Subject: [PATCH 02/13] http-push: do not access git_default_email directly
Date: Fri, 18 May 2012 19:09:05 -0400
Message-ID: <20120518230905.GB30031@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:09:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWIQ-0001B0-Nr
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946763Ab2ERXJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:09:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48750
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946838Ab2ERXJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:09:08 -0400
Received: (qmail 7585 invoked by uid 107); 18 May 2012 23:09:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:09:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:09:05 -0400
Content-Disposition: inline
In-Reply-To: <20120518230528.GA30510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197982>

By calling the ident_default_email accessor, we can be sure
that the default value is actually filled-in.

Signed-off-by: Jeff King <peff@peff.net>
---
I believe this is a real, triggerable bug if you don't have your
user.email config set, but I didn't actually test it (and I have no idea
if DAV would actually care about an empty email here anyway).

 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 1df7ab5..a832ca7 100644
--- a/http-push.c
+++ b/http-push.c
@@ -904,7 +904,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 		ep = strchr(ep + 1, '/');
 	}
 
-	escaped = xml_entities(git_default_email);
+	escaped = xml_entities(ident_default_email());
 	strbuf_addf(&out_buffer.buf, LOCK_REQUEST, escaped);
 	free(escaped);
 
-- 
1.7.10.1.16.g53a707b
