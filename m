From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 1/8] merge-recursive: remove dead conditional in update_stages()
Date: Sat, 22 Feb 2014 10:17:49 +0100
Message-ID: <f68a6a74ecf23db6c565d59abee23587545b6d6c.1393059605.git.tr@thomasrast.ch>
References: <cover.1393059605.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 10:18:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH8jU-0003yP-Nm
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 10:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbaBVJSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 04:18:41 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:34851 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbaBVJSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 04:18:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id D379E4D64BD;
	Sat, 22 Feb 2014 10:18:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id L_q9EsQXTqNx; Sat, 22 Feb 2014 10:17:59 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id BD3F74D6590;
	Sat, 22 Feb 2014 10:17:58 +0100 (CET)
X-Mailer: git-send-email 1.9.0.313.g3d0a325
In-Reply-To: <cover.1393059605.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242522>

From: Thomas Rast <trast@inf.ethz.ch>

650467c (merge-recursive: Consolidate different update_stages
functions, 2011-08-11) changed the former argument 'clear' to always
be true.  Remove the useless conditional.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8400a8e..c36dc79 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -545,11 +545,9 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 	 * would_lose_untracked).  Instead, reverse the order of the calls
 	 * (executing update_file first and then update_stages).
 	 */
-	int clear = 1;
 	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
-	if (clear)
-		if (remove_file_from_cache(path))
-			return -1;
+	if (remove_file_from_cache(path))
+		return -1;
 	if (o)
 		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options))
 			return -1;
-- 
1.9.0.313.g3d0a325
