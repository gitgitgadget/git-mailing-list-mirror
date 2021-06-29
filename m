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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF0C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877AD61CCE
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhF2Byj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhF2ByX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED59C0617A8
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m18so23658549wrv.2
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sxTXciz4KAY7fU0l8Y3HSNjtGXPSTPrbuXtexuD+41c=;
        b=EIF9j3pvE8z9useOqoCnka6SO8sDTkOyMfyhw99wbIPgkzzM3mhbAR/LV/dGFzzKss
         dYNvb7dofOuWtB6Nrc4K51yOkdo0yXnOLDMKLKvjybGvKUSs3Rru9DCli6KD3CTSWGuA
         HTOxT+3Gz6h+30EWqWbWKm52JsN9RXR012AWjW72d80nbY8pKlx99G9i0WtHGJg5vMoN
         0e5VzYquAJeY4ZXIBevKX9p70F2KehalnJGANOPRUpoQnPhI4wSb3wokzw7buwmgzkNG
         WLT/723EJFPJrcxvBPQJ57q4LEoEpqnkujAd/0xHnF3xeHSd6K71KbSX5fHy7V42f7Pl
         HWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sxTXciz4KAY7fU0l8Y3HSNjtGXPSTPrbuXtexuD+41c=;
        b=qfztsRDW5ARY7TI5UHf70bakJAfYsjaXJA9160Ya0OtO7XFTVSBqdjNFCOBo4eJ45N
         dgTZTM8/NsJVWCFKezamDZ3VNcMOhqsTtA/3qZFdvtMkrsGXHopFmWFgOWICZMJg4k+S
         NCcOjoJ6MZR+fDRjDaJG1ubnT/0zdlIaxsfZcMfooXqA12vCMDxL6+81Vpa2i8vPHZJ6
         js6Yy7Uo5AkqRYUOS/HXpawIw0vFhU8rn7kA6sd21GD2YvA3SCDIv551XmGQ06nkbvfp
         sLU22IFRhFnH7bEB9dyyz/QbLGQeFaxe3iT5JwEKN+1GD/iRjjpeZab+xI8PF/FmxRnM
         H3ag==
X-Gm-Message-State: AOAM532O2B1zhoJIgYV/8PBGHrf+ZHxaHtTvEvu5bIzIui63lPuEt9zB
        PFFHVB3H8xckcGMRY+HymzynEtCS7nU=
X-Google-Smtp-Source: ABdhPJydHdzLKYkFouObaDvhNlJcu13I3X6nVyypya5pbShEtIuctUH3I10E2PKa9ih5ijY7p5qcWw==
X-Received: by 2002:a05:6000:1245:: with SMTP id j5mr29831814wrx.371.1624931510272;
        Mon, 28 Jun 2021 18:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm16259010wrp.73.2021.06.28.18.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:50 -0700 (PDT)
Message-Id: <48fd25aacbeb1baeca637aec40f3f4cba0da0f52.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:39 +0000
Subject: [PATCH v6 11/14] status: skip sparse-checkout percentage with
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
index 7c78e40b861..9035adcb7db 100755
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

