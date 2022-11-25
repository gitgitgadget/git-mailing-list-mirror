Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A9C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKYJy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKYJyc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:54:32 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2BC48417
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x17so5952816wrn.6
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBI2XrDpwLHXbAoJ0T0b3JqX5iW/bHQ+RbCJX8+591g=;
        b=CX6+iiCezlWkyx8j81/VK55ogg76yligc/P96JDoCcJtPfHBiz+QCvBq+PmbxMEL2V
         kzsbDld+WIjLY6WKH9h578Are7uJYgDMjc+YQdvVrBMkwt55kLCV3ZlFaVd8JiXn+ayL
         WVJra7mLj81FVTt1uQnZ2qt/moOYtiNIyuckVN+iAbyu09cOlaNC8Bh4/dIXwpD9FoaN
         b0UEK+b6va1SK4JAqJjKEOoNEk0lKH2fQMOkIgu4Qv7tosoPmUMaJN6JHO9/lcRNby2p
         668suHbWozTA8pk6onBM87yxnfWEnvZB8Dkn6RzUhqzin+s3Zl49SxDIQHTRMEn2RGVv
         j+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBI2XrDpwLHXbAoJ0T0b3JqX5iW/bHQ+RbCJX8+591g=;
        b=qCmTzwGBLBEVFjpNcSlYXyZG4LX3V0HGj9AUnGS+boursXQ0vlnisGhBq+8nRZcFwe
         Vs3Dhnv7nxmrcUYIIG9g32+nLiA6e4yzG04H6WsHUSMx6I/XYijlPF2E3eZFUbrP13YK
         n0ctkSaGlJKP0HBczCVEtBWITD3p3Rc02xe57PYGnL8H05O6Ro7fXqLeLB8czK/Lrcj4
         v8bOwe5PBSPEmM1JgXV1MRas+Hq4MgDjINKZN23WbIKxYm5tBNjQdDNgOe7RzpuON5zd
         6/8drN5hkJtjSM++/azI8Ki8OYiwlsA0wnsDZA4zJ5q5CQ4Pv7NL3EgUeoU7vhURcCZn
         Ev8A==
X-Gm-Message-State: ANoB5pmw2Qz49/A+Zi+9Wa0tqR9/r1h30ub8/jqkE2qLzaHVZ2E7goq5
        Vs2we7Bi2HtvNKNIGTnfPTZamTITa5SjPfs/
X-Google-Smtp-Source: AA0mqf55pgbXpiiDyLyniu4m6C1IDwGsHPNEbap3TCf1PQpf/qrOVpYfsxBGbRATZkuzQdtpJ4g1tQ==
X-Received: by 2002:a05:6000:12d1:b0:236:71fe:c9c5 with SMTP id l17-20020a05600012d100b0023671fec9c5mr22010431wrx.677.1669369883400;
        Fri, 25 Nov 2022 01:51:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b0023655e51c33sm3420975wrm.4.2022.11.25.01.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:51:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/9] config tests: cover blind spots in git_die_config() tests
Date:   Fri, 25 Nov 2022 10:50:03 +0100
Message-Id: <patch-v3-2.9-3eb8da6086d-20221125T093159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.955.ge9b241be664
In-Reply-To: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
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

Let's check for that by extending the existing tests, and adding a new
one for "fetch.negotiationAlgorithm" so that we have a test for a user
of git_config_get_string*() calling git_die_config().

The other ones are testing:

- For *-resolve.sh: A custom call to git_die_config(), or via
  git_config_get_notes_strategy()
- For *-prune.sh: A call via git_config_get_expiry().

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
index 8ae314af585..c8fa962b397 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -64,8 +64,16 @@ test_expect_success 'gc: implicit prune --expire' '
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
2.39.0.rc0.955.ge9b241be664

