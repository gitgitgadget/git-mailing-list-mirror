From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v3 2/2] alloc.c: remove the redundant commit_count variable
Date: Fri, 11 Jul 2014 00:59:48 +0100
Message-ID: <53BF28F4.8050704@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:59:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5OFn-0002yY-CA
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 01:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbaGJX7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 19:59:52 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:59073 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751011AbaGJX7v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 19:59:51 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 1DD0F6F903E;
	Thu, 10 Jul 2014 23:24:28 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id E46656F8FC1;
	Thu, 10 Jul 2014 23:24:27 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Thu, 10 Jul 2014 23:24:27 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253239>


The 'commit_count' static variable is used in alloc_commit_node()
to set the 'index' field of the commit structure to a unique value.
This variable assumes the same value as the 'count' field of the
'commit_state' allocator state structure, which may be used in its
place.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/alloc.c b/alloc.c
index d7c3605..c6687f9 100644
--- a/alloc.c
+++ b/alloc.c
@@ -64,9 +64,8 @@ static struct alloc_state commit_state;
 
 void *alloc_commit_node(void)
 {
-	static int commit_count;
 	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
-	c->index = commit_count++;
+	c->index = commit_state.count - 1;
 	return c;
 }
 
-- 
2.0.0
