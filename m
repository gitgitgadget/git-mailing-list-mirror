Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1668420756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbdAJUmv (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:42:51 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33595 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdAJUmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:47 -0500
Received: by mail-qt0-f173.google.com with SMTP id v23so177100857qtb.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VsULfCy+wfvCW+6ac2/4fvs4kCNaElAE9gCkCKMd+EE=;
        b=gPVAHtpnYX0MISRC5l1AvV9i+g8bH1ZF5uOw9bOnezpRygNheRi+CYwmRsW7w81ti6
         8S4oue4fs4j9Fv9r+wMO5/SKelrQmoA12AKkipzuRkVh6GKNqsDVWPjfsGm0RKyg0KoL
         DYftGDd33e+HzNXBGRnZD1fXpKQx/DrPVSmzqEGbpm154uRr+WvlAnyjh4Xbawqadg/G
         bJ4/H+9vf5vPv753LZKp5DQ95O/DrkJIlssCOOff+RRACzdFivio+JWVG/duh0MYI2VS
         JGaRwtaX7iksGjAdUBl6iT50pwOYo42xVsfXTAtKJ8xjy4NICah3TpX5Fbud/Eqt5ZH4
         6t6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsULfCy+wfvCW+6ac2/4fvs4kCNaElAE9gCkCKMd+EE=;
        b=qIK/Q+NFGvaZiG26Bp1t+MGgacivfgUIBhPfj/60HR8pNJFUNFOAZ81s7bodyR4kCG
         Qsq8IXZ7Qnv8NtALpgq3hdDL2NBgHGTK8+QdllhMy2ByXQWiTz87ERlTtpgQyfV1D4e4
         LCOq7TK2ah7RdlyoK+jFLF37BLrgK2sNn9LJ1GifdmMmQOyYIXmHV39MOp7KTWr79FBN
         Yvopnf5IRhkHaHLQTIIL0FPcLNeMkAz48M9dULKGaQ62DbDgZv7ic6mbAn/7zYgtRdk0
         yrQNW8Y+M6BEIAEZJlxq/z1fLxPwTCPg6YEOlUx8xzvG7Vibvv402DXeUe6VNmFXN455
         LVbQ==
X-Gm-Message-State: AIkVDXJdhc90gKmzZKvvZwGRSIicvfHd2QVWmapbCSvoLfxIFvYxxPMoYKVwkdtcNZqZARd7
X-Received: by 10.200.43.115 with SMTP id 48mr5070632qtv.157.1484080966297;
        Tue, 10 Jan 2017 12:42:46 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:45 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 10/14] t7610: don't assume the checked-out commit
Date:   Tue, 10 Jan 2017 15:41:58 -0500
Message-Id: <20170110204202.21779-11-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Always check out the required commit at the beginning of the test so
that a failure in a previous test does not cause the test to work off
of the wrong commit.

This is a step toward making the tests more independent so that if one
test fails it doesn't cause subsequent tests to fail.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index efcf5c3f1..54164a320 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -184,7 +184,7 @@ test_expect_success 'mergetool in subdir' '
 
 test_expect_success 'mergetool on file in parent dir' '
 	test_when_finished "git reset --hard" &&
-	git checkout -b test$test_count &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
 		cd subdir &&
@@ -218,7 +218,7 @@ test_expect_success 'mergetool skips autoresolved' '
 
 test_expect_success 'mergetool merges all from subdir' '
 	test_when_finished "git reset --hard" &&
-	git checkout -b test$test_count &&
+	git checkout -b test$test_count branch1 &&
 	test_config rerere.enabled false &&
 	(
 		cd subdir &&
@@ -306,7 +306,7 @@ test_expect_success 'mergetool delete/delete conflict' '
 
 test_expect_success 'mergetool produces no errors when keepBackup is used' '
 	test_when_finished "git reset --hard HEAD" &&
-	git checkout -b test$test_count &&
+	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepBackup true &&
 	test_must_fail git merge move-to-b &&
 	: >expect &&
@@ -317,7 +317,7 @@ test_expect_success 'mergetool produces no errors when keepBackup is used' '
 
 test_expect_success 'mergetool honors tempfile config for deleted files' '
 	test_when_finished "git reset --hard HEAD" &&
-	git checkout -b test$test_count &&
+	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries false &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
@@ -327,7 +327,7 @@ test_expect_success 'mergetool honors tempfile config for deleted files' '
 test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 	test_when_finished "git reset --hard HEAD" &&
 	test_when_finished "git clean -fdx" &&
-	git checkout -b test$test_count &&
+	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries true &&
 	test_must_fail git merge move-to-b &&
 	! (echo a; echo n) | git mergetool a/a/file.txt &&
@@ -663,7 +663,7 @@ test_expect_success 'diff.orderFile configuration is honored' '
 '
 test_expect_success 'mergetool -Oorder-file is honored' '
 	test_when_finished "git reset --hard >/dev/null 2>&1" &&
-	git checkout -b test$test_count &&
+	git checkout -b test$test_count order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
-- 
2.11.0.390.gc69c2f50cf-goog

