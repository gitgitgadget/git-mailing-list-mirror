From: Jeff King <peff@peff.net>
Subject: [PATCH 7/9] http: re-word http error message
Date: Fri, 5 Apr 2013 18:22:01 -0400
Message-ID: <20130405222201.GG22163@sigill.intra.peff.net>
References: <20130405221331.GA21209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:28:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQN-0001b9-FC
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162984Ab3DEWWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:22:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58252 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162853Ab3DEWWK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:22:10 -0400
Received: (qmail 18435 invoked by uid 107); 5 Apr 2013 22:24:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 18:24:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 18:22:01 -0400
Content-Disposition: inline
In-Reply-To: <20130405221331.GA21209@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220211>

When we report an http error code, we say something like:

  error: The requested URL reported failure: 403 Forbidden while accessing http://example.com/repo.git

Everything between "error:" and "while" is written by curl,
and the resulting sentence is hard to read (especially
because there is no punctuation between curl's sentence and
the remainder of ours). Instead, let's re-order this to give
better flow:

  error: unable to access 'http://example.com/repo.git: The requested URL reported failure: 403 Forbidden

This is still annoyingly long, but at least reads more
clearly left to right.

Signed-off-by: Jeff King <peff@peff.net>
---
As I mentioned in the cover letter, I'm still not that excited about the
"after" result here. Suggestions welcome.

 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 5e6f67d..64068a2 100644
--- a/http.c
+++ b/http.c
@@ -943,7 +943,7 @@ void http_error(const char *url)
 
 void http_error(const char *url)
 {
-	error("%s while accessing %s", curl_errorstr, url);
+	error("unable to access '%s': %s", url, curl_errorstr);
 }
 
 int http_fetch_ref(const char *base, struct ref *ref)
-- 
1.8.2.rc0.33.gd915649
