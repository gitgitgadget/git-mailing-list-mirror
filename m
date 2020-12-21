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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D84C43381
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAE623159
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgLUSDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLUSDd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:03:33 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F24DC061248
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:03:18 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id q22so14696258eja.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/5JHbDbPC3Nt0YIkibu+H0qEMLkn1if1xWwVfnpFpw=;
        b=PlHCSeeieGlZJ3cJ3HT0rP89jLnbL8JiBRPBeY82YL7MrTmHAmvQuwU/yknjGAVn7o
         OiezcTzcUpHv9e0/yqtQAxwPQ+aW9lBaxVEuT1cRTuabg7xyVWOArzeox669JVrp7Ap2
         OufC+y4pZyK1BgvmUz5khbiJmXqUF08f3bvhwx45xL9ubs7s48EJfKECfttmxgm1Q7CS
         UV3lmvLINOr+V5wpgD5IQqoJNIIEacSh0jEJgs5i61F7Y4qPtJUoJ9qeOgYycSAmFmu5
         CqpBqhYS61PJBnEoVlTceNC3JqNl0FbJxV/EfryN36ak8ua3Td+XR9CKoQTb/XcrSHWF
         DPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/5JHbDbPC3Nt0YIkibu+H0qEMLkn1if1xWwVfnpFpw=;
        b=IQh0IT0K1VqDp2FLNyya46gTGKkgGf35duPTMHZHE+7qCWvCU2KFybZKfo3GSJd9ou
         UG0qPXB0Zog17j2LKaNL6YQW5jjGMFY+vwc4KTis3s2BOJSSXGFDV9XmlbgdKCFBb8wR
         isxVXHRJMIi5HDGAZVy7qXQhQ+VEfRV5Sqq/3G34hg0U8Aca79NDxVnF3lm1Z2VenOtP
         18qHDM7MujfiNDZIGiPEOjSQ8RNeNXt3Wv07Bvz18cCzXrORj99PcOXTFKjCcS8Yakth
         YJXqROw0KxDkGyo78iEdp2E5CBTqRTKWKkgjFv1PWGH9aGHZDg3lp2kJFZVsDiL69KB1
         LvUw==
X-Gm-Message-State: AOAM530l2dPYSt/rbt0cb7hSW+hS+5vmNs/KjDgkfi7lVIr1n21LAS3+
        FLMmc3B1SOCK6ghNm2V4ldUc7Aeh8Hs=
X-Google-Smtp-Source: ABdhPJzo1/IcWdym18eorelxDoWL12q6p85MwdI3xeBpF8H4Qs3mCM8JkQrjDmGqcL5vnLtDgcyrhw==
X-Received: by 2002:a05:651c:509:: with SMTP id o9mr7345555ljp.212.1608564036339;
        Mon, 21 Dec 2020 07:20:36 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:35 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 03/32] revision: factor out initialization of diff-merge related settings
Date:   Mon, 21 Dec 2020 18:19:31 +0300
Message-Id: <20201221152000.13134-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move initialization code related to diffing merges into new
init_diff_merge_revs() function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index d818e0b18bbc..3250b2d7e112 100644
--- a/revision.c
+++ b/revision.c
@@ -1805,6 +1805,8 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	return 1;
 }
 
+static void init_diff_merge_revs(struct rev_info *revs);
+
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix)
@@ -1813,7 +1815,7 @@ void repo_init_revisions(struct repository *r,
 
 	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
-	revs->ignore_merges = -1;
+	init_diff_merge_revs(revs);
 	revs->simplify_history = 1;
 	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
@@ -2153,6 +2155,11 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+static void init_diff_merge_revs(struct rev_info *revs)
+{
+	revs->ignore_merges = -1;
+}
+
 static int parse_diff_merge_opts(struct rev_info *revs, const char **argv)
 {
 	int argcount = 1;
-- 
2.25.1

