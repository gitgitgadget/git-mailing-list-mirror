From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 08/11] replace_object.c: change register_replace_object()
 to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 13:45:41 +0400
Message-ID: <53105AC5.8000607@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:46:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJK1R-00088Q-T3
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbaB1JqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:46:20 -0500
Received: from forward2l.mail.yandex.net ([84.201.143.145]:49428 "EHLO
	forward2l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaB1JqT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:46:19 -0500
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [37.140.190.29])
	by forward2l.mail.yandex.net (Yandex) with ESMTP id 197FB1AC0F2C
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:46:18 +0400 (MSK)
Received: from smtp4o.mail.yandex.net (localhost [127.0.0.1])
	by smtp4o.mail.yandex.net (Yandex) with ESMTP id C5CD52321400
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:46:17 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id hmfoQq1I8r-kHYGsBPV;
	Fri, 28 Feb 2014 13:46:17 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: a7d74770-4507-405a-8046-62ce58218da7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580777;
	bh=9KN6WJwvYWxydwlOsK9QNUEdSdQYVxqvuoV163j6YpI=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=w+9dIhISJ4YPcj0QeCZ+Y+Ycj3Lm2Yj6CJdazqwYWBC8NZQe9byyuWza+uk8CY6/f
	 kAwV9xeKCnLHTFC/ZUQdTcMYYXbEABOYgxk5my0eOiBPT2sp9jDLlp9iAzVy7aetVk
	 Qwb6BjrARiIo79uBPSToFi21cxpkdD4PJQDtstmk=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242927>

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
