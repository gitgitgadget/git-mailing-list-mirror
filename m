From: Jeff King <peff@peff.net>
Subject: [PATCH 01/17] cache.h: clarify documentation for git_path, et al
Date: Mon, 10 Aug 2015 05:32:07 -0400
Message-ID: <20150810093207.GA30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:32:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjRJ-0002Z7-Et
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbbHJJcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:32:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:42799 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753754AbbHJJcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:32:12 -0400
Received: (qmail 30729 invoked by uid 102); 10 Aug 2015 09:32:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:32:12 -0500
Received: (qmail 3006 invoked by uid 107); 10 Aug 2015 09:32:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:32:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:32:07 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275567>

The comment above these functions actually describes
sha1_file_name, and comes from the very first revision of
git. Commit 723c31f (Add "git_path()" and "head_ref()"
helper functions., 2005-07-05) added git_path, pushing the
comment away from the function it describes; later commits
added more functions in this block.

Let's fix the comment to describe these related functions in
more detail. Let's also make sure to point out their safer
alternatives (and move those alternatives below, which makes
more sense when reading the file).

Note that we do not need to move the existing comment to
sha1_file_name.  Commit d40d535 (sha1_file.c: document a
bunch of functions defined in the file, 2014-02-21) already
added a much more descriptive comment to it.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 6bb7119..8db884e 100644
--- a/cache.h
+++ b/cache.h
@@ -708,6 +708,18 @@ extern int check_repository_format(void);
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
+/*
+ * Return a statically allocated filename, either generically (mkpath), in
+ * the repository directory (git_path), or in a submodule's repository
+ * directory (git_path_submodule). In all cases, note that the result
+ * may be overwritten by another call to _any_ of the functions. Consider
+ * using the safer "dup" or "strbuf" formats below.
+ */
+extern const char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern const char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern const char *git_path_submodule(const char *path, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+
 extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
@@ -717,11 +729,6 @@ extern char *git_pathdup(const char *fmt, ...)
 extern char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
-/* Return a statically allocated filename matching the sha1 signature */
-extern const char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern const char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern const char *git_path_submodule(const char *path, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
 extern void report_linked_checkout_garbage(void);
 
 /*
-- 
2.5.0.414.g670f2a4
