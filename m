From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 13/14] read-cache.c: use ALLOC_GROW() in add_index_entry()
Date: Tue,  4 Mar 2014 02:32:01 +0400
Message-ID: <1393885922-21616-14-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQ2-0002Y2-2l
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbaCCWcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:50 -0500
Received: from forward10l.mail.yandex.net ([84.201.143.143]:57543 "EHLO
	forward10l.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755488AbaCCWct (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 17:32:49 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward10l.mail.yandex.net (Yandex) with ESMTP id B912EBA0E88;
	Tue,  4 Mar 2014 02:32:45 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 7A6FC1E1357;
	Tue,  4 Mar 2014 02:32:45 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-Wjv8Djeh;
	Tue,  4 Mar 2014 02:32:45 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 0a2a9645-d2c1-4f98-a0e8-5e498fe41530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885965;
	bh=ojAuhuZn7MzWS8coNieCtmJah9kJAhAeediCv3lpBhM=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=ReRD4cCwY2JfkFFimgVn1tX5js+wz2oNVLlhH3besXQydqm+yjV4du7CBKMd4gfS8
	 hk8hayh8UcLtgFOZTTkO5ym1vLQYH2EkSZFKbiBvVYGHZmHTzjPQsafNmekMGr4Enz
	 wxPFGmyrT7FKUqXs6ip1NncEhyaaAp6pdi/OdigM=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243286>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 read-cache.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index fb440b4..cbdf954 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -990,11 +990,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 	}
 
 	/* Make sure the array is big enough .. */
-	if (istate->cache_nr == istate->cache_alloc) {
-		istate->cache_alloc = alloc_nr(istate->cache_alloc);
-		istate->cache = xrealloc(istate->cache,
-					istate->cache_alloc * sizeof(*istate->cache));
-	}
+	ALLOC_GROW(istate->cache, istate->cache_nr + 1, istate->cache_alloc);
 
 	/* Add it in.. */
 	istate->cache_nr++;
-- 
1.8.3.2
