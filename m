From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: [PATCH] make git compile on old version of engarde linux
Date: Mon, 7 Aug 2006 23:26:10 +0300
Message-ID: <20060807202610.GB24206@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 07 22:24:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GABeI-0001gk-Fa
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 22:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWHGUY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 16:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWHGUYZ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 16:24:25 -0400
Received: from mxl145v66.mxlogic.net ([208.65.145.66]:8133 "EHLO
	p02c11o143.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751044AbWHGUYX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 16:24:23 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 771a7d44.2491534256.6760.00-004.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 07 Aug 2006 14:24:23 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 7 Aug 2006 23:30:16 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon,  7 Aug 2006 23:26:10 +0300
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 07 Aug 2006 20:30:16.0750 (UTC) FILETIME=[4B2CECE0:01C6BA60]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25040>

The following makes git build on my instance of Engarde Linux 1.x

The definition of S_IFLNK and S_ISLNK seems to be mising in the headers,
but a simple test showed that the correct value for it is still 0120000,
same as on more modern systems.

With this patch, git built with 
$make NO_CURL=1 NO_SYMLINK_HEAD=1 NO_PYTHON=1
seems to work with no issues so far (more than a week now).

---

Make git build on Engarde Linux 1.x (which is missing
the definition for S_IFLNK/S_ISLNK)

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

--- git/cache.h.orig	Thu Jun 29 11:43:45 2006
+++ git/cache.h	Thu Jun 29 11:45:13 2006
@@ -6,6 +6,13 @@
 #include SHA1_HEADER
 #include <zlib.h>
 
+#ifndef S_IFLNK
+#define S_IFLNK        0120000
+#endif
+#ifndef S_ISLNK
+#define S_ISLNK(m)    (((m) & S_IFMT) == S_IFLNK)
+#endif
+
 #if ZLIB_VERNUM < 0x1200
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif

-- 
MST
