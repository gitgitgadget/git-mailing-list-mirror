From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 08/14] replace_object.c: use ALLOC_GROW() in register_replace_object()
Date: Tue,  4 Mar 2014 02:31:56 +0400
Message-ID: <1393885922-21616-9-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbPz-0002Y2-SL
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbaCCWco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:44 -0500
Received: from forward5l.mail.yandex.net ([84.201.143.138]:44743 "EHLO
	forward5l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472AbaCCWcm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:42 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward5l.mail.yandex.net (Yandex) with ESMTP id 5F97DC40FE6;
	Tue,  4 Mar 2014 02:32:41 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 17D5F1E1112;
	Tue,  4 Mar 2014 02:32:41 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-WevOdYha;
	Tue,  4 Mar 2014 02:32:40 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: b238c0b9-83bc-4421-82b5-c70fa7fe5c27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885960;
	bh=c4Wr8n8v1stgZW9TpGmydVK1OXPCXlGGBWDZP+tagW8=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=kScxnflC7vaVAxrlqcSg22ScAFTEIYs/KE7pLGjEdx+hNTW36dF1mYzIjRwyZW/lY
	 H8bROp2dVo8jxTEwI84z/oJeR74fmLFpLDHA/GnIgL6+uGg7rDoMMptnvwT9M14djR
	 fVlH1YdRpD8pYQcpFlAiD2861wsF/RsLfj0+ElAU=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243281>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 replace_object.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/replace_object.c b/replace_object.c
index cdcaf8c..843deef 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -36,12 +36,8 @@ static int register_replace_object(struct replace_object *replace,
 		return 1;
 	}
 	pos = -pos - 1;
-	if (replace_object_alloc <= ++replace_object_nr) {
-		replace_object_alloc = alloc_nr(replace_object_alloc);
-		replace_object = xrealloc(replace_object,
-					  sizeof(*replace_object) *
-					  replace_object_alloc);
-	}
+	ALLOC_GROW(replace_object, replace_object_nr + 1, replace_object_alloc);
+	replace_object_nr++;
 	if (pos < replace_object_nr)
 		memmove(replace_object + pos + 1,
 			replace_object + pos,
-- 
1.8.3.2
