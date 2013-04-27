From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/6] compat/win32/pthread.c: Fix a sparse warning
Date: Sat, 27 Apr 2013 20:16:28 +0100
Message-ID: <517C240C.80803@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:47:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB5X-0000VO-8r
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab3D0TrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:47:10 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33128 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754290Ab3D0TrK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:47:10 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 1C16E384081;
	Sat, 27 Apr 2013 20:47:09 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 67D0A38407C;
	Sat, 27 Apr 2013 20:47:08 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:46:50 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222672>


Sparse issues a 'Using plain integer as NULL pointer' warning when
initializing an pthread_t structure with an '{ 0 }' initializer.
The first field of the pthread_t structure has type HANDLE (void *),
so in order to suppress the warning, we replace the initializer
expression with '{ NULL }'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/win32/pthread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 010e875..e18f5c6 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -52,7 +52,7 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 
 pthread_t pthread_self(void)
 {
-	pthread_t t = { 0 };
+	pthread_t t = { NULL };
 	t.tid = GetCurrentThreadId();
 	return t;
 }
-- 
1.8.2
