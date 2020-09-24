Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67955C4727D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21384221EB
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCYj6CC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgIXMeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgIXMeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 08:34:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351BAC0613D4
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:34:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so3613100wrp.8
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2I9Y2hRuXgRqT6FgB1KECR88tDHWd7i0V/IscrZ+zbo=;
        b=vCYj6CC2E3tqXW0ogfe/xmkNsPtqkcJTT6h5ucsIF0+Li8yn+ojcZ2aKmoJNraLB/r
         j2URTmVgWTjVjpwOcos1OMnFboijHTZam5yZ67ilT95FcNHtadhYT6h1s2sEyFUCtFwP
         4d8jeKPV/cRT8ar2KMrZ8Xcd8x5dOZUMbw0Tt49lxDY6/3rNS0Ki4tuw3pqb32ffsjx0
         Lq3IfyI/Sobv46MCRyHL4ofExxPqnKFf/dIHZ9aGVPMiQGpOwPZWC/4tBHi61ClMc9PG
         V5m6iDT9EFaA3pe4j5uvbKgz00rmDODsK2ueVrsIbLsCBdYuzsQ8vkMeJQsZ1fQO+0Jz
         VqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2I9Y2hRuXgRqT6FgB1KECR88tDHWd7i0V/IscrZ+zbo=;
        b=eTTorYef5ebFjo4wTH37lwwc2k/3qSctzVoT6HgdGqRcEJ3HmRblkJDOyI8E0vHukg
         SrCbNanGSYmd+qogZOyy7Z+7klaNxPxP31mNm83rwoEjmMgakgOyIALhELSp67bAZEeE
         9xNf3lMPbw3B8qx9ntOlg3OYKg7a+UCWwuhCI2vIVZjq1s359V4PGAa5Og4GVaNITwYs
         XlnQkcESZkr+xwuvCdPc/jE1CMTfsB8kt6YJ5Lq3HIL/pFuBRc1edSullWVLh195rSsK
         0nPPV+lyB/eVzM0vrOnoj2H1NcOEfJ1ZdQcdfP9qOzrOevy6b1O83GgiJIinyIj/feYJ
         RlsA==
X-Gm-Message-State: AOAM530V75ubpO5dB5cWWiLe+JiJ/kS6CBjYZkM1m9h5+zxYRhVWtMS1
        qIv+GJxBEvr4djfefZK6k24wf4IJWf4=
X-Google-Smtp-Source: ABdhPJwZdPMUs9H+FAOV2gUbYhvvSZut3gbqXw90Q2uj3gUHfgV2dR+Z8JUvnZg3N34lQFiLfj/PGQ==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr5278368wrm.150.1600950842732;
        Thu, 24 Sep 2020 05:34:02 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id i83sm3485457wma.22.2020.09.24.05.34.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 05:34:02 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 5/6] bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
Date:   Thu, 24 Sep 2020 14:33:39 +0200
Message-Id: <20200924123340.52632-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200924123340.52632-1-mirucam@gmail.com>
References: <20200924123340.52632-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there can be other revision walks after bisect_next_all(),
let's add a call to a function to clear all the marks at the
end of bisect_next_all().

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bisect.c b/bisect.c
index d42a3a3767..c6aba2b9f2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1082,6 +1082,8 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
 	free(steps_msg);
+	/* Clean up objects used, as they will be reused. */
+	clear_commit_marks_all(ALL_REV_FLAGS);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
-- 
2.25.0

