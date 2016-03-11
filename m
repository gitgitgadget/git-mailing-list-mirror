From: Jeff King <peff@peff.net>
Subject: [PATCH v2 01/10] setup: document check_repository_format()
Date: Fri, 11 Mar 2016 17:36:45 -0500
Message-ID: <20160311223645.GA449@sigill.intra.peff.net>
References: <20160311223620.GA7963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 23:36:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeVfw-0003fK-H2
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 23:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbcCKWgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 17:36:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:58641 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932397AbcCKWgs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 17:36:48 -0500
Received: (qmail 20893 invoked by uid 102); 11 Mar 2016 22:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:36:47 -0500
Received: (qmail 7429 invoked by uid 107); 11 Mar 2016 22:37:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Mar 2016 17:37:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2016 17:36:45 -0500
Content-Disposition: inline
In-Reply-To: <20160311223620.GA7963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288709>

This function's interface is rather enigmatic, so let's
document it further.

While we're here, let's also drop the return value. It will
always either be "0" or the function will die (consequently,
neither of its two callers bothered to check the return).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h | 9 ++++++++-
 setup.c | 4 ++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index b829410..02e38d1 100644
--- a/cache.h
+++ b/cache.h
@@ -747,7 +747,14 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_version;
 extern int repository_format_precious_objects;
-extern int check_repository_format(void);
+
+/*
+ * Check the repository format version in the path found in get_git_dir(),
+ * and die if it is a version we don't understand. Generally one would
+ * set_git_dir() before calling this, and use it only for "are we in a valid
+ * repo?".
+ */
+extern void check_repository_format(void);
 
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
diff --git a/setup.c b/setup.c
index de1a2a7..b2f2e69 100644
--- a/setup.c
+++ b/setup.c
@@ -982,9 +982,9 @@ int check_repository_format_version(const char *var, const char *value, void *cb
 	return 0;
 }
 
-int check_repository_format(void)
+void check_repository_format(void)
 {
-	return check_repository_format_gently(get_git_dir(), NULL);
+	check_repository_format_gently(get_git_dir(), NULL);
 }
 
 /*
-- 
2.8.0.rc2.328.g39e2a47
