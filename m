From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] t/lib-httpd/apache.conf: do not use LockFile in apache
 >= 2.4
Date: Sun, 9 Jun 2013 04:07:59 -0400
Message-ID: <20130609080759.GA32139@sigill.intra.peff.net>
References: <20130609080722.GA31699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 10:08:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulafe-0003LR-5r
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 10:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab3FIIIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 04:08:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:33128 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab3FIIIC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 04:08:02 -0400
Received: (qmail 21496 invoked by uid 102); 9 Jun 2013 08:08:51 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 03:08:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 04:07:59 -0400
Content-Disposition: inline
In-Reply-To: <20130609080722.GA31699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226944>

The LockFile directive from earlier versions of apache has
been replaced by the Mutex directive. The latter seems to
give sane defaults and does not need any specific
customization, so we can get away with just adding a version
check to the use of LockFile.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/apache.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index b5bce45..38699bb 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -1,5 +1,7 @@ LockFile accept.lock
 ServerName dummy
+<IfVersion < 2.4>
 LockFile accept.lock
+</IfVersion>
 PidFile httpd.pid
 DocumentRoot www
 LogFormat "%h %l %u %t \"%r\" %>s %b" common
-- 
1.8.3.rc2.14.g7eee6b3
