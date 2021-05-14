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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C764C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1131D613EB
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhENScp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhENSce (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0658C0613ED
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i17so142903wrq.11
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aieF5APTh0NLP7SmOzgU2W+ZxUYW0jJ5qZJaNE169FM=;
        b=k2sdDVtPNJTvSDz2IiiXIcGazfEI/AA7B28nxGLAWHtyHPYFk9beudZ6W8GDsPH2gk
         yzDDcF7SZlNITTYd3jGgG9MOhjhu/K5AjkJ4/B6MXNWcKuems1DDB6Hbs7kdX62FPmiD
         1gKWya1yVMY7bRcOfBNq6I4aTKm6GxgNmb3PHxKm0DgxShTXLdWlmtNdVsrjhOCKXD0n
         TZDftlwgr0wsQel52LPdhAvn4o4DaMb8mY1swNli1O5FyLzUjTqkJY6qjS4tqMiBp+S/
         nE+dMhsiiX1yF8z2yHK2Pai/jNa9E1VIRk0BnpMh451g1cy7G2q4uOXNf9mnWfMW2Mf5
         9+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aieF5APTh0NLP7SmOzgU2W+ZxUYW0jJ5qZJaNE169FM=;
        b=jdRNt6WEVXSchlnf4Mv3mtqNmRxvWS8Y1nem1VeRU9cxdtJ1HX5qLCwAgRuy5qSgGH
         qWz0pjCsnSx1L4MiGUVdJK26d9c9sRgIOD+C9Nz6l+sqqnID3ER6JZG6gY/exPNqCPB/
         lWGpBlYmDePXVuaKoDlDLNdgXZ314nUa7KKutLYXg2PAHFl9T1QuT3Qz8RxM4tZ8p/Pg
         SUyxHP2AurmUPu688vA/mLb2QNxz/yN3OYWsuiGz/Kx8llnMGxIeVKTcISbx7s/M+5Su
         cNCB8JJPUcBiLr/9YOmsGcrg44BjpV4GE8Ht7lmRFGpKeYPStO3TUEGO49e597oW8o+4
         2hGg==
X-Gm-Message-State: AOAM531ZZxBWQfh4aGtwVjRJQvOrIRv2MVElkecywffjCKfbCGhvlwU6
        5yjRUiw9gv8OsH8eDtdAFL+tj2lZ2lY=
X-Google-Smtp-Source: ABdhPJy9cWkGbHEVLwyJkY2LU5m14WmP95ih27W1zMV3+AT5YrxAF4bvRjxBeFgSIgd4NGbdc0QNZg==
X-Received: by 2002:a5d:5301:: with SMTP id e1mr17738450wrv.36.1621017081673;
        Fri, 14 May 2021 11:31:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11sm12266639wmq.41.2021.05.14.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:21 -0700 (PDT)
Message-Id: <bc151298149331e75b0a5aacb66c7bfcbe9822b8.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:08 +0000
Subject: [PATCH v3 09/12] status: skip sparse-checkout percentage with
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

