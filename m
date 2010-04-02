From: YONETANI Tomokazu <y0netan1@dragonflybsd.org>
Subject: [PATCH] Fix _XOPEN_SOURCE problem on DragonFly
Date: Fri, 2 Apr 2010 16:52:09 +0900
Message-ID: <20100402075209.GA53099@les.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 10:01:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxbpC-0002PP-Jw
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 10:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334Ab0DBIBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 04:01:33 -0400
Received: from x219233.ppp.asahi-net.or.jp ([122.249.219.233]:4269 "EHLO
	les.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756704Ab0DBIBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 04:01:31 -0400
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Apr 2010 04:01:30 EDT
Received: by les.ath.cx (Postfix, from userid 1000)
	id 89B1786654; Fri,  2 Apr 2010 16:52:09 +0900 (JST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143793>

As on FreeBSD, defining _XOPEN_SOURCE to 600 on DragonFly BSD 2.4-RELEASE
or later hides symbols from programs, which leads to implicit declaration
of functions, making the return value to be assumed an int.  On architectures
where sizeof(int) < sizeof(void *), this can cause unexpected behaviors or
crashes.
This change won't affect other OSes unless they define __DragonFly__ macro,
or older versions of DragonFly BSD as the current git code doesn't rely on
the features only available with _XOPEN_SOURCE set to 600 on DragonFly.

Signed-off-by: YONETANI Tomokazu <y0netan1@dragonflybsd.org>
---
 git-compat-util.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a3c4537..e292926 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -55,7 +55,8 @@
 # else
 # define _XOPEN_SOURCE 500
 # endif
-#elif !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX) && !defined(sgi)
+#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
+      !defined(_M_UNIX) && !defined(sgi) && !defined(__DragonFly__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-- 
1.6.6.2
