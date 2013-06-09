From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] t/lib-httpd/apache.conf: load extra auth modules in
 apache 2.4
Date: Sun, 9 Jun 2013 04:08:22 -0400
Message-ID: <20130609080822.GB32139@sigill.intra.peff.net>
References: <20130609080722.GA31699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 10:08:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulafv-0003Wt-RJ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 10:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab3FIII0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 04:08:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:33132 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab3FIIIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 04:08:25 -0400
Received: (qmail 21559 invoked by uid 102); 9 Jun 2013 08:09:14 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 03:09:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 04:08:22 -0400
Content-Disposition: inline
In-Reply-To: <20130609080722.GA31699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226945>

In apache 2.4, the "Auth*" and "Require" directives have
moved into the authn_core and authz_core modules,
respectively.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/apache.conf | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 38699bb..1d3615b 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -47,6 +47,15 @@ ErrorLog error.log
 </IfModule>
 </IfVersion>
 
+<IfVersion >= 2.4>
+<IfModule !mod_authn_core.c>
+	LoadModule authn_core_module modules/mod_authn_core.so
+</IfModule>
+<IfModule !mod_authz_core.c>
+	LoadModule authz_core_module modules/mod_authz_core.so
+</IfModule>
+</IfVersion>
+
 PassEnv GIT_VALGRIND
 PassEnv GIT_VALGRIND_OPTIONS
 
-- 
1.8.3.rc2.14.g7eee6b3
