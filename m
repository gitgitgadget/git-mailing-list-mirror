Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5127DC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjC1OGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjC1OGP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:06:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C4BCC0D
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:04:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so4194461wmq.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OOK10i7DgT28p7HLiKJC10k2AsXfqCe8TFpdOiB4yc=;
        b=i0VdRXk9nnBeMOSa4ym4tYaZQ0cwVMVrcrHPy6hbBUSV2e3dcs3b7aKLnC3hCcQ5gV
         jmhGn1jEud2Mp6pYcES9sLqrqlqvlshaylTZJwH6OZabyaoNjfpLG7efzJHDZicZfFxQ
         SXwU19rYjq7sj7F7YtDG7Mpt8RQ3/eoWJqLEOsx/SwKOmkQhyaUeof6n5zNEb225T000
         F/+yfmm2uwPm7ylbNsXjxOsApshpavvyd0SYpZcooZjvjlaiJrlCOs1Bn1o9vtEe9kZl
         Tre+hTcKtFNTGna1BKTXqSZU/7ZQ5XlzFGqdC2FTT1DQUOXbN6E57t4onrhpcsHQ1Hbn
         +Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OOK10i7DgT28p7HLiKJC10k2AsXfqCe8TFpdOiB4yc=;
        b=ch3mZ7WRAfpeCqfFQiTfbJTbxMCSFLbfVdcVWqtKdCtjaJisBCocyyZoJn8ehIv+UI
         9SPoUHmfeHlUkDrpL9yj/5rC0KfsPIi/DcxRlH72wQkqJ0gYorPn4s44sxS6yLeGc+5P
         xvgrJuw0HQPV7QZ0vJGFk+pARbdVs9eM5KflLfaCy/8ypG58ggX/bBBPskULQYFOH3nX
         t/jWSW0yKSZn+IXwNgspk1I4xOesd3fDQg2jP2wfReWcpjK+WNF3GsqDsuHDH+/IJaEX
         uOoX9N8ugkzeiL+Z6FzEziG/5U6zjaUuNfqB53LcqZfPhjtPMpG5CLJxm6xxPnryiltG
         KipA==
X-Gm-Message-State: AO0yUKVak5Y5MdK6Z19wxdqHkYZb3cArNvMn76NV7aeYoJ2lWZp0G58u
        bHJ+YmsJrO6XfmRDDyb6I6OqdZ5bm+b6zg==
X-Google-Smtp-Source: AK7set9A8MbuV9cM6zL3IHYk1sUAzOu5KAuJpRBTWk6u5+yILwPacIkGybl66xHcXKLd8OShG7MAfw==
X-Received: by 2002:a1c:4b06:0:b0:3ed:316d:668d with SMTP id y6-20020a1c4b06000000b003ed316d668dmr12544104wma.5.1680012277213;
        Tue, 28 Mar 2023 07:04:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003ede3f5c81fsm12903622wms.41.2023.03.28.07.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:04:36 -0700 (PDT)
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
Subject: [PATCH v8 1/9] config tests: cover blind spots in git_die_config() tests
Date:   Tue, 28 Mar 2023 16:04:20 +0200
Message-Id: <patch-v8-1.9-b600354c0f6-20230328T140127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com> <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
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
2.40.0.rc1.1034.g5867a1b10c5

