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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6126BC07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD4E61175
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhGUBCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhGUBB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 21:01:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635C8C061767
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i94so395147wri.4
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IFqFaKyXiAefTGKoC9snpcrEzuGy0Vkzel8b0+ws4a4=;
        b=a7/RUfnxWqWv5bB6hccXuHcfqNweelEdr08ZZPTJsIYT10L2RwIRhGKz7VJyNwLSQB
         IfEcqs6AqJDWhPJb1muRCkVXGsKGcT5VAhl1ykMS5S7ClG/D+9DiBOkO1g4RipzZLaU2
         b8aba56365TLhfoMLajDhtikPyq3rWdc7caOtDV4cS0sT5lUCJe78vSt8H2e37itS6bd
         fjG6Mas20pdWevppchwa2RGgZRQGzkAQl3bB33HzqzVHZaq4uDgflaQAqPHJMPPzOUpq
         XHZ0Q7RkPchjpCLt8S5g5fW82FmxQYREiCgzI/4chA4J4EFDv4Gvc5Pw5K6ysYPb3Kd7
         3Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IFqFaKyXiAefTGKoC9snpcrEzuGy0Vkzel8b0+ws4a4=;
        b=IsV2URm15RREM3MSuyuXe8CrzE/UuByxdpbXIGuByyS5YHtS3PmlvLjJrUJOX7IWjV
         PUJvR/7lR5oojN6cQcEHI2aM3FikeRjN2CMIB2/UeIu46LN0EqjzdVtbRQHtncosDQ7f
         9svaRVAJeJS5y5Pa+Z+fHf1FaXIMyXa472LVIWjX/BaSiDfsBgSJBW34tti7Dcytoh/h
         q41LD8BB0h0YbEfSyqGbRTK5PdhpEjTM7sDzcndogY8quOLfUjfdZZYzjrLloqG9PPEJ
         FLicJQSksebp+4D747motsfH/vR7kfPQS+YniaXrHKJ7jGKutDXiHt6ksrmj2nWt0huK
         7BDA==
X-Gm-Message-State: AOAM530dvdZ/4q/i2bkS4Nt9za6wT8Fq1benbc5iPvo0NjduZc7IVKQw
        C4XSZpaLTbFc5FXCF1FFidwQsGHLKT4=
X-Google-Smtp-Source: ABdhPJyRbxhu6TkPcvKXBrZ6JlaPHMeRlVxzwrfGxNFPh/bp7nkD/0NAW1qkOC+hGcXb72E50glKSg==
X-Received: by 2002:a5d:634e:: with SMTP id b14mr38159531wrw.81.1626831748017;
        Tue, 20 Jul 2021 18:42:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm24474285wrq.88.2021.07.20.18.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:42:27 -0700 (PDT)
Message-Id: <c45cd2396664e915a1d962e6d131505df51b118e.1626831744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
From:   "Alex Henrie via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 01:42:19 +0000
Subject: [PATCH v2 3/8] pull: abort if --ff-only is given and fast-forwarding
 is impossible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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
[en: updated tests; note 3 fixes and 1 new failure]
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 advice.c                     |  5 +++++
 advice.h                     |  1 +
 builtin/merge.c              |  2 +-
 builtin/pull.c               | 11 ++++++++---
 t/t7601-merge-pull-config.sh | 10 +++++-----
 5 files changed, 20 insertions(+), 9 deletions(-)

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
index 3e13f810843..d9796604825 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1046,9 +1046,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
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
index 21db1e9e14b..d1f621725ad 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -209,11 +209,11 @@ test_attempts_fast_forward () {
 # Group 1: Interaction of --ff-only with --[no-]rebase
 # (And related interaction of pull.ff=only with pull.rebase)
 #
-test_expect_failure '--ff-only overrides --rebase' '
+test_expect_success '--ff-only overrides --rebase' '
 	test_attempts_fast_forward pull --rebase --ff-only
 '
 
-test_expect_failure '--ff-only overrides --rebase even if first' '
+test_expect_success '--ff-only overrides --rebase even if first' '
 	test_attempts_fast_forward pull --ff-only --rebase
 '
 
@@ -221,7 +221,7 @@ test_expect_success '--ff-only overrides --no-rebase' '
 	test_attempts_fast_forward pull --ff-only --no-rebase
 '
 
-test_expect_failure 'pull.ff=only overrides pull.rebase=true' '
+test_expect_success 'pull.ff=only overrides pull.rebase=true' '
 	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=true pull
 '
 
@@ -252,7 +252,7 @@ test_expect_success 'pull.rebase=true overrides pull.ff=true' '
 '
 
 # Group 3: command line flags take precedence over config
-test_expect_failure '--ff-only takes precedence over pull.rebase=true' '
+test_expect_success '--ff-only takes precedence over pull.rebase=true' '
 	test_attempts_fast_forward -c pull.rebase=true pull --ff-only
 '
 
@@ -264,7 +264,7 @@ test_expect_failure '--no-rebase takes precedence over pull.ff=only' '
 	test_falls_back_to_full_merge -c pull.ff=only pull --no-rebase
 '
 
-test_expect_success '--rebase takes precedence over pull.ff=only' '
+test_expect_failure '--rebase takes precedence over pull.ff=only' '
 	test_does_rebase -c pull.ff=only pull --rebase
 '
 
-- 
gitgitgadget

