From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 02/14] bundle.c: use ALLOC_GROW() in add_to_ref_list()
Date: Tue,  4 Mar 2014 02:31:50 +0400
Message-ID: <1393885922-21616-3-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:32:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbPg-0002IJ-1f
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbaCCWck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:40 -0500
Received: from forward3l.mail.yandex.net ([84.201.143.136]:45764 "EHLO
	forward3l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbaCCWci (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:38 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward3l.mail.yandex.net (Yandex) with ESMTP id 31E431500E5D;
	Tue,  4 Mar 2014 02:32:36 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id DEBD01E1112;
	Tue,  4 Mar 2014 02:32:35 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-WZvC91DB;
	Tue,  4 Mar 2014 02:32:35 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: ac38a0ce-486d-4baf-8277-23852f9dbcaa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885955;
	bh=30GMCSL037YX5GkT65GkbTSpRbKDPT55Tj57fJtiyz4=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=U3bypu816n7KLDP3SVYlrl9j39Gx9SpQisFG1c3da/D15IvvNvy8ySsDyP2zeg7MU
	 aQpgmgEkQw/5ahUfwH4kKEFe0sfsvXGHBuRQicQtjII5PRkimgdummc9mVjPxYzakb
	 RIjirX8XRaIKbhigBWCCgi7lrBkCXvsaqIWrdMNk=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243280>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 bundle.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index e99065c..1388a3e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -14,11 +14,7 @@ static const char bundle_signature[] = "# v2 git bundle\n";
 static void add_to_ref_list(const unsigned char *sha1, const char *name,
 		struct ref_list *list)
 {
-	if (list->nr + 1 >= list->alloc) {
-		list->alloc = alloc_nr(list->nr + 1);
-		list->list = xrealloc(list->list,
-				list->alloc * sizeof(list->list[0]));
-	}
+	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
 	memcpy(list->list[list->nr].sha1, sha1, 20);
 	list->list[list->nr].name = xstrdup(name);
 	list->nr++;
-- 
1.8.3.2
