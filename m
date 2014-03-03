From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 03/14] cache-tree.c: use ALLOC_GROW() in find_subtree()
Date: Tue,  4 Mar 2014 02:31:51 +0400
Message-ID: <1393885922-21616-4-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQT-0002rx-G4
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465AbaCCWck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:40 -0500
Received: from forward5l.mail.yandex.net ([84.201.143.138]:44738 "EHLO
	forward5l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454AbaCCWci (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:38 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward5l.mail.yandex.net (Yandex) with ESMTP id 23FB0C40FE6;
	Tue,  4 Mar 2014 02:32:37 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id D0BE41E1112;
	Tue,  4 Mar 2014 02:32:36 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-Wav8KZk4;
	Tue,  4 Mar 2014 02:32:36 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: d2cc17e7-0cb4-4ff5-a9f4-9376fe459f31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885956;
	bh=XxhdlgaN57OAeRQLnfrjaFhQQo03L0SygT1IC0dtXm0=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=KEUAKVvh+b8baemyYfKZvdQlHa6DdnT2dmY5NH2bvR0gIS/KkIROCfOGoD23Dy8sV
	 xohbg6IMo53YZEtY/+lMevOveppbEy3ETSZxRImk/+SBY1hbzSwya4EyMVmpoNazcy
	 kuANK4pekTCOqxkMyHbPddaW+ZmZgmqPVOapYrnk=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243288>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 cache-tree.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 0bbec43..30149d1 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -75,11 +75,7 @@ static struct cache_tree_sub *find_subtree(struct cache_tree *it,
 		return NULL;
 
 	pos = -pos-1;
-	if (it->subtree_alloc <= it->subtree_nr) {
-		it->subtree_alloc = alloc_nr(it->subtree_alloc);
-		it->down = xrealloc(it->down, it->subtree_alloc *
-				    sizeof(*it->down));
-	}
+	ALLOC_GROW(it->down, it->subtree_nr + 1, it->subtree_alloc);
 	it->subtree_nr++;
 
 	down = xmalloc(sizeof(*down) + pathlen + 1);
-- 
1.8.3.2
