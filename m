From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Wed, 17 Feb 2016 00:30:05 +0530
Message-ID: <1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 19:59:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkqh-00082n-Vg
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 19:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933176AbcBPS7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 13:59:45 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35518 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbcBPS7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 13:59:43 -0500
Received: by mail-pa0-f41.google.com with SMTP id ho8so109308952pac.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 10:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q+VPI9b8zRXXAMGCK7zAnBSZXU9R8y0J7vtbWz+vv0c=;
        b=YcQNYR6fnk78sjoMrOFA7nHiQcIdIyZDS+xjFlp+w6uV4aCzeMus9byMR1OZgYjvKH
         M8FveMA9u1607JK5PWUnzLf2cR91mQ5c9HEUpqI6DWf4EDyoT9g8XSdXouMzru1x41oh
         nISX++eAo3gTctDTOtidj5hv7F5cGykyUwTenmbyEgFDS3nq/mKrZSh5/x6FHgNjjS9m
         KZQ5BylVbjs1jLpKpMsZcPjQoIoeK16+8K7EZUeNiY+k28bX2Sd1K48ilwONYMr/k7lQ
         oZ0oFBkfza7JDOdET636WnSQ3vIWp3zQriNQBOkq+q92CnRLGLE9G7/6BYP+5GS5WoVW
         ERIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q+VPI9b8zRXXAMGCK7zAnBSZXU9R8y0J7vtbWz+vv0c=;
        b=R6DaoFQlXcWFhsN8BOxFtG02voOVp64bVb15SavNKtmY6rExNFAUMmWva3c+ihXFg3
         lOOofuDchaGSztql24ArFyL0zsyJadVtLSXwJDBOK2CQpMhe+sMFkKlAm0pmsB6TqakU
         pQTbCMgBx7wd+abKXO2G78wkCO2+Hzqh4Aq9QYu8QjCs6/hLSQ9U5ccFOss1aSxaVaNN
         /Rhy02oPEarhgK9bVqqeBsY4MMHJ+q4SiG5Ow1056q3fQr54bk8UGO3nD332fxXxygnf
         rzA3LeAFvTSMOd6qxXnrR1RHJaCf40M70KMnZNMlbg7xCYdTVZEYC7RyK4SucFp+2vr7
         jnRg==
X-Gm-Message-State: AG10YOQDpS8kC2o1FLpQg5l+FYgQ8pfeRJ2bFh88mLX8lGbbYUjalnjv3y/o8f0sF97jdQ==
X-Received: by 10.66.124.170 with SMTP id mj10mr33298722pab.92.1455649183377;
        Tue, 16 Feb 2016 10:59:43 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.10.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 10:59:42 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286415>

Use the newly introduced strbuf_split_str_omit_term() rather than
using strbuf_split_str() and manually removing the ',' terminator.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f097176..38f38d4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -892,18 +892,11 @@ static void populate_value(struct ref_array_item *ref)
 			if (!valp)
 				die(_("expected format: %%(align:<width>,<position>)"));
 
-			/*
-			 * TODO: Implement a function similar to strbuf_split_str()
-			 * which would omit the separator from the end of each value.
-			 */
-			s = to_free = strbuf_split_str(valp, ',', 0);
+			s = to_free = strbuf_split_str_omit_term(valp, ',', 0);
 
 			align->position = ALIGN_LEFT;
 
 			while (*s) {
-				/*  Strip trailing comma */
-				if (s[1])
-					strbuf_setlen(s[0], s[0]->len - 1);
 				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
 					;
 				else if (!strcmp(s[0]->buf, "left"))
-- 
2.7.1
