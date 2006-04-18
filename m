From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix filename scaling for binary files
Date: Tue, 18 Apr 2006 23:26:43 +0200
Message-ID: <20060418212643.GA30478@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 18 23:27:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVxis-0002PW-ON
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 23:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWDRV0r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWDRV0r
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 17:26:47 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:29407 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750709AbWDRV0r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 17:26:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id DB1D1770002;
	Tue, 18 Apr 2006 23:26:45 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08442-13; Tue, 18 Apr 2006 23:26:44 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5AC2F770001;
	Tue, 18 Apr 2006 23:26:44 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 21CB16DF835; Tue, 18 Apr 2006 23:24:29 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2C36D62179; Tue, 18 Apr 2006 23:26:44 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18881>

Set maximum filename length for binary files so that scaling won't be
triggered and result in invalid string access.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 diff.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index b54bbfa..ddcfb84 100644
--- a/diff.c
+++ b/diff.c
@@ -250,13 +250,14 @@ static void show_stats(struct diffstat_t
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 
+		len = strlen(file->name);
+		if (max_len < len)
+			max_len = len;
+
 		if (file->is_binary || file->is_unmerged)
 			continue;
 		if (max_change < file->added + file->deleted)
 			max_change = file->added + file->deleted;
-		len = strlen(file->name);
-		if (max_len < len)
-			max_len = len;
 	}
 
 	for (i = 0; i < data->nr; i++) {

-- 
Jonas Fonseca
