From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/3] read-cache.c: Simplify do loop conditional expression
Date: Tue, 04 Sep 2012 20:05:17 +0100
Message-ID: <504650ED.1040801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: t.gummerer@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 04 21:08:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8yTf-0002AQ-UV
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649Ab2IDTHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:07:53 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:40981 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932637Ab2IDTHw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:07:52 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id A0577128076;
	Tue,  4 Sep 2012 20:07:51 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id E247D128075;	Tue,  4 Sep 2012 20:07:50 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue,  4 Sep 2012 20:07:50 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204776>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Thomas,

I note that index_changed(), which has no side effects, is called with
unchanged parameters twice each time around the loop. I was about to
suggest saving the result of a single call and using it in both places ...

However, on first sight, it looks like the expression in the while
condition will always be true (otherwise you would not reach that point
in the code - you would already have returned), so we can simply remove
that part of the expression (however, I didn't look too closely, so ...)
:-D

ATB,
Ramsay Jones

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 36f0877..5176d7a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1278,7 +1278,7 @@ int read_index_from(struct index_state *istate, const char *path)
 
 		usleep(10*1000);
 		i++;
-	} while ((err || index_changed(&st_old, &st_new)) && i < 50);
+	} while (i < 50);
 
 	munmap(mmap, mmap_size);
 	die("index file corrupt");
-- 
1.7.12
