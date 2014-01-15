From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] interpret_branch_name: rename "cp" variable to "at"
Date: Wed, 15 Jan 2014 03:27:32 -0500
Message-ID: <20140115082732.GB19132@sigill.intra.peff.net>
References: <20140115082528.GA18974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 09:27:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Lp4-0002Bx-JQ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 09:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbaAOI1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 03:27:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:60913 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751512AbaAOI1e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 03:27:34 -0500
Received: (qmail 9083 invoked by uid 102); 15 Jan 2014 08:27:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 02:27:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 03:27:32 -0500
Content-Disposition: inline
In-Reply-To: <20140115082528.GA18974@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240439>

In the original version of this function, "cp" acted as a
pointer to many different things. Since the refactoring in
the last patch, it only marks the at-sign in the string.
Let's use a more descriptive variable name.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously can be squashed with the prior refactoring, but I think
splitting it makes the diffs easier to read.

 sha1_name.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 5db742b..958aa2e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1117,7 +1117,7 @@ static int interpret_upstream_mark(const char *name, int namelen,
  */
 int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 {
-	char *cp;
+	char *at;
 	int len = interpret_nth_prior_checkout(name, buf);
 
 	if (!namelen)
@@ -1132,15 +1132,15 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 			return reinterpret(name, namelen, len, buf);
 	}
 
-	cp = strchr(name, '@');
-	if (!cp)
+	at = strchr(name, '@');
+	if (!at)
 		return -1;
 
-	len = interpret_empty_at(name, namelen, cp - name, buf);
+	len = interpret_empty_at(name, namelen, at - name, buf);
 	if (len > 0)
 		return reinterpret(name, namelen, len, buf);
 
-	len = interpret_upstream_mark(name, namelen, cp - name, buf);
+	len = interpret_upstream_mark(name, namelen, at - name, buf);
 	if (len > 0)
 		return len;
 
-- 
1.8.5.2.500.g8060133
