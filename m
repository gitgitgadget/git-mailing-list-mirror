From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] dir: do all size checks before seeking back and fix file closing
Date: Sat, 26 Aug 2006 16:17:09 +0200
Message-ID: <20060826141709.GC11601@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 26 16:17:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGyyR-0005G2-KB
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 16:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWHZORS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 10:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWHZORS
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 10:17:18 -0400
Received: from [130.225.96.91] ([130.225.96.91]:21170 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751363AbWHZORR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 10:17:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 667FC77008F
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:17:10 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13396-01 for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:17:09 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 44D9B770005
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:17:09 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 326DA6DF835
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 16:15:49 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 3316D62A02; Sat, 26 Aug 2006 16:17:09 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26049>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 dir.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index d53d48f..ff8a2fb 100644
--- a/dir.c
+++ b/dir.c
@@ -122,11 +122,11 @@ static int add_excludes_from_file_1(cons
 	size = lseek(fd, 0, SEEK_END);
 	if (size < 0)
 		goto err;
-	lseek(fd, 0, SEEK_SET);
 	if (size == 0) {
 		close(fd);
 		return 0;
 	}
+	lseek(fd, 0, SEEK_SET);
 	buf = xmalloc(size+1);
 	if (read(fd, buf, size) != size)
 		goto err;
@@ -146,7 +146,7 @@ static int add_excludes_from_file_1(cons
 	return 0;
 
  err:
-	if (0 <= fd)
+	if (0 >= fd)
 		close(fd);
 	return -1;
 }
-- 
1.4.2.GIT

-- 
Jonas Fonseca
