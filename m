From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v3 3/4] fix some win32 specific dependencies in poll.c
Date: Fri, 7 Sep 2012 14:55:45 +0200
Message-ID: <003c01cd8cf8$1968a980$4c39fc80$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:56:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9y6O-0007lH-Tw
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 14:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab2IGMz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 08:55:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56073 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2IGMz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 08:55:57 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Mdund-1SvKYZ1i2v-00PeF0; Fri, 07 Sep 2012 14:55:54 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2M+AStjTjcygVlSpuvkqnyM5dLcQ==
Content-Language: de
X-Provags-ID: V02:K0:cWmFK+TrlTWkq6Dc7pep0nhLNWJl4+a4qSWGqLF7vcH
 AsDOMTO4iviu6vkidlWTaO8xmvqjlcN72JQXX9GZpsDDsNOrWp
 Mi4xaZJjDgeLaRgYJJp0sxTdthHkUf+IV+F2wwbx6/i8wKalKt
 jCGbRzyS+H+NqDBwURhL4hSrqy6NMfFd9HIfjZ9tmsbdWjU+us
 BoqY/BWnOWmEdHQcy/OOSlAQVFgxyEvwtAy3a2Zw4/Pk1s08EC
 peO5rEMY3U8PIDgXlt6+wS7CcoAjPKmZE5WygeQLmUJBqFT582
 vlHbSnxbPkTDbtLZlliSxyr0x2eFkQPeufD3o8r9zk9ypligah
 TZU8sL/ce0crwRT/pnyobiIiHtfmC220Dd7N4lSpzIgze8DaMQ
 34z9RF00uQIog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204963>

In order for non-win32 platforms to be able to use poll.c, #ifdef the
inclusion of two header files

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 compat/poll/poll.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 9e7a25c..e4b8319 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -24,7 +24,9 @@
 # pragma GCC diagnostic ignored "-Wtype-limits"
 #endif
 
-#include <malloc.h>
+#if defined(WIN32)
+# include <malloc.h>
+#endif
 
 #include <sys/types.h>
 
@@ -48,7 +50,9 @@
 #else
 # include <sys/time.h>
 # include <sys/socket.h>
-# include <sys/select.h>
+# ifndef NO_SYS_SELECT_H
+#  include <sys/select.h>
+# endif
 # include <unistd.h>
 #endif
 
-- 
1.7.12
