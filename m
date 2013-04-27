From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/6] compat/win32mmap.c: Fix some sparse warnings
Date: Sat, 27 Apr 2013 20:18:03 +0100
Message-ID: <517C246B.3010307@ramsay1.demon.co.uk>
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
	id 1UWB5d-0000gb-33
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab3D0TrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:47:16 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33142 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754780Ab3D0TrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:47:14 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 104BC384081;
	Sat, 27 Apr 2013 20:47:14 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 7CD3638407C;
	Sat, 27 Apr 2013 20:47:13 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:47:12 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222674>


Sparse issues two 'Using plain integer as NULL pointer' warnings
against the call to the CreateFileMapping() function. The warnings
relate to the second and sixth parameters, which both have pointer
type. In order to suppress the warnings, we simply pass the NULL
pointer, rather than '0', to those parameters in the function call.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/win32mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index 61d2ef8..80a8c9a 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -21,8 +21,8 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 	if (!(flags & MAP_PRIVATE))
 		die("Invalid usage of mmap when built with USE_WIN32_MMAP");
 
-	hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), 0, PAGE_WRITECOPY,
-		0, 0, 0);
+	hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
+		PAGE_WRITECOPY, 0, 0, NULL);
 
 	if (!hmap)
 		return MAP_FAILED;
-- 
1.8.2
