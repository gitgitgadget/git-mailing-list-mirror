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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C1C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D821560F25
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhHDFiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbhHDFiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:38:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C3DC061798
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:38:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p5so812647wro.7
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vXzpr4mBuAan/TfaY8pYS0X5/xTK3QoxcMpyEW5wNLA=;
        b=RATmp/pVP9MMdZUWzc6p+ua70ogHZtdaprA0VWON/geS1XwIsRhM5LJDJa24tmquGU
         Uz+1k9JiNaiXBnqeCFEw6ltrMgJAyFk5QPxE1Eo99+NEU2t19YVovcfX2WUpC/6doGQB
         gDKJ0PpoVZoR9/JEUUiPOL2885zrybzNLHt8/0ZM4nAr0p7OIdPiOTLMF+R/HT5dMtLn
         X/RZLdKV0NY7OZp2Ua815KcXfRunfrJB6JGs0bsFVFrEyZ/hp1ykc3OgsBXCoxfJB/ej
         A9LR2Mgftcw5PJXHqriHMUzVIMQhByhKBXq5yB5j8Vj/azdxdO9KdWlx8reeAIAtFLCP
         Jriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vXzpr4mBuAan/TfaY8pYS0X5/xTK3QoxcMpyEW5wNLA=;
        b=Rq5V1ekwQlPpwSJ10KndElHdpQ2Yf7ejTgAJUHos67n3hCbWTU5Cflp61czooz4fPI
         Bs6q4T7rAYzx4MK6+Pu6TrvAEXvrtPiZNMfkMCPEz3O4Jj0ABi39+U+KiWUqSUD6MuqN
         hMfWpVCFKYrQP1HYW3yHbnUhZh0/2Da68DkDOYdF5vh2UrJrMylYd1lREDao35oU2gHg
         zHN4Kj43VGWP7DG3yf/NDXwyN7OrzukrzICnT/nJbf7Wd4oF+HyDTjpWdJeqhIvwmSZJ
         GeSnKhqBy8OJkFfIUemKrdRnUqSwg0nmkPc/+08dShorvu5qic88QccKkRHkn5eloiY9
         kPfw==
X-Gm-Message-State: AOAM533YQGqleJj9KcauVOJg8Pm7NTqbeI7kDl0+y45vvKRxKtTQe86B
        4YmdhoZfYooyOUDsGuacdb4zGq8axwM=
X-Google-Smtp-Source: ABdhPJxn06GbgXCdHQI0UDJMXz/EguEyYocZHfjPnVNDsnDdtgs+4RehTw25SNNG+6Utrx5/QNqWlg==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr26434276wrs.341.1628055483889;
        Tue, 03 Aug 2021 22:38:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm1107798wrv.20.2021.08.03.22.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:38:03 -0700 (PDT)
Message-Id: <4a0f088f3669a95c7f75e885d06c0a3bdaf31f42.1628055482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1011.git.1628055482.gitgitgadget@gmail.com>
References: <pull.1011.git.1628055482.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:38:01 +0000
Subject: [PATCH 1/2] Change default merge backend from recursive to ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are a few reasons to switch the default:
  * Correctness
  * Extensibility
  * Performance

I'll provide some summaries about each.

=== Correctness ===

The original impetus for a new merge backend was to fix issues that were
difficult to fix within recursive's design.  The success with this goal
is perhaps most easily demonstrated by running the following:

  $ git grep -2 KNOWN_FAILURE t/ | grep -A 4 GIT_TEST_MERGE_ALGORITHM
  $ git grep test_expect_merge_algorithm.failure.success t/
  $ git grep test_expect_merge_algorithm.success.failure t/

In order, these greps show:

  * Seven sets of submodule tests (10 total tests) that fail with
    recursive but succeed with ort
  * 22 other tests that fail with recursive, but succeed with ort
  * 0 tests that pass with recursive, but fail with ort

=== Extensibility ===

Being able to perform merges without touching the working tree or index
makes it possible to create new features that were difficult with the
old backend:

  * Merging, cherry-picking, rebasing, reverting in bare repositories...
    or just on branches that aren't checked out.

  * `git diff AUTO_MERGE` -- ability to see what changes the user has
    made to resolve conflicts so far (see commit 5291828df8 ("merge-ort:
    write $GIT_DIR/AUTO_MERGE whenever we hit a conflict", 2021-03-20)

  * A --remerge-diff option for log/show, used to show diffs for merges
    that display the difference between what an automatic merge would
    have created and what was recorded in the merge.  (This option will
    often result in an empty diff because many merges are clean, but for
    the non-clean ones it will show how conflicts were fixed including
    the removal of conflict markers, and also show additional changes
    made outside of conflict regions to e.g. fix semantic conflicts.)

  * A --remerge-diff-only option for log/show, similar to --remerge-diff
    but also showing how cherry-picks or reverts differed from what an
    automatic cherry-pick or revert would provide.

The last three have been implemented already (though only one has been
submitted upstream so far; the others were waiting for performance work
to complete), and I still plan to implement the first one.

=== Performance ===

I'll quote from the summary of my final optimization for merge-ort
(while fixing the testcase name from 'no-renames' to 'few-renames'):

                               Timings

                                          Infinite
                 merge-       merge-     Parallelism
                recursive    recursive    of rename    merge-ort
                 v2.30.0      current     detection     current
                ----------   ---------   -----------   ---------
few-renames:      18.912 s    18.030 s     11.699 s     198.3 ms
mega-renames:   5964.031 s   361.281 s    203.886 s     661.8 ms
just-one-mega:   149.583 s    11.009 s      7.553 s     264.6 ms

                           Speedup factors

                                          Infinite
                 merge-       merge-     Parallelism
                recursive    recursive    of rename
                 v2.30.0      current     detection    merge-ort
                ----------   ---------   -----------   ---------
few-renames:        1           1.05         1.6           95
mega-renames:       1          16.5         29           9012
just-one-mega:      1          13.6         20            565

And, for partial clone users:

             Factor reduction in number of objects needed

                                          Infinite
                 merge-       merge-     Parallelism
                recursive    recursive    of rename
                 v2.30.0      current     detection    merge-ort
                ----------   ---------   -----------   ---------
mega-renames:       1            1            1          181.3

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c  | 10 ++++++++--
 builtin/rebase.c |  2 +-
 sequencer.c      |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d7b14bf4a7f..fbe21d413c1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -88,9 +88,9 @@ static int autostash;
 static int no_verify;
 
 static struct strategy all_strategy[] = {
-	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
+	{ "recursive",  NO_TRIVIAL },
 	{ "octopus",    DEFAULT_OCTOPUS },
-	{ "ort",        NO_TRIVIAL },
+	{ "ort",        DEFAULT_TWOHEAD | NO_TRIVIAL },
 	{ "resolve",    0 },
 	{ "ours",       NO_FAST_FORWARD | NO_TRIVIAL },
 	{ "subtree",    NO_FAST_FORWARD | NO_TRIVIAL },
@@ -1484,6 +1484,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			fast_forward = FF_NO;
 	}
 
+	if (!use_strategies && !pull_twohead &&
+	    remoteheads && !remoteheads->next) {
+		char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
+		if (default_strategy)
+			append_strategy(get_strategy(default_strategy));
+	}
 	if (!use_strategies) {
 		if (!remoteheads)
 			; /* already up-to-date */
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d9..587a2f1d299 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1713,7 +1713,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		int i;
 
 		if (!options.strategy)
-			options.strategy = "recursive";
+			options.strategy = "ort";
 
 		strbuf_reset(&buf);
 		for (i = 0; i < strategy_options.nr; i++)
diff --git a/sequencer.c b/sequencer.c
index a4e5c43fcf2..d08ddae52fa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -636,7 +636,7 @@ static int do_recursive_merge(struct repository *r,
 	for (i = 0; i < opts->xopts_nr; i++)
 		parse_merge_opt(&o, opts->xopts[i]);
 
-	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
+	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
 		memset(&result, 0, sizeof(result));
 		merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree,
 					    &result);
@@ -3988,7 +3988,7 @@ static int do_merge(struct repository *r,
 	o.branch2 = ref_name.buf;
 	o.buffer_output = 2;
 
-	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
+	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
 		/*
 		 * TODO: Should use merge_incore_recursive() and
 		 * merge_switch_to_result(), skipping the call to
-- 
gitgitgadget

