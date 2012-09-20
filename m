From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] remote-curl: rename is_http variable
Date: Thu, 20 Sep 2012 13:00:22 -0400
Message-ID: <20120920170022.GA18981@sigill.intra.peff.net>
References: <20120920165938.GB18655@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:00:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEk77-00016p-IX
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 19:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658Ab2ITRAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 13:00:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51568 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab2ITRAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 13:00:24 -0400
Received: (qmail 17619 invoked by uid 107); 20 Sep 2012 17:00:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Sep 2012 13:00:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2012 13:00:22 -0400
Content-Disposition: inline
In-Reply-To: <20120920165938.GB18655@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206058>

We don't actually care whether the connection is http or
not; what we care about is whether it might be smart http.
Rename the variable to be more accurate, which will make it
easier to later make smart-http optional.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 2359f59..c0b98cc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -95,7 +95,7 @@ static struct discovery* discover_refs(const char *service)
 	struct strbuf buffer = STRBUF_INIT;
 	struct discovery *last = last_discovery;
 	char *refs_url;
-	int http_ret, is_http = 0;
+	int http_ret, maybe_smart = 0;
 
 	if (last && !strcmp(service, last->service))
 		return last;
@@ -103,7 +103,7 @@ static struct discovery* discover_refs(const char *service)
 
 	strbuf_addf(&buffer, "%sinfo/refs", url);
 	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
-		is_http = 1;
+		maybe_smart = 1;
 		if (!strchr(url, '?'))
 			strbuf_addch(&buffer, '?');
 		else
@@ -131,7 +131,7 @@ static struct discovery* discover_refs(const char *service)
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-	if (is_http && 5 <= last->len && last->buf[4] == '#') {
+	if (maybe_smart && 5 <= last->len && last->buf[4] == '#') {
 		/* smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
-- 
1.7.11.7.15.g085c6bd
