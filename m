Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03725C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiLOJdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiLOJdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:33:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511552DDD
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:32:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c17so26163309edj.13
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qDY3IPj2/xenHISiRFCOuHSiEkYq9I3l+Etnk4wQn8=;
        b=T3goYIeCy+DAPXK/Y2OAyH+umtAr5opURM/7gpWyTKnL7APMNpJp8Lsdsz9TZ05uDM
         D8UfPAUry4nU28KvetRYZAO1H00MSd07gHy5RT3Ml4HxQQtK9cjcI7w69jVKRd7Be1uL
         lAn0P8b3WsauxnzxK4w8X0UYAoGg8qri2Dy3dl7OTrMTSLETWQNPVzgMWOo/zPBMkFIR
         hvGG7UTSUI1iWBHAGp9p+7HsJ//eDJSHyORJ0yQxxPmx+cq2MjHQ9zWgx2hrqFHLQc9N
         U4HFrst+AI13PgSNAarucuV47/LfGq93SP6b6Bhv4qjBBvEH1lZ080PjA9/K4+pPc/fp
         lF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qDY3IPj2/xenHISiRFCOuHSiEkYq9I3l+Etnk4wQn8=;
        b=q2e7XEaXLr9w9eFztqqv1v6lySq6hpw64bwSNoqrvMmkXocPkVDGts51Y7/dCAo978
         EMWD5CSAJW2ljXjuiQSODxnM1T2nwgALII9d34e7xaAp8ZTwbNdMUZHDG5JFJ9Sbaf06
         w9GMc6UFRrNjmjTuxA7f+OGk6Hhdm3kYjbQd6AYbBu0MqunL86sgVjy0Q9j3llVOsEl+
         bJ2a1OE390o72nrDu78i2sjrLZ0B72Q7WiXvWWxJUxJjeknK1tLMfVQT+6NQ/MrS0KqF
         BU+xjMcRLCzjEbrlVa96fd6ssYQ4i3G9ZrGssFUkl963tIEQBILWu3obdqyR5teTgWPv
         5Ptg==
X-Gm-Message-State: ANoB5pkV6xQMnNXeXBU53EoDodQKOh6Z8EEaXkR+Ws4k3C0JL/DFaZZq
        B3F0NH7G9rp/EoIXQobxos0GQT8RhCCpTA==
X-Google-Smtp-Source: AA0mqf7OCWzWrM/i0E0ZUhON5AfKRmOcvwIU8k/GUQxZowinUpH8YdWSomN14C6JZs/yY9qZW1n99w==
X-Received: by 2002:a05:6402:3643:b0:461:78ef:56f2 with SMTP id em3-20020a056402364300b0046178ef56f2mr24355209edb.34.1671096777431;
        Thu, 15 Dec 2022 01:32:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b007c1675d2626sm5457702ejt.96.2022.12.15.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:32:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/9] submodule absorbgitdirs tests: add missing "Migrating git..." tests
Date:   Thu, 15 Dec 2022 10:32:42 +0100
Message-Id: <patch-v4-1.9-f479003941b-20221215T083502Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blind spots in the tests surrounding "submodule absorbgitdirs"
and test what output we emit, and how emitted the message and behavior
interacts with a "git worktree" where the repository isn't at the base
of the working directory.

The "$(pwd)" instead of "$PWD" here is needed due to Windows, where
the latter will be a path like "/d/a/git/[...]", whereas we need
"D:/a/git/[...]".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7412-submodule-absorbgitdirs.sh | 64 ++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 2859695c6d2..d556342ea57 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -10,6 +10,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a real submodule' '
+	cwd="$(pwd)" &&
 	git init sub1 &&
 	test_commit -C sub1 first &&
 	git submodule add ./sub1 &&
@@ -18,13 +19,21 @@ test_expect_success 'setup a real submodule' '
 '
 
 test_expect_success 'absorb the git dir' '
+	>expect &&
+	>actual &&
 	>expect.1 &&
 	>expect.2 &&
 	>actual.1 &&
 	>actual.2 &&
 	git status >expect.1 &&
 	git -C sub1 rev-parse HEAD >expect.2 &&
-	git submodule absorbgitdirs &&
+	cat >expect <<-EOF &&
+	Migrating git directory of '\''sub1'\'' from
+	'\''$cwd/sub1/.git'\'' to
+	'\''$cwd/.git/modules/sub1'\''
+	EOF
+	git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	git fsck &&
 	test -f sub1/.git &&
 	test -d .git/modules/sub1 &&
@@ -37,7 +46,8 @@ test_expect_success 'absorb the git dir' '
 test_expect_success 'absorbing does not fail for deinitialized submodules' '
 	test_when_finished "git submodule update --init" &&
 	git submodule deinit --all &&
-	git submodule absorbgitdirs &&
+	git submodule absorbgitdirs 2>err &&
+	test_must_be_empty err &&
 	test -d .git/modules/sub1 &&
 	test -d sub1 &&
 	! test -e sub1/.git
@@ -56,7 +66,13 @@ test_expect_success 'setup nested submodule' '
 test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >expect.1 &&
 	git -C sub1/nested rev-parse HEAD >expect.2 &&
-	git submodule absorbgitdirs &&
+	cat >expect <<-EOF &&
+	Migrating git directory of '\''sub1/nested'\'' from
+	'\''$cwd/sub1/nested/.git'\'' to
+	'\''$cwd/.git/modules/sub1/modules/nested'\''
+	EOF
+	git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	test -f sub1/nested/.git &&
 	test -d .git/modules/sub1/modules/nested &&
 	git status >actual.1 &&
@@ -87,7 +103,13 @@ test_expect_success 're-setup nested submodule' '
 test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >expect.1 &&
 	git -C sub1/nested rev-parse HEAD >expect.2 &&
-	git submodule absorbgitdirs &&
+	cat >expect <<-EOF &&
+	Migrating git directory of '\''sub1'\'' from
+	'\''$cwd/sub1/.git'\'' to
+	'\''$cwd/.git/modules/sub1'\''
+	EOF
+	git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	test -f sub1/.git &&
 	test -f sub1/nested/.git &&
 	test -d .git/modules/sub1/modules/nested &&
@@ -97,6 +119,27 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	test_cmp expect.2 actual.2
 '
 
+test_expect_success 'absorb the git dir outside of primary worktree' '
+	test_when_finished "rm -rf repo-bare.git" &&
+	git clone --bare . repo-bare.git &&
+	test_when_finished "rm -rf repo-wt" &&
+	git -C repo-bare.git worktree add ../repo-wt &&
+
+	test_when_finished "rm -f .gitconfig" &&
+	test_config_global protocol.file.allow always &&
+	git -C repo-wt submodule update --init &&
+	git init repo-wt/sub2 &&
+	test_commit -C repo-wt/sub2 A &&
+	git -C repo-wt submodule add ./sub2 sub2 &&
+	cat >expect <<-EOF &&
+	Migrating git directory of '\''sub2'\'' from
+	'\''$cwd/repo-wt/sub2/.git'\'' to
+	'\''$cwd/repo-bare.git/worktrees/repo-wt/modules/sub2'\''
+	EOF
+	DO_IT=1 git -C repo-wt submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup a gitlink with missing .gitmodules entry' '
 	git init sub2 &&
 	test_commit -C sub2 first &&
@@ -107,7 +150,11 @@ test_expect_success 'setup a gitlink with missing .gitmodules entry' '
 test_expect_success 'absorbing the git dir fails for incomplete submodules' '
 	git status >expect.1 &&
 	git -C sub2 rev-parse HEAD >expect.2 &&
-	test_must_fail git submodule absorbgitdirs &&
+	cat >expect <<-\EOF &&
+	fatal: could not lookup name for submodule '\''sub2'\''
+	EOF
+	test_must_fail git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	git -C sub2 fsck &&
 	test -d sub2/.git &&
 	git status >actual &&
@@ -127,8 +174,11 @@ test_expect_success 'setup a submodule with multiple worktrees' '
 '
 
 test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
-	test_must_fail git submodule absorbgitdirs sub3 2>error &&
-	test_i18ngrep "not supported" error
+	cat >expect <<-\EOF &&
+	fatal: could not lookup name for submodule '\''sub2'\''
+	EOF
+	test_must_fail git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.39.0.rc2.1048.g0e5493b8d5b

