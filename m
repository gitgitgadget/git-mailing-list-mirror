From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] t/lib-httpd/apache.conf: load compat access module in
 apache 2.4
Date: Sun, 9 Jun 2013 04:08:45 -0400
Message-ID: <20130609080845.GC32139@sigill.intra.peff.net>
References: <20130609080722.GA31699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 10:08:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlagI-0003ih-AQ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 10:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab3FIIIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 04:08:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:33137 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab3FIIIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 04:08:48 -0400
Received: (qmail 21575 invoked by uid 102); 9 Jun 2013 08:09:37 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 03:09:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 04:08:45 -0400
Content-Disposition: inline
In-Reply-To: <20130609080722.GA31699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226946>

In apache 2.4, the "Order" directive has gone away in favor
of a new system in mod_authz_host. However, since we want
our config file to remain compatible across multiple Apache
versions, we can use mod_access_compat to keep using the
older style.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/apache.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 1d3615b..4883b8c 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -54,6 +54,9 @@ ErrorLog error.log
 <IfModule !mod_authz_core.c>
 	LoadModule authz_core_module modules/mod_authz_core.so
 </IfModule>
+<IfModule !mod_access_compat.c>
+	LoadModule access_compat_module modules/mod_access_compat.so
+</IfModule>
 </IfVersion>
 
 PassEnv GIT_VALGRIND
-- 
1.8.3.rc2.14.g7eee6b3
