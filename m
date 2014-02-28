From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 06/11] diffcore-rename.c: use ALLOC_GROW() instead of inline
 code
Date: Fri, 28 Feb 2014 13:44:10 +0400
Message-ID: <53105A6A.30200@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:44:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJK02-0002EM-17
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbaB1Jow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:44:52 -0500
Received: from forward9l.mail.yandex.net ([84.201.143.142]:60858 "EHLO
	forward9l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbaB1Jot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:44:49 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward9l.mail.yandex.net (Yandex) with ESMTP id EA0A0E60F0C
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:44:47 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 7E5361E13D9
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:44:47 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id BxWB0KFWLw-ikOGbxiM;
	Fri, 28 Feb 2014 13:44:47 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 986ff3fd-9ab0-4dd3-98ae-c024c55dd5be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580687;
	bh=6UmIKLDzObaVddEVR07QA8qMxN8eWOwTQOLhYeseEEs=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=eugsNEcXrv9T9OXOJsX+s2d/6n74cQsvwooy7fiziy17y8JlVPgq3OENd74M6pH30
	 cOmMsCMnjiXNgmLFwwgxiUHRcC/g+sjx7QmkKvyVRxXC/l6TyzpFE/hkkeLl2q3lE+
	 DFuEb27n+HzJWlbVEGuYEXJ9zA5mqzR4n9y2oU08=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242925>

Affected functions: locate_rename_dst(), register_rename_src()

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 diffcore-rename.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 9b4f068..fbf3272 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -38,11 +38,7 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
 	if (!insert_ok)
 		return NULL;
 	/* insert to make it at "first" */
-	if (rename_dst_alloc <= rename_dst_nr) {
-		rename_dst_alloc = alloc_nr(rename_dst_alloc);
-		rename_dst = xrealloc(rename_dst,
-				      rename_dst_alloc * sizeof(*rename_dst));
-	}
+	ALLOC_GROW(rename_dst, rename_dst_nr + 1, rename_dst_alloc);
 	rename_dst_nr++;
 	if (first < rename_dst_nr)
 		memmove(rename_dst + first + 1, rename_dst + first,
@@ -82,11 +78,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
 	}
 
 	/* insert to make it at "first" */
-	if (rename_src_alloc <= rename_src_nr) {
-		rename_src_alloc = alloc_nr(rename_src_alloc);
-		rename_src = xrealloc(rename_src,
-				      rename_src_alloc * sizeof(*rename_src));
-	}
+	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
 	rename_src_nr++;
 	if (first < rename_src_nr)
 		memmove(rename_src + first + 1, rename_src + first,
-- 
1.8.5.3
