From: Jeff King <peff@peff.net>
Subject: [PATCH] test-path-utils: use xsnprintf in favor of strcpy
Date: Mon, 8 Feb 2016 17:21:55 -0500
Message-ID: <20160208222155.GA17395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:22:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSuC3-0004GZ-7t
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 23:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbcBHWV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 17:21:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:39529 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755975AbcBHWV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 17:21:57 -0500
Received: (qmail 30733 invoked by uid 102); 8 Feb 2016 22:21:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 17:21:57 -0500
Received: (qmail 10183 invoked by uid 107); 8 Feb 2016 22:21:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 17:21:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 17:21:55 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285815>

This strcpy will never overflow because it's copying from
baked-in test data. But we would prefer to avoid strcpy
entirely, as it makes it harder to audit for real security
bugs.

Signed-off-by: Jeff King <peff@peff.net>
---
Repost of <20160114202608.GA8806@sigill.intra.peff.net> from a few weeks
ago (sorry, gmane is down so I can't generate a link). I think the
original was never applied because the topic that introduced the strcpy
(js/dirname-basename) predated xsnprintf, so there was some merging
complexity. Now that topic is in master, so this can be applied there.

 test-path-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-path-utils.c b/test-path-utils.c
index c3adcd8..6232dfe 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -56,7 +56,7 @@ static int test_function(struct test_data *data, char *(*func)(char *input),
 		if (!data[i].from)
 			to = func(NULL);
 		else {
-			strcpy(buffer, data[i].from);
+			xsnprintf(buffer, sizeof(buffer), "%s", data[i].from);
 			to = func(buffer);
 		}
 		if (!strcmp(to, data[i].to))
-- 
2.7.1.526.gd04f550
