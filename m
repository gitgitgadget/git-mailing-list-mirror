From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Fix compilation on newer NetBSD systems
Date: Thu, 11 May 2006 19:35:31 +0200
Message-ID: <20060511173531.G18d4553c@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 11 19:35:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeF4d-0007zx-18
	for gcvg-git@gmane.org; Thu, 11 May 2006 19:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWEKRfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 13:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWEKRfg
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 13:35:36 -0400
Received: from v345.ncsrv.de ([89.110.145.104]:63203 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1030391AbWEKRfg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 May 2006 13:35:36 -0400
Received: from leonov.stosberg.net (p213.54.91.79.tisdip.tiscali.de [213.54.91.79])
	by ncs.stosberg.net (Postfix) with ESMTP id 26C0DAEBA00A
	for <git@vger.kernel.org>; Thu, 11 May 2006 19:35:10 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id EC0E7F601E; Thu, 11 May 2006 19:35:31 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Thu, 11 May 2006 19:26:33 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19907>

NetBSD >=2.0 has iconv() in libc.  A libiconv is not required and
does not exist.

See: http://netbsd.gw.com/cgi-bin/man-cgi?iconv+3+NetBSD-2.0

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>

---

 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

2a73fcf43bfd1f73ec5e1e50396d54b83abae5e1
diff --git a/Makefile b/Makefile
index 37fbe78..26fa4e6 100644
--- a/Makefile
+++ b/Makefile
@@ -285,7 +285,9 @@ ifeq ($(uname_S),OpenBSD)
 	ALL_LDFLAGS += -L/usr/local/lib
 endif
 ifeq ($(uname_S),NetBSD)
-	NEEDS_LIBICONV = YesPlease
+	ifeq ($(shell test `uname -r | sed -e 's/^\([0-9]\).*/\1/'` -lt 2 && echo y),y)
+		NEEDS_LIBICONV = YesPlease
+	endif
 	ALL_CFLAGS += -I/usr/pkg/include
 	ALL_LDFLAGS += -L/usr/pkg/lib -Wl,-rpath,/usr/pkg/lib
 endif
-- 
1.3.2.gbe65
