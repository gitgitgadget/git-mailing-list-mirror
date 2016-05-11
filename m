From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] Windows: only add a no-op pthread_sigmask() when needed
Date: Wed, 11 May 2016 17:10:30 +0200 (CEST)
Message-ID: <446e1cd65673e4bcf1aa8ec6e05cd7b361762119.1462979365.git.johannes.schindelin@gmx.de>
References: <26c2fb5560246fc7f980da24a239edc333864527.1462885167.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 17:10:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Vmc-0003sX-IQ
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 17:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbcEKPKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 11:10:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:53706 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbcEKPKg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 11:10:36 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LjZn2-1bc2ST0BI0-00bYx6; Wed, 11 May 2016 17:10:29
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <26c2fb5560246fc7f980da24a239edc333864527.1462885167.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:45qQV4acMJQc9aCRynXw7/doa2GvTzK14a5RWde5kxfQ6co2YKS
 sdMSFY8K3Z7mIM6ZKEjgMu/ZuMZAQfU8zjOwKkB6s1j768nIlww3wReRaZCovGPEzaMSFXI
 8csut9GXtf/mgO8McX2r4uQbw9/9fPb0JvBsKexa9vjY5L8TKDGMf36bvvulpqvUrgWZWvD
 Dj/sOVnMxaIKBZvnDUpvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hIv3OsBusvA=:LviRe7lpybYQlMqOkxe92B
 Jps4/ntpiyDca3IFVqZf7u5qOzZjhxM28e4JmOTmjvtkCDeiZDSKQA3jrfcvtZw7E7ZjLbrNq
 UtIuoOVW2SqeGPafHBBWnsGwj3Q8D/BZN3jjdTLTpbYeOzcafzYYOZS8E8Vr6B8RUTi4Q7a88
 qJJbc4j8HqOH+oiQzpCC7zcpblgtnSNUWcvQgy7ILVrkNFWgaPrVP+tKO+cvSZUHKIWrQkteM
 AkcnKZjYBjZNOBCXTFlhjuJA2uZ7MnRORNKRVLKQzW0krqw7T4DGHoAYKecH9UG6ii1js5c5F
 W7SVZSZ42hx0uY2lrbcV4PCYvho5f8jKq8O9Rv5C/tPxh9r3Bm04vpPPCvhRjPJfzN62liHOY
 6tdQfaXBeeIzGJhFdmREk64AZYG17QlnMr/iQzUdfWv3w1JXFdSDftyzIyRwssipafne2RtDs
 lpiF+8crOvTnH8jOTsh3GjC4wj7HUyhADn+/AXPZdvuLIBmqzLbbX65aa9PBo3bkXVme7imbN
 kBf68q3cy3QNQlzJ5ixVQZsQ7wFmOd9ULnr3zLEch5GVNboC6b7y6FTNr4aHtmV30yIKwBKMP
 ZSAfACKILWmU+3ByXx8ltancHJfVhnxDRTkONByRAwuXNhqUJlNiGbwIjQsnI+VxJt1VP2wNC
 mmqQPnjqBSKRgRtVzdZke1b+ZPKaWPaK+u5VFjT5+KmL12P0gibbQeL5OKYUvZ9mCxpkLAtzM
 Yf/ffvE3xqQW6mRGfC7RvS/fR2s6yYMTFmhWyODM7znL6XQsQz1yiQQ3rJ3gQHWo0Uc17AIu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294349>

In f924b52 (Windows: add pthread_sigmask() that does nothing,
2016-05-01), we introduced a no-op for Windows. However, this breaks
building Git in Git for Windows' SDK because pthread_sigmask() is
already a no-op there, #define'd in the pthread_signal.h header in
/mingw64/x86_64-w64-mingw32/include/.

Let's wrap the definition of pthread_sigmask() in a guard that skips
it when compiling with MinGW-w64' headers.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/mingw-sigmask-v2
 compat/win32/pthread.h | 2 ++
 1 file changed, 2 insertions(+)
Interdiff vs v1:

 diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
 index 8df702c..1c16408 100644
 --- a/compat/win32/pthread.h
 +++ b/compat/win32/pthread.h
 @@ -104,7 +104,7 @@ static inline void *pthread_getspecific(pthread_key_t key)
  	return TlsGetValue(key);
  }
  
 -#ifndef pthread_sigmask
 +#ifndef __MINGW64_VERSION_MAJOR
  static inline int pthread_sigmask(int how, const sigset_t *set, sigset_t *oset)
  {
  	return 0;


diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index d336451..1c16408 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -104,9 +104,11 @@ static inline void *pthread_getspecific(pthread_key_t key)
 	return TlsGetValue(key);
 }
 
+#ifndef __MINGW64_VERSION_MAJOR
 static inline int pthread_sigmask(int how, const sigset_t *set, sigset_t *oset)
 {
 	return 0;
 }
+#endif
 
 #endif /* PTHREAD_H */
-- 
2.8.2.465.gb077790
