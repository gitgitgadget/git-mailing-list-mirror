From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/6] compat/poll/poll.c: Fix a sparse warning
Date: Sat, 27 Apr 2013 20:17:14 +0100
Message-ID: <517C243A.20702@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:47:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB5c-0000gb-Jc
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab3D0TrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:47:13 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33135 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754780Ab3D0TrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:47:12 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 9AE1F384081;
	Sat, 27 Apr 2013 20:47:11 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 1453838407C;
	Sat, 27 Apr 2013 20:47:11 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:47:10 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222673>


Sparse issues an 'Using plain integer as NULL pointer' warning when
passing the constant '0' as the second parameter in the call to the
WSAEventSelect() function. The function parameter has a pointer type
(WSAEVENT, aka HANDLE, aka void *) so that, in order to suppress the
warning, we simply pass NULL for that parameter in the function call
expression.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/poll/poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 7d226ec..4410310 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -576,7 +576,7 @@ restart:
 	{
 	  /* It's a socket.  */
 	  WSAEnumNetworkEvents ((SOCKET) h, NULL, &ev);
-	  WSAEventSelect ((SOCKET) h, 0, 0);
+	  WSAEventSelect ((SOCKET) h, NULL, 0);
 
 	  /* If we're lucky, WSAEnumNetworkEvents already provided a way
 	     to distinguish FD_READ and FD_ACCEPT; this saves a recv later.  */
-- 
1.8.2
