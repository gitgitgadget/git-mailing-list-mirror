From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 05/35] rollback_lock_file(): set fd to -1
Date: Tue, 16 Sep 2014 21:33:26 +0200
Message-ID: <1410896036-12750-6-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWB-00008O-JS
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbaIPTeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:34:23 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53858 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754881AbaIPTeX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:34:23 -0400
X-AuditID: 12074414-f79446d000001f1d-dc-541890be64dc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id CA.EA.07965.EB098145; Tue, 16 Sep 2014 15:34:22 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBc9001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:21 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqLtvgkSIwaslKhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdcffNLsaCZ6wVc/9NZWpgvMnSxcjJISFgIrHg5g9W
	CFtM4sK99WxdjFwcQgKXGSUm/l3JCJIQEjjBJNH4LhTEZhPQlVjU08wEUiQi0MYoseviZlYQ
	h1mgm1Hi/YnTTCBVwgI2ErNn9ADZHBwsAqoSpyYzg4R5BVwk1kyYDrVNTmLD7v+MICWcAq4S
	X/cVgJhCQCUH7/pNYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMk
	6ER2MB45KXeIUYCDUYmH1+OReIgQa2JZcWXuIUZJDiYlUd5/3RIhQnxJ+SmVGYnFGfFFpTmp
	xYcYJTiYlUR4f/gC5XhTEiurUovyYVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiUJHjn
	9QM1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiIr4YGBkgKR6gvZtB2nmLCxJz
	gaIQracYjTlamt72MnGs6/zWzyTEkpeflyolzmsDUioAUppRmge3CJZuXjGKA/0tzLsFpIoH
	mKrg5r0CWsUEtOpsjxjIqpJEhJRUAyOTVhiTntPdu5ezJL/e2pzrrPthqYAp/+MpH6Yomact
	t02dwX37zKeSQwcj32z/H7zP4PpPa9tXt1llK/c7X2SXW9bH/XTS6k7xo0UnFnVs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257146>

When rolling back the lockfile, call close_lock_file() so that the
lock_file's fd field gets set back to -1.  This keeps the lock_file
object in a valid state, which is important because these objects are
allowed to be reused.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 49179d8..b1c4ba0 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -276,7 +276,7 @@ void rollback_lock_file(struct lock_file *lk)
 		return;
 
 	if (lk->fd >= 0)
-		close(lk->fd);
+		close_lock_file(lk);
 	unlink_or_warn(lk->filename);
 	lk->filename[0] = 0;
 }
-- 
2.1.0
