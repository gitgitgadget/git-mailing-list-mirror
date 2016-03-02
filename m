From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3] Mark win32's pthread_exit() as NORETURN
Date: Wed, 2 Mar 2016 20:11:13 +0100 (CET)
Message-ID: <63310f6af16c70870bd620c83d8860421ca02718.1456945703.git.johannes.schindelin@gmx.de>
References: <d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 20:11:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abCBU-0002T3-L9
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 20:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939AbcCBTLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 14:11:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:50191 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbcCBTLc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 14:11:32 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MVrQS-1aQCk727xY-00X6sH; Wed, 02 Mar 2016 20:11:15
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:5Dtu/JUrpDpwy+4SarmQbIuaLH7JIgveIGcg1HG0EI1LHgP1mwI
 d1oQg/LHtUfjtYoT97NNVL0SZClLxQiJTXXnPdnMqq2CArZ2/jUeTC/oJBN6kXEl9u/isEO
 vY53+z3BWg510+jiO9EylMzOdf5LGzfQaveOgU4Uf6tOpLP8wgHQ0xdKnNvbVntwidG/gnA
 ZOaoQRCPEtyjN8Y8tozSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SLK13+GeMxE=:L4L9X8Ph1wVYElJQKv10RE
 pDxQ10qbTtj2lp74RuaFV6ZvSs+O9MMIGRpUtBQ6K/wutRFuw10TrsJAj+JbDPu/VjGcASiZz
 u9CnaP/mP+xqEFPTIddUXRUv3kInnAlet4qhljHOyuZ+lTKrNbRbIpWbKnu15ZCVfAFl7HN45
 gllKSYM6DbMPherhUyAyUsyPLb8Boc+CH8nXNl3UiAaSW2WFQUP1Wu4p5x6FNEE7R+z7rk/kk
 +Av1qHnzZq3mmuNi5a/wE269Ouf3/Vx142Wx7TUN7ghsheq73BkA8Yop9kS6FVj4vA+DpT4bk
 hCsyy4qhhYDlzv48/5kKMrsjtKPdJSsHGyDAT4qVChlXLl4vZ4mm9x99QDkzQ3LMzI+kffGGs
 G2nn7GFxoR4sKKIHq2nfFiQi6tW7NssNRx1thVV6fPLcNRwH/uNqm6QB0O5Xqy/TdVzfnX+xR
 Sp2JtlQ4TTTBxKts5551Ls1I9nOi6wbWIBwIKwLkqZH4lwfZ+MmYSFv5D6Pfzt554N+QDTm9F
 QRXbLN4FMXwxkTIitoDi/mhZzVkNez1NhJX4bLBoYmYA0l3sYXK8BBbu/yRlWJg2IiX7uP56U
 ngVlIu2HW8om0qaXUgCrGaYQEtP0nILepTa9dGistzfk+jYa8SrRHETCQT0iUIG/CqUUs9wer
 P8OWN4UoJw4DVSOMaVGQcO1UVzhH5nX4VL27GyMKnaV4iGsiHVtoGlFVKF7oGtXBBXytUAWjM
 uEof25YmD6rbfP5JAFiWbHy4mHBT0c+wKVmMfsZ2oFApd4xRtl0Xinba0XlYMI4b6lnZlTuo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288148>

The pthread_exit() function is not expected to return. Ever. On Windows,
we call ExitThread() whose documentation claims: "Ends the calling
thread", i.e. there is no condition in which this function simply
returns: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682659

While at it, fix the return type to be void, as per
http://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_exit.html

Pointed out by Jeff King, helped by Stefan Naewe, Junio Hamano &
Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/pthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
Interdiff vs v2:

 diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
 index 148db60..b6ed9e7 100644
 --- a/compat/win32/pthread.h
 +++ b/compat/win32/pthread.h
 @@ -78,7 +78,7 @@ extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
  #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
  extern pthread_t pthread_self(void);
  
 -static inline int NORETURN pthread_exit(void *ret)
 +static inline void NORETURN pthread_exit(void *ret)
  {
  	ExitThread((DWORD)(intptr_t)ret);
  }


diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 20b35a2..b6ed9e7 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -78,7 +78,7 @@ extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
 #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
 extern pthread_t pthread_self(void);
 
-static inline int pthread_exit(void *ret)
+static inline void NORETURN pthread_exit(void *ret)
 {
 	ExitThread((DWORD)(intptr_t)ret);
 }
-- 
2.7.2.windows.1.5.g64acc33
