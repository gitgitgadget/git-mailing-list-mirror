Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EDAC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 13:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjBBN1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBBN1w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 08:27:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B718C42F
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 05:27:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso1386116wms.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 05:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRW7mHY9/QvX8zcbl7zdiGKNV8MYDAFfHdG9TjFWy2E=;
        b=oSFBEb8BusRSTMOU2TRMSe32Kjvg/+5bl0BQQ+PhgMHvXKKA7Ft7bpAN9200S34wCG
         HXULKCn4eDE+7zjj5dEUC3rQ/Jf2Mpuov4yAoIaGOQvN7GpkJ9G/dnWYWX4Zj4jnsd+/
         3Kva/P5zFY9zibC02/0AZZpFj8IdqncQh84JAokwDBguKRt98jAikaNYGwht29ElXw19
         PuHDrujdGNYVZpdIVqwWH17MjpD9/ISAQ4DpQJ+1p8mFQEHfDJSeaSmRosI2JzwUm2yY
         Je3nEoCijcJ2bqoajy33oCPlHPgSTu3h/5UtA7NGr8ftzGzLM9WTJ0/l8lLnvH33AX+u
         n3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRW7mHY9/QvX8zcbl7zdiGKNV8MYDAFfHdG9TjFWy2E=;
        b=fSK+5ZE/OiMSmMwPoVfM/eYbbOan3H5aebUikk3ptLi43989hZkzRxrK95uKa83tWJ
         tlebzgyswDLH/YE9vKEb/GKUIl4z1TMWuL5pYb6JUSkY5hBjfM2sSW0BBo7hWoPu6kW9
         k1ltLcgf1rhpiX2jncQhqhuDC8KCYG/sq/1BqYEcfHAjWBSUnN2lgR9bdna+ndjGOjYI
         6gJbQa1Dm5jsBDZnruHzAD73OrlAi/YQV2wdPuPOkQWxymAIoT/nSqepLM7BJUB/fPQD
         l0p/FNw4lzPHBZNagX1XqfI0y266U928PD12PA/IlCKRPmyEtgEVuCAcAESbWaYrkMfR
         RsdQ==
X-Gm-Message-State: AO0yUKUbPc/8N9NHc0YSNDYhejGn6JPJZr7Gv2ytRRjDV5CMngbY1/8f
        3aLSpNJK0z7FrcfTkaDUoVfE85jsKLBV2k/r
X-Google-Smtp-Source: AK7set+679Hv6A0H1uRtJ+uf6ml1xnYvvUifNQ9lmAW+jNpPtHFFBFUq4KnKKumjAmMOPmcPGIAOqw==
X-Received: by 2002:a05:600c:4f8d:b0:3dc:e66:4cb9 with SMTP id n13-20020a05600c4f8d00b003dc0e664cb9mr5982589wmq.13.1675344449238;
        Thu, 02 Feb 2023 05:27:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003dc48a2f997sm4306052wmf.17.2023.02.02.05.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:27:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/9] config tests: cover blind spots in git_die_config() tests
Date:   Thu,  2 Feb 2023 14:27:13 +0100
Message-Id: <patch-v4-1.9-4ae56cab7c7-20230202T131155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.g8c8c074958d
In-Reply-To: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were no tests checking for the output of the git_die_config()
function in the config API, added in 5a80e97c827 (config: add
`git_die_config()` to the config-set API, 2014-08-07). We only tested
"test_must_fail", but didn't assert the output.

We need tests for this because a subsequent commit will alter the
return value of git_config_get_value_multi(), which is used to get the
config values in the git_die_config() function. This test coverage
helps to build confidence in that subsequent change.

These tests cover different interactions with git_die_config():

- The "notes.mergeStrategy" test in
  "t/t3309-notes-merge-auto-resolve.sh" is a case where a function
  outside of config.c (git_config_get_notes_strategy()) calls
  git_die_config().

- The "gc.pruneExpire" test in "t5304-prune.sh" is a case where
  git_config_get_expiry() calls git_die_config(), covering a different
  "type" than the "string" test for "notes.mergeStrategy".

- The "fetch.negotiationAlgorithm" test in
  "t/t5552-skipping-fetch-negotiator.sh" is a case where
  git_config_get_string*() calls git_die_config().

We also cover both the "from command-line config" and "in file..at
line" cases here.

The clobbering of existing ".git/config" files here is so that we're
not implicitly testing the line count of the default config.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3309-notes-merge-auto-resolve.sh  |  7 ++++++-
 t/t5304-prune.sh                     | 12 ++++++++++--
 t/t5552-skipping-fetch-negotiator.sh | 16 ++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index 141d3e4ca4d..9bd5dbf341f 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -360,7 +360,12 @@ test_expect_success 'merge z into y with invalid strategy => Fail/No changes' '
 
 test_expect_success 'merge z into y with invalid configuration option => Fail/No changes' '
 	git config core.notesRef refs/notes/y &&
-	test_must_fail git -c notes.mergeStrategy="foo" notes merge z &&
+	cat >expect <<-\EOF &&
+	error: unknown notes merge strategy foo
+	fatal: unable to parse '\''notes.mergeStrategy'\'' from command-line config
+	EOF
+	test_must_fail git -c notes.mergeStrategy="foo" notes merge z 2>actual &&
+	test_cmp expect actual &&
 	# Verify no changes (y)
 	verify_notes y y
 '
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index d65a5f94b4b..5500dd08426 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -72,8 +72,16 @@ test_expect_success 'gc: implicit prune --expire' '
 '
 
 test_expect_success 'gc: refuse to start with invalid gc.pruneExpire' '
-	git config gc.pruneExpire invalid &&
-	test_must_fail git gc
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	>repo/.git/config &&
+	git -C repo config gc.pruneExpire invalid &&
+	cat >expect <<-\EOF &&
+	error: Invalid gc.pruneexpire: '\''invalid'\''
+	fatal: bad config variable '\''gc.pruneexpire'\'' in file '\''.git/config'\'' at line 2
+	EOF
+	test_must_fail git -C repo gc 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'gc: start with ok gc.pruneExpire' '
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 165427d57e5..b55a9f65e6b 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -3,6 +3,22 @@
 test_description='test skipping fetch negotiator'
 . ./test-lib.sh
 
+test_expect_success 'fetch.negotiationalgorithm config' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cat >repo/.git/config <<-\EOF &&
+	[fetch]
+	negotiationAlgorithm
+	EOF
+	cat >expect <<-\EOF &&
+	error: missing value for '\''fetch.negotiationalgorithm'\''
+	fatal: bad config variable '\''fetch.negotiationalgorithm'\'' in file '\''.git/config'\'' at line 2
+	EOF
+	test_expect_code 128 git -C repo fetch >out 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+'
+
 have_sent () {
 	while test "$#" -ne 0
 	do
-- 
2.39.1.1397.g8c8c074958d

