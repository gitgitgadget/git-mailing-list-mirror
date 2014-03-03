From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 14/14] sha1_file.c: use ALLOC_GROW() in pretend_sha1_file()
Date: Tue,  4 Mar 2014 02:32:02 +0400
Message-ID: <1393885922-21616-15-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQ1-0002Y2-Gz
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbaCCWcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:48 -0500
Received: from forward4l.mail.yandex.net ([84.201.143.137]:37256 "EHLO
	forward4l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbaCCWcr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:47 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward4l.mail.yandex.net (Yandex) with ESMTP id A5D1E1440D12;
	Tue,  4 Mar 2014 02:32:46 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 679101E1112;
	Tue,  4 Mar 2014 02:32:46 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-WkvaqYQU;
	Tue,  4 Mar 2014 02:32:46 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: befaa39a-6bb1-456d-93ad-a804b43a587a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885966;
	bh=WUFr42EFeHbs6Fp6FXO5dpkJmEfGR66GM0q8FEgjNEc=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=Aml4gYto+Eq9fYa7ZOvGGzhKp/2d738ZJNQT2AWZVFgCOYNFgfQRUYTjuq1rqALP1
	 UuDmhI32+G7qLpXnJIZEH6nBflkyPvWkdEFRUDUEYmZo4Tx2hb8jIrrWvgAQAPHtqi
	 KYn1vdL0mmJ+Bq1UECb3aE7zx5PpWDrmuTVxvS4s=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243283>

Helped-by: He Sun <sunheehnus@gmail.com>
Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 sha1_file.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 019628a..3cb17b8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2624,12 +2624,7 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 	hash_sha1_file(buf, len, typename(type), sha1);
 	if (has_sha1_file(sha1) || find_cached_object(sha1))
 		return 0;
-	if (cached_object_alloc <= cached_object_nr) {
-		cached_object_alloc = alloc_nr(cached_object_alloc);
-		cached_objects = xrealloc(cached_objects,
-					  sizeof(*cached_objects) *
-					  cached_object_alloc);
-	}
+	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
 	co = &cached_objects[cached_object_nr++];
 	co->size = len;
 	co->type = type;
-- 
1.8.3.2
