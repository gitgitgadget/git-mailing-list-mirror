From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v4 4/4] make poll() work on platforms that can't recv() on a non-socket
Date: Fri, 7 Sep 2012 17:43:41 +0200
Message-ID: <004201cd8d0f$8e9ad4f0$abd07ed0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 17:44:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA0j1-0006Qn-6y
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 17:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab2IGPn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 11:43:59 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:61478 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab2IGPn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 11:43:58 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MWxmu-1T6nCM0MwG-00W18D; Fri, 07 Sep 2012 17:43:50 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2ND43l9atcGbQZQcOODkccVzwaNw==
Content-Language: de
X-Provags-ID: V02:K0:6+63WHJLCpDw2OWgMLuUDj34MM9/Y44OJiMJUGcZ0KP
 NHOmPvHvvvbPmux743Gb9PKxGNT0LX53tQpv3FNq6c/Sl0memq
 76bBzrtjKR56Nb17fObwJy+ign7AE/hu6Tj1Aki4xRvRZUGGwb
 k1c2OtC3SYSMx0Yx4hTgV0PiVR3x9tWjvGrP7lmGgi7N7BsL81
 PGE+AJG0MeYHJjlG3NaSDOXiAAY9OUi/XKSXrFPylTwZJyiVf6
 jlsNCsCUYwmJJgRAVZY1Mhu6gTrMRwKdENAErUtKt3pewY5eQe
 uMM5rxcH2n9ptyc7FpHBv2Hx6bJHsnMGBygTKUdFpyI1Wr5+rz
 4yyivm8Ffa0UrHf7jk+gEhZcXWGJyAuv0yfzeQWt3nZCPkp4cO
 ZOcAwxc5g7m/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204972>

This way it gets added to gnulib too.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 compat/poll/poll.c | 5 +++++
 1 file changed, 4 insertions(+)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index e4b8319..10a204e 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -306,6 +306,10 @@ compute_revents (int fd, int sought, fd_set *rfds, fd_set *wfds, fd_set *efds)
 	       || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
 	happened |= POLLHUP;
 
+      /* some systems can't use recv() on non-socket, including HP NonStop */
+      else if (/* (r == -1) && */ socket_errno == ENOTSOCK)
+	happened |= (POLLIN | POLLRDNORM) & sought;
+
       else
 	happened |= POLLERR;
     }
-- 
1.7.12
