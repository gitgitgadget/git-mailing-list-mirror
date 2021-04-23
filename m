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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EDCC43460
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACD161468
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbhDWVfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbhDWVfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:35:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F7C06138D
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p6so43002653wrn.9
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AiG42CSDvtiEqVNCos1umX9Q+yDZCmxbKcD4xVEEkZc=;
        b=RpBTxgtpKDs9nnhuxLm775qGBjEzQOVnPfuHy1Oem/um4bqBSufLLOIxmQd/5W5TTv
         hiffsFnSwmEWj0SJ0WoQLwrkUDWaSwWraTZt3Fx7AfqVVHTcOqUNS3yY6bklsi6e/+iA
         kgUWWqaV+jSvyaY1HTUZKHahmSpXXTEm1uEBzUI/TKIOYp5U6//ws+wk+fgmeaOY7gdw
         nV65D18gOx6oXBeNqzdB5zZn9UouhsY0Z2IgVC/y6vdGLej2Fxxa+nR0NApl/ginalfb
         AIa0hYUR5JPVQ1tIm2qMQ2da4q/6mc0IlCMlgpLZdZSz+KQiHBfvdDZ3+R7Lgykry5Iv
         AzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AiG42CSDvtiEqVNCos1umX9Q+yDZCmxbKcD4xVEEkZc=;
        b=qEmTWiWqhuJUDStcGiak7DDHtPp2ek5FHnXCnQ3ahEsXyM4T7hNo9GFsyXhvpPdATt
         J8tav/WN1pV/CiH4dKdcIO5E/Iguz8zvVVPMA5ogs9CIAfm7ST8Ojc6sT8ukK6218Bzt
         bKZKWM4cDnBB8f5QaHW1NRUpQOPAw29kkS3begNpLnM0f/VZgERj2wXEiwiiw8g/pjLr
         kxfDrJgmknNTuBEHaeaAOURudo4dtgKhwOgDp7u1nfqbiF5WluUtEjKQ4ERfJKj9KnW0
         8a/sKvSMSppQr988eSIfzTsxI8cyqowZRPxC9Cikmabc2x8TLF82vkRVCVJkZVms+6X1
         AkZA==
X-Gm-Message-State: AOAM5306UZmtiLaJ8UzL/0XcWhTU42+Z7Xh85nBVUSnYuyMHI2cwfnfA
        ii/kAdVJxDnGzJjXLt20Rg9Vp5QfiSk=
X-Google-Smtp-Source: ABdhPJxPg4qJ7HDUR6Du5P6WobJu2rFsP1fSJ6KELUe7Ox1xu95AQV9dNykGzTijzBUjeRty+RNrtg==
X-Received: by 2002:a5d:650d:: with SMTP id x13mr7069632wru.264.1619213670417;
        Fri, 23 Apr 2021 14:34:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16sm10516053wrq.21.2021.04.23.14.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:34:30 -0700 (PDT)
Message-Id: <1f4ba56e741632be5d55effc4ed8b6d40e3863d2.1619213665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
        <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 21:34:23 +0000
Subject: [PATCH v2 6/8] status: skip sparse-checkout percentage with
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
index 0ec487acd283..0dc551b25f67 100755
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

