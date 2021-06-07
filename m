Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6734FC4743F
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F99610E7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhFGMg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhFGMg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:36:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E77AC061795
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 05:34:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l9so934278wms.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FKiHIw3ebWQz9cNbabJCmOn9U0CL4gxPTfpaj57hnfY=;
        b=iWP3zmEQcBDkIkTQIqWzD7iKNWe2SSQTX/ITOSq+lcRGLFDeOBt05jloc81MrPuo4d
         8thMXP3woRnBIBUK0TEjAFdmQKbL3CTPdRaibjvR8GTL07mIsFa0keB69rSbYAH/y9LR
         nfIvUX5ovJukO5/kUNFwtBzSS8U9slZYmG4+GlVuI1X9rLKb7FecmHnoakqaIPuVICxZ
         bVtwpXlTgnJlXP4Es02E4n381J9YpAL6BbKFABywY5y2cjLoX3RYGGudUY6LLhynrUQb
         s2aRAtGNMlEoY1s2GHDMWMn0U+c5ZKZBdwKrgdlPCAgaB/O6YDlGjXGJ5KcZHRVpWnGq
         Z1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FKiHIw3ebWQz9cNbabJCmOn9U0CL4gxPTfpaj57hnfY=;
        b=dL5+nzQ71vAx7I5sAa909vAjYR7axQAF8UoB7G7D0WA+dHOGrmS9uzigmTft4h5Q7d
         FeWeaR2BaKsOZp2m0pgGj6UiHropYV4Zua9PS2uKk5bvlxdfJGO3BVkaM7Z56i5re5pv
         krrZ56MlXUJ0bdk5gjWKwK8PF3yye56Dm/YNYdgh1PhdPA6DzDCaGAcrRge1Ga51JakK
         lw3lDKlEFrBRVn/ySnXsJcUGLMYiNk0KOajx2L0Rz2lKZ5QSuwJ+Rfj6iEEWKt2GGB+y
         dRztbWP7HbHM0Pe/MENfFETT8KjbqHld2Exi4zH8fOkDmhtZhhs6YQTXdsjx0TM1CpT8
         Rkag==
X-Gm-Message-State: AOAM531oHFgTONZNoI4Ea1xnHfOlWSvxnNfYSmu7xAJEif6tMkratDsk
        2cfaUsOQLmcRvOjmAaWmSX/CqSftuV4=
X-Google-Smtp-Source: ABdhPJz6GiMMBpz6Yoho0Nv7Ac+7SWglynGjjYQhzsl0UEG4r0efy5AcD7EUp2zYSE2TuI1i/evjwA==
X-Received: by 2002:a1c:7912:: with SMTP id l18mr16619339wme.135.1623069260693;
        Mon, 07 Jun 2021 05:34:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v132sm17944482wmb.14.2021.06.07.05.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:20 -0700 (PDT)
Message-Id: <611b9f61fb2c834d01ace24b82e1d9791a21c939.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:09 +0000
Subject: [PATCH v5 11/14] status: skip sparse-checkout percentage with
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
index 851a83388e4b..f6b124e0500f 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -215,6 +215,14 @@ test_expect_success 'status with options' '
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

