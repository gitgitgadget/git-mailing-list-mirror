From: Ralph Loader <suckfish@ihug.co.nz>
Subject: PATCH] mingw: Fix a typo in the pipe() implementation.
Date: Thu, 9 Oct 2014 21:03:59 +1300
Message-ID: <20141009210359.57a0bdab1f8f8700dc206e76@ihug.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 10:13:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xc8qx-0002Bd-Ae
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 10:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbaJIINf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 04:13:35 -0400
Received: from mailfilter8.ihug.co.nz ([203.109.136.8]:54557 "EHLO
	mailfilter8.ihug.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbaJIINc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 04:13:32 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Oct 2014 04:13:32 EDT
X-Cloudmark-SP-Filtered: true
X-Cloudmark-SP-Result: v=1.1 cv=Jvf6ujsaZ0YWyfwTZEpY3fGhAY4g5tJxczE4GWqCWHk= c=1 sm=2
 a=kj9zAlcOel0A:10 a=q_QNz6l7XxdGIcs6aoUA:9 a=CjuIK1q_8ugA:10
X-IronPort-AV: E=Sophos;i="5.04,683,1406548800"; 
   d="scan'208";a="148718382"
Received: from 30.124.252.27.dyn.cust.vf.net.nz (HELO i.geek.nz) ([27.252.124.30])
  by cust.filter8.content.vf.net.nz with SMTP; 09 Oct 2014 21:03:39 +1300
X-Mailer: Sylpheed 3.4.2 (GTK+ 2.24.24; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We checked the first file descriptor for errors twice, instead of
checking both file descriptors.

Signed-off-by: Ralph Loader <rcl@ihug.co.nz>
---
While this appears utterly trivial, I noticed this reading the code not
running it - I do not have the relevant OS to compile and test on.

 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index c5c37e5..7c92783 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -681,7 +681,7 @@ int pipe(int filedes[2])
 		return -1;
 	}
 	filedes[1] = _open_osfhandle((int)h[1], O_NOINHERIT);
-	if (filedes[0] < 0) {
+	if (filedes[1] < 0) {
 		close(filedes[0]);
 		CloseHandle(h[1]);
 		return -1;
-- 
2.1.0
