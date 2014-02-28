From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 01/11] builtin/pack-objects.c: change check_pbase_path()
 to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 13:40:37 +0400
Message-ID: <53105995.3010001@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:41:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJwm-0004mf-F6
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbaB1Jla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:41:30 -0500
Received: from forward13.mail.yandex.net ([95.108.130.120]:43080 "EHLO
	forward13.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbaB1Jl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:41:28 -0500
Received: from smtp13.mail.yandex.net (smtp13.mail.yandex.net [95.108.130.68])
	by forward13.mail.yandex.net (Yandex) with ESMTP id C5C68141B2B
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:41:13 +0400 (MSK)
Received: from smtp13.mail.yandex.net (localhost [127.0.0.1])
	by smtp13.mail.yandex.net (Yandex) with ESMTP id A40BFE4005A
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:41:13 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp13.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id s7uayGnkO4-fDEa545q;
	Fri, 28 Feb 2014 13:41:13 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: d778321d-2fb3-4fab-a0ad-3a4f65194a1b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580473;
	bh=Wp8WD89eqedhy081Bo2Dukx0ILbpiZ9uTVSDt7XCGis=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=gM5ZV7DP3Np/9I3GRqgOSlXy2m3WcjxaQOETRf6lVpuBEGIlHDx2j4BSMnNq/QVC7
	 zXLGBUdMomtu+nxQU4lvQjM7SpSRI73SIQxasW3Ii9j+LaDaVFHmDLj77x0G+YW9tx
	 mBoFr6yAVQngD8m5jOtztQHPH/ArlSgLLeXtnfBU=
Authentication-Results: smtp13.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242920>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 builtin/pack-objects.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..56a6fc8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1213,12 +1213,7 @@ static int check_pbase_path(unsigned hash)
 	if (0 <= pos)
 		return 1;
 	pos = -pos - 1;
-	if (done_pbase_paths_alloc <= done_pbase_paths_num) {
-		done_pbase_paths_alloc = alloc_nr(done_pbase_paths_alloc);
-		done_pbase_paths = xrealloc(done_pbase_paths,
-					    done_pbase_paths_alloc *
-					    sizeof(unsigned));
-	}
+	ALLOC_GROW(done_pbase_paths, done_pbase_paths_num + 1, done_pbase_paths_alloc);
 	done_pbase_paths_num++;
 	if (pos < done_pbase_paths_num)
 		memmove(done_pbase_paths + pos + 1,
-- 
1.8.5.3
