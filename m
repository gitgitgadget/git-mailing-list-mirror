From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/3] read-cache.c: Fix index reading breakage on cygwin
Date: Tue, 04 Sep 2012 19:47:13 +0100
Message-ID: <50464CB1.6030002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: t.gummerer@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 04 21:07:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8yTH-0001rb-Rr
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642Ab2IDTHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:07:25 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:40958 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932637Ab2IDTHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:07:22 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 355D2128076;
	Tue,  4 Sep 2012 20:07:21 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id A4146128075;	Tue,  4 Sep 2012 20:07:20 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue,  4 Sep 2012 20:07:19 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204774>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 read-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index b69dd05..211b971 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1204,9 +1204,11 @@ static int index_changed(struct stat st_old, struct stat st_new)
 	int changed = 0;
 
 	if (st_old.st_mtime != st_new.st_mtime ||
+#if !defined(__CYGWIN__)
 	    st_old.st_uid   != st_new.st_uid ||
 	    st_old.st_gid   != st_new.st_gid ||
 	    st_old.st_ino   != st_new.st_ino ||
+#endif
 	    st_old.st_size  != st_new.st_size)
 		changed = 1;
 #ifdef USE_NSEC
-- 
1.7.12
