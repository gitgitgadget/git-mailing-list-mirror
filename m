From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 3/5] nedmalloc: allow compiling with MSys2's compiler
Date: Thu, 14 Jan 2016 17:51:54 +0100 (CET)
Message-ID: <0436c74f0fcd46d9a77a3012d146d741ca2c7a0a.1452790142.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de> <cover.1452790142.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 17:52:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJl81-00053K-Un
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbcANQv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:51:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:55246 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbcANQv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:51:58 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MLA45-1aJU8z0KqP-000I52; Thu, 14 Jan 2016 17:51:56
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452790142.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:uAjWm/akWwSzw7818C+SlOnwejzIXh5QcO2Y7VdLp3pNaaVKIS1
 9+oDHOWQViQJLnWzFDzr5kxoGz3MijH5MoNx+QkLvuL9dltKLrjt6HxdsifZVG76Wjobb6O
 0V2lm89n2Zl1oF4hTvWVxjCxhhqbcADSc7TCjWMhh+WHdDDK3mJ6RfYkfoLKEhrqIrrzOcF
 8L+9n0BvAi+cFbgCF73Ng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MlezF3bB0VE=:Yzo9bBaZYYjFSY+gJV2wGm
 UFcHxKWrgW95DwSX+hsWJ/+0G3mnK2Qbg9hqkJYtw2YJ0g/af3E/AgdtkZ556NQzaffMTSRpH
 +usUs+DOUnXYUueLETyMH4JW7vJm4dptpRXc+Ja4Zl7Xo3p7aBPDzzlmPuCtxSf0/zZGEaX9f
 eR828/VzIhZoxfwlCZqjpKcM/c3oLdMRFCfQcVSGAFLs/tmnrLZsvla039uzfOc0QyXhpUQdA
 TQ14wv3CkWFcBuk0jygf14WyJW7EBgqCxi46kcB3NMH3XjtZHbL5mJZNQujS1O6SI4GdUaS7T
 WJmRX/WQs0Cr+eCPr4wVWogrMtPXT9CQ9bUHv0+gagndYiRvt1s02r2ShWzlHMAjnVU1Dc5gR
 eYrbpIeYB25nusUQHAF4dzQzClU9H2hDpaRJiIILo4eCkpuQuUByZVCWMXbdQRgies5yWxVGg
 bCpa+p8ZtMxVNR6ByBILGUUTpFEc8GLJ+QO+5FgQLMwP5+/UwxsDy6+KkbbZh2xgSRBYStKEm
 VzDuTXLU4FfsAFtz01LgOUtv5B99UXb2X+/DZEOeD9mT4JysiVKEwIw1PG82teyHf64mPESkr
 0q2zz67xhtXKjGKjkooyFjAVjOgk27I/I6bi13vfBuGUa3toEQmqkyLx35bUv5hcO6ceIvxK7
 C1POS9o5m0MasoNS2Q4fakYE2lTZP6I0cKu3zGbNeIxqBBih7GJpNY+BQUNNFKCNx9V+o1ECM
 XOYIwPjr6UUBjgYHjswnu4NLEfIVyvVzi3TKWO58fbq7LvW+BrcTgi2BWy2EzZ9caLq3THlo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284063>

With MSys2's GCC, `ReadWriteBarrier` is already defined, and FORCEINLINE
unfortunately gets defined incorrectly.

Let's work around both problems, using the MSys2-specific
__MINGW64_VERSION_MAJOR constant to guard the FORCEINLINE definition so
as not to affect other platforms.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/nedmalloc/malloc.c.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index f216a2a..bf70037 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -720,6 +720,9 @@ struct mallinfo {
   inlining are defined as macros, so these aren't used for them.
 */
 
+#ifdef __MINGW64_VERSION_MAJOR
+#undef FORCEINLINE
+#endif
 #ifndef FORCEINLINE
   #if defined(__GNUC__)
 #define FORCEINLINE __inline __attribute__ ((always_inline))
@@ -1382,6 +1385,7 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
 
   /*** Atomic operations ***/
   #if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) > 40100
+    #undef _ReadWriteBarrier
     #define _ReadWriteBarrier() __sync_synchronize()
   #else
     static __inline__ __attribute__((always_inline)) long __sync_lock_test_and_set(volatile long * const Target, const long Value)
-- 
2.7.0.windows.1.7.g55a05c8
