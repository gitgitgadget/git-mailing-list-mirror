From: Jeff King <peff@peff.net>
Subject: [PATCH 03/16] avoid using skip_prefix as a boolean
Date: Wed, 18 Jun 2014 15:42:14 -0400
Message-ID: <20140618194214.GC22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:42:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLkS-00061L-1h
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbaFRTmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:42:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:46938 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754537AbaFRTmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:42:16 -0400
Received: (qmail 29906 invoked by uid 102); 18 Jun 2014 19:42:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:42:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:42:14 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252035>

There's no point in using:

  if (skip_prefix(buf, "foo"))

over

  if (starts_with(buf, "foo"))

as the point of skip_prefix is to return a pointer to the
data after the prefix. Using starts_with is more readable,
and will make refactoring skip_prefix easier.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fmt-merge-msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3906eda..72378e6 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -298,7 +298,7 @@ static void credit_people(struct strbuf *out,
 	    (them->nr == 1 &&
 	     me &&
 	     (me = skip_prefix(me, them->items->string)) != NULL &&
-	     skip_prefix(me, " <")))
+	     starts_with(me, " <")))
 		return;
 	strbuf_addf(out, "\n%c %s ", comment_line_char, label);
 	add_people_count(out, them);
-- 
2.0.0.566.gfe3e6b2
