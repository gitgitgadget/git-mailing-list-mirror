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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F18C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D13B61353
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhDMOC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbhDMOCF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E53C06138C
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s7so16466921wru.6
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8VJdwr9CcCAR4dz9bRohUSRZbYTLN3SS0ect0Dufjjk=;
        b=Z5fpgw+puVzzUrlETeMaorIUAV82unWwZDih1G2xVuwUGO2QIX2WrsJxkLke9j4dXy
         kuw5BRY+qzrCNP5g2SpDi04pMmAECJ5Y4vtc5wxh429nrPP9bC9Lq5/nsb426jH/5g1T
         8gywi2tMF8K/RNpShnr+HPfiqv1rjILBk55NQHW4+6dHIrhQmktIB0uoeabsuXsnLNpK
         k5v0QxcQjDYHJ0Be7rxGVrdssmAUGkrYug3ISXzcZTO9gPLLLT3DKP7/T04CDQqrkdqW
         7JpS46vrsapUxLAJx/RotgGf/EpOUj8sfWtjwCa6yrMeYnXCfK1Fim55ZVWwPnxUe34V
         T9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8VJdwr9CcCAR4dz9bRohUSRZbYTLN3SS0ect0Dufjjk=;
        b=uMX4oKVV1uKmh0onSWWPrJiYyWCZivPo802PhCu9hnjp9UYR5CprtZi0GmVLMXypG6
         aAGU6o4YYqyDZ4SXmH41VevS9rSQgsupm5z/bK7DHLxt8CiJiB29/9Nwaf+RsjL88YWf
         3jilGXojMcnNcarormc42uDPkc2wmwJzjjSJsDUBj/+MROrtKBRNGtqqr0r372ORa7D9
         Had3JYI/YJGi14fpTwlJn0+5k7Yb4Y/T8yWrae3usQxClnSI7oVpzd+pepnQb8v/0Et6
         xZuhZII1F+qQzvBOZ1yw1LzTsBkv9O8WOHCgIeR36SmnBfelUtG41o1MmCll4jqLvodc
         tpbg==
X-Gm-Message-State: AOAM530t6sh4IaSDDB0Z+OLv0eVWavkdJOhnDs9FI4GiZhfKj0qgpeLB
        9kPUZE5yybRLuTwCYjYanG2GU0YvZfo=
X-Google-Smtp-Source: ABdhPJyGjS2dObJN8cQ/tDex8ayGUP/81O8NtHdfxCcykRfC3L6gGn58sSdDjGE0FO/5beGF5PISQQ==
X-Received: by 2002:adf:f692:: with SMTP id v18mr26935139wrp.206.1618322502521;
        Tue, 13 Apr 2021 07:01:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 24sm2996155wmk.18.2021.04.13.07.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:42 -0700 (PDT)
Message-Id: <e86f874dd41291da66848068e7725a172dee231e.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:31 +0000
Subject: [PATCH 04/10] status: skip sparse-checkout percentage with
 sparse-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
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
index 6598c12a2069..e488ef9bd941 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -196,6 +196,14 @@ test_expect_success 'status with options' '
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

