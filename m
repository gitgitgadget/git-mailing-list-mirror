From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 32/56] merge-recursive: Add comments about handling rename/add-source cases
Date: Thu, 11 Aug 2011 23:20:05 -0600
Message-ID: <1313126429-17368-33-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:22:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkCJ-0005Kt-GQ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab1HLFVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:41 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab1HLFVi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:38 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6cxTn/zQaq0KX7QfGZey9Zh58iH7pXRH54E+r4RF2kI=;
        b=Tobf/+EmJr/ppQWtIU1rdzFuzD/qVG7ngFwjKcdYItnpcxVl6eft3t2RgEUtba1Nk9
         F0EGmVjHhM2FEjoyHoXCD+EbyKuc4YtxgenndurmfOXflXnCmfdMqbPLXbLKlLyNmwBJ
         6qqU/CJhykCu3ZFZwKzAd0yP1pgi5aWNzKWlY=
Received: by 10.42.133.137 with SMTP id h9mr582695ict.392.1313126498041;
        Thu, 11 Aug 2011 22:21:38 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.36
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179200>

There are a couple of places where changes are needed to for situations
involving rename/add-source issues.  Add comments about the needed changes
(and existing bugs) until git has been enabled to detect such cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f74feb5..5f28905 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1087,6 +1087,9 @@ static int process_renames(struct merge_options *o,
 		}
 
 		ren1->dst_entry->processed = 1;
+		/* BUG: We should only mark src_entry as processed if we
+		 * are not dealing with a rename + add-source case.
+		 */
 		ren1->src_entry->processed = 1;
 
 		if (ren1->processed)
@@ -1113,6 +1116,10 @@ static int process_renames(struct merge_options *o,
 							      ren1->dst_entry,
 							      ren2->dst_entry);
 			} else {
+				/* BUG: We should only remove ren1_src in
+				 * the base stage (think of rename +
+				 * add-source cases).
+				 */
 				remove_file(o, 1, ren1_src, 1);
 				update_entry(ren1->dst_entry,
 					     ren1->pair->one,
@@ -1136,6 +1143,10 @@ static int process_renames(struct merge_options *o,
 			int renamed_stage = a_renames == renames1 ? 2 : 3;
 			int other_stage =   a_renames == renames1 ? 3 : 2;
 
+			/* BUG: We should only remove ren1_src in the base
+			 * stage and in other_stage (think of rename +
+			 * add-source case).
+			 */
 			remove_file(o, 1, ren1_src,
 				    renamed_stage == 2 || !was_tracked(ren1_src));
 
-- 
1.7.6.100.gac5c1
