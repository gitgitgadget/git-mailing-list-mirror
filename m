From: Rocco Rutte <pdmef@gmx.net>
Subject: [PATCH] Don't define _XOPEN_SOURCE to unbreak compilation on FreeBSD
Date: Thu, 21 Dec 2006 10:47:28 +0000
Message-ID: <11666980484010-git-send-email-pdmef@gmx.net>
Cc: Rocco Rutte <pdmef@gmx.net>
X-From: git-owner@vger.kernel.org Thu Dec 21 11:47:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxLSn-0001S3-PM
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 11:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbWLUKrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 05:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbWLUKrq
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 05:47:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:40013 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752313AbWLUKrp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 05:47:45 -0500
Received: (qmail invoked by alias); 21 Dec 2006 10:47:44 -0000
Received: from cable-62-117-26-66.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.26.66]
  by mail.gmx.net (mp030) with SMTP; 21 Dec 2006 11:47:44 +0100
X-Authenticated: #1642131
Received: from robert.daprodeges.fqdn.th-h.de (robert.daprodeges.fqdn.th-h.de [192.168.0.113])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP
	id 2CA7E20F16; Thu, 21 Dec 2006 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by robert.daprodeges.fqdn.th-h.de (Postfix) with ESMTP
	id EAEBC33FF6; Thu, 21 Dec 2006 10:47:28 +0000 (UTC)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.2.g9474f
In-Reply-To: 7vk60lbnvj.fsf@assigned-by-dhcp.cox.net
References: 7vk60lbnvj.fsf@assigned-by-dhcp.cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35049>

FreeBSD 6 requires the __BSD_VISIBLE flag for fchmod(), IPPROTO_IPV6 and
more which is only properly set by <sys/cdefs.h> if _POSIX_C_SOURCE
isn't present. However, _POSIX_C_SOURCE is defined if _XOPEN_SOURCE is
defined and >=500.

As a solution, simply don't define _XOPEN_SOURCE for FreeBSD and continue
with its defaults.

Signed-off-by: Rocco Rutte <pdmef@gmx.net>
---
 git-compat-util.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bc296b3..27d3b89 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -11,7 +11,12 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
-#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#if !defined(__FreeBSD__)
+#define _XOPEN_SOURCE 600        /* glibc2 and AIX 5.3L need 500,
+                                  * OpenBSD needs 600 for S_ISLNK(),
+                                  * FreeBSD 6 doesn't like it
+                                  */
+#endif
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #define _GNU_SOURCE
 #define _BSD_SOURCE
-- 
1.4.4.2.g9474f
