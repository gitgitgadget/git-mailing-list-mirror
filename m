Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372F8C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 18:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CC461075
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 18:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhHYSQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 14:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhHYSQt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 14:16:49 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518F9C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 11:16:03 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id m21so314779qkm.13
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBMsAAvOG6dhTGh2p7L591plmVe16IN7MmEDnQqKNcU=;
        b=D/xHFntwGtV+0VcYAm7QzZuuNNgZFdXAXHXMfIM4VS6cRLJ+rrIvPoG5D0gpei0udV
         xc/t/FU+OZw0w/QojtJwuvYuNqOWci5srPDoP3Lr9iF1mBs/4E5Ftjg/bH6Um7Cbm6P9
         aYWaxDBHyUYhI7X6M9xvCZ+/2W+NyCozqMYWL2aZECcb3kJHY2LB3XVbxza8mEXZ7wUP
         iYo9AwJ98Vz356M1NogDCOoPJbVtO0mb/p9xaH3kDpXI65ilCfOLgNQqi1q7D5fRYaZw
         C5aC1jL5eM8xV5fisuAUoDEw7hU4y5akQcQlJ7+HTdlRXygVucLd91fKEOSq3D2szG1L
         p9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBMsAAvOG6dhTGh2p7L591plmVe16IN7MmEDnQqKNcU=;
        b=c9okSruK6S1Ws504CkgN135h8nhKJEDiI4V295vINu1r5woRgLYY2iFZ31dHeFEgtZ
         4LT89NV0oiaU9kzsqwdg3gReQLPnID3k5wOpyrpF+WYbIdjlJWxZkYywTVoTj3rUj+F0
         KPKvgqilmnE87TNsc0fvapSYPzLKeKn3Sj+5XBA9UBpVilOhp/Qkea2C27+7bp1f28H4
         mDa/G+LVkOgO6ZKmLBnFOSS6SUFoV4clfIzqBdsYzhc2z/3ATgFypbvLXq46PHlCof6z
         ojAjCKmD7Hxdyg64rMLYzx/ribGcQARNTI3NT8nRtLdw5JiQbEAwY0oTVziyZ4J8HSK5
         /3eA==
X-Gm-Message-State: AOAM5320plZZ7j8Rk0w0zuQvUUbi7zcVnw7IMUrZX1chBR05b7c+qaCR
        sKvKNeQoBW6qcC1zccPTTorB2A==
X-Google-Smtp-Source: ABdhPJy5xEIACX18DQuu9O8s0/f5pbW6bqC9uUbZ29+FTloSv3jSuQmPtCyj4sZ3BUOqcT4YoxiE2A==
X-Received: by 2002:a37:2d04:: with SMTP id t4mr33337405qkh.463.1629915362459;
        Wed, 25 Aug 2021 11:16:02 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id d20sm539157qkl.13.2021.08.25.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 11:16:02 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     peff@peff.net
Cc:     allred.sean@gmail.com, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: [PATCH] checkout: make delayed checkout respect --quiet and --no-progress
Date:   Wed, 25 Aug 2021 15:15:55 -0300
Message-Id: <d1405b781915c085ac8a8965dadf3efbe1b0f6aa.1629915330.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YF2b8LLhE0vjc7mg@coredump.intra.peff.net>
References: <YF2b8LLhE0vjc7mg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'Filtering contents...' progress report from delayed checkout is
displayed even when checkout and clone are invoked with --quiet or
--no-progress. Furthermore, it is displayed unconditionally, without
first checking whether stdout is a tty. Let's fix these issues and also
add some regression tests for the two code paths that currently use
delayed checkout: unpack_trees.c:check_updates() and
builtin/checkout.c:checkout_worktree().

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

The test section of the patch is a bit long because it checks all the
verbosity options related to the progress report, and it also tests both
the check_updates() and checkout_worktree() code paths. If that is
overkill, I can remove some tests.

 builtin/checkout.c    |  2 +-
 entry.c               |  7 +++--
 entry.h               |  3 ++-
 t/t0021-conversion.sh | 63 +++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c        |  2 +-
 5 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a..b23bc149d1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -404,7 +404,7 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	mem_pool_discard(&ce_mem_pool, should_validate_cache_entries());
 	remove_marked_cache_entries(&the_index, 1);
 	remove_scheduled_dirs();
-	errs |= finish_delayed_checkout(&state, &nr_checkouts);
+	errs |= finish_delayed_checkout(&state, &nr_checkouts, opts->show_progress);
 
 	if (opts->count_checkout_paths) {
 		if (nr_unmerged)
diff --git a/entry.c b/entry.c
index 125fabdbd5..044e8ec92c 100644
--- a/entry.c
+++ b/entry.c
@@ -159,7 +159,8 @@ static int remove_available_paths(struct string_list_item *item, void *cb_data)
 	return !available;
 }
 
-int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
+int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
+			    int show_progress)
 {
 	int errs = 0;
 	unsigned delayed_object_count;
@@ -173,7 +174,9 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 
 	dco->state = CE_RETRY;
 	delayed_object_count = dco->paths.nr;
-	progress = start_delayed_progress(_("Filtering content"), delayed_object_count);
+	progress = show_progress
+		? start_delayed_progress(_("Filtering content"), delayed_object_count)
+		: NULL;
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
 			struct string_list available_paths = STRING_LIST_INIT_NODUP;
diff --git a/entry.h b/entry.h
index b8c0e170dc..7c889e58fd 100644
--- a/entry.h
+++ b/entry.h
@@ -43,7 +43,8 @@ static inline int checkout_entry(struct cache_entry *ce,
 }
 
 void enable_delayed_checkout(struct checkout *state);
-int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
+int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
+			    int show_progress);
 
 /*
  * Unlink the last component and schedule the leading directories for
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index b5749f327d..be12b92f21 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -6,6 +6,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 TEST_ROOT="$PWD"
 PATH=$TEST_ROOT:$PATH
@@ -1061,4 +1062,66 @@ test_expect_success PERL,SYMLINKS,CASE_INSENSITIVE_FS \
 	)
 '
 
+test_expect_success PERL 'setup for progress tests' '
+	git init progress &&
+	(
+		cd progress &&
+		git config filter.delay.process "rot13-filter.pl delay-progress.log clean smudge delay" &&
+		git config filter.delay.required true &&
+
+		echo "*.a filter=delay" >.gitattributes &&
+		touch test-delay10.a &&
+		git add . &&
+		git commit -m files
+	)
+'
+
+for mode in pathspec branch
+do
+	case "$mode" in
+	pathspec) opt='.' ;;
+	branch) opt='-f HEAD' ;;
+	esac
+
+	test_expect_success PERL,TTY "delayed checkout shows progress by default only on tty ($mode checkout)" '
+		(
+			cd progress &&
+			rm -f *.a delay-progress.log &&
+			test_terminal env GIT_PROGRESS_DELAY=0 git checkout $opt 2>err &&
+			grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
+			grep "Filtering content" err &&
+
+			rm -f *.a delay-progress.log &&
+			GIT_PROGRESS_DELAY=0 git checkout $opt 2>err &&
+			grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
+			! grep "Filtering content" err
+		)
+	'
+
+	test_expect_success PERL,TTY "delayed checkout ommits progress with --quiet ($mode checkout)" '
+		(
+			cd progress &&
+			rm -f *.a delay-progress.log &&
+			test_terminal env GIT_PROGRESS_DELAY=0 git checkout --quiet $opt 2>err &&
+			grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
+			! grep "Filtering content" err
+		)
+	'
+
+	test_expect_success PERL,TTY "delayed checkout honors --[no]-progress ($mode checkout)" '
+		(
+			cd progress &&
+			rm -f *.a delay-progress.log &&
+			test_terminal env GIT_PROGRESS_DELAY=0 git checkout --no-progress $opt 2>err &&
+			grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
+			! grep "Filtering content" err &&
+
+			rm -f *.a delay-progress.log &&
+			test_terminal env GIT_PROGRESS_DELAY=0 git checkout --quiet --progress $opt 2>err &&
+			grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
+			grep "Filtering content" err
+		)
+	'
+done
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 5786645f31..f07304f1b7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -479,7 +479,7 @@ static int check_updates(struct unpack_trees_options *o,
 		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
 					      progress, &cnt);
 	stop_progress(&progress);
-	errs |= finish_delayed_checkout(&state, NULL);
+	errs |= finish_delayed_checkout(&state, NULL, o->verbose_update);
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
 	if (o->clone)
-- 
2.32.0

