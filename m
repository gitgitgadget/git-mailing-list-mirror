From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 02/11] bundle.c: use ALLOC_GROW() in add_to_ref_list()
Date: Mon, 03 Mar 2014 11:20:03 +0400
Message-ID: <53142D23.6000505@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:20:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNB7-0000Pk-DJ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbaCCHUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:20:41 -0500
Received: from forward2l.mail.yandex.net ([84.201.143.145]:44380 "EHLO
	forward2l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbaCCHUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:20:41 -0500
Received: from smtp11.mail.yandex.net (smtp11.mail.yandex.net [95.108.130.67])
	by forward2l.mail.yandex.net (Yandex) with ESMTP id 3DB991AC0E99
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:20:39 +0400 (MSK)
Received: from smtp11.mail.yandex.net (localhost [127.0.0.1])
	by smtp11.mail.yandex.net (Yandex) with ESMTP id EF7EC7E00CE
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:20:38 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp11.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id BHKmNfCM7P-KcmmMslb;
	Mon,  3 Mar 2014 11:20:38 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 110374fb-2fd2-490b-b5fb-25fd7d93fc55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831238;
	bh=LnR9tc9vNzkb9Ojph+53fCtZYJxxObDLtIZycnk+C9w=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=WrpZ0SM9lNclrs/aqcKUyfvYyBKG9jyLsUUIvOXY5P5rmP49O3HzQBln4YYx7NC+w
	 nmFESwCxm/lDN5cQA223cwCZlcJ0vAg1lXJrrWEOmPPvGhPkUDQFiPzy3FsCssjiAs
	 gY/gqrJm+MqUmoRLdhJWZb00GiTLhJqfBOk0iC3M=
Authentication-Results: smtp11.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243181>

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
1.8.5.3
