From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] stub out getpass_echo function
Date: Sun, 27 Nov 2011 03:30:16 -0500
Message-ID: <20111127083016.GC1702@sigill.intra.peff.net>
References: <20111127082744.GA32068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 09:30:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUa7z-00034d-Ke
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 09:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab1K0IaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 03:30:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53665
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857Ab1K0IaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 03:30:18 -0500
Received: (qmail 13122 invoked by uid 107); 27 Nov 2011 08:36:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 27 Nov 2011 03:36:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2011 03:30:16 -0500
Content-Disposition: inline
In-Reply-To: <20111127082744.GA32068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185973>

We can't implement getpass_echo portably, but we can at
least put in the infrastructure so that builds can provide a
system-specific way of accomplishing this.

Right now we just fall back on calling getpass (which
doesn't echo, but is available almost everywhere).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile         |    2 ++
 compat/getpass.c |    6 ++++++
 compat/getpass.h |    6 ++++++
 3 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 compat/getpass.c
 create mode 100644 compat/getpass.h

diff --git a/Makefile b/Makefile
index 14c6480..d133e2b 100644
--- a/Makefile
+++ b/Makefile
@@ -521,6 +521,7 @@ LIB_H += color.h
 LIB_H += commit.h
 LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
+LIB_H += compat/getpass.h
 LIB_H += compat/mingw.h
 LIB_H += compat/obstack.h
 LIB_H += compat/win32/pthread.h
@@ -609,6 +610,7 @@ LIB_OBJS += cache-tree.o
 LIB_OBJS += color.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
+LIB_OBJS += compat/getpass.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += config.o
 LIB_OBJS += connect.o
diff --git a/compat/getpass.c b/compat/getpass.c
new file mode 100644
index 0000000..8ae82f0
--- /dev/null
+++ b/compat/getpass.c
@@ -0,0 +1,6 @@
+#include "../git-compat-util.h"
+
+char *getpass_echo(const char *prompt)
+{
+	return getpass(prompt);
+}
diff --git a/compat/getpass.h b/compat/getpass.h
new file mode 100644
index 0000000..5f1986b
--- /dev/null
+++ b/compat/getpass.h
@@ -0,0 +1,6 @@
+#ifndef GETPASS_H
+#define GETPASS_H
+
+char *getpass_echo(const char *prompt);
+
+#endif /* GETPASS_H */
-- 
1.7.7.4.7.g24824
