Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D316C43381
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E7064F5F
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhBCV4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhBCV4L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:56:11 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE66BC061788
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:55:30 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so1097612wrz.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmEPKW5pzcRFq8NxXw8POw9K1zv72VmN32IOXZFvpd8=;
        b=NhdVr+BKCQwRGLw8I9Hvj+ocDBedr/ieMxB+LOkQScWRxRQKrcK9CZyR2iG1CKmyLH
         2KfFcrYvrnHvUlh3w33E5jCvOFLjVEU6Qw9IOK68uFcB4HzCGN+Fu4SRxGHQE0ORh5/E
         3dzaKVlJKu0RChBgWEpEwKztchyRjLbIPK199Jiv6UOCxoxqk806/0RF43szL1bpK3Ml
         Fz4J2BqVZZQJAy2xEx2laEMz+rOvOCYYUjnvs//ZEzcVAQLRQPJnZy7qmZBExjQCDt9q
         hKYY/OpVhVbNrJQvzFDLFDN6CGgYlGelcKY1QznGbnjW/3GsrroBZQyBNBUPeB6sLwnS
         plTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmEPKW5pzcRFq8NxXw8POw9K1zv72VmN32IOXZFvpd8=;
        b=tAIWg8SkYiFAxjxb+KC1Ze/nVTk92gQVThQR39J9nkn44LWikfL0CcC3C2ghxs9YJJ
         HsF09kVsIXI5AJHpTTH7GxV4N4ef86MWu7Ys2umSbuj9NgBaYpu2OInbr5ofhQ7gWCWj
         xD6M3eHovTa0znLrlM5OVtipCS8BlEVsW6cts/OKNhKReE4SuD1Dci314cNMBWKGRNuq
         Z+C2o+3HzRTzL+C1PkXq4p6oxkPGxsN6D6ZMyR5blgIpHDjmmUof1VPzj5+eCyh4HvKL
         bu2JLdXRLOfOOnh15JV5z6DQOQ403P+lClZGZjEsZ7vYJjcFqiivTAhse1rOofoV/gAZ
         tuTA==
X-Gm-Message-State: AOAM530GcbvBrTNdhHW1lFkIHtrrEFIk88+kqoyVh9gTKZLV5tLKRDQ4
        Ix1Ssr3uaxSbiWdSuOwWgULwE31mCMw=
X-Google-Smtp-Source: ABdhPJzalPUbQoCCFljGosPzs/OIoyinjQsky3yKVnvYziyaZGaYPyygIWWER9poVk9pITs7+GrMJA==
X-Received: by 2002:adf:ee43:: with SMTP id w3mr6068329wro.200.1612389329712;
        Wed, 03 Feb 2021 13:55:29 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.148])
        by smtp.gmail.com with ESMTPSA id 143sm2609531wmb.47.2021.02.03.13.55.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 13:55:29 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     rafaeloliveira.cs@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 4/7] bisect--helper: use `res` instead of return in BISECT_RESET case option
Date:   Wed,  3 Feb 2021 22:54:35 +0100
Message-Id: <20210203215438.96760-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203215438.96760-1-mirucam@gmail.com>
References: <20210203215438.96760-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Use `res` variable to store `bisect_reset()` output in BISECT_RESET
case option to make bisect--helper.c more consistent.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 36b50e3aa8..fd018ddda5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1047,7 +1047,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-		return !!bisect_reset(argc ? argv[0] : NULL);
+		res = bisect_reset(argc ? argv[0] : NULL);
+		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
 			return error(_("--check-and-set-terms requires 3 arguments"));
-- 
2.29.2

