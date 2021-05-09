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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA33AC433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 21:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F58600EF
	for <git@archiver.kernel.org>; Sun,  9 May 2021 21:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhEIVzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhEIVzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 17:55:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4210CC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 14:53:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lp4so8640229pjb.1
        for <git@vger.kernel.org>; Sun, 09 May 2021 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uVzKzmSpzbrIbfsF3qUHGBjv811x9pjhafIDzbPd/68=;
        b=AXikaK7dsENbSR4b7S4U/vksUZCHOJ64zolnJrdDvt9poUwSuNtdkWBNRncCHMJnO5
         2LSvFw2EveoXe0g8/Xq5EjFOV0XGx4FNuVbFwhkKaBcOuaWQqADsjTCYqwFUjSyI6+Ku
         KWmBes/3RHgw//fuqLSOFuPxGjhQGw9GFsmniNLdmcdRoET1qY3K+E3GiI1oGErikt6P
         kfv/N/LFIAC+wg1MN2tBSYImoe0yqVRFzOyXM7NqiWysutS+/zmZ5dpbad2FKCRIYsLs
         yJMZ5bccB4Dsv8WDmAXZdbKIce1bz8mpt8CrmgSTjmXDZXJfiqho381/Km8+0sdPpVco
         y88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uVzKzmSpzbrIbfsF3qUHGBjv811x9pjhafIDzbPd/68=;
        b=AIAIxtdQB8qyD9941uMf3axRNPYeR36Shw5ciDAXp206jW8FJEb+V2YhNIRoDxiDE/
         0Gcz/0xLNdEP9AIaa4RbXzt5Snc84x8T714Oez46EkaaWuKEsGxzIqojBgwbymTTLB+2
         h5N0YP7k2Cmw7jMa/4j1PQ4vlL/sslYMcWPDqN+MQScFvplNo5tYCrsFlOiOo+ZQXmxc
         gu7FlmiG0EEIZY9aaJ+LRmtIDrVYf9BhbJLYujUB8PpPXSEzPLFXZP7TWoVS8T1kx5bz
         6opl3Rhp3BkJZSMPK+e/qcWIK5754Z17Hv3Oav38kHRK/Z5ggjNeOIY/GKwBhPTeQEn/
         dYQA==
X-Gm-Message-State: AOAM5325UELpBnN+1wwayYy3c+l33MMDruaVYMZGADO9lDq0JLkqRZ0H
        oFE7NxqsYv4PWqkuy/v/CEPr9NkmxP8=
X-Google-Smtp-Source: ABdhPJyFaxU+VB6opr/YcLoWXCWiL2AaTmmT1/9T2gY57aQLTjQQUecxuWG3z2vI565oGQLtOnq5SA==
X-Received: by 2002:a17:90a:4505:: with SMTP id u5mr10669130pjg.66.1620597238317;
        Sun, 09 May 2021 14:53:58 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id t24sm5355934pji.56.2021.05.09.14.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 14:53:57 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] merge-ort: split "distinct types" message into two translatable messages
Date:   Sun,  9 May 2021 15:52:50 -0600
Message-Id: <20210509215250.33215-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The word "renamed" has two possible translations in many European
languages depending on whether one thing was renamed or two things were
renamed. Give translators freedom to alter any part of the message to
make it sound right in their language.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 merge-ort.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6c2792b10e..745a844b18 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3050,12 +3050,21 @@ static void process_entry(struct merge_options *opt,
 				rename_b = 1;
 			}
 
-			path_msg(opt, path, 0,
-				 _("CONFLICT (distinct types): %s had different "
-				   "types on each side; renamed %s of them so "
-				   "each can be recorded somewhere."),
-				 path,
-				 (rename_a && rename_b) ? _("both") : _("one"));
+			if (rename_a && rename_b) {
+				path_msg(opt, path, 0,
+					 _("CONFLICT (distinct types): %s had "
+					   "different types on each side; "
+					   "renamed both of them so each can "
+					   "be recorded somewhere."),
+					 path);
+			} else {
+				path_msg(opt, path, 0,
+					 _("CONFLICT (distinct types): %s had "
+					   "different types on each side; "
+					   "renamed one of them so each can be "
+					   "recorded somewhere."),
+					 path);
+			}
 
 			ci->merged.clean = 0;
 			memcpy(new_ci, ci, sizeof(*new_ci));
-- 
2.31.1

