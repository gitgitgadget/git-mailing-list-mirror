From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 04/38] rollback_lock_file(): do not clear filename redundantly
Date: Wed,  1 Oct 2014 12:28:08 +0200
Message-ID: <1412159322-2622-5-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZH9h-0002St-RW
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbaJAK27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:28:59 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58224 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbaJAK26 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:28:58 -0400
X-AuditID: 1207440e-f79da6d0000002fc-9b-542bd7686b9f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 72.F9.00764.867DB245; Wed,  1 Oct 2014 06:28:56 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk63026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:28:55 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1M24rh1iMP2tqUXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BlfN3xhL2hnrXiwbxtzA2MvSxcj
	J4eEgIlEz/PlbBC2mMSFe+uBbC4OIYHLjBIbttxihXCOM0m0/jwIVsUmoCuxqKeZCcQWEVCT
	mNh2iAWkiFlgMZPEhEObwIqEBQIlZi48ww5iswioSqz63QIW5xVwlpj8EGQqyDo5iQ27/zOC
	2JwCLhLLLzeDnSQEVLPjzlemCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbo
	paaUbmKEhCPfDsb29TKHGAU4GJV4eBUStEOEWBPLiitzDzFKcjApifIuugQU4kvKT6nMSCzO
	iC8qzUktPsQowcGsJMKbfQAox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh
	4FCS4GW4BtQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qO+GJgfICkeID2OoO0
	8xYXJOYCRSFaTzEac7Q0ve1l4ljX+a2fSYglLz8vVUqcNxOkVACkNKM0D24RLBG9YhQH+luY
	VxqkigeYxODmvQJaxQS0KnkN2KqSRISUVAOj2cP6a2m3TRXc1Dm8qjv0U5KZ6uY/XpDx8uHj
	v8/LVOa6v86NbJso3no++vOtBz2WHzNj0tkKvJdZ9TEUzLqbzLVci+32Pj7uM60y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257702>

It is only necessary to clear the lock_file's filename field if it was
not already clear.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index d02c3bf..5330d6a 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -280,6 +280,6 @@ void rollback_lock_file(struct lock_file *lk)
 		if (lk->fd >= 0)
 			close(lk->fd);
 		unlink_or_warn(lk->filename);
+		lk->filename[0] = 0;
 	}
-	lk->filename[0] = 0;
 }
-- 
2.1.0
