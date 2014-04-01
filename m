From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/22] rollback_lock_file(): do not clear filename redundantly
Date: Tue,  1 Apr 2014 17:58:11 +0200
Message-ID: <1396367910-7299-4-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV15d-0004hY-81
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbaDAP6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:58:48 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56291 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751822AbaDAP6k (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:40 -0400
X-AuditID: 12074413-f79076d000002d17-ae-533ae2305f67
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 67.58.11543.032EA335; Tue,  1 Apr 2014 11:58:40 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWb7027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:39 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqGvwyCrY4NMlBYuuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ2x/vR69oIFLBWrp9U0MG5g7mLk5JAQMJG4MGspK4QtJnHh3nq2LkYuDiGBy4wS17pX
	sUM4x5gkVrZcBetgE9CVWNTTzARiiwioSUxsO8QCYjMLpEi8+rsLzBYW8JO4vXwuWD2LgKpE
	77c97CA2r4CzxNEpi6E2y0lM+b0ALM4p4CJx6cEesCuEgGpOv1nMPIGRdwEjwypGucSc0lzd
	3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2MkJAS3sG466TcIUYBDkYlHt4D562ChVgTy4or
	cw8xSnIwKYny/rgLFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCO+smUI43JbGyKrUoHyYlzcGi
	JM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMEb9RCoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUv
	JbUosbQkIx4UGfHFwNgASfEA7Z0O0s5bXJCYCxSFaD3FqCglzhsCkhAASWSU5sGNhSWKV4zi
	QF8K8y4GqeIBJhm47ldAg5mABnOvAxtckoiQkmpgDNcTsHkcNq1Ft194ieQdmRvfYm00Eu97
	BRit0VjpKZA746Nn3V/l5pfZgZETeBX6TLhu6sQvyL4QtHOm3p5rk64c9g+clNVV+PvYsoX7
	3r+7c9vSwyJHzOpHS9kGYUsF+27JCjk11vsLHaZ++Fw7z7E56/3jC4fV354LPXPp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245593>

It is only necessary to clear the lock_file's filename field if it was
not already clear.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 8fbcb6a..d26711f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -277,6 +277,6 @@ void rollback_lock_file(struct lock_file *lk)
 		if (lk->fd >= 0)
 			close(lk->fd);
 		unlink_or_warn(lk->filename);
+		lk->filename[0] = 0;
 	}
-	lk->filename[0] = 0;
 }
-- 
1.9.0
