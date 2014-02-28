From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 03/11] cache-tree.c: change find_subtree() to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 13:41:59 +0400
Message-ID: <531059E7.4030406@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:42:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJxr-0000zE-FU
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbaB1Jmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:42:39 -0500
Received: from forward6l.mail.yandex.net ([84.201.143.139]:52797 "EHLO
	forward6l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbaB1Jmh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:42:37 -0500
Received: from smtp13.mail.yandex.net (smtp13.mail.yandex.net [95.108.130.68])
	by forward6l.mail.yandex.net (Yandex) with ESMTP id B968D14E0E55
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:42:35 +0400 (MSK)
Received: from smtp13.mail.yandex.net (localhost [127.0.0.1])
	by smtp13.mail.yandex.net (Yandex) with ESMTP id 78C96E4005A
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:42:35 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp13.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id jykReuJON1-gZE0k4d2;
	Fri, 28 Feb 2014 13:42:35 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: f9dfa0e2-cce2-42bc-ab2a-b024a36bd2b6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580555;
	bh=IZNDJs9LtSwgwSCCJyCuty1ZDGzjlL4jgZ1cc9Kxeyk=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=QYNhl+73nRLPIbxuS8wMqMvmjoxrFM7YFlAXf5KoWpfMPaXYGXAtq0nPK9HPlv8ZF
	 v1Qc/j4dFM37X6b1Kupsc5l+SHn8K/HXjSV+OHFo1CVGcIU77QHbgDjgIgy35C7FgJ
	 Vqtzj2M8Zp17hw75yAPIji5Cns8TxRd6tWxy+9vs=
Authentication-Results: smtp13.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242922>

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
1.8.5.3
