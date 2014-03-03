From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 06/11] diffcore-rename.c: use ALLOC_GROW()
Date: Mon, 03 Mar 2014 11:22:40 +0400
Message-ID: <53142DC0.1080403@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:23:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNDe-00028K-QP
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbaCCHXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:23:19 -0500
Received: from forward10l.mail.yandex.net ([84.201.143.143]:56542 "EHLO
	forward10l.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753114AbaCCHXS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 02:23:18 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward10l.mail.yandex.net (Yandex) with ESMTP id 6AD74BA0F1F
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:23:15 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 220E41E1357
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:23:15 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id jPC6If2bFs-NEwqrjYn;
	Mon,  3 Mar 2014 11:23:14 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 29796920-6954-479d-8fa9-ca96ba54d1da
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831394;
	bh=ZvkE+Ts2AFUOLqd7GzCLd+TVl8YJB6FBxguYcda+nKA=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=GyLGrI1Ygs2BYb10TGS5uvCzWHHcYnSKiu0mBYZsGx/bCnMahJMZNajg56wHHawA7
	 X1zzgKKSEDzsaQmJRWC+MfSsOaTXDm8YNOcK1p5wYOiv+TXV3ltlz80JeNqGcwARoe
	 o4YVhzI2w+gQg3dbhfpD3qHbxqHUX0dz/lIWxkJc=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243185>

Use ALLOC_GROW() instead inline code in
locate_rename_dst() and register_rename_src()

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 diffcore-rename.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 9b4f068..fbf3272 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -38,11 +38,7 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 	if (!insert_ok)
 		return NULL;
 	/* insert to make it at "first" */
-	if (rename_dst_alloc <= rename_dst_nr) {
-		rename_dst_alloc = alloc_nr(rename_dst_alloc);
-		rename_dst = xrealloc(rename_dst,
-				      rename_dst_alloc * sizeof(*rename_dst));
-	}
+	ALLOC_GROW(rename_dst, rename_dst_nr + 1, rename_dst_alloc);
 	rename_dst_nr++;
 	if (first < rename_dst_nr)
 		memmove(rename_dst + first + 1, rename_dst + first,
@@ -82,11 +78,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
 	}
 
 	/* insert to make it at "first" */
-	if (rename_src_alloc <= rename_src_nr) {
-		rename_src_alloc = alloc_nr(rename_src_alloc);
-		rename_src = xrealloc(rename_src,
-				      rename_src_alloc * sizeof(*rename_src));
-	}
+	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
 	rename_src_nr++;
 	if (first < rename_src_nr)
 		memmove(rename_src + first + 1, rename_src + first,
-- 
1.8.5.3
