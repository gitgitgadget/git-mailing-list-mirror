From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 03/11] cache-tree.c: use ALLOC_GROW() in find_subtree()
Date: Mon, 03 Mar 2014 11:20:37 +0400
Message-ID: <53142D45.6050601@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:21:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNBk-0000rY-HI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbaCCHVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:21:17 -0500
Received: from forward8l.mail.yandex.net ([84.201.143.141]:35827 "EHLO
	forward8l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbaCCHVP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:21:15 -0500
Received: from smtp13.mail.yandex.net (smtp13.mail.yandex.net [95.108.130.68])
	by forward8l.mail.yandex.net (Yandex) with ESMTP id C102E1A40EC9
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:21:12 +0400 (MSK)
Received: from smtp13.mail.yandex.net (localhost [127.0.0.1])
	by smtp13.mail.yandex.net (Yandex) with ESMTP id 7E1D4E40066
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:21:12 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp13.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 96zGKoHaAC-LBHC4L5J;
	Mon,  3 Mar 2014 11:21:12 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: aca3e6e4-d2d9-43d5-926c-92b679014028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831272;
	bh=IZNDJs9LtSwgwSCCJyCuty1ZDGzjlL4jgZ1cc9Kxeyk=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=NAcA8OS6jS6e2x9QBTmepRSUeotBII2Dwho9DGrTTU4oGoQJI65Zh3h+x3f878NGk
	 +G5GPLMDX0xiqQBXrMsJ7/8rtLoqDFgMx84ZzTa2d28Nlyi3GMUi6r8r4LSKBHow0v
	 c7b/032f1/M8rRhsaBdlxm3WoS8Y6RR+Vxl0cDKw=
Authentication-Results: smtp13.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243182>

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
