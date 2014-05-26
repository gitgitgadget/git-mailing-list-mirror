From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 04/15] commit.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:45 +0900
Message-ID: <1401118436-66090-5-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WowwF-0006Md-WF
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbaEZPfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:35:43 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:55493 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbaEZPeu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:34:50 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so7739711pad.4
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U5/zBLj32I+AYaJBoa3F9WFnCpOARTfvB7AhnjjVteY=;
        b=MzZ8ZyK1gGDdBYvJ/pFwmFmdiFdjl+7FVdTsbAOpBmGDohMAOurqCbXmcTYHA0waCa
         2KrvaPW/PXRxZc4ticN5ftQssmOSdinP4Rx9mxZCjEKBmxSV237WPucDRu2hsE/obwIY
         u+MuLGtxIHQvIVBhVBfDuBOXCCqYoqeVGq8IwY60hoOqVctBY2D1oKGOYDYHTNg6CVOB
         kd6N6SvUZYVx0tquSedS4Hn76FmEPS6m+dbXXLD83NxorJpvKWB/TyRdasTT4F8Zj/UR
         7PhGyjJfw8GMN4SaU5fmx9e7GV5Ssd8Ypm1sAkf4NZtGtd9a+KQk2+ynAxRkCw/X5XUX
         Vqsg==
X-Received: by 10.66.253.170 with SMTP id ab10mr29273328pad.53.1401118490574;
        Mon, 26 May 2014 08:34:50 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:50 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250106>

xcalloc takes two arguments: the number of elements and their size.
reduce_heads passes the arguments in reverse order, passing the
size of a commit*, followed by the number of commit* to be allocated.
Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..0fe685f 100644
--- a/commit.c
+++ b/commit.c
@@ -1041,7 +1041,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 		p->item->object.flags |= STALE;
 		num_head++;
 	}
-	array = xcalloc(sizeof(*array), num_head);
+	array = xcalloc(num_head, sizeof(*array));
 	for (p = heads, i = 0; p; p = p->next) {
 		if (p->item->object.flags & STALE) {
 			array[i++] = p->item;
-- 
2.0.0.rc1.543.gc8042da
