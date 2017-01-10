Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEDD20A93
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbdAJUnO (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:14 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35989 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdAJUmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:45 -0500
Received: by mail-qt0-f174.google.com with SMTP id k15so406887099qtg.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PuP43wLd8Pj3wjWktyDOZI2Yr0WAIS21ejo6rwmKT3c=;
        b=nqHEHOzIt9EYQWroNPHvNm5UC67AbCwJUGLPvisQC4KtqKydUCKcFM92qdSCyW8Hf1
         HcBpPOILVuvlilDWLggY/4LzhqCBViWUQWAKOqvRwkPLDnLIoPiwdywQwb3sVrdCqsAp
         R9ottAOo89L8R07aWHkD2dMIAUWBHLnwzL7nKBhpJyckxaMdAEEY4V/fLfeKK4SIB/Xn
         kYjtZaOCXHziXk7q/3FqruTLjbtUpknY65lyRBe3ukt5qS1d3AIjHRInaOpJAPLd6ED7
         DSHXhSCC0voLq2yqZ8TQ9z43anXderST7/s/C075CtLU7tAAkB5/5AGGmf0NYnA+uazi
         3zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PuP43wLd8Pj3wjWktyDOZI2Yr0WAIS21ejo6rwmKT3c=;
        b=ExRLgG+h5jVzduvV7hqN85JMuNWn01BSvwduAF8PY7fDS68KpX9MV012kLk2EFGD5D
         n5ijzuHsBgVbfy+0azfdfxKhlpAEwBZ35SislS1kSdC/b4dPZJnEEVH0/kQ2/UNU2DgS
         e/dSCZNexgjmMmXA+HJQWi20fWG5mBWkn1EcTyM7H3QYHK9OhIijx7avIvyFrr4SjtS1
         iVPbxnVgI5M9LX3XdAYPwuYgqBMl8QvgOhmLqQ+N1GTcLf65hEk3dKhLO5Bgcgnkr39+
         PNnAXASHxHn+DZ6MaYiQ432inpbmPpmwDlbaHvsRH8oDt9G3gjugySeIgPaBh/PbM5sn
         nZfA==
X-Gm-Message-State: AIkVDXILowJWZhsSqJm6w7CdWPkbt1o7BphfyphJRE0wzTpSQ6wZfogMXV75l/av672dQLAS
X-Received: by 10.200.34.155 with SMTP id f27mr4434115qta.129.1484080964110;
        Tue, 10 Jan 2017 12:42:44 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:43 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 07/14] t7610: run 'git reset --hard' after each test to clean up
Date:   Tue, 10 Jan 2017 15:41:55 -0500
Message-Id: <20170110204202.21779-8-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_when_finished to run 'git reset --hard' after each test so
that the repository is left in a saner state for the next test.

This is a step toward making the tests more independent so that if one
test fails it doesn't cause subsequent tests to fail.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 2d92a2646..55587504e 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -127,6 +127,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'custom mergetool' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
@@ -170,6 +171,7 @@ test_expect_success 'mergetool crlf' '
 '
 
 test_expect_success 'mergetool in subdir' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
@@ -181,6 +183,7 @@ test_expect_success 'mergetool in subdir' '
 '
 
 test_expect_success 'mergetool on file in parent dir' '
+	test_when_finished "git reset --hard" &&
 	git reset --hard &&
 	git submodule update -N &&
 	(
@@ -214,6 +217,7 @@ test_expect_success 'mergetool skips autoresolved' '
 '
 
 test_expect_success 'mergetool merges all from subdir' '
+	test_when_finished "git reset --hard" &&
 	test_config rerere.enabled false &&
 	(
 		cd subdir &&
@@ -244,6 +248,7 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
 '
 
 test_expect_success 'conflicted stash sets up rerere'  '
+	test_when_finished "git reset --hard" &&
 	test_config rerere.enabled true &&
 	git checkout stash1 &&
 	echo "Conflicting stash content" >file11 &&
@@ -403,6 +408,7 @@ test_expect_success 'deleted vs modified submodule' '
 '
 
 test_expect_success 'file vs modified submodule' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
@@ -474,6 +480,7 @@ test_expect_success 'file vs modified submodule' '
 '
 
 test_expect_success 'submodule in subdirectory' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
@@ -535,6 +542,7 @@ test_expect_success 'submodule in subdirectory' '
 '
 
 test_expect_success 'directory vs modified submodule' '
+	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	mv submod submod-movedaside &&
 	git rm --cached submod &&
-- 
2.11.0.390.gc69c2f50cf-goog

