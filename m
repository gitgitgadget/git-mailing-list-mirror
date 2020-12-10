Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6951DC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200D222DA9
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgLJKGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgLJKG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 05:06:27 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE2C061794
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:05:47 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id w124so2017089oia.6
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2szruxJnWf41uQaF2p/QjnHt6VBQe2JkZ+WAoy0/Z1U=;
        b=HU3HPoTpQ8F+BOUq5Gt7vFeryX7dv7Bq/sAIDIxP5mqY4lI8jSIRUEDdLcCUK4c3zV
         YwYgW75S6neuHEZyuLN7Ja1vSR0T4JHbvgFHyBCV1l+2G4sZ+Ea/iIWNLrtPHnth0gAu
         OUChOKKsj0FFQMRcl4X6XhdnLUkByoWCCCsMmzNrP3ajMxxzcA4OtUc9BG/s2gtU/pZf
         tDz9uNjTbjPcPahjQ5LfcCUs7fnbNCXndkcAF3p/jA1+ZKR7vSwYZGkkSs/mqYYS/Dbl
         HNoGg9dy/wDuhWKGeIpXiAuvOKwobOhTgAHZS+GAouZCHquGxVXvLZyqzMiH/Oe5h8cr
         fpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2szruxJnWf41uQaF2p/QjnHt6VBQe2JkZ+WAoy0/Z1U=;
        b=PVjmcboMhkaC48bycG6PXmHVWWVtQ23rpKmX/TDLKYvRdUnKkPLTB1hkt9GcByHxTn
         8GSNfazeHBQhSq+kxrCFE5xgXiUsso6zhKnxgUNfdS59CivQNyqSLJqGxdKGI4YTfOOc
         qqgj4m7Wq59QKykaDNN+5Z5HmvA5KSJHP4MGwYfQMwDzksLFpe74ORTM3cELsjwtOgeJ
         0dpkS0lRjM9XxXkcxwCfwysA5CicT2YSEmsE3kCKo5ebt9Nbg1IF9+naXLbZYXxyaPeM
         1F47cBexlBjZx/0hDzZsSNjGKJLBqsFWQ8Vhi4uk697H73KvduRK2Q4rul1RJOQEmYTw
         BFLQ==
X-Gm-Message-State: AOAM532epCg8QHovAwOAPf117KcW4Ncfp8PVi2OG+ufX0mlII6e7KHzE
        l1YGGymQkFbFSbDVzWAFmZsCJX6oF9eGzA==
X-Google-Smtp-Source: ABdhPJw/BUBgmN9yNN2hzdwh+UrIj5ORi6X09rUdO0/PFB/ksXYr7jo8r8k8r/Ypty1YlFqVLldTTA==
X-Received: by 2002:aca:4257:: with SMTP id p84mr4894326oia.176.1607594746505;
        Thu, 10 Dec 2020 02:05:46 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 9sm986728otl.52.2020.12.10.02.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:05:45 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 3/3] pull: display default warning only when non-ff
Date:   Thu, 10 Dec 2020 04:05:38 -0600
Message-Id: <20201210100538.696787-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210100538.696787-1-felipe.contreras@gmail.com>
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to display the annoying warning on every pull... only
the ones that are not fast-forward.

This requires the tests to pick another base, so the merge is not
fast-forward. And in the cases where --ff-only is specified add
test_must_fail (since now they are non-fast-forward).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               |  7 +++++--
 t/t7601-merge-pull-config.sh | 28 +++++++++++++++++-----------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index ff8e3ce137..9a7caf3a3e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -934,6 +934,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
 	int autostash;
+	int can_ff;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -1029,7 +1030,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
-	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
+
+	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
 		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
 			 "discouraged. You can squelch this message by running one of the following\n"
 			 "commands sometime before your next pull:\n"
@@ -1058,7 +1061,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
-			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
+			if (can_ff) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
 				ran_ff = 1;
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6774e9d86f..6b4adab8b1 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'pull.rebase not set' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git -c color.advice=always pull . c1 2>err &&
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
@@ -36,54 +36,60 @@ test_expect_success 'pull.rebase not set' '
 
 '
 
-test_expect_success 'pull.rebase not set and pull.ff=true' '
+test_expect_success 'pull.rebase not set (fast-forward)' '
 	git reset --hard c0 &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and pull.ff=true' '
+	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	test_config pull.ff only &&
-	git pull . c1 2>err &&
+	test_must_fail git pull . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --no-rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
-	git reset --hard c0 &&
-	git pull --ff-only . c1 2>err &&
+	git reset --hard c2 &&
+	test_must_fail git pull --ff-only . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.29.2

