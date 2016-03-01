From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Mark win32's pthread_exit() as NORETURN
Date: Tue, 1 Mar 2016 14:53:04 +0100 (CET)
Message-ID: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 14:53:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aakjs-0002OR-DA
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 14:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbcCANxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 08:53:20 -0500
Received: from mout.gmx.net ([212.227.15.15]:52747 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbcCANxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 08:53:19 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MWk3f-1aQ6YL2SPD-00Xwk5; Tue, 01 Mar 2016 14:53:06
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xPRwrr+9dFwa1qsPIqkFB+TsJ1VvP35UuPNdBJ3NjcD02/7u6Wn
 RfIC9xFOUXq/LXgcC8UUyfRJmbgEOzwfk4VO6BmO5YPjjR9W+Ep4frYQ4ol2V49y0Kp4hOl
 KsZx0q84UwqIsnm9TfTlEFfPDSlOFfqVTCJGjh7utrufNBVZBg+P3fo9f/iJjiU75+/qBdo
 Uix3HLyssLv6impyLvA0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EzHZVtJZKyA=:a+46AN1lkxeG7peGub1pdV
 o8DKahXGe4RFOnTCk73NCpaXiohXo8jAT0Det9SKRylVasc0dfmMQ7u6FRs1ZOWbtqT1NpIU1
 sEhdb/mYyLsw1ks5CfUHt7Wv5wW0vsZFdWvREwm78FP5Q5Uii8uBWFBudJF3MYkq8htWHNwmT
 XTJWnRwwB9EcrMr4anZYN4rKognP3OxUnP51uGNc9KLzEEjVzRNCWRzBhZpwcd0/p6pjR5LQt
 29nl8YItme3bhrhT3z1bBH6uf10Y18+J9m5HZOKTLByTR91vZLhOuJBpps/1emGpiLYZv0mJ5
 YkRX7S55arfSUXb1Qcc7liEmn3Fs9Ck9vKxrByJEx09cObGJKsKN0J4ZKT8T+JynAgCiiG04Y
 aZU+dnHED+AJpv7Wgralt5EwstMYPcO6f3u3H2/ApiKjafu7311aKmwRUwcv2sk6fiIUabqe8
 wWQOxFSZEFtabU5vq+6Ocemqj47BqGmElwVfoVjCtE+HPU5JoB+zuiqS/0vY1Po3S4KMDt4UD
 r4kVU+2cQsWAlAlEV6mRgY0wd6OEYL4CAsJDmiHcro0yAlfS7mFeo1bQGz7K0/feavs+ts8Kp
 Jf3KM2dcqhzvaJyDq0q9WBEZ1IkYloITQmwnoZm+TP0YyI9sRyXtTqoPrtLvkusTxbemAsJdy
 S7F3h5WU3Q8g/qhFkFvX7Jnd5JKJOQmKnY2LrpbLYVDzbd8txLbUPBaQnPcL16N61MqbVs8Jr
 eAp8O0rNjK4nukCdOmVRX4oPTYyodxDIrXx/qAbpenZHWlJWqE90U/DzLv2yD2rsKJ3hP5MZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288013>

The pthread_exit() function is not expected to return. Ever.

Pointed out by Jeff King.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/pthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 20b35a2..148db60 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -78,7 +78,7 @@ extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
 #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
 extern pthread_t pthread_self(void);
 
-static inline int pthread_exit(void *ret)
+static inline int NORETURN pthread_exit(void *ret)
 {
 	ExitThread((DWORD)(intptr_t)ret);
 }
-- 
2.7.2.windows.1.5.g64acc33
