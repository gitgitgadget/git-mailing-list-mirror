From: Jeff King <peff@peff.net>
Subject: [PATCH 08/12] sha1_name: refactor upstream_mark
Date: Fri, 1 May 2015 18:53:41 -0400
Message-ID: <20150501225341.GH1534@peff.net>
References: <20150501224414.GA25551@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 00:53:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJoa-0003LL-L7
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbbEAWxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:53:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:53117 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750710AbbEAWxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:53:43 -0400
Received: (qmail 24000 invoked by uid 102); 1 May 2015 22:53:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 17:53:43 -0500
Received: (qmail 21088 invoked by uid 107); 1 May 2015 22:54:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 18:54:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 18:53:41 -0400
Content-Disposition: inline
In-Reply-To: <20150501224414.GA25551@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268193>

We will be adding new mark types in the future, so separate
the suffix data from the logic.

Signed-off-by: Jeff King <peff@peff.net>
---
Same as v1.

 sha1_name.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 461157a..1005f45 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -415,12 +415,12 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
-static inline int upstream_mark(const char *string, int len)
+static inline int at_mark(const char *string, int len,
+			  const char **suffix, int nr)
 {
-	const char *suffix[] = { "@{upstream}", "@{u}" };
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
+	for (i = 0; i < nr; i++) {
 		int suffix_len = strlen(suffix[i]);
 		if (suffix_len <= len
 		    && !memcmp(string, suffix[i], suffix_len))
@@ -429,6 +429,12 @@ static inline int upstream_mark(const char *string, int len)
 	return 0;
 }
 
+static inline int upstream_mark(const char *string, int len)
+{
+	const char *suffix[] = { "@{upstream}", "@{u}" };
+	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
+}
+
 static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(const char *name, int namelen, struct strbuf *buf);
 
-- 
2.4.0.rc3.477.gc25258d
