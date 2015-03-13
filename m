From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] t: pass GIT_TRACE through Apache
Date: Fri, 13 Mar 2015 00:51:15 -0400
Message-ID: <20150313045114.GE18532@peff.net>
References: <20150313044101.GA18476@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 05:51:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWHZD-0001Fy-Lf
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 05:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbbCMEvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 00:51:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:60821 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750806AbbCMEvR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 00:51:17 -0400
Received: (qmail 30870 invoked by uid 102); 13 Mar 2015 04:51:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 23:51:17 -0500
Received: (qmail 9558 invoked by uid 107); 13 Mar 2015 04:51:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 00:51:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2015 00:51:15 -0400
Content-Disposition: inline
In-Reply-To: <20150313044101.GA18476@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265396>

Apache removes GIT_TRACE from the environment before running
git-http-backend. This can make it hard to debug the server
side of an http session. Let's let it through.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh          | 1 +
 t/lib-httpd/apache.conf | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d154d1e..e6adf2f 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -79,6 +79,7 @@ HTTPD_DOCUMENT_ROOT_PATH=$HTTPD_ROOT_PATH/www
 # hack to suppress apache PassEnv warnings
 GIT_VALGRIND=$GIT_VALGRIND; export GIT_VALGRIND
 GIT_VALGRIND_OPTIONS=$GIT_VALGRIND_OPTIONS; export GIT_VALGRIND_OPTIONS
+GIT_TRACE=$GIT_TRACE; export GIT_TRACE
 
 if ! test -x "$LIB_HTTPD_PATH"
 then
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 03a4c2e..0b81a00 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -70,6 +70,7 @@ PassEnv GIT_VALGRIND
 PassEnv GIT_VALGRIND_OPTIONS
 PassEnv GNUPGHOME
 PassEnv ASAN_OPTIONS
+PassEnv GIT_TRACE
 
 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
-- 
2.3.2.472.geadab3c
