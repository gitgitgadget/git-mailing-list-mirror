From: Jeff King <peff@peff.net>
Subject: [PATCH 10/17] path.c: drop git_path_submodule
Date: Mon, 10 Aug 2015 05:36:27 -0400
Message-ID: <20150810093627.GJ30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:36:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjVU-0004kw-EE
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbbHJJgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:36:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:42840 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753421AbbHJJgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:36:32 -0400
Received: (qmail 30978 invoked by uid 102); 10 Aug 2015 09:36:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:36:32 -0500
Received: (qmail 3186 invoked by uid 107); 10 Aug 2015 09:36:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:36:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:36:27 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275575>

There are no callers of the slightly-dangerous static-buffer
git_path_submodule left. Let's drop it.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |  5 ++---
 path.c  | 10 ----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 6f74f33..7a4fa90 100644
--- a/cache.h
+++ b/cache.h
@@ -713,12 +713,11 @@ extern int check_repository_format(void);
  * the repository directory (git_path), or in a submodule's repository
  * directory (git_path_submodule). In all cases, note that the result
  * may be overwritten by another call to _any_ of the functions. Consider
- * using the safer "dup" or "strbuf" formats below.
+ * using the safer "dup" or "strbuf" formats below (in some cases, the
+ * unsafe versions have already been removed).
  */
 extern const char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern const char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern const char *git_path_submodule(const char *path, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
 
 extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
diff --git a/path.c b/path.c
index 9aad9a1..94d7ec2 100644
--- a/path.c
+++ b/path.c
@@ -245,16 +245,6 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 	strbuf_cleanup_path(buf);
 }
 
-const char *git_path_submodule(const char *path, const char *fmt, ...)
-{
-	va_list args;
-	struct strbuf *buf = get_pathname();
-	va_start(args, fmt);
-	do_submodule_path(buf, path, fmt, args);
-	va_end(args);
-	return buf->buf;
-}
-
 char *git_pathdup_submodule(const char *path, const char *fmt, ...)
 {
 	va_list args;
-- 
2.5.0.414.g670f2a4
