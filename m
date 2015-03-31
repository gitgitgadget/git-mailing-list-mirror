From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] sha1_name: refactor upstream_mark
Date: Tue, 31 Mar 2015 13:37:41 -0400
Message-ID: <20150331173740.GE18912@peff.net>
References: <20150331173339.GA17732@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 19:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd06m-0005ls-CX
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078AbbCaRho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:37:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:40426 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752400AbbCaRhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:37:43 -0400
Received: (qmail 16855 invoked by uid 102); 31 Mar 2015 17:37:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 12:37:43 -0500
Received: (qmail 25653 invoked by uid 107); 31 Mar 2015 17:38:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:38:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 13:37:41 -0400
Content-Disposition: inline
In-Reply-To: <20150331173339.GA17732@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266538>

We will be adding new mark types in the future, so separate
the suffix data from the logic.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 6d10f05..3741ca3 100644
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
2.4.0.rc0.363.gf9f328b
