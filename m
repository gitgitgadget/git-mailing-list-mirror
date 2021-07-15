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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CA2C47E4B
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B29961377
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhGOCnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 22:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhGOCns (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 22:43:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA654C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t5so5626971wrw.12
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9NN/a+OZh2ph5WZuVmOe5wEspO3B2Q+Szi6mpwZt1Uc=;
        b=p/eCc9kOolmZ9wpCBa6YnNMT0szPFIf1abB5WQAgDoqHALpXl1G/1xoJLwHXxpiZK1
         8A8KDv1wZk/xVQuihQpwaJFu4NM7RyMauOckiJMffOsBeZ2hgAGSNqacvttJnoMB5iJ7
         xMTmjd2Ruqxbafuf2ZWK6rUMOs+rTqAj+rLbVJEbUoOj+kqGYwjq/QgLDEuBlcVWA945
         b7ez36Da1/bj9KwgRh5fibI37dX/YHDfJeHTVtqXFGu6feJhLTn+ucVT0C6UDWjUFail
         cGq9VMO2kCMaVb+Ck3oHwjTNemf0feLAVOQ1BW9sVuk/P2+aGv5fr2xutTgoVywMQ4xU
         JUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9NN/a+OZh2ph5WZuVmOe5wEspO3B2Q+Szi6mpwZt1Uc=;
        b=MojC3EW1AZoVMXBvpILRRvQ3SYQpltm/kZAerGpRXoTD14zmDynBzik+lg4xQvgBgB
         OcUx7MFo4h20kRHG/lTVdNk2XxRXNqHYFu4DFm4yeWX96K2bXptBfUNLcLvGhMsv/haC
         syeNqxDKBni6MkFJc6s1gUtjL1YWCwDdYtd4Zx5GS7u/SVXvU5KqyL2dqTS0xzMJ6tUz
         Y/uCxrA+KNWq9tMgLwB+K85VyzyEVzfBXbjHCGqgybJUpR/wcIvf0UcP7aAKJ+sJxtv1
         YY8Tr94d6l/Dc8e3Bto3zj8k/1IWEml1WSX2ggi1kU8kjQ8b9lAgbr2utoLrPcCDlKRG
         TiVw==
X-Gm-Message-State: AOAM533SamZSOyRdMg8qC5JyZXS93PoLn72wnoR2H/skjUHIzBprQHUG
        r/RD4Q77W6PZdZ6fn6RBsesB5DQcJV4=
X-Google-Smtp-Source: ABdhPJzT3qzT2hiiyvgHNTqymaDNG8pTldHTfEG7Dq/TjBQwZfq2WIQO/OyD3jJCPdijOFvH+8+xtQ==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr1760021wrx.202.1626316853454;
        Wed, 14 Jul 2021 19:40:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm4581770wro.79.2021.07.14.19.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 19:40:53 -0700 (PDT)
Message-Id: <12ee3b140b4e1170bc725753cda56a4426823bdc.1626316849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
From:   "Alex Henrie via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 02:40:48 +0000
Subject: [PATCH 4/5] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Henrie <alexhenrie24@gmail.com>

The warning about pulling without specifying how to reconcile divergent
branches says that after setting pull.rebase to true, --ff-only can
still be passed on the command line to require a fast-forward. Make that
actually work.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 advice.c                     |  5 +++++
 advice.h                     |  1 +
 builtin/merge.c              |  2 +-
 builtin/pull.c               | 11 ++++++++---
 t/t7601-merge-pull-config.sh | 24 ++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 0b9c89c48ab..337e8f342bc 100644
--- a/advice.c
+++ b/advice.c
@@ -286,6 +286,11 @@ void NORETURN die_conclude_merge(void)
 	die(_("Exiting because of unfinished merge."));
 }
 
+void NORETURN die_ff_impossible(void)
+{
+	die(_("Not possible to fast-forward, aborting."));
+}
+
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
 {
 	struct string_list_item *item;
diff --git a/advice.h b/advice.h
index bd26c385d00..16240438387 100644
--- a/advice.h
+++ b/advice.h
@@ -95,6 +95,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...);
 int error_resolve_conflict(const char *me);
 void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
+void NORETURN die_ff_impossible(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f54..aa920ac524f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1620,7 +1620,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	if (fast_forward == FF_ONLY)
-		die(_("Not possible to fast-forward, aborting."));
+		die_ff_impossible();
 
 	if (autostash)
 		create_autostash(the_repository,
diff --git a/builtin/pull.c b/builtin/pull.c
index b355fd38794..2c90bbb1588 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1070,9 +1070,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (rebase_unspecified && !opt_ff && !can_ff) {
-		if (opt_verbosity >= 0)
-			show_advice_pull_non_ff();
+	if (!can_ff) {
+		if (opt_ff) {
+			if (!strcmp(opt_ff, "--ff-only"))
+				die_ff_impossible();
+		} else {
+			if (rebase_unspecified && opt_verbosity >= 0)
+				show_advice_pull_non_ff();
+		}
 	}
 
 	if (opt_rebase) {
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 73a0dbdf25a..6b9e80db97b 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -250,6 +250,30 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
 	test_must_fail git pull . c3
 '
 
+test_expect_success 'pull prevents non-fast-forward with pull.ff=only and pull.rebase=true' '
+	git reset --hard c1 &&
+	test_config pull.ff only &&
+	test_config pull.rebase true &&
+	test_must_fail git pull . c3
+'
+
+test_expect_success 'pull prevents non-fast-forward with pull.ff=only and pull.rebase=false' '
+	git reset --hard c1 &&
+	test_config pull.ff only &&
+	test_config pull.rebase false &&
+	test_must_fail git pull . c3
+'
+
+test_expect_success 'pull prevents non-fast-forward with --rebase --ff-only' '
+	git reset --hard c1 &&
+	test_must_fail git pull --rebase --ff-only . c3
+'
+
+test_expect_success 'pull prevents non-fast-forward with --no-rebase --ff-only' '
+	git reset --hard c1 &&
+	test_must_fail git pull --no-rebase --ff-only . c3
+'
+
 test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
 	git reset --hard c1 &&
 	git config pull.twohead ours &&
-- 
gitgitgadget

