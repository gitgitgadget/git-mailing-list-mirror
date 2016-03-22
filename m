From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/3] builtin/apply: simplify gitdiff_{old,new}name()
Date: Tue, 22 Mar 2016 21:58:42 +0100
Message-ID: <1458680322-17681-4-git-send-email-chriscool@tuxfamily.org>
References: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 22:06:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiTVt-00013t-Nj
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbcCVVGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:06:46 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34160 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbcCVVGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:06:44 -0400
Received: by mail-wm0-f46.google.com with SMTP id p65so209330721wmp.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 14:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ba0/OcWuDRFaxWZOytN00b/g7pCBJ+BEdGfpFYv/2Vs=;
        b=vYTKPP9mglczWFzs7lfO6e54RkvkxfNHlaHdHjCnoLh7/eHEBbe6FbJYLVyUcKuACf
         HARO33LYKj41YE7+bHcNm/SqE7WFew1kh9oZ+AkaArtFhIasbP4rRxbehTJi+lMc4/dW
         BjCZOf0VyXIQ2xwbHiBakHNg7uyJD/qEjY8Wzjg81DvAUeL0AWY+IYuc8mQ8MpTZG6Wg
         yZZ/Tu1P5Qw+NLEdenuwRml3NB1CmSYKEBwn1W2NFvGKd6h7nJQTSKRVqzT0EnjL3G5a
         ik28pmIbDuGiQbfKLtnPDDFmRpeBAR+QU/dCfguQD0KWqXAkbMXAg+UPgPgDpVqTIC44
         n9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ba0/OcWuDRFaxWZOytN00b/g7pCBJ+BEdGfpFYv/2Vs=;
        b=LuxzBoo8ZgOLYbrIxuD3NPgIwSJXBBpuwwMKy4bRtAVWtOr7pm/sR6V5YyhkZAAcQw
         JGemkyM0YuHHY4MI8eZG+fl3J1JESVO7Ha2n1rAUGDk2WN1trwQHpgEJKvA5zl4c5IJQ
         zycRWCssjzB3GfLHdp9OgvMoRdG14c3QyfDy2umHiPmhqIZFxcGgELSJTeyuS/rO/KQ9
         56uBfbzyeR20/XFLcVW4j/aoNBvar9yK9RafKSWkSqtdXxzhIDkN6CJTc2reP/62SSE6
         VRwQfGtWfHyXCXd0fZxcrUPUJ3HGGYtDtRdJGAFdjNTd1FSP++pM0JbjrCIOgwaaefqn
         qFVw==
X-Gm-Message-State: AD7BkJIxDpQ4RNPHAjWg2AzwcYdbmMgJHRBZmCaSTo8+6g2gjFV1Uq21e+x8BbvCVnMikA==
X-Received: by 10.28.156.146 with SMTP id f140mr20934436wme.99.1458680803100;
        Tue, 22 Mar 2016 14:06:43 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id i5sm31920087wjx.15.2016.03.22.14.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 14:06:42 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc4.59.g21809a1
In-Reply-To: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289560>

After the previous simplifications, it is easy to see that
there is no need to free the original string passed to
gitdiff_verify_name(), because this string can be changed
only when it is NULL.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4cafdaf..9cfa9f4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -953,21 +953,15 @@ static void gitdiff_verify_name(const char *line, int isnull, char **name, int s
 
 static int gitdiff_oldname(const char *line, struct patch *patch)
 {
-	char *orig = patch->old_name;
 	gitdiff_verify_name(line, patch->is_new, &patch->old_name,
 			    DIFF_OLD_NAME);
-	if (orig != patch->old_name)
-		free(orig);
 	return 0;
 }
 
 static int gitdiff_newname(const char *line, struct patch *patch)
 {
-	char *orig = patch->new_name;
 	gitdiff_verify_name(line, patch->is_delete, &patch->new_name,
 			    DIFF_NEW_NAME);
-	if (orig != patch->new_name)
-		free(orig);
 	return 0;
 }
 
-- 
2.8.0.rc4.1.g302de0d.dirty
