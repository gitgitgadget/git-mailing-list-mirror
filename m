Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CC7C07E95
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 01:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB3761289
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 01:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhGKBbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 21:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhGKBbA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 21:31:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC54C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 18:28:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso8365130pjb.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 18:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGajPJ5yl19/eAM2S9bM01p+19Pt6tTDD4n+VluU114=;
        b=CtLbU+yM38McXCxEutoS2ADAFWgtcrZFqxra6XMu6sAnLBaBmI/ZWM+NxJedTI9x5M
         jMoWSNErmGbpb3A2PipHRBsuoFZs7yGJr2g5NRGi580zkLmyAx9ozNSL6vn/Cl7BD3Mf
         9voBjj7/DFpLbMgiVZ65QD7/MbR53lyeuL/crSCIGbmPVE8TwGs7tMDNX24+OpVVQoUn
         Eyj+F/7P7Uz5Lt381owAd7lCl9lq8X8Ytu3hdjw8qsL9O/QLlQhh3m9fbE1pYbexfHNM
         FLLoarwy0uGgeCU5B85pKt8eIc8RC8fM4e6EKyUM6qYamyL4tfFjl6D6jE3scXDiJImr
         +AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGajPJ5yl19/eAM2S9bM01p+19Pt6tTDD4n+VluU114=;
        b=YLS6b722QwZBl2pnfwoSCyNufBWeY9vAn1qQHgFZBK2uwDEqXDBYi5vp4rM5GZdANR
         mcLpfgHN8MLgj2hrQEwuToFUJ+s4VJK9Wxn46rE3vUjLLp3tB/1Fjdwmvi7LVWaLKknR
         StSIwmFVrsCK2EdR4w72xXKOvVijYn3FF01/q/k5ciL3rZ10MJkj3ta2eZsZzePekYrB
         heYVPIfY5cnYisCYP6CSA49G9rAqsR57gYwCmT2Fk+ty7/NkrBROQeEOMHVpHY+lwcz7
         3/nRwwKGAVwP+SaamvyFXtrzvu6N+cEv77fIHdaB9xY6/U+XDEDQpgGozCb+E2XHsQ/p
         8asg==
X-Gm-Message-State: AOAM530kEtzM8CfxznaU5iniTQIM+He2+RWDVn+TAiBIti+yJyWZm1nH
        R91523HN/cqm6fpgyoG7uTCDBgnOGZ0lXA==
X-Google-Smtp-Source: ABdhPJwU2os5MZ2UryUvMGEDrJwpkwghQz86v4jXrpSqWJYxaNQGjsF1d0c03gUEcrqXGU585YFvcA==
X-Received: by 2002:a17:90a:eac3:: with SMTP id ev3mr6869312pjb.204.1625966893689;
        Sat, 10 Jul 2021 18:28:13 -0700 (PDT)
Received: from xavier.bn-i.net (69-92-154-18.cpe.sparklight.net. [69.92.154.18])
        by smtp.gmail.com with ESMTPSA id w186sm5590756pfw.106.2021.07.10.18.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 18:28:13 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, phillip.wood123@gmail.com, avarab@gmail.com,
        gitster@pobox.com, felipe.contreras@gmail.com, newren@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
Date:   Sat, 10 Jul 2021 19:26:04 -0600
Message-Id: <20210711012604.947321-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.171.gfa4a44ff46
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 3e13f81084..d979660482 100644
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
index 52e8ccc933..b5a09a60f9 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -183,6 +183,30 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
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
2.32.0.171.gfa4a44ff46

