From: Zheng Liu <gnehzuil.liu@gmail.com>
Subject: [PATCH] Remove useless code about diffcore_count_changes()
Date: Fri, 18 Nov 2011 09:43:36 +0800
Message-ID: <1321580616-19281-1-git-send-email-wenqing.lz@taobao.com>
Cc: Zheng Liu <wenqing.lz@taobao.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 02:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRDSp-0006l2-7A
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 02:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635Ab1KRBlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 20:41:55 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35608 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab1KRBly (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 20:41:54 -0500
Received: by yenq3 with SMTP id q3so1895777yen.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 17:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=z6SIcn49x8udVSJvRS116WpXAkT77u6pkNcxXqABX0U=;
        b=QrcdAKKMEdiH8pMCwsu5zx7nFvGxKMTFab/t0QTN+HBFgSwBhJnScKXo53/2efOLGm
         WyFzq062ElHL69W3RSKVdsiUohM/MJeBN22BZgovKno0B877a8IPwMdP9F+EK2U6o8NW
         frLbSSXINqPkwsAWyravDu6AYhPaJvvgUrEAA=
Received: by 10.50.207.38 with SMTP id lt6mr974766igc.43.1321580513959;
        Thu, 17 Nov 2011 17:41:53 -0800 (PST)
Received: from localhost.localdomain ([182.92.247.2])
        by mx.google.com with ESMTPS id e2sm64766541ibe.0.2011.11.17.17.41.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 17:41:53 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185622>

We don't need to check return value because it always returns zero in
diffcore_count_changes().

Signed-off-by: Zheng Liu <wenqing.lz@taobao.com>
---
 diffcore-break.c  |    7 ++-----
 diffcore-rename.c |    7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 44f8678..402bba1 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -68,11 +68,8 @@ static int should_break(struct diff_filespec *src,
 	if (max_size < MINIMUM_BREAK_SIZE)
 		return 0; /* we do not break too small filepair */
 
-	if (diffcore_count_changes(src, dst,
-				   &src->cnt_data, &dst->cnt_data,
-				   0,
-				   &src_copied, &literal_added))
-		return 0;
+	diffcore_count_changes(src, dst, &src->cnt_data, &dst->cnt_data, 0,
+			       &src_copied, &literal_added);
 
 	/* sanity */
 	if (src->size < src_copied)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index f639601..969482f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -182,11 +182,8 @@ static int estimate_similarity(struct diff_filespec *src,
 
 	delta_limit = (unsigned long)
 		(base_size * (MAX_SCORE-minimum_score) / MAX_SCORE);
-	if (diffcore_count_changes(src, dst,
-				   &src->cnt_data, &dst->cnt_data,
-				   delta_limit,
-				   &src_copied, &literal_added))
-		return 0;
+	diffcore_count_changes(src, dst, &src->cnt_data, &dst->cnt_data,
+			       delta_limit, &src_copied, &literal_added);
 
 	/* How similar are they?
 	 * what percentage of material in dst are from source?
-- 
1.7.5.4
