Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D890320756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdAJUmw (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:42:52 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36000 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbdAJUmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:46 -0500
Received: by mail-qt0-f181.google.com with SMTP id k15so406887656qtg.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JSUmhTxL5OzXjbR+WFAZcAESq2rmOYAq+GbWMOTd4zM=;
        b=U1WfPQz6vT2+kvG08x7nRpxXLLpYfUdZJr1t2Y6ck2MvInU/fPlyRxNUNC7ihn9mUW
         1ibD4CqbNdMNZza7WcPLpMzSyU3o+1i1TmEScRY0ZQpzMzqa0IEJnjoJs5hMWejalZWp
         a4kpKf9HuLpSWz1ZmeTJ96LHBiOs8LxmegIbQrgg0YKA7rtTDc4fKT0XglhJ5Qxz6iTa
         Z8Mf19NEDJrpeh0o/3z/CuhHhe35SjU5jEwHKeac+PoR8mDFOqyXUoTpQoTaj+Oy5ef9
         SOyJyBo4Z+AsPZ/lMPXAcrQmsdJRftwVwaOUkU0d765Zm3IMp+yQSLdqNeI7iYf0kEfn
         VM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JSUmhTxL5OzXjbR+WFAZcAESq2rmOYAq+GbWMOTd4zM=;
        b=lEa5Pq4ec3Z6KU9a/ne+k3k3a90bnODrY3eWSN+5NWiX4tWoNn7U3I8X0+Ub0zPOnF
         qGrHLuWQaTGzMeXKFF0dZti35hQgNyRBnGw0iDZ3vrV/8BUh+UyXfTu6OaIXX60YOrgf
         +0wxoZl8qAWnWo2bek6BeleTbrgvT7A3a6Y8jaXeQKzPL7XD4UE+/iu0trMQ/Vz/W/1T
         AgMp0/t3Ilt7hE9MeCOItDtHa19k0XlLkDWEXW4a3/wRpd+ekLIeYaC+13MMBfBI1y5W
         1kyM4TCB8aesIC9ZaHh9SusnZA1HSh5EP9RihidspPNWuVhNamBC03zdzWD18eTi0P5B
         IVrQ==
X-Gm-Message-State: AIkVDXIuQd14gpvoVlZrWSyQ8qTmXX9a9pYRETFEsFwXwwb/5AfZBKGAA3iLFfm5mJncAjo7
X-Received: by 10.237.61.20 with SMTP id g20mr5080308qtf.272.1484080965622;
        Tue, 10 Jan 2017 12:42:45 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:45 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 09/14] t7610: always work on a test-specific branch
Date:   Tue, 10 Jan 2017 15:41:57 -0500
Message-Id: <20170110204202.21779-10-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create and use a test-specific branch when the test might create a
commit.  This is not always necessary for correctness, but it improves
debuggability by ensuring a commit created by test #N shows up on the
testN branch, not the branch for test #N-1.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 7d5e1df88..efcf5c3f1 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -184,6 +184,7 @@ test_expect_success 'mergetool in subdir' '
 
 test_expect_success 'mergetool on file in parent dir' '
 	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count &&
 	git submodule update -N &&
 	(
 		cd subdir &&
@@ -217,6 +218,7 @@ test_expect_success 'mergetool skips autoresolved' '
 
 test_expect_success 'mergetool merges all from subdir' '
 	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count &&
 	test_config rerere.enabled false &&
 	(
 		cd subdir &&
@@ -288,7 +290,7 @@ test_expect_success 'mergetool takes partial path' '
 
 test_expect_success 'mergetool delete/delete conflict' '
 	test_when_finished "git reset --hard HEAD" &&
-	git checkout move-to-c &&
+	git checkout -b test$test_count move-to-c &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
 	! test -f a/a/file.txt &&
@@ -304,6 +306,7 @@ test_expect_success 'mergetool delete/delete conflict' '
 
 test_expect_success 'mergetool produces no errors when keepBackup is used' '
 	test_when_finished "git reset --hard HEAD" &&
+	git checkout -b test$test_count &&
 	test_config mergetool.keepBackup true &&
 	test_must_fail git merge move-to-b &&
 	: >expect &&
@@ -314,6 +317,7 @@ test_expect_success 'mergetool produces no errors when keepBackup is used' '
 
 test_expect_success 'mergetool honors tempfile config for deleted files' '
 	test_when_finished "git reset --hard HEAD" &&
+	git checkout -b test$test_count &&
 	test_config mergetool.keepTemporaries false &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
@@ -323,6 +327,7 @@ test_expect_success 'mergetool honors tempfile config for deleted files' '
 test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 	test_when_finished "git reset --hard HEAD" &&
 	test_when_finished "git clean -fdx" &&
+	git checkout -b test$test_count &&
 	test_config mergetool.keepTemporaries true &&
 	test_must_fail git merge move-to-b &&
 	! (echo a; echo n) | git mergetool a/a/file.txt &&
@@ -640,7 +645,7 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 
 test_expect_success 'diff.orderFile configuration is honored' '
 	test_when_finished "git reset --hard >/dev/null" &&
-	git checkout order-file-side2 &&
+	git checkout -b test$test_count order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
@@ -658,6 +663,7 @@ test_expect_success 'diff.orderFile configuration is honored' '
 '
 test_expect_success 'mergetool -Oorder-file is honored' '
 	test_when_finished "git reset --hard >/dev/null 2>&1" &&
+	git checkout -b test$test_count &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
-- 
2.11.0.390.gc69c2f50cf-goog

