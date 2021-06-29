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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F19C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B51861CAF
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhF2CHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhF2CHb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7AC061760
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v20-20020a05600c2154b02901dcefb16af0so1269005wml.5
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y0Ogi+qqLnMLGGwroR980d2NMgu2JWWRhDy+7DcqaV0=;
        b=qV/G0md59ehb8vNR+lwhOeQi0D/QRtvaG2d49EXJOdY6SFPscWXRobrURpkonxq/xd
         4U3UE0JpkrEeriW5VkmfOZFTlr4v+wQ1khHNjW/geX/cLL4WvCvoaDB1x20xu0UTg5A9
         3zCjredr6MKHkEiplWcoXigNpCPeaaj+yXOQSLqzT7mpRgZgdVgnXs4IIbCfV/f3IPty
         eAu6CIV/ABAqr8Euz+EpbXYZivQhruKXtb6Un/aWA/jLJwIbsmbI6kh/PnftOkAmPlod
         5jgjDBHIblf3k+PF8Ezi0fMZl2I1nUB9fXOoTo1Iye5+bJrRiM4wlr3z45QqqdGGpZ+4
         kGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y0Ogi+qqLnMLGGwroR980d2NMgu2JWWRhDy+7DcqaV0=;
        b=b89W386Pu/9vonInuGHloYsddsgY+09TR+PYWVq257Pm/fx5a910EAKLeYkXm1a4VM
         PTH7iFEOhbBkR/bL9ep2hxIy3B79IKtwzy8pNuqnma0dhlT9EB/H2ifehXxN8K3y1Y3h
         XOAmzSCj0REJPh81cxugBY4qTnC6JCZsZZqbFGxOhm3x5fLT5Z5kQxd/xmrhr4rDsPHV
         nMS+jQgcEcHtMpUgP2Tjzu0aHb+O6yLYxnwxGkuX6XlyyxROyZQaknpwPLzvAICMwo94
         qW+tO9LTo3j21Wj5TIx7QcI4gNH7/ucM8WG2oc0S1K2gcBGS9rliFc+B5gMTWgCfANhU
         RPtw==
X-Gm-Message-State: AOAM533i0UZjo1I+tlxKpTfYvZhQ3QjIWeKyDwEWkSPvxlbb1M9g2Ne2
        k6P0/mEQh4YLqALsDxnJ3HIErmCT+fQ=
X-Google-Smtp-Source: ABdhPJyl5ItVkBN4ujRtX5UUEeH5MDqSRtOuhzijyqQ1v2p0oUtJV5pUopyeGUnZFGQxc2ctHISBJA==
X-Received: by 2002:a05:600c:4f96:: with SMTP id n22mr29678556wmq.116.1624932302560;
        Mon, 28 Jun 2021 19:05:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17sm11766766wrw.31.2021.06.28.19.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:05:02 -0700 (PDT)
Message-Id: <35063ffb8ed6c60c5777d27e4e36a802234200d2.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:50 +0000
Subject: [PATCH v7 13/16] status: skip sparse-checkout percentage with
 sparse-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
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
index 4e6446e7545..d372932cd12 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -231,6 +231,14 @@ test_expect_success 'status with options' '
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
index 42b67357169..96db3e74962 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1493,9 +1493,12 @@ static void show_sparse_checkout_in_use(struct wt_status *s,
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
 
@@ -1653,6 +1656,11 @@ static void wt_status_check_sparse_checkout(struct repository *r,
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
index 0d32799b28e..ab9cc9d8f03 100644
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

