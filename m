From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 07/11] patch-ids.c: use ALLOC_GROW() in add_commit()
Date: Mon, 03 Mar 2014 11:23:07 +0400
Message-ID: <53142DDB.40600@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:23:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNE9-0002SW-AM
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbaCCHXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:23:45 -0500
Received: from forward5l.mail.yandex.net ([84.201.143.138]:34626 "EHLO
	forward5l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbaCCHXn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:23:43 -0500
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [37.140.190.26])
	by forward5l.mail.yandex.net (Yandex) with ESMTP id 45095C40E59
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:23:42 +0400 (MSK)
Received: from smtp1o.mail.yandex.net (localhost [127.0.0.1])
	by smtp1o.mail.yandex.net (Yandex) with ESMTP id EFAEEDE148A
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:23:41 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 7CPrdPPFUJ-Nfc0LRFD;
	Mon,  3 Mar 2014 11:23:41 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 7c5def04-babd-4f95-93bf-b7e036425858
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831421;
	bh=sueayh8yx626EXZqyCjBbeey0pl3Au80HW4bGxSd8dk=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=V+g01MHrBXczypSG2Ud/QvwP28L5x6rPsg08lzOxLWeSkzyhqPYYRrOjaz86KYCvx
	 KLVrAddOm94pz3//4+SoJwxm//ybqYF2hY6U0P9Ns0DECGhFHx+jkHiYTCOSSS08V8
	 vCMNNPj7cGItXbnC7GgcC/5+UhRQcNM6qM6T8T/s=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243186>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 patch-ids.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index bc8a28f..bf81b92 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -83,10 +83,7 @@ static struct patch_id *add_commit(struct commit *commit,
 	ent = &bucket->bucket[bucket->nr++];
 	hashcpy(ent->patch_id, sha1);
 
-	if (ids->alloc <= ids->nr) {
-		ids->alloc = alloc_nr(ids->nr);
-		ids->table = xrealloc(ids->table, sizeof(ent) * ids->alloc);
-	}
+	ALLOC_GROW(ids->table, ids->nr + 1, ids->alloc);
 	if (pos < ids->nr)
 		memmove(ids->table + pos + 1, ids->table + pos,
 			sizeof(ent) * (ids->nr - pos));
-- 
1.8.5.3
