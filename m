Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F96C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 05:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C417461362
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 05:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhGOFJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 01:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbhGOFJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 01:09:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12788C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 22:06:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n10so2582168plk.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 22:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nbkLoB38b3DTCyDl3ifujtlm8GCR9T6p1ahBElbQjaw=;
        b=iVtCmzrWTYqo8+fjQbqHC/VVqlvz13kQMe7NTww/CdGuO3ggjiJhPOE/MqqK/zBUfc
         RRYl9wh26twuV2OX2bklxXS7WFGyVZl4igfKL1SOFN6KpgnZ6nZQTzbkMR9OmSVtRCC9
         7yD2SmifNiIYvlx+iRzzLVviu9bjhGLQ8ibLqExO9fzNzl0EwDvoYuXzbb1PxtsTf8wu
         M6Usd2buJf48oXcJ+IQhYEfoBc/MNQGCfw1i6u8HUcxgCT2rWKKe7fPCegvxwyqpDdhQ
         9l6Q3bs7M7KdYBSdDDOVLjiL6zGNZGr/pmAdh1P3ynpcPoDKtK0gOZjSeVvsRYHSSWiJ
         f1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nbkLoB38b3DTCyDl3ifujtlm8GCR9T6p1ahBElbQjaw=;
        b=EtO0zzrLTl2BFZ25Mo35O4RcxaUHtp1S9cEDwsN8n43UiuTgu+0BFaAkYnJZJnbtdT
         FvulFno0UppP85ZlIDq0jXoHyMvex5NuR3/FV0CPAZcKXQFk3B8GfvRWjIzffKnLJZij
         E2jtRVc8gw4cxoTfVP/DPFsVoAOoO9jd/G/Z92gBIHIUJmOmr1pZmMlTL/XvG1rHjz8E
         bCVRdY/C9pxJnQZiRqTt0BPQoBRUVi68prlyVYBic875GE66VdO/iW7oq4xRAHsydrNR
         BgXBvD8RKqk4LLJa7P4AHBntwf3/woPAJ+Cu2uROp1YLvoAZDPy6f/xHrjLAYIbdQ4Da
         kJ7Q==
X-Gm-Message-State: AOAM530msRAPj8S/9QAWrq7kMv8xzRfPsfSNAexBxzf02T8fkPNWs2Iv
        FDjDPHOzMwz8fVDOivcheB+YlmS4wso=
X-Google-Smtp-Source: ABdhPJwFd0g7k2Srog62UP2Kn6XmNtJgTncl/Dvm2Tv4JqKpKdWxoAgOTLvWknwEdGQ1zAARrdp4Pg==
X-Received: by 2002:a17:90a:c283:: with SMTP id f3mr2197859pjt.138.1626325579048;
        Wed, 14 Jul 2021 22:06:19 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id u16sm4635905pfh.205.2021.07.14.22.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 22:06:18 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, avarab@gmail.com,
        felipe.contreras@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] pull: abort if --ff-only is given and fast-forwarding is impossible
Date:   Wed, 14 Jul 2021 23:05:59 -0600
Message-Id: <20210715050559.3371470-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.265.g52796feb00
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The warning about pulling without specifying how to reconcile divergent
branches says that after setting pull.rebase to true, --ff-only can
still be passed on the command line to require a fast-forward. Make that
actually work.

Per the discussion on the mailing list, explicitly passing --rebase on
the command line countermands pull.ff=only in the configuration or a
previous --ff-only on the command line.

The --no-ff in `git pull --rebase --no-ff` is still ignored.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
This is the code I was working on when Elijah sent his patch set to
accomplish the same general goals. Mine is a less ambitious (and less
invasive) approach, but I don't care which solution wins.
---
 Documentation/git-pull.txt   |  2 +-
 advice.c                     |  5 +++++
 advice.h                     |  1 +
 builtin/merge.c              |  2 +-
 builtin/pull.c               | 23 +++++++++++++++++------
 t/t7601-merge-pull-config.sh | 35 +++++++++++++++++++++++++++++++++++
 6 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..3cf957d2ed 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -107,7 +107,7 @@ include::merge-options.txt[]
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
 	was rebased since last fetched, the rebase uses that information
-	to avoid rebasing non-local changes.
+	to avoid rebasing non-local changes. Implies --ff.
 +
 When set to `merges`, rebase using `git rebase --rebase-merges` so that
 the local merge commits are included in the rebase (see
diff --git a/advice.c b/advice.c
index 0b9c89c48a..337e8f342b 100644
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
index bd26c385d0..1624043838 100644
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
index a8a843b1f5..aa920ac524 100644
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
index 3e13f81084..256b96633e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -55,12 +55,17 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 static int parse_opt_rebase(const struct option *opt, const char *arg, int unset)
 {
 	enum rebase_type *value = opt->value;
+	char **ff_value = (char **)opt->extra;
 
 	if (arg)
 		*value = parse_config_rebase("--rebase", arg, 0);
 	else
 		*value = unset ? REBASE_FALSE : REBASE_TRUE;
-	return *value == REBASE_INVALID ? -1 : 0;
+	if (*value == REBASE_INVALID)
+		return -1;
+	if (*value != REBASE_FALSE)
+		*ff_value = xstrdup("--ff");
+	return 0;
 }
 
 static const char * const pull_usage[] = {
@@ -125,10 +130,11 @@ static struct option pull_options[] = {
 
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
-	OPT_CALLBACK_F('r', "rebase", &opt_rebase,
+	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
-		PARSE_OPT_OPTARG, parse_opt_rebase),
+		PARSE_OPT_OPTARG, parse_opt_rebase, REBASE_FALSE, NULL,
+		(intptr_t)&opt_ff },
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -1046,9 +1052,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
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
index 52e8ccc933..8922aa6f7c 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -183,6 +183,41 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
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
+test_expect_success 'pull allows non-fast-forward with --ff-only --rebase' '
+	git reset --hard c1 &&
+	git pull --ff-only --rebase . c3
+'
+
+test_expect_success 'pull allows non-fast-forward with pull.ff=only and --rebase' '
+	git reset --hard c1 &&
+	test_config pull.ff only &&
+	git pull --rebase . c3
+'
+
 test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
 	git reset --hard c1 &&
 	git config pull.twohead ours &&
-- 
2.32.0.265.g52796feb00

