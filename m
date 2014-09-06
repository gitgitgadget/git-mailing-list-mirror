From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 1/8] merge-recursive: remove dead conditional in update_stages()
Date: Sat,  6 Sep 2014 19:56:59 +0200
Message-ID: <407c0fe475316267949c3043d8e6457ae793835c.1409860234.git.tr@thomasrast.ch>
References: <cover.1409860234.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 19:57:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQKEn-0005cx-Ie
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 19:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbaIFR5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 13:57:21 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:40764 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbaIFR5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 13:57:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 9BE444D66AE;
	Sat,  6 Sep 2014 19:57:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Q7tu8W7QLMYY; Sat,  6 Sep 2014 19:57:08 +0200 (CEST)
Received: from linux.local (unknown [65.50.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 3485F4D65CD;
	Sat,  6 Sep 2014 19:57:06 +0200 (CEST)
X-Mailer: git-send-email 2.1.0.72.g9b94086
In-Reply-To: <cover.1409860234.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256590>

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
index 1d332b8..4459607 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -547,11 +547,9 @@ static int update_stages(const char *path, const struct diff_filespec *o,
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
2.1.0.72.g9b94086
