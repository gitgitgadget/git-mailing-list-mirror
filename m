From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 11/11] attr.c: change handle_attr_line() to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 13:47:28 +0400
Message-ID: <53105B30.7010608@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:48:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJK3C-0007xU-4L
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbaB1JsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:48:07 -0500
Received: from forward2l.mail.yandex.net ([84.201.143.145]:49939 "EHLO
	forward2l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaB1JsG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:48:06 -0500
Received: from smtp17.mail.yandex.net (smtp17.mail.yandex.net [95.108.252.17])
	by forward2l.mail.yandex.net (Yandex) with ESMTP id 96CDF1AC0BAE
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:48:04 +0400 (MSK)
Received: from smtp17.mail.yandex.net (localhost [127.0.0.1])
	by smtp17.mail.yandex.net (Yandex) with ESMTP id 58763190060C
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:48:04 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp17.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id PxV4HKALJT-m3147WBb;
	Fri, 28 Feb 2014 13:48:03 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 66eb4999-5a7f-4d51-a7a1-f525e882677c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580884;
	bh=+0+2/kNbmPsuyaF8Q5g+WfhiKDkb4bncgDVDFacC0HI=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=pxpdUM+cu8Z/5jIXgVNN/Cfv7FO+l/qZwPzb/4LUCtMrVZReO83GTuFsLaaYjM/+0
	 jq3pD4cB1G2/ilOHPxADEiPO7bHURZM14No80HPlG35Q2USmpw+D08q7K+62zox1Mo
	 y+CFgK4PETscfb4p+k2WDzx7hDJJvI9BKPyEDSpk=
Authentication-Results: smtp17.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242931>

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
1.8.5.3
