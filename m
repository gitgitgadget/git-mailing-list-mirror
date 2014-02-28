From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 07/11] patch-ids.c: change add_commit() to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 13:45:01 +0400
Message-ID: <53105A9D.9040400@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:45:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJK0o-0005Sp-Ra
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbaB1Jpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:45:42 -0500
Received: from forward4l.mail.yandex.net ([84.201.143.137]:48522 "EHLO
	forward4l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbaB1Jpk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:45:40 -0500
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [37.140.190.27])
	by forward4l.mail.yandex.net (Yandex) with ESMTP id 7F4F81440DA0
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:45:37 +0400 (MSK)
Received: from smtp2o.mail.yandex.net (localhost [127.0.0.1])
	by smtp2o.mail.yandex.net (Yandex) with ESMTP id 3089F36A156E
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:45:37 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 9KlN3CDHIj-jaresYBb;
	Fri, 28 Feb 2014 13:45:36 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: b3c86f40-f496-427e-a2c9-7fd5e4dd0a38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580736;
	bh=sueayh8yx626EXZqyCjBbeey0pl3Au80HW4bGxSd8dk=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=SfvivDD80VpjtroeGNXgEPHd4e2fGG77bgJmIg9U/YytduP4RgopzXzkRjoNBLJSw
	 Kp3SLX/BL6wRyDetmy1cA4uJ9eRAZQmgEs4rYXQ0i/z/Kbmcc6oxXRNRsxOJJ4DDq5
	 1xxkXlYViHc5H6HDhS01UPpPV8IunSDHx9BNPTug=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242926>

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
