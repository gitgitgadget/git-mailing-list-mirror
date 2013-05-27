From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] fetch: don't try to update unfetched tracking refs
Date: Mon, 27 May 2013 12:40:25 +0100
Message-ID: <9c6fd36368cd6b0fba4855be4d31106781c02f58.1369654825.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 27 13:40:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugvn7-0008Br-AU
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 13:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948Ab3E0Lki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 07:40:38 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:47908 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757704Ab3E0Lkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 07:40:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id CD664198007;
	Mon, 27 May 2013 12:40:36 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7+qIBbtYE29H; Mon, 27 May 2013 12:40:36 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C9BF2198005;
	Mon, 27 May 2013 12:40:31 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc3.438.gb3e4ae3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225587>

Since commit f269048 (fetch: opportunistically update tracking refs,
2013-05-11) we update tracking refs opportunistically when fetching
remote branches.  However, if a refspec is given on the command line
that does not include a configured (non-pattern) refspec a fatal error
occurs.

Fix this by setting the "missing_ok" flag when calling get_fetch_map.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e41cc0d..d15a734 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -183,7 +183,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		old_tail = tail;
 		for (i = 0; i < transport->remote->fetch_refspec_nr; i++)
 			get_fetch_map(ref_map, &transport->remote->fetch[i],
-				      &tail, 0);
+				      &tail, 1);
 		for (rm = *old_tail; rm; rm = rm->next)
 			rm->fetch_head_status = FETCH_HEAD_IGNORE;
 	} else {
-- 
1.8.3.rc3.438.gb3e4ae3
