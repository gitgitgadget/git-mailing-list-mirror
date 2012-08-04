From: Jeff King <peff@peff.net>
Subject: [PATCH 2/8] map: add helper functions for objects as keys
Date: Sat, 4 Aug 2012 13:10:47 -0400
Message-ID: <20120804171047.GB19378@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:10:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxhsN-0002vd-GM
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 19:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791Ab2HDRKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 13:10:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51676 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612Ab2HDRKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 13:10:49 -0400
Received: (qmail 1957 invoked by uid 107); 4 Aug 2012 17:10:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Aug 2012 13:10:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2012 13:10:47 -0400
Content-Disposition: inline
In-Reply-To: <20120804170905.GA19267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202883>

These functions can be used as HASH and KEY_EQUAL functions
when defining new maps with "struct object *" as their key.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile     |  1 +
 map-object.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 map-object.h

diff --git a/Makefile b/Makefile
index d512f27..1d29a95 100644
--- a/Makefile
+++ b/Makefile
@@ -633,6 +633,7 @@ LIB_H += map-decl.h
 LIB_H += map-done.h
 LIB_H += map-impl.h
 LIB_H += map-init.h
+LIB_H += map-object.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
 LIB_H += mergesort.h
diff --git a/map-object.h b/map-object.h
new file mode 100644
index 0000000..4f98413
--- /dev/null
+++ b/map-object.h
@@ -0,0 +1,19 @@
+#ifndef MAP_OBJECT_H
+#define MAP_OBJECT_H
+
+#include "object.h"
+
+static unsigned int hash_obj(const struct object *obj, unsigned int n)
+{
+	unsigned int hash;
+
+	memcpy(&hash, obj->sha1, sizeof(unsigned int));
+	return hash % n;
+}
+
+static int obj_equal(const struct object *a, const struct object *b)
+{
+	return a == b;
+}
+
+#endif /* MAP_OBJECT_H */
-- 
1.7.12.rc1.7.g7a223a6
