From: Jeff King <peff@peff.net>
Subject: [PATCH 9/9] http: drop http_error function
Date: Fri, 5 Apr 2013 18:22:31 -0400
Message-ID: <20130405222231.GI22163@sigill.intra.peff.net>
References: <20130405221331.GA21209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:48:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQh-0001b9-2x
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163039Ab3DEWWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:22:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58258 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163034Ab3DEWWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:22:40 -0400
Received: (qmail 18469 invoked by uid 107); 5 Apr 2013 22:24:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 18:24:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 18:22:31 -0400
Content-Disposition: inline
In-Reply-To: <20130405221331.GA21209@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220234>

This function is a single-liner and is only called from one
place. Just inline it, which makes the code more obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a cleanup made possible by the previous patch.

 http-push.c | 2 +-
 http.c      | 5 -----
 http.h      | 5 -----
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/http-push.c b/http-push.c
index 439a555..395a8cf 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1551,7 +1551,7 @@ static int remote_exists(const char *path)
 		ret = 0;
 		break;
 	case HTTP_ERROR:
-		http_error(url);
+		error("unable to access '%s': %s", url, curl_errorstr);
 	default:
 		ret = -1;
 	}
diff --git a/http.c b/http.c
index 64068a2..58c063c 100644
--- a/http.c
+++ b/http.c
@@ -941,11 +941,6 @@ cleanup:
 	return ret;
 }
 
-void http_error(const char *url)
-{
-	error("unable to access '%s': %s", url, curl_errorstr);
-}
-
 int http_fetch_ref(const char *base, struct ref *ref)
 {
 	char *url;
diff --git a/http.h b/http.h
index fa65128..4dc5353 100644
--- a/http.h
+++ b/http.h
@@ -135,11 +135,6 @@ int http_get_strbuf(const char *url, struct strbuf *content_type, struct strbuf
  */
 int http_get_strbuf(const char *url, struct strbuf *content_type, struct strbuf *result, int options);
 
-/*
- * Prints an error message using error() containing url and curl_errorstr.
- */
-void http_error(const char *url);
-
 extern int http_fetch_ref(const char *base, struct ref *ref);
 
 /* Helpers for fetching packs */
-- 
1.8.2.rc0.33.gd915649
