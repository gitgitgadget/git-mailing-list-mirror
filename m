From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 03/32] rollback_lock_file(): do not clear filename redundantly
Date: Sat,  6 Sep 2014 09:50:17 +0200
Message-ID: <1409989846-22401-4-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAtv-0004vm-0u
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbaIFH7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:11 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64341 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750849AbaIFH7F (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:05 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Sep 2014 03:59:05 EDT
X-AuditID: 12074412-f792e6d000005517-5f-540abd22425a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FD.8E.21783.22DBA045; Sat,  6 Sep 2014 03:52:02 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFH2006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:00 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqKu0lyvEYOpLDouuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujJXn37AVLGCp+Lisja2BcQNzFyMnh4SAicTF+fdYIGwxiQv31rN1
	MXJxCAlcZpRYOX8yK0hCSOAYk8TlHiUQm01AV2JRTzMTSJGIQBujxK6Lm8GKmAVSJDqedzN2
	MXJwCAsESiw+awISZhFQlfiweyMTSJhXwEVi7ec8iF1yEht2/2cEsTkFXCWmN3UyQqxykWg/
	2c80gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQIBPawbj+pNwh
	RgEORiUe3gIHrhAh1sSy4srcQ4ySHExKorx5y4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHg7
	JgPleFMSK6tSi/JhUtIcLErivD8Xq/sJCaQnlqRmp6YWpBbBZGU4OJQkeF32ADUKFqWmp1ak
	ZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg+IivhgYGSApHqC9rCDtvMUFiblAUYjWU4zGHC1N
	b3uZONZ1futnEmLJy89LlRLnZQIpFQApzSjNg1sESy+vGMWB/hbmFQOp4gGmJrh5r4BWMQGt
	Mk/nBFlVkoiQkmpgFCp76qQV4Os6rediIKsos5fQqqUV/i9yWavEXj3IiBFd/sDC1SLW88N6
	W7Gz+5f49a2/5d+88ZQRV8WeO9MXPuF955yWv8Ps8jGdY0LZVtf/LZM5Huz8t2nW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256566>

It is only necessary to clear the lock_file's filename field if it was
not already clear.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index f1ce154..a548e08 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -276,6 +276,6 @@ void rollback_lock_file(struct lock_file *lk)
 		if (lk->fd >= 0)
 			close(lk->fd);
 		unlink_or_warn(lk->filename);
+		lk->filename[0] = 0;
 	}
-	lk->filename[0] = 0;
 }
-- 
2.1.0
