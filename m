From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v8 1/3] tests: adjust the configuration for Apache 2.2
Date: Tue, 10 May 2016 09:08:27 +0200 (CEST)
Message-ID: <10a0848e281bf8595c78d4e9f9a770fea9bc6ba8.1462863934.git.johannes.schindelin@gmx.de>
References: <cover.1462774709.git.johannes.schindelin@gmx.de> <cover.1462863934.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 09:08:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01mc-0003nI-7z
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 09:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbcEJHIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 03:08:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:63618 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbcEJHIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 03:08:39 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LynHb-1bezPf4Azf-016ATY; Tue, 10 May 2016 09:08:29
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462863934.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:vQHtKvxugnrL2FsXFq7tzFQaIadM6kWIcmTbRfO6TKHlVTclhUT
 VuljJnh191Uv7nMS/vxjUDIRWGJBuoaZ7Q1Cr0SqOvz2z/k1XakOQuY2+lk99/QqEuowYoO
 2C8iMpvkhBHHUSSy8rdlwupLfEwAILhlPeeeaLTnWumuSjw/s0EzJRySqJaDpGFHAb1n50P
 UyI+BchI5APVXNDPevwOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GlRxAEed6OM=:oiAQXqcVueEOBGFS5v9/qq
 XtaLBYpvtn+Jvfj2T3vSItiU4+n1F40bm/s19Z5g1wJtBbHvNQs0rMjLm+J8DqpJCpfesaSmc
 civ2hCfCreuFwn9MEQbttiO7L1W3tZzVF4abFBQLYTcNVV9zGLbyRRQkIjMZV83fc9vxezath
 QhsK+SrTY1ASZWT+x1Fz4pWfDp50XwLuahv8dh4vaTfZ5O15SySeEcPlhOidDq3r4OU8mkeoT
 gu/Kh/WI5esVOzIjRttXFhP8nNs6cnKXf0K0Zuv4uyD6AvUzr8g3xKZctJS08gG+QrIwpRn6T
 GY3yfqSOfPHoMxKB3r2VbNqYlKOeavC1b3VA41Rx/HGK1l/c0huJOK+7kuG6YfXnOQ6JTMdGe
 j6KvURmAjuhZh5jQ7H//SizLWMSthRW3TbG4rDVkUVx3CEDCqaAJg8xj9+KlN73X8JFLqHyfY
 UsTDrP86mxjXx/48gm4gGf1MWVVLc8+CkeZB2FLUlGzYLNtQQaaf3JleVIIWao5r7yXMOZxwA
 FGvoTnvk2QjWYizr1W1I0CiKDwhaNqxdvvnmooHa9QQG/paYPisGUPXLGbGsfa9eijQIkWruc
 aSFPuajykHuPSIZnCV6U2c4suiuivXyY56CeqTWkJa+YtAbsxmdrSqZzZcwoiP5ODlpHJiWCg
 7ONkV28Ll6N1uGxEkk9/jbAEEci3HhrrScwWfv4m9Yz9JqJKjsdIuMTCkjGe3J2ZzopKcu4Th
 T0wVcnMoIc541x3f3PBBh9XlTDNwB3506RMLdUn4Gpl0XHqZtemCnAMZZir/O26Wz6I8VTXE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294104>

Lars Schneider noticed that the configuration introduced to test the
extra HTTP headers cannot be used with Apache 2.2 (which is still
actively maintained, as pointed out by Junio Hamano).

To let the tests pass with Apache 2.2 again, let's substitute the
offending <RequireAll> and `expr` by using old school RewriteCond
statements.

As RewriteCond does not allow testing for *non*-matches, we simply match
the desired case first and let it pass by marking the RewriteRule as
'[L]' ("last rule, do not process any other matching RewriteRules after
this"), and then have another RewriteRule that matches all other cases
and lets them fail via '[F]' ("fail").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-httpd/apache.conf | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index b8ed96f..018a83a 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -103,10 +103,6 @@ Alias /auth/dumb/ www/auth/dumb/
 	Header set Set-Cookie name=value
 </LocationMatch>
 <LocationMatch /smart_headers/>
-	<RequireAll>
-		Require expr %{HTTP:x-magic-one} == 'abra'
-		Require expr %{HTTP:x-magic-two} == 'cadabra'
-	</RequireAll>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
@@ -136,6 +132,18 @@ RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
 RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302]
 RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
 
+# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
+# And as RewriteCond does not allow testing for non-matches, we match
+# the desired case first (one has abra, two has cadabra), and let it
+# pass by marking the RewriteRule as [L], "last rule, do not process
+# any other matching RewriteRules after this"), and then have another
+# RewriteRule that matches all other cases and lets them fail via '[F]',
+# "fail the request".
+RewriteCond %{HTTP:x-magic-one} =abra
+RewriteCond %{HTTP:x-magic-two} =cadabra
+RewriteRule ^/smart_headers/.* - [L]
+RewriteRule ^/smart_headers/.* - [F]
+
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
 
-- 
2.8.2.463.g99156ee
