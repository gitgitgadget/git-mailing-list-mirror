From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v6 4/4] make poll() work on platforms that can't recv() on a non-socket
Date: Mon, 17 Sep 2012 09:03:53 +0200
Message-ID: <k36i16$ou1$1@ger.gmane.org>
References: <k36h3i$ihb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 09:05:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDVOp-0005Eg-Cx
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 09:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab2IQHFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 03:05:03 -0400
Received: from plane.gmane.org ([80.91.229.3]:56661 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab2IQHFC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 03:05:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TDVOB-0004xz-MU
	for git@vger.kernel.org; Mon, 17 Sep 2012 09:05:03 +0200
Received: from dsdf-4db53772.pool.mediaways.net ([77.181.55.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 09:05:03 +0200
Received: from jojo by dsdf-4db53772.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 09:05:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db53772.pool.mediaways.net
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205660>

This way it just got added to gnulib too the other day.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 compat/poll/poll.c | 5 +++++
 1 file changed, 4 insertions(+)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index e4b8319..10a204e 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -306,6 +306,10 @@ compute_revents (int fd, int sought, fd_set *rfds, 
fd_set *wfds, fd_set *efds)
         || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
  happened |= POLLHUP;

+      /* some systems can't use recv() on non-socket, including HP NonStop 
*/
+      else if (socket_errno == ENOTSOCK)
+ happened |= (POLLIN | POLLRDNORM) & sought;
+
       else
  happened |= POLLERR;
     }
-- 
1.7.12 
