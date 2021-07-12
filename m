Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5AC07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20CB611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhGLR7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbhGLR6z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9C6C0613E9
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so579209wmq.3
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7vhfreIm1fgP496Y8tHbzJwdwnJTTb9sQWNvLVkIPvU=;
        b=na7mHTYLeb5eXEfo5loSp+nDpdpcQPSRbrYEs1hSdnm0vdfUncVZEgIo+la7kEVvck
         d3B5/v5QkZOdRUBebyc0/BCCnGe5Qb6WKh/PL7E5KGu9CiSmm3l4IXz/49ZPYEQNhBcu
         ruDFRUgj804fI15eWG4beBciY+w1NiEL9T46aEhI2YqJlIccOc7XoN5RzxQZvy3RMBh6
         QribvcTxFM1FPHeEBdm1FUJ7Uf7tVNXePh2rhlF2b3zYoxA2G9iyzSZWOGRulTdPKfS/
         IsAKe7lE2+pc6fiqy2/7HrOBWhyFfmHz9aJRpHiDqxxYli2fMtkgTe4zxGeM69qGIdp/
         2adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7vhfreIm1fgP496Y8tHbzJwdwnJTTb9sQWNvLVkIPvU=;
        b=VlxMugafOiBjye4xc03pONNAtNzYcGTvRKu/zEvSN3f88S4zgS4jJ1Q74hwgjTgiUn
         +8e/GAQUqZtzExfPnNvZHDEopq97+9x2HB73Ww0CT29BZ4vr8C++S4nUtudoTUdEwPrZ
         FgzLt14H79mLPe+k0V4p4mfMpzQZOkYPLiBhH8Q+LqHWBVHK18zeiAaU95hdl4y+tagr
         rvDllsG87gNYiun2AfZ2ltuwk13XbCEc5bhgN43nBjX1jns1DYzK1jD/WuEN3pd7c0qa
         4pjEx3J73kkK/IycG6HUF9hvhKAP7KoEmpH63sb17nh7TRPMmOnI+KHDUtXb5ieJsxi3
         Ku4Q==
X-Gm-Message-State: AOAM532IZD/tJ61lCwFGCwEXqPm9Llj7V4Mfe1mSADA1HFJNd1G0cne6
        +DD5IUkDrPkCxxg2KsngMj7ZSgXMh3U=
X-Google-Smtp-Source: ABdhPJz7j4QLDK5HGrf+z+9hZysjNBcD0cjFmV3sba8gFxRmReeTtyvuVV6Jppm2Q/neZbHloIkhcA==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr405350wmc.163.1626112565650;
        Mon, 12 Jul 2021 10:56:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o29sm11515611wms.13.2021.07.12.10.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:56:05 -0700 (PDT)
Message-Id: <2b72cc2d98505a635d902ab1be66bd1af763a99d.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:53 +0000
Subject: [PATCH v8 12/15] status: skip sparse-checkout percentage with
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
index 2269f44e033..375b0d35565 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -218,6 +218,14 @@ test_expect_success 'status with options' '
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

