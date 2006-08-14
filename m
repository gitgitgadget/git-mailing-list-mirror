From: David Rientjes <rientjes@google.com>
Subject: [PATCH 24/28] read-cache.c cleanup
Date: Mon, 14 Aug 2006 13:38:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141337420.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:38:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjCp-0001hF-I2
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWHNUih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWHNUih
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:38:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:61336 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964861AbWHNUig
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:38:36 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id k7EKcId9023123
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:38:18 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=NJjKiSjQ7xBQpxpCUaZrRJj3Vf40jtncIg99x0SWClJ3UPT0pkM+2pDYDzbYFKzmz
	kAkzHe9N18WbWCvuHyung==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps37.corp.google.com with ESMTP id k7EKcEJH029695
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:38:14 -0700
Received: by localhost (Postfix, from userid 24081)
	id 685EE87D71; Mon, 14 Aug 2006 13:38:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 65FE587D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:38:14 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25405>

Removes conditional returns.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 read-cache.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c923a32..b18f9f7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -880,10 +880,8 @@ static int write_index_ext_header(SHA_CT
 {
 	ext = htonl(ext);
 	sz = htonl(sz);
-	if ((ce_write(context, fd, &ext, 4) < 0) ||
-	    (ce_write(context, fd, &sz, 4) < 0))
-		return -1;
-	return 0;
+	return ((ce_write(context, fd, &ext, 4) < 0) ||
+		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
 
 static int ce_flush(SHA_CTX *context, int fd)
@@ -905,9 +903,7 @@ static int ce_flush(SHA_CTX *context, in
 	/* Append the SHA1 signature at the end */
 	SHA1_Final(write_buffer + left, context);
 	left += 20;
-	if (write(fd, write_buffer, left) != left)
-		return -1;
-	return 0;
+	return (write(fd, write_buffer, left) != left) ? -1 : 0;
 }
 
 static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
-- 
1.4.2.g89bb-dirty
