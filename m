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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B01AC433E6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD19922583
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbhAYR5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731323AbhAYRz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC82C061222
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m1so13119825wrq.12
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ekNEm1K7+IoPighnLWAgxDWfFsc/lZtfxyrUwGCkduY=;
        b=EGcLn7V9TD7CjVz4UY84AU/uTX2RVy/rYViuwcK/kZ25WaSAZEauMPlS6byhUW5eYW
         PwosV3T0UvgnF3LyRU2I5+80l4hLagSQhps0Y1vv2NrStH6xJOZGjuFcb88A1+0d+gkv
         jcOT5pfYEN0ZP/trH2XTV5Vt2Tm5dbcBTEMIweUibivLx45nZGWWq7b06DTDdQh8pHPa
         aR2SSPoe2Nf/H2y1wlaE4Y+dnuydmUFH1ZazCKcUlqil1PoKmyNpXECyR1SBl1TJuavJ
         fylN6SOcx9cIzU0qw0YkXimqkLL0airJTmlcfc4hRKxhpm4rNizhqvq1qxsyMm0lDOy1
         Y4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ekNEm1K7+IoPighnLWAgxDWfFsc/lZtfxyrUwGCkduY=;
        b=ITF9PDAASV5u9Zf5XqFPc4028jyd2cbJQ7Y7Tas6UN/zePAwYMSoZ5TcCZrsVHBvWK
         c9xOzUYwgoO1IYOEwkAp7RSS4+LE3dZrBM0CyGuaQyr0qkId+/4uoSN1q9tq8HGrKxHp
         K0KHTY8as4O/NS5yYJgo9y8N5SIbcEm8nkkDPoS76NoOog6a55snbGQbFn9ElqtSyO1l
         h+JfMzzCtsohAviTtHCL+e1Ks66NYOgbtDJVJoXQDmk9OHtvb6t82bzjcV7xhqdeFNJB
         AWGmiOGenQGL7Mi6GTDBFAbwHcAFCo6oUYA7Pk4IA8w7tCw+8ycVrx7eQlkboSsA1wkf
         42qw==
X-Gm-Message-State: AOAM533GyfxLsVCeriXuBZlViBiV+IIwLK8us0B7BsFplk+MkaxFupVJ
        zVYtIEb0eauKuApGTSZ9VDpM61onNc4=
X-Google-Smtp-Source: ABdhPJyBi5zce1KT2VfxEo8JPIQda3rICeex9iuPO72SD/81qNfOr+eN+L8Nu4mkUcyBcOAPqVcaEw==
X-Received: by 2002:adf:92a6:: with SMTP id 35mr2218017wrn.193.1611596552430;
        Mon, 25 Jan 2021 09:42:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n193sm51458wmb.0.2021.01.25.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:32 -0800 (PST)
Message-Id: <fc2d0dad6bfa67ee68877a0e85f57271a9508ebe.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:05 +0000
Subject: [PATCH 19/27] status: skip sparse-checkout percentage with
 sparse-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh |  8 ++++++++
 wt-status.c                              | 14 +++++++++++---
 wt-status.h                              |  1 +
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a3521cdc310..09650f0755c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -190,6 +190,14 @@ test_expect_success 'status with options' '
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
index 5366d336938..46c9d71068e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1492,9 +1492,12 @@ static void show_sparse_checkout_in_use(struct wt_status *s,
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
 
@@ -1652,6 +1655,11 @@ static void wt_status_check_sparse_checkout(struct repository *r,
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
index 35b44c388ed..3cb0c200244 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -80,6 +80,7 @@ enum wt_status_format {
 #define HEAD_DETACHED_AT _("HEAD detached at ")
 #define HEAD_DETACHED_FROM _("HEAD detached from ")
 #define SPARSE_CHECKOUT_DISABLED -1
+#define SPARSE_CHECKOUT_SPARSE_INDEX -2
 
 struct wt_status_state {
 	int merge_in_progress;
-- 
gitgitgadget

