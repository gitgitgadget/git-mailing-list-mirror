From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Don't allocate too much memory in quote_ref_url
Date: Sat, 14 Jun 2008 12:02:22 +0200
Message-ID: <1213437742-5751-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 14 12:04:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ScX-0000mn-HC
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 12:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbYFNKD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 06:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbYFNKD2
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 06:03:28 -0400
Received: from vuizook.err.no ([194.24.252.247]:40784 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246AbYFNKD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 06:03:27 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K7SbN-0002X7-86; Sat, 14 Jun 2008 12:03:23 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K7SaU-0001VB-Vl; Sat, 14 Jun 2008 12:02:23 +0200
X-Mailer: git-send-email 1.5.5.4
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85005>

In c13b263, http_fetch_ref got "refs/" included in the ref passed to it,
which, incidentally, makes the allocation in quote_ref_url too big, now.
---

I noticed this when rebasing some of my private branches onto current
master. I had a commit similar to c13b263 that ended up conflicting,
and after conflict resolving, this is all that was left, which is
an obvious change that was lacking there.

 http.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index bc14bdb..9b6d5ed 100644
--- a/http.c
+++ b/http.c
@@ -583,7 +583,7 @@ static char *quote_ref_url(const char *base, const char *ref)
 	int len, baselen, ch;
 
 	baselen = strlen(base);
-	len = baselen + 7; /* "/refs/" + NUL */
+	len = baselen + 2;
 	for (cp = ref; (ch = *cp) != 0; cp++, len++)
 		if (needs_quote(ch))
 			len += 2; /* extra two hex plus replacement % */
-- 
1.5.5.4
