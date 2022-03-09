Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBE8C433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiCINTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiCINT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC101795D2
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:18:03 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q20so1356514wmq.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1oKUhqigOW/6kmAsfsBgpkBTUZApUX8Azz2qrByCTw=;
        b=LBKgvbtPeLVnOiFH6J7kdYvphhisP/9Rxq9JPiawqKUFaS05K5wYKF8xbhNyjlnZOC
         /el4xzymWMFryEUJ37L1/Gh0DMBo5AhrhCEuM+288M6xSRmgQQL8Q7PW2+4aE15fnl4n
         UlTSN4x6ZGHebWNTBi0Ko+firWk8oYRa9llDkrloOlPR5hcqwDkpJnwjBqDZxE5p24cb
         8qL2jti7xIBM8B8WV62NSscDpB9k410pv9cPre9YJmSyZN9p1eZ52XtrLpLUEhxJdGod
         xUueTDowZgviJKOz266LtpaM0SDQURSAzzI0tkyerQsv4e1x/enR+THdxbfoBSQW4Eui
         URSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1oKUhqigOW/6kmAsfsBgpkBTUZApUX8Azz2qrByCTw=;
        b=4LMj2Vocy3B08svYIdtGd62q6BSLAiLMd/LHSp4ejePTFUGpHm08liQZ7DNep6jKYI
         R9bGWLqA2vopJAoxAks9LjAojwGqeLZN0tZBKgzzVtcWNpu3ZVX3l5iqMJ76VUUK6gQN
         ZdcK9TzSuQdACxBqOKYyikPqMi/v0Y06eWkMoZcp8ekTGv7/8m2SSmqeBaDpfRH5C+sc
         SGjjYgM0x6gc6hEsJluOiDgPjkRJSOsQul1srEv1QyjPn/oVNY8Ik1gxuLX8SbxemGpV
         rVrMHXhWRNTZ5vW0/UeF+RUXDG7AjsdFYkXZRhaKN4yqMTZPTosZHTDGciBUv8cmj+BL
         VAXQ==
X-Gm-Message-State: AOAM530bzRcGfERJYHGu5i6TZeNZ2qmlysI9f2FuNj/3/i8gPqY2La3M
        WCEpBRYT6giXdcrleZ0K1gRPe0t6yD1PqQ==
X-Google-Smtp-Source: ABdhPJwYf6MUIPIVs4ROvqVIRKP0SToFSYsWxSoboTcelCSG8l+nf3ALyslEwk4FWBjn8aW2FGxTsA==
X-Received: by 2002:a05:600c:694:b0:389:9c6e:c265 with SMTP id a20-20020a05600c069400b003899c6ec265mr3359092wmn.5.1646831881477;
        Wed, 09 Mar 2022 05:18:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:18:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/24] revisions API: clear "boundary_commits" in release_revisions()
Date:   Wed,  9 Mar 2022 14:16:50 +0100
Message-Id: <patch-20.24-fa53e81c7c0-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clear the "boundary_commits" object_array in release_revisions(). This
makes a *lot* of tests pass under SANITIZE=leak, including most of the
t/t[0-9]*git-svn*.sh tests.

This includes the tests we had false-positive passes on before my
6798b08e848 (perl Git.pm: don't ignore signalled failure in
_cmd_close(), 2022-02-01), now they pass for real.

Since there are 66 tests matching t/t[0-9]*git-svn*.sh it's easier to
list those that don't pass than to touch most of those 66. So let's
introduce a "TEST_FAILS_SANITIZE_LEAK=true", which if set in the tests
won't cause lib-git-svn.sh to set "TEST_PASSES_SANITIZE_LEAK=true.

This change also marks all the tests that we removed
"TEST_FAILS_SANITIZE_LEAK=true" from in an earlier commit due to
removing the UNLEAK() from cmd_format_patch(), we can now assert that
its API use doesn't leak any "struct rev_info" memory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c                           | 1 +
 t/t4021-format-patch-numbered.sh     | 1 +
 t/t4028-format-patch-mime-headers.sh | 2 ++
 t/t4036-format-patch-signer-mime.sh  | 1 +
 t/t4122-apply-symlink-inside.sh      | 1 +
 t/t4126-apply-empty.sh               | 1 +
 t/t6110-rev-list-sparse.sh           | 1 +
 t/t9001-send-email.sh                | 1 +
 8 files changed, 9 insertions(+)

diff --git a/revision.c b/revision.c
index 290700ea66f..a73e76bed4a 100644
--- a/revision.c
+++ b/revision.c
@@ -2952,6 +2952,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
 	release_revisions_cmdline(&revs->cmdline);
+	object_array_clear(&revs->boundary_commits);
 	clear_pathspec(&revs->prune_data);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 9be65fd4440..1219aa226dc 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -5,6 +5,7 @@
 
 test_description='Format-patch numbering options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4028-format-patch-mime-headers.sh b/t/t4028-format-patch-mime-headers.sh
index 204ba673cb5..60cb819c42e 100755
--- a/t/t4028-format-patch-mime-headers.sh
+++ b/t/t4028-format-patch-mime-headers.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='format-patch mime headers and extra headers do not conflict'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create commit with utf-8 body' '
diff --git a/t/t4036-format-patch-signer-mime.sh b/t/t4036-format-patch-signer-mime.sh
index 98d9713d8b2..48655bcc789 100755
--- a/t/t4036-format-patch-signer-mime.sh
+++ b/t/t4036-format-patch-signer-mime.sh
@@ -2,6 +2,7 @@
 
 test_description='format-patch -s should force MIME encoding as needed'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index aa52de401b9..96965373036 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -4,6 +4,7 @@ test_description='apply to deeper directory without getting fooled with symlink'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 66a7ba8ab8f..ece9fae207d 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -2,6 +2,7 @@
 
 test_description='apply empty'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6110-rev-list-sparse.sh b/t/t6110-rev-list-sparse.sh
index 13c1da53528..ddefc7f24ee 100755
--- a/t/t6110-rev-list-sparse.sh
+++ b/t/t6110-rev-list-sparse.sh
@@ -4,6 +4,7 @@ test_description='operations that cull histories in unusual ways'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 84d0f40d76a..dfa6b20f7a6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -4,6 +4,7 @@ test_description='git send-email'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # May be altered later in the test
-- 
2.35.1.1295.g6b025d3e231

