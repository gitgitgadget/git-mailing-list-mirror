From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Use __VA_ARGS__ for all of error's arguments
Date: Fri,  8 Feb 2013 07:09:28 -0800
Message-ID: <1360336168-27740-1-git-send-email-kraai@ftbfs.org>
References: <20130208043915.GB4525@ftbfs.org>
Cc: Matt Kraai <matt.kraai@amo.abbott.com>
To: git@vger.kernel.org, Max Horn <max@quendi.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 16:10:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3paS-0001NW-1O
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 16:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946398Ab3BHPJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 10:09:36 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:55850 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945976Ab3BHPJf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 10:09:35 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1U3pa0-0007E8-8b; Fri, 08 Feb 2013 07:09:32 -0800
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <20130208043915.GB4525@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215774>

From: Matt Kraai <matt.kraai@amo.abbott.com>

QNX 6.3.2 uses GCC 2.95.3 by default, and GCC 2.95.3 doesn't remove the
comma if the error macro's variable argument is left out.

Instead of testing for a sufficiently recent version of GCC, make
__VA_ARGS__ match all of the arguments.

Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
---
 git-compat-util.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index cc2abee..b7eaaa9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -305,13 +305,13 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
 
 /*
  * Let callers be aware of the constant return value; this can help
- * gcc with -Wuninitialized analysis. We have to restrict this trick to
- * gcc, though, because of the variadic macro and the magic ## comma pasting
- * behavior. But since we're only trying to help gcc, anyway, it's OK; other
- * compilers will fall back to using the function as usual.
+ * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
+ * because some compilers may not support variadic macros. Since we're only
+ * trying to help gcc, anyway, it's OK; other compilers will fall back to
+ * using the function as usual.
  */
 #if defined(__GNUC__) && ! defined(__clang__)
-#define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
+#define error(...) (error(__VA_ARGS__), -1)
 #endif
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
-- 
1.8.1.2.546.g90a97a4
