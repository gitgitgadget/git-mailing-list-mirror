Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B40C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB44206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRD+/q03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbgGANfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbgGANfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A1C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so23836113wrs.11
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJBqQyCyaifjDmIyIOSXfw9cRsG6/XuqaQklreu6lS0=;
        b=bRD+/q03oH9xvfGf3DO48XogT2ln8rV16swLRCXc12C45x3brFsbwmMMkvToKDAaOq
         tDjt4YA7rllNeqgCXxO7/1aAHyzoXxodBaDgpjIMuRPw8KWfvCDLUlr6WZY7nV4+ypDd
         cj2g0rxyPhYStYevBSWiiSn71R7TWlH2/J6yec/oTcyGpQKMFvKkeQjPgw9Au2TjAavE
         IJDWTcPBjsfB34D+y9Oc4dsjWLVBDObKT+Dzot2u45P1Y8/pn3t/XfGv7qVsdNXodRB6
         b6SLg/0kfb1YCR0KmeWbd7hkiQ04H/cJPPMWCH7SrWmmgHxfkFCvYnu5SDqCIbv93GDL
         Gj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJBqQyCyaifjDmIyIOSXfw9cRsG6/XuqaQklreu6lS0=;
        b=ZfGOFATKQj3+IS5icAwIywoGTncRW4F3y9EMUK+7igYnVBENt1a7e4VylAexWF9CR9
         WjmNOD0/Y3vxfGrpL/c3TTib8+NtLKs4ZVDeWwyQJm04DMI+cuXfhd9CNl2p4U54LbQP
         KOY2TjCc3enzNUbnjpCoOxCV2JShrbmXYO34J4KmKUQs6zo1y9O5fYBOHhfo7B4BPTIM
         Id7QSbK3oEpucDnmWpIbId3oJ0fajxIM32Cds2D8uvvBtfX8Q52zw7+Z74kCPyl3RwH6
         yznUIWaMXv/IGpB9Zm8xGK1swiTJnsQDGw1v3iwvhKhH8leC8X4z8OxD6z/cSEsOT904
         pZkg==
X-Gm-Message-State: AOAM532vvvDet9Xrh6VGliUYr0s65eiBNMLzYBBX/ucccWqfF5igplhL
        HBT1HYr0QqTgx+3T/NvNeh6RukRuxIg=
X-Google-Smtp-Source: ABdhPJw4+N798pepeOsOhMPNByb2X2fC0f3+f8jMObGC3O1j3n3qTssFFMBVSW084ToIQL1c3WgzEA==
X-Received: by 2002:a05:6000:1182:: with SMTP id g2mr25064356wrx.44.1593610535464;
        Wed, 01 Jul 2020 06:35:35 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:34 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 05/13] bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
Date:   Wed,  1 Jul 2020 15:34:56 +0200
Message-Id: <20200701133504.18360-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200701133504.18360-1-mirucam@gmail.com>
References: <20200701133504.18360-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
index d5e830410f..db00850065 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1064,6 +1064,8 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
 	free(steps_msg);
+	/* Clean up objects used, as they will be reused. */
+	clear_commit_marks_all(ALL_REV_FLAGS);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
-- 
2.25.0

