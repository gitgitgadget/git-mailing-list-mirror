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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC642C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A30661245
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhDGW4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGW4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:56:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CFDC061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:56:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j18so725037lfg.5
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZY0pt9PS7URoeVZBoFthunzKB4BCSEyxxW9IeM9jkI=;
        b=KD21byo3aZyA3E79E/L9yuVgQdetKjyN2r+KunbuWHerU+V5vhf5ADlcUIAvIKxuwH
         Q6CgZm/DBu8I0LrFfESWZUm71TNhHfrvfiHuMfqtHIGFFK4aeQ1G4DkO0Lo8pd3Enh2I
         4kkorxjLVzrRXV7buqLWf/Rl9Khxu6biFblnwtlkGn02pwlZF8cBXIuVn2DYXHZ23ltf
         wu9I8xlRWcHLXSUWzBtzbyAQ8y/p3QLQaVMg6fOZN/+Y5YwBoA4n2IYNJCQN0kD+ZTsB
         dl/PqzPS0mIRnM4XJADJRmjuv7+JFJhZ9dMlkPaitcLn3ko4fp2oVKSxr9lOMsX7pbVD
         OgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZY0pt9PS7URoeVZBoFthunzKB4BCSEyxxW9IeM9jkI=;
        b=mV1OR3nivKdspxwea07bFN3Of2xRfPLc37bwYEx9sA0uiW2DeS7UtPcFG5zbXMO39z
         CKksz4y0zx0y9vpURJW2LGstT4MmS1DWQMU069df8x4KTAQj/9pUhTmkckC8qJ7MxrVQ
         1hRvU3CajWhAuQT1yJjSjRngHPb4nF+J+LzV/KlWNa4QjFV8B5XsALxMGLRMHBEHDe0r
         P8a+dNVzs6z8c+cF6m1hR3hJjjpx4wHuFJMlB7RbfyrNLtMA72yfogmxQIlX4JE+/u2M
         k5A2aGV+jeH4NR5Lex6CjwpOVDmyM7VRH+zMfgni2tbG/ptARpwrLS7jADwRjC94zB52
         NW2g==
X-Gm-Message-State: AOAM5302Q3x2HUc3dpA0kqcxaZwexob+KBv7IqvdJeCmvjMTOAQ7aZxR
        Zr12fzW/GyqfUPZQG1FG5s4=
X-Google-Smtp-Source: ABdhPJxWmciMeB1tCVsE6OseXW39e1Av+Tkv9tTzd3OXmnOk+JH+Th7pyghFYP3yxCTC/SFcmHkTmg==
X-Received: by 2002:ac2:43d0:: with SMTP id u16mr3913211lfl.263.1617836182136;
        Wed, 07 Apr 2021 15:56:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm2580101ljo.102.2021.04.07.15.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:56:21 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 1/9] diff-merges: introduce --diff-merges=def
Date:   Thu,  8 Apr 2021 01:56:00 +0300
Message-Id: <20210407225608.14611-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407225608.14611-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the notion of default diff format for merges, and the option
"def" to select it. The default is "separate" and can't yet be
changed, so effectively "dev" is just a synonym for "separate" for
now.

This is in preparation for introducing log.diffMerges configuration
option that will let --diff-merges=def to be configured to any
supported format.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/diff-merges.c b/diff-merges.c
index 146bb50316a6..0887a07cfc67 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -2,6 +2,8 @@
 
 #include "revision.h"
 
+typedef void (*diff_merges_setup_func_t)(struct rev_info *);
+
 static void suppress(struct rev_info *revs)
 {
 	revs->separate_merges = 0;
@@ -19,6 +21,8 @@ static void set_separate(struct rev_info *revs)
 	revs->separate_merges = 1;
 }
 
+static diff_merges_setup_func_t set_to_default = set_separate;
+
 static void set_first_parent(struct rev_info *revs)
 {
 	set_separate(revs);
@@ -66,6 +70,8 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 		set_combined(revs);
 	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		set_dense_combined(revs);
+	else if (!strcmp(optarg, "def"))
+		set_to_default(revs);
 	else
 		die(_("unknown value for --diff-merges: %s"), optarg);
 
-- 
2.25.1

