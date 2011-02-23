From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] format-patch: rfc2047-encode newlines in headers
Date: Wed, 23 Feb 2011 04:59:18 -0500
Message-ID: <20110223095917.GC9222@sigill.intra.peff.net>
References: <20110223094844.GA9205@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: xzer <xiaozhu@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 10:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsBVF-0001b1-P0
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 10:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab1BWJ7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 04:59:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38709 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab1BWJ7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 04:59:19 -0500
Received: (qmail 10811 invoked by uid 111); 23 Feb 2011 09:59:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 09:59:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 04:59:18 -0500
Content-Disposition: inline
In-Reply-To: <20110223094844.GA9205@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167684>

These should generally never happen, as we already
concatenate multiples in subjects into a single line. But
let's be defensive, since not encoding them means we will
output malformed headers.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 0e167f4..65d20a7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -228,7 +228,7 @@ static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 
 	for (i = 0; i < len; i++) {
 		int ch = line[i];
-		if (non_ascii(ch))
+		if (non_ascii(ch) || ch == '\n')
 			goto needquote;
 		if ((i + 1 < len) && (ch == '=' && line[i+1] == '?'))
 			goto needquote;
@@ -254,7 +254,7 @@ needquote:
 		 * many programs do not understand this and just
 		 * leave the underscore in place.
 		 */
-		if (is_rfc2047_special(ch) || ch == ' ') {
+		if (is_rfc2047_special(ch) || ch == ' ' || ch == '\n') {
 			strbuf_addf(sb, "=%02X", ch);
 			line_len += 3;
 		}
-- 
1.7.2.5.15.gfdd1c
