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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DF6C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC7F6008E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhEUMBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbhEUMBP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA5DC06138E
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q5so20809354wrs.4
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aieF5APTh0NLP7SmOzgU2W+ZxUYW0jJ5qZJaNE169FM=;
        b=rAVJ3tSQMA1G14w1rD+OGDpebbcPaeUKnc3CKqHosbqRMSBOgDkLtwmknhVbQObkhZ
         g4ixnMysWTkZXl7UAwYMlWdR3bEoosSDzhA7FihqEWMWxJdty+1gODF9OZECduFVbx+1
         BbOUymeh9E809/1QxXZAXYhaU5fpzBgPqJzN3+M5tQmGoQkyz4d9an3PTGnnT8hs8EOq
         0KkaXTR0HAOcfxf13WONREvW5SiCAjs4K6FlhlTjxVtlwJp21Xm++hSIxqlABocbPNxH
         F6yKaYlO3uqvkEyjADaex071GGfThJNteejlcX5QzOB2tLZ6fevN3oYI9c/3j58RVcT+
         5N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aieF5APTh0NLP7SmOzgU2W+ZxUYW0jJ5qZJaNE169FM=;
        b=rHf7WHjm7E60cJdVFvTK5h5cIga5QGOyXjUY8cnxt4C50l0P5ZpQVRwpAkER/8f/5G
         mCPxLIct7GOgQARikEeDqLXQUinZ7Iiw0BhKZkDucygZJD6rkOKbAqWcrj7+G8FsSpiV
         tDovLG2Oy99o+7BPyDGOMvz9vw/pXSWD7+hn7fW67edwhVF6IcfqfLvWMw4QsIvs9JcE
         RucOwWUntV+xAEhhHLBsLXBj4p5l/pMf8VB4BCzloM6i2ozSU5eS3xJP+4036VQ9K+75
         FeL2DJL+eY/FrXqFR9WhgIY7yPuytplluAh8nPz9ke4EZdeXJnnP/mX98DsFvMBnZkf5
         FeOw==
X-Gm-Message-State: AOAM533sQOf1m/egJkPubd3REOymDRnmDH9Omta3ILLP/xaG1MSTxNBh
        mf8UcphU6lsJ1tILFwpslDFLbbXhCXk=
X-Google-Smtp-Source: ABdhPJys7cHRBKRLn6G7S5D0eCuiTVCq9UoLl09+X0abkKZcp27jK+MkyNrnmcff5vCi6CYkagWm+w==
X-Received: by 2002:adf:9cc1:: with SMTP id h1mr8967733wre.135.1621598388652;
        Fri, 21 May 2021 04:59:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm1818795wrx.74.2021.05.21.04.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:48 -0700 (PDT)
Message-Id: <5011feb1aa04885f6bb272305913257db5c304eb.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:38 +0000
Subject: [PATCH v4 09/12] status: skip sparse-checkout percentage with
 sparse-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

'git status' began reporting a percentage of populated paths when
sparse-checkout is enabled in 051df3cf (wt-status: show sparse
checkout status as well, 2020-07-18). This percentage is incorrect when
the index has sparse directories. It would also be expensive to
calculate as we would need to parse trees to count the total number of
possible paths.

Avoid the expensive computation by simplifying the output to only report
that a sparse checkout exists, without the percentage.

This change is the reason we use 'git status --porcelain=v2' in
t1092-sparse-checkout-compatibility.sh. We don't want to ensure that
this message is equal across both modes, but instead just the important
information about staged, modified, and untracked files are compared.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh |  8 ++++++++
 wt-status.c                              | 14 +++++++++++---
 wt-status.h                              |  1 +
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index fba98d5484ae..34dae7fbcadd 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -202,6 +202,14 @@ test_expect_success 'status with options' '
 	test_all_match git status --porcelain=v2 -uno
 '
 
+test_expect_success 'status reports sparse-checkout' '
+	init_repos &&
+	git -C sparse-checkout status >full &&
+	git -C sparse-index status >sparse &&
+	test_i18ngrep "You are in a sparse checkout with " full &&
+	test_i18ngrep "You are in a sparse checkout." sparse
+'
+
 test_expect_success 'add, commit, checkout' '
 	init_repos &&
 
diff --git a/wt-status.c b/wt-status.c
index 0c8287a023e4..0425169c1895 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1490,9 +1490,12 @@ static void show_sparse_checkout_in_use(struct wt_status *s,
 	if (s->state.sparse_checkout_percentage == SPARSE_CHECKOUT_DISABLED)
 		return;
 
-	status_printf_ln(s, color,
-			 _("You are in a sparse checkout with %d%% of tracked files present."),
-			 s->state.sparse_checkout_percentage);
+	if (s->state.sparse_checkout_percentage == SPARSE_CHECKOUT_SPARSE_INDEX)
+		status_printf_ln(s, color, _("You are in a sparse checkout."));
+	else
+		status_printf_ln(s, color,
+				_("You are in a sparse checkout with %d%% of tracked files present."),
+				s->state.sparse_checkout_percentage);
 	wt_longstatus_print_trailer(s);
 }
 
@@ -1650,6 +1653,11 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 		return;
 	}
 
+	if (r->index->sparse_index) {
+		state->sparse_checkout_percentage = SPARSE_CHECKOUT_SPARSE_INDEX;
+		return;
+	}
+
 	for (i = 0; i < r->index->cache_nr; i++) {
 		struct cache_entry *ce = r->index->cache[i];
 		if (ce_skip_worktree(ce))
diff --git a/wt-status.h b/wt-status.h
index 0d32799b28e1..ab9cc9d8f032 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -78,6 +78,7 @@ enum wt_status_format {
 };
 
 #define SPARSE_CHECKOUT_DISABLED -1
+#define SPARSE_CHECKOUT_SPARSE_INDEX -2
 
 struct wt_status_state {
 	int merge_in_progress;
-- 
gitgitgadget

