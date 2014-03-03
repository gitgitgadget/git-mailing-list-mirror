From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 08/11] replace_object.c: use ALLOC_GROW() in register_replace_object()
Date: Mon, 03 Mar 2014 11:23:51 +0400
Message-ID: <53142E07.9000409@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:24:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNEm-0002s1-7s
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbaCCHY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:24:28 -0500
Received: from forward2l.mail.yandex.net ([84.201.143.145]:45364 "EHLO
	forward2l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbaCCHY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:24:27 -0500
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [37.140.190.27])
	by forward2l.mail.yandex.net (Yandex) with ESMTP id A9D571AC0E9A
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:24:26 +0400 (MSK)
Received: from smtp2o.mail.yandex.net (localhost [127.0.0.1])
	by smtp2o.mail.yandex.net (Yandex) with ESMTP id 61D2636A15A5
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:24:26 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id uSuahGotpL-OPeCNHg5;
	Mon,  3 Mar 2014 11:24:25 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 848d2a2e-52b5-403c-9a1c-1fd9f565680b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831466;
	bh=9KN6WJwvYWxydwlOsK9QNUEdSdQYVxqvuoV163j6YpI=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=suA4WBGWdywbhOIOdjyYZPMw/7toLmHsViCY2zb0IMBtx1PCSSN56Cm9AgN6vLC/e
	 kz/DTCl5SesPi+xOs/pmZpqsImE7RsiHMUrvh4bI+pMKWR2HoVKp6HAWSJjBsDuRW9
	 gm2+O8wuY5qjEwNCFonM0h5cBuC5MwRfQki6MZ90=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243187>

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
1.8.5.3
