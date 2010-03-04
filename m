From: YONETANI Tomokazu <qhwt+git@les.ath.cx>
Subject: [PATCH] Fix _XOPEN_SOURCE problem on DragonFly
Date: Thu, 4 Mar 2010 11:05:22 +0900
Message-ID: <20100304020522.GA76036@les.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 03:18:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn0dt-0004Bp-0U
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 03:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab0CDCSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 21:18:20 -0500
Received: from x219233.ppp.asahi-net.or.jp ([122.249.219.233]:2937 "EHLO
	les.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755714Ab0CDCSS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 21:18:18 -0500
X-Greylist: delayed 773 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2010 21:18:18 EST
Received: by les.ath.cx (Postfix, from userid 1000)
	id B65D186654; Thu,  4 Mar 2010 11:05:22 +0900 (JST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141507>

Hi.
DragonFly has the same problem that FreeBSD used to have.  Since the
return value of implicitly declared functions defaults to int, it can
cause disasters on architectures where sizeof(int) < sizeof(void *).
The patch below should address this issue.

Best regards,
YONETANI Tomokazu.

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
