From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 06/14] diffcore-rename.c: use ALLOC_GROW()
Date: Tue,  4 Mar 2014 02:31:54 +0400
Message-ID: <1393885922-21616-7-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQV-0002rx-4n
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbaCCWdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:33:07 -0500
Received: from forward6l.mail.yandex.net ([84.201.143.139]:44875 "EHLO
	forward6l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454AbaCCWck (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:40 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward6l.mail.yandex.net (Yandex) with ESMTP id A24D014E0F67;
	Tue,  4 Mar 2014 02:32:39 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 5AA001E1112;
	Tue,  4 Mar 2014 02:32:39 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-Wcv0Y9No;
	Tue,  4 Mar 2014 02:32:39 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 0e3da018-a0e8-4533-89d1-5f8fbddf474e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885959;
	bh=nmGY2oYMOrohkMg8IVBAySYMouCNBmhdYet9DYEAQt0=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=WV1auEF+BcOuHcCl6JIgY5KSDrAz77fatbPPJbFsrtEVKDa9etaV3LdHLDcDmSWcb
	 HHt++2d6+3xT9ksykZmPrHeDzADvdPs9TXv3qb+t5gk0u8GhvsnwaAR2oRNlbv1w9L
	 MMkAK919jzIMbtoCc9ORP/zO87YPl/F7X+fTDM8c=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243291>

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
1.8.3.2
