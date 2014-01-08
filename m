From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] sha1_name: refactor upstream_mark
Date: Wed, 8 Jan 2014 04:34:24 -0500
Message-ID: <20140108093424.GA15720@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 10:34:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0pWy-0005Sw-7i
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 10:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbaAHJe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 04:34:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:57084 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753919AbaAHJe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 04:34:26 -0500
Received: (qmail 29553 invoked by uid 102); 8 Jan 2014 09:34:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 03:34:27 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 04:34:24 -0500
Content-Disposition: inline
In-Reply-To: <20140108093338.GA15659@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240199>

We will be adding new mark types in the future, so separate
the suffix data from the logic.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index b1873d8..0c50801 100644
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
 static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf);
 
-- 
1.8.5.2.500.g8060133
