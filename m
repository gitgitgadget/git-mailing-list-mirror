From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v3 1/4] poll() exits too early with EFAULT if 1st arg is NULL
Date: Fri, 7 Sep 2012 14:52:48 +0200
Message-ID: <003a01cd8cf7$af821100$0e863300$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:53:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9y41-0004fE-DJ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 14:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab2IGMxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 08:53:30 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:58265 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab2IGMx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 08:53:29 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Lm4C9-1Tikq92lij-00Zde4; Fri, 07 Sep 2012 14:52:57 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2M966mF/+Lhp3dRQi1BDMrh7pz0w==
Content-Language: de
X-Provags-ID: V02:K0:SyK1+flxJsAJVixhnbypof0ckmPI1HG25DHUhkfwfzp
 13xhSRw8tfCoBkCSpR8/j0OhZM95tXtspqoGnIrqFQss0giQmz
 v69QRzjMaTtmAdwxyMePaiZgjV13kowvzBrnvLWzwxt5tDYl7Q
 nNJNs1Zip+nxw7ON75JZKIKcMsDujg6wfX6WRE5/yUBcEwj0F6
 Q1KWcTVWoKSJCLvcc0L9WzK9C/FKCZiXVY39MtIjGOXhoScbuh
 mIfmDOqcD6oti8dZUrsuR9tp1LcEUoZ9ASPq1VJw52i9x9O9Az
 4Zvz/urk6stglIFYYbaotAEFkn50jR3TR6n2sZqZmPgGaHfkWu
 l8jbhJ88oaztgHgzHIJ6N6xQ+q0bRzs8hjd15XCHl8tbmgku7J
 PuOgBZ5nClxZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204961>

If poll() is used as a milli-second sleep, like in help.c, by passing a NULL
in the 1st and a 0 in the 2nd arg, it exits with EFAULT.

As per Paolo Bonzini, the original author, this is a bug and to be fixed like
in this commit, which is not to exit if the 2nd arg is 0.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 compat/win32/poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/poll.c b/compat/win32/poll.c
index 403eaa7..9e7a25c 100644
--- a/compat/win32/poll.c
+++ b/compat/win32/poll.c
@@ -349,7 +349,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
 
   /* EFAULT is not necessary to implement, but let's do it in the
      simplest case. */
-  if (!pfd)
+  if (!pfd && nfd)
     {
       errno = EFAULT;
       return -1;
-- 
1.7.12
