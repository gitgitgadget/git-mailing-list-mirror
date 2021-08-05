Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCF4C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3942610CD
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbhHEXDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 19:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhHEXDt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 19:03:49 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1663AC061798
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 16:03:34 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id dk2so3907678qvb.3
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0w2ZWyCz+3Q5f/O7IJjGcAHV2u3++QqgDNFYMB0Z2A=;
        b=M6nZL9rPjINGCOLFuY8sgnC5AGcQJmkWG1RA5PT/bYzzjgc/qW6m9QetMj4G+Tbt0g
         Sm4gHJrZLboeCM6zMaB/Dy76eJOMQ+eiLAebDbeOXSUcPJMsTwOrR/EzA/1SHO7AApHf
         AOGU0P9DbZ+nQ+yRr5uZZg4aOj5LV3HuQnmdekyTZroRYjWtlb3XZ71j6znvaJqnnG/x
         ZVzgZbVy26I7bSjJwC/7PHrHi/hmikzETEzknfsaYQrjMQHL1s0Pom7wC9jQ1690cXBT
         95hQzARuWZozo8PKnSvqOR2davoEW6FevcVDR5Fnqkmhvdb7ghn1nK0vU4qn43Hg+Y/g
         AXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0w2ZWyCz+3Q5f/O7IJjGcAHV2u3++QqgDNFYMB0Z2A=;
        b=CNMjW18kdI2f60Iju1vu10qoq0u8Aq2pfL7LQCzCNCAdBp8yJ548hLUhVNZhhByE2w
         ceA397GBjugTJavK6uncfVSHkhcg5l/7z1SYC7rf8SE63KkDmAhivtesky9ivdAQOG5B
         DaYPpW/kF4eqPAmkRJ+DxeWhG7VpzIwAURirCR4HQLRq+mLLb9Et0RFuL8jR0vERclop
         pLDmhaoue2notu5cpz3EAyR5mz4mhB+2VNWRmNz6vGFgMfyM2b0U+njtMSM5ZHEOc3UJ
         K/YbLJWf+/lmE7pJ3daYnjgVj7yjNS2ElvNMgBWtVHGi6ahyGMAj6xa0PVtvEILOUSAA
         J05g==
X-Gm-Message-State: AOAM530hjmRasNCPnRGbrewAO1EdBFABxFk3R7yjofAdtcQ1+8h3/4pn
        mrCIGEWgNAH+q1iEIOe2r4qTSOtkhqY=
X-Google-Smtp-Source: ABdhPJyG2VoI+cvzj2sA7r5W7fMaSGpRwRBbJMGK30J23H9RDg6kfKP1PcdRoOeRUIK3VfIRnJLtEw==
X-Received: by 2002:a05:6214:528a:: with SMTP id kj10mr7985219qvb.38.1628204612792;
        Thu, 05 Aug 2021 16:03:32 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id bi3sm3086410qkb.133.2021.08.05.16.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 16:03:32 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] advice: add enum variants for missing advice variables
Date:   Thu,  5 Aug 2021 19:03:18 -0400
Message-Id: <20210805230321.532218-2-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210805230321.532218-1-mathstuf@gmail.com>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
 <20210805230321.532218-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In daef1b300b0 (Merge branch 'hw/advice-add-nothing', 2020-02-14), two
advice settings were introduced into the `advice_config` array.

Subsequently, c4a09cc9ccb (Merge branch 'hw/advise-ng', 2020-03-25)
started to deprecate `advice_config` in favor of a new array,
`advice_setting`.

However, the latter branch did not include the former branch, and
therefore `advice_setting` is missing the two entries added by the
`hw/advice-add-nothing` branch.

These are currently the only entries in `advice_config` missing from
`advice_setting`.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 advice.c | 2 ++
 advice.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/advice.c b/advice.c
index 0b9c89c48a..6da51be63c 100644
--- a/advice.c
+++ b/advice.c
@@ -106,6 +106,8 @@ static struct {
 	int enabled;
 } advice_setting[] = {
 	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
+	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
+	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
diff --git a/advice.h b/advice.h
index bd26c385d0..95489ab4c6 100644
--- a/advice.h
+++ b/advice.h
@@ -45,6 +45,8 @@ extern int advice_add_empty_pathspec;
  */
  enum advice_type {
 	ADVICE_ADD_EMBEDDED_REPO,
+	ADVICE_ADD_EMPTY_PATHSPEC,
+	ADVICE_ADD_IGNORED_FILE,
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
-- 
2.31.1

