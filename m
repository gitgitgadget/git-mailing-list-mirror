From: Jeff King <peff@peff.net>
Subject: [PATCHv2 02/15] http-push: do not access git_default_email directly
Date: Mon, 21 May 2012 19:09:47 -0400
Message-ID: <20120521230947.GB10981@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:10:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWbjh-00075M-69
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315Ab2EUXJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:09:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51199
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666Ab2EUXJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:09:50 -0400
Received: (qmail 7689 invoked by uid 107); 21 May 2012 23:10:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:10:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:09:47 -0400
Content-Disposition: inline
In-Reply-To: <20120521230917.GA474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198148>

By calling the ident_default_email accessor, we can be sure
that the default value is actually filled-in.

Signed-off-by: Jeff King <peff@peff.net>
---
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
1.7.10.1.19.g711d603
