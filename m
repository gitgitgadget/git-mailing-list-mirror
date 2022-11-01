Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3828FC4321E
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiKAXFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiKAXFh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF060C9
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:05:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q9so41011426ejd.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6c9TprEpV9WuIUmNMG1reX7F0ikEZHtA3DQNcpC2NA=;
        b=ovvf8yfbvG6UviSh1TeeWJCg70MXu9pa6HTWpWuT0YqveIJ8v2+S3ZzhXFPcENNSO+
         +0AbkGEzGUWw79C2tMCL5jTbPhc9YYtAUds1hVrg568Xf92AFz9Pz/Wee3GXNshb3BpQ
         lulEB4GMANGehJEHhkxP6rdrENxk3DKTC69olgo/jJBba5IDlMUKiXDYBUE/4pEWQPP3
         Tfa5CRHd55QNQ0a8Kbq6AMXgsd3OiLI9TXe+17/nKckcOGIWTqejMEkA5Y/Y3Gg2uoNn
         ifiXcTnuGovhu2YiwWVAF/liZeN9OGDQ/0QlH/fsrxkxGhfpbPv/fRd0DEm7Q7PN9oAZ
         QhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6c9TprEpV9WuIUmNMG1reX7F0ikEZHtA3DQNcpC2NA=;
        b=fhbE2JPDdIB1NaYH7xPRNT9gcBXmzBd8sK81jG18kKvR5OC5LGw6JRNWjumJIWFFSZ
         0wUbNRXx7xTATMAhr0NBsJl2zYgTmmrZMVp5EmmSRHsr9GVjCDIWcz03tA9X3PLCTx1C
         ZNlAMCbZOmo+iebG08FmoE204WB7hsaIQISgn/4NxYRmykM0K8Ovj4mXR+MPQkCMrrPt
         jvD+eMy2HZcAMuRs5FJ2ytzS+4iN50vOEobN36mYeRAF0kJ5d/ryauw1OoZgfu6GLD1h
         7aQyxqzQXukbEbf1z0Q/IXnvd+hCD7Z7iAOP/iSQwqOGjqYiUALyR8js0UThf5lb7CD4
         Cxcw==
X-Gm-Message-State: ACrzQf0hmt2DjSGasT7b64U++xiYERw7qTFPBZj57pTr21cB+Z081dtp
        RgIUFI4DCYXQKtCFbH15Mv862eVJQUlpew==
X-Google-Smtp-Source: AMsMyM41KYM+ar//zVHVX6BXQEqaozV+PjyyplHRp42cCKmRvAJZHnWT4vH8oJhWOpKYmVHYwq057A==
X-Received: by 2002:a17:906:fe46:b0:73d:939a:ec99 with SMTP id wz6-20020a170906fe4600b0073d939aec99mr20771345ejb.169.1667343934017;
        Tue, 01 Nov 2022 16:05:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090631d200b0078cb06c2ef9sm4645202ejf.8.2022.11.01.16.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:05:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/9] config tests: cover blind spots in git_die_config() tests
Date:   Wed,  2 Nov 2022 00:05:13 +0100
Message-Id: <patch-v2-2.9-6cd0d6faf3c-20221101T225823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
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
2.38.0.1280.g8136eb6fab2

