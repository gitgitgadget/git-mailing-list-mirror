From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 11/14] attr.c: use ALLOC_GROW() in handle_attr_line()
Date: Tue,  4 Mar 2014 02:31:59 +0400
Message-ID: <1393885922-21616-12-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQ2-0002Y2-Kv
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbaCCWcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:54 -0500
Received: from forward10l.mail.yandex.net ([84.201.143.143]:57544 "EHLO
	forward10l.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755492AbaCCWct (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 17:32:49 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward10l.mail.yandex.net (Yandex) with ESMTP id 09975BA0D5E;
	Tue,  4 Mar 2014 02:32:43 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id B50AD1E1112;
	Tue,  4 Mar 2014 02:32:43 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-WhvCoxZO;
	Tue,  4 Mar 2014 02:32:43 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 7e4a0ce4-acc4-4237-8a14-6b2f473fb77e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885963;
	bh=/VDvc2j2wc64wBoyO/RGfTPM/TH1Fp6TKtEBgI+xJtc=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=OcRTQ4JiAvjGPWhiWs2APijaOa3fk6TAkw0OXiHrPtYMm/f1ihXqgHZhKddP/nY2g
	 Rx8LiJ1/uXj/yhfO7bKvMYW53IQng+ESzbypOSHhN2IRmiaRfgbXA9rXS69ChZpsJG
	 9EYgz5xzYRS7TnAHrV1fWLlIBq6k7Pg4zM6gZWs8=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243285>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 attr.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 8d13d70..734222d 100644
--- a/attr.c
+++ b/attr.c
@@ -338,12 +338,7 @@ static void handle_attr_line(struct attr_stack *res,
 	a = parse_attr_line(line, src, lineno, macro_ok);
 	if (!a)
 		return;
-	if (res->alloc <= res->num_matches) {
-		res->alloc = alloc_nr(res->num_matches);
-		res->attrs = xrealloc(res->attrs,
-				      sizeof(struct match_attr *) *
-				      res->alloc);
-	}
+	ALLOC_GROW(res->attrs, res->num_matches + 1, res->alloc);
 	res->attrs[res->num_matches++] = a;
 }
 
-- 
1.8.3.2
