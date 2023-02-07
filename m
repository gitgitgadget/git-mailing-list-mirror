Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FCEC636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 16:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBGQLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBGQK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 11:10:59 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9226FF0B
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 08:10:57 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u21so16282236edv.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gEi3Xke5TU+9qYxym/Pk389b3yqRI5aUUljUPno9mU=;
        b=fb1Knm5X3M852nH4v5RHArMmf6FqrtYivQKJbhe/ouRGdqY3Zt/JzKMmO2n9D+VPm6
         QFoHLnGKq2UjO8FcpFQQyhzjmCgbrqhz+7uhLe1iKTm77gpbVmF9yY8yq+IPx6rTaGPC
         ut/zKaEp5evEDDmT04iinz/Hjae8UyawNsyl+VpWLQzElhrqkhNLUPB4ysZsDEtb83yH
         x6rI7jAMS8EIsArnqRRkqzWrqQlKNN39yikS8VU1hwYGzi5ta0jvby8Ia9A2sIQjzAXh
         o8WzX5+qNf5XcpbvbsfRoeTbXrA0+qbSau+7flnOA9zmbRDq0eOVQbymlkZHQ5lry1J+
         d00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gEi3Xke5TU+9qYxym/Pk389b3yqRI5aUUljUPno9mU=;
        b=lvtCmiPkNOTshaCe9fyisXhINwKwxVx9rlwPtaEJtp4U1brVQyZ4H6jGsxgiiQW2PH
         9k94wLxs5UPQVXVqXEC+7XI/HY0QGv88Qi7BLr1LRsgx9dOS+d4oGGBEL6VgKk2Rn1WR
         YA/G4iDZ8CGRGuS4Xp5VDWp2b4Q7t3cauHu52vkS75RJHFK4sgjfCHmf+Y5wvITiISqA
         IKFdz1T81FRFvUHPDkAT3VxEmtT/fJOhC66dUoRei7OcCREoUhBwWKWf6agbD6ZjoW+G
         8+qgbXaY1x150DkgW0jFOG9eghhZnBoaGfGZLKUkR4g2RVoeaRHTYyXFQRKDQFpcmX7j
         Oppw==
X-Gm-Message-State: AO0yUKWCQ3BLqJgzZ70y/D30NMV2vA6mTzN71NkP729EIzsPh24YsRpz
        tVSmDxgWxi9deGjUkrd9ua++pHyUoif4JVBR
X-Google-Smtp-Source: AK7set/Kp6ft3io2yE3iuk5EQjHJNrfR8ipMW7XKwYWIuCJl045+OQTnaNNC+UIsw32dKqK/4kFWdg==
X-Received: by 2002:a17:906:a0c:b0:87b:db29:61af with SMTP id w12-20020a1709060a0c00b0087bdb2961afmr3815021ejf.24.1675786255991;
        Tue, 07 Feb 2023 08:10:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906080400b008a60ed04e42sm2401167ejd.110.2023.02.07.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:10:55 -0800 (PST)
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
Subject: [PATCH v5 01/10] config tests: cover blind spots in git_die_config() tests
Date:   Tue,  7 Feb 2023 17:10:41 +0100
Message-Id: <patch-v5-01.10-cefc4188984-20230207T154000Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1430.gb2471c0aaf4
In-Reply-To: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
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
2.39.1.1430.gb2471c0aaf4

