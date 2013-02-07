From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Use __VA_ARGS__ for all of error's arguments
Date: Thu,  7 Feb 2013 12:00:38 -0800
Message-ID: <1360267238-21896-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <matt.kraai@amo.abbott.com>
To: git@vger.kernel.org, Max Horn <max@quendi.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 21:01:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Xf0-0004al-Pd
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 21:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759174Ab3BGUA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 15:00:59 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:55483 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756283Ab3BGUA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 15:00:59 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1U3XeQ-0005ht-PA; Thu, 07 Feb 2013 12:00:54 -0800
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215720>

From: Matt Kraai <matt.kraai@amo.abbott.com>

QNX 6.3.2 uses GCC 2.95.3 by default, and GCC 2.95.3 doesn't remove the
comma if the error macro's variable argument is left out.

Instead of testing for a sufficiently recent version of GCC, make
__VA_ARGS__ match all of the arguments.  Since this should work on any
C99-compliant compiler, also remove the tests around the macro definition.

Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
---
 git-compat-util.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index cc2abee..df1681f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -305,14 +305,9 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
 
 /*
  * Let callers be aware of the constant return value; this can help
- * gcc with -Wuninitialized analysis. We have to restrict this trick to
- * gcc, though, because of the variadic macro and the magic ## comma pasting
- * behavior. But since we're only trying to help gcc, anyway, it's OK; other
- * compilers will fall back to using the function as usual.
+ * gcc with -Wuninitialized analysis.
  */
-#if defined(__GNUC__) && ! defined(__clang__)
-#define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
-#endif
+#define error(...) (error(__VA_ARGS__), -1)
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
-- 
1.8.1.GIT
