Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150B2C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9E224683
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRwgHA0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgA1OlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33557 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgA1OlR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so16332176wrq.0
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBO/bOkGCdl6QTwKATRatKk/3LmebozvS+OJB1ptUKw=;
        b=oRwgHA0Ds3q1CABMFfhT04cMvOepkL0w+ogG3gcqe/EPmYArPOrk/6zRzHMqOs7ymV
         BbAm3cfXkTt75mgMnz6MIC6R2o8sLnFCR1TITvl5ggjjeXwlsuN0bylvtsUA7a4TP2iO
         FjEaeqWOMDGtHaNdkh50TQXfZRWktOb6/QIT9EPKFMSIve8JsfuusR3BYgMVt23LMJhm
         bplo+tYxMJF1diN0/ehQO1KS09nqO98AdK6twb/m8rO1747oJmgLsLW2MEb7MFtoJQa6
         u7JLdMI0sndDPO3ej1A9FRg7EcMzV/B8BxXV62GbR+MsYC0li97JMsSWC1jv0/8mUc98
         Rq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBO/bOkGCdl6QTwKATRatKk/3LmebozvS+OJB1ptUKw=;
        b=uiX3pcaZRDSA1blylCo9ogt7qNFkQyEnMp+LwzZ2pbkKrZu9jCh2B/xJkvkLVFQfHc
         2itpPYF8hRx9UDBBCx7lYF3C55xxQyaM/kXjRBQmMORDcFtMEJPRuRzrXMRTL23HHpEe
         pGS0rXUT+7L/3XSSNP9+H9FkSGjPinVyRtjQ3kwCGIsH7jUG3XFi4Tjrey8gCHIQ5EsK
         KoosPgZECw2X3kqeqashIMnOR7ZVMejW10OJhKfKbmNBSC+H56PWjA1MRaXSug/3qUto
         HSW2erORGfSZLmKb2LZs/E8QQ8KAryaiQ00mehKX2szQUc0kLKpHaU8tC2P7BXtPoIpP
         NawQ==
X-Gm-Message-State: APjAAAVDH8QKmJRG9Guh9yzdF3gzCkESLQAXbP0tyVvSWgaLZOPsg4dW
        Jy7ThN/VVGpkUP51nWX3B5Bnskf+
X-Google-Smtp-Source: APXvYqz9yvozQ0qIzY7npudFcNeHzSRxHWc2L19YjHcC6N+TH4FEYELX3RhEGVCnA+MTuTeIx6Uhhw==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr30149008wrw.313.1580222475675;
        Tue, 28 Jan 2020 06:41:15 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:15 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 03/11] bisect: use the standard 'if (!var)' way to check for 0
Date:   Tue, 28 Jan 2020 15:40:18 +0100
Message-Id: <20200128144026.53128-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200128144026.53128-1-mirucam@gmail.com>
References: <20200128144026.53128-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using 'var == 0' in an if condition, let's use '!var' and
make 'bisect.c' more consistent with the rest of the code.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index e81c91d02c..83cb5b3a98 100644
--- a/bisect.c
+++ b/bisect.c
@@ -572,7 +572,7 @@ static int sqrti(int val)
 {
 	float d, x = val;
 
-	if (val == 0)
+	if (!val)
 		return 0;
 
 	do {
@@ -869,7 +869,7 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 		goto done;
 
 	/* Bisecting with no good rev is ok. */
-	if (good_revs.nr == 0)
+	if (!good_revs.nr)
 		goto done;
 
 	/* Check if all good revs are ancestor of the bad rev. */
-- 
2.21.1 (Apple Git-122.3)

