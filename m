Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A399C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D67361029
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbhDMLmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbhDMLmL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 07:42:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469BC061756
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o16so18987261ljp.3
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AMHivxL4jFTVDyuMa520/THgXsrTD5DwY99Wc72tEVw=;
        b=MMdtlCd1QArlxe0UicztXJP3TV0hUQHW3fnzJKCJ1nf7xfVsawp+SFslfE/tvWxZwx
         bTj/7E9COAAawEsyNUZrAaDDpPLQQZqGkHLFmN+tDz7lu75Hqp3ah8UVb1BLg1SSWNd2
         4XpqmbQuCCcDCgTln+H0zurNC7o80AOQbDtLy1H1B9fM8SedBFKZfZ1/jLJXKNOke7Xf
         Am+z4hmUmwui/Sl28csV1kRHqW0MF2v3RS1LSAB7KXj0o2uHghKphxZewUXi/29qi8Mi
         6MhJGOcq2Hk9qf+BRymfuu4R71mQ5yRAsgzB3WckrnrOoGWfbHt1Jm/3sg4ShwrRK9W2
         EB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AMHivxL4jFTVDyuMa520/THgXsrTD5DwY99Wc72tEVw=;
        b=O1MIbg/QhVVp4R9LQPkmDCRkhDGD6BSLur0+59+8jUGbgOdVaH4nm+qoM1Lm9BM697
         LQM5Vu5NadiPjoUhxeLSuED4ANp7ixjXA0Adu1p4UXYUnBfzXrwmKsF+wXLoqMMeb8Mt
         BNztFmTtI58xKA/myDBIjYCvlmpT4cV5/AwN3HkKN9uu2qW+Atyjw8ip1jniVFBJt5uh
         1ovSEKObtZhX6tqPVvrcoH5ZBNngvSTxXO1Dcjo/kdlW9gn1vZjVfoURXvFuIN5zdqdP
         aKFooLQnRVvf23OCj9qoV9YU1f5uhblctZf1t12aEzrgz+kDPhWkn8Gtx/Lp/pWudx2K
         fhzA==
X-Gm-Message-State: AOAM532jels9dXM3YnMYk0jhW8UhCdtHjFdJTZQFmGSH/5PFyYT6yyTr
        Kqx3fbgiD+YvFJbR3WyUqNg=
X-Google-Smtp-Source: ABdhPJxJ1nWbt4t2x+qAqiVwbhh//aQ1DYCEBn/9didyEXr+l09LDHfNsbhXqgz3eDUHZtKYoeUSWw==
X-Received: by 2002:a05:651c:114:: with SMTP id a20mr4284127ljb.82.1618314109322;
        Tue, 13 Apr 2021 04:41:49 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b11sm663339lfi.292.2021.04.13.04.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:41:48 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 3/5] diff-merges: adapt -m to enable default diff format
Date:   Tue, 13 Apr 2021 14:41:16 +0300
Message-Id: <20210413114118.25693-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210413114118.25693-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210413114118.25693-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let -m option (and --diff-merges=m) enable the default format instead
of "separate", to be able to tune it with log.diffMerges option.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 66c8ba0cc6a0..9d19225b3ec9 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -34,10 +34,10 @@ static void set_m(struct rev_info *revs)
 {
 	/*
 	 * To "diff-index", "-m" means "match missing", and to the "log"
-	 * family of commands, it means "show full diff for merges". Set
+	 * family of commands, it means "show default diff for merges". Set
 	 * both fields appropriately.
 	 */
-	set_separate(revs);
+	set_to_default(revs);
 	revs->match_missing = 1;
 }
 
@@ -61,13 +61,13 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
 		return suppress;
 	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
 		return set_first_parent;
-	else if (!strcmp(optarg, "m") || !strcmp(optarg, "separate"))
+	else if (!strcmp(optarg, "separate"))
 		return set_separate;
 	else if (!strcmp(optarg, "c") || !strcmp(optarg, "combined"))
 		return set_combined;
 	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		return set_dense_combined;
-	else if (!strcmp(optarg, "on"))
+	else if (!strcmp(optarg, "m") || !strcmp(optarg, "on"))
 		return set_to_default;
 	return NULL;
 }
-- 
2.25.1

