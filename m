Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E31C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 00:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C821D6115B
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 00:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbhIUA4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 20:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhIUAyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 20:54:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53110C10F500
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:57:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g16so32138048wrb.3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7ws927nRBkUxD7akW53F4I2dOz6lGl4lLidCwsiUMgE=;
        b=h8qrDfS+6w4UOQlgQN25eUsVqyaRRfsQVRCkPla/6bDD9v18dEECO625l36QEXY9aI
         WKp7bSlx762lI+yq3bSX6mtwGaMRrwx/9nd8Tj+8mhMuBn2YzOUWqVzmtWjAKHrlGvHb
         FKyom6egTIB/1gMVHSS6EfzU+jjv65vYtSsOQzuHd0Dw2Fhcuvpk1sPpEqHEsLXgpTMm
         2ckGcPfyv5eaedHNz8j2Xe6n7SJCYJ5lwEZ3HVxdjtzuIBI0UEs0pkFfKpZZCbS39DOh
         ntD77p4DxlXw8GTO1U4UlwNip98MC12E/XMYAFb+9x2W4FiMdNxlK2vCEAeuuwTqclpM
         NDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7ws927nRBkUxD7akW53F4I2dOz6lGl4lLidCwsiUMgE=;
        b=bJoLDmE/H1+rgS3MHFzugrgU1fFrf6emkmLo+l0AQ5QDQ5Ukcg0eGXKkY6t7rME+Gf
         oWGako9wcqb/EBPpsZSiYhezPcREqktRF+3J7AVMM7wrGVQtGdcej0DxCpiDpbwjFupz
         9jRaOjj6v81KvwAT5kHEJuzwR3AHvebcqU622welAlF7lKduq2OF4YcIZ9OmbNFTB9De
         qa+K5J2ujgmbibWlXQUljAiuq8svjX//oyVnnRHImJsUuc2W/SqphDF8aAPrs8bG/egO
         MQ3G8t472ca/P1qbnyzCRQZLJMwOLngq/Xm0LCdUCATONCxyPjkjULhQXsX3al6gkh8C
         OX7g==
X-Gm-Message-State: AOAM5302dTDJjWfmpdQs8V2vVKcP0HVZojZ9wrhmb46DiFBSfO+rjNVl
        5Jlehkt7MV+viQkb68iP6t+ahX0LyWc=
X-Google-Smtp-Source: ABdhPJzXi+uPd+CSojQkRa0zyOOis8bOI2YB2mctzEHtZZ1DZanHFNgdkiIWa7GOre8eteL82ZLNeA==
X-Received: by 2002:a05:600c:1910:: with SMTP id j16mr317482wmq.11.1632160661001;
        Mon, 20 Sep 2021 10:57:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g22sm174164wmp.39.2021.09.20.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:57:40 -0700 (PDT)
Message-Id: <d513b28b75189d066f9c66de44a1a578cbc38139.1632160658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
References: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:57:38 +0000
Subject: [PATCH 3/3] sparse-checkout: refuse to add to bad patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, calbabreaker@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When in cone mode sparse-checkout, it is unclear how 'git
sparse-checkout add <dir1> ...' should behave if the existing
sparse-checkout file does not match the cone mode patterns. Change the
behavior to fail with an error message about the existing patterns.

Also, all cone mode patterns start with a '/' character, so add that
restriction. This is necessary for our example test 'cone mode: warn on
bad pattern', but also requires modifying the example sparse-checkout
file we use to test the warnings related to recognizing cone mode
patterns.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          |  3 +++
 dir.c                              |  2 +-
 t/t1091-sparse-checkout-builtin.sh | 11 +++++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fe76c3eedda..2492ae828a9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -513,6 +513,9 @@ static void add_patterns_cone_mode(int argc, const char **argv,
 		die(_("unable to load existing sparse-checkout patterns"));
 	free(sparse_filename);
 
+	if (!existing.use_cone_patterns)
+		die(_("existing sparse-checkout patterns do not use cone mode"));
+
 	hashmap_for_each_entry(&existing.recursive_hashmap, &iter, pe, ent) {
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					pe->pattern, &buffer) ||
diff --git a/dir.c b/dir.c
index 03c4d212672..93136442103 100644
--- a/dir.c
+++ b/dir.c
@@ -727,7 +727,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 	}
 
 	if (given->patternlen < 2 ||
-	    *given->pattern == '*' ||
+	    *given->pattern != '/' ||
 	    strstr(given->pattern, "**")) {
 		/* Not a cone pattern. */
 		warning(_("unrecognized pattern: '%s'"), given->pattern);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index af0acd32bd9..780c6a1aaae 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -108,14 +108,17 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
 	git -C bad-patterns sparse-checkout init &&
 	git -C bad-patterns sparse-checkout add dir &&
 	git -C bad-patterns config core.sparseCheckoutCone true &&
-	git -C bad-patterns sparse-checkout add dir &&
+
+	test_must_fail git -C bad-patterns sparse-checkout add dir 2>err &&
+	grep "existing sparse-checkout patterns do not use cone mode" err &&
 
 	git -C bad-patterns sparse-checkout init --cone &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
 	EOF
-	test_cmp expect bad-patterns/.git/info/sparse-checkout
+	test_cmp expect bad-patterns/.git/info/sparse-checkout &&
+	git -C bad-patterns sparse-checkout add dir
 '
 
 test_expect_success 'interaction with clone --no-checkout (unborn index)' '
@@ -182,9 +185,9 @@ test_expect_success 'set sparse-checkout using --stdin' '
 test_expect_success 'add to sparse-checkout' '
 	cat repo/.git/info/sparse-checkout >expect &&
 	cat >add <<-\EOF &&
-	pattern1
+	/pattern1
 	/folder1/
-	pattern2
+	/pattern2
 	EOF
 	cat add >>expect &&
 	git -C repo sparse-checkout add --stdin <add &&
-- 
gitgitgadget
