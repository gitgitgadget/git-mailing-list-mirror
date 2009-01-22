From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/5] Windows: Fix signal numbers
Date: Thu, 22 Jan 2009 00:57:34 -0500
Message-ID: <20090122055734.GA30133@coredump.intra.peff.net>
References: <20090122042643.GB31427@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 06:59:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPsak-0005ri-LD
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 06:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbZAVF5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 00:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbZAVF5h
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 00:57:37 -0500
Received: from peff.net ([208.65.91.99]:38181 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941AbZAVF5g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 00:57:36 -0500
Received: (qmail 24394 invoked by uid 107); 22 Jan 2009 05:57:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 22 Jan 2009 00:57:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2009 00:57:34 -0500
Content-Disposition: inline
In-Reply-To: <20090122042643.GB31427@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106724>

From: Johannes Sixt <j6t@kdbg.org>

We had defined some SIG_FOO macros that appear in the code, but that are
not supported on Windows, in order to make the code compile.  But a
subsequent change will assert that a signal number is non-zero.  We now
use the signal numbers that are commonly used on POSIX systems.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jeff King <peff@peff.net>
---
This is necessary to avoid violating sigchain assertions in the next
patch.

 compat/mingw.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 4f275cb..a255898 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -21,12 +21,12 @@ typedef int pid_t;
 #define WEXITSTATUS(x) ((x) & 0xff)
 #define WIFSIGNALED(x) ((unsigned)(x) > 259)
 
-#define SIGKILL 0
-#define SIGCHLD 0
-#define SIGPIPE 0
-#define SIGHUP 0
-#define SIGQUIT 0
-#define SIGALRM 100
+#define SIGHUP 1
+#define SIGQUIT 3
+#define SIGKILL 9
+#define SIGPIPE 13
+#define SIGALRM 14
+#define SIGCHLD 17
 
 #define F_GETFD 1
 #define F_SETFD 2
-- 
1.6.1.403.g6c435
