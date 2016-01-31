From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] checkout-index: simplify "-z" option parsing
Date: Sun, 31 Jan 2016 06:25:43 -0500
Message-ID: <20160131112543.GB5116@sigill.intra.peff.net>
References: <20160131112215.GA4589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 12:26:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPq8c-0004Cu-JB
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 12:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345AbcAaLZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 06:25:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:35048 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757287AbcAaLZq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 06:25:46 -0500
Received: (qmail 7256 invoked by uid 102); 31 Jan 2016 11:25:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:25:46 -0500
Received: (qmail 15674 invoked by uid 107); 31 Jan 2016 11:26:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:26:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2016 06:25:43 -0500
Content-Disposition: inline
In-Reply-To: <20160131112215.GA4589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285136>

Now that we act as a simple bool, there's no need to use a
custom callback.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout-index.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index d8d7bd3..3b913d1 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -142,13 +142,6 @@ static int option_parse_u(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_z(const struct option *opt,
-			  const char *arg, int unset)
-{
-	nul_term_line = !unset;
-	return 0;
-}
-
 static int option_parse_prefix(const struct option *opt,
 			       const char *arg, int unset)
 {
@@ -192,9 +185,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'u', "index", &newfd, NULL,
 			N_("update stat information in the index file"),
 			PARSE_OPT_NOARG, option_parse_u },
-		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
-			N_("paths are separated with NUL character"),
-			PARSE_OPT_NOARG, option_parse_z },
+		OPT_BOOL('z', NULL, &nul_term_line,
+			N_("paths are separated with NUL character")),
 		OPT_BOOL(0, "stdin", &read_from_stdin,
 			N_("read list of paths from the standard input")),
 		OPT_BOOL(0, "temp", &to_tempfile,
-- 
2.7.0.489.g6faad84
