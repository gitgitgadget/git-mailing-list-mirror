From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 11/11] attr.c: use ALLOC_GROW() in handle_attr_line()
Date: Mon, 03 Mar 2014 11:25:54 +0400
Message-ID: <53142E82.5080806@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:26:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNGl-0004FG-Tr
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbaCCH0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:26:31 -0500
Received: from forward9l.mail.yandex.net ([84.201.143.142]:59464 "EHLO
	forward9l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbaCCH0b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:26:31 -0500
Received: from smtp19.mail.yandex.net (smtp19.mail.yandex.net [95.108.252.19])
	by forward9l.mail.yandex.net (Yandex) with ESMTP id 9B648E60BE0
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:26:29 +0400 (MSK)
Received: from smtp19.mail.yandex.net (localhost [127.0.0.1])
	by smtp19.mail.yandex.net (Yandex) with ESMTP id 5C42ABE0094
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:26:29 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp19.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id GwAtQqxuaY-QS2mnvHx;
	Mon,  3 Mar 2014 11:26:28 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 46ecc9ad-3441-483b-b746-656a32d78852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831589;
	bh=+0+2/kNbmPsuyaF8Q5g+WfhiKDkb4bncgDVDFacC0HI=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=sFn3vaZYAUggcEM2Eyj/RQX2s9G/zqrM/+lxeO8OSNv84+jpP+qCkvtSqxtwqPf4W
	 SZ+t9GbqywBAsuRw8R5MvfGZVOUo5rWUWhE4NrLvape78VC2jvezNH8h2e/vxdqtJO
	 TAw4ihzQ2Ff5N+j6RPtrEdOZrExXNICFsD0H++50=
Authentication-Results: smtp19.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243190>

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
