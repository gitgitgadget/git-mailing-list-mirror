From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v5 4/4] make poll() work on platforms that can't recv() on a non-socket
Date: Thu, 13 Sep 2012 09:12:46 +0200
Message-ID: <002601cd917f$2d3e1590$87ba40b0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
To: <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 09:13:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC3bj-0000ef-92
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 09:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab2IMHMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 03:12:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64381 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab2IMHMy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 03:12:54 -0400
Received: from DualCore (dsdf-4db5d951.pool.mediaWays.net [77.181.217.81])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MI8Ug-1TFuQM49bK-003Nmc; Thu, 13 Sep 2012 09:12:53 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2RfwALjBEbrcQzSoS23Z1vIlVpnA==
Content-language: de
X-Provags-ID: V02:K0:MaDjR/hYMcAyHlRjV93VsEsq+vBhEu0jVOoqC1ywgIj
 89n2+HmQMKpR2KUENoVXLh+OcfnairYMV6asMiSgcZ98zdgU9m
 bA4ueM3NMdH4kQpDM+wMDPveXK88WAOWX9XFlcfiOqDu2h/wqM
 DupJDNtNJKdz3MNEzW69oyPaQ2PxC2PuttN3viE7MhA354KRQv
 7LwNXTojvdsFtEpuY+Nx6J+rWxIr5Xp7wlvEu/zFym3UxT9yG0
 2O3nSmrdHczgBHdWHseUeI4hUA611Zs1C23Ni2SQeR+hNJAfyN
 8Uh+flxShKxiCEoV7B06fxcgZCTQvwPYj+VA+Xc3Y8p2CghzVM
 Kj5IdYSvkSSCG/wGVCmLiw9kDaMEo3S/qlIO2RBW1FeXWRHRpc
 T4YpFgF852oJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205357>

This way it just got added to gnulib too.

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
+      else if (socket_errno == ENOTSOCK)
+	happened |= (POLLIN | POLLRDNORM) & sought;
+
       else
 	happened |= POLLERR;
     }
-- 
1.7.12
