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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2513C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8A86128B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbhGNNPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbhGNNPs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63188C0613E3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y21-20020a7bc1950000b02902161fccabf1so3883082wmi.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=spsw3CzVcVRJ4GYh3elNeWxty9blR0xLmNfhBzkk9Mg=;
        b=mooNAoXlJ0aXEDJdHxZhSmdmRu3573wq0Xe96+vpYnnzzXcfKoauWM5gamT8hH8dkO
         1Qu/zvg6XcGaSCM76OsW6fTn4caQOJ0xofgQwgnAQnGw+gzUGV8tffCzo6qOCBvuaZGA
         2H9ou/6sQpSu7PR3hOfclQdCmKIKEcK3m/WrniP5fljLKA1tdj3A1HWUfteveZFyRonF
         +rPcOXAB34tO6zZsB5J3F6tKhntLx19LcSNg+iozfDNCJBrARM1fXtd2//n4+00krMwb
         k4Q+HuWI8XQUO6RLXE21aPxjBPS0UxQCQdLfbgp+JoKDahvxgss+uR+KuccBNcbsnVD8
         pH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=spsw3CzVcVRJ4GYh3elNeWxty9blR0xLmNfhBzkk9Mg=;
        b=f+MfGW2Dd58RtU/KJOyaV0nLQu0M+0mOCo1NhQ0Yy1TPsHGGvXga34QXdkGn02J+V2
         bKOsmaB2OKtOfosOav4nDmzpNLYgVhDUbqE6VWyxO6PbP95/Uop5JukKQVXAqFHQqAPX
         jXTGGVJ9t17qmOwKOLQC8p7gRyQRQyaUcIRK8siVeLWxonhC5jAFzkbn+Ys/LBqh/WRB
         S5klw4rHyhswyEQdjAFGZGqhI3o4VO/jukMi7KzOoehfAQKq1t/VYBdq79gShh6IMzrV
         Bg0w8seFcLzUu33kIN6AAW72G3ks9EV6nKsQFeSyXVuisYvTqDXwuVOvFOGn9t1YcuYQ
         Rexw==
X-Gm-Message-State: AOAM530xXSOrZWU8/PhMMqz/6usy04spYe0wUjXdI6vpdvfxyXfLlKLh
        l7yLcQcECX2sfuL1oZi8voQ+OWpFcQo=
X-Google-Smtp-Source: ABdhPJxi28c1ArPPgPLXDl+mGxZ0RBEauz09TAbZhKOgr35WeEeU7KV3xG5IwBhbXWkQ2tCZb8AXfA==
X-Received: by 2002:a05:600c:4fcf:: with SMTP id o15mr2328724wmq.116.1626268372972;
        Wed, 14 Jul 2021 06:12:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm2497016wrx.59.2021.07.14.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:52 -0700 (PDT)
Message-Id: <7f782e3fe5061e90e7130d463accfc1f0f59a020.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:36 +0000
Subject: [PATCH v9 12/16] status: skip sparse-checkout percentage with
 sparse-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
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

Reviewed-by: Elijah Newren <newren@gmail.com>
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

