From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 07/14] patch-ids.c: use ALLOC_GROW() in add_commit()
Date: Tue,  4 Mar 2014 02:31:55 +0400
Message-ID: <1393885922-21616-8-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQ3-0002Y2-6p
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbaCCWcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:43 -0500
Received: from forward4l.mail.yandex.net ([84.201.143.137]:37251 "EHLO
	forward4l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbaCCWcm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:42 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward4l.mail.yandex.net (Yandex) with ESMTP id 7FBAB1440D12;
	Tue,  4 Mar 2014 02:32:40 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 377601E1112;
	Tue,  4 Mar 2014 02:32:40 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-Wdv8d8Op;
	Tue,  4 Mar 2014 02:32:39 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: a17aec35-4bda-486b-822d-470c0648e8b5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885960;
	bh=cj5FGw9mD16Ay9LF0jGU24xbRwZX/7IWpuuZjxm/tco=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=OKcZGDRSX387+K/Y+DH2Sa+SAfAkWzlrPTHt8o4nhw7Rfu7Ru58BTyEE+G8vWQdx2
	 kSDXdmpkjeOwDwF7dzEwNOn3FiCOx1cXickNHXOmhxw0BTHGBu2sOwaDwwNw+PpANT
	 zl7liqKfjvJRifkf/lMzwxm2nG91mcnthNyS39f0=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243287>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 patch-ids.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index bc8a28f..bf81b92 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -83,10 +83,7 @@ static struct patch_id *add_commit(struct commit *commit,
 	ent = &bucket->bucket[bucket->nr++];
 	hashcpy(ent->patch_id, sha1);
 
-	if (ids->alloc <= ids->nr) {
-		ids->alloc = alloc_nr(ids->nr);
-		ids->table = xrealloc(ids->table, sizeof(ent) * ids->alloc);
-	}
+	ALLOC_GROW(ids->table, ids->nr + 1, ids->alloc);
 	if (pos < ids->nr)
 		memmove(ids->table + pos + 1, ids->table + pos,
 			sizeof(ent) * (ids->nr - pos));
-- 
1.8.3.2
