From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 02/11] bundle.c: change add_to_ref_list() to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 13:41:30 +0400
Message-ID: <531059CA.4020700@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:42:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJxS-0007Yk-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbaB1JmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:42:12 -0500
Received: from forward12.mail.yandex.net ([95.108.130.94]:46449 "EHLO
	forward12.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbaB1JmK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:42:10 -0500
Received: from smtp14.mail.yandex.net (smtp14.mail.yandex.net [95.108.131.192])
	by forward12.mail.yandex.net (Yandex) with ESMTP id B60AAC22504
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:42:06 +0400 (MSK)
Received: from smtp14.mail.yandex.net (localhost [127.0.0.1])
	by smtp14.mail.yandex.net (Yandex) with ESMTP id 9342C1B600AC
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:42:06 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp14.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id uTKsWhd18Y-g62a55N5;
	Fri, 28 Feb 2014 13:42:06 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 1b5a6ca6-6fbb-4a4b-8080-927aa59945b2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580526;
	bh=LnR9tc9vNzkb9Ojph+53fCtZYJxxObDLtIZycnk+C9w=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=Y0UkZJIOaS/88uSELfLs4Ye34PX8CJ049DPtHcN4Y3RNTw5Ro05UmZ9L2vcxfVqZh
	 qXyLmYEnmpMA5bC3CklPerx05GJYHqm2d+beqEfx2aRNxooUfv0M8/J3kiPufgdSJP
	 gfI/jy65OCHHCt/0Q1L02w+BFxtkpuRk3rGqjfuE=
Authentication-Results: smtp14.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242921>

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
