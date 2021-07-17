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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B469C636CB
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649A061179
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbhGQPox (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhGQPou (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:44:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B788DC06175F
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a13so15591544wrf.10
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JGp7s4pCml5nfXimznQtdu5QRUOVTkZhzOC/BjyS3Ug=;
        b=eP2VIWCuLGfDkG9hSoYh56dav3guc1l3HI0tIbbzuDUD3iJlTcBzdzZjYRFhPs235K
         Ya+jTpQYpvypH7LlKRhgCGdMX8dNahKke/FVeMY+kucnftqRU/xaK2ZP/18W7YdYtApz
         C5Oq1GJXr46mH/jH462rW9Q9dNn+tVrpA7vskhQ39MGS6Y8KvjnGo0sOJFOXRltFS/iU
         nJFjkgG5x2iFRsK1GcW/5Wb8ZVzqJYSiqvoFsux8YN2aa3n++onPtcQ30aZ93BY4lxT/
         kXYAv7UhWtaDN7XQDBhv63H1E/jFVm8ArE8T3Zg6KjfMrYDahhNUET2eTYe526/PhXBp
         MYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JGp7s4pCml5nfXimznQtdu5QRUOVTkZhzOC/BjyS3Ug=;
        b=uB97l+tJPOQ3kR1iVY4iOyTtn7xzf9M0gHoEPcgF5yhP03B1Idz2zv3lMRJPV5Mcw5
         4li9mB/YOSsYBRClsmlW1lTnuXO1E6mlZzD1cKgZne5ZylLxiWtXkwIi+t9cg0ri/oDM
         PwC4TG8RklH0MEAgG5Pmwuhwae2JVlHUsJeWOFkSb1RS/FjmOGlPRyFl8nX1iJ0Ph7CV
         sg+FgyCcubILllYabQHQ086osoiXOVOfIEr3p63hr3IrrVOfJzIGbYyibW6j3kY9cVxH
         pxep+KQfWeiYoPGZh4v3kZm17sCpMl6TT7RoXZsICtJ4kKq/9hPiyQUI0MYerjd5Gi+X
         IJLw==
X-Gm-Message-State: AOAM5316D7Vft52Lp9K8zAPWpyULo8/1KYw1R1camzowiRh/g4oMGHpr
        sKSEl9ro9uy1ul3QKhcQEY7+uxXgnB0=
X-Google-Smtp-Source: ABdhPJx0GYbrTF3Dbdmdn/+oU5Qsg2uXrb2w7jzqkjsmh0CyaCuRtiaiKOxumclHppzip5qk06oL5g==
X-Received: by 2002:adf:ce83:: with SMTP id r3mr19635830wrn.204.1626536511377;
        Sat, 17 Jul 2021 08:41:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm11088254wmh.44.2021.07.17.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:41:51 -0700 (PDT)
Message-Id: <ae54afd8b0118aa1e2b90503aee75a8fddecae1a.1626536508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Alex Henrie via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Jul 2021 15:41:41 +0000
Subject: [PATCH 3/9] pull: abort if --ff-only is given and fast-forwarding is
 impossible
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
index 40d8fb95113..23a1fbc17b3 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -197,11 +197,11 @@ test_attempts_fast_forward() {
 # Rule 1: --ff-only takes precedence over --[no-]rebase
 # (Corollary: pull.ff=only overrides pull.rebase)
 #
-test_expect_failure '--ff-only takes precedence over --rebase' '
+test_expect_success '--ff-only takes precedence over --rebase' '
 	test_attempts_fast_forward pull --rebase --ff-only
 '
 
-test_expect_failure '--ff-only takes precedence over --rebase even if first' '
+test_expect_success '--ff-only takes precedence over --rebase even if first' '
 	test_attempts_fast_forward pull --ff-only --rebase
 '
 
@@ -209,7 +209,7 @@ test_expect_success '--ff-only takes precedence over --no-rebase' '
 	test_attempts_fast_forward pull --ff-only --no-rebase
 '
 
-test_expect_failure 'pull.ff=only overrides pull.rebase=true' '
+test_expect_success 'pull.ff=only overrides pull.rebase=true' '
 	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=true pull
 '
 
@@ -236,7 +236,7 @@ test_expect_success 'pull.rebase=true takes precedence over pull.ff=true' '
 '
 
 # Rule 3: command line flags take precedence over config
-test_expect_failure '--ff-only takes precedence over pull.rebase=true' '
+test_expect_success '--ff-only takes precedence over pull.rebase=true' '
 	test_attempts_fast_forward -c pull.rebase=true pull --ff-only
 '
 
@@ -248,7 +248,7 @@ test_expect_failure '--no-rebase overrides pull.ff=only' '
 	test_does_need_full_merge -c pull.ff=only pull --no-rebase
 '
 
-test_expect_success '--rebase takes precedence over pull.ff=only' '
+test_expect_failure '--rebase takes precedence over pull.ff=only' '
 	test_does_rebase -c pull.ff=only pull --rebase
 '
 
-- 
gitgitgadget

